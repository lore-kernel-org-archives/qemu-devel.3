Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AC6CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 11:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upPrp-0007Xx-83; Fri, 22 Aug 2025 07:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1upPrn-0007Xc-Tq
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 07:23:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1upPrU-0002TY-Sr
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 07:23:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b065d58so16392735e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755861789; x=1756466589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwRlfdLD1ctMdmZ8QEZ6byp8xwlw+tmby5Yo44DY6Kc=;
 b=wjDXtgRbVMdMANf8XByoIfOv3LUUYTkTJulJET+J1WXABGKZ4W1KBGIfX9o2ijBgrc
 oM0u93yQ7fuoQ4rTz6p8ZahowrcwJ+DzIZtZX1nBo8SU8IMqqPShMP0litNSskUqwcYV
 1nGnGMnUT99GXLNZERyye4yAke4K58QAI/xwo7ZjE0vtygVfmBmxClRW3f2nCkpfZJBB
 rG9VTqltnzomT5B3UI1NwtU7iGeQJ0bg3NIcAolaN4FYiYkJqHvFjYs+nvm3joUpdJLr
 I+1Ty+sOy3Ir6x9XCdVL33cV0RqSd5r7j8vBcNoEE9cB3yMRBcamXXhWvcBZbSRJzje1
 Ykug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755861789; x=1756466589;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XwRlfdLD1ctMdmZ8QEZ6byp8xwlw+tmby5Yo44DY6Kc=;
 b=eEHAIQ+kNpAF5S+GkcN2C/9fyVB/zeU3a8xIWPhrkzWsoGaKBAggFoIxkUVE19VQoF
 kxnW3lDlkIDFqlOUMXxrd8WqilutTvZxdeQX/KtOZdA1EbTbt497+vkby/zgggY/RG1W
 frosv7lGqT1UImeHRZdK6K3RDPc/Yi8/mApyNwy1HmM9/KOseRjeTwErE7yQ17NFLCq/
 4jwABvOoJcvQ5/Xejr792ZhCmzLVIUNv3fxMk/mErwsGIyGYFJnzuS4G3opxbtx3KGaY
 ytkolIGYWTaf4Bgk/TYhPlNLUpMHz+Y9R5PuYTI16iv/UhwtI3lbaVpNz5LO7zDuZuLD
 dwVQ==
X-Gm-Message-State: AOJu0YyB+o7wtZHHpJ4qWmdyAhSwlq6m6P29zRmHhoyMeWK26x40ippH
 N2Pc946/c0dRR7sor2tLhfvI552W+YcDFNss3JQf80q6VEraYPw/Mb6fafe+h0n1RgM=
X-Gm-Gg: ASbGnctHGCodq7+GmRRqCJUxj2wpKjskKK8x0Kz6GvzknHIzoT1OR4And8Lqm6gxyWT
 QBRc/YhcGBZclGGXq1LrkoT2ZCRcSpOaathssHX5tpNvloMe75uEzk1yeLD3xbxz5N9+c2ywSdB
 RqVOeI695xJkG2dm5udO0v62LkIgHqSvxRMqBYro5NI8iEX9De+04uU2+vLkSh0vZPaGlnA+yo3
 R6ip4Z5XoQqfqwxtKAzRIup2eirWxA0CpR+EkKoRvr64lhsQMhBsJO+x2L07y7PWv3X0t0TZYtm
 Yxi7KakPRjUyC83h/iOqhXiSqX9IjFIxBIZEtaiwmsopUJ9aFPUlwjGJaM64kW7rJj9TkTZffa8
 mG8gXPNdGfHZ6Pf5aUN1yf13HLXLUlAFupw==
X-Google-Smtp-Source: AGHT+IG+X+ikCXu60VC9gxR5UnC9GcQsnuOvheUINrmPICDFlB9pxjHa9gNEctUVI3ch8d7sacH/Fg==
X-Received: by 2002:a05:600c:3594:b0:459:f90e:4f5a with SMTP id
 5b1f17b1804b1-45b5179ebbdmr19644045e9.15.1755861788940; 
 Fri, 22 Aug 2025 04:23:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50dcea8esm34980225e9.8.2025.08.22.04.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 04:23:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2D8975F810;
 Fri, 22 Aug 2025 12:23:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Aleksandar Rikalo <arikalo@gmail.com>,  Riku
 Voipio <riku.voipio@iki.fi>,  Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Huacai Chen
 <chenhuacai@kernel.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/5] docker: Remove 32-bit MIPS toolchain from
 debian-all-test image
In-Reply-To: <20250820142108.46639-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 20 Aug 2025 16:21:04
 +0200")
References: <20250820142108.46639-1-philmd@linaro.org>
 <20250820142108.46639-2-philmd@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 12:23:07 +0100
Message-ID: <87ect3k3c4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> In commit d3322023bfe ("configure: unify again the case arms in
> probe_target_compiler") we lost coverage of 32-bit MIPS with the
> debian-all-test image. No need to keep installing the toolchain.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/test=
s/docker/dockerfiles/debian-all-test-cross.docker
> index 420a4e33e60..bc74d65a634 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -40,14 +40,10 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>          libc6-dev-arm64-cross \
>          gcc-arm-linux-gnueabihf \
>          libc6-dev-armhf-cross \
> -        gcc-mips-linux-gnu \
> -        libc6-dev-mips-cross \
>          gcc-mips64-linux-gnuabi64 \
>          libc6-dev-mips64-cross \
>          gcc-mips64el-linux-gnuabi64 \
>          libc6-dev-mips64el-cross \
> -        gcc-mipsel-linux-gnu \
> -        libc6-dev-mipsel-cross \
>          gcc-powerpc64le-linux-gnu \
>          libc6-dev-ppc64el-cross \
>          gcc-riscv64-linux-gnu \

You also need to remove the references in configure:

      hppa|m68k|mips|riscv64|sparc64)
        container_image=3Ddebian-all-test-cross
        ;;
      mips64)
        container_image=3Ddebian-all-test-cross
        container_cross_prefix=3Dmips64-linux-gnuabi64-
        ;;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

