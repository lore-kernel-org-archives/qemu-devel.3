Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AA1D1CA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8AIL-0007HN-B1; Mon, 04 Nov 2024 22:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t8AIJ-0007H5-NL
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t8AIG-00009n-V9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730777507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4du7xPxKh9C6nfsFSpKflyJX39GLtxgu0BvYU9+NQU=;
 b=CozR4OhJVvyulgf/DdDKZLs8MnFNb102wjLM4ACkuz2hF8I4cir+wry4ZrPKPpqL2vXnwL
 z8fxkgRbbHzO4zFoqeFDHc14eV1VN2/WsCyCJMgjEnN0dt2DsxddSZzihr0I3dYLGD7wVK
 tt4BMozK245sWbXjHXS1UEGjoo+PO5g=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-E29oo7VsPPGHlBZ0U26qNA-1; Mon, 04 Nov 2024 22:31:46 -0500
X-MC-Unique: E29oo7VsPPGHlBZ0U26qNA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7e6cc094c2fso4499458a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 19:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730777505; x=1731382305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4du7xPxKh9C6nfsFSpKflyJX39GLtxgu0BvYU9+NQU=;
 b=s5zjTcJbeNt4GcEV/1ec1Z+130Td5YDIULq/iS4Vi4XaC3+bQKv68DV51xNB1jtbXf
 kjmAE6bOGBeHNdO8XTAcMhCc1FUSKmQLPw/GjSS5DRDgD2o1S0hKGtYhJ7IMjmQt7diA
 wsnQ3/uiYdHEk91OlZZwo4YmgJPvsHsdqf+yOMjP+3kFWZ9SGZ1McPh2vxi6ap5QLkop
 42BFXtqepGGao3EycXsxXvCODfh+iYDDkKm94ceLkQ9klxSNCUvX5hxiE4SSdiawrpWl
 HyiUgHWNAKTYzwhtqLTnfBuRWVnuEA9/8ye27ana4z6Yxv5Ru0Qz9XBheOC5aFimRTKv
 BScw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUntOxJYiKSKBn23tCWV+nkmP2h6AhOyeRRfr9hGsJhlauJX/7k3XVD9rHWeyRTY7OUbbq2Slqm7opQ@nongnu.org
X-Gm-Message-State: AOJu0Yzi14mpECocppYqMTuIMiEOGxG0QmAeDh4OJhlo+QjlXATzwE93
 BgL7LGfrG53xazJih6fLCpJZ5fCk2C6Z+KSA26k+iF1pMoTcAefkcu35BADD07roWdzY4vlUDbd
 mVXFDE8g5dgbPjizESeND5/M5wgNVjXATfdp2K6YMv47NLoTEHFUM
X-Received: by 2002:a05:6a20:4a07:b0:1d9:dc8:b80d with SMTP id
 adf61e73a8af0-1db95047b9dmr21237350637.20.1730777504501; 
 Mon, 04 Nov 2024 19:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdo7PaxL7l7hezg9/us3onCf/O6YapZMNLkm9/o4iAF1b+tGJ0PIRdHqtAFC2YINFeZrUONQ==
X-Received: by 2002:a05:6a20:4a07:b0:1d9:dc8:b80d with SMTP id
 adf61e73a8af0-1db95047b9dmr21237306637.20.1730777503904; 
 Mon, 04 Nov 2024 19:31:43 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.129])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc314670sm8462000b3a.191.2024.11.04.19.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 19:31:43 -0800 (PST)
Message-ID: <171f7b8a-0c3a-4f9e-b3e0-94ffbd279d19@redhat.com>
Date: Tue, 5 Nov 2024 13:31:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm-gicv3*: Refactor GICv3 CPU reginfo to have
 common invocation
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: jonathan.cameron@huawei.com, alex.bennee@linaro.org, imammedo@redhat.com, 
 pbonzini@redhat.com, maz@kernel.org, will@kernel.org,
 oliver.upton@linux.dev, jean-philippe@linaro.org, lpieralisi@kernel.org,
 david@redhat.com, philmd@linaro.org, andrew.jones@linux.dev,
 eric.auger@redhat.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com,
 gustavo.romero@linaro.org
