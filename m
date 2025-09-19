Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4065CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWej-0005jU-Me; Fri, 19 Sep 2025 04:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzWef-0005hl-6d
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzWec-0002RM-H5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758271180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Pqyqjg0uXiqy4MWiXXlKqP1WmA0uDd46qFg34n2XrA=;
 b=Zp/vl/fmHM1fdzBzJdEGbaNqW/jsXCjfbHl+QejAlwZgE7RXP9p9ZxmQtuQ45vC7mHCVOC
 cS9hM2ajGdF8GaBz+oPen/j/70weYocNBMqGEMad02QWrPiWw8C8aA4h/CDOrij5hMDB4l
 qTV/icGH2Pab/1znQ4U4pkTlEhwuZYY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-7o5JqPBGN0eQ1KyePO1nMA-1; Fri,
 19 Sep 2025 04:39:37 -0400
X-MC-Unique: 7o5JqPBGN0eQ1KyePO1nMA-1
X-Mimecast-MFC-AGG-ID: 7o5JqPBGN0eQ1KyePO1nMA_1758271175
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EC551956050; Fri, 19 Sep 2025 08:39:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3759630002C5; Fri, 19 Sep 2025 08:39:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74F9721E6A27; Fri, 19 Sep 2025 10:39:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 04/20] util: expose qemu_thread_set_name
In-Reply-To: <20250910180357.320297-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:41
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-5-berrange@redhat.com>
Date: Fri, 19 Sep 2025 10:39:31 +0200
Message-ID: <87h5wy6dks.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The ability to set the thread name needs to be used in a number
> of places, so expose the current impls as public methods.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c | 30 ++++++++++++++++++------------
>  util/qemu-thread-win32.c |  6 +++---
>  3 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 3a286bb3ef..27b888ab0a 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -215,6 +215,7 @@ void *qemu_thread_join(QemuThread *thread);
>  void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  G_NORETURN void qemu_thread_exit(void *retval);
> +void qemu_thread_set_name(const char *name);
>=20=20
>  struct Notifier;
>  /**
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 7c985b5d38..ddaa1de4dd 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -329,6 +329,21 @@ static void qemu_thread_atexit_notify(void *arg)
>      notifier_list_notify(&thread_exit, NULL);
>  }
>=20=20
> +void qemu_thread_set_name(const char *name)
> +{
> +    /*
> +     * Attempt to set the threads name; note that this is for debug, so
> +     * we're not going to fail if we can't set it.
> +     */
> +# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +    pthread_setname_np(pthread_self(), name);
> +# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> +    pthread_setname_np(name);
> +# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> +    pthread_set_name_np(pthread_self(), name);
> +# endif
> +}
> +
>  typedef struct {
>      void *(*start_routine)(void *);
>      void *arg;
> @@ -342,20 +357,11 @@ static void *qemu_thread_start(void *args)
>      void *arg =3D qemu_thread_args->arg;
>      void *r;
>=20=20
> -    /* Attempt to set the threads name; note that this is for debug, so
> -     * we're not going to fail if we can't set it.
> -     */
>      if (qemu_thread_args->name) {
> -# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> -        pthread_setname_np(pthread_self(), qemu_thread_args->name);
> -# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> -        pthread_setname_np(qemu_thread_args->name);
> -# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> -        pthread_set_name_np(pthread_self(), qemu_thread_args->name);
> -# endif
> +        qemu_thread_set_name(qemu_thread_args->name);

Clean factoring out up to here.

> +        QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
> +        g_free(qemu_thread_args->name);
>      }
> -    QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
> -    g_free(qemu_thread_args->name);

This part avoids

       QEMU_TSAN_ANNOTATE_THREAD_NAME(NULL);
       g_free(NULL);

The latter is an obvious no-op.  The former isn't.  Separate patch or
mention in the commit message?

>      g_free(qemu_thread_args);
>=20=20
>      /*
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 9595a5b090..62eaa11026 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -316,7 +316,7 @@ void *qemu_thread_join(QemuThread *thread)
>      return ret;
>  }
>=20=20
> -static void set_thread_description(HANDLE h, const char *name)
> +void qemu_thread_set_name(const char *name)
>  {
>      g_autofree wchar_t *namew =3D NULL;
>=20=20
> @@ -329,7 +329,7 @@ static void set_thread_description(HANDLE h, const ch=
ar *name)
>          return;
>      }
>=20=20
> -    SetThreadDescriptionFunc(h, namew);
> +    SetThreadDescriptionFunc(GetCurrentThread(), namew);
>  }
>=20=20
>  void qemu_thread_create(QemuThread *thread, const char *name,
> @@ -356,7 +356,7 @@ void qemu_thread_create(QemuThread *thread, const cha=
r *name,
       hThread =3D (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                         data, 0, &thread->tid);
       if (!hThread) {
>          error_exit(GetLastError(), __func__);
>      }
>      if (name) {
> -        set_thread_description(hThread, name);
> +        qemu_thread_set_name(name);
>      }
>      CloseHandle(hThread);

This changes the first argument of SetThreadDescriptionFunc() from the
value of _beginthreadex() to GetCurrentThread().  I'm a happy Windows
ignoramus...  sure these refer to the same thread?


