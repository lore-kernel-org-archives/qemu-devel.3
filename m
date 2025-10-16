Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11CFCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Rhy-0000iE-NR; Thu, 16 Oct 2025 13:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9Rhw-0000ho-FO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:24:08 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9Rhr-0005WD-1P
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:24:07 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-638d01a8719so1079117d50.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760635438; x=1761240238; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xmcQyauNcshW0NfteA5pVhbcjoN0pMK4AdljA6AZ1WM=;
 b=DfQApFyAadE33XXqPe+98ByVb9Z+7oNN9doT5OmgZ2dsTLOtTSCXVVyK/On2Ebxel/
 Wo+Kw/zRBFeUH1opojh7jx1Kvl1luanPqZx/jxTLuJivqaQ5P6GwqL0lrSPDxXwmx14w
 0133YLKnIbwpJamqgutT6EkjIyAHSQYgYk0FaQOssoFdLiVm8BhH0gYdUF9E+G08Cmwq
 EsFAczk9zVwC0Jgynfm9YN5rXvuHhmcUQOuQCm41RnsRlfXoH48WLt0w9/pGOBwCLsJP
 IHtVuy5ASEnwIlrSdB7jXvPjQhJrbiENe0Qtwb+EO03NWFS+SqHJ5tl0MQfq047U+BaA
 AzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760635438; x=1761240238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmcQyauNcshW0NfteA5pVhbcjoN0pMK4AdljA6AZ1WM=;
 b=M+qUrlM3j61ZMn0kdMsdiX/B5dmSph0jOLILvBxRUlFtv8P3Pms/QtL9WYAxqp5YzR
 A8zj2LcqabYpB1TUiIkbKk0uY6q0stNkqUMk749Jq61EgSR2Vf59HHN0BHAJ63bTHMap
 JXJLARnatTrnFdt8VLORaTZhzcS1eaAetUWGc//L9kQO7Ghh5oI42PTH2OpYy4f9kcZb
 loJ6PzGQlAcDp9Vp3eKMDE7bjUc35g3deJLC9RSde5/Y+MSOlVGoMA385O+sYBcGnogd
 VnQddDN8BeaI7Lxb9ZuWbi71qif65s8QTcHhqBx4rx+9BmwmFUi+oxKSHuAg7YAQiplf
 wkpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQbmCfqg/fYqM45Swrg0kuddqC3vWjfSe5ObKS6In6Hp4C+k1kL6LwksqyPByUmLlRCy0V6TfoIPcT@nongnu.org
X-Gm-Message-State: AOJu0YyyNMDGPv8MbFcljnja8ifUWKrx6xN1wwoAtaDHbT97LXaAQXKy
 6829Nv7fUQ05cM5bBPz25SUl/FoCXEUf5fdQJTCHJ1L0YXDS5h3ks+cjysbTjCh/wbyvU4uj0HW
 2dUfASEp3uoiddGw/P8S+mzatBTMEQkZUbJlsdjk6Ig==
X-Gm-Gg: ASbGnctzpH4QTWpRRlrMkuiuMJqsvn18kgKdRKgpLPpf+TlyaiCNMLrjpfffu+r8aji
 5l365VfKQXzLLjfWUUueYp4Rei1cLcTvsBGX1wUu0ebukCDP/rcv5IjubzEsZM/W6YTjPV3Upqk
 kiS7SI6smd+xl1gSe/QiBGOpRQtk1beQHnmEqEEostsyxywJ4LEbeMAkspadmqk1iFm5fhMEm7D
 2PlWJjbiOoOEA37EGzgsE1E2i3vfOAVG/g3NYe4laFg/foUvF77ygcZHDZxzYPLlL5bx7Ad
X-Google-Smtp-Source: AGHT+IHs726GqZvy3ScVilrNhGFf1qRuYubYLM2qA70hmfL5Bdk53q1mU+1tVqptk3cS2hVIonzyvjaNaYkMc45BaXA=
X-Received: by 2002:a53:c607:0:b0:63e:1327:8df5 with SMTP id
 956f58d0204a3-63e1625f009mr587668d50.49.1760635437467; Thu, 16 Oct 2025
 10:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250517120053.18231-1-deller@kernel.org>
 <20250517120053.18231-4-deller@kernel.org>
