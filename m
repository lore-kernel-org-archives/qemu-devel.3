Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45507CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 15:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsPAJ-0008Qd-Tx; Thu, 04 Apr 2024 11:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsPAH-0008QT-R8
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 11:38:10 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsPAF-0002o5-Si
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 11:38:09 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-516d1ecaf25so291073e87.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712245086; x=1712849886; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RYZtDnRfDnSy8RH+YsfydNCoz4KDYscJFqZ3Myp/us4=;
 b=mjFG3pUgf1IpLfWDAFB3iytOt7CbIxZ66k6CTOCtOqrl3XQLzB5beJGUZ2bDq2Rqgj
 jiWk7uKuLcJCT8v0nLDhSzJTHivRJ1/NITTpWfcjoRkwz6vkymjrV8eMGjDyo2Zv0SOr
 PbMqPI9DoY4vgVo0TbHliNwM2mXiMR16OmBiWSZZZmmryR9mofOzhsD3wIp5hnIHNzxJ
 P4aA6xggOCiydlnorvRYVTb2qVcw6Gqd19aQTIuGrDMfkhPY4r/qi9YkM6M0VhoCw4qj
 pwolnllnr/GjahMNpMdV0RpIQnVYaMVUwlR80G70KtRS0lC38tgPZ8bXOvTrP0so+t4+
 3Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712245086; x=1712849886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RYZtDnRfDnSy8RH+YsfydNCoz4KDYscJFqZ3Myp/us4=;
 b=DaInJnhpn3BNA5zAvCucU8agf9W/kKtkhTPl4QcH/sb/5C8u8bBnT0XfBfPZnFDbwZ
 F35yhMVjatJ2Iyo5hlyuLfDufE/42XgcRxAYiJhm7rJpJdoQNY3CO1xqLd2ox0rR1CAW
 5HwrGITDIWvPiC86shuk8quIElOE8HpJh2hY6/RvUT7idksRE4N4nn3jhlJyoPL2iKUl
 nhaqIrFor/UEDkHF6y7+B33icEqW0Nx5RA6akP7bJpCoOi+dixDaa92xXwG4AtxaRh33
 m7uAdcwj5eyEA09Jzi1EKSEg6brhUtetlFrnONHpQrJRdGdXCCGqvUTLtJcOummvF5PN
 aeuQ==
X-Gm-Message-State: AOJu0YwsCnSD4XLptgMG/8b6fwblImXuwqIYPQ5fo/2l329i4+vXYi1E
 Rc1iSgF/EdquPfYjxn+G5l+fAln9MEWqauKR+om3hNEXten1uPUE57L8rgRkVs/D31v2Y96hOI2
 BaAzudvspAfGFAfZw4f+hCvfxWA7rfZQX7ySXrA==
X-Google-Smtp-Source: AGHT+IF0d23o0GGJg8QIPZwU2Z4X4UItV+AOA6Bx5nLouJR3d3EBtEwBcJY5jeqs8trYuAoZM78qq1m5a1DGemut+7A=
X-Received: by 2002:ac2:5e3a:0:b0:513:a257:919b with SMTP id
 o26-20020ac25e3a000000b00513a257919bmr1799437lfg.14.1712245085625; Thu, 04
 Apr 2024 08:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240404151100.24063-1-zack@buhman.org>
