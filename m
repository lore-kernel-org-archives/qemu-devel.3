Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7090D185C2
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnUg-0003RA-ND; Thu, 08 Jan 2026 05:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdnUc-0003Qs-DU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:43:50 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdnUa-0005CF-Jb
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:43:50 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-88a2d21427dso30849966d6.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767869028; x=1768473828; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvq+1doVaK1AzVvsl5AbNK7unrNAD2j+RT253YHeijM=;
 b=nEAUxyB0RlObbPsLdogk2fI/KlQiaBHanpnn3eW5tAp24XGhArtW8H75iCUZOcIJpa
 x2leBB9IEhAY/o+1e8gkEYCI4+33Wy06H/2tV2tR15Ybcsw0na5irapT0K3Pf9zVgtLh
 stUlO6DzkAgUMha/QUDD4V8CVwK5rLacaRoDRET2LQcB7I5TIWEagBSYq2tvieHcGMEl
 FTxKqQOHBxtXB8dc7w0YRV7Ef0e6P3FqBoc/nW0s/rV018LaixyFuIJ2jm8+lKATN+NI
 KCoLsxBRdtp5fFnVZygD9wa23Ve3TsC8rD5tsQUPs14n7CY9nGrJWbjcX3kNzGq/SoRK
 XNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869028; x=1768473828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tvq+1doVaK1AzVvsl5AbNK7unrNAD2j+RT253YHeijM=;
 b=jpG9uTmcLESAEOD2xWqcLEPaz+GAljbgG8I1+a1leWQlQuSgS5VB6Bd3NKjl6ifQD8
 qff9xvptqICYgOQSO01W7rGJRRK9Wk6QDVPdqETfGj3Ft7M4PPzIdFKTQjZ1U0GdijL/
 G2+/KaddowdySqHdFNNo4tiVG8BZvYAk5Ag7Z3aapQmLPMn6DbmFeG2oZj6iy7TQpkMC
 rGX50cI5TYcx1knxUSowtHll1n+5YkDLdNyeyx3QcAQodILsFkuRzLz8NV7evPGTkaLv
 3PLPv5ttrp4A0MEsGtOMhgHiMLNujCdUWx/7HZUCQL+DwAVK9yoPj5a0xuInWfmkNEF3
 QvXw==
X-Gm-Message-State: AOJu0YwxYXRQoRUgBTTPD/feCdF59bCZcGYAgT9XvIlyioytqd4Lcu76
 FNNaW48SCNZPKUs24x41U3E/kTHkIWQA5G+wQcYl5soi9EmSjeYR1Dp/YPyo2dPQGbKDW75riu9
 6GGnvkQeCgk0OsqV7gfPp/yTtuLsmSbE=
X-Gm-Gg: AY/fxX7cCWmxZecpEzynwK3Ak+FpMm8dJNBxfjzsUCw3boRMjZrDoy6OqXWYOwBCK10
 KrFd8KsiPRMsMbX+MNm+YDi5e3kjBOD18Vb7CcKHDA5pt5L/00inkonBrAL0iP2Qft9LibySX3B
 ocXvp7jDPA5q/qvnFlVTyhCLWSgjIhxQQrR2+U4+XQ+PvUoLWFqVJwOBQZZOEETLl2mz+QZqvWd
 eB1/O+eJzblRF5zBVZ9RofStDDVsWCRGWVT6jpDrbVi+kqaS7Y9iXRzjp90RXYxTZh0UtrRJAkx
 LQRC9ETi7NSpUseEAPstw7PJ9b6vOgveZWQIrw==
X-Google-Smtp-Source: AGHT+IFy0tsK+IJ+E3IpJd0kktlRgHxG/JkL7Ga8WfLHY/u++sA6dFXurUtsItsf4tRf+MmZdaf8j62D1PTx/Khxf3s=
X-Received: by 2002:a05:6214:e6c:b0:882:52fc:9acc with SMTP id
 6a1803df08f44-890842770femr81205676d6.52.1767869027615; Thu, 08 Jan 2026
 02:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20260107153442.1832957-1-berrange@redhat.com>
 <20260107153442.1832957-3-berrange@redhat.com>
In-Reply-To: <20260107153442.1832957-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Jan 2026 14:43:35 +0400
X-Gm-Features: AQt7F2qcwpotJA6wpshf4mUd083qkxuFTtFbQw4CO3MC8AYD_3S_mwaXMAhnJj8
Message-ID: <CAJ+F1C+zQHyyTmf8CKdvZHyJb-tT2wcyP5kUD5xWYvaT706XDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] io: fix cleanup for TLS I/O source data on
 cancellation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, zoudongjie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 7, 2026 at 7:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The TLS code will create a GSource for tracking completion of the
