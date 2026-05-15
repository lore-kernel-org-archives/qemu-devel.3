Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A181CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtSr-0004S5-C5; Fri, 15 May 2026 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtSg-0004Os-AP
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:24:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtSb-0008WH-WA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:24:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso54040905e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855054; cv=none;
 d=google.com; s=arc-20240605;
 b=fjHkkna74MFgCtBRrCrGXqfPzkDwJAZXTyB+jUvtksMGVJf9aDozSeto3UNhlGfCc7
 s660CqoQ5tmmIlJF6rCFAuA9xYXL17JOexKsW0eF4WFeBr7+hr5ATIOChxsHVo+CUiPJ
 sI8JL+lt1mvN4LHo9QVPEYQrP65GDj6lSYVAxv4yFDRB+Fiz8snSGIPEB5TzFvOdhZpM
 zadWWpC8CcrWbxFxw5GAyWVWXElbD+NRLREw9URUUjp8n10g4Dj1olTXFxQNqc7/Myml
 bRXBOdArqyrWUYk8++sD1NKAivl778cdDcYB2p3EfBh/gJsZEsoOCpiZjQk1KSrXlZLr
 OYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NBvzPX5JQzQqn/Diim4ka1qTU1UwKGkci3Lx7p+HPtw=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=jl9da5cXDlQ3UWGVfZBfxoeHl5nHRUw0KmeciiWul/V4KsXR/shl7YdjOBqWKFKHGh
 S+gzn4+IIghjsM/kjsR18xwdvnDVhB5D/kCtglMyfvKA8ptNbmWhdD/pl4OVedcapsSG
 L3AdC+a2u6QmTqjfbox47POctBBjjsaTozJbwCVwMs6ULP+/B6on6ZeVDeWD9WWd89h6
 YrqvtcVZZJbVBLnjBCLdrUS37f4NBu2dWFlB3JXLnFZtYfhHoKcBWBIS9MB62dCHbngg
 Cw+U9uRffdmEByaogAUC0HIvQ6vcrF8PzzGDiNFeax4ouQh+8f7Ba9k6BPBxe9QF86bM
 ky5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855054; x=1779459854; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBvzPX5JQzQqn/Diim4ka1qTU1UwKGkci3Lx7p+HPtw=;
 b=Tmxjh8649qz+3BpBnSB8Jb/A60pRCvlByDncCdqWQbY4hZb2TGxI0zh0WR0rJ+A4QP
 Ka0vU823VB1qW7LVbcrH3YIcMhUmLr0orIJi19MBPogJEuV282nuO0AoklfmTAB9Hylr
 ZVDNFNZM6pGo4bBO2wbnpr+tFyPmcnC8CwCvbotnBTH8HIAsUy8bQAllE01F3SPIsByK
 sCE6x3IEBxviFVaZNEtnDYlj5+TIiiQJy5OhxHjwL3cGLSPyeaggmLTb8v8rG8oJ/YXq
 OeXyN8s/SRHu/nvDTCWY+bMdDnQZBjGXBrmdVOotPwbRYGsOMoGOdos0WFky271o19MI
 8j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855054; x=1779459854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NBvzPX5JQzQqn/Diim4ka1qTU1UwKGkci3Lx7p+HPtw=;
 b=BEjLwTFWWwv/sUBKgqwVtD/jhu6HdsrdHvuOcTUO/HBcnKyNmN1eWX1EapZBwVNvrc
 7u89Fjy621BHDDDL/IT3KIFAKiVT21yQbZaRsaguRcNo5NNV4TyMU+s4Y485eTNMlsZE
 ho0wATjiq2oURvi1tG/B0IOijjBM7Og2AG9gFA+D6xuTPk51HbWZH9v049HNCDpnVbu5
 GiBs1/8DqHn04W7EKcpD4DextYubUpzPPM0MbxSdcUjcUJ3KO1dq1MBgH+aImaFVN3Op
 5EHq0ZEAhRbCkrR+dEmQYKhxt7liUkvOAkhVAt73cmNKv9A1AFfoA6NVYgkk9j6tQGIc
 cgYQ==
X-Gm-Message-State: AOJu0YzOHv59o57wQbE6S37dZz6xRnu354+ZDX49DlweNCxO/L+8WaJZ
 09LfbiTQqC9n4cg2r6phAUfLoRagN1rjaUi5f79JScv+u37Ja8JVYcn61EmbQx263SOfKKdajim
 d24bRRbxN5mJ7uz5ZvNdfe16CITjlgWw6SFIwP0fbGcboIfts1ohgi4NJrA==
X-Gm-Gg: Acq92OERmTzqdczY8sO5xaH8CA8jTTGTPiUIR0O+hOP/C4cf/Uu6oa9ktXCi5zBQu8m
 AN1ikuQVLlp/cY/CqMpfiD8Ii7wwRFXDWH1K9/eKrYK1CwfZI0ys9LRf4EHHdLqVBPdScVFk1dx
 hbkbh7VVgGWn74MlrvUBWVwx57VrXAcB8usT4bViHnbF9Rzml309rdVSp/2Q5yW5UWus4lVcjHR
 6ifowmV6aMJsTYw6E10OlT7f8RIr+/ywYOzDNIffvkrX97BXLaZKfywXg8x5OdSZdApjNcQArEy
 orgTH5AAVJ+inqZxpt8Zuf+iIRQtz7zPqNqBSSRjvrlpAG4brxVzjJ+xpspD