References: <20241103152639.202480-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241103152639.202480-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/4/24 1:26 AM, Salil Mehta wrote:
> Refactor GICv3 code for TCG and KVM to initialize the GIC CPU interface
> register information by introducing a new common hook
> `ARMGICv3CommonClass::init_cpu_reginfo`. This hook can be assigned to
> the respective TCG or KVM variants during the GICv3 initialization
> phase and invoked during the GICv3 realization phase. The primary goals
> of this refactor include:
> 
> 1. Enhancing code modularity and reusability in future patch-sets.
> 2. Providing a common invocation function for TCG and KVM during GICv3
>     realization.
> 3. Improving code readability.
> 
> Note: This is a non-intrusive patch with *no* functional changes
>        intended. Code has been tested to confirm correct initialization
>        sequences across relevant scenarios.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/intc/arm_gicv3.c                |   1 +
>   hw/intc/arm_gicv3_cpuif.c          | 245 ++++++++++++++---------------
>   hw/intc/arm_gicv3_cpuif_common.c   |  10 ++
>   hw/intc/arm_gicv3_kvm.c            |  12 +-
>   hw/intc/gicv3_internal.h           |   1 +
>   include/hw/intc/arm_gicv3_common.h |   1 +
>   6 files changed, 140 insertions(+), 130 deletions(-)
> 

