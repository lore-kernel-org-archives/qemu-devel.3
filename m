Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F5ED1681B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veB2c-0000Zs-HE; Fri, 09 Jan 2026 06:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veB2b-0000XU-88
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:52:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veB2Y-0006CZ-3a
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767959545;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVRgaeKonoKn6lhkHfRgySFdZ4nAAtsJRQcAee3k77M=;
 b=HyqMJ+YN6n9To19Kjx2ypvkFZ9cv+zn++UA2tuOIHKNfmYLtDZKNny0Ws9Zri4SURfnOoV
 Mdspd1rtfWY7cMqE45tXt8R3uRC935cMkk8NQ+ltfmh4LPJPd6Be9c+YBcoAv1oZHc+K40
 CrC6SbYjV8e7EKFr4piG5LzGx1RMb3o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-8nHoPoNjMaa_YoA7kDtE7g-1; Fri,
 09 Jan 2026 06:52:22 -0500
X-MC-Unique: 8nHoPoNjMaa_YoA7kDtE7g-1
X-Mimecast-MFC-AGG-ID: 8nHoPoNjMaa_YoA7kDtE7g_1767959540
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A28A18005A7; Fri,  9 Jan 2026 11:52:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.39])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D030030002D1; Fri,  9 Jan 2026 11:52:12 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:52:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org,
 qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 07/24] util: set the name for the 'main' thread
Message-ID: <aWDr6Fpbp_oDNylt@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-8-berrange@redhat.com>
 <5cbc1f80-aef8-4bcd-beeb-af9c54eea3c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cbc1f80-aef8-4bcd-beeb-af9c54eea3c8@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 09, 2026 at 12:45:03PM +0100, Paolo Bonzini wrote:
> On 1/8/26 18:03, Daniel P. Berrangé wrote:
> > The default main thread name is undefined, so use a constructor to
> > explicitly set it to 'main'. This constructor is marked to run early
> > as the thread name is intended to be used in error reporting / logs
> > which may be triggered very early in QEMU execution.
> 
> At least on Linux I don't think we want to call the pthread function.
> 
> Since pthread_setname_np writes to /proc/self/task/tid/comm, wouldn't that
> cause ps to show qemu processes as "main" instead of "qemu" or "qemu-kvm"?

Hmmm, it depends on the 'ps' options you use:

$ ./build/qemu-system-x86_64  &
[3] 3859009

⚙️ [oci:fedora-43 qemu]$ ps  | grep 3859009
3859009 pts/10   00:00:04 main
⚙️ [oci:fedora-43 qemu]$ ps -a | grep 3859009
3859009 pts/10   00:00:03 main
⚙️ [oci:fedora-43 qemu]$ ps -ax | grep 3859009
3859009 pts/10   Sl     0:03 ./build/qemu-system-x86_64
⚙️ [oci:fedora-43 qemu]$ ps -au | grep 3859009
berrange 3859009  8.6  0.1 3893224 123700 pts/10 Sl   11:49   0:04 ./build/qemu-system-x86_64
⚙️ [oci:fedora-43 qemu]$ ps -af | grep 3859009
berrange 3859009 2085609  8 11:49 pts/10   00:00:04 ./build/qemu-system-x86_64
⚙️ [oci:fedora-43 qemu]$ ps -axuwf | grep 3859009
berrange 3859009 53.4  0.1 3905536 124108 pts/10 Sl   11:49   0:03  |       \_ ./build/qemu-system-x86_64


and I hadn't noticed since I always use one of the latter
sets of options that give the true name.

> 
> Paolo
> 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   util/qemu-thread-posix.c | 6 ++++++
> >   util/qemu-thread-win32.c | 6 ++++++
> >   2 files changed, 12 insertions(+)
> > 
> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index b1c127dbe3..afeac9ecad 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -22,6 +22,12 @@
> >   #include <pthread_np.h>
> >   #endif
> > +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> > +qemu_thread_init(void)
> > +{
> > +    qemu_thread_set_name("main");
> > +}
> > +
> >   static void error_exit(int err, const char *msg)
> >   {
> >       fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
> > diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> > index 4d2d663a9a..8ca6429ad3 100644
> > --- a/util/qemu-thread-win32.c
> > +++ b/util/qemu-thread-win32.c
> > @@ -22,6 +22,12 @@ typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
> >   static pSetThreadDescription SetThreadDescriptionFunc;
> >   static HMODULE kernel32_module;
> > +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> > +qemu_thread_init(void)
> > +{
> > +    qemu_thread_set_name("main");
> > +}
> > +
> >   static bool load_set_thread_description(void)
> >   {
> >       static gsize _init_once = 0;
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


