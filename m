Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA5C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj2tw-0005Xw-0W; Mon, 04 Aug 2025 17:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2ti-0005Rq-7T
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:39:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2tf-0004zS-FE
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:39:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76bd041c431so3975768b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754343546; x=1754948346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//eA0my1IPfWDYlLxpBvFPXWpoez1CE2RydJ32c4d+Q=;
 b=e6vOZmQO5XB1dIO5vko2EdZrPs6KfK6xtF4VpH2kJOKE6Xl3riwp7FB3HLkuGEMOHu
 eDIIgvfaD61Ogk//OdoEQWgFAMDRf4KGNEi44JvWdOkthsNdpHzdOV9TDwZKat+Bf2yv
 wGdcN+9Pbuf5qrS0fYRRkQdiWqfS7zRenTxLvh+9TcugHNRqh7pty1K+opk2UHQhI0n7
 fN6eMQvQlAbxP1hUpNQtRffNdaVZheGIxex0FwE1pPC1DodSERG9Juzjt5g4HQrAdl8Q
 qan3VrPu/MYjhag2e5JlMKhPYwX+c4YvdrkL6c7BvCuRuMUOsSb9glnxSYUHES1MKMJZ
 0qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754343546; x=1754948346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//eA0my1IPfWDYlLxpBvFPXWpoez1CE2RydJ32c4d+Q=;
 b=BEF3bZ8j9pcsz4IrY6iR4hYGDQ1knn+3CNXf8AiUE8COXLuQocFo3SurQrDGWmG18M
 Vr/MF/8Vsg7VcCIVtuHPOOGLMZCqt2B59c9CADL+848+uFSw0XwuvB5mbF1wucG/aS6N
 jNu/f/VpCWJjzCo/RokCRpTcxaGtjFm2owf1XDTLg8+lTk1YSL2SAS2he3T9Ztdygx0H
 A8b1iyclWrUO6+euoSEP+eYJuh8nack1rcX5QUreeTp54NrhzbYKJ9aEpNEi7OfX4meu
 oqs6gS4H1z5hO/0XYrhNDju2kpfi6Z8spnG/BDl500QM8hn3VJ4E+uv0Shk5UrDLeqYK
 Qx1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi7t/is6ZYDzOXv4fKST9YD+RtrlRG0XfpWGs1yhiDCGZN6Jfi72BHGd267Cv9jGqiLagiEicJTjOj@nongnu.org
X-Gm-Message-State: AOJu0Ywa+LVA8IRdHztf5wwTtnff1jkqMKJnWusfVCLWV6D8JV2ZpBVo
 tOhUZ4uPABOFi3HoUBH3cNKyqrItWa3l41HnRjt0Uv0dgCff1PStOwKhTDeVawALK10=
X-Gm-Gg: ASbGnct1iapfZbvBMM1quhHchK8hFbRMqQWMw6ASTZr50efTl8ArLD6zoEinnUMmi7B
 s+7LV1PVASB6Yztz6X8k+F3HZQzk8PaKUZSaYUZC9Qzt2veOYIrIrawZzkGP8un/YdQaxkQ8/RV
 N3YZWF8btTpoulgQTP0JddQj5Q8+ry/iwjySYW60OMoXXWkePR2VhUlZEALkqrA8rFDvrgTiG1H
 EJ69j0nwX64fvPsxkjF4vQohIkQakxYwu1w65W1+wnJMmaAFtPxDD6KDcE8rWLJ9OgWHyxZhjaZ
 yQd7UPQUrk8vGhfm3abRDW6XH+IrtENGWMH5BZdxml6rywXMdOypV5GlSmGrNObMAuxqO3akmEH
 Z+VekYwqYEIFudxWOx/AN4Yf3iyL5thcA2/U=
X-Google-Smtp-Source: AGHT+IHDKLtgvkDk3quNh6JFUm+kfS+jwTjJt3xpSaNSql2jesg6fwlqFbqU/UnpAhIj784bP0VQdQ==
X-Received: by 2002:a05:6a00:1908:b0:76b:e805:30e4 with SMTP id
 d2e1a72fcca58-76bec502ac0mr13866773b3a.24.1754343545739; 
 Mon, 04 Aug 2025 14:39:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcceaae02sm11211095b3a.59.2025.08.04.14.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 14:39:04 -0700 (PDT)