X-Received: by 2002:a05:600c:1505:b0:48f:ed68:6760 with SMTP id
 5b1f17b1804b1-48fed6867famr18430725e9.29.1778855053728; Fri, 15 May 2026
 07:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-12-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-12-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:23:46 +0300
X-Gm-Features: AVHnY4KXrEtl6HQ-aLWpONcnBxT2pz0ORYtoERYZlCH_Z422Q5gCY26vKEdIJ1g
Message-ID: <CAAjaMXY0Fa-POojxwcBjWjJwOL1NeTOHo+L+OjJN1UJUnFFU=Q@mail.gmail.com>
Subject: Re: [PATCH v6 11/20] target/arm: Rename Aarch64-specific methods
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
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/internals.h   |  8 ++++----
>  target/arm/cpu.c         |  8 ++++----
>  target/arm/cpu32-stubs.c |  8 ++++----
>  target/arm/cpu64.c       | 12 ++++++------
>  4 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 3edc15c7b4a..00830b17248 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1750,10 +1750,10 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GBy=
teArray *buf, int reg);
>  int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
>  int aarch64_gdb_get_tls_reg(CPUState *cs, GByteArray *buf, int reg);
>  int aarch64_gdb_set_tls_reg(CPUState *cs, uint8_t *buf, int reg);
> -void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
> -void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
> -void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
> -void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
> +void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
> +void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
> +void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
> +void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
>  void aarch64_max_tcg_initfn(Object *obj);
>  void aarch64_add_pauth_properties(Object *obj);
>  void aarch64_add_sve_properties(Object *obj);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 76f5909e902..31e1fd6cd51 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1707,25 +1707,25 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error=
 **errp)
>      Error *local_err =3D NULL;
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> -        arm_cpu_sve_finalize(cpu, &local_err);
> +        aarch64_cpu_sve_finalize(cpu, &local_err);
>          if (local_err !=3D NULL) {
>              error_propagate(errp, local_err);
>              return;
>          }
>
> -        arm_cpu_sme_finalize(cpu, &local_err);
> +        aarch64_cpu_sme_finalize(cpu, &local_err);
>          if (local_err !=3D NULL) {
>              error_propagate(errp, local_err);
>              return;
>          }
>
> -        arm_cpu_pauth_finalize(cpu, &local_err);
> +        aarch64_cpu_pauth_finalize(cpu, &local_err);
>          if (local_err !=3D NULL) {
>              error_propagate(errp, local_err);
>              return;
>          }
>
> -        arm_cpu_lpa2_finalize(cpu, &local_err);
> +        aarch64_cpu_lpa2_finalize(cpu, &local_err);
>          if (local_err !=3D NULL) {
>              error_propagate(errp, local_err);
>              return;
> diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
> index 9e50bb1b0b5..d42b1a5d6a6 100644
> --- a/target/arm/cpu32-stubs.c
> +++ b/target/arm/cpu32-stubs.c
> @@ -4,22 +4,22 @@
>  #include "target/arm/cpu.h"
>  #include "target/arm/internals.h"
>
> -void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
>  {
>      g_assert_not_reached();
>  }
>
> -void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>  {
>      g_assert_not_reached();
>  }
>
> -void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
>  {
>      g_assert_not_reached();
>  }
>
> -void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
>  {
>      g_assert_not_reached();
>  }
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index a93ad2da5ad..b38a78aac3f 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -60,7 +60,7 @@ int get_sysreg_idx(ARMSysRegs sysreg)
>
>  #undef DEF
>
> -void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>  {
>      /*
>       * If any vector lengths are explicitly enabled with sve<N> properti=
es,
> @@ -121,7 +121,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>               * Disable all SVE extensions as well. Note that some ZFR0
>               * fields are used also by SME so must not be wiped in
>               * an SME-no-SVE config. We will clear the rest in
> -             * arm_cpu_sme_finalize() if necessary.
> +             * aarch_cpu_sme_finalize() if necessary.
>               */
>              FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F64MM, 0);
>              FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F32MM, 0);
> @@ -336,7 +336,7 @@ static void cpu_arm_set_sve(Object *obj, bool value, =
Error **errp)
>      FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);
>  }
>
> -void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
>  {
>      uint32_t vq_map =3D cpu->sme_vq.map;
>      uint32_t vq_init =3D cpu->sme_vq.init;
> @@ -408,7 +408,7 @@ static void cpu_arm_set_sme(Object *obj, bool value, =
Error **errp)
>      /*
>       * For now, write 0 for "off" and 1 for "on" into the PFR1 field.
>       * We will correct this value to report the right SME
> -     * level (SME vs SME2) in arm_cpu_sme_finalize() later.
> +     * level (SME vs SME2) in aarch_cpu_sme_finalize() later.
>       */
>      FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, value);
>  }
> @@ -548,7 +548,7 @@ void aarch64_add_sme_properties(Object *obj)
>  #endif
>  }
>
> -void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
>  {
>      ARMPauthFeature features =3D cpu_isar_feature(pauth_feature, cpu);
>      ARMISARegisters *isar =3D &cpu->isar;
> @@ -666,7 +666,7 @@ void aarch64_add_pauth_properties(Object *obj)
>      }
>  }
>
> -void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
> +void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
>  {
>      uint64_t t;
>
> --
> 2.53.0
>

