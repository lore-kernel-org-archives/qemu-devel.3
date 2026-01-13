Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DECAD0C84A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbqV-0006LE-Vw; Tue, 13 Jan 2026 05:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfbqT-0006Kl-8u
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:41:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfbqR-0004FB-6D
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768300910;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypVwbn+5ODH+qHpboGY8/sLTBhGQ8D1kvL2o97sCsa8=;
 b=SLQ0NbViouvJ4njdCBxpik3WQsu8QQz0tuMaaHxZqnarJJfld5g6aFH10X/pTxgNKWgKL9
 JNrP45BdUCAYwoFqdj+3hsTpWgnsBThgrJuihoqOi+aho1k5ml5tzSoM6sPTEcg3ASN5AA
 ugGaqf437+z31p8noA3qMIRwe6iUE7I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-Fa9gEokYMgu3aEmL3ZHdiw-1; Tue,
 13 Jan 2026 05:41:48 -0500
X-MC-Unique: Fa9gEokYMgu3aEmL3ZHdiw-1
X-Mimecast-MFC-AGG-ID: Fa9gEokYMgu3aEmL3ZHdiw_1768300904
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44ABE1955D42; Tue, 13 Jan 2026 10:41:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEF4419560AB; Tue, 13 Jan 2026 10:41:38 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:41:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org,
 qemu-rust@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 05/24] util: expose qemu_thread_set_name
Message-ID: <aWYhX_B2Lvqeaf-H@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-6-berrange@redhat.com>
 <87cy3dc1pl.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cy3dc1pl.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Jan 13, 2026 at 10:16:06AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The ability to set the thread name needs to be used in a number
> > of places, so expose the current impls as public methods.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/qemu/thread.h    |  1 +
> >  util/qemu-thread-posix.c | 26 ++++++++++++++++----------
> >  util/qemu-thread-win32.c | 13 ++++++++-----
> >  3 files changed, 25 insertions(+), 15 deletions(-)
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
> > index 7c985b5d38..b1c127dbe3 100644
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
> > @@ -342,17 +357,8 @@ static void *qemu_thread_start(void *args)
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
> >      }
> >      QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
> >      g_free(qemu_thread_args->name);
> 
> qemu_thread_set_name() is factored out.  No change in behavior.
> 
> > diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> > index 9595a5b090..4d2d663a9a 100644
> > --- a/util/qemu-thread-win32.c
> > +++ b/util/qemu-thread-win32.c
> > @@ -225,6 +225,7 @@ struct QemuThreadData {
> >      void             *arg;
> >      short             mode;
> >      NotifierList      exit;
> > +    char             *name;
> >  
> >      /* Only used for joinable threads. */
> >      bool              exited;
> > @@ -266,6 +267,10 @@ static unsigned __stdcall win32_start_routine(void *arg)
> >      void *(*start_routine)(void *) = data->start_routine;
> >      void *thread_arg = data->arg;
> >  
> > +    if (data->name) {
> > +        qemu_thread_set_name(data->name);
> > +        g_clear_pointer(&data->name, g_free);
> > +    }
> >      qemu_thread_data = data;
> >      qemu_thread_exit(start_routine(thread_arg));
> >      abort();
> > @@ -316,7 +321,7 @@ void *qemu_thread_join(QemuThread *thread)
> >      return ret;
> >  }
> >  
> > -static void set_thread_description(HANDLE h, const char *name)
> > +void qemu_thread_set_name(const char *name)
> >  {
> >      g_autofree wchar_t *namew = NULL;
> >  
> > @@ -329,7 +334,7 @@ static void set_thread_description(HANDLE h, const char *name)
> >          return;
> >      }
> >  
> > -    SetThreadDescriptionFunc(h, namew);
> > +    SetThreadDescriptionFunc(GetCurrentThread(), namew);
> >  }
> >  
> >  void qemu_thread_create(QemuThread *thread, const char *name,
> > @@ -344,6 +349,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
> >      data->arg = arg;
> >      data->mode = mode;
> >      data->exited = false;
> > +    data->name = g_strdup(name);
> >      notifier_list_init(&data->exit);
> >  
> >      if (data->mode != QEMU_THREAD_DETACHED) {
> > @@ -355,9 +361,6 @@ void qemu_thread_create(QemuThread *thread, const char *name,
> >      if (!hThread) {
> >          error_exit(GetLastError(), __func__);
> >      }
> > -    if (name) {
> > -        set_thread_description(hThread, name);
> > -    }
> >      CloseHandle(hThread);
> >  
> >      thread->data = data;
> 
> This delays setting the thread name until the thread runs.  Fine, I
> guess, but I'd mention it in the commit message.
> 
> The new QemuThreadData member @name is non-null only between thread
> creation and thread name setting, unlike the other members under
> /* Passed to win32_start_routine.  */  Worth a comment?  Keep it alive
> until the thread dies?  Entirely up to you.

win32_start_routine never returns as it calls into qemu_thread_exit
so it is simpler to just free immediately after use. I'll comment
the struct.

> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


