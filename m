Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE39CDD554
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 03:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr7l3-0000TM-7t; Wed, 18 Sep 2024 23:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sr7l0-0000Qg-Tv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 23:23:02 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sr7ky-0006iT-HC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 23:23:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7191f58054aso305385b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 20:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726716179; x=1727320979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q4JlnRf+sH8eouq6eUmmXaWchAjLldxPWsjwU8cMKxg=;
 b=WQZ65PNs62yYNqLAxpUJRBlpKtIn+IixPEDJRiJq+o+xDXiWBnthP9lS/zda34K6G/
 +SJuRyICLzrMhyPnfOldQ7bXCX1EzPC0YTfhLGDGfi/n9Uth2RyQ1BtfoFcRRICyz2Bj
 xQJ7AAN/ZZrlbNJiG61r6P2vPxKCPS/ViwXQU0IWbCro71lIXboR5WwVcSVMA8ZmI6Tv
 4eV/BU3i3yMCd/vKoBTCJCeLjMFop053pBltEJbIqlcTWMej4RNhmtsh5cEQUPd7ZVTD
 JzWN8oBmQOLeS20I01vUxJGxyt1uD+9gAmdIvha0x80rwngj0tvDOu4MEfczv8p92Bhp
 kZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726716179; x=1727320979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q4JlnRf+sH8eouq6eUmmXaWchAjLldxPWsjwU8cMKxg=;
 b=tJij9Xx+0u9fq81+nYt/5kzbmEe0kwwBDnVK62Oo7Oe5Xo4NnMCN1dFm3SKAS/pd6c
 K+ZtS/+fRL4T2QDBot73DbPczSienxFNIa6U17mtIfkd3t/F9vyvZMutVp3u9DTcW6tl
 A05cQZwCLjdrcGgXFxFSR9w18uXQrV8f5d1FvjbiszQUljYIKw9/eNt1lzcUxbr03V+S
 P7RLGsqNfFXeJylZl1fba2/NYs0ydwh2DZh4rwUwVoUbLr7xeEWKxvDkX+9gLKXcTdpQ
 hcKNstxzaj26gXZe+SQ53UA3q6SZNp9/FRqd3Dh7QNLthXH6FsTQeG/5rjXjwRt240xm
 f64w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0EdeFuGi6B6PymXgpVntll6TkM0ZWZP+fg/sDHJkGqxHfV3ZbO04dqMexlpWQh51DVBGevYDju7xj@nongnu.org
X-Gm-Message-State: AOJu0Yx9TzpMKQzj9v4toRw5vCNnYLtT9SgxhL+5k/Tm89PcNDk4tjBt
 /t5HEZOJCDhfJ9OWFlwle0+GgB5DpGYZkpaizb2SkVqJ1dKgQwW2YsVNwazGFeY=
X-Google-Smtp-Source: AGHT+IER8vk7VNwH0jakUaiaKB5bHqzns1GxQE7Z/Bxv2Y4wh0eEixI3JmItxHLLPwPvFbdzocsz3g==
X-Received: by 2002:a05:6a00:2daa:b0:717:9154:b5b6 with SMTP id
 d2e1a72fcca58-7192606ce9emr38653960b3a.7.1726716178457; 
 Wed, 18 Sep 2024 20:22:58 -0700 (PDT)
