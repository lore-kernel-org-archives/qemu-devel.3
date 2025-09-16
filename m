Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF85DCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 11:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyU5E-0000ZK-HC; Tue, 16 Sep 2025 07:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1uyU56-0000U3-Fo
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:42:45 -0400
Received: from sg-1-12.ptr.blmpb.com ([118.26.132.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1uyU4t-0003PK-2l
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1758022927;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=zAIkPCtH5/gSXDqa9mtSDLXkEaENTX70VnPZtF+PJjQ=;
 b=Hv/ezAbHkwR6Te0IelU8DhmdPWKybkyZ7VNOWu8NCeSc/fwqHUHj2BgrbciZ3cwn0I+VAl
 fEPYLuYgQRDDL1zfavexbrDMXGpJsz2cyEywULdExtUZkt3k+oaTwC763B+mqWjH3o2TlS
 f19u1ZVAo4Nkm/FtiH2YnPKW6F6QXqLK08Gytevw5TBsRBQ4WU3+AXbEVWoLZNzZ3kiMjV
 wMDePorETHc5+/WGaC0pJd8Fi1nRYgosCd8YfnzcvWQ0+he1SNlrcagUCYmO3fI9TMVdKU
 gmCMSWalKFg71u21BkaBeOJNBucCIvapnvpkCN7ExFfBB1gSXvMzrG+byKIapw==
Cc: <qemu-riscv@nongnu.org>, <zhiwei_liu@linux.alibaba.com>, 
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, 
 <alistair.francis@wdc.com>, <palmer@dabbelt.com>
Date: Tue, 16 Sep 2025 19:42:03 +0800
Content-Language: en-US
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Subject: Re: [PATCH] target/riscv/kvm: Sync vCPU mp_state for migration
References: <20250916104843.1953-1-xiangwencheng@lanxincomputing.com>
Received: from [127.0.0.1] ([222.128.9.250]) by smtp.feishu.cn with ESMTPS;
 Tue, 16 Sep 2025 19:42:04 +0800
X-Lms-Return-Path: <lba+268c94d0d+2e9ccc+nongnu.org+xiangwencheng@lanxincomputing.com>
To: <qemu-devel@nongnu.org>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Message-Id: <5716dba7-eba3-4e25-8479-3b7218c66ea5@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <20250916104843.1953-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.12;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=sg-1-12.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi all, sorry for bothering. I just noticed that
Xie Bo <xb@ultrarisc.com> is already working on this.

On 9/16/2025 6:48 PM, BillXiang wrote:
> Fix secondary vCPUs(id > 0) stall after migration.
> 
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>   target/riscv/cpu.h           |  3 +++
>   target/riscv/kvm/kvm-cpu.c   | 34 ++++++++++++++++++++++++++--------
>   target/riscv/kvm/kvm_riscv.h |  3 ++-
>   target/riscv/machine.c       | 30 ++++++++++++++++++++++++++++++
>   4 files changed, 61 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..4290229c56 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -20,6 +20,7 @@
>   #ifndef RISCV_CPU_H
>   #define RISCV_CPU_H
>   
> +#include <linux/kvm.h>
>   #include "hw/core/cpu.h"
>   #include "hw/registerfields.h"
>   #include "hw/qdev-properties.h"
> @@ -546,6 +547,8 @@ struct ArchCPU {
>       RISCVCPUConfig cfg;
>       RISCVSATPModes satp_modes;
>   
> +    struct kvm_mp_state mp_state;
> +
>       QEMUTimer *pmu_timer;
>       /* A bitmask of Available programmable counters */
>       uint32_t pmu_avail_ctrs;
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5c19062c19..f0a97293f9 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1348,17 +1348,16 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>           return ret;
>       }
>   
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    ret = kvm_riscv_sync_mpstate_to_qemu(cpu);
> +
>       return ret;
>   }
>   
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
> +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu)
>   {
>       if (cap_has_mp_state) {
> -        struct kvm_mp_state mp_state = {
> -            .mp_state = state
> -        };
> -
> -        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
> +        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &cpu->mp_state);
>           if (ret) {
>               fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
>                       __func__, ret, strerror(-ret));
> @@ -1369,6 +1368,17 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
>       return 0;
>   }
>   
> +int kvm_riscv_sync_mpstate_to_qemu(RISCVCPU *cpu)
> +{
> +    if (cap_has_mp_state) {
> +        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &cpu->mp_state);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
>   int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
>   {
>       int ret = 0;
> @@ -1396,13 +1406,21 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
>       if (KVM_PUT_RESET_STATE == level) {
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           if (cs->cpu_index == 0) {
> -            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
> +            cpu->mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
> +            ret = kvm_riscv_sync_mpstate_to_kvm(cpu);
>           } else {
> -            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
> +            cpu->mp_state.mp_state = KVM_MP_STATE_STOPPED;
> +            ret = kvm_riscv_sync_mpstate_to_kvm(cpu);
>           }
>           if (ret) {
>               return ret;
>           }
> +    } else if (KVM_PUT_FULL_STATE == level) {
> +        RISCVCPU *cpu = RISCV_CPU(cs);
> +        ret = kvm_riscv_sync_mpstate_to_kvm(cpu);
> +        if (ret) {
> +            return ret;
> +        }
>       }
>   
>       return ret;
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index b2bcd1041f..770f58bf0a 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -28,7 +28,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num);
>   void riscv_kvm_aplic_request(void *opaque, int irq, int level);
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
> +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu);
> +int kvm_riscv_sync_mpstate_to_qemu(RISCVCPU *cpu);
>   void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>   uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
>   
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 1600ec44f0..178ae6a3a0 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -251,6 +251,28 @@ static const VMStateDescription vmstate_debug = {
>       }
>   };
>   
> +static int get_mp_state(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field)
> +{
> +    RISCVCPU *cpu = opaque;
> +    cpu->mp_state.mp_state = qemu_get_be32(f);
> +    return 0;
> +}
> +
> +static int put_mp_state(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    RISCVCPU *cpu = opaque;
> +    qemu_put_be32(f, cpu->mp_state.mp_state);
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_mp_state = {
> +    .name = "mp_state",
> +    .get = get_mp_state,
> +    .put = put_mp_state,
> +};
> +
>   static int riscv_cpu_post_load(void *opaque, int version_id)
>   {
>       RISCVCPU *cpu = opaque;
> @@ -457,6 +479,14 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINTTL(env.sscratch, RISCVCPU),
>           VMSTATE_UINTTL(env.mscratch, RISCVCPU),
>           VMSTATE_UINT64(env.stimecmp, RISCVCPU),
> +        {
> +            .name = "mp_state",
> +            .version_id = 0,
> +            .size = sizeof(bool),
> +            .info = &vmstate_mp_state,
> +            .flags = VMS_SINGLE,
> +            .offset = 0,
> +        },
>   
>           VMSTATE_END_OF_LIST()
>       },

