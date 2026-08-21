Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B15EC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1M-0001VP-V3; Fri, 21 Aug 2026 07:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1J-00019X-G1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1H-0007Zx-IZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so5866745e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310162; x=1787914962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gDfut0uAhYBlev9mWhTT7UDrgSY0wWCSRE5ndjMg/dU=;
 b=W74ggF06lGfyaZ66P0cYlDtBgW1oqjGxuiVOvpHAt3nIXShhTI6Qvaa6Fmm+/hCBAL
 kRyObW2ZxhNtHi13oQvoRA2uz+kUGMTEOZOTAFHxaEgZ3iIDL7PgwZTt905ZzzCykSYF
 JdP7wVf+nqRluBC27MljYPsX7lSQ2XHO3wSW57DlsEPGqQCCR1aYtq3e2YbIhAm27d3F
 gpcfRf36zO1osfXBfehPNrcz0w8pgEfQmu8fUuuHpeyVOIwYSg0kZWGlRtUcyjeavC44
 FhZqhm6T45gcfZT9kOvU0xNEgpgTlfY+oy/fWKfQaY50qCVq64wOJpYWV6ylj6mEQdsN
 hV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310162; x=1787914962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gDfut0uAhYBlev9mWhTT7UDrgSY0wWCSRE5ndjMg/dU=;
 b=SFQilVD12UwrMZW8qIKHCHakjcWu3HTlmjafNLwyzNM9vkkdUKt0J+CfJeB4NLpP6e
 RJpaMEEuPUVW2AY4NLtbSEIzP7hGAkJ3ZzmbJVlUGhjLOMk+bBLSEBI+jVytw0y8hK00
 H3cyH31dPV8z83IV3Mz9FPyw1G2VsKZmgjiEtpOondyFBMIWIJbkTpwXtyKBRBstzxaL
 KBHhm2kJ8mPLYQOVaFH7zJoNzwPj2dxlfNgEqRY49kfhdWapgBt1sKObU7KISY+uqx1L
 ug1P4Xy7XGbERtmmE9ECZt+s7AW4ujeTyc+b4LXQfbLUXrCgPDmxQ0gMoN6WHgIhWV50
 Rq3A==
X-Gm-Message-State: AOJu0YwKkAz7jS0L4PWEj5Q6vjB4/tW8smR1oC0STwETzZPfseykeQ8x
 dqp9qYzFYHmLpeTAebVoKKRFWuu8omSUSoG4T9uTPGLSkTITuDPWFKqI2APJ+//Sz913HZmDOqg
 3k6Fm
X-Gm-Gg: AR+sD12vhByCzt2yHEJuhqyRsfCpfoZk7fJuuo7wysYKSouGKvK5YOdP/h4HgUwp1e0
 D2VS81wfRB46PAIuNEyOoAIkSUpZHnkyZc7Z/xX+ofCY+P+4oMJxGzyoH8DlmsEjGSwKGBI78p0
 J3DqfJazaQWq9HcL3mDmH2h9L8MFc6+/fi7TrQ8Pvo+sFwIn+CuBM0V8mFpJnZBqD9fSXvW7+qh
 kRnS/6WK+Us7IKvKoO0bOFwqWxQLZeaGpzigzaGozlzv4KpV8j0q4mpRpYijjieS6gx7VcUEeaE
 syfv3Cg7rl323p+XJmYWz6FWP91aQ0BchTxSfWt3lHI/OlCA2RD6bVkyy8FypS22raNVrhyRROh
 K+ppI2EWu9L5CyXWcbSJ5SgLSUM5vWjtQvQFT3s4B/bcRyikguiMIGT1MJOXvfE/jrSFjoLU5Io
 EBx6PcUP1fPGm0VWT9LVWUBnFZaKHUJFsM7ZC1qIl6oBaSC9zDgp7OdnUizaAdtPJZm+pGWKtFX
 8mFqv0WvcWqBA1OpxWrT4u8Zgf7O21sfUX26wvJVC1rJsJnc6zUEqi9egfhfrz9IpiZFQ==
X-Received: by 2002:a05:600c:1387:b0:499:7a4f:d13d with SMTP id
 5b1f17b1804b1-499b8313ad3mr66282195e9.4.1787310161965; 
 Fri, 21 Aug 2026 04:02:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/43] hw/arm: realview: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:58 +0100
Message-ID: <20260821110101.3971391-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bin Meng <bin.meng@processmission.com>

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Give all four realview machine types the same RealViewMachineState
instance struct and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-18-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/realview.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2b9f3271d62..0c2daf5c01f 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -39,10 +39,11 @@
 
 /* Board init.  */
 
-static struct arm_boot_info realview_binfo = {
-    .smp_loader_start = SMP_BOOT_ADDR,
-    .smp_bootreg_addr = SMP_BOOTREG_ADDR,
-};
+typedef struct RealViewMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} RealViewMachineState;
 
 /* The following two lists must be consistent.  */
 enum realview_board_type {
@@ -76,6 +77,8 @@ static void split_irq_from_named(DeviceState *src, const char* outname,
 static void realview_init(MachineState *machine,
                           enum realview_board_type board_type)
 {
+    /* All realview-* machines embed the same state as their first member */
+    RealViewMachineState *rvms = (RealViewMachineState *)machine;
     ARMCPU *cpu = NULL;
     CPUARMState *env;
     MemoryRegion *sysmem = get_system_memory();
@@ -202,7 +205,7 @@ static void realview_init(MachineState *machine,
         }
         sysbus_create_varargs("l2x0", periphbase + 0x2000, NULL);
         /* Both A9 and 11MPCore put the GIC CPU i/f at base + 0x100 */
-        realview_binfo.gic_cpu_if_addr = periphbase + 0x100;
+        rvms->bootinfo.gic_cpu_if_addr = periphbase + 0x100;
     } else {
         uint32_t gic_addr = is_pb ? 0x1e000000 : 0x10040000;
         /* For now just create the nIRQ GIC, and ignore the others.  */
@@ -387,10 +390,12 @@ static void realview_init(MachineState *machine,
                            &error_fatal);
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
-    realview_binfo.ram_size = ram_size;
-    realview_binfo.board_id = realview_board_id[board_type];
-    realview_binfo.loader_start = (board_type == BOARD_PB_A8 ? 0x70000000 : 0);
-    arm_load_kernel(cpu, machine, &realview_binfo);
+    rvms->bootinfo.smp_loader_start = SMP_BOOT_ADDR;
+    rvms->bootinfo.smp_bootreg_addr = SMP_BOOTREG_ADDR;
+    rvms->bootinfo.ram_size = ram_size;
+    rvms->bootinfo.board_id = realview_board_id[board_type];
+    rvms->bootinfo.loader_start = board_type == BOARD_PB_A8 ? 0x70000000 : 0;
+    arm_load_kernel(cpu, machine, &rvms->bootinfo);
 }
 
 static void realview_eb_init(MachineState *machine)
@@ -431,6 +436,7 @@ static const TypeInfo realview_eb_type = {
     .name = MACHINE_TYPE_NAME("realview-eb"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -453,6 +459,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -473,6 +480,7 @@ static const TypeInfo realview_pb_a8_type = {
     .name = MACHINE_TYPE_NAME("realview-pb-a8"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -494,6 +502,7 @@ static const TypeInfo realview_pbx_a9_type = {
     .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.43.0


