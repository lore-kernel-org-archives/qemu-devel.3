Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC22CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtXE-0005IG-JT; Fri, 15 May 2026 10:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtX1-00053s-0o
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:28:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtWy-0002Cf-GD
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:28:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so90627185e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855326; cv=none;
 d=google.com; s=arc-20240605;
 b=hAppc41E71dHS641VS44nuNfbbnxkFqRo2dKxGvaTdGlTYILaXhef23Mixt8I+QQKr
 iit78nuPWGwUtDC5Euui+totUc2uUJ1QJ6gLVWf9JkoaDnlazV+nHDNwcwoohGd4Wlsp
 6KLKtBDO46Bd3mJHsiGVBVNGMO9qmLi8goUUdEgTM1Ebi/XwhyPT4psqoSTSQyDRUsff
 fivxcQgU1vR4awuwhl5LbiynmbRkGQwQR2gzzKBttz8/ZZrrT28jln95ouYK8uYn4E5O
 7x06xZuQmxkHs5Ssr/k7dECFWqNeWhWs4irOKIw3SgdMLk2WhcyLs19DtvI6x6ZkLkOl
 O4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x+HcHjq82BuPwQhlrLBVJym7keyCP1UMUVHCB17HpWg=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=bLL1Kl7ik2H31eSCQrNvtGJmHH4Q5a3vZXHc5oIsz4irw7NrBWGT3O2AC4DxxkEQwQ
 s+WqJ9THCMAyaUdTHq/a+Esdfo74hNNHo9Kb8pwg5QKvhKVm5kRzI9zz0B6pvGVN9bHw
 hfzesV1ni9LCyw/wLV3Pyc1jeYCrtBZrxfRBHB1qP9JfVY1hGQ6DZs/mj6bgFuHrqjeb
 HiacFHtklMzs78hHMnd2z6jhkNHSEM+nSon3kJkLrJqE2bvGQOeeAG/c8PU9EaolBxJn
 8HcGbvCzN/tgXu+15S7zyfZ9p1eM3WjVr0zHpW4eB0QIGlpT/jnds9+jYiJiKHkF4KWr
 GE0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855326; x=1779460126; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+HcHjq82BuPwQhlrLBVJym7keyCP1UMUVHCB17HpWg=;
 b=xCoAbPutbLnHGsT2zfnNwwNbXxO7pT5ffVW1gn8IGzQ8MbgtB7GIOPWEQrNscCS3e1
 cjm7or2M5T72oMVBkpglr8UI5uPwOktLxBYytfyzjbjkTwCHa/yM68x/BNbQ67aHUHua
 qcLVJmiIZ5UoA3wmpj+nAzeb0L481ehSlUyQfY1JvFboK2t1dZLUYNg557dHM0Z5nGSk
 V+B1kSBzCMqU5Ls4XN1APzCoh8rbb7ZkYDjyh+jTCbJ8krGQ8tjlQItISlZJ9kzmGISM
 XgACh6KlHv6D4pv8xG7a79xRL3daXcqWNtWpz37cEmQFPbgtyET0FagTXFIHlD3htpzh
 DVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855326; x=1779460126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+HcHjq82BuPwQhlrLBVJym7keyCP1UMUVHCB17HpWg=;
 b=AOQRP+FVCPhw8+MtLTG8+IReZi0sneQ+yFE5axWNL53A8KyYrie1MmmJfBjXbu6mbM
 w/+zojJkr5Xa9l/l0CoqWcC7PvTrVtMSFgCMGemeGWkjLsrSiolodSJQ1DNpSCWIAP/O
 rcbjPrb9xZaSvZT22Z3sIv4SytdE7jYbKHDxJ30DIcf90GvVIDOxizmAUz8OO/mjmrOZ
 +7+VEpiyUez82t7hVIIctLU9oo/bCSGRWgQO+ISi8EEpLYESzk/Hjz9/QwTFwwopWyIz
 709ty1XhSUJ9l97inKy+UNqG+QPGm8USen9l/xPvY+Zhs4U6+IzvM47k/Fpkf5FoDilC
 N/0w==
X-Gm-Message-State: AOJu0YyRlTfK+fn8hFqhO+PP5kvRkAf32fgbuogMD+UG+e0cBZjPh/2R
 1mMqq7eEYs+m7BBumCq6hAoYzjv1n2YON8I047/UBqgr+HYEVpzs7euMPcOIMTtoN64odSQOW2W
 mjzOH9rVv5U+HCraEw7qVgMzrgdGDjrEoR1mFVSpE0Q==
