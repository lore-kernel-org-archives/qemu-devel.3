Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29679FA3728
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 07:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbZyc-0001Ui-RK; Fri, 02 Jan 2026 02:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vbZyS-0001SX-N6; Fri, 02 Jan 2026 02:53:31 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vbZyM-0000kL-Sg; Fri, 02 Jan 2026 02:53:27 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6027pEdX008347
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 2 Jan 2026 16:51:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fFpgb0crGxGutnJeasPtIj8udO1ET4o77v6uYQwojxw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1767340318; v=1;
 b=lSvopANWSk6qEZYfYLO+DQlhnwcqZrOG3iymesH9ZVeGkcps74wlUGu4EsnxQclY
 A3Hi1Y6uGEhpT5DImNEw97QBGgYk3GSZ16j+9/186aw0ineNyGzPap4E0uQM334E
 GlanqkrJY1mmZvhffkeiqr7x06IpJ0kH9VRtF3w/62Gv5Ih6yZjSIP0ryr6X9X1X
 JNZcYrRB674OMvuL54Wf0RMKjEJ+WQWdD8VgFHyUl8uR5UbkKeb+LC8Jidn3IZgX
 /xtid+JWu0Y76peEtOmLGjihI5dkj6fSEnu1TXEmBYUKpe0iLBGM9bHZ/3ESDHl4
 iv/ESUGMYc8qiXMVHFpMgg==
