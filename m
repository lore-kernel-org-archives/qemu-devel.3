Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3565C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1U-00020x-Nc; Fri, 21 Aug 2026 07:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1G-0000zw-Gg
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1E-0007Yz-KI
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-499b0eefa61so4871395e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310159; x=1787914959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mra+QSr7xL4AJufg9b5eo4WZM7PgunenWDduQ/wz9f8=;
 b=hrfF0tnp3KvJ0h4n5HOgMkqlwHN8xerg5gdvWopn2pwkBc1G2yfIFpPbi/8ZqD6MzD
 fjRiN4cVTjzLvPZASef0Yt4EGxBfNHqb0kEsfy7fI1xGucmFmoIXtzyBZs1TvIDC2PrH
 YGuY1Nez46r4jvMOWGFLWwUM9Crtcl2TPZe+tDq0akgzwyWld9VrqSuKs7Sb664Y9W5Y
 HnpCwZwXNky4Vzgav/ZREzHe2lY4JwXn/BA7f0/dOc8q72rFpaoCFl+V5CYnjq/mYen/
 jmmvwwCaVMioZoAr3n5YrCglNvoyZI3KcY4+AYZD3mhoWm2h+uKGrLelKUr0O1s+5V8o
 61lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310159; x=1787914959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mra+QSr7xL4AJufg9b5eo4WZM7PgunenWDduQ/wz9f8=;
 b=dXLxEMKO7fNxiUrMKdegakAgo0PbBvQYwJUFWEYh5P1thk2QZDOdfCehG88zDTIkI6
 Fp5p2/h+NiLI6g+jok5KJiJtumCZ3NkmCDg7QTmL0yFMfCghx+WUGi1NNzWjJkMxLKJQ
 nKneBUpolsXx3xGMsEayvLjWsrrbx8kjWIuE4nUmC7sfxfqmylUh4k19P7egpxqFw7R9
 pIuTXcAMmdpwQRtVxZTjVEobu1FLaEXIR12pZN2fcT4DV5xfZ0SBkfbSnm/xEK898vKt
 gPRX4/cuyzkAGB6wzWf8gGrN0sTKEEO7rdDDOmRU0T6hU2XERGre6ZCuvt1UrbHPh8ue
 d5yw==
X-Gm-Message-State: AOJu0YyaTX0WCNTSZKlGkNw5f/C3FjyRP7iSkaWZChpWZWymKESaqJjL
 UcVtIWgoqjLFRHtWS+Zn5vWSviEME00f6nnLC9Lzw2/I6A8vKrfDCBBOeHlWFU9hC4Qhg5t25Fk
 OGJ8A
X-Gm-Gg: AR+sD12VHrh2olb9Srhd4UvMEiq456eePOBgYhhPUpEjllZEEzxsp/x6fl0lavu5GOy
 CGbGJaLiSoHiQPlQFzmnNGVTDte4dNhxWKk4yr1kXpBXMvnnI0hUE628QojjDSbBHQhlwk0VCiK
 I0FpOqvsY6ukuO950RwBVjHngqZA26bOflX/NPVFcDqWaX9UMz4rH94K3T6ASzRPWD8z/PnNIiz
 LPvkt+NteLGN75WMHUEejYA761btwHT2b1XHN8b7EMcsduyl7bG8o8HdcSWMBVyFHbV0BN7cuJd
 XicrcqAfgq/rksgRbx/k56MAc2/hK8krjEKEPEyflcyl0DJjSMdh4eb6k70QJoUXfoC8m36u567
 IJJntWYuDAIqFcrDtMJJ6J66J+yQwePi1kDT9NtQqoFZTjY6lrNl9fS8g5NeDPBacztSxPrPIC+
 QDWzWorYktc+wcelW0xxmOAygPmIQAqElRRMowyJiZ9gf+mMnXwiaP3iNrkbctNMOap1U+Culiy
 MDgV38TE9DM1sP2GbNWqq81nU1wp6z3t24i9tCNdvQoVA9WjophsV9vBjmjcevdDSXAsw==