X-Gm-Gg: Acq92OHAtIEDhUWlFYou9SopJUa4QwwTanqyuv7VD7um/8mdZlXN5PoIGwZpcz3gnPt
 BitYINfCI/vQvArqMAp4N17el2VNY5/3ElHd5DruWiLF0fgDuhvbLHIzy9yl0RUy8Ut6bVmQrLT
 UocgVdUeLRd49b93ny5SrR85vg5iQfrMEs3ZtGRm29C8q9w/TkQo3S9CFq7a4qQwklpgExPhHqe
 4BiY4+0//mlj/zfsCTdtj0kG3wNOXKzsiVJBf/WiqV+lOOGmGgCCBfogk5oeomJoZ2dDcTy11FK
 0GEByxVkrDVxezl8G1vya84kEfaQ2ZCtNGd9Kc1NpoEK+zgKwXsHi74KHntxsIjLCZYpn2M=
X-Received: by 2002:a05:600c:8901:b0:48e:526e:1040 with SMTP id
 5b1f17b1804b1-48fe63021f9mr48635335e9.23.1778855326384; Fri, 15 May 2026
 07:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-18-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-18-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:28:19 +0300
X-Gm-Features: AVHnY4Ii6C1VtxVBmL2d_4YtD2Ft2RSuyeDtVsIi1apT_1YLBRrOQHzezGn1hS0
Message-ID: <CAAjaMXYv31nfMdK4r4XjN_tEcLGUAsPdpEyPf6gPvkYL8ChnYQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] target/arm: Re-use common aarch64_aa32_a57_init()
 helper
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

