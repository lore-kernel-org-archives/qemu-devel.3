Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D9BCD8C88
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 10:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWAxz-0002qG-Cq; Sun, 07 Jun 2026 06:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1wWAxx-0002pe-50
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 06:42:53 -0400
Received: from out-179.mta0.migadu.com ([2001:41d0:1004:224b::b3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1wWAxu-0007HV-Jg
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 06:42:52 -0400
Message-ID: <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780828965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noYmow1kBQa3rEdW0s9wrCxvvB3LEAmiDxNdxTGBF3k=;
 b=CbJCRR5ogyAvkAdGDsJegdh23c/CDQDOi11Hg3byDtp57Ll3EGnjrOZogLBOqvLqMrmt/T
 4PupJ4DdMgn2wig6Q2JhnRbAtqk1yXP/N4Y0m8B3vgTTAtyA2tCyhfIl7Uy7G1/JNXJH/U
 mp67/f+dmQTv+dWmwhbwEyvMgGzvYOU=
Date: Sun, 7 Jun 2026 18:42:30 +0800
MIME-Version: 1.0
Subject: Re: [PULL 17/21] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
To: Peter Maydell <peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm <qemu-arm@nongnu.org>
In-Reply-To: <20260529114723.42040-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b3;
 envelope-from=zenghui.yu@linux.dev; helo=out-179.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

+ Alexander and qemu-arm (for HVF/arm),

On 5/29/26 7:47 PM, Peter Maydell wrote:
> From: Jason Wright <wrigjl@proton.me>
> 
> Add an .accessfn to the RNDR and RNDRRS system registers that traps
> reads to EL3 when SCR_EL3.TRNDR is set, as required by FEAT_RNG_TRAP.
> Mark SCR_EL3.TRNDR (bit 40) as a writable field in scr_write() when
> the CPU advertises the feature. The pseudocode in DDI0487 revision M.b
> shows the trap firing from EL0, EL1, EL2, and EL3, so there is no
> check of arm_current_el().
> 
> When FEAT_RNG_TRAP is implemented without FEAT_RNG, an RNDR/RNDRRS read
> with SCR_EL3.TRNDR=0 should UNDEF rather than succeed; handle that case
> in access_rndr(). Register the rndr_reginfo CP reg entries whenever either
> FEAT_RNG or FEAT_RNG_TRAP is implemented, so the accessfn fires even on a
> FEAT_RNG_TRAP-only CPU.
> 
> When SCR_EL3.TRNDR is set, ID_AA64ISAR0_EL1.RNDR reads as 1 regardless
> of whether FEAT_RNG is implemented; give ID_AA64ISAR0_EL1 a readfn so it
> reports this at runtime, as we already do for ID_AA64PFR0_EL1.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jason Wright <wrigjl@proton.me>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu-features.h |  5 ++++
>  target/arm/helper.c       | 58 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 58 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 4e8d844fea..38a695ded7 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -908,6 +908,11 @@ static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RNDR) != 0;
>  }
>  
> +static inline bool isar_feature_aa64_rng_trap(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64PFR1, RNDR_TRAP) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
>  {
>      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TLB) == 2;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 34487eeaa3..9dd8fdfa41 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -790,6 +790,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>          if (cpu_isar_feature(aa64_fpmr, cpu)) {
>              valid_mask |= SCR_ENFPM;
>          }
> +        if (cpu_isar_feature(aa64_rng_trap, cpu)) {
> +            valid_mask |= SCR_TRNDR;
> +        }
>      } else {
>          valid_mask &= ~(SCR_RW | SCR_ST);
>          if (cpu_isar_feature(aa32_ras, cpu)) {
> @@ -5170,6 +5173,21 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      }
>      return pfr0;
>  }
> +
> +static uint64_t id_aa64isar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    uint64_t isar0 = GET_IDREG(&cpu->isar, ID_AA64ISAR0);
> +
> +    /*
> +     * When FEAT_RNG_TRAP is active (SCR_EL3.TRNDR set), ID_AA64ISAR0_EL1.RNDR
> +     * reads as 1 regardless of whether FEAT_RNG is implemented.
> +     */
> +    if (env->cp15.scr_el3 & SCR_TRNDR) {
> +        isar0 = FIELD_DP64(isar0, ID_AA64ISAR0, RNDR, 1);
> +    }
> +    return isar0;
> +}
>  #endif
>  
>  /*
> @@ -5304,6 +5322,22 @@ static const ARMCPRegInfo pauth_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, keys.apib.hi) },
>  };
>  
> +static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                  bool isread)
> +{
> +    if (env->cp15.scr_el3 & SCR_TRNDR) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }
> +    /*
> +     * Note that FEAT_RNG_TRAP may be implemented without FEAT_RNG.
> +     * In that case, if the trap is not enabled, the read undefs.
> +     */
> +    if (!cpu_isar_feature(aa64_rndr, env_archcpu(env))) {
> +        return CP_ACCESS_UNDEFINED;
> +    }
> +    return CP_ACCESS_OK;
> +}
> +
>  static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      Error *err = NULL;
> @@ -5335,11 +5369,11 @@ static const ARMCPRegInfo rndr_reginfo[] = {
>      { .name = "RNDR", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
>        .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 0,
> -      .access = PL0_R, .readfn = rndr_readfn },
> +      .access = PL0_R, .accessfn = access_rndr, .readfn = rndr_readfn },
>      { .name = "RNDRRS", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
>        .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 1,
> -      .access = PL0_R, .readfn = rndr_readfn },
> +      .access = PL0_R, .accessfn = access_rndr, .readfn = rndr_readfn },
>  };
>  
>  static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -6522,11 +6556,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_tid3,
>                .resetvalue = 0 },
> +            /*
> +             * ID_AA64ISAR0_EL1 is not a plain ARM_CP_CONST in system
> +             * emulation because the RNDR field depends on SCR_EL3.TRNDR
> +             * at read time when FEAT_RNG_TRAP is implemented.
> +             */
>              { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
> -              .access = PL1_R, .type = ARM_CP_CONST,
> +              .access = PL1_R,
> +#ifdef CONFIG_USER_ONLY
> +              .type = ARM_CP_CONST,
> +              .resetvalue = GET_IDREG(isar, ID_AA64ISAR0)
> +#else
> +              .type = ARM_CP_NO_RAW,
>                .accessfn = access_tid3,
> -              .resetvalue = GET_IDREG(isar, ID_AA64ISAR0)},
> +              .readfn = id_aa64isar0_read,
> +              .writefn = arm_cp_write_ignore
> +#endif
> +            },

A new assert() was triggered when booting guest on M1 since this change:

Assertion failed: (!(ri->type & ARM_CP_NO_RAW)), function hvf_arch_init_vcpu, file hvf.c, line 1442.

Thanks,
Zenghui

>              { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
>                .access = PL1_R, .type = ARM_CP_CONST,
> @@ -7454,7 +7501,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (cpu_isar_feature(aa64_pauth, cpu)) {
>          define_arm_cp_regs(cpu, pauth_reginfo);
>      }
> -    if (cpu_isar_feature(aa64_rndr, cpu)) {
> +    if (cpu_isar_feature(aa64_rndr, cpu) ||
> +        cpu_isar_feature(aa64_rng_trap, cpu)) {
>          define_arm_cp_regs(cpu, rndr_reginfo);
>      }
>      /* Data Cache clean instructions up to PoP */

