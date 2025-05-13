Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A794C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqfY-0003dB-6c; Tue, 13 May 2025 10:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqfW-0003c4-3D
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqfS-0007w1-9y
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747146697;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJnrKexwHwdXj+CB7Gav0WgyIYENhp5GhJAlL4b2KHY=;
 b=MpfryKzJHsSxaozgGP0S1dnBncbv9NmEDJhHokZJYWbIGynRgOqVgTm4ramOOa9VOUwelL
 kKKzM6G+gNyb87MlA2wGzqAMGlLydQAt2tuhlESaSmQPE2GfhGJPQUPztup85dd8Vvbxh3
 zEBsa548UdwK5RFqgkBqCuHpL+eWwjM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-c2DdhED0O2yDzrzq1RDQvw-1; Tue, 13 May 2025 10:31:35 -0400
X-MC-Unique: c2DdhED0O2yDzrzq1RDQvw-1
X-Mimecast-MFC-AGG-ID: c2DdhED0O2yDzrzq1RDQvw_1747146694
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so39817355e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747146694; x=1747751494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJnrKexwHwdXj+CB7Gav0WgyIYENhp5GhJAlL4b2KHY=;
 b=CvVTw4nBmd/LBxufHWIuIs5uzonqaHKQyhq6/T/ZCbrA/yR0I707i5/czqRcrVHkXs
 CfZbiWZMDdv0WWoIWz8f7K9tWHg4PWFrDNB2W1R0aU7tFWB7XvmDnbrcw6dQXswwuwk9
 lV1Vq5XcniEvuT5I54C0GvEfxyxOfs2GyK6becEyjHFRfYtqFq+Bxkdo/XHOlGhnczIE
 W6q0iHycx3hVfyiOZOHOvxyzr7QNv3xiEWNioxdBtMhy1g1aJqEpL0TGeWOLmc7qO8zn
 gGVQBWi4Zh7YROFEUTHiZ3IksYtbrgWCCZRk/xqIVFeSjoOrHn58/Yn0OPPQIPnAews4
 MtVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnjr0xMB2dJuVqhcKX7OnwotDEkQGCp+JqtfbJfUvmrqWSfyRGbYOcMltH2BNTeWt446mvPYOEbRMc@nongnu.org
X-Gm-Message-State: AOJu0YzNTkaoWKdVpcbNsCzU79CwBKLPx/opnLlshUcACrVkDcmwvr+U
 TLk1uZEP2v3qHTmjfCWgi0rj7JoxXYYhaG334tREXEyBu+wL9agnGcA0wexyH2qgI/SlAG5/Psw
 3L2SsAIpCWZByT83Ix5vKfCfenORNatS6ezhi6Tyq5z2WhLTqwgz+
X-Gm-Gg: ASbGncsOjVhO0gVDVKaLP1r5Llbic40wmLZ5nyR2tgiNolRjgMwyd2tRH9dP3WpLcku
 LEisMN/GC/9P/FHfkV+l8pgNnqLvSt2f1m5b1nFbRskkaAI+YG9u1zMMa5Newesv1p0e+J76sud
 3HswHhWxyoqr/oY+TY5WjluKr4CYoQUR397l4WRhXKHMimNMLR/j8EazF9q9Ap0EIA7ttP8Nfat
 ndC94HWAjlU3PpADPrRtgr9HJMUHcf/UUaR60kdI4eUF/yvBHESJOOgqfKLDqa76yiT5XoBX9K8
 Uj9ggDmhZje98xjuiLkipEH8BTy3ALI6nkigdxW4AA7G5+BDsEue5qFb9Ds=
X-Received: by 2002:a05:600c:8284:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-442d6dd2478mr127725815e9.20.1747146694232; 
 Tue, 13 May 2025 07:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFLJWt2QiNaKo97Dk/ZflyIag+3rx1lRvEaHhwYl2oiZBkI8lMmCjRt1/4I5/C2hIUHb2WNQ==