On Fri, May 15, 2026 at 5:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Make aarch64_aa32_a57_init() common by exposing its prototype
> and defining it in cpu-max.c. Call it in arm_max_initfn()
> restricted to AArch32.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/internals.h |  1 +
>  target/arm/cpu-max.c   | 74 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu64.c     | 71 ----------------------------------------
>  target/arm/tcg/cpu32.c | 48 ++-------------------------
>  4 files changed, 77 insertions(+), 117 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 00830b17248..c95f3d63138 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1758,6 +1758,7 @@ void aarch64_max_tcg_initfn(Object *obj);
>  void aarch64_add_pauth_properties(Object *obj);
>  void aarch64_add_sve_properties(Object *obj);
>  void aarch64_add_sme_properties(Object *obj);
> +void aarch64_aa32_a57_init(Object *obj, bool aa32_only);
>
>  /* Return true if the gdbstub is presenting an AArch64 CPU */
>  static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
> diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
> index 9fd48ce46e2..6fc54ebe74e 100644
> --- a/target/arm/cpu-max.c
> +++ b/target/arm/cpu-max.c
> @@ -7,7 +7,81 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "system/kvm.h"
>  #include "target/arm/internals.h"
> +#include "target/arm/cpregs.h"
> +
> +void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +    ARMISARegisters *isar =3D &cpu->isar;
> +    const bool aarch64_enabled =3D !aa32_only;
> +
> +    cpu->dtb_compatible =3D "arm,cortex-a57";
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_NEON);
> +    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> +    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
> +    if (aarch64_enabled) {
> +        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> +    }
> +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
> +    set_feature(&cpu->env, ARM_FEATURE_EL3);
> +    set_feature(&cpu->env, ARM_FEATURE_PMU);
> +    if (kvm_enabled()) {
> +        cpu->kvm_target =3D QEMU_KVM_ARM_TARGET_CORTEX_A57;
> +    }
> +    cpu->midr =3D 0x411fd070;
> +    cpu->revidr =3D 0x00000000;
> +    cpu->reset_fpsid =3D 0x41034070;
> +    cpu->isar.mvfr0 =3D 0x10110222;
> +    cpu->isar.mvfr1 =3D 0x12111111;
> +    cpu->isar.mvfr2 =3D 0x00000043;
> +    cpu->ctr =3D 0x8444c004;
> +    cpu->reset_sctlr =3D 0x00c50838;
> +    SET_IDREG(isar, ID_PFR0, 0x00000131);
> +    SET_IDREG(isar, ID_PFR1, 0x00011011);
> +    SET_IDREG(isar, ID_DFR0, 0x03010066);
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
> +    SET_IDREG(isar, ID_MMFR0, 0x10101105);
> +    SET_IDREG(isar, ID_MMFR1, 0x40000000);
> +    SET_IDREG(isar, ID_MMFR2, 0x01260000);
> +    SET_IDREG(isar, ID_MMFR3, 0x02102211);
> +    SET_IDREG(isar, ID_ISAR0, 0x02101110);
> +    SET_IDREG(isar, ID_ISAR1, 0x13112111);
> +    SET_IDREG(isar, ID_ISAR2, 0x21232042);
> +    SET_IDREG(isar, ID_ISAR3, 0x01112131);
> +    SET_IDREG(isar, ID_ISAR4, 0x00011142);
> +    SET_IDREG(isar, ID_ISAR5, 0x00011121);
> +    SET_IDREG(isar, ID_ISAR6, 0);
> +    if (aarch64_enabled) {
> +        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
> +        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
> +        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
> +        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
> +    }
> +    cpu->isar.dbgdidr =3D 0x3516d000;
> +    cpu->isar.dbgdevid =3D 0x01110f13;
> +    cpu->isar.dbgdevid1 =3D 0x2;
> +    cpu->isar.reset_pmcr_el0 =3D 0x41013000;
> +    SET_IDREG(isar, CLIDR, 0x0a200023);
> +    /* 32KB L1 dcache */
> +    cpu->ccsidr[0] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB=
, 7);
> +    /* 48KB L1 icache */
> +    cpu->ccsidr[1] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB=
, 2);
> +    /* 2048KB L2 cache */
> +    cpu->ccsidr[2] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB=
, 7);
> +    if (aarch64_enabled) {
> +        set_dczid_bs(cpu, 4); /* 64 bytes */
> +        cpu->gic_num_lrs =3D 4;
> +        cpu->gic_vpribits =3D 5;
> +        cpu->gic_vprebits =3D 5;
> +        cpu->gic_pribits =3D 5;
> +    }
> +    define_cortex_a72_a57_a53_cp_reginfo(cpu);
> +}
>
>  /* Share AArch32 -cpu max features with AArch64. */
>  void aa32_max_features(ARMCPU *cpu)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 7dce17fdb20..499d154dace 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -686,77 +686,6 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **=
errp)
>      SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
>  }
>
> -static void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
> -{
> -    ARMCPU *cpu =3D ARM_CPU(obj);
> -    ARMISARegisters *isar =3D &cpu->isar;
> -    const bool aarch64_enabled =3D !aa32_only;
> -
> -    cpu->dtb_compatible =3D "arm,cortex-a57";
> -    set_feature(&cpu->env, ARM_FEATURE_V8);
> -    set_feature(&cpu->env, ARM_FEATURE_NEON);
> -    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> -    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
> -    if (aarch64_enabled) {
> -        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> -    }
> -    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> -    set_feature(&cpu->env, ARM_FEATURE_EL2);
> -    set_feature(&cpu->env, ARM_FEATURE_EL3);
> -    set_feature(&cpu->env, ARM_FEATURE_PMU);
> -    if (kvm_enabled()) {
> -        cpu->kvm_target =3D QEMU_KVM_ARM_TARGET_CORTEX_A57;
> -    }
> -    cpu->midr =3D 0x411fd070;
> -    cpu->revidr =3D 0x00000000;
> -    cpu->reset_fpsid =3D 0x41034070;
> -    cpu->isar.mvfr0 =3D 0x10110222;
> -    cpu->isar.mvfr1 =3D 0x12111111;
> -    cpu->isar.mvfr2 =3D 0x00000043;
> -    cpu->ctr =3D 0x8444c004;
> -    cpu->reset_sctlr =3D 0x00c50838;
> -    SET_IDREG(isar, ID_PFR0, 0x00000131);
> -    SET_IDREG(isar, ID_PFR1, 0x00011011);
> -    SET_IDREG(isar, ID_DFR0, 0x03010066);
> -    SET_IDREG(isar, ID_AFR0, 0x00000000);
> -    SET_IDREG(isar, ID_MMFR0, 0x10101105);
> -    SET_IDREG(isar, ID_MMFR1, 0x40000000);
> -    SET_IDREG(isar, ID_MMFR2, 0x01260000);
> -    SET_IDREG(isar, ID_MMFR3, 0x02102211);
> -    SET_IDREG(isar, ID_ISAR0, 0x02101110);
> -    SET_IDREG(isar, ID_ISAR1, 0x13112111);
> -    SET_IDREG(isar, ID_ISAR2, 0x21232042);
> -    SET_IDREG(isar, ID_ISAR3, 0x01112131);
> -    SET_IDREG(isar, ID_ISAR4, 0x00011142);
> -    SET_IDREG(isar, ID_ISAR5, 0x00011121);
> -    SET_IDREG(isar, ID_ISAR6, 0);
> -    if (aarch64_enabled) {
> -        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
> -        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
> -        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
> -        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
> -    }
> -    cpu->isar.dbgdidr =3D 0x3516d000;
> -    cpu->isar.dbgdevid =3D 0x01110f13;
> -    cpu->isar.dbgdevid1 =3D 0x2;
> -    cpu->isar.reset_pmcr_el0 =3D 0x41013000;
> -    SET_IDREG(isar, CLIDR, 0x0a200023);
> -    /* 32KB L1 dcache */
> -    cpu->ccsidr[0] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB=
, 7);
> -    /* 48KB L1 icache */
> -    cpu->ccsidr[1] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB=
, 2);
> -    /* 2048KB L2 cache */
> -    cpu->ccsidr[2] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB=
, 7);
> -    if (aarch64_enabled) {
> -        set_dczid_bs(cpu, 4); /* 64 bytes */
> -        cpu->gic_num_lrs =3D 4;
> -        cpu->gic_vpribits =3D 5;
> -        cpu->gic_vprebits =3D 5;
> -        cpu->gic_pribits =3D 5;
> -    }
> -    define_cortex_a72_a57_a53_cp_reginfo(cpu);
> -}
> -
>  static void aarch64_a57_initfn(Object *obj)
>  {
>      aarch64_aa32_a57_init(obj, false);
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 2e8afc28602..a2f730451fb 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -720,53 +720,9 @@ static void sa1110_initfn(Object *obj)
>  static void arm_max_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> -    ARMISARegisters *isar =3D &cpu->isar;
>
> -    /* aarch64_a57_initfn, advertising none of the aarch64 features */
> -    cpu->dtb_compatible =3D "arm,cortex-a57";
> -    set_feature(&cpu->env, ARM_FEATURE_V8);
> -    set_feature(&cpu->env, ARM_FEATURE_NEON);
> -    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> -    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
> -    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> -    set_feature(&cpu->env, ARM_FEATURE_EL2);
> -    set_feature(&cpu->env, ARM_FEATURE_EL3);
> -    set_feature(&cpu->env, ARM_FEATURE_PMU);
> -    cpu->midr =3D 0x411fd070;
> -    cpu->revidr =3D 0x00000000;
> -    cpu->reset_fpsid =3D 0x41034070;
> -    cpu->isar.mvfr0 =3D 0x10110222;
> -    cpu->isar.mvfr1 =3D 0x12111111;
> -    cpu->isar.mvfr2 =3D 0x00000043;
> -    cpu->ctr =3D 0x8444c004;
> -    cpu->reset_sctlr =3D 0x00c50838;
> -    SET_IDREG(isar, ID_PFR0, 0x00000131);
> -    SET_IDREG(isar, ID_PFR1, 0x00011011);
> -    SET_IDREG(isar, ID_DFR0, 0x03010066);
> -    SET_IDREG(isar, ID_AFR0, 0x00000000);
> -    SET_IDREG(isar, ID_MMFR0, 0x10101105);
> -    SET_IDREG(isar, ID_MMFR1, 0x40000000);
> -    SET_IDREG(isar, ID_MMFR2, 0x01260000);
> -    SET_IDREG(isar, ID_MMFR3, 0x02102211);
> -    SET_IDREG(isar, ID_ISAR0, 0x02101110);
> -    SET_IDREG(isar, ID_ISAR1, 0x13112111);
> -    SET_IDREG(isar, ID_ISAR2, 0x21232042);
> -    SET_IDREG(isar, ID_ISAR3, 0x01112131);
> -    SET_IDREG(isar, ID_ISAR4, 0x00011142);
> -    SET_IDREG(isar, ID_ISAR5, 0x00011121);
> -    SET_IDREG(isar, ID_ISAR6, 0);
> -    cpu->isar.dbgdidr =3D 0x3516d000;
> -    cpu->isar.dbgdevid =3D 0x01110f13;
> -    cpu->isar.dbgdevid1 =3D 0x2;
> -    cpu->isar.reset_pmcr_el0 =3D 0x41013000;
> -    SET_IDREG(isar, CLIDR, 0x0a200023);
> -    /* 32KB L1 dcache */
> -    cpu->ccsidr[0] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB=
, 7);
> -    /* 48KB L1 icache */
> -    cpu->ccsidr[1] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB=
, 2);
> -    /* 2048KB L2 cache */
> -    cpu->ccsidr[2] =3D make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB=
, 7);
> -    define_cortex_a72_a57_a53_cp_reginfo(cpu);
> +    /* Cortex-A57 advertising none of the aarch64 features */
> +    aarch64_aa32_a57_init(obj, true);
>
>      aa32_max_features(cpu);
>
> --
> 2.53.0
>

