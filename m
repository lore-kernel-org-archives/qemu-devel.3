Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817BCFA3728
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 08:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbaie-00068H-7i; Fri, 02 Jan 2026 03:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vbaib-00067O-BB; Fri, 02 Jan 2026 03:41:10 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vbaiY-00059A-1t; Fri, 02 Jan 2026 03:41:08 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6028YCKL019171
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 2 Jan 2026 17:35:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5wM7K0zT0TfD9YB03Fc86GQdnMiyrWwYJskPedYp2D4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1767342902; v=1;
 b=IXLXwK7hBn6rUhR5c1YoQWlKVBjVg9rpN9FDbXeNuhwUVbJm4HecN34+jNUH1JSE
 X76hPtUjJpkYNAQHswsuLY87GiYNWJj8uEdSPk/GIsCGf4dBdxLKXtYHmADGW9yL
 bf925vLHRTzixlbixV0wperXUt6eSXBXT3d5Nntaa1qk0pIBpRpGFBkQxKE44abe
 ZXZYwVZXg6J121BNswYnfIzj86/nRhdsOW5Zg7HYluA0KmMo+ctAKeXY4kqWSrox
 I8WR/vyl4jo4j7Bnof4vpdpCrehEyHk7Fvy/SUA60QnmdxfCVeoamtJ3yT8rTppF
 TyFE/E0pqtBMv+yv6JSoLg==
Message-ID: <6733ce8c-6d9b-49a7-9286-bedc758de51a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 2 Jan 2026 17:34:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 19/28] whpx: arm64: clamp down IPA size
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
 <20251230000401.72124-20-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251230000401.72124-20-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/30 9:03, Mohamed Mediouni wrote:
> Code taken from HVF and adapted for WHPX use. Note that WHPX doesn't
> have a default vs maximum IPA distinction.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/virt.c               | 32 ++++++++++++++++++++++++++
>   include/hw/core/boards.h    |  1 +
>   target/arm/whpx/meson.build |  2 ++
>   target/arm/whpx/whpx-all.c  | 45 +++++++++++++++++++++++++++++++++++++
>   target/arm/whpx/whpx-stub.c | 15 +++++++++++++
>   target/arm/whpx_arm.h       | 16 +++++++++++++

Better named as "whpx-arm.h" for consistency.

