Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5BEFB44C3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAjw-0001gs-7B; Fri, 24 Apr 2026 03:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAju-0001gK-AP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:14:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAjs-0007lu-Fr
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:14:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso46843555e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777014851; x=1777619651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Jlj8iPeS9bImGWIO+BpSnKCZteX65zg+665JRvJf1yo=;
 b=Iu3kSlt0Y243fLuAzeRSZpgFxav6D27ih1O2K8DhxJqJuiiyarpsDUEMSl6uyHdMjr
 Di2NqJVeFQVYUcaFvbZDmI4hPE9w+VbkPIpoEcA7FRKCOpafjuLg95abl429gMksHWxF
 9+GqM43BHikrKWyn/QLl8D+w0uCsGbsBTZ4lOgXdWTXpy+ZtH1ewIh3S4DIGbdagne6j
 X6zkmxlMgvkUs+RZlJUlllhk2LWU0qD+F1+oXr76ZRjiZ289Zxh/05LmpZf++RnKfyqs
 s/8jYquEhztV7JT3iANHhyxgIZ//jYwo28llYv3fX6GHv3WXK6X4InsW9cYLxjRit7aq
 IKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777014851; x=1777619651;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jlj8iPeS9bImGWIO+BpSnKCZteX65zg+665JRvJf1yo=;
 b=lyz0dTYsqLi3+XZs6YisMgb2+rm9OZmr04Jjo+eGaJ/PXsg/eWxa/yn2X3gQkTiHS9
 9BAPgld1r5uc6Z9BIqEbHoGCOZ6z8Z5pP+dCccGmPialb/jSG0nyv/YLuPyOQGAMeGXO
 DCCFpha/3NiTfw4nSlRSnsZfvQcVpTSvXHy7VVMSzA0G3g/OJqMMsRAxuP8xwxjPRBij
 /pBbMWXKri/j/wzX0s3AjgE6kPyagATiyUDvTlcMJa2C6p/snZylkRJoNMAN5dpuDPTc
 wW8GwHJqFBmT8Y6YkUuLnIY/TG2XAjAv3uSzP/5enP98wbCUsljIMoWqPWAheh4dplcU
 C88w==
X-Gm-Message-State: AOJu0YytbdkpPhrC6XKQzGm5udlot2Uum8SFItWEHw51LEZP6PqGJQtX
 CK4xLBigfnU3fhL8+NMcOSOhMalIGxqweYQvq/LhqP+vijjvpvXHGW0rrQZcHkHZsaZHTsg5O32
 ig0m1q5Q=
X-Gm-Gg: AeBDiet6GazVXN8d0ITLjFmF+cfi/m3uDZfnmlokikw5CoDFSp7M6ucb7jkbVMHDHNe
 QdBu401iwo8ic56I1a9/yQ8d9a1+364r7eeqFxB4Ou0chLmzFNqB/q8K+58db8xsqMBMWEJsYgN
 FHyfWk9VsFRXwitrDyLNOc3UdDxeEzj1HIkRrhnBG19wXYdOSx0NJ4NNK3qq9en9Zn6raU71ftA
 ltw0r5/ehl9yEYUpVdN37fqLa+cJ1f7iKZPkTshuMEXsQlTzS3TYpWbhYeAPoTGaSrekW4CJQGu
 2LebY0rXYb99+sO1tOcqnK3eTfcSfXErM7l6CMBFRn1bjObdrL8nR3oe6lunO9FnFjR8kd2DC4y
 +/7zuTPziUqehgql8MtM+q3EGB3/kM9iTRxzn8QC2PklC+oHgV/ROLXq2vA06U7FRjh7a1B7RLw
 rkeKF2qlTtYQN0fJxz91lsysD0kGL3n5iS5Wk+FvRgRiPjhNx/J99xjFtvw72o8cUrlCcqwLTVm
 sKTBjlE4fqthXyZHmEN86XasenheKsqlk3VIe02snalDfDBeB8IpEF6RQNLGA==
X-Received: by 2002:a05:600c:3222:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-489e69685a4mr158704965e9.13.1777014850522; 
 Fri, 24 Apr 2026 00:14:10 -0700 (PDT)
