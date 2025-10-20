Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC7CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqZa-0003Dr-Qu; Mon, 20 Oct 2025 10:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqZV-0003Cx-Bq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:09:14 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqZQ-0006i7-MU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:09:12 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63e16fbdd50so3330452d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760969346; x=1761574146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R+vWKXYePCWA4bi2+f4sMJFhep6lKGDa+fVhlfdzZ7k=;
 b=xUOkKoB8nzqZDFGXz+xx9XYQMBJexPenM5rraNAh+AW1nwSWlCiqgr/bDf2fL/lN5J
 JADcuCk3IB09uFEpBaV81Z6u9OmRKtlpjoGiN+mBxhdWrEYGrSmFP84TMBcE1xa2qaTw
 bZrd+a9gpi6azilLY80PvsGqz3k1UJ4aexEnGprBAVdG6GADLK/s+qKtbtvvyYK93n6t
 0yBbt88LiS8g/93uqwagWdq1XpVkkrjHpA9rcPyNut/wVIf+VpN2eXsxCgjU3NScIQT1
 w1g/EQj9dCURzXMz65OLPvkI6SfESV5Hkkjto06+4w4QkWVwzZSk4ahkxUj7k070u/eh
 hkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760969346; x=1761574146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+vWKXYePCWA4bi2+f4sMJFhep6lKGDa+fVhlfdzZ7k=;
 b=FeB0PBcOczNPM4H+Jddp4X9BTjzLYEom9h05bwAP3UTH+E5wUWBcsmtYe+t45Lmpnm
 +SG3Iuf9utipmqUHHVWQr8pXjxtu1ZMnb6C/nqmavRYoVL1WCSJ/295mXIi0ldZhTnHA
 Y1HX5SO9kqOFUclMS25L+ggBLr00WU89509jzyEiNVghpUw8kHOKksHY1xkzEt6CW+8w
 fjrGbZkgLuKylrSGKoHap6gVlpB/CxSc8Qd6qVxvw0WK2+DNH5jsHD/QvgNpGZuvbqkN
 bPopzn2NhrB133RYNRrfuxBX+I643EbtvQ5Mix9nz6gFDpbnZ84yl9c8Ka61G7/nSt3o
 e76g==
X-Gm-Message-State: AOJu0Yzs5rpsTkodRU0g0qQyQqUMTyR89Smyk8ODajVBZsf4S1tPi2lj
 Up4lO7Mm5DHowkF4nwMvdnPmXiD4FWRAab0BFPmzXu4uISnc4NOy7ejM2y2aGJHwbf3yZCz47Tv
 gTI+llF8DnbNswQCQDpwn0+Pow5Y8I77oaL51xDa3lQ==
X-Gm-Gg: ASbGncvPMzO+Jysy3Hb7sbo7odyMk/laq18JGa0mlA4Dig3ZXaiQl4cwPR73ZkPQ2PN
 X813deIZl3OuiZwzsGSHPbNx4CfIaZht8LhXru7H/F9hwcRcXATpIKhvfSdJNbElwJUZIUXD4+h
 fv+IZwpYmJoO/Edco6gnSi99yjy3t3zvHe3x1r4A8uFqNnttd6g+pRuK4LoqfQkl0iIbxThMrHO
 furq1CG45+rK/nZBPO7F7+0d73fHV0zX6ivKbx4xFGf6KH629ucR9hVukXwJFTtoLfjn/eF
X-Google-Smtp-Source: AGHT+IG1g9MIK2HmIcZrQnYY4gQuZUMU8itXPFC/kokpgHb3APNlaF+E+7rux+R5C/rhLYsTPgYNQ3TdDxXz+MsCAPg=
X-Received: by 2002:a05:690e:d5c:b0:63d:d8c1:4347 with SMTP id
 956f58d0204a3-63e160e9854mr10475477d50.5.1760969346395; Mon, 20 Oct 2025
 07:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-25-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:08:54 +0100
X-Gm-Features: AS18NWDdNoKF3wHrZijxN11VA7z1qACq_TLm8RjBi4iW4v6zKryskTnAUq0QHMY
Message-ID: <CAFEAcA83Tgv5CV+EjMDemEb5FQkfAj0en7dq1g4JkxHZ1kKOdQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/37] target/arm: Use flush_if_asid_change in
 vmsa_ttbr_write
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 14 Oct 2025 at 21:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Only flush the subset of tlbs that are affected by the ttbr
> register to which we are writing.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c6d290ce7c..2b55e219c2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2943,11 +2943,20 @@ static void flush_if_asid_change(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
> -    /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
> -    if (cpreg_field_type(ri) == MO_64 &&
> -        extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
> -        ARMCPU *cpu = env_archcpu(env);
> -        tlb_flush(CPU(cpu));
> +    /*
> +     * If the ASID changes (with a 64-bit write), we must flush the TLB.
> +     * The non-secure ttbr registers affect the EL1 regime;
> +     * the secure ttbr registers affect the AA32 EL3 regime.
> +     */
> +    if (cpreg_field_type(ri) == MO_64) {
> +        flush_if_asid_change(env, ri, value,
> +                             ri->secure & ARM_CP_SECSTATE_S
> +                             ? (ARMMMUIdxBit_E30_0 |
> +                                ARMMMUIdxBit_E30_3_PAN |
> +                                ARMMMUIdxBit_E3)
> +                             : (ARMMMUIdxBit_E10_1 |
> +                                ARMMMUIdxBit_E10_1_PAN |
> +                                ARMMMUIdxBit_E10_0));
>      }

What's the value of ri->secure here for the case where EL3 is
AArch64 and we're in Secure EL1 at AArch32 ?

thanks
-- PMM