With the following nitpicks addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
> index 58e18fff54..2a30625916 100644
> --- a/hw/intc/arm_gicv3.c
> +++ b/hw/intc/arm_gicv3.c
> @@ -459,6 +459,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, void *data)
>       ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
>   
>       agcc->post_load = arm_gicv3_post_load;
> +    agcc->init_cpu_reginfo = gicv3_init_cpu_reginfo;
>       device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
>   }
>   
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index ea1d1b3455..75a06d6f28 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -3025,143 +3025,138 @@ static void gicv3_cpuif_el_change_hook(ARMCPU *cpu, void *opaque)
>       gicv3_cpuif_virt_irq_fiq_update(cs);
>   }
>   
> -void gicv3_init_cpuif(GICv3State *s)
> +void gicv3_init_cpu_reginfo(CPUState *cs)
>   {

Ideally, this function together with the dependent register information and
definitions can be moved to arm_gicv3.c where is the only place this function
is referred and used. In this way, gicv3_init_cpu_reginfo() becomes a static
function and needn't to be exported in gicv3_internal.h.

> -    /* Called from the GICv3 realize function; register our system
> -     * registers with the CPU
> -     */
> -    int i;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    GICv3CPUState *gcs = icc_cs_from_env(&cpu->env);
>   
> -    for (i = 0; i < s->num_cpu; i++) {
> -        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
> -        GICv3CPUState *cs = &s->cpu[i];
> +    /*
> +     * If the CPU doesn't define a GICv3 configuration, probably because
> +     * in real hardware it doesn't have one, then we use default values
> +     * matching the one used by most Arm CPUs. This applies to:
> +     *  cpu->gic_num_lrs
> +     *  cpu->gic_vpribits
> +     *  cpu->gic_vprebits
> +     *  cpu->gic_pribits
> +     */
>   
> -        /*
> -         * If the CPU doesn't define a GICv3 configuration, probably because
> -         * in real hardware it doesn't have one, then we use default values
> -         * matching the one used by most Arm CPUs. This applies to:
> -         *  cpu->gic_num_lrs
> -         *  cpu->gic_vpribits
> -         *  cpu->gic_vprebits
> -         *  cpu->gic_pribits
> -         */
> +    /*
> +     * Note that we can't just use the GICv3CPUState as an opaque pointer
> +     * in define_arm_cp_regs_with_opaque(), because when we're called back
> +     * it might be with code translated by CPU 0 but run by CPU 1, in
> +     * which case we'd get the wrong value.
> +     * So instead we define the regs with no ri->opaque info, and
> +     * get back to the GICv3CPUState from the CPUARMState.
> +     *
> +     * These CP regs callbacks can be called from either TCG or HVF code.
> +     */
> +    define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
>   
> -        /* Note that we can't just use the GICv3CPUState as an opaque pointer
> -         * in define_arm_cp_regs_with_opaque(), because when we're called back
> -         * it might be with code translated by CPU 0 but run by CPU 1, in
> -         * which case we'd get the wrong value.
> -         * So instead we define the regs with no ri->opaque info, and
> -         * get back to the GICv3CPUState from the CPUARMState.
> -         *
> -         * These CP regs callbacks can be called from either TCG or HVF code.
> -         */
> -        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
> +    /*
> +     * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
> +     * implement FEAT_GICv3_NMI, which is the CPU interface part
> +     * of NMI support. This is distinct from whether the GIC proper
> +     * (redistributors and distributor) have NMI support. In QEMU
> +     * that is a property of the GIC device in s->nmi_support;
> +     * cs->nmi_support indicates the CPU interface's support.
> +     */
> +    if (cpu_isar_feature(aa64_nmi, cpu)) {
> +        gcs->nmi_support = true;
> +        define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
> +    }
>   
> -        /*
> -         * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
> -         * implement FEAT_GICv3_NMI, which is the CPU interface part
> -         * of NMI support. This is distinct from whether the GIC proper
> -         * (redistributors and distributor) have NMI support. In QEMU
> -         * that is a property of the GIC device in s->nmi_support;
> -         * cs->nmi_support indicates the CPU interface's support.
> -         */
> -        if (cpu_isar_feature(aa64_nmi, cpu)) {
> -            cs->nmi_support = true;
> -            define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
> -        }
> +    /*
> +     * The CPU implementation specifies the number of supported
> +     * bits of physical priority. For backwards compatibility
> +     * of migration, we have a compat property that forces use
> +     * of 8 priority bits regardless of what the CPU really has.
> +     */
> +    if (gcs->gic->force_8bit_prio) {
> +        gcs->pribits = 8;
> +    } else {
> +        gcs->pribits = cpu->gic_pribits ?: 5;
> +    }
>   
> -        /*
> -         * The CPU implementation specifies the number of supported
> -         * bits of physical priority. For backwards compatibility
> -         * of migration, we have a compat property that forces use
> -         * of 8 priority bits regardless of what the CPU really has.
> -         */
> -        if (s->force_8bit_prio) {
> -            cs->pribits = 8;
> -        } else {
> -            cs->pribits = cpu->gic_pribits ?: 5;
> -        }
> +    /*
> +     * The GICv3 has separate ID register fields for virtual priority
> +     * and preemption bit values, but only a single ID register field
> +     * for the physical priority bits. The preemption bit count is
> +     * always the same as the priority bit count, except that 8 bits
> +     * of priority means 7 preemption bits. We precalculate the
> +     * preemption bits because it simplifies the code and makes the
> +     * parallels between the virtual and physical bits of the GIC
> +     * a bit clearer.
> +     */
> +    gcs->prebits = gcs->pribits;
> +    if (gcs->prebits == 8) {
> +        gcs->prebits--;
> +    }
> +    /*
> +     * Check that CPU code defining pribits didn't violate
> +     * architectural constraints our implementation relies on.
> +     */
> +    g_assert(gcs->pribits >= 4 && gcs->pribits <= 8);
>   
> -        /*
> -         * The GICv3 has separate ID register fields for virtual priority
> -         * and preemption bit values, but only a single ID register field
> -         * for the physical priority bits. The preemption bit count is
> -         * always the same as the priority bit count, except that 8 bits
> -         * of priority means 7 preemption bits. We precalculate the
> -         * preemption bits because it simplifies the code and makes the
> -         * parallels between the virtual and physical bits of the GIC
> -         * a bit clearer.
> -         */
> -        cs->prebits = cs->pribits;
> -        if (cs->prebits == 8) {
> -            cs->prebits--;
> -        }
> -        /*
> -         * Check that CPU code defining pribits didn't violate
> -         * architectural constraints our implementation relies on.
> -         */
> -        g_assert(cs->pribits >= 4 && cs->pribits <= 8);
> +    /*
> +     * gicv3_cpuif_reginfo[] defines ICC_AP*R0_EL1; add definitions
> +     * for ICC_AP*R{1,2,3}_EL1 if the prebits value requires them.
> +     */
> +    if (gcs->prebits >= 6) {
> +        define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr1_reginfo);
> +    }
> +    if (gcs->prebits == 7) {
> +        define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr23_reginfo);
> +    }
>   
> -        /*
> -         * gicv3_cpuif_reginfo[] defines ICC_AP*R0_EL1; add definitions
> -         * for ICC_AP*R{1,2,3}_EL1 if the prebits value requires them.
> -         */
> -        if (cs->prebits >= 6) {
> -            define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr1_reginfo);
> -        }
> -        if (cs->prebits == 7) {
> -            define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr23_reginfo);
> -        }
> +    if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
> +        int j;
>   
> -        if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
> -            int j;
> +        gcs->num_list_regs = cpu->gic_num_lrs ?: 4;
> +        gcs->vpribits = cpu->gic_vpribits ?: 5;
> +        gcs->vprebits = cpu->gic_vprebits ?: 5;
>   
> -            cs->num_list_regs = cpu->gic_num_lrs ?: 4;
> -            cs->vpribits = cpu->gic_vpribits ?: 5;
> -            cs->vprebits = cpu->gic_vprebits ?: 5;
>   
> -            /* Check against architectural constraints: getting these
> -             * wrong would be a bug in the CPU code defining these,
> -             * and the implementation relies on them holding.
> -             */
> -            g_assert(cs->vprebits <= cs->vpribits);
> -            g_assert(cs->vprebits >= 5 && cs->vprebits <= 7);
> -            g_assert(cs->vpribits >= 5 && cs->vpribits <= 8);
> +        /* Check against architectural constraints: getting these
> +         * wrong would be a bug in the CPU code defining these,
> +         * and the implementation relies on them holding.
> +         */
> +        g_assert(gcs->vprebits <= gcs->vpribits);
> +        g_assert(gcs->vprebits >= 5 && gcs->vprebits <= 7);
> +        g_assert(gcs->vpribits >= 5 && gcs->vpribits <= 8);
>   