Received: from meli-email.org (athedsl-338307.home.otenet.gr. [85.72.177.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8193sm519664675e9.1.2026.04.24.00.14.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:14:10 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:13:17 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v20 15/15] hvf: arm: enable vGIC by default for virt-11.1
 and later
User-Agent: meli/0.8.13
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-16-mohamed@unpredictable.fr>
In-Reply-To: <20260316130642.13246-16-mohamed@unpredictable.fr>
Message-ID: <tdzlfl.1qym1kot8zrta@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

On Mon, 16 Mar 2026 15:06, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>Save states are incompatible between kernel-irqchip=on and off on HVF due to opaque vGIC state.
>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> accel/hvf/hvf-all.c      | 11 +++++++++++
> hw/arm/virt.c            | 22 +++++++++++++++++++++-
> include/hw/arm/virt.h    |  2 ++
> include/hw/core/boards.h |  1 +
> include/system/hvf_int.h |  1 +
> 5 files changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
>index 48c653630f..4e5a8c58a8 100644
>--- a/accel/hvf/hvf-all.c
>+++ b/accel/hvf/hvf-all.c
>@@ -25,6 +25,7 @@
> bool hvf_allowed;
> bool hvf_kernel_irqchip;
> bool hvf_nested_virt;
>+bool hvf_kernel_irqchip_override;
> 
> void hvf_nested_virt_enable(bool nested_virt) {
>     hvf_nested_virt = nested_virt;
>@@ -203,6 +204,13 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
>         }
>     }
> 
>+    if (mc->get_kernel_irqchip_default) {
>+        bool kernel_irqchip_default = mc->get_kernel_irqchip_default(ms);
>+        if (!hvf_kernel_irqchip_override) {
>+            hvf_kernel_irqchip = kernel_irqchip_default;
>+        }
>+    }
>+
>     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
>     if (ret == HV_DENIED) {
>         error_report("Could not access HVF. Is the executable signed"
>@@ -229,6 +237,8 @@ static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
>                                    Error **errp)
> {
>     OnOffSplit mode;
>+
>+    hvf_kernel_irqchip_override = true;
>     if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
>         return;
>     }
>@@ -268,6 +278,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>     ac->init_machine = hvf_accel_init;
>     ac->allowed = &hvf_allowed;
>     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
>+    hvf_kernel_irqchip_override = false;
>     hvf_kernel_irqchip = false;
>     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
>         NULL, hvf_set_kernel_irqchip,
>diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>index 391ec722c0..ad82a7356e 100644
>--- a/hw/arm/virt.c
>+++ b/hw/arm/virt.c
>@@ -3443,6 +3443,16 @@ static int virt_get_physical_address_range(MachineState *ms,
>     return requested_ipa_size;
> }
> 
>+static bool get_kernel_irqchip_default(const MachineState *ms) {
>+    VirtMachineState *vms = VIRT_MACHINE(ms);
>+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>+    if (hvf_allowed) {
>+        return !vmc->hvf_no_kernel_irqchip_default;
>+    } else {
>+        return true;
>+    }
>+}
>+
> static const char *virt_get_default_cpu_type(const MachineState *ms)
> {
>     return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
>@@ -3509,6 +3519,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>     mc->kvm_type = virt_kvm_type;
>     mc->get_physical_address_range = virt_get_physical_address_range;
>+    mc->get_kernel_irqchip_default = get_kernel_irqchip_default;
>     assert(!mc->get_hotplug_handler);
>     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>     hc->pre_plug = virt_machine_device_pre_plug_cb;
>@@ -3740,10 +3751,19 @@ static void machvirt_machine_init(void)
> }
> type_init(machvirt_machine_init);
> 
>+static void virt_machine_11_1_options(MachineClass *mc)
>+{
>+}
>+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
>+
> static void virt_machine_11_0_options(MachineClass *mc)
> {
>+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>+    virt_machine_11_1_options(mc);
>+
>+    vmc->hvf_no_kernel_irqchip_default = true;
> }
>-DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
>+DEFINE_VIRT_MACHINE(11, 0)
> 
> static void virt_machine_10_2_options(MachineClass *mc)
> {
>diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>index dba8ac7f2f..d2575e14a0 100644
>--- a/include/hw/arm/virt.h
>+++ b/include/hw/arm/virt.h
>@@ -135,6 +135,8 @@ struct VirtMachineClass {
>     bool no_tcg_lpa2;
>     bool no_ns_el2_virt_timer_irq;
>     bool no_nested_smmu;
>+    /* HVF specific: support for kernel-irqchip=on introduced in QEMU 11.1 */
>+    bool hvf_no_kernel_irqchip_default;
> };
> 
> struct VirtMachineState {
>diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
>index f85f31bd90..ad896ed0b7 100644
>--- a/include/hw/core/boards.h
>+++ b/include/hw/core/boards.h
>@@ -279,6 +279,7 @@ struct MachineClass {
>     int (*kvm_type)(MachineState *machine, const char *arg);
>     int (*get_physical_address_range)(MachineState *machine,
>         int default_ipa_size, int max_ipa_size);
>+    bool (*get_kernel_irqchip_default) (const MachineState *machine);
> 
>     BlockInterfaceType block_default_type;
>     int units_per_default_bus;
>diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>index 2621164cb2..ad7d375109 100644
>--- a/include/system/hvf_int.h
>+++ b/include/system/hvf_int.h
>@@ -112,4 +112,5 @@ bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
> uint32_t hvf_arch_get_default_ipa_bit_size(void);
> uint32_t hvf_arch_get_max_ipa_bit_size(void);
> 
>+extern bool hvf_kernel_irqchip_override;
> #endif
>-- 
>2.50.1 (Apple Git-155)
>
>