Message-ID: <b002eb6b-5056-4ef0-a306-6dcfcf9b2a8f@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 2 Jan 2026 16:51:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 15/28] whpx: interrupt controller support
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
 <20251230000401.72124-16-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251230000401.72124-16-mohamed@unpredictable.fr>
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
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/virt.c                      |   3 +
>   hw/intc/arm_gicv3_common.c         |   3 +
>   hw/intc/arm_gicv3_whpx.c           | 239 +++++++++++++++++++++++++++++
>   hw/intc/meson.build                |   1 +
>   include/hw/intc/arm_gicv3_common.h |   3 +
>   5 files changed, 249 insertions(+)
>   create mode 100644 hw/intc/arm_gicv3_whpx.c
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 1858190dd1..01fc1f9ac9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -49,6 +49,7 @@
>   #include "system/tcg.h"
>   #include "system/kvm.h"
>   #include "system/hvf.h"
> +#include "system/whpx.h"
>   #include "system/qtest.h"
>   #include "system/system.h"
>   #include "hw/core/loader.h"
> @@ -2117,6 +2118,8 @@ static void finalize_gic_version(VirtMachineState *vms)
>           /* KVM w/o kernel irqchip can only deal with GICv2 */
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           accel_name = "KVM with kernel-irqchip=off";
> +    } else if (whpx_enabled()) {
> +        gics_supported |= VIRT_GIC_VERSION_3_MASK;
>       } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           if (module_object_class_by_name("arm-gicv3")) {
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 0a2e5a3e2f..9054143ea7 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -32,6 +32,7 @@
>   #include "gicv3_internal.h"
>   #include "hw/arm/linux-boot-if.h"
>   #include "system/kvm.h"
> +#include "system/whpx.h"
>   
>   
>   static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
> @@ -663,6 +664,8 @@ const char *gicv3_class_name(void)
>   {
>       if (kvm_irqchip_in_kernel()) {
>           return "kvm-arm-gicv3";
> +    } else if (whpx_enabled()) {
> +        return TYPE_WHPX_GICV3;
>       } else {
>           if (kvm_enabled()) {
>               error_report("Userspace GICv3 is not supported with KVM");
> diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
> new file mode 100644
> index 0000000000..4fe6305c89
> --- /dev/null
> +++ b/hw/intc/arm_gicv3_whpx.c
> @@ -0,0 +1,239 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * ARM Generic Interrupt Controller using HVF platform support
> + *
> + * Copyright (c) 2025 Mohamed Mediouni
> + * Based on vGICv3 KVM code by Pavel Fedin
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/intc/arm_gicv3_common.h"
> +#include "qemu/error-report.h"
> +#include "qemu/module.h"
> +#include "system/runstate.h"
> +#include "system/whpx.h"
> +#include "system/whpx-internal.h"
> +#include "gicv3_internal.h"
> +#include "vgic_common.h"
> +#include "qom/object.h"
> +#include "target/arm/cpregs.h"
> +
> +#include "hw/arm/bsa.h"
> +#include <winhvplatform.h>
> +#include <winhvplatformdefs.h>
> +#include <winnt.h>
> +
> +struct WHPXARMGICv3Class {
> +    ARMGICv3CommonClass parent_class;
> +    DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
> +};
> +
> +OBJECT_DECLARE_TYPE(GICv3State, WHPXARMGICv3Class, WHPX_GICV3)
> +
> +/* TODO: Implement GIC state save-restore */
> +static void whpx_gicv3_check(GICv3State *s)
> +{
> +}
> +
> +static void whpx_gicv3_put(GICv3State *s)
> +{
> +    whpx_gicv3_check(s);
> +}
> +
> +static void whpx_gicv3_get(GICv3State *s)
> +{
> +}
> +
> +static void whpx_gicv3_set_irq(void *opaque, int irq, int level)
> +{
> +    struct whpx_state *whpx = &whpx_global;
> +
> +    GICv3State *s = opaque;
> +    if (irq > s->num_irq) {
> +        return;
> +    }
> +    WHV_INTERRUPT_TYPE interrupt_type = WHvArm64InterruptTypeFixed;
> +    WHV_INTERRUPT_CONTROL interrupt_control = {
> +        interrupt_type = WHvArm64InterruptTypeFixed,
> +        .RequestedVector = GIC_INTERNAL + irq,
> +        .InterruptControl.Asserted = level
> +    };

You probably missed one of my comments for a previous version:
 > I think this should be:
 >
 > WHV_INTERRUPT_CONTROL interrupt_control = {
 >     .Type = WHvArm64InterruptTypeFixed,
 >     .RequestedVector = GIC_INTERNAL + irq,
 >     .InterruptControl.Asserted = level
 > };

All my other previous comments are addressed, but I still have new 
comments below...

> +
> +    whp_dispatch.WHvRequestInterrupt(whpx->partition, &interrupt_control,
> +         sizeof(interrupt_control));
> +}
> +
> +static void whpx_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    GICv3State *s;
> +    GICv3CPUState *c;
> +
> +    c = (GICv3CPUState *)env->gicv3state;

This explicit cast should be gone, just like the one which used to be in 
whpx_gicv3_set_irq().

> +    s = c->gic;
> +
> +    c->icc_pmr_el1 = 0;
> +    /*
> +     * Architecturally the reset value of the ICC_BPR registers
> +     * is UNKNOWN. We set them all to 0 here; when the kernel
> +     * uses these values to program the ICH_VMCR_EL2 fields that
> +     * determine the guest-visible ICC_BPR register values, the
> +     * hardware's "writing a value less than the minimum sets
> +     * the field to the minimum value" behaviour will result in
> +     * them effectively resetting to the correct minimum value
> +     * for the host GIC.
> +     */
> +    c->icc_bpr[GICV3_G0] = 0;
> +    c->icc_bpr[GICV3_G1] = 0;
> +    c->icc_bpr[GICV3_G1NS] = 0;
> +
> +    c->icc_sre_el1 = 0x7;
> +    memset(c->icc_apr, 0, sizeof(c->icc_apr));
> +    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
> +
> +    if (s->migration_blocker) {
> +        return;
> +    }
> +
> +    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
> +}
> +
> +static void whpx_gicv3_reset_hold(Object *obj, ResetType type)
> +{
> +    GICv3State *s = ARM_GICV3_COMMON(obj);
> +    WHPXARMGICv3Class *kgc = WHPX_GICV3_GET_CLASS(s);
> +
> +    if (kgc->parent_phases.hold) {
> +        kgc->parent_phases.hold(obj, type);
> +    }
> +
> +    whpx_gicv3_put(s);
> +}
> +
> +
> +/*
> + * CPU interface registers of GIC needs to be reset on CPU reset.
> + * For the calling arm_gicv3_icc_reset() on CPU reset, we register
> + * below ARMCPRegInfo. As we reset the whole cpu interface under single
> + * register reset, we define only one register of CPU interface instead
> + * of defining all the registers.
> + */
> +static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
> +    { .name = "ICC_CTLR_EL1", .state = ARM_CP_STATE_BOTH,
> +      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 4,
> +      /*
> +       * If ARM_CP_NOP is used, resetfn is not called,
> +       * So ARM_CP_NO_RAW is appropriate type.
> +       */
> +      .type = ARM_CP_NO_RAW,
> +      .access = PL1_RW,
> +      .readfn = arm_cp_read_zero,
> +      .writefn = arm_cp_write_ignore,
> +      /*
> +       * We hang the whole cpu interface reset routine off here
> +       * rather than parcelling it out into one little function
> +       * per register
> +       */
> +      .resetfn = whpx_gicv3_icc_reset,
> +    },
> +};
> +
> +static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
> +{
> +    struct whpx_state *whpx = &whpx_global;
> +    HRESULT hr;
> +
> +    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
> +         &reg, 1, &val);
> +
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
> +    }
> +}
> +
> +static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    GICv3State *s = WHPX_GICV3(dev);
> +    WHPXARMGICv3Class *kgc = WHPX_GICV3_GET_CLASS(s);
> +    Error *local_err = NULL;
> +    int i;
> +
> +    kgc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;

