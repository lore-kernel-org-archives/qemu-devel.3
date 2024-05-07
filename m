Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F2DC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GdH-0004GM-3h; Tue, 07 May 2024 04:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4GdF-0004G7-QB
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4GdE-00041J-1I
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715072222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEf/ykASi6GsgFSKNRIigV0ACFvxIVVQwg5gSD395+g=;
 b=BzDuPgNqW/Gg2zKm0s+8wdokV3hwAScNsImWecCIQBEnr0zQYL/WagF3HKRPQNgBD8S0Kn
 PhIbEYRkel204OpNoZ1vDm7zNrl7DfZ/uiUp5EhM6LvqN8SaCuqUQvNx9GrP30LeESmOZy
 bbCVruzA28JF+oSuATtOvH9vBXsr1e4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-xY8d-1XINgWciHf5GoW9eA-1; Tue,
 07 May 2024 04:56:59 -0400
X-MC-Unique: xY8d-1XINgWciHf5GoW9eA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74B8E3800BA2;
 Tue,  7 May 2024 08:56:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF13B40C6CB6;
 Tue,  7 May 2024 08:56:56 +0000 (UTC)
Date: Tue, 7 May 2024 09:56:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V1 01/26] oslib: qemu_clear_cloexec
Message-ID: <Zjns1qd57E86lAGy@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-2-git-send-email-steven.sistare@oracle.com>
 <875xvqmsh8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xvqmsh8.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 06, 2024 at 08:27:15PM -0300, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
> +cc dgilbert, marcandre
> 
> > Define qemu_clear_cloexec, analogous to qemu_set_cloexec.
> >
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> A v1 patch with two reviews already, from people from another company
> and they're not in CC. Looks suspicious. =)

It is ok in this case - the cpr work has been going on a long
time and the original series that got partial reviews has been
split up somewhat. So its "v1" of this series of patches, but
not "v1" of what we've seen posted on qemu-devel in the past

> 
> Here's a fresh one, hopefully it won't spend another 4 years in the
> drawer:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> > ---
> >  include/qemu/osdep.h | 9 +++++++++
> >  util/oslib-posix.c   | 9 +++++++++
> >  util/oslib-win32.c   | 4 ++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index c7053cd..b58f312 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -660,6 +660,15 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
> >  
> >  void qemu_set_cloexec(int fd);
> >  
> > +/*
> > + * Clear FD_CLOEXEC for a descriptor.
> > + *
> > + * The caller must guarantee that no other fork+exec's occur before the
> > + * exec that is intended to inherit this descriptor, eg by suspending CPUs
> > + * and blocking monitor commands.
> > + */
> > +void qemu_clear_cloexec(int fd);
> > +
> >  /* Return a dynamically allocated directory path that is appropriate for storing
> >   * local state.
> >   *
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index e764416..614c3e5 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -272,6 +272,15 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
> >      return ret;
> >  }
> >  
> > +void qemu_clear_cloexec(int fd)
> > +{
> > +    int f;
> > +    f = fcntl(fd, F_GETFD);
> > +    assert(f != -1);
> > +    f = fcntl(fd, F_SETFD, f & ~FD_CLOEXEC);
> > +    assert(f != -1);
> > +}
> > +
> >  char *
> >  qemu_get_local_state_dir(void)
> >  {
> > diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> > index b623830..c3e969a 100644
> > --- a/util/oslib-win32.c
> > +++ b/util/oslib-win32.c
> > @@ -222,6 +222,10 @@ void qemu_set_cloexec(int fd)
> >  {
> >  }
> >  
> > +void qemu_clear_cloexec(int fd)
> > +{
> > +}
> > +
> >  int qemu_get_thread_id(void)
> >  {
> >      return GetCurrentThreadId();
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