>   6 files changed, 111 insertions(+)
>   create mode 100644 target/arm/whpx/whpx-stub.c
>   create mode 100644 target/arm/whpx_arm.h
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 01fc1f9ac9..86d725cc76 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -72,6 +72,7 @@
>   #include "hw/core/irq.h"
>   #include "kvm_arm.h"
>   #include "hvf_arm.h"
> +#include "whpx_arm.h"
>   #include "hw/firmware/smbios.h"
>   #include "qapi/visitor.h"
>   #include "qapi/qapi-visit-common.h"
> @@ -3315,6 +3316,36 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>       return fixed_ipa ? 0 : requested_pa_size;
>   }
>   
> +static int virt_whpx_get_physical_address_range(MachineState *ms)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(ms);
> +
> +    int max_ipa_size = whpx_arm_get_ipa_bit_size();
> +
> +    /* We freeze the memory map to compute the highest gpa */
> +    virt_set_memmap(vms, max_ipa_size);
> +
> +    int requested_ipa_size = 64 - clz64(vms->highest_gpa);
> +
> +    /*
> +     * If we're <= the default IPA size just use the default.
> +     * If we're above the default but below the maximum, round up to
> +     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only

This comment still mentions "hvf" though this is imported to whpx now.

> +     * returns values that are valid ARM PARange values.
> +     */
> +    if (requested_ipa_size <= max_ipa_size) {
> +        requested_ipa_size = max_ipa_size;
> +    } else {
> +        error_report("-m and ,maxmem option values "
> +                     "require an IPA range (%d bits) larger than "
> +                     "the one supported by the host (%d bits)",
> +                     requested_ipa_size, max_ipa_size);
> +        return -1;
> +    }
> +
> +    return requested_ipa_size;
> +}
> +
>   static int virt_hvf_get_physical_address_range(MachineState *ms)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(ms);
> @@ -3414,6 +3445,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>       mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>       mc->kvm_type = virt_kvm_type;
>       mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
> +    mc->whpx_get_physical_address_range = virt_whpx_get_physical_address_range;
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>       hc->pre_plug = virt_machine_device_pre_plug_cb;
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 815845207b..0dd9ef2613 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -278,6 +278,7 @@ struct MachineClass {
>       void (*wakeup)(MachineState *state);
>       int (*kvm_type)(MachineState *machine, const char *arg);
>       int (*hvf_get_physical_address_range)(MachineState *machine);
> +    int (*whpx_get_physical_address_range)(MachineState *machine);
>   
>       BlockInterfaceType block_default_type;
>       int units_per_default_bus;
> diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
> index 1de2ef0283..3df632c9d3 100644
> --- a/target/arm/whpx/meson.build
> +++ b/target/arm/whpx/meson.build
> @@ -1,3 +1,5 @@
>   arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
>     'whpx-all.c',
>   ))
> +
> +arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 75b82be4e7..fe58217e46 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -35,6 +35,7 @@
>   #include "system/whpx-accel-ops.h"
>   #include "system/whpx-all.h"
>   #include "system/whpx-common.h"
> +#include "whpx_arm.h"
>   #include "hw/arm/bsa.h"
>   #include "arm-powerctl.h"
>   
> @@ -657,6 +658,40 @@ static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
>   {
>   }
>   
> +uint32_t whpx_arm_get_ipa_bit_size(void)
> +{
> +    WHV_CAPABILITY whpx_cap;
> +    UINT32 whpx_cap_size;
> +    HRESULT hr;
> +    hr = whp_dispatch.WHvGetCapability(
> +        WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
> +        sizeof(whpx_cap), &whpx_cap_size);
> +    if (FAILED(hr)) {
> +        error_report("WHPX: failed to get supported"
> +             "physical address width, hr=%08lx", hr);
> +    }
> +
> +    /*
> +     * We clamp any IPA size we want to back the VM with to a valid PARange
> +     * value so the guest doesn't try and map memory outside of the valid range.
> +     * This logic just clamps the passed in IPA bit size to the first valid
> +     * PARange value <= to it.
> +     */
> +    return round_down_to_parange_bit_size(whpx_cap.PhysicalAddressWidth);
> +}
> +
> +static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
> +{
> +    uint32_t ipa_size = whpx_arm_get_ipa_bit_size();
> +    uint64_t id_aa64mmfr0;
> +
> +    /* Clamp down the PARange to the IPA size the kernel supports. */
> +    uint8_t index = round_down_to_parange_index(ipa_size);
> +    id_aa64mmfr0 = GET_IDREG(isar, ID_AA64MMFR0);
> +    id_aa64mmfr0 = (id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
> +    SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
> +}
> +
>   int whpx_init_vcpu(CPUState *cpu)
>   {
>       HRESULT hr;
> @@ -735,6 +770,7 @@ int whpx_init_vcpu(CPUState *cpu)
>       val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);
>       whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
>   
> +    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
>       return 0;
>   
>   error:
> @@ -757,6 +793,8 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>       UINT32 whpx_cap_size;
>       WHV_PARTITION_PROPERTY prop;
>       WHV_CAPABILITY_FEATURES features = {0};
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    int pa_range = 0;
>   
>       whpx = &whpx_global;
>       /* on arm64 Windows Hypervisor Platform, vGICv3 always used */
> @@ -767,6 +805,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>           goto error;
>       }
>   
> +    if (mc->whpx_get_physical_address_range) {
> +        pa_range = mc->whpx_get_physical_address_range(ms);
> +        if (pa_range < 0) {
> +            return -EINVAL;

This should: goto error;

> +        }
> +    }
> +
>       whpx->mem_quota = ms->ram_size;
>   
>       hr = whp_dispatch.WHvGetCapability(
> diff --git a/target/arm/whpx/whpx-stub.c b/target/arm/whpx/whpx-stub.c
> new file mode 100644
> index 0000000000..32e434a5f6
> --- /dev/null
> +++ b/target/arm/whpx/whpx-stub.c
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * WHPX stubs for ARM
> + *
> + *  Copyright (c) 2025 Mohamed Mediouni
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "whpx_arm.h"
> +
> +uint32_t whpx_arm_get_ipa_bit_size(void)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/whpx_arm.h b/target/arm/whpx_arm.h
> new file mode 100644
> index 0000000000..de7406b66f
> --- /dev/null
> +++ b/target/arm/whpx_arm.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * WHPX support -- ARM specifics
> + *
> + * Copyright (c) 2025 Mohamed Mediouni
> + *
> + */
> +
> +#ifndef QEMU_WHPX_ARM_H
> +#define QEMU_WHPX_ARM_H
> +
> +#include "target/arm/cpu-qom.h"
> +
> +uint32_t whpx_arm_get_ipa_bit_size(void);
> +
> +#endif