With ERRP_GUARD(), this should be:

kgc->parent_realize(dev, errp);
if (*errp) {
   return;
}

include/qapi/error.h has an explanation for this.

> +    }
> +
> +    if (s->revision != 3) {
> +        error_setg(errp, "unsupported GIC revision %d for platform GIC",
> +                   s->revision);

"return;" is missing here.

> +    }
> +
> +    if (s->security_extn) {
> +        error_setg(errp, "the platform vGICv3 does not implement the "
> +                   "security extensions");
> +        return;
> +    }
> +
> +    if (s->nmi_support) {
> +        error_setg(errp, "NMI is not supported with the platform GIC");
> +        return;
> +    }
> +
> +    if (s->nb_redist_regions > 1) {
> +        error_setg(errp, "Multiple VGICv3 redistributor regions are not "
> +                   "supported by WHPX");
> +        error_append_hint(errp, "A maximum of %d VCPUs can be used",
> +                          s->redist_region_count[0]);
> +        return;
> +    }
> +
> +    gicv3_init_irqs_and_mmio(s, whpx_gicv3_set_irq, NULL);
> +
> +    for (i = 0; i < s->num_cpu; i++) {
> +        CPUState *cpu_state = qemu_get_cpu(i);
> +        ARMCPU *cpu = ARM_CPU(cpu_state);
> +        WHV_REGISTER_VALUE val = {.Reg64 = 0x080A0000 + (GICV3_REDIST_SIZE * i)};
> +        whpx_set_reg(cpu_state, WHvArm64RegisterGicrBaseGpa, val);
> +        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
> +    }
> +
> +    if (s->maint_irq) {
> +        error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
> +        return;
> +    }
> +}
> +
> +static void whpx_gicv3_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
> +    WHPXARMGICv3Class *kgc = WHPX_GICV3_CLASS(klass);
> +
> +    agcc->pre_save = whpx_gicv3_get;
> +    agcc->post_load = whpx_gicv3_put;
> +
> +    device_class_set_parent_realize(dc, whpx_gicv3_realize,
> +                                    &kgc->parent_realize);
> +    resettable_class_set_parent_phases(rc, NULL, whpx_gicv3_reset_hold, NULL,
> +                                       &kgc->parent_phases);
> +}
> +
> +static const TypeInfo whpx_arm_gicv3_info = {
> +    .name = TYPE_WHPX_GICV3,
> +    .parent = TYPE_ARM_GICV3_COMMON,
> +    .instance_size = sizeof(GICv3State),
> +    .class_init = whpx_gicv3_class_init,
> +    .class_size = sizeof(WHPXARMGICv3Class),
> +};
> +
> +static void whpx_gicv3_register_types(void)
> +{
> +    type_register_static(&whpx_arm_gicv3_info);
> +}
> +
> +type_init(whpx_gicv3_register_types)
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index faae20b93d..96742df090 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -41,6 +41,7 @@ specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
>   specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
> +specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
>   specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
>   specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 3d24ad22d2..c55cf18120 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -313,6 +313,9 @@ typedef struct ARMGICv3CommonClass ARMGICv3CommonClass;
>   DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3CommonClass,
>                        ARM_GICV3_COMMON, TYPE_ARM_GICV3_COMMON)
>   
> +/* Types for GICv3 kernel-irqchip */
> +#define TYPE_WHPX_GICV3 "whpx-arm-gicv3"
> +
>   struct ARMGICv3CommonClass {
>       /*< private >*/
>       SysBusDeviceClass parent_class;