[gshan@gshan q]$ ./scripts/checkpatch.pl --codespell patch/check/0003*
WARNING: Block comments use a leading /* on a separate line
#240: FILE: hw/intc/arm_gicv3_cpuif.c:3119:
+        /* Check against architectural constraints: getting these

> -            define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
> +        define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
>   
> -            for (j = 0; j < cs->num_list_regs; j++) {
> -                /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
> -                 * are split into two cp15 regs, LR (the low part, with the
> -                 * same encoding as the AArch64 LR) and LRC (the high part).
> -                 */
> -                ARMCPRegInfo lr_regset[] = {
> -                    { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
> -                      .opc0 = 3, .opc1 = 4, .crn = 12,
> -                      .crm = 12 + (j >> 3), .opc2 = j & 7,
> -                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
> -                      .nv2_redirect_offset = 0x400 + 8 * j,
> -                      .access = PL2_RW,
> -                      .readfn = ich_lr_read,
> -                      .writefn = ich_lr_write,
> -                    },
> -                    { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
> -                      .cp = 15, .opc1 = 4, .crn = 12,
> -                      .crm = 14 + (j >> 3), .opc2 = j & 7,
> -                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
> -                      .access = PL2_RW,
> -                      .readfn = ich_lr_read,
> -                      .writefn = ich_lr_write,
> -                    },
> -                };
> -                define_arm_cp_regs(cpu, lr_regset);
> -            }
> -            if (cs->vprebits >= 6) {
> -                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
> -            }
> -            if (cs->vprebits == 7) {
> -                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
> -            }
> +        for (j = 0; j < gcs->num_list_regs; j++) {
> +            /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
> +             * are split into two cp15 regs, LR (the low part, with the
> +             * same encoding as the AArch64 LR) and LRC (the high part).
> +             */
> +            ARMCPRegInfo lr_regset[] = {
> +                { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
> +                  .opc0 = 3, .opc1 = 4, .crn = 12,
> +                  .crm = 12 + (j >> 3), .opc2 = j & 7,
> +                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
> +                  .nv2_redirect_offset = 0x400 + 8 * j,
> +                  .access = PL2_RW,
> +                  .readfn = ich_lr_read,
> +                  .writefn = ich_lr_write,
> +                },
> +                { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
> +                  .cp = 15, .opc1 = 4, .crn = 12,
> +                  .crm = 14 + (j >> 3), .opc2 = j & 7,
> +                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
> +                  .access = PL2_RW,
> +                  .readfn = ich_lr_read,
> +                  .writefn = ich_lr_write,
> +                },
> +            };
> +            define_arm_cp_regs(cpu, lr_regset);
> +        }

