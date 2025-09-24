Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A369CAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LIZ-00067t-6n; Wed, 24 Sep 2025 04:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1LIV-00067D-58
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1LIP-0000B0-HG
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758704173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+6HcEeGn4EQXRiWkN65TtZAbP+MJwu9nEgiKy8V93Y=;
 b=NBQDNJ8HGBA0+80DwV+U3WPQBCj8jvzkx+uYF5HjdaBMN9v4vYeQwwk/lJ7CiewIpNNdHr
 5OL8XQeNjRf9hrgZxs5zAyjUAgk5oqyoXR2/TXEoCwM8awhfm2XYjucUA/FT9i89mn+uOY
 lC6CMl/7DuG+Cz2CJTH3sGZ6bUL2/r4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-u9DKIbh3M4imjkZkjJl6Vw-1; Wed,
 24 Sep 2025 04:56:04 -0400
X-MC-Unique: u9DKIbh3M4imjkZkjJl6Vw-1
X-Mimecast-MFC-AGG-ID: u9DKIbh3M4imjkZkjJl6Vw_1758704162
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F06C1956055; Wed, 24 Sep 2025 08:56:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 867011800452; Wed, 24 Sep 2025 08:55:57 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:55:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 07/20] util: add API to fetch the current thread name
Message-ID: <aNOyGfTQ4oYoufCg@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-8-berrange@redhat.com>
 <877bxp9xm5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bxp9xm5.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 23, 2025 at 02:12:02PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This will be used to include the thread name in error reports
> > in a later patch. It returns a const string stored in a thread
> > local to avoid memory allocation when it is called repeatedly
> > in a single thread. This makes the assumption that the thread
> > name is set at the very start of the thread, which is the case
> > when using qemu_thread_create.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> [...]
> 
> > diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> > index 7a734a7a09..e3789c20d1 100644
> > --- a/util/qemu-thread-win32.c
> > +++ b/util/qemu-thread-win32.c
> 
> [...]
> 
> > @@ -412,3 +418,38 @@ bool qemu_thread_is_self(QemuThread *thread)
> >  {
> >      return GetCurrentThreadId() == thread->tid;
> >  }
> > +
> > +static __thread char namebuf[64];
> > +
> > +const char *qemu_thread_get_name(void)
> > +{
> > +    HRESULT hr;
> > +    wchar_t *namew = NULL;
> > +    g_autofree char *name = NULL;
> > +
> > +    if (namebuf[0] != '\0') {
> > +        return namebuf;
> > +    }
> > +
> > +    if (!load_thread_description()) {
> > +        goto error;
> > +    }
> > +
> > +    hr = GetThreadDescriptionFunc(GetCurrentThread(), &namew);
> > +    if (!SUCCEEDED(hr)) {
> > +        goto error;
> > +    }
> > +
> > +    name = g_utf16_to_utf8(namew, -1, NULL, NULL, NULL);
> > +    LocalFree(namew);
> > +    if (!name) {
> > +        goto error;
> > +    }
> > +
> > +    g_strlcpy(namebuf, name, G_N_ELEMENTS(namebuf));
> > +    return namebuf;
> > +
> > + error:
> > +    strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
> > +    return namebuf;
> > +}
> 
> ../util/qemu-thread-win32.c: In function 'qemu_thread_get_name':
> ../util/qemu-thread-win32.c:453:5: error: implicit declaration of function 'strlcpy'; did you mean 'strncpy'? [-Wimplicit-function-declaration]
>   453 |     strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
>       |     ^~~~~~~
>       |     strncpy
> ../util/qemu-thread-win32.c:453:5: error: nested extern declaration of 'strlcpy' [-Werror=nested-externs]

Sigh, I meant g_strlcopy like the line shortly before.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


