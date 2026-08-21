Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08F5C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1M-0001RG-8f; Fri, 21 Aug 2026 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1B-0000ue-6k
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN18-0007Xf-Gm
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so492093f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310153; x=1787914953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VtCtqDJnzt5NurG6KBHFtJkEwweKFqZTgZ904LHAtlY=;
 b=Lbkuv3UR3NUJmjAMZ9M6tIQ1LS1EohAdGJgCxvaafJhwMufcXxng3uv9B+2txdA1jm
 bqxoR5aK8qxY4v9hmOB5X4C+kk4+pmqof41HNkkO1Aibxi0Uk7OIlYU8IxTSSaOKffOZ
 zeWJcSmJOQ8ccdMKiJ/LBOFYfL6Es6yCAMr403QlY4jDYCufHj4/bi1k0uE0kh193575
 46jhdSwN7HzuTSH8R61u9h0yxtqA8NXzZXgMGDymkQ3f7x/oM/3CCyQM40zdmThBlL/o
 Exbh0799fmwfT9JNq4OPlXQwpyo30ER+D8StSwnPupTFdKEPNyS6gfgeB1uWlK+8bwM6
 54YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310153; x=1787914953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VtCtqDJnzt5NurG6KBHFtJkEwweKFqZTgZ904LHAtlY=;
 b=QyR5jib7sW10FH+YMuVSMIqZi8fRRz2aIMdhQtKnN+YdT0iRT2jydDRQQQ5OoJLMz7
 rGoEbJqDbl0yPsxDmw3IvNa5b7DjEl12KrGAOYAC+ANmMIxrYx++tXXZcqHad8ZnSeD9
 k1cU/W1jyJJGEn7hAMGag97/vPQEetQuYqb4P4uzXjtXVIsGr4WJ/57duH7LnDs6jUx5
 +AxwhF3ECvyZt1K71jPoTBF1wfy0oV18kyNOyV1eTBXggnbdRaId+yQ/UHC5FmvzjetA
 uNnRO5XJ6fi/rVSRgbfgEedmzUv5OSOqoymGfSJNZbt41N4R+tSeVmsaPtlwAttc/0XR
 LmLw==
X-Gm-Message-State: AOJu0YwjUjRmwTSEZAQNdSlzc+loMonpf2xyRiiKhQg/eVto7eZ9H+cT
 AB5qemtiPmQvbn1zejsSqPEUokN7XQQ+F2x4CGHeZsRWlZLHZ7WH2L/CaQncwy4xHqjZ1FkuQKY
 EgrKE
X-Gm-Gg: AR+sD13czRTD53nLU7W6R5uLfjhDDc0CAwtO0uwZQtI67CVlZgzPP7Q9PctQHoCq8Cs
 hrnmdgDX55hW5O2o5DadLEKKlrt7eKEGfFSbumJAkHFFwGz/kbWxdVP0artqTN+hDY8Kmf1zUiZ
 jgGi+coDQj/p6YOhfg3+PbWhth11XBH2u77wgWWFg15Gzx09e9wS3eJ2bo5vHjwdIjqceQt+C2p
 7FoqYPi2TsOASKJ+K3FA9KoPt3G9lY/z13E8LZC5bIxFVoKxYirFxbX4XBnVBbIY0PB+MNiJ4/W
 sleqQDTAd6s+h0t+3hqpFG6VE6fyjryx+OfqRwftS5t5Ot22lqsm4nzPcWQm4HWAgTBwcWxQT5r
 XrPFTcT9Z6WxejjAse5837yIt0P/WzPHFNSqEVq4HVO6dBZvERHdpWXs5c3Qn32WiYX102YY39P
 GMa51YHscQMow5DXfA+7jl+cUJpaOqOKWBZ4X1pIgXm16p9HsRZe0f9Rv26UoTW57moqdMAtbkU
 y+4XApOxSRBIUlnCJ14ueqVEWVy1suv8CfAfkPlKbujarJGLx7SyiFziFS1wGeDnPdhlQ==
X-Received: by 2002:a05:600c:314f:b0:499:a07d:a482 with SMTP id
 5b1f17b1804b1-499b8454b37mr75535225e9.10.1787310152893; 
 Fri, 21 Aug 2026 04:02:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/43] hw/arm: imx8mm-evk: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:49 +0100
Message-ID: <20260821110101.3971391-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
rather than to a function scoped static object.

Move it into a new Imx8mmEvkMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_AARCH64 macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-9-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/imx8mm-evk.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 6b7774d3e25..019c609c542 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -20,6 +20,15 @@
 #include "qapi/error.h"
 #include <libfdt.h>
 
+#define TYPE_IMX8MM_EVK_MACHINE MACHINE_TYPE_NAME("imx8mm-evk")
+OBJECT_DECLARE_SIMPLE_TYPE(Imx8mmEvkMachineState, IMX8MM_EVK_MACHINE)
+
+struct Imx8mmEvkMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
+
 static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
     int i, offset;
@@ -60,7 +69,7 @@ static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
 static void imx8mm_evk_init(MachineState *machine)
 {
-    static struct arm_boot_info boot_info;
+    Imx8mmEvkMachineState *ims = IMX8MM_EVK_MACHINE(machine);
     FslImx8mmState *s;
 
     if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
@@ -69,13 +78,11 @@ static void imx8mm_evk_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
-        .loader_start = FSL_IMX8MM_RAM_START,
-        .board_id = -1,
-        .ram_size = machine->ram_size,
-        .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
-        .modify_dtb = imx8mm_evk_modify_dtb,
-    };
+    ims->bootinfo.loader_start = FSL_IMX8MM_RAM_START;
+    ims->bootinfo.board_id = -1;
+    ims->bootinfo.ram_size = machine->ram_size;
+    ims->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    ims->bootinfo.modify_dtb = imx8mm_evk_modify_dtb;
 
     s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
                                          "soc", &error_fatal, NULL));
@@ -103,7 +110,7 @@ static void imx8mm_evk_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &ims->bootinfo);
     }
 }
 
@@ -127,4 +134,6 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
+DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
+                        imx8mm_evk_machine_init, false,
+                        aarch64_machine_interfaces)
-- 
2.43.0


