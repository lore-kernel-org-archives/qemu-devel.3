Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E90C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1M-0001QU-3i; Fri, 21 Aug 2026 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN14-0000j8-TG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN12-0007VL-95
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so7648575e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310147; x=1787914947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tdwp4aUV0FuWOV3NHOQRHCUGQ71NyoUxAiznLkuyZp4=;
 b=eYAL37Vb0p1Efp/JVEhRYFotQywEI/x7XSK88+fFxaRrP+0K8A5h0XZ15LnIws18kp
 dNrToZnnwCtsZIa9Rv74bjghEhAA8XfRU/XKXeoaRamLlfFe6xFauWi4Uk5+qei0xepZ
 tn/Z1gH4rOtwkxIrXznWpbpAZ8SByb3VsWSBc1hk1LluHXIkCxXBNdffT650XESMkycJ
 YlLMJOgd30It68ZQvf3uOw/c4wvlNEXXlD5SpoU8VdbuAZyNqcjGbCAFIC7k1F9cUhKN
 l3wc4KJrrJOf/WV/g0cUG6fyOnCLc3pO08CVc4gu2zXFbJ+KbclcXMpgom647jzTCSVQ
 AU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310147; x=1787914947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tdwp4aUV0FuWOV3NHOQRHCUGQ71NyoUxAiznLkuyZp4=;
 b=KC13klx1Sy5D2b5xlq15olxF3c1frlJiv2V3QBEyMme7UAa5GqPGYO/tDbVQz7vSpU
 AL8ZfLd/VOUmomxzCrWWHmppyJpWThXMAJIGHTQQ/L5oKhThCC8cH+mtKN8N5QY6Nqhx
 YyrjAbGJnExj4QVforTnq5mqmrgZNXPLBNxvZsQNWUPVBNUJ/b3BouD/2DHqG/PyhmZ+
 5NlvjDHIuo5/HxiNNa38eZ8546LarkTNIybhxHQwccV9rSs9HYCu1PclwSnU7FpgGa6L
 iFszazJ8b7djqPg87alc2Ds69n2crNBCCstz7USoLFXOYuN2XCWtbo1BMYWzf3ObKaZR
 Yz3A==
X-Gm-Message-State: AOJu0YzKpHDkxpS0lvq7a6Q7gcnaeM8MK5CoGEEhOgxVGi4T4EP/iroL
 vaL5r3AVwUEyNhvcVUzIbPmcvVT6t8Xz3AcXWLjhXoUph5xw/h1Q6bvKREgxplVomglrUfQtFIk
 Syl7J
X-Gm-Gg: AR+sD10xKvvyfwz3aB7qyIQ/9ckr8cEW5HqTNF7jK9zlnIzMAHvZxUxAHkqwqV+gmxd
 ovcCl0fFYD4x6QxBlZ69ds7fP8j0mUwWwlX6+weSrR9kURBwpFzEgYmJ1fnMv4lsjh89LR8QQzi
 T6GzYYClovzt8hsoqpBWWE92CpD8oKprIWmDzTJhr5548G0p9IMtyfFcfC6UJRp/JYjB3YAWo8T
 JBUdPNQyGa342QMPrDHbujzNRAi7kUQviyk+7DUImpkaoA+1a9GJ/3owM7KZgIhy1goDLfu76rv
 ZDU8V++NddcGTDxqI1FWaTFJHISEAKzEwaxgWjPjrzqoMxBDf1uplKwVuAdhvOxDj9MOAi71EOj
 0LRzDHApo9WBsnJIBPR2AL/7ayZca/teuEKkRYqfBpEWRoBXxxrfeO2hvYNUb3pjoIhTPP1Vhrs
 y5KuT4QpGcjf8aqEG42jIvNdaLNZxSPoP9R261czMqBE9GPmxq8g+m9jWQFg2Oq01eoZ3PJlRf5
 +0UfMD6e1EJEYiRwIRpr/WdUCgM/+tcTi1gn3woPcDmS+hObKeqrOsP3q1MjaDTGK4IrA==
X-Received: by 2002:a05:600c:628d:b0:499:795a:c5fc with SMTP id
 5b1f17b1804b1-499b832643emr81034235e9.7.1787310146655; 
 Fri, 21 Aug 2026 04:02:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/43] hw/arm: bananapi_m2u: Store boot info in the machine
 state
Date: Fri, 21 Aug 2026 12:00:44 +0100
Message-ID: <20260821110101.3971391-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Move it into a new Bpim2uMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-4-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bananapi_m2u.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 9b468cd8ac8..0079aa1dd2b 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -29,7 +29,14 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 
-static struct arm_boot_info bpim2u_binfo;
+#define TYPE_BPIM2U_MACHINE MACHINE_TYPE_NAME("bpim2u")
+OBJECT_DECLARE_SIMPLE_TYPE(Bpim2uMachineState, BPIM2U_MACHINE)
+
+struct Bpim2uMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
 
 /*
  * R40 can boot from mmc0 and mmc2, and bpim2u has two mmc interface, one is
@@ -62,6 +69,7 @@ static void mmc_attach_drive(AwR40State *s, AwSdHostState *mmc, int unit,
 
 static void bpim2u_init(MachineState *machine)
 {
+    Bpim2uMachineState *bpms = BPIM2U_MACHINE(machine);
     bool bootroom_loaded = false;
     AwR40State *r40;
     I2CBus *i2c;
@@ -120,10 +128,10 @@ static void bpim2u_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(),
                                 r40->memmap[AW_R40_DEV_SDRAM], machine->ram);
 
-    bpim2u_binfo.loader_start = r40->memmap[AW_R40_DEV_SDRAM];
-    bpim2u_binfo.ram_size = machine->ram_size;
-    bpim2u_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    arm_load_kernel(&r40->cpus[0], machine, &bpim2u_binfo);
+    bpms->bootinfo.loader_start = r40->memmap[AW_R40_DEV_SDRAM];
+    bpms->bootinfo.ram_size = machine->ram_size;
+    bpms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    arm_load_kernel(&r40->cpus[0], machine, &bpms->bootinfo);
 }
 
 static void bpim2u_machine_init(MachineClass *mc)
@@ -145,4 +153,5 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("bpim2u", bpim2u_machine_init)
+DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
+                        bpim2u_machine_init, false, arm_machine_interfaces)
-- 
2.43.0


