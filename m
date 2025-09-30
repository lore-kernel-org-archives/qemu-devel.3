Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0C0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YQQ-0001xf-Ev; Tue, 30 Sep 2025 07:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v3YQN-0001xC-EL
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:21:40 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v3YQB-0004El-Ge
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:21:39 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4dfe74ed2e1so31826141cf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759231282; x=1759836082; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJYgk7BEs4GCmCR/PakLNLSBw0hYmjYtKhcm5yHK+Ss=;
 b=ShZD81ERSotin6CGIDuJavYbaaP8+sBsXLQROFcvtBKnWsb0WQtxYYPOynhVtF/vDf
 Hu0wSD5ps1ztTd8HyF+te3lpbCwCpstN7iac6JLF/5RXS/1L/x0cns3B0eGHLRxgj3Ig
 gbbkR+DvhX+CfprJCoQ3o3mS5FF/r40aGqz6Ybet8kWLNszfnbMfoIr07HCMP47PYEwO
 0pnZojYMaLwEYNp+S4Vxt6QywfU3swJx9Xn2c9V1Nh/OUUyK1ixRri1DSLRprN9br9ER
 sOm3RHaynliu1n99YBOZhF1u64x9oRfsHxuUdhWAL0xW3a90ccrz7o19oRhe1Q00atd3
 T1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759231282; x=1759836082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJYgk7BEs4GCmCR/PakLNLSBw0hYmjYtKhcm5yHK+Ss=;
 b=tPytOIHInUIRayjRnyo2gfvXx5FfUaI1/QHT5obf7IgutznfuEkmKw7dHLtre0FyII
 z6iB3jsVuTiSpNnSI/nXRBW7XuYrELrNFsray2Sr/J8IToWDignWB8A2whrKDZLHR2IW
 oy9JV63vNkEhB9DqaiasDil5iftv54v8fRAvIfFUBLgVC2ccAcoRmU/68ALjMHGGRJ0q
 HaMyT6QU1SIgUmPHVqTFe+RpnIrM4sZC+Jw4PVvS7mIbeYfe/R5tla4GzcgIwXfmYOkU
 VSPbgbZySah64lHAwUD69tj6zsSwHnkqaYt5Kw04t7SJgfwAxurPBnBn1PfI5PHlScqf
 9B6Q==
X-Gm-Message-State: AOJu0YycxA1Wq6pxEHFbJZTGGypiT7ZHXCFG5w4gz0oQOZmh0drwy2NR
 acVRF2UszUaArAi9lLGiEQT4D75xZRY9OBzyDpCFcg+UngdXDZpEWUgdhgBOvWMC7nq2Ac7qAv/
 5UaSkORBLtovm+LYqDZ7PDceXOFX1Cb2wXMTaCpQ=
X-Gm-Gg: ASbGnct8H8Mfab8SeB+tSv0ud0WV2rzclDZwig7fY/mWFn3uDB+bO9PUVNGk3oj/xXn
 QVrNH6N6BYZoCseNUZCvAMWlLw7jc1eNcTbSUGL8yUoqRFxwIluTMNyzUPZzS3PoOHHQs01LjIW
 zMWxxcTLrdqhWBVlltPXGrXwQ9lVbf3aRpWILshIdCEhXz6fw0dIsC9GazjtUrLJxGWleXcSmUf
 M7Z8r6bQ8wli5l1FA6H07geArsjfk+NPSW6ukecN5U3pXiPzI/YzGLYI8etUzeDhWFrd4uUjOI=
X-Google-Smtp-Source: AGHT+IFZizCuDH8ipJcyJuQTXAVhfCVhdykIOT4l7697q+1wtyfPPWr/7Udmm/Ik8GmdLVrJ5bde2JIxIyqXSpLyICU=
X-Received: by 2002:a05:622a:987:b0:4b2:9beb:1986 with SMTP id
 d75a77b69052e-4e11065f7admr81478991cf.82.1759231282174; Tue, 30 Sep 2025
 04:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250930110834.2551757-1-berrange@redhat.com>
 <20250930110834.2551757-2-berrange@redhat.com>
In-Reply-To: <20250930110834.2551757-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Sep 2025 15:21:10 +0400
X-Gm-Features: AS18NWB4c8BkignqnPvRBCEZneZ24xlJpmFj6L8Xn15Qz3OKjdUNYeBlFEXtDHA
Message-ID: <CAJ+F1C+oe-4oYjzaMQ0eF8_8eFiU5mihkaO9eJ=phJ-7JOQ7Aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] io: move websock resource release to close method
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Grant Millar | Cylo" <rid@cylo.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

Hi

On Tue, Sep 30, 2025 at 3:08=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The QIOChannelWebsock object releases all its resources in the
> finalize callback. This is too late, as callers expect to be
> able to call qio_channel_close() to fully close a channel and
> release resources related to I/O. Only releasing the underlying
> QIOChannel transport can be delayed until finalize.
>
> Furthermore the close callback must be robust against being
> called multiple times. Thus when moving the code we now clear
> the GSource ID using  g_clear_handle_id.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  io/channel-websock.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 0a8c5c4712..56d53355d5 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -919,16 +919,7 @@ static void qio_channel_websock_finalize(Object *obj=
)
>  {
>      QIOChannelWebsock *ioc =3D QIO_CHANNEL_WEBSOCK(obj);
>
> -    buffer_free(&ioc->encinput);
> -    buffer_free(&ioc->encoutput);
> -    buffer_free(&ioc->rawinput);
>      object_unref(OBJECT(ioc->master));
> -    if (ioc->io_tag) {
> -        g_source_remove(ioc->io_tag);
> -    }
> -    if (ioc->io_err) {
> -        error_free(ioc->io_err);
> -    }

Maybe finalize should call close() ? Otherwise, it's hard to guarantee
that there is no leak when doing simply init/finish.

>  }
>
>
> @@ -1218,6 +1209,15 @@ static int qio_channel_websock_close(QIOChannel *i=
oc,
>      QIOChannelWebsock *wioc =3D QIO_CHANNEL_WEBSOCK(ioc);
>
>      trace_qio_channel_websock_close(ioc);
> +    buffer_free(&wioc->encinput);
> +    buffer_free(&wioc->encoutput);
> +    buffer_free(&wioc->rawinput);
> +    if (wioc->io_tag) {
> +        g_clear_handle_id(&wioc->io_tag, g_source_remove);
> +    }
> +    if (wioc->io_err) {
> +        g_clear_pointer(&wioc->io_err, error_free);
> +    }
>      return qio_channel_close(wioc->master, errp);
>  }
>

otherwise lgtm

> --
> 2.50.1
>


--=20
Marc-Andr=C3=A9 Lureau