[gshan@gshan q]$ ./scripts/checkpatch.pl --codespell patch/check/0003*
WARNING: Block comments use a leading /* on a separate line
#284: FILE: hw/intc/arm_gicv3_cpuif.c:3130:
+            /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs

> +        if (gcs->vprebits >= 6) {
> +            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
> +        }
> +        if (gcs->vprebits == 7) {
> +            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
>           }
>           if (tcg_enabled() || qtest_enabled()) {
>               /*
> @@ -3169,7 +3164,7 @@ void gicv3_init_cpuif(GICv3State *s)
>                * state only changes on EL changes involving EL2 or EL3, so for
>                * the non-TCG case this is OK, as EL2 and EL3 can't exist.
>                */
> -            arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, cs);
> +            arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, gcs);
>           } else {
>               assert(!arm_feature(&cpu->env, ARM_FEATURE_EL2));
>               assert(!arm_feature(&cpu->env, ARM_FEATURE_EL3));
> diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
> index ff1239f65d..f4d5ca447b 100644
> --- a/hw/intc/arm_gicv3_cpuif_common.c
> +++ b/hw/intc/arm_gicv3_cpuif_common.c
> @@ -20,3 +20,13 @@ void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
>   
>       env->gicv3state = (void *)s;
>   };
> +
> +void gicv3_init_cpuif(GICv3State *s)
> +{
> +    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_GET_CLASS(s);
> +
> +    /* define and register `system registers` with the vCPU  */
> +    for (int i = 0; i < s->num_cpu; i++) {
> +        agcc->init_cpu_reginfo(s->cpu[i].cpu);
> +    }
> +}
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 9ea6b8e218..b4128786ca 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -777,6 +777,10 @@ static void vm_change_state_handler(void *opaque, bool running,
>       }
>   }
>   
> +static void kvm_gicv3_init_cpu_reginfo(CPUState *cs)
> +{
> +    define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
> +}
>   
>   static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>   {
> @@ -812,11 +816,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>   
>       gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
>   
> -    for (i = 0; i < s->num_cpu; i++) {
> -        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
> -
> -        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
> -    }
> +    /* Initialize vCPU interface */
> +    gicv3_init_cpuif(s);
>   
>       /* Try to create the device via the device control API */
>       s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> @@ -902,6 +903,7 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
>   
>       agcc->pre_save = kvm_arm_gicv3_get;
>       agcc->post_load = kvm_arm_gicv3_put;
> +    agcc->init_cpu_reginfo = kvm_gicv3_init_cpu_reginfo;
>       device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
>                                       &kgc->parent_realize);
>       resettable_class_set_parent_phases(rc, NULL, kvm_arm_gicv3_reset_hold, NULL,
> diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
> index bc9f518fe8..cc8edc499b 100644
> --- a/hw/intc/gicv3_internal.h
> +++ b/hw/intc/gicv3_internal.h
> @@ -722,6 +722,7 @@ void gicv3_redist_vinvall(GICv3CPUState *cs, uint64_t vptaddr);
>   
>   void gicv3_redist_send_sgi(GICv3CPUState *cs, int grp, int irq, bool ns);
>   void gicv3_init_cpuif(GICv3State *s);
> +void gicv3_init_cpu_reginfo(CPUState *cs);
>   
>   /**
>    * gicv3_cpuif_update:
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index cd09bee3bc..7171f770e4 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -338,6 +338,7 @@ struct ARMGICv3CommonClass {
>   
>       void (*pre_save)(GICv3State *s);
>       void (*post_load)(GICv3State *s);
> +    void (*init_cpu_reginfo)(CPUState *cs);
>   };
>   
>   void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,

Thanks,
Gavin


