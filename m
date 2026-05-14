Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A4FCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNYsr-0000wR-7K; Thu, 14 May 2026 12:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNYsp-0000wJ-Gl
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:25:59 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNYso-0002WW-67
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:25:59 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso15280780a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 09:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778775956; cv=none;
 d=google.com; s=arc-20240605;
 b=PX85s6NaF6nY9snvOp21rnbbCaokLpF4ORvC45lDgYMt5/wMFWV4L1GxwlFnOPSGaU
 rKrze3z9EYjh9KBgyOXtZBLQE+j3lhK2clPLZUzu851vnQT0ETihFvVD7qS66nwHRwT9
 hQCH0oHPRZzTwPS8OkJprg5F7BdSw9FfnInN+huhSIJS42s0WiL437tZP/4gPHxtAxvs
 AnkFJpdXrmsEgbjp6k/himt0iWp/zKouPyenngeN3RxXC+mM6SFlTLQ2QDmeEJOhYCn5
 mNohn+RbyvxgIlHXYA+v12Hn0hlum7fNU+uedWvgIr6PnbNuHUbbkd9kQVdqw9CBHvp5
 iOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=17XMi1au2nS65ICBdAefdiAzfp0xQXbHyLNtg/Fg9fY=;
 fh=pMchcd1nOROfpz8BtzUjVKNDz/vdYF6LoDFaisCl9nQ=;
 b=dutw3VTvbegagDG/XZHsuhsXNUHOHNXKMQZxCpy6bVOugxXRwYMiWqtxMbQR4QwvKn
 kxwOq6wl+C3gsT6gy95RUk+nDR4rO7GU6973+b8KBWUAotvSd2ctSd01Om6H14EnYv7e
 t4d7S3vjj+ZimaR2NRnmLXW1K+6YwTgQJQyvtLaV2kNX16Cg+S5mpmCqvpuysW1/MqaJ
 ne+EnoIU+1swUMnY+HpE5ROm1rw4UsvY5Llm82dJ87g6AgFYOGzdZ1PNeRxkq08iPFdm
 KppWqZZ6LzyRn/g5NVavyujw4lSUDY6wYQ+ANm2T1YPuOkUuUgjgqqu5HrxFxnz9hDPQ
 HAoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778775956; x=1779380756; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17XMi1au2nS65ICBdAefdiAzfp0xQXbHyLNtg/Fg9fY=;
 b=OrsTyzN+iu9XrvwALn1hZvYFXWT9gK04f9OrCrRZ4Qi3XIg2IPXcz4IJ1JxYW4rQ2l
 E9Otq5O5N3PvDat78EZVUd3+p88Mh9Nacj1xb6JmrWQ3QOA5noTfSXIboDkh75y3yfjd
 TQs5yJXej7eP1faA+o3xvm4UIU/Ll70tuvZOMGmBS0nUg6BpMwOfLZCeFFCD+s6dXIvg
 9mOVHnL+sIPS+BjWwiNvPa7DP5b2FZ/em/nzGjtTGYtE0R8Jelk0QduM2ynrNuHCibYz
 ogKaHv3vzZ3kEvFL1/5PpS6kfmU2ROmxH/AaRkmpEMxWCY8XWV14+xIX7cGlnT+0e6Y8
 Fu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778775956; x=1779380756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=17XMi1au2nS65ICBdAefdiAzfp0xQXbHyLNtg/Fg9fY=;
 b=F3xpfV/WVnfu2zNjlanqDJbdf1EVA6HEEOzzVO1t3zEetaMT6f3Tu5/pSdAPc/9RQC
 /F6KkAiG7qFYDwJYfZOZc7X22KxNBr3le8pZLcADIU73toMrKeJqW1vCsPMRyr0HkDc/
 9GmlPigc1LbWe7ZUPusslF6jahrIHTUTr24IhWEfXj5aJl66dIF0fbcFhqN+Wd+Dzv1/
 CA1ctKMPVG/5NkYgpsuNM/U0iUmGyRuYiHrdR1uV5vVK52T41eiBN6r9kIeERavp76+c
 6Yxqs6Trv+/Qx82xjS3LWRiRYHIZAZVhT5RjM5wGzYCaZW9mHd2DZ7X9eQdBHx3mUceI
 IG5g==