X-Received: by 2002:a05:600c:1d1a:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-499b8303b86mr76863705e9.4.1787310158862; 
 Fri, 21 Aug 2026 04:02:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/43] hw/arm: npcm8xx: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:55 +0100
Message-ID: <20260821110101.3971391-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
npcm8xx_load_kernel().

Let the caller own the boot info: the board stores it in its
NPCM8xxMachine and passes it to npcm8xx_load_kernel(), which only
fills in the SoC specific values.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-15-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm8xx.c         | 26 ++++++++++++--------------
 hw/arm/npcm8xx_boards.c  |  2 +-
 include/hw/arm/npcm8xx.h | 10 ++++++++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 9ce6ea52d97..7d707a09b41 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -357,22 +357,20 @@ static const struct {
     },
 };
 
-static struct arm_boot_info npcm8xx_binfo = {
-    .loader_start           = NPCM8XX_LOADER_START,
-    .smp_loader_start       = NPCM8XX_SMP_LOADER_START,
-    .smp_bootreg_addr       = NPCM8XX_SMP_BOOTREG_ADDR,
-    .gic_cpu_if_addr        = NPCM8XX_GICC_BA,
-    .secure_boot            = false,
-    .board_id               = -1,
-    .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
-    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
-};
-
-void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc)
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc,
+                         struct arm_boot_info *binfo)
 {
-    npcm8xx_binfo.ram_size = machine->ram_size;
+    binfo->loader_start = NPCM8XX_LOADER_START;
+    binfo->smp_loader_start = NPCM8XX_SMP_LOADER_START;
+    binfo->smp_bootreg_addr = NPCM8XX_SMP_BOOTREG_ADDR;
+    binfo->gic_cpu_if_addr = NPCM8XX_GICC_BA;
+    binfo->secure_boot = false;
+    binfo->board_id = -1;
+    binfo->board_setup_addr = NPCM8XX_BOARD_SETUP_ADDR;
+    binfo->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    binfo->ram_size = machine->ram_size;
 
-    arm_load_kernel(&soc->cpu[0], machine, &npcm8xx_binfo);
+    arm_load_kernel(&soc->cpu[0], machine, binfo);
 }
 
 static void npcm8xx_init_fuses(NPCM8xxState *s)
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 042a928857c..f462369bea3 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -198,7 +198,7 @@ static void npcm845_evb_init(MachineState *machine)
     npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm845_evb_i2c_init(soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
-    npcm8xx_load_kernel(machine, soc);
+    npcm8xx_load_kernel(machine, soc, &NPCM8XX_MACHINE(machine)->bootinfo);
 }
 
 static void npcm8xx_set_soc_type(NPCM8xxMachineClass *nmc, const char *type)
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index a8377db4905..676c82150db 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -23,6 +23,7 @@
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "hw/mem/npcm7xx_mc.h"
+#include "hw/arm/boot.h"
 #include "hw/misc/npcm_clk.h"
 #include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
@@ -62,6 +63,7 @@ struct NPCM8xxMachine {
      */
     SplitIRQ            fan_splitter[NPCM8XX_NR_PWM_MODULES *
                                      NPCM7XX_PWM_PER_MODULE];
+    struct arm_boot_info bootinfo;
 };
 
 
@@ -122,11 +124,15 @@ OBJECT_DECLARE_TYPE(NPCM8xxState, NPCM8xxClass, NPCM8XX)
  * npcm8xx_load_kernel - Loads memory with everything needed to boot
  * @machine - The machine containing the SoC to be booted.
  * @soc - The SoC containing the CPU to be booted.
+ * @binfo - Caller owned boot info structure to be filled in.
  *
  * This will set up the ARM boot info structure for the specific NPCM8xx
  * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
- * into memory, if requested by the user.
+ * into memory, if requested by the user.  The boot info is owned by the
+ * caller because arm_load_kernel() keeps a pointer to it for the lifetime
+ * of the CPUs.
  */
-void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc);
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc,
+                         struct arm_boot_info *binfo);
 
 #endif /* NPCM8XX_H */
-- 
2.43.0


