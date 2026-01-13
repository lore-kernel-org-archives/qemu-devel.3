Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD2AD29DEC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaVj-0003Fn-0C; Tue, 13 Jan 2026 04:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfaVe-0003EK-Ci
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfaVc-0007qL-Pt
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768295775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXNzfc334bOvD2nytUVU8KqMVbWDxOpofDodxjadK2U=;
 b=JbeWBhyLZdcomNlNVnAldSTOFeffZps6H0o6jy2kXwr1U2JMQXosihnNg3fJM6FdEJDY3u
 xQvAoimGyZpUn0/NBbpF6FVs74yZzdiokKOWREHY2BeAWOY8Qmei3CjSozwuFeVN8RE9Ib
 66Q1/NeAXwzAFAMX9hGCVPdMWkAGT/I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-7-w_rji4N-GvZXAXzuhKMg-1; Tue,
 13 Jan 2026 04:16:12 -0500
X-MC-Unique: 7-w_rji4N-GvZXAXzuhKMg-1
X-Mimecast-MFC-AGG-ID: 7-w_rji4N-GvZXAXzuhKMg_1768295771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A74018005AD; Tue, 13 Jan 2026 09:16:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43301180066A; Tue, 13 Jan 2026 09:16:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBA2C21E676C; Tue, 13 Jan 2026 10:16:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  devel@lists.libvirt.org,
 qemu-block@nongnu.org,  qemu-rust@nongnu.org,  Stefan Weil
 <sw@weilnetz.de>,  Kevin Wolf <kwolf@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 05/24] util: expose qemu_thread_set_name
In-Reply-To: <20260108170338.2693853-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:19
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-6-berrange@redhat.com>
Date: Tue, 13 Jan 2026 10:16:06 +0100
Message-ID: <87cy3dc1pl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The ability to set the thread name needs to be used in a number
> of places, so expose the current impls as public methods.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c | 26 ++++++++++++++++----------
>  util/qemu-thread-win32.c | 13 ++++++++-----
>  3 files changed, 25 insertions(+), 15 deletions(-)
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
> index 7c985b5d38..b1c127dbe3 100644
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
> @@ -342,17 +357,8 @@ static void *qemu_thread_start(void *args)
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
>      }
>      QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
>      g_free(qemu_thread_args->name);

qemu_thread_set_name() is factored out.  No change in behavior.

> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 9595a5b090..4d2d663a9a 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -225,6 +225,7 @@ struct QemuThreadData {
>      void             *arg;
>      short             mode;
>      NotifierList      exit;
> +    char             *name;
>=20=20
>      /* Only used for joinable threads. */
>      bool              exited;
> @@ -266,6 +267,10 @@ static unsigned __stdcall win32_start_routine(void *=
arg)
>      void *(*start_routine)(void *) =3D data->start_routine;
>      void *thread_arg =3D data->arg;
>=20=20
> +    if (data->name) {
> +        qemu_thread_set_name(data->name);
> +        g_clear_pointer(&data->name, g_free);
> +    }
>      qemu_thread_data =3D data;
>      qemu_thread_exit(start_routine(thread_arg));
>      abort();
> @@ -316,7 +321,7 @@ void *qemu_thread_join(QemuThread *thread)
>      return ret;
>  }
>=20=20
> -static void set_thread_description(HANDLE h, const char *name)
> +void qemu_thread_set_name(const char *name)
>  {
>      g_autofree wchar_t *namew =3D NULL;
>=20=20
> @@ -329,7 +334,7 @@ static void set_thread_description(HANDLE h, const ch=
ar *name)
>          return;
>      }
>=20=20
> -    SetThreadDescriptionFunc(h, namew);
> +    SetThreadDescriptionFunc(GetCurrentThread(), namew);
>  }
>=20=20
>  void qemu_thread_create(QemuThread *thread, const char *name,
> @@ -344,6 +349,7 @@ void qemu_thread_create(QemuThread *thread, const cha=
r *name,
>      data->arg =3D arg;
>      data->mode =3D mode;
>      data->exited =3D false;
> +    data->name =3D g_strdup(name);
>      notifier_list_init(&data->exit);
>=20=20
>      if (data->mode !=3D QEMU_THREAD_DETACHED) {
> @@ -355,9 +361,6 @@ void qemu_thread_create(QemuThread *thread, const cha=
r *name,
>      if (!hThread) {
>          error_exit(GetLastError(), __func__);
>      }
> -    if (name) {
> -        set_thread_description(hThread, name);
> -    }
>      CloseHandle(hThread);
>=20=20
>      thread->data =3D data;

This delays setting the thread name until the thread runs.  Fine, I
guess, but I'd mention it in the commit message.

The new QemuThreadData member @name is non-null only between thread
creation and thread name setting, unlike the other members under
/* Passed to win32_start_routine.  */  Worth a comment?  Keep it alive
until the thread dies?  Entirely up to you.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


