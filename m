Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91120CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtQJ-0002Wj-SH; Fri, 15 May 2026 10:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtQB-0002Sq-Jf
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:21:49 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtQ8-0007fx-II
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:21:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso5777410f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854903; cv=none;
 d=google.com; s=arc-20240605;
 b=fmuurgx1uYzOBmd0TNQi+hnceiYg42+YjnuqC8fGp64SUFSZejMhlNytd/W4rrxL1G
 caL09GtPyJXnONfb6hjyreMM9YDmGkAcmfvfWavUy8u8V1X9y7uQBiI0dyDeDOw7wrcv
 RK91tHtw2/T3Nf6oEeBPi+vBxEi8POq7mRAhVf7Lt/3GqlRV7LrRLzPThaOBDZuF32p4
 WAIRIX+SJ0MisusG/Q7KC+SKpJ0w488LvEAs1wocD7ycv01e2kMElPWctlRZPOW8lRWc
 Y6WCnnNiwyua4g6QTf6EH1ljaJOkzJIsxJvRSNf3BcbGTQzlusQjIEt/eFERfOPrw34W
 WgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A6TigkJBMiYq0C6l+x61U2CsRJvEKK7w6lxRs19b8qU=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=gTSvja6RruSsfL102FYN1awBDWLD3uBv17I6JZFEn/jm4sbF7rNRUn9usY1vFulQTu
 wyLA26T3yZTI5OCUlxBgOuN0iybcdh7v6i90H4oH3pk8eN1EZObXlLtpnOCfR1sH81iz
 +ejygFIAv3wKA69rv1yi+WUlm52SYQkdY/YVLVqY9c8dP1NAtwbF+Zs552Uaa0gvNkFx
 BSeHH3seMqbVxI6+rzfKRnWleEmQvp6yURa9+7BOeWDGjK616LhddRPDVcPxgDFZ3sqN
 3U0WYUs6OWDyYA2Q8xOmtxi6fy5tU8v/scVcQEIsb1EX31FlWB0WcR6evWFDDWYffl7j
 7uDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854903; x=1779459703; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6TigkJBMiYq0C6l+x61U2CsRJvEKK7w6lxRs19b8qU=;
 b=pvqawHvbyam7v9OrcS9Nyuj59VSkuxm8clE02SZMDlltEn9khSB84uzaEliAI3wgU6
 KJR94Fs9rOXPMZS+4G2fPpCtb6/dbVKFjSHUkL2ZuR+7w/evxthxUHrbX43wbYsYbgUr
 Zp8XDOBMUt3FRmtT2p3Xc1mRFAace5qRCENj+MwLvqgb5fSsMXvJtRP32gFUScvDzZ0p
 ASCveDx/xbMCgnZS5fjm1mjJbbkUT2SiZJlxk96Vn4iKbrJePHjh1cG/lAN+LHwc+2rz
 WLEAkyxa5wGGUfHBD5G2QmoiXpzi2YFk/lytHcbZ9ZN+spKSOfjsUayq4necZFhPmg0R
 tn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854903; x=1779459703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6TigkJBMiYq0C6l+x61U2CsRJvEKK7w6lxRs19b8qU=;
 b=n0ikWULKCVGBFzPWyQUqoRssSbuNZ4VnKEr5XTn+0FGQ8fNjKFm1INPsyCDbDyFHBN
 lzHGtVfpE13Jl/CY0h88IU4l/2Kuz7q+dTicoeEuzHxGjFQmK40iXtkQcva4xPGTanRo
 d2hXOB1qKrW2qPbgz6ftvg+MeUU86GXDoDbcN7RsGEJB4sRts6hLCRGHnAeGUBWaLGeV
 E+rEx+wvuxc3eRPyQDHCDa5IzzSL9uKJz5Yh0cQpZcQ/LpQCIl/NsRe5cp8X4mlmvOEw
 QVGmM6ZiaJ849gX7zDR1RaQPetwVQiHHOxdLU1psXe+yVxlFYL65ByoQh9Fp9WkD+uAC
 WSYA==
X-Gm-Message-State: AOJu0YzKfxUZPONkFh0N4NJ8fKQVBz2S7wrBIDhEWgyxcTVlDgpI1Qbp
 PMD6hqW6IL2RBc8XEpnZwYoMVVfEsffCg4iTBt6errDcW14jPkgSlL7gLpxDisSawnvHYTG0ACC
 xQ7x0K1Fop4eC201a58yHDP96bvF97EMwIhSHJH+gSQ==
X-Gm-Gg: Acq92OGTuqySyvzKUz4Xrr0VOXRzq5LMMBy6bcBchwf4nk9405s8iT+2mCr9GBdwtp5
 dJLGphhn4X9ioczlw3GzXohxn0No3MGa4AZEduKv19diYSccTzMm0vYVSktoidbanjmATcWU7dh
 oJ29ovKiNjO5tpYb4CxeZo3MB8vZAHKgX9VSELd5fuPeu+0u/GYqvHmNY646dpb9dHkkZl67/gt
 9/VC7bRg3HhRAkKTwj0EcAGXNVKT4hkcwFmawOPfvFpTm8ykz0gxq/W/5gTuNc81znTKZMSuWnr
 2hCtzNCEnbciZjVoJ6CD6L167yVcuuZYfLLqSzNGGtyROyu7IC/WxJOO9jph
X-Received: by 2002:a5d:5847:0:b0:45d:b14b:2402 with SMTP id
 ffacd0b85a97d-45e5c5af3d6mr6003924f8f.11.1778854902940; Fri, 15 May 2026
 07:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-10-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-10-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:21:15 +0300
X-Gm-Features: AVHnY4LYCfEUJUHUVlifvR3EaIDMir3XRsfjNofjJEt5L_nV7qLPRilcUEM4tJw
Message-ID: <CAAjaMXbmCR10cGb8DsYF+vHFxb2NNVpxGJsijh76o3fOEXH=CQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/20] target/arm: Build cpu64.o as common object
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
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
> While gdbstub64.o is already built once, build it as
> common object, reducing target-specific set in arm_ss[].
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

The commit message was copied from the gdbstub patch, but this patch
touches the decodetree a64 gen files

For the patch changes:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  target/arm/tcg/meson.build | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 9eeccb2adca..f821331fbee 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -27,15 +27,13 @@ translate32_d =3D [
>    decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-de=
code=3Ddisas_t16']),
>  ]
>
> -arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
>  arm_stubs_ss.add(files('stubs32.c'))
>
>  arm_ss.add(files(
>    'cpu32.c',
>  ))
>
> -arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
> -  'cpu64.c',
> +arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64 + files(
>    'gengvec64.c',
>    'translate-a64.c',
>    'translate-sve.c',
> @@ -79,6 +77,9 @@ arm_common_user_system_ss.add(
>    'vec_helper.c',
>    'vfp_helper.c',
>  ))
> +arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> +  'cpu64.c',
> +))
>
>  arm_common_system_ss.add(files(
>    'cpregs-at.c',
> --
> 2.53.0
>

