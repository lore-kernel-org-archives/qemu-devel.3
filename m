Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287F7CAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1L0S-0000Hi-AO; Wed, 24 Sep 2025 04:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1L0M-0000H1-11
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1L0H-00065C-AV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758703048;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ul5UXQY/61DYy/DYZGSV4NbvFog8odkmuETdWvV0E8=;
 b=WaHvelQouwJNcfJemUlbG+4q9F9owZScH0TyE8mdr/uJh1+aAyTMo/7g+odsyyNAw0QFvJ
 Cm6wfBGjeDZjKSeKdfG+q5kN8u5VMs+EM26aLBzlFX/GJuHm/gJVCDTsfxm/jpNMmGf+3v
 ada9ujGjlylyilCqcY2RGzzdWC28Leg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-NF0YDD7rMvGJO6lUveeKWg-1; Wed,
 24 Sep 2025 04:37:25 -0400
X-MC-Unique: NF0YDD7rMvGJO6lUveeKWg-1
X-Mimecast-MFC-AGG-ID: NF0YDD7rMvGJO6lUveeKWg_1758703044
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 276DD19560B2; Wed, 24 Sep 2025 08:37:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ED481800451; Wed, 24 Sep 2025 08:37:15 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:37:12 +0100
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
Subject: Re: [PATCH v3 04/20] util: expose qemu_thread_set_name
Message-ID: <aNOtpOSXDj56owPa@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-5-berrange@redhat.com>
 <87h5wy6dks.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5wy6dks.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 10:39:31AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The ability to set the thread name needs to be used in a number
> > of places, so expose the current impls as public methods.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/qemu/thread.h    |  1 +
> >  util/qemu-thread-posix.c | 30 ++++++++++++++++++------------
> >  util/qemu-thread-win32.c |  6 +++---
> >  3 files changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> > index 3a286bb3ef..27b888ab0a 100644
> > --- a/include/qemu/thread.h
> > +++ b/include/qemu/thread.h
> > @@ -215,6 +215,7 @@ void *qemu_thread_join(QemuThread *thread);
> >  void qemu_thread_get_self(QemuThread *thread);
> >  bool qemu_thread_is_self(QemuThread *thread);
> >  G_NORETURN void qemu_thread_exit(void *retval);
> > +void qemu_thread_set_name(const char *name);
> >  
> >  struct Notifier;
> >  /**
> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index 7c985b5d38..ddaa1de4dd 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -329,6 +329,21 @@ static void qemu_thread_atexit_notify(void *arg)
> >      notifier_list_notify(&thread_exit, NULL);
> >  }
> >  
> > +void qemu_thread_set_name(const char *name)
> > +{
> > +    /*
> > +     * Attempt to set the threads name; note that this is for debug, so
> > +     * we're not going to fail if we can't set it.
> > +     */
> > +# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> > +    pthread_setname_np(pthread_self(), name);
> > +# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> > +    pthread_setname_np(name);
> > +# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> > +    pthread_set_name_np(pthread_self(), name);
> > +# endif
> > +}
> > +
> >  typedef struct {
> >      void *(*start_routine)(void *);
> >      void *arg;
> > @@ -342,20 +357,11 @@ static void *qemu_thread_start(void *args)
> >      void *arg = qemu_thread_args->arg;
> >      void *r;
> >  
> > -    /* Attempt to set the threads name; note that this is for debug, so
> > -     * we're not going to fail if we can't set it.
> > -     */
> >      if (qemu_thread_args->name) {
> > -# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> > -        pthread_setname_np(pthread_self(), qemu_thread_args->name);
> > -# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> > -        pthread_setname_np(qemu_thread_args->name);
> > -# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> > -        pthread_set_name_np(pthread_self(), qemu_thread_args->name);
> > -# endif
> > +        qemu_thread_set_name(qemu_thread_args->name);
> 
> Clean factoring out up to here.
> 
> > +        QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
> > +        g_free(qemu_thread_args->name);
> >      }
> > -    QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
> > -    g_free(qemu_thread_args->name);
> 
> This part avoids
> 
>        QEMU_TSAN_ANNOTATE_THREAD_NAME(NULL);
>        g_free(NULL);
> 
> The latter is an obvious no-op.  The former isn't.  Separate patch or
> mention in the commit message?

I'll just drop this since it isn't needed by the patch

> 
> >      g_free(qemu_thread_args);
> >  
> >      /*
> > diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> > index 9595a5b090..62eaa11026 100644
> > --- a/util/qemu-thread-win32.c
> > +++ b/util/qemu-thread-win32.c
> > @@ -316,7 +316,7 @@ void *qemu_thread_join(QemuThread *thread)
> >      return ret;
> >  }
> >  
> > -static void set_thread_description(HANDLE h, const char *name)
> > +void qemu_thread_set_name(const char *name)
> >  {
> >      g_autofree wchar_t *namew = NULL;
> >  
> > @@ -329,7 +329,7 @@ static void set_thread_description(HANDLE h, const char *name)
> >          return;
> >      }
> >  
> > -    SetThreadDescriptionFunc(h, namew);
> > +    SetThreadDescriptionFunc(GetCurrentThread(), namew);
> >  }
> >  
> >  void qemu_thread_create(QemuThread *thread, const char *name,
> > @@ -356,7 +356,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>        hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
>                                          data, 0, &thread->tid);
>        if (!hThread) {
> >          error_exit(GetLastError(), __func__);
> >      }
> >      if (name) {
> > -        set_thread_description(hThread, name);
> > +        qemu_thread_set_name(name);
> >      }
> >      CloseHandle(hThread);
> 
> This changes the first argument of SetThreadDescriptionFunc() from the
> value of _beginthreadex() to GetCurrentThread().  I'm a happy Windows
> ignoramus...  sure these refer to the same thread?

No, I messed up here. I should have moved the qemu_thread_set_name call
into the thread function, as this is still the parent thread.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