In-Reply-To: <20250517120053.18231-4-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 18:23:46 +0100
X-Gm-Features: AS18NWBnlgGgcL6BB89Ve8RUpcLgE7xbsC1SvNFuheU-cMDDX1yXE6blepmle3Q
Message-ID: <CAFEAcA8i31Btj4KLXb+4oL9fxEQsCOwsZxJtw4qXcorboG=tDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/hppa: Fix FPE exceptions
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Sat, 17 May 2025 at 13:02, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> Implement FP exception register #1 (lower 32-bits of 64-bit fr[0]).
> A proper implementation is necessary to allow the Linux kernel in
> system mode and the qemu linux-user to send proper si_code values
> on SIGFPE signal.
>
> Always set the T-bit on taken exception, and merge over- and underflow
> in system mode to just set overflow bit to mimic the behaviour I tested
> on a physical machine.

It looks like this patch broke the setting of the Flag
bits in the FPSR for non-trapped exceptions, which is
https://gitlab.com/qemu-project/qemu/-/issues/3158 ...

> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
> index a62d9d3083..294ce0a970 100644
> --- a/target/hppa/fpu_helper.c
> +++ b/target/hppa/fpu_helper.c
> @@ -95,7 +95,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
>  {
>      uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
>      uint32_t hard_exp = 0;
> -    uint32_t shadow = env->fr0_shadow;
> +    uint32_t shadow = env->fr0_shadow & 0x3ffffff;

We used to have 'shadow' contain all the existing Flag bits,
but now we mask them out. So whenever we call this function
we will zero out any previously set Flag bits.

> +    uint32_t fr1 = 0;
>
>      if (likely(soft_exp == 0)) {
>          env->fr[0] = (uint64_t)shadow << 32;
> @@ -108,9 +109,22 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
>      hard_exp |= CONVERT_BIT(soft_exp, float_flag_overflow,  R_FPSR_ENA_O_MASK);
>      hard_exp |= CONVERT_BIT(soft_exp, float_flag_divbyzero, R_FPSR_ENA_Z_MASK);
>      hard_exp |= CONVERT_BIT(soft_exp, float_flag_invalid,   R_FPSR_ENA_V_MASK);
> -    shadow |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);

...and we used to set the Flags bits for any exception that
had happened, and now we don't. So setting Flags for
non-trapped exceptions doesn't work.

> +    if (hard_exp & shadow) {
> +        shadow = FIELD_DP32(shadow, FPSR, T, 1);
> +        /* fill exception register #1, which is lower 32-bits of fr[0] */
> +#if !defined(CONFIG_USER_ONLY)
> +        if (hard_exp & (R_FPSR_ENA_O_MASK | R_FPSR_ENA_U_MASK)) {
> +            /* over- and underflow both set overflow flag only */
> +            fr1 = FIELD_DP32(fr1, FPSR, C, 1);
> +            fr1 = FIELD_DP32(fr1, FPSR, FLG_O, 1);
> +        } else
> +#endif
> +        {
> +            fr1 |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
> +        }
> +    }
>      env->fr0_shadow = shadow;
> -    env->fr[0] = (uint64_t)shadow << 32;
> +    env->fr[0] = (uint64_t)shadow << 32 | fr1;
>
>      if (hard_exp & shadow) {
>          hppa_dynamic_excp(env, EXCP_ASSIST, ra);
> --

"Set all the Flag bits for non-trapping exceptions" seems
straightforward. I can't see anywhere in the function which
would care about the Flag bits in the 'shadow' variable,
though, so I don't understand why you were masking out the
Flag bits in this patch; so I'm not sure whether undoing that
will break anything. (I don't have a setup to try the test
program you give in this commit message.)

This patch fixes the "don't trap" case:

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 45353202fae..2d272730f60 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -94,7 +94,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
 {
     uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
     uint32_t hard_exp = 0;
-    uint32_t shadow = env->fr0_shadow & 0x3ffffff;
+    uint32_t shadow = env->fr0_shadow;
+    uint32_t to_flag = 0;
     uint32_t fr1 = 0;

     if (likely(soft_exp == 0)) {
@@ -122,6 +123,10 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
             fr1 |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
         }
     }
+    /* Set the Flag bits for every exception that was not enabled */
+    to_flag = hard_exp & ~shadow;
+    shadow |= to_flag << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
+
     env->fr0_shadow = shadow;
     env->fr[0] = (uint64_t)shadow << 32 | fr1;

If it looks OK I'll send it as a proper patch.

-- PMM