Message-ID: <f8bb5277-bb6b-44be-a5ea-93e7dd55ca18@linaro.org>
Date: Mon, 4 Aug 2025 14:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] whpx: interrupt controller support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-9-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-9-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c                      |   3 +
>   hw/intc/arm_gicv3_common.c         |   3 +
>   hw/intc/arm_gicv3_whpx.c           | 261 +++++++++++++++++++++++++++++
>   hw/intc/meson.build                |   1 +
>   include/hw/intc/arm_gicv3_common.h |   3 +
>   5 files changed, 271 insertions(+)
>   create mode 100644 hw/intc/arm_gicv3_whpx.c
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5951b331f3..98a1c74c42 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -49,6 +49,7 @@
>   #include "system/tcg.h"
>   #include "system/kvm.h"
>   #include "system/hvf.h"
> +#include "system/whpx.h"
>   #include "system/qtest.h"
>   #include "hw/loader.h"
>   #include "qapi/error.h"
> @@ -2060,6 +2061,8 @@ static void finalize_gic_version(VirtMachineState *vms)
>           /* KVM w/o kernel irqchip can only deal with GICv2 */
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           accel_name = "KVM with kernel-irqchip=off";
> +    } else if (whpx_enabled()) {
> +        gics_supported |= VIRT_GIC_VERSION_3_MASK;
>       } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           if (module_object_class_by_name("arm-gicv3")) {
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index e438d8c042..8b85b60c9b 100644
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
> @@ -662,6 +663,8 @@ const char *gicv3_class_name(void)
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
> index 0000000000..ead4e167c5
> --- /dev/null
> +++ b/hw/intc/arm_gicv3_whpx.c
> @@ -0,0 +1,261 @@
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
> +typedef struct WHPXARMGICv3Class WHPXARMGICv3Class;
> +
> +/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
> +DECLARE_OBJ_CHECKERS(GICv3State, WHPXARMGICv3Class,
> +                     WHPX_GICV3, TYPE_WHPX_GICV3);
> +
> +static void whpx_gicv3_check(GICv3State *s)
> +{
> +}
> +
> +static void whpx_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
> +{
> +}
> +
> +static void whpx_gicv3_put(GICv3State *s)
> +{
> +    int ncpu;
> +
> +    whpx_gicv3_check(s);
> +
> +    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
> +        run_on_cpu_data data;
> +        data.host_ptr = &s->cpu[ncpu];
> +        run_on_cpu(s->cpu[ncpu].cpu, whpx_gicv3_put_cpu, data);
> +    }
> +}
> +
> +static void whpx_gicv3_get_cpu(CPUState *cpu_state, run_on_cpu_data arg)
> +{
> +}
> +
> +static void whpx_gicv3_get(GICv3State *s)
> +{
> +    int ncpu;
> +
> +    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
> +        run_on_cpu_data data;
> +        data.host_ptr = &s->cpu[ncpu];
> +        run_on_cpu(s->cpu[ncpu].cpu, whpx_gicv3_get_cpu, data);
> +    }
> +}
> +

Probably a stupid question, but since check, get_cpu and put_cpu are 
empty functions, why define them and the logic associated?

> +static void whpx_gicv3_set_irq(void *opaque, int irq, int level)
> +{
> +    struct whpx_state *whpx = &whpx_global;
> +
> +    GICv3State *s = (GICv3State *)opaque;
> +    if (irq > s->num_irq) {
> +        return;
> +    }
> +    WHV_INTERRUPT_TYPE interrupt_type = WHvArm64InterruptTypeFixed;
> +    WHV_INTERRUPT_CONTROL interrupt_control = {
> +    interrupt_type = WHvArm64InterruptTypeFixed,
> +    .RequestedVector = GIC_INTERNAL + irq, .InterruptControl.Asserted = level};
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
> +    GICv3State *s = WHPX_GICV3(dev);
> +    WHPXARMGICv3Class *kgc = WHPX_GICV3_GET_CLASS(s);
> +    Error *local_err = NULL;
> +    int i;
> +
> +    kgc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (s->revision != 3) {
> +        error_setg(errp, "unsupported GIC revision %d for platform GIC",
> +                   s->revision);
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
> index 3137521a4a..4fc6b78a04 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -41,6 +41,7 @@ specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
>   specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
>   specific_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
>   specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
> +specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
>   specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>   specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
>   specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index c18503869f..7776558a0e 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -306,6 +306,9 @@ typedef struct ARMGICv3CommonClass ARMGICv3CommonClass;
>   DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3CommonClass,
>                        ARM_GICV3_COMMON, TYPE_ARM_GICV3_COMMON)
>   
> +/* Types for GICv3 kernel-irqchip */
> +#define TYPE_WHPX_GICV3 "whpx-arm-gicv3"
> +
>   struct ARMGICv3CommonClass {
>       /*< private >*/
>       SysBusDeviceClass parent_class;


