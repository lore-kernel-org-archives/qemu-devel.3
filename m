Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B355DCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwhEw-0004vp-EA; Thu, 11 Sep 2025 09:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uwhEt-0004uX-SS
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:21:28 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uwhEi-000089-BZ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=chriOzsqxtbtOmSIzS1qwTelP37PkTps5Ws4aL6TY0M=; b=cpqc0YosWL5gt2rxCUb+DZQl7D
 8Ljdyzlu4J/fmW8aUiMlf+XhN9+yRxqaBN+5hf64UkPzhrsJMa4+fWZRNV+MDgvGxar5o06WWgHLw
 p17nLxsV6KeEf91HfsAP6PG16wCFNffBHY9Uo5mpKrnxVFjV9/bU8IcN4xHlblIyFYjLeCjn9dFxD
 kM3VZkSWNqv0O2Y8pNoNbV5IihxvWdA2v3rnHZchU0i8b51t8RkqAm38Kw7q6ntX45Me8WByePz5q
 ZaECbu5DaU1+4hyktpCo9BqVfhB8nii+cO5ZKQZpD8RG0tkBBaMqF/emKAMGnZDFMeYj6FlE7/6vY
 4ppsOJ6HAPNrtSAI8lTtbh9pLy0jMIRa/7deJmW+h9z3ifNrnwMQ4a2JwmNVLB2Ir466fi9p/ARIt
 1juUA5qDjThlTlP5tLVM/QTxwaDDYBp4/BY1KAo5h/AQUUgoAxz+Q1y7fof1QwS0RNCnclcWSrkGH
 neo7tqMqXq16+jaPta7TAwzaGwTmA2h3IgZBgC1d79UosFd7kbfjrhz1qWMB12nj3xEtqKysdbC/A
 vwIJtKQcY6DlgupIFoYDaoQym2GzX52sWLZja10TIHw3b44bd8czND9wEBpzjn4YyDqOL8E6gj6Gu
 gl3ZDdDx0VBWbt2651xjrPDvJ64JfOvBJI7j2I9k8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 05/20] audio: make jackaudio use qemu_thread_set_name
Date: Thu, 11 Sep 2025 15:21:04 +0200
Message-ID: <10718921.crInZIivIp@silver>
In-Reply-To: <20250910180357.320297-6-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wednesday, September 10, 2025 8:03:42 PM CEST Daniel P. Berrang=E9 wrote:
> This has greater portability than directly call pthread_setname_np,
> which is only 1 out of 3 possible functions for pthreads that can
> set the name.
>=20
> The new API requires a trampoline function, since it can only set
> the name of the current thread.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  audio/jackaudio.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 974a3caad3..69dce3f302 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -629,18 +629,36 @@ static void qjack_enable_in(HWVoiceIn *hw, bool
> enable) ji->c.enabled =3D enable;
>  }
>=20
> -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +#if !defined(WIN32)
> +struct QJackThreadData {
> +    void *(*function)(void *);
> +    void *arg;
> +};
> +
> +static void *qjack_thread_trampoline(void *targ)
> +{
> +    struct QJackThreadData *data =3D targ;
> +    void *(*function)(void *) =3D data->function;
> +    void *arg =3D data->arg;
> +
> +    g_free(data);
> +    qemu_thread_set_name("jack-client");
> +
> +    return function(arg);
> +}
> +
>  static int qjack_thread_creator(jack_native_thread_t *thread,
>      const pthread_attr_t *attr, void *(*function)(void *), void *arg)
>  {
> -    int ret =3D pthread_create(thread, attr, function, arg);
> +    struct QJackThreadData *data =3D g_new0(struct QJackThreadData, 1);
> +    data->function =3D function;
> +    data->arg =3D arg;
> +    int ret =3D pthread_create(thread, attr, qjack_thread_trampoline, da=
ta);
>      if (ret !=3D 0) {
> +        g_free(data);
>          return ret;
>      }
>=20
> -    /* set the name of the thread */
> -    pthread_setname_np(*thread, "jack-client");
> -
>      return ret;
>  }
>  #endif
> @@ -696,7 +714,7 @@ static void register_audio_jack(void)
>  {
>      qemu_mutex_init(&qjack_shutdown_lock);
>      audio_driver_register(&jack_driver);
> -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +#if !defined(WIN32)
>      jack_set_thread_creator(qjack_thread_creator);
>  #endif
>      jack_set_error_function(qjack_error);

Well, it does what you said, so:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

I just wonder whether this thread naming code couldn't be much more simplif=
ied
now by dropping jack_set_thread_creator() entirely, which is very seldomly
used at all and had another user case [1]:

"This function can be used in very very specialized cases where it is
necessary that client threads created by JACK are created by something other
than pthread_create(). After it is used, any threads that JACK needs for the
client will will be created by calling the function passed to this function.

No normal application/client should consider calling this. The specific case
for which it was created involves running win32/x86 plugins under Wine on
Linux, where it is necessary that all threads that might call win32 functio=
ns
are known to Wine."

[1] https://jackaudio.org/api/group__ClientThreads.html#ga157ab0ade60e266ff=
d26ddffdb5545af

However there doesn't seem to be a thread creation callback in the JACK API,
so the jack_set_thread_creator() bypass is still the best we can get, right?

/Christian



