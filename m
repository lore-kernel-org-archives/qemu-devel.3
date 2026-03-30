Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4473103D95A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7D1k-000620-Rm; Mon, 30 Mar 2026 09:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7D1b-000618-6e
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:51:33 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7D1X-0003iv-G6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:51:25 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b982d56dac4so775523666b.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774878679; x=1775483479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Oxm7cC7jbJObT0aDDnlzxcH4bFI8mpGYRNRDy7kxHQ=;
 b=xGK0xemXWXSAKczJPF9Ih49U7meRUFC0ddtK9+bUfhQiruqEgdFHQ6vCjVAkvX5Y3Z
 597flRvik5zTT3eQOTmEfSO6PPor9/VYTBLYB1LJ7VU6akgM9TVWblxMtj4zeHee59Vn
 8UMtn4bCqGtuFuMlKzQKEGgxOyOt5NoPwi+x4qDZq4ws+tueaU82gNPh0OpO6IxarOQT
 F2HXPocqlleBANk84MM6Rj1JFwcXkyTL/hqnZfPdl+7F4MlpgcGV64TOYD5xakzTzw4l
 ysytcMOLSQaX9+n3XXtTqWuFuk12x+neX20mz0I5rsy5q9kyBl0FnAGcjGN5f2u8RNuQ
 DDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774878679; x=1775483479;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Oxm7cC7jbJObT0aDDnlzxcH4bFI8mpGYRNRDy7kxHQ=;
 b=Z38WggOtYjfpaxLvUFv1or1TsPXVLOAB+YpZc/8X94tl/c1E5W5zKL1dYI7Cz2G+68
 xd6JcSAapdWkDIu1sPldLKUqMNh+eQTRZLMt3OXvrxEN38ntagn2YUpghVfaQz+mvpSv
 DFNDAnw6OK1pedRO3TFt2RUQjqB15sh5blsdGItGBdum8xUqWJTF0y3A6xkKDH2v+PUl
 kbw22LtN22k7yttx7Tb8HR4WtXCuE6C5+wk31ZAFD2j/2birro7XWUVUwyWCgKHj/YyY
 ha7PSBJ4xg/Tt47oYQxxHJh/AiBJ7EUC1JXNvkO0Rw5On2930QpvIgkngUGu3WvIUtCD
 fS0A==
X-Gm-Message-State: AOJu0YwuvorkIujKp8hfaiarKvgXUNnulE1f/+IfEi1xVCHn2OCxD+3o
 dsWYUhI0mg5e+6ztZECwfblbIs2QYV2YHW0X6Dr1aRkJ2Y2vxV+vywPYABV9za+RH1k=
X-Gm-Gg: ATEYQzx1y1zzzJU8QXEzSD0s8ve3TaLeVVoktU2GnbPYwQzclP7JIETe8TG5m3YWh6Z
 l482ayt2HkpHQSeRjQeEzly4m36/GFCBN1/173gFuGL8Bim62NLp800OacqxAsGpFSNLf2wNhtL
 vYy2XljASBf5WZwZiBOKWyCLZ6FDnQUnQdPecXgpnjcy6MOTcwd2S37+11H50DP4Lr5TIBq2IyP
 2CFN73Jrz26qK4F9uBijdk3zG1SYpvsH6gv1PPjMOGrCM4o7S/KXBnX+B1klE3TzrBi3iQojBOS
 dXtdIEVlnxLpGKAj8qpEldUCei2/8DJPKoqvASSyRxgyD/WNit5izkT8MbmSF3eKaeUeeyOZwMQ
 WWonEAkP26oLlEWSYkiFHyOl5vvb4DtrmXh2a2sg4qVHI2uUN6KWwX+vG4z4C6Ytq5fiT4CARmZ
 opCvzRNV6eQtiSmbU+b5fttS0=
X-Received: by 2002:a17:907:1b09:b0:b98:4c2a:d503 with SMTP id
 a640c23a62f3a-b9b5090af40mr736197566b.38.1774878678573; 
 Mon, 30 Mar 2026 06:51:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b225d4bsm295789866b.60.2026.03.30.06.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:51:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B0B15F8D7;
 Mon, 30 Mar 2026 14:51:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stepan Popov <Stepan.Popov@kaspersky.com>
Cc: <qemu-devel@nongnu.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] meson: add missing semicolon in
 pthread_condattr_setclock test
In-Reply-To: <20260330131406.87080-1-Stepan.Popov@kaspersky.com> (Stepan
 Popov's message of "Mon, 30 Mar 2026 16:14:06 +0300")
References: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Mon, 30 Mar 2026 14:51:17 +0100
Message-ID: <87pl4lpgru.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stepan Popov <Stepan.Popov@kaspersky.com> writes:

> The test code was missing a semicolon after the pthread_condattr_t
> variable declaration.
>
> Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index d7c4095b39..5447504ea8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2882,7 +2882,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCL=
OCK', cc.links(osdep_prefix +
>=20=20
>    int main(void)
>    {
> -    pthread_condattr_t attr
> +    pthread_condattr_t attr;
>      pthread_condattr_init(&attr);
>      pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
>      return 0;

Good catch:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I guess we've just been silently failing that test since it was
introduced then?

  Cached compiler stderr:
   /home/alex/lsrc/qemu.git/builds/all/meson-private/tmpy5s2fh25/testfile.c=
: In function 'main':
  /home/alex/lsrc/qemu.git/builds/all/meson-private/tmpy5s2fh25/testfile.c:=
23:5: error: expected '=3D', ',', ';', 'asm' or '__attribute__' before 'pth=
read_condattr_init'
     23 |     pthread_condattr_init(&attr);
        |     ^~~~~~~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu.git/builds/all/meson-private/tmpy5s2fh25/testfile.c:=
23:28: error: 'attr' undeclared (first use in this function)
     23 |     pthread_condattr_init(&attr);
        |                            ^~~~
  /home/alex/lsrc/qemu.git/builds/all/meson-private/tmpy5s2fh25/testfile.c:=
23:28: note: each undeclared identifier is reported only once for each func=
tion it appears in

  Using cached compile:
  Cached command line:  cc -m64 /home/alex/lsrc/qemu.git/builds/all/meson-p=
rivate/tmppx1fde_i/testfile.c -o /home/alex/lsrc/qemu.git/builds/all/meson-=
private/tmppx1fde_i/output.exe -pthread -D_FILE_OFFSET_BITS=3D64 -O0 -std=
=3Dgnu11=20

So maybe:

Fixes: 657ac98b58c (thread-posix: use monotonic clock for QemuCond and Qemu=
Semaphore)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