Received: from [192.168.0.101] ([187.75.38.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944b7afaesm7349289b3a.130.2024.09.18.20.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 20:22:57 -0700 (PDT)
Message-ID: <0faf9a7c-0400-482c-974f-7b70e1d58202@linaro.org>
Date: Thu, 19 Sep 2024 00:22:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm/kvm: add support for MTE
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, darren@os.amperecomputing.com
References: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x432.google.com
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

Hi Ganapatrao,

On 9/12/24 06:16, Ganapatrao Kulkarni wrote:
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable
> the capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
> which broke TCG since it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
> Changes since V1:
> 	Added code to enable MTE before reading register
> id_aa64pfr1 (unmasked MTE bits).
>
> This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
> and default case(i.e, no mte).
>
>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>   target/arm/cpu.c     |  7 +++--
>   target/arm/cpu.h     |  2 ++
>   target/arm/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++
>   target/arm/kvm_arm.h | 19 ++++++++++++
>   5 files changed, 126 insertions(+), 33 deletions(-)

Overall the patch looks good. I just have a couple of questions.


> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7934b23651..a33af7d996 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2211,7 +2211,7 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
> +    if (vms->mte && hvf_enabled()) {
>           error_report("mach-virt: %s does not support providing "
>                        "MTE to the guest CPU",
>                        current_accel_name());
> @@ -2281,39 +2281,51 @@ static void machvirt_init(MachineState *machine)
>           }
>   
>           if (vms->mte) {
> -            /* Create the memory region only once, but link to all cpus. */
> -            if (!tag_sysmem) {
> -                /*
> -                 * The property exists only if MemTag is supported.
> -                 * If it is, we must allocate the ram to back that up.
> -                 */
> -                if (!object_property_find(cpuobj, "tag-memory")) {
> -                    error_report("MTE requested, but not supported "
> -                                 "by the guest CPU");
> -                    exit(1);
> +            if (tcg_enabled()) {
> +                /* Create the memory region only once, but link to all cpus. */
> +                if (!tag_sysmem) {
> +                    /*
> +                     * The property exists only if MemTag is supported.
> +                     * If it is, we must allocate the ram to back that up.
> +                     */
> +                    if (!object_property_find(cpuobj, "tag-memory")) {
> +                        error_report("MTE requested, but not supported "
> +                                     "by the guest CPU");
> +                        exit(1);
> +                    }
> +
> +                    tag_sysmem = g_new(MemoryRegion, 1);
> +                    memory_region_init(tag_sysmem, OBJECT(machine),
> +                                       "tag-memory", UINT64_MAX / 32);
> +
> +                    if (vms->secure) {
> +                        secure_tag_sysmem = g_new(MemoryRegion, 1);
> +                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
> +                                           "secure-tag-memory",
> +                                           UINT64_MAX / 32);
> +
> +                        /* As with ram, secure-tag takes precedence over tag. */
> +                        memory_region_add_subregion_overlap(secure_tag_sysmem,
> +                                                            0, tag_sysmem, -1);
> +                    }
>                   }
>   
> -                tag_sysmem = g_new(MemoryRegion, 1);
> -                memory_region_init(tag_sysmem, OBJECT(machine),
> -                                   "tag-memory", UINT64_MAX / 32);
> -
> +                object_property_set_link(cpuobj, "tag-memory",
> +                                         OBJECT(tag_sysmem), &error_abort);
>                   if (vms->secure) {
> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
> -                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
> -                                       "secure-tag-memory", UINT64_MAX / 32);
> -
> -                    /* As with ram, secure-tag takes precedence over tag.  */
> -                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> -                                                        tag_sysmem, -1);
> +                    object_property_set_link(cpuobj, "secure-tag-memory",
> +                                             OBJECT(secure_tag_sysmem),
> +                                             &error_abort);
>                   }
> -            }
> -
> -            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
> -                                     &error_abort);
> -            if (vms->secure) {
> -                object_property_set_link(cpuobj, "secure-tag-memory",
> -                                         OBJECT(secure_tag_sysmem),
> -                                         &error_abort);
> +            } else if (kvm_enabled()) {
> +                if (!kvm_arm_mte_supported()) {
> +                    error_report("MTE requested, but not supported by KVM");
> +                    exit(1);
> +                }
> +                kvm_arm_enable_mte(cpuobj, &error_abort);
> +            } else {
> +                    error_report("MTE requested, but not supported ");
> +                    exit(1);
>               }
>           }
>   
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 19191c2391..a59417aac8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2390,11 +2390,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>   #ifndef CONFIG_USER_ONLY
>           /*
> -         * If we do not have tag-memory provided by the machine,
> -         * reduce MTE support to instructions enabled at EL0.
> +         * If we do not have tag-memory provided by the TCG
> +         * nor MTE at KVM enabled, reduce MTE support to
> +         * instructions enabled at EL0.

What controls if MTE insns. (stg, etc.) are enabled on EL0 and EL1

are the ATA and ATA0 bits in SCTRL register. Also, AA64PFR1 is a

register just to report the features available on the CPU, so I

wonder if that comment is indeed correct.

@rth: what do you think?


>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>            */
> -        if (cpu->tag_memory == NULL) {
> +        if (cpu->tag_memory == NULL && !cpu->kvm_mte) {
>               cpu->isar.id_aa64pfr1 =
>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>           }

If MTE is off on TGC and on KVM, then we're actually setting (deposit) MTE

field in AA64PFR1, meaning that MTE is implemented? or am I missing

something?


> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f065756c5c..8fc8b6398f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -922,6 +922,8 @@ struct ArchCPU {
>   
>       /* CPU has memory protection unit */
>       bool has_mpu;
> +    /* CPU has MTE enabled in KVM mode */
> +    bool kvm_mte;
>       /* PMSAv7 MPU number of supported regions */
>       uint32_t pmsav7_dregion;
>       /* PMSAv8 MPU number of supported hyp regions */
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 849e2e21b3..29865609fb 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -39,6 +39,7 @@
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/ghes.h"
>   #include "target/arm/gtimer.h"
> +#include "migration/blocker.h"
>   
>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
> @@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>       if (vmfd < 0) {
>           goto err;
>       }
> +
> +    /*
> +     * MTE bits of register id_aa64pfr1 are masked if MTE is
> +     * not enabled and required to enable before VCPU
> +     * is created. Hence enable MTE(if supported) before VCPU
> +     * is created to read unmasked MTE bits.
> +     */
> +    if (kvm_arm_mte_supported()) {
> +        KVMState kvm_state;
> +
> +        kvm_state.fd = kvmfd;
> +        kvm_state.vmfd = vmfd;
> +        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
> +    }
> +
>       cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>       if (cpufd < 0) {
>           goto err;
> @@ -1793,6 +1809,11 @@ bool kvm_arm_sve_supported(void)
>       return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
>   }
>   
> +bool kvm_arm_mte_supported(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
> +}
> +
>   QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
>   
>   uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
> @@ -2417,3 +2438,41 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       }
>       return 0;
>   }
> +
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    static bool tried_to_enable;
> +    static bool succeeded_to_enable;
> +    Error *mte_migration_blocker = NULL;
> +    ARMCPU *cpu = ARM_CPU(cpuobj);
> +    int ret;
> +
> +    if (!tried_to_enable) {
> +        /*
> +         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
> +         * sense), and we only want a single migration blocker as well.
> +         */
> +        tried_to_enable = true;
> +
> +        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
> +            return;
> +        }
> +
> +        /* TODO: Add migration support with MTE enabled */
> +        error_setg(&mte_migration_blocker,
> +                   "Live migration disabled due to MTE enabled");
> +        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
> +            error_free(mte_migration_blocker);
> +            return;
> +        }
> +
> +        succeeded_to_enable = true;
> +    }
> +
> +    if (succeeded_to_enable) {
> +        cpu->kvm_mte = true;
> +    }
> +}
> +

nit: remove ending blank line here.


Cheers,

Gustavo


> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index cfaa0d9bc7..4d293618a7 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -188,6 +188,13 @@ bool kvm_arm_pmu_supported(void);
>    */
>   bool kvm_arm_sve_supported(void);
>   
> +/**
> + * kvm_arm_mte_supported:
> + *
> + * Returns: true if KVM can enable MTE, and false otherwise.
> + */
> +bool kvm_arm_mte_supported(void);
> +
>   /**
>    * kvm_arm_get_max_vm_ipa_size:
>    * @ms: Machine state handle
> @@ -214,6 +221,8 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
>   
>   int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
>   
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
> +
>   #else
>   
>   /*
> @@ -235,6 +244,11 @@ static inline bool kvm_arm_sve_supported(void)
>       return false;
>   }
>   
> +static inline bool kvm_arm_mte_supported(void)
> +{
> +    return false;
> +}
> +
>   /*
>    * These functions should never actually be called without KVM support.
>    */
> @@ -283,6 +297,11 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
>       g_assert_not_reached();
>   }
>   
> +static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> +
>   #endif
>   
>   #endif

