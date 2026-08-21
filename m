Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F58BC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1K-0001K7-Sd; Fri, 21 Aug 2026 07:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1C-0000us-Ig
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN19-0007Xv-H8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-495437bb891so4359935e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310154; x=1787914954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OORRY6R7krpOHz801JATma95E9xqPBNTjEyL2kX76xo=;
 b=t2uDpIdtJxWKNlsPIiEeStLUCkq4q0x7D1zf8nEzk/FrLCQw+E8/LLJ+iwNGUKKkuZ
 NcdiH4V5nZuOZLNTIZHO8Sjx4O/e+IJD1m431elMYvxxgCxbR6+l9DroJwj+6xI1Ou3m
 Z5YsoC2Fsi0P/W3n1Iwmwd+KWp4uFH3axUb+aNpk+Ppk5bKb88aVm7AoK8K3KqL7Ls7c
 penyTirgRVAy9WVUgta6iYO3zlaTDINeD3HUEE4+8BRt+gy+0XyF+GUh9sAgNN8Il3VE
 YLeDHX3gyOF5xgNaghZiGx4WP1aHZ92WwhOjShP2Tm9/sdjCNduSWfMBG4cW3MWFFbL3
 S/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310154; x=1787914954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OORRY6R7krpOHz801JATma95E9xqPBNTjEyL2kX76xo=;
 b=XDLOYFJE7PmBZmtzIIXnBfsiJBAaMnZjLL2PXnyNtrSp85LyRRzGsvCuI89tZ1ZyfS
 9CEtR+1GWMgC82yfNLMqrwgH6ApNWmu1b0boqkiuFSNUHj4fsxrXze/4/8mSpp1N0v3x
 2gK7yrQGTQx9yYFEDn12Ac9Kjq23YBBX8o32+eBdd1WkgyV0N4w8XSXMzekSJNyyXrYC
 2ACuKtKRF4aWiIK3boV1uHUDh6VcAn8CvCZGbwb+yCfBhwr6MjfOEUXxGcgK7R7h1Wu5
 5Ew9ez3ZAvbYbhT9KwN0OI/pxIxsa41O9Qi6rlWfqqjqUV+9zqriGxKWsfFlAYy6ZfB3
 H1yQ==
X-Gm-Message-State: AOJu0YzOHw/FxGxyYi+W9Mn49ZhbFQbGqBzU7g8gKuHdhEqNtMOB30W9
 SInqlRJK2jts5DXtvwaYess/8sVnWNikhNwJ6zmOYBxIrTsnxESyK+OWmCC9XGJ11p6wDdeEyJh
 ZAHTu
X-Gm-Gg: AR+sD12vyqdFLHYLSJ9hY74S2FIR+x4gZPTUITUbeQ+j7zvasnisBSfFt3yo9VybptF
 46UgxxhJ1uJiurGxL4hHzLuGNbLDF5EA31SYcOQW5m8mGpHoiu6IlEQUUEEl18ovpszlu3gGLNw
 AwUuaxgY/F7oY0bHVoryyH1x9BRBdZVWNbp6GLOb3fQpVKwB8YPGfgGT7ICZU88u81byZcQ1iR7
 un4Q9DSvAW95zj8QiTaBQqdq3TKOs/CB98kbmOjzOI9Jog1eRs3UiOUeRouQVGWjkAVzvbLRXpA
 BeItS94a14vuSX47SezGX/LSaJ+Z7Psm9NF2VQfbYxwoOy2ZW53Ib89ipX5pBxNi0xuT0JJn6Lb
 KLJ4QgEJY4oxHUEuBd1kkBo1izOYekgTg4/zxlXkc8K+nNzyPvZHpkkIoVWwKg7zr0OlvhGYffu
 oubiIDvmH0iU+FgE1ddTdkBbzWTUs90DXomEWhy+IHOFqa8oKeZDczBnKum7D6JWKXC6/sbZf31
 XYnws1W1rgZOopYr6wA1gUsnh4vjrPxsyClRr/Ybta0MTPSJybTlk0jO8wPKS9HLW9hig==
X-Received: by 2002:a05:600c:350f:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-499b90be53bmr44647745e9.0.1787310153899; 
 Fri, 21 Aug 2026 04:02:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/43] hw/arm: integratorcp: Store boot info in the machine
 state
Date: Fri, 21 Aug 2026 12:00:50 +0100
Message-ID: <20260821110101.3971391-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Move it into a new IntegratorcpMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-10-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index c25bbf3c82a..f8bcf42c615 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -581,13 +581,19 @@ static void icp_control_init(Object *obj)
 
 /* Board init.  */
 
-static struct arm_boot_info integrator_binfo = {
-    .loader_start = 0x0,
-    .board_id = 0x113,
+#define TYPE_INTEGRATORCP_MACHINE MACHINE_TYPE_NAME("integratorcp")
+OBJECT_DECLARE_SIMPLE_TYPE(IntegratorcpMachineState,
+                           INTEGRATORCP_MACHINE)
+
+struct IntegratorcpMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
 };
 
 static void integratorcp_init(MachineState *machine)
 {
+    IntegratorcpMachineState *icms = INTEGRATORCP_MACHINE(machine);
     ram_addr_t ram_size = machine->ram_size;
     Object *cpuobj;
     ARMCPU *cpu;
@@ -680,8 +686,10 @@ static void integratorcp_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xc0000000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[22]);
 
-    integrator_binfo.ram_size = ram_size;
-    arm_load_kernel(cpu, machine, &integrator_binfo);
+    icms->bootinfo.loader_start = 0x0;
+    icms->bootinfo.board_id = 0x113;
+    icms->bootinfo.ram_size = ram_size;
+    arm_load_kernel(cpu, machine, &icms->bootinfo);
 }
 
 static void integratorcp_machine_init(MachineClass *mc)
@@ -696,7 +704,9 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("integratorcp", integratorcp_machine_init)
+DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
+                        integratorcp_machine_init, false,
+                        arm_machine_interfaces)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
-- 
2.43.0


