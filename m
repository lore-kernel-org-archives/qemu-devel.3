Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539F3C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHI-0002LD-HU; Fri, 26 Jan 2024 09:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHG-0002IM-17
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:54 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHD-0007wA-HR
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:53 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso548154f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279630; x=1706884430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aKFqrLvCzXTDGSINS8VWH1i0hLeDZyaY1SkgUJsHk9M=;
 b=UEd733YkeDANubnYUnCNE/GrAdynl14V5gm3FlKHQegKwdpTftLN5BsBzG5aidn3yP
 eCRfr9012I5hKZofHAXWJUNIHURK/btr74ck8/l4Az14DPPNl7LHv2n1HNUgvmDdeaK+
 tlmLF2iTh7Z8dKSfxaYnFrMNwziXqTb02ZK4iQD0/pNWVUdgXvhARHlDLhcwMt3xl4sG
 I7TIHap99rosPFSj44ozycG1Ux9BYtJWAXRJV+Ra6a3hReKHfVB9r3n7qj4uh8KJTZft
 6T62ipYPmUrR7hI9/SlO9EURiVn9OocKY6ENDdZZw9pwaqUEEhsxlkgJhylpR2aQLtVg
 33LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279630; x=1706884430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKFqrLvCzXTDGSINS8VWH1i0hLeDZyaY1SkgUJsHk9M=;
 b=D3lDNdtaVbR5PF1DdrohuoaaZZ9xaWEfvFMTEEfJFSMfmyss/0Ur/R+C8+qMYigrVw
 /iQh//L0RiN3GUwoYYnsaN9oIhMoZWDUJNgxp8YlGSpEtRXCniZ5lrWJBjN0yeS4UQzq
 iLTrSJGhiFLYrakndsiQS67TQ5R+NpD660yeZkM9u/STGXBsyFz7v83jRDPjkpeFnr/y
 QajFieNYoyhZdhKJ0Q4AsUEyEhwfP+TA7XHMV5/SOiNe7Jf0Dc2Rs94F8gY6/rSXJ7c1
 LodUBQfy3OlZGU8QElaJ5l662UikFFwXHtnQSLbFaxS/NqfY7cVYBZrNXzBbL/vI5ZY7
 rCNQ==
X-Gm-Message-State: AOJu0YxGeeZ7yUHhK8HvGPmuFhjXMH62iO7rZibVsZZ8FbuKtifaU03z
 AbicbH+PncfqRw8zupemleKiXrG1MewJ+LRDTsyrIK1XE0zsH0okOXn0tQpqcDZ1vY/cbgh58S2
 6
X-Google-Smtp-Source: AGHT+IEIy+ckq7GFIKhkAM1WGB0VYb6u5WtGOgJHhtQykhYqTDFIqMN/TnuAu3pIDDsh84CaRcOBZA==
X-Received: by 2002:a7b:cb43:0:b0:40e:5aa4:44f8 with SMTP id
 v3-20020a7bcb43000000b0040e5aa444f8mr863285wmj.216.1706279630224; 
 Fri, 26 Jan 2024 06:33:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/36] target/arm: Create arm_cpu_mp_affinity
Date: Fri, 26 Jan 2024 14:33:23 +0000
Message-Id: <20240126143341.2101237-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Wrapper to return the mp affinity bits from the cpu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          | 5 +++++
 hw/arm/virt-acpi-build.c  | 2 +-
 hw/arm/virt.c             | 6 +++---
 hw/arm/xlnx-versal-virt.c | 3 ++-
 hw/misc/xlnx-versal-crl.c | 4 ++--
 target/arm/arm-powerctl.c | 2 +-
 target/arm/hvf/hvf.c      | 4 ++--
 target/arm/tcg/psci.c     | 2 +-
 8 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 55a19e8539e..d1584bdb3b5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1173,6 +1173,11 @@ void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
 