X-Received: by 2002:a05:600c:8284:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-442d6dd2478mr127725245e9.20.1747146693778; 
 Tue, 13 May 2025 07:31:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb6esm216527915e9.25.2025.05.13.07.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 07:31:33 -0700 (PDT)
Message-ID: <a706e9a2-0a49-4296-ba0a-8001f433b8b8@redhat.com>
Date: Tue, 13 May 2025 16:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] arm/kvm: Allow reading all the writable ID
 registers
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-7-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-7-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/14/25 6:38 PM, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> At the moment kvm_arm_get_host_cpu_features() reads a subset of the
> ID regs. As we want to introduce properties for all writable ID reg
> fields, we want more genericity and read more default host register
> values.
>
> Introduce a new get_host_cpu_idregs() helper and add a new exhaustive
> boolean parameter to kvm_arm_get_host_cpu_features() and
> kvm_arm_set_cpu_features_from_host() to select the right behavior.
> The host cpu model will keep the legacy behavior unless the writable
> id register interface is available.
>
> A writable_map IdRegMap is introduced in the CPU object. A subsequent
> patch will populate it.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu-sysregs.h |  2 ++
>  target/arm/cpu.h         |  3 ++
>  target/arm/cpu64.c       |  2 +-
>  target/arm/kvm.c         | 78 ++++++++++++++++++++++++++++++++++++++--
>  target/arm/kvm_arm.h     |  9 +++--
>  target/arm/trace-events  |  1 +
>  6 files changed, 89 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index e89a1105904c..367fab51f19e 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -41,6 +41,8 @@ int get_sysreg_idx(ARMSysRegs sysreg);
>  
>  #ifdef CONFIG_KVM
>  uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
> +int kvm_idx_to_idregs_idx(int kidx);
> +int idregs_idx_to_kvm_idx(ARMIDRegisterIdx idx);
>  #endif
>  
>  #endif /* ARM_CPU_SYSREGS_H */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 775a8aebc5d3..8717c5e7695b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1088,6 +1088,9 @@ struct ArchCPU {
>       */
>      ARMIdRegsState writable_id_regs;
>  
> +    /* ID reg writable bitmask (KVM only) */
> +    IdRegMap *writable_map;
as it is KVM only we may put it in ifdef CONFIG_KVM block above
> +
>      /* QOM property to indicate we should use the back-compat CNTFRQ default */
>      bool backcompat_cntfrq;
>  
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 839442745ea4..60a709502697 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -757,7 +757,7 @@ static void aarch64_host_initfn(Object *obj)
>  {
>  #if defined(CONFIG_KVM)
>      ARMCPU *cpu = ARM_CPU(obj);
> -    kvm_arm_set_cpu_features_from_host(cpu);
> +    kvm_arm_set_cpu_features_from_host(cpu, false);
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          aarch64_add_sve_properties(obj);
>          aarch64_add_pauth_properties(obj);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6e3cd06e9bc5..b07d5f16db50 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -41,6 +41,7 @@
>  #include "hw/acpi/ghes.h"
>  #include "target/arm/gtimer.h"
>  #include "migration/blocker.h"
> +#include "cpu-custom.h"
>  
>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>      KVM_CAP_INFO(DEVICE_CTRL),
> @@ -270,7 +271,73 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx i
>      return ret;
>  }
>  
> -static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> +int kvm_idx_to_idregs_idx(int kidx)
> +{
> +    int op1, crm, op2;
> +    ARMSysRegs sysreg;
> +
> +    op1 = kidx / 64;
> +    if (op1 == 2) {
> +        op1 = 3;
> +    }
> +    crm = (kidx % 64) / 8;
> +    op2 = kidx % 8;
> +    sysreg = ENCODE_ID_REG(3, op1, 0, crm, op2);
> +    return get_sysreg_idx(sysreg);
> +}
> +
> +int idregs_idx_to_kvm_idx(ARMIDRegisterIdx idx)
> +{
> +    ARMSysRegs sysreg = id_register_sysreg[idx];
> +
> +    return KVM_ARM_FEATURE_ID_RANGE_IDX((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
> +                                        (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK) >> CP_REG_ARM64_SYSREG_OP1_SHIFT,
> +                                        (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK) >> CP_REG_ARM64_SYSREG_CRN_SHIFT,
> +                                        (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK) >> CP_REG_ARM64_SYSREG_CRM_SHIFT,
> +                                        (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK) >> CP_REG_ARM64_SYSREG_OP2_SHIFT);
> +}
> +
> +
> +/*
> + * get_host_cpu_idregs: Read all the writable ID reg host values
> + *
> + * Need to be called once the writable mask has been populated
> + * Note we may want to read all the known id regs but some of them are not
> + * writable and return an error, hence the choice of reading only those which
> + * are writable. Those are also readable!
> + */
> +static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
> +{
> +    int err = 0;
> +    int i;
> +
> +    for (i = 0; i < NUM_ID_IDX; i++) {
> +        ARM64SysReg *sysregdesc = &arm64_id_regs[i];
> +        ARMSysRegs sysreg = sysregdesc->sysreg;
> +        uint64_t writable_mask = cpu->writable_map->regs[idregs_idx_to_kvm_idx(i)];
> +        uint64_t *reg;
> +        int ret;
> +
> +        if (!writable_mask) {
> +            continue;
> +        }
> +
> +        reg = &ahcf->isar.idregs[i];
> +        ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
> +        trace_get_host_cpu_idregs(sysregdesc->name, *reg);
> +        if (ret) {
> +            error_report("%s error reading value of host %s register (%m)",
> +                         __func__, sysregdesc->name);
> +
> +            err = ret;
> +        }
> +    }
> +    return err;
> +}
> +
> +static bool
> +kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf,
> +                              bool exhaustive)
maybe the exhaustive term shall be replaced by handle_writable_id_regs
which tells more explicitly what it does
>  {
>      /* Identify the feature bits corresponding to the host CPU, and
>       * fill out the ARMHostCPUClass fields accordingly. To do this
> @@ -398,6 +465,11 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          err |= get_host_cpu_reg(fd, ahcf, ID_DFR1_EL1_IDX);
>          err |= get_host_cpu_reg(fd, ahcf, ID_MMFR5_EL1_IDX);
>  
> +        /* Make sure writable ID reg values are read */
> +        if (exhaustive) {
> +            err |= get_host_cpu_idregs(cpu, fd, ahcf);
> +        }
> +
>          /*
>           * DBGDIDR is a bit complicated because the kernel doesn't
>           * provide an accessor for it in 64-bit mode, which is what this
> @@ -467,13 +539,13 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      return true;
>  }
>  
> -void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
> +void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu, bool exhaustive)
>  {
>      CPUARMState *env = &cpu->env;
>  
>      if (!arm_host_cpu_features.dtb_compatible) {
>          if (!kvm_enabled() ||
> -            !kvm_arm_get_host_cpu_features(&arm_host_cpu_features)) {
> +            !kvm_arm_get_host_cpu_features(cpu, &arm_host_cpu_features, exhaustive)) {
>              /* We can't report this error yet, so flag that we need to
>               * in arm_cpu_realizefn().
>               */
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 8d1f20ca8d89..90ba4f7d8987 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -141,8 +141,12 @@ uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu);
>   *
>   * Set up the ARMCPU struct fields up to match the information probed
>   * from the host CPU.
> + *
> + * @cpu: cpu object
> + * @exhaustive: if true, all the feature ID regs are queried instead of
s/queried/handled
> + *              a subset
>   */
> -void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
> +void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu, bool exhaustive);
>  
>  /**
>   * kvm_arm_add_vcpu_properties:
> @@ -257,7 +261,8 @@ static inline int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap)
>  /*
>   * These functions should never actually be called without KVM support.
>   */
> -static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
> +static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu,
> +                                                      bool exhaustive)
>  {
>      g_assert_not_reached();
>  }
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 4438dce7becc..17e52c0705f2 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -13,3 +13,4 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>  
>  # kvm.c
>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
> +get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64

Eric


