Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7796FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuT-00048q-1s; Fri, 01 May 2026 06:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuO-000469-LJ
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuM-0000M9-Ph
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-483487335c2so19480145e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630541; x=1778235341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L9CjgKuIn/enkAlQvRU0xfpossUgh2O4ehxD2AGrQ84=;
 b=nNn3rHR6BdJVFtv2vUekuZlf1KPACpSkgsS5XhpzNZt5NOEoSO4qH1xdzVLpQ0+pAv
 VbIV86duXpgdPBtG1T0oeEu0jtAu44x4RLKPUOej2XuDrkiaiECL6BmzdPU2oByIcWlE
 RhZKW7SyBmhykfJ5cbfCjZvAnhjViTS9XnSjQz7TZMe0ra2zpONiJec5IJHZj+MoqGTN
 jThNxZ1d9/i94i6KcMxprOYkRVS+xIwSY6G98ZXvQYEmCjUpZOT6KaHSeKjknJrH6OxK
 Q7ivzqTwaqtA6U2uAzpJ3pl9Isvd4/lI0es6Rdu6d3tYJSX1WlI4IfDyAR7BA1IJt6iW
 1l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630541; x=1778235341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L9CjgKuIn/enkAlQvRU0xfpossUgh2O4ehxD2AGrQ84=;
 b=nngXaoMywZutn67BytFGyNAzBoK49Nl+ADYzZ7mBZC3AdQRsUgR9ogy5ExFSP/KQ5Q
 C/WCbVg7zqqL86dAaJ7v84cW5F0b4MwS0/DRrzqdzpgj5ribi9IaIVoznD2M8NVt2bYD
 tZuwTumzkYSBgf/aQTKmtHjKPUCnHCn88XuvfydAGkyIdpYm9mDaxT8ubs8AzzQnBBUP
 0Y2kngYWynF/W3mBaYB82Q/StjEqhWI5CEm2wJkUWEBSpGsboZc91l7Si7bu/huk3AYN
 zyvfVovIBlnZhGd+Yw9q5/7y1v6TA/ZkFb2m4TwWhnm0eAA+mPQ1SfnZlapYaDsnyivZ
 tpQA==
X-Gm-Message-State: AOJu0Yymc1w1qPVdwAflbhtB268p6trOIrE1M6dG28I1y35VxKmdK/Re
 +lGuPzRjyQO+3z8vTeaMkFvBRZdCTOze6Am8uOA1bxAEo6ZTP23y0lFyla3unQ6SP3kr+RH8kh/
 rk6Tt
X-Gm-Gg: AeBDiev5dgpU1g1Vj4XIBn+H/lMIs19SfgGu+G3ca0zXbRXXaskbMGx/3ND1PLjRET9
 nww7MURgIpxPvfUNgNdrYI6ZwipOcgNTcL+rhDVY08QWlq6KIc3CIEnqVYqToMiOuwaIKCzFDts
 YZFQ9iQS9DVy3BfSp/Z86VXfdsY4+y6v24qbMLWiqbdfkFy4Dlz/LkbRaIGOKKwBJbT+U1N0vsa
 KX4JxbTSJqK5+cjil6HigNNcZr3viksBSP4BpWQnKf8mS2s2zvXOF57f+VYZBYL73MLkKRv4hY3
 ri1bzlUDBqZiTYQ7vLUBx3i3ekHN1L74/k/JBvVrk10VKpO665HUhrT2gTZbpqEjyNfWECIkniE
 83kwfg3jy2vhAvONYdTx1q+vkirpgbVoPqRcSHLDfi8guUd8lo4XpfjjRrnb8HN5h00uzn6DHw5
 Wb+4Zxk69tDf9duGaaOgLuTZHPDqd7GwUUwgvB03h9703TkqBbmj15pKZcLx76KV90RQmeSJ/VN
 66ae2xk0+wFALhQbu5EwLBHjp5dg36nQL4pHUzwIA==
X-Received: by 2002:a05:600c:6088:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48a844ec847mr102891865e9.9.1777630541439; 
 Fri, 01 May 2026 03:15:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/28] hvf: arm: enable vGIC by default for virt-11.1 and later
Date: Fri,  1 May 2026 11:15:05 +0100
Message-ID: <20260501101505.3485916-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Save states are incompatible between kernel-irqchip=on and off on HVF due to opaque vGIC state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260429190532.26538-16-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c      | 11 +++++++++++
 hw/arm/virt.c            | 15 +++++++++++++++
 include/hw/arm/virt.h    |  2 ++
 include/hw/core/boards.h |  1 +
 include/system/hvf_int.h |  1 +
 5 files changed, 30 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index da29aa3aa3..946dbca59d 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -25,6 +25,7 @@
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
 bool hvf_nested_virt;
+bool hvf_kernel_irqchip_override;
 
 void hvf_nested_virt_enable(bool nested_virt)
 {
@@ -204,6 +205,13 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
+    if (mc->get_kernel_irqchip_default) {
+        bool kernel_irqchip_default = mc->get_kernel_irqchip_default(ms);
+        if (!hvf_kernel_irqchip_override) {
+            hvf_kernel_irqchip = kernel_irqchip_default;
+        }
+    }
+
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     if (ret == HV_DENIED) {
         error_report("Could not access HVF. Is the executable signed"
@@ -230,6 +238,8 @@ static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
                                    Error **errp)
 {
     OnOffSplit mode;
+
+    hvf_kernel_irqchip_override = true;
     if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
         return;
     }
@@ -269,6 +279,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+    hvf_kernel_irqchip_override = false;
     hvf_kernel_irqchip = false;
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, hvf_set_kernel_irqchip,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ad0a459987..fe19030886 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3769,6 +3769,17 @@ static int virt_get_physical_address_range(MachineState *ms,
     return requested_ipa_size;
 }
 
+static bool get_kernel_irqchip_default(const MachineState *ms)
+{
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    if (hvf_allowed) {
+        return !vmc->hvf_no_kernel_irqchip_default;
+    } else {
+        return true;
+    }
+}
+
 static const char *virt_get_default_cpu_type(const MachineState *ms)
 {
     return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
@@ -3835,6 +3846,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     mc->get_physical_address_range = virt_get_physical_address_range;
+    mc->get_kernel_irqchip_default = get_kernel_irqchip_default;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
@@ -4079,8 +4091,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
 
 static void virt_machine_11_0_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_11_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    vmc->hvf_no_kernel_irqchip_default = true;
 }
 DEFINE_VIRT_MACHINE(11, 0)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index fc7950da85..13e135a460 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -138,6 +138,8 @@ struct VirtMachineClass {
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
+    /* HVF specific: support for kernel-irqchip=on introduced in QEMU 11.1 */
+    bool hvf_no_kernel_irqchip_default;
 };
 
 struct VirtMachineState {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index ca63304c95..29c68931d8 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -280,6 +280,7 @@ struct MachineClass {
     int (*kvm_type)(MachineState *machine, const char *arg);
     int (*get_physical_address_range)(MachineState *machine,
         int default_ipa_size, int max_ipa_size);
+    bool (*get_kernel_irqchip_default) (const MachineState *machine);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 2621164cb2..ad7d375109 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -112,4 +112,5 @@ bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
 
+extern bool hvf_kernel_irqchip_override;
 #endif
-- 
2.43.0