+static inline uint64_t arm_cpu_mp_affinity(ARMCPU *cpu)
+{
+    return cpu->mp_affinity;
+}
+
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a22a2f43a56..2127778c1ea 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -720,7 +720,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, vgic_interrupt, 4);
         build_append_int_noprefix(table_data, 0, 8);    /* GICR Base Address*/
         /* MPIDR */
-        build_append_int_noprefix(table_data, armcpu->mp_affinity, 8);
+        build_append_int_noprefix(table_data, arm_cpu_mp_affinity(armcpu), 8);
         /* Processor Power Efficiency Class */
         build_append_int_noprefix(table_data, 0, 1);
         /* Reserved */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eecde04fc77..b3592798ea9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -370,7 +370,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     for (cpu = 0; cpu < smp_cpus; cpu++) {
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
 
-        if (armcpu->mp_affinity & ARM_AFF3_MASK) {
+        if (arm_cpu_mp_affinity(armcpu) & ARM_AFF3_MASK) {
             addr_cells = 2;
             break;
         }
@@ -397,10 +397,10 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 
         if (addr_cells == 2) {
             qemu_fdt_setprop_u64(ms->fdt, nodename, "reg",
-                                 armcpu->mp_affinity);
+                                 arm_cpu_mp_affinity(armcpu));
         } else {
             qemu_fdt_setprop_cell(ms->fdt, nodename, "reg",
-                                  armcpu->mp_affinity);
+                                  arm_cpu_mp_affinity(armcpu));
         }
 
         if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 537118224fb..841ef69df66 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -107,7 +107,8 @@ static void fdt_add_cpu_nodes(VersalVirt *s, uint32_t psci_conduit)
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
 
         qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop_cell(s->fdt, name, "reg", armcpu->mp_affinity);
+        qemu_fdt_setprop_cell(s->fdt, name, "reg",
+                              arm_cpu_mp_affinity(armcpu));
         if (psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
             qemu_fdt_setprop_string(s->fdt, name, "enable-method", "psci");
         }
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index ac6889fcf26..9bfa9baa157 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -67,9 +67,9 @@ static void crl_reset_cpu(XlnxVersalCRL *s, ARMCPU *armcpu,
                           bool rst_old, bool rst_new)
 {
     if (rst_new) {
-        arm_set_cpu_off(armcpu->mp_affinity);
+        arm_set_cpu_off(arm_cpu_mp_affinity(armcpu));
     } else {
-        arm_set_cpu_on_and_reset(armcpu->mp_affinity);
+        arm_set_cpu_on_and_reset(arm_cpu_mp_affinity(armcpu));
     }
 }
 
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 88503815659..6c86e901028 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -37,7 +37,7 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
     CPU_FOREACH(cpu) {
         ARMCPU *armcpu = ARM_CPU(cpu);
 
-        if (armcpu->mp_affinity == id) {
+        if (arm_cpu_mp_affinity(armcpu) == id) {
             return cpu;
         }
     }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a537a5bc94c..659401e12c7 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1016,7 +1016,7 @@ static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
 
 static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
 {
-    int32_t ret = arm_set_cpu_off(arm_cpu->mp_affinity);
+    int32_t ret = arm_set_cpu_off(arm_cpu_mp_affinity(arm_cpu));
     assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
 }
 
@@ -1045,7 +1045,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     int32_t ret = 0;
 
     trace_hvf_psci_call(param[0], param[1], param[2], param[3],
-                        arm_cpu->mp_affinity);
+                        arm_cpu_mp_affinity(arm_cpu));
 
     switch (param[0]) {
     case QEMU_PSCI_0_2_FN_PSCI_VERSION:
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 9080a91d9c6..50d4b23d26b 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -215,7 +215,7 @@ err:
     return;
 
 cpu_off:
-    ret = arm_set_cpu_off(cpu->mp_affinity);
+    ret = arm_set_cpu_off(arm_cpu_mp_affinity(cpu));
     /* notreached */
     /* sanity check in case something failed */
     assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
-- 
2.34.1


