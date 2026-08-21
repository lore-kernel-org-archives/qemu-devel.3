Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E95C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1T-0001rT-Uf; Fri, 21 Aug 2026 07:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1D-0000vG-81
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1B-0007YL-Eb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so6796105e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310156; x=1787914956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qd+OWW3qU6A06engUu0NRn2PFP6Sh3jtFDKQxp24mZ4=;
 b=Fp3ATfco0GFmnIr/5bqgXgPmdyLz3HTTs9l98QJXMWpl8aF6uSc7/3QGBVdMgR9vxy
 Khj0CCdQTc629k7WDs/YihvYMsq4EauvuTBVMlRfgAJfATDzBXMaGushRN8JGDC4GfrJ
 BinuZbHZWYJaaObmThTxAn4/XtcEoQ8qrgsnsmzb2m7DXlmSd/Km49tT/wK9GRTm6YvG
 eY/S9r54iSVmxcaiSKyH/FMavHsXdxZe6odnLyyisADNbxmP1psim9IF2ggEzondxJ15
 bZWLPlnib74Mx4gJCseR+hzj1EGbauejsO4xidxQoFgmLjsUIUbdMbQqv3gvYUgNuZgD
 13Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310156; x=1787914956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Qd+OWW3qU6A06engUu0NRn2PFP6Sh3jtFDKQxp24mZ4=;
 b=MvXKEZKvj6EOv3d7dEIboq7UgPBB0Vi7tfF/7PQExjAOwYQ8J1hfpsFWtDHyzvoXyp
 STWbTUWQnNvoVRkgfqQERo6vmx/LShc01shB+/ohQZXvtkLwG9BDkmrrK/RY6UHHWYlp
 hrWv/b+EfxzdKTyliSmOLrL0NpNYmfo1+ebyrks8lpNhLhOSiJoiE0WbAF8vmYILjSxt
 SiQSKi1h095P/qIF1cHBfIWcc5MXLTYEaP/02K51muSTotr+WMHikupUTOCPE31V2ngB
 Bf2TT+AbpWrPh4R5umW1wH1YAtNcX7d1MyHNloDk5sGtnmwHXCL3HqeJ74D3QC8j39L0
 k/sQ==
X-Gm-Message-State: AOJu0YwZvIHqj+UNUTPGXwpoX58zkyP1J8kfZrSCh3LPJPFe2ECsCfmk
 eLHxat09+C3EY6vUfQeGJXQ6o1rT8P7FSSp0pBi7Vmpqzx5rYWSvy0/cGHQDMhn8Gt1alPS0+dn
 kFoJt
X-Gm-Gg: AR+sD13VmvFakgPihNeDRe2sUd2Z6Qew0y9zVv353wkWT7W7LCLxdwb9JVYDgODdfRb
 rC3mQ88QDZx/cvuiXndHEJR6YhW32bKXWyveY8p2+QZhnANVEVjvxuKHVFErzq9SrM+8jqZeXIY
 aO8cn3F0zjb1WaRBTXFbLB/uxkNOCvzVTXsKxDXQYfQxK6oD7MpjRwgfwOkM6q5G0rYy79BWInZ
 Q7cocT1+N0vs+i6+sflkc4/RvzuxY/zAn3GXEgiekvXFxWBXV2u7QUqwsXIgjcVZ2LT8/0YBHZW
 Zz2cg/NXEwoYigKGOiKgPPwfAMzwefd7N8Ra4XQeIY7yqwD2qBGDNlb7i2kVGT4Rf2j7NEeASyh
 2D0S1sNLE/BmTNW2vJdDWk2iAYPHQEiEWscYEI56Lb8fBzhyPRygbiikE/HE4iSk5Mf7eU50/TA
 c4i5nz+RefLH5In8ZQ6bXGFcGrSRMEk4LaQBlfhnBKsFSN13tzDvQvR+17aYm8OR228cynuyYKV
 i9OrH+0eW4m631hEbfqLIg1IpRNVyU/nqPAzFC0xWUxNBYeTUjdq/YLuKID06OEkh+Ppg==
X-Received: by 2002:a05:600c:8b77:b0:499:48bb:417e with SMTP id
 5b1f17b1804b1-499b82f4163mr87353215e9.2.1787310155931; 
 Fri, 21 Aug 2026 04:02:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/43] hw/arm: mcimx7d-sabre: Store boot info in the machine
 state
Date: Fri, 21 Aug 2026 12:00:52 +0100
Message-ID: <20260821110101.3971391-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Move it into a new Mcimx7dSabreMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-12-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mcimx7d-sabre.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index a0ac647c3df..22fe1fa932f 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -22,9 +22,19 @@
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 
+#define TYPE_MCIMX7D_SABRE_MACHINE MACHINE_TYPE_NAME("mcimx7d-sabre")
+OBJECT_DECLARE_SIMPLE_TYPE(Mcimx7dSabreMachineState,
+                           MCIMX7D_SABRE_MACHINE)
+
+struct Mcimx7dSabreMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
+
 static void mcimx7d_sabre_init(MachineState *machine)
 {
-    static struct arm_boot_info boot_info;
+    Mcimx7dSabreMachineState *msms = MCIMX7D_SABRE_MACHINE(machine);
     FslIMX7State *s;
     int i;
 
@@ -34,12 +44,10 @@ static void mcimx7d_sabre_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
-        .loader_start = FSL_IMX7_MMDC_ADDR,
-        .board_id = -1,
-        .ram_size = machine->ram_size,
-        .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
-    };
+    msms->bootinfo.loader_start = FSL_IMX7_MMDC_ADDR;
+    msms->bootinfo.board_id = -1;
+    msms->bootinfo.ram_size = machine->ram_size;
+    msms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
 
     s = FSL_IMX7(object_new(TYPE_FSL_IMX7));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
@@ -65,7 +73,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &msms->bootinfo);
     }
 }
 
@@ -78,4 +86,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("mcimx7d-sabre", mcimx7d_sabre_machine_init)
+DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
+                        mcimx7d_sabre_machine_init, false,
+                        arm_machine_interfaces)
-- 
2.43.0