> handshake process, passing a QIOChannelTLSData struct that contains
> various data items. The data struct is freed by the callback when
> it completes, which means when a source is cancelled, nothing is
> free'ing the data struct or its contents.
>
> Switch to provide a data free callback to the GSource, which ensures
> the QIOChannelTLSData struct is always freed even when the main event
> callback never fires.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3114
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  io/channel-tls.c | 64 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
>
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index 07274c12df..8b70e95a4b 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -153,13 +153,32 @@ struct QIOChannelTLSData {
>  };
>  typedef struct QIOChannelTLSData QIOChannelTLSData;
>
> +static void qio_channel_tls_io_data_free(gpointer user_data)
> +{
> +    QIOChannelTLSData *data =3D user_data;
> +    /*
> +     * Usually 'task' will be NULL since the GSource
> +     * callback will either complete the task or pass
> +     * it on to a new GSource. We'll see a non-NULL
> +     * task here only if the GSource was released before
> +     * its callback triggers
> +     */
> +    if (data->task) {
> +        qio_task_free(data->task);
> +    }
> +    if (data->context) {
> +        g_main_context_unref(data->context);
> +    }
> +    g_free(data);
> +}
> +
>  static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
>                                               GIOCondition condition,
>                                               gpointer user_data);
>
> -static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
> -                                           QIOTask *task,
> -                                           GMainContext *context)
> +static gboolean qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
> +                                               QIOTask *task,
> +                                               GMainContext *context)
>  {
>      Error *err =3D NULL;
>      int status;
> @@ -170,8 +189,7 @@ static void qio_channel_tls_handshake_task(QIOChannel=
TLS *ioc,
>          trace_qio_channel_tls_handshake_fail(ioc);
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> -        qio_task_free(task);
> -        return;
> +        return TRUE;
>      }
>
>      if (status =3D=3D QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
> @@ -184,7 +202,7 @@ static void qio_channel_tls_handshake_task(QIOChannel=
TLS *ioc,
>              trace_qio_channel_tls_credentials_allow(ioc);
>          }
>          qio_task_complete(task);
> -        qio_task_free(task);
> +        return TRUE;
>      } else {
>          GIOCondition condition;
>          QIOChannelTLSData *data =3D g_new0(typeof(*data), 1);
> @@ -208,8 +226,9 @@ static void qio_channel_tls_handshake_task(QIOChannel=
TLS *ioc,
>                                         condition,
>                                         qio_channel_tls_handshake_io,
>                                         data,
> -                                       NULL,
> +                                       qio_channel_tls_io_data_free,
>                                         context);
> +        return FALSE;
>      }
>  }
>
> @@ -225,11 +244,9 @@ static gboolean qio_channel_tls_handshake_io(QIOChan=
nel *ioc,
>          qio_task_get_source(task));
>
>      tioc->hs_ioc_tag =3D 0;
> -    g_free(data);
> -    qio_channel_tls_handshake_task(tioc, task, context);
> -
> -    if (context) {
> -        g_main_context_unref(context);
> +    if (!qio_channel_tls_handshake_task(tioc, task, context)) {
> +        /* task is kept by new GSource so must not be released yet */
> +        data->task =3D NULL;
>      }
>
>      return FALSE;
> @@ -258,8 +275,8 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
>  static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition con=
dition,
>                                         gpointer user_data);
>
> -static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
> -                                     GMainContext *context)
> +static gboolean qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *ta=
sk,
> +                                         GMainContext *context)
>  {
>      GIOCondition condition;
>      QIOChannelTLSData *data;
> @@ -272,14 +289,12 @@ static void qio_channel_tls_bye_task(QIOChannelTLS =
*ioc, QIOTask *task,
>          trace_qio_channel_tls_bye_fail(ioc);
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> -        qio_task_free(task);
> -        return;
> +        return TRUE;
>      }
>
>      if (status =3D=3D QCRYPTO_TLS_BYE_COMPLETE) {
>          qio_task_complete(task);
> -        qio_task_free(task);
> -        return;
> +        return TRUE;
>      }
>
>      data =3D g_new0(typeof(*data), 1);
> @@ -299,7 +314,10 @@ static void qio_channel_tls_bye_task(QIOChannelTLS *=
ioc, QIOTask *task,
>      trace_qio_channel_tls_bye_pending(ioc, status);
>      ioc->bye_ioc_tag =3D qio_channel_add_watch_full(ioc->master, conditi=
on,
>                                                    qio_channel_tls_bye_io=
,
> -                                                  data, NULL, context);
> +                                                  data,
> +                                                  qio_channel_tls_io_dat=
a_free,
> +                                                  context);
> +    return FALSE;
>  }
>
>
> @@ -312,11 +330,9 @@ static gboolean qio_channel_tls_bye_io(QIOChannel *i=
oc, GIOCondition condition,
>      QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(qio_task_get_source(task));
>
>      tioc->bye_ioc_tag =3D 0;
> -    g_free(data);
> -    qio_channel_tls_bye_task(tioc, task, context);
> -
> -    if (context) {
> -        g_main_context_unref(context);
> +    if (!qio_channel_tls_bye_task(tioc, task, context)) {
> +        /* task is kept by new GSource so must not be released yet */
> +        data->task =3D NULL;
>      }
>
>      return FALSE;
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

