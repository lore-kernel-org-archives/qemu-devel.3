Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B782C5DF8E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1U-0001yd-BV; Fri, 21 Aug 2026 07:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1F-0000yE-CE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1D-0007Yj-C2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-499acf0fb55so4588245e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310158; x=1787914958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sk2+v2/9QdWzWPCYo+tcVu+g/i4C/qMtLjEeWY+x0ak=;
 b=PjDJOueHJYLsaZz/wzj5rIZ6qMb1rQsbHwnMRFr4E4OKsU9PDeUgMQMjeFOagea+Un
 w/7117yeoXVq02NBF5dgb0GOSuYpm1QgBgq4k+5bTu10R2sbglAG2URgr3XhmF+kmiNu
 5MSWTBIMdg0RsKrosvOLAvMXEBsWQz5fXC7sFpDUZj+hfTScCSlh/JVdYo/1Vuijx9ho
 22U3FkDPJR5ZiPQ3sJ7wXQYcKseQPgOvFK+7g8uValYQN43KpNMn3+TYcTPxCVhfg3iu
 v0EQN608jAjJ1MhcPmlMDN6QrRGX2BupHteFNuwjS1WEXFmHysTN79TcYC24oxB6p+7C
 TF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310158; x=1787914958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sk2+v2/9QdWzWPCYo+tcVu+g/i4C/qMtLjEeWY+x0ak=;
 b=ReLLY/qtv3hFlW99TE96MpPyEUDOxiw41A+4/YXS8LBgC351nkF+oxmYSWOOrbOvsW
 80Ih7I0rvjV8pamTl3PxCHuT8jLdqGE0WQ2bax3Xbd/2+m0gROJCpxs+Hf9SmWpMSAC6
 tBF/fF1UPA0HN0JVnI14fDf/0q52xysBeh49G2MxNdRNFrmFVhpyRLy4R86VSklkRR1J
 EXJ+AeNNcalf8nX0qNN9A21m6SgAu+OxRDxGjwXRVboZHgoxXFS7U43gAlX5FdfAuihk
 N7aLYi1beQhyU/R1xdnK28bx3cxm2p1MZluh9jMFfauSvgblWOifxY/UxcLIt0L4NwWa
 6slA==
X-Gm-Message-State: AOJu0YzGmsc1O0lB0yS7PwRaYwWRqvFkKc+xpfw5KcHbHcdiTET5VIns
 2fPJjyeimizkSHPpt0WGkZS3TJDVf5vb36Y0heNAa5m2zXU2VT3XODwJALhvGWpAg6gIxPDjQNt
 JzTeI
X-Gm-Gg: AR+sD12FKxvBuAhMYCGXnrXkQzX3HeTxQnwlLwpmUEGei1GWHqATRhkiXI0pmOTTqTN
 JV7VpPGe7tTirkwxEnbGQ7ygtfjKr9Lb562BcFAj4e3+QaUX0fdezPmTZGz37moLTPpZZaVN7Wc
 BN9+12/eaFA5M/oiIAAB5XetXedS6xBKvekjsnJqBzwev09FtLmHMYXTwNaXycur1peKuU1ZuJ8
 j/G14PefU8YIZErD4KiBGsC7Q5i4Y5FN0YeyKGfhJMonEtyzty9MHWGlC4Ce2VFAHIx5ODjMewa
 fKEFNMUdIP+bbfaY9v1h+mb4M/BpkiGsVlw77/uE15A6Vu5WVM1CfSDEmdw60uYdhRDfNR2c+17
 JHXpizpjJCnQph7+Ag0zKcmwK+JJzMRL0poENcfmkQ4cv9DWxrb8SaWV2spvxoNAl4ci/2zxRs3
 ZGr5NrJdVyyYGflnYotOlQxCQq98AHFubLqB+RueeFcJGMRhkDDs3h7/TslctdkbCg9knQN26vW
 A+VF9mff9XYnp6m4nvoLHqTO761bxdZGIbNDZdwGcTL2d5876TbsXjYEUwzyjFpdQuo2Q==
X-Received: by 2002:a05:600c:4e56:b0:499:728c:4704 with SMTP id
 5b1f17b1804b1-499b8461b32mr82896775e9.12.1787310157941; 
 Fri, 21 Aug 2026 04:02:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/43] hw/arm: npcm7xx: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:54 +0100
Message-ID: <20260821110101.3971391-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
rather than to a file scoped static object inside
npcm7xx_load_kernel().

Let the caller own the boot info: the boards store it in their
NPCM7xxMachine and pass it to npcm7xx_load_kernel(), which only fills
in the SoC specific values.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-14-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx.c         | 26 ++++++++++++--------------
 hw/arm/npcm7xx_boards.c  | 10 +++++-----
 include/hw/arm/npcm7xx.h | 10 ++++++++--
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c27f149c04a..695f30a0dc2 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -364,22 +364,20 @@ static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
                        NPCM7XX_SMP_LOADER_START);
 }
 
