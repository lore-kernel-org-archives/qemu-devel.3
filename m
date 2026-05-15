Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA5CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtMO-0005tU-Nq; Fri, 15 May 2026 10:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtLj-0005hn-5X
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:17:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtLf-0005up-O1
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:17:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so8474910f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854626; cv=none;
 d=google.com; s=arc-20240605;
 b=ctdHneQItW1f/IM19auxtCjRNhhHd5Y9xUDcZQ6J3Ip4dgTpQ5LBL0MwrbmvCqhbgA
 Tg5smJw4S28ift8yRpNT+Qj8ykuUmrLC4a6m3f2usq37xNBBJ68GrjaM69a9MwLPx8eH
 CMViuNCW8f/2bAmiFqBbthOirywdT72kcJ51R95zDIPP9RUl/qqgFWniHz2myNw/0zfs
 yRBf8ZSZbrRWurrYEWiRM68d8XO3mNAu05Wu4RDh3fBuv0MeI55IqWdP9ivdv+BQwKvE
 B19GVngRcyvge6GzZocrEzZUgVyV2cdnhkjRsjYyVQJqFVhutDSonW9hYEUaMZRe2hEm
 hBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UOp7CuZHjDBgJG2J8FccCnQW2jyNecZ9QuOydA4HVmY=;
 fh=XU+e7/sdy3BdKRahytsg4BqM2g/A0Q0Ptwqap2eda14=;
 b=TXlG5BBqW3uyNIGLjGfaYGXypiEV77cvum7NTBUhb9pVr1sRSytcwV1vzekeburFD2
 Y8xdphRj/znRHNFL3VLOeY+ZzTJsYhOS7o8Te1l6TP6sQlNGEHSQcutLyqrtJRRNvp5M
 5dIJ29tBA2O4wi4ZYZ1GOWhJp7l0MUmMIcCqqfUN455qGBDblrKdZztnEEmfnFkOLytV
 zpUfrCdeKciGqtEU2O8mLPDubmfhOegFFXJjziDWhI1NF0wVN11BPfT7BLS0y/aR9zJF
 u0iagpfQyRaz83RiFqk4T1D2YveW4fCDU27NeGe9ctUyxKZi650XsufBDuDm2VZDeH2E
 zt6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854626; x=1779459426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOp7CuZHjDBgJG2J8FccCnQW2jyNecZ9QuOydA4HVmY=;
 b=iX3Kh9XDBpw3AisSu5SQW//6JSkvi3qo9n3P0g7TWet0iuVGIaxOOwviUOtMGVkHRq
 XbiuKiSLAqV12O92rER3s6Y03tMnBhzYHVvkkDs8PNMn3AguiozabrCuEdjEhi+mdnWO
 5cG7JjjxQUoDA+ADyRustZBSxeH5Xqp+hcvr8npHuaq1ww8bE10T6JV5wq1fB/9StFN7
 8p63C+t3xXBfrQzgLbK2fm/rjqC61KwTps5/bskk1mRjauk7mi2AmjOyeQ59TjAcZy+Q
 jLzUBqiNWRebTb83AymE39WD93jWLRnNqY/vwyMsXs64n46geVTkQzfJcrEnWIcRlc1g
 Hh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854626; x=1779459426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UOp7CuZHjDBgJG2J8FccCnQW2jyNecZ9QuOydA4HVmY=;
 b=AjSAFcVJIF2S9jLKeXh3I4YGd53p1peXur2OOw+uODvMZGnMgot7baKTAUMskhDKMw
 eh5rMfGq+pBBhFnXXdbayEIIQcjgzIevkvfjtMQKGBP+k7WDVt+5cwyajwBdNHAO1p3+
 UQ7CdvvOhNSCHMQMVi/0A0GFtUxzYcYo0pPhfAClQs7tVV+nvDox3cHGO7flZkDy5EYw
 BuZYt1botCRjgT5/HCeClONQe0AayT9lXqECj0qCydDeD5BOU95KRq4wNhjJLP8rqVzX
 qdTPp2m1hxvCTZK2QLBsR4f4YJb/LpzV3Wv2CaS+tjDweA3f7QlwZ7Mto6EmJ+ioijLj
 ggSg==
X-Gm-Message-State: AOJu0YwilGrG2f4M7u4/3Ah3bMZeb/QQrwIP7xV81EnYNT0NzujK96EE
 NiaBulCiZCSrWUGYi/O2UQj2DFlsueroXjPbkvXKYnfU5ovDwneiLjACFzDpen2Jl4yVtOYKu7j
 ib9zS4wd0P0eBRyiKqP4kJx13mtTU1kQPtuSU3Ty0Cg==
X-Gm-Gg: Acq92OH6blXRsrYFFAoD5mAiN5v6KfUUJxbyN3wYaXFv80IvZ9UM218O1UiIQlNElQy
 EBlJfu/mXXJLgTAAWYLVeLNx45Q5AHvYuSlH/M2CesQg7xM8ygtixIOfSaXGYqcjcvjKC1VDeRk
 LKsUYqpQcMq0o6/iuPPfKF4Cp9e5tWI5WKklOxfNpfi6K/gS5alUWLg77Uc7siIqki9MVcEoMPe
 fbz5fiSVb04TFR8rX80cYA64uA9tLFscNKbH6DkGLnxZbItrqIOjLRiQqIL5tenW76cJJkn0EY0
 v/vsgtmVvLh0Zo2L7rn8o6isQc9U+G4LjIXr8I48NnjcTp3Ui+XYMlQws2Fa
X-Received: by 2002:a05:6000:40cc:b0:45a:c0e1:37b with SMTP id
 ffacd0b85a97d-45e5c5ccf6fmr5712567f8f.32.1778854625194; Fri, 15 May 2026
 07:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-6-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:16:37 +0300
X-Gm-Features: AVHnY4KxSKUANBiquY_aKqvXRjKg-JAV7XS5ZlBr3-ELxGtFvx2RvUeU8DBnbfY
Message-ID: <CAAjaMXZ=iK68KAkPc2voqkZ1eqAsuaAdqvrMh=kjWWMiP9f-aQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/20] hw/arm/aspeed: Build objects once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

On Fri, May 15, 2026 at 5:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Commit 064f1ce95fe ("hw/arm/aspeed: Split AST2700 EVB
> machine into a separate source file for maintainability")
> remove the last TARGET_AARCH64 use.
>
> Now than Aspeed machines can be filtered when running a
> qemu-system-arm or qemu-system-aarch64 binary, we can
> compile the aspeed.c file once, moving it from arm_ss[]
> source set to arm_common_ss[].
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/arm/meson.build | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 144e4827660..7c3d66f4378 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: =
files('xlnx-versal.c', 'x
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c'=
, 'imx25_pdk.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c'=
, 'kzm.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
> -arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
> +arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>    'aspeed.c',
>    'aspeed_soc_common.c',
>    'aspeed_ast2400.c',
> @@ -66,8 +66,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>    'aspeed_ast2600_gb200nvl.c',
>    'aspeed_ast2600_rainier.c',
>    'aspeed_ast10x0.c',
> -  'aspeed_ast10x0_evb.c'))
> -arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true=
: files(
> +  'aspeed_ast10x0_evb.c',
>    'aspeed_ast1700.c',
>    'aspeed_ast27x0.c',
>    'aspeed_ast27x0_evb.c',
> --
> 2.53.0
>