In-Reply-To: <20240404151100.24063-1-zack@buhman.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 16:37:54 +0100
Message-ID: <CAFEAcA-VQ0yZMoFEuYWD2twe129OZHaer+-_49inW1exANKV2w@mail.gmail.com>
Subject: Re: [PATCH] sh4: mac.l: implement saturation arithmetic logic
To: Zack Buhman <zack@buhman.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Thu, 4 Apr 2024 at 16:12, Zack Buhman <zack@buhman.org> wrote:
>
> The saturation arithmetic logic in helper_macl is not correct.
>
> I tested and verified this behavior on a SH7091, the general pattern
> is a code sequence such as:
>
>         sets
>
>         mov.l _mach,r2
>         lds r2,mach
>         mov.l _macl,r2
>         lds r2,macl
>
>         mova _n,r0
>         mov r0,r1
>         mova _m,r0
>         mac.l @r0+,@r1+
>
>     _mach: .long 0x00007fff
>     _macl: .long 0x12345678
>     _m:    .long 0x7fffffff
>     _n:    .long 0x7fffffff
>
> Test case 0: (no int64_t overflow)
>   given; prior to saturation mac.l:
>     mach = 0x00007fff macl = 0x12345678
>     @r0  = 0x7fffffff @r1  = 0x7fffffff
>
>   expected saturation mac.l result:
>     mach = 0x00007fff macl = 0xffffffff
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0x00007ffe macl = 0x12345678
>
> Test case 1: (no int64_t overflow)
>   given; prior to saturation mac.l:
>     mach = 0xffff8000 macl = 0x00000000
>     @r0  = 0xffffffff @r1  = 0x00000001
>
>   expected saturation mac.l result:
>     mach = 0xffff8000 macl = 0x00000000
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0xffff7fff macl = 0xffffffff
>
> Test case 2: (int64_t addition overflow)
>   given; prior to saturation mac.l:
>     mach = 0x80000000 macl = 0x00000000
>     @r0  = 0xffffffff @r1  = 0x00000001
>
>   expected saturation mac.l result:
>     mach = 0xffff8000 macl = 0x00000000
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0xffff7fff macl = 0xffffffff
>
> Test case 3: (int64_t addition overflow)
>   given; prior to saturation mac.l:
>     mach = 0x7fffffff macl = 0x00000000
>     @r0 = 0x7fffffff @r1 = 0x7fffffff
>
>   expected saturation mac.l result:
>     mach = 0x00007fff macl = 0xffffffff
>
>   qemu saturation mac.l result (prior to this commit):
>     mach = 0xfffffffe macl = 0x00000001
>
> All of the above also matches the description of MAC.L as documented
> in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf
> ---
>  target/sh4/op_helper.c | 45 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
>
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index 4559d0d376..a3eb2f5281 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -160,18 +160,43 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
>
>  void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>  {
> -    int64_t res;
> -
> -    res = ((uint64_t) env->mach << 32) | env->macl;
> -    res += (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
> -    env->mach = (res >> 32) & 0xffffffff;
> -    env->macl = res & 0xffffffff;
> +    int32_t value0 = (int32_t)arg0;
> +    int32_t value1 = (int32_t)arg1;
> +    int64_t mul = ((int64_t)value0) * ((int64_t)value1);
> +    int64_t mac = (((uint64_t)env->mach) << 32) | env->macl;
> +    int64_t result = mac + mul;
> +    /* Perform 48-bit saturation arithmetic if the S flag is set */
>      if (env->sr & (1u << SR_S)) {
> -        if (res < 0)
> -            env->mach |= 0xffff0000;
> -        else
> -            env->mach &= 0x00007fff;
> +        /*
> +         * The following xor/and expression is necessary to detect an
> +         * overflow in MSB of res; this is logic necessary because the
> +         * sign bit of `mac + mul` may overflow. The MAC unit on real
> +         * SH-4 hardware has carry/saturation logic that is equivalent
> +         * to the following:
> +         */
> +        const int64_t upper_bound =  ((1ull << 47) - 1);
> +        const int64_t lower_bound = -((1ull << 47) - 0);
> +
> +        if (((((result ^ mac) & (result ^ mul)) >> 63) & 1) == 1) {
> +            /* An overflow occured during 64-bit addition */

This is testing whether the "int64_t result = mac + mul"
signed 64-bit arithmetic overflowed, right? That's probably
cleaner written by using the sadd64_overflow() function in
host-utils.h, which does the 64-bit add and returns a bool
to tell you whether it overflowed or not:

   if (sadd64_overflow(mac, mul, &result)) {
       result = (result < 0) ? lower_bound : upper_bound;
   } else {
       result = MIN(MAX(result, lower_bound), upper_bound);
   }



> +            if (((mac >> 63) & 1) == 0) {
> +                result = upper_bound;
> +            } else {
> +                result = lower_bound;
> +            }
> +        } else {
> +            /* An overflow did not occur during 64-bit addition */
> +            if (result > upper_bound) {
> +                result = upper_bound;
> +            } else if (result < lower_bound) {
> +                result = lower_bound;
> +            } else {
> +                /* leave result unchanged */
> +            }
> +        }
>      }
> +    env->macl = result;
> +    env->mach = result >> 32;

thanks
-- PMM