-static struct arm_boot_info npcm7xx_binfo = {
-    .loader_start           = NPCM7XX_LOADER_START,
-    .smp_loader_start       = NPCM7XX_SMP_LOADER_START,
-    .smp_bootreg_addr       = NPCM7XX_SMP_BOOTREG_ADDR,
-    .gic_cpu_if_addr        = NPCM7XX_GIC_CPU_IF_ADDR,
-    .write_secondary_boot   = npcm7xx_write_secondary_boot,
-    .board_id               = -1,
-    .board_setup_addr       = NPCM7XX_BOARD_SETUP_ADDR,
-    .write_board_setup      = npcm7xx_write_board_setup,
-};
-
-void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
+void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc,
+                         struct arm_boot_info *binfo)
 {
-    npcm7xx_binfo.ram_size = machine->ram_size;
+    binfo->loader_start = NPCM7XX_LOADER_START;
+    binfo->smp_loader_start = NPCM7XX_SMP_LOADER_START;
+    binfo->smp_bootreg_addr = NPCM7XX_SMP_BOOTREG_ADDR;
+    binfo->gic_cpu_if_addr = NPCM7XX_GIC_CPU_IF_ADDR;
+    binfo->write_secondary_boot = npcm7xx_write_secondary_boot;
+    binfo->board_id = -1;
+    binfo->board_setup_addr = NPCM7XX_BOARD_SETUP_ADDR;
+    binfo->write_board_setup = npcm7xx_write_board_setup;
+    binfo->ram_size = machine->ram_size;
 
-    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
+    arm_load_kernel(&soc->cpu[0], machine, binfo);
 }
 
 static void npcm7xx_init_fuses(NPCM7xxState *s)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 57a8d3186e6..4f14d257465 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -374,7 +374,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm750_evb_i2c_init(soc);
     npcm750_evb_fan_init(NPCM7XX_MACHINE(machine), soc);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void quanta_gsj_init(MachineState *machine)
@@ -390,7 +390,7 @@ static void quanta_gsj_init(MachineState *machine)
                           drive_get(IF_MTD, 0, 0));
     quanta_gsj_i2c_init(soc);
     quanta_gsj_fan_init(NPCM7XX_MACHINE(machine), soc);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void quanta_gbs_init(MachineState *machine)
@@ -408,7 +408,7 @@ static void quanta_gbs_init(MachineState *machine)
 
     quanta_gbs_i2c_init(soc);
     sdhci_attach_drive(&soc->mmc.sdhci, 0);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void kudo_bmc_init(MachineState *machine)
@@ -427,7 +427,7 @@ static void kudo_bmc_init(MachineState *machine)
 
     kudo_bmc_i2c_init(soc);
     sdhci_attach_drive(&soc->mmc.sdhci, 0);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void mori_bmc_init(MachineState *machine)
@@ -442,7 +442,7 @@ static void mori_bmc_init(MachineState *machine)
     npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
                           drive_get(IF_MTD, 3, 0));
 
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *type)
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index eef7cc5332b..9f3dd489ecd 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -19,6 +19,7 @@
 #include "hw/core/boards.h"
 #include "hw/adc/npcm7xx_adc.h"
 #include "hw/core/split-irq.h"
+#include "hw/arm/boot.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/i2c/npcm7xx_smbus.h"
@@ -62,6 +63,7 @@ struct NPCM7xxMachine {
      */
     SplitIRQ            fan_splitter[NPCM7XX_NR_PWM_MODULES *
                                      NPCM7XX_PWM_PER_MODULE];
+    struct arm_boot_info bootinfo;
 };
 
 #define TYPE_NPCM7XX_MACHINE MACHINE_TYPE_NAME("npcm7xx")
@@ -129,11 +131,15 @@ typedef struct NPCM7xxClass {
  * npcm7xx_load_kernel - Loads memory with everything needed to boot
  * @machine - The machine containing the SoC to be booted.
  * @soc - The SoC containing the CPU to be booted.
+ * @binfo - Caller owned boot info structure to be filled in.
  *
  * This will set up the ARM boot info structure for the specific NPCM7xx
  * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
- * into memory, if requested by the user.
+ * into memory, if requested by the user.  The boot info is owned by the
+ * caller because arm_load_kernel() keeps a pointer to it for the lifetime
+ * of the CPUs.
  */
-void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc);
+void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc,
+                         struct arm_boot_info *binfo);
 
 #endif /* NPCM7XX_H */
-- 
2.43.0