X-Gm-Message-State: AOJu0Yxqwy6KQLmDuF51+DnAGFZDPoQ8wJENV2ATDsEnkKAUHipuRcEf
 K/tLIsjdUGXubm3bsqv8pohK/DlA3VV8JG5ydusC+U0yIgJbcgl2aJQpRf9lSk+bsPTEwO/zYfX
 PO7Fa+gzR/2S6iBM+n1Fgjlji7ekNG3Y=
X-Gm-Gg: Acq92OE7m2qLXabEUrtlmBq4Rx2owX5UDnaXDrP1gt4hchszlwopf90xQ73hXy3c0E8
 ouhbpIYA4UUqbxMF7jn7iWmOYb6jbSJDWivtCKoYQEuO5N8H4oBn15Uj/OgVs79XN53QRbdw5c9
 T6Zizbu0cPPxhe8whNQ+f185lepldDk49KYlG3nKzsaiwFppbu3QRQcFNpYMnZ9dChvA/6QB1wB
 tQdF+IVHT65mZyVs+KFXRje7Gsd9Jpjwt7kJ3KIJRE5kY9uKtDISHdFyyxV1BPItR9MXG0mNNo/
 akaK86ka+7trOxN0HdY6sOMqtAx1LWoRPbKxUbc25g==
X-Received: by 2002:aa7:c90b:0:b0:670:8b48:182a with SMTP id
 4fb4d7f45d1cf-682557f3d7emr3752283a12.4.1778775956274; Thu, 14 May 2026
 09:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260513082517.1720433-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260513082517.1720433-1-marcandre.lureau@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 14 May 2026 12:25:44 -0400
X-Gm-Features: AVHnY4Kj8yWJYn7Va99F4hdMUJaYpbNvnYKQvviLvoqdxV1m6jNgz_8OuUgzeO0
Message-ID: <CAJSP0QUOf743xw7Lix1WHqJBOo8ZHyU0+L8nv3YtxvwO+EVDQg@mail.gmail.com>
Subject: Re: [PATCH] test/dbus-vnc-test: skip it for now
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, May 13, 2026 at 4:26=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> For some reason, the VNC auth setup sometime fails in CI.
> Disable until it is figured out.
>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/dbus-vnc-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks!

Stefan

> diff --git a/tests/qtest/dbus-vnc-test.c b/tests/qtest/dbus-vnc-test.c
> index 2a1bf67b9d7..8953a4b6265 100644
> --- a/tests/qtest/dbus-vnc-test.c
> +++ b/tests/qtest/dbus-vnc-test.c
> @@ -1309,6 +1309,16 @@ main(int argc, char **argv)
>  {
>      g_log_set_always_fatal(G_LOG_LEVEL_WARNING | G_LOG_LEVEL_CRITICAL);
>
> +    /*
> +     * Flaky test:
> +     * ERROR:../tests/qtest/dbus-vnc-test.c:621:test_dbus_vnc_password_a=
uth:
> +     * assertion failed (qemu_vnc1_server_get_auth(proxy) =3D=3D "vnc"):=
 ("none" =3D=3D
> +     * "vnc")
> +     */
> +    if (!getenv("QEMU_TEST_FLAKY_TESTS")) {
> +        g_test_skip("QEMU_TEST_FLAKY_TESTS not set");
> +        return 0;
> +    }
>      if (getenv("GTK_VNC_DEBUG")) {
>          vnc_util_set_debug(true);
>      }
> --
> 2.54.0
>
>

