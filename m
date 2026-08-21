Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43257C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1V-000234-1P; Fri, 21 Aug 2026 07:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1I-00012f-3L
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1G-0007Zd-BH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso7255085e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310161; x=1787914961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AeyrW8w1ZGo0zpjO2gq6yEe2dJOSXGi87kFcV2lfD1I=;
 b=N5R2SC91exkreL3r5zUddB39hIG6K05ENqYQfAbBwnpNtgvnOjmFWLBxr3F4RNSk3S
 U3QkA531gjPHdUEHlzo8MzW/OUddPBgn/vWB8t/Xw97P0jHeGwTa9N5u0xGMygap6H/4
 bIdIsacZ2ysuovTbS2ZFUjpLYJS++/z7l62GTa4A2kgw54mfonNSK7Mw10tRSG5j6SVn
 oa09rsZISrHmUWIoWx+jLe773mFGT0I6yZGaY6WbvVv8lh9PmTpIyDBWRG7tbSE3kb4k
 l4wxhPnX9YGp78H4m2RwVgsMwGOC6tRAlmEOdGKugFJswUBmJwKWY/g+SpoMK6ZC69h/
 spyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310161; x=1787914961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AeyrW8w1ZGo0zpjO2gq6yEe2dJOSXGi87kFcV2lfD1I=;
 b=i/hvVD0kW5Uqt0un7MZBOEtOWH+sz3fnpyMDPp2ZJHl5VY/vXzFlHivE7PRjXIgk5Q
 +arVjfyjbZ3GqLoEsLUULlnHM463O2chrmxqDYL3G2HUcQCh9wxG3up6j0wdDl7m4Biw
 TGjtFK1ZCEfPaE7l2bHF2gF4Z6ghX25FgrK3qbTXG6D58Ut3bDIDzIyWcTiYcgfDPZi9
 /v8I+a23kq/CCfb1eV3YvuOnlVX4kXDb0TpHaRVXajFb1jGdtXpIcpBn88KPdejtuWtN
 hGZxUK+OIqbMhiAnZF9/p3c0JRErOhkekgyo53frWuvYTgljFRkrlRRPKOF3htAxDth9
 7NKw==
X-Gm-Message-State: AOJu0Yx7c6aPzj7T/qy+cZ5WHCZu3luVVw/oW98YeXloJiCwebWygGhJ
 n/N7M0lKiAfHFwWp9udAUpWxjiWywX5xaTohA1KtMqOExqUPAQnZSxtf9o/npGjfP+LzzPOdEfd
 7kQoD
X-Gm-Gg: AR+sD13W6BKq/eq+fmZcyc/mukcfkDX7Lwc28c8H5eNi5kwmDvHtl4YCggHAtDcdMrF
 iWc6RiofC5y2ER7NFwAochK72cZNG0FQcg0PUtSGbGD/rU1wYd18qYDwe6A6zPFcbXFiBYukBgw
 FdYA5FHa/NuBdv1sfUV84Vq9EGMtathdwuwIb73LF2+mvTKVKLUPX2kk+kasmznqYH9qk9HGE3a
 dJ/dqSTvhFUnc6CIE+4+dBwl6yEpySFJp+5NHk7gYGIOwic+SB0+NuBdssBdog9dlmdV3PRpw+k
 TG0+tt4rKiwBZfQTzhr6+d5qRWe00yXOt3jWfSNLw20pZDxdl+8773R7vq0mTOo0GzRHpfelGf9
 IYjEJcbmql3AFyT8aT3yqRivlyWvAlGnO5hFcTgTuHERJ6vwVGL/JDXh5Tl69XdXmFhMssoEvMQ
 uExH1ZmoBn0XdkRVHNavGjGzXsomjjSmwquv21UGTXtu5CyDm+7NvyTujSQ7UVaUhk4jo2YbBz5
 c9nMSmissqcpG/rMpAzrikbelSgf9VDtdGMeU02iGyhh1l0XFcRCNduorwZRQrApKfISQ==
X-Received: by 2002:a05:600c:354f:b0:499:a8bd:1930 with SMTP id
 5b1f17b1804b1-499b830dd8amr73909405e9.5.1787310160989; 
 Fri, 21 Aug 2026 04:02:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/43] hw/arm: orangepi: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:57 +0100
Message-ID: <20260821110101.3971391-40-peter.maydell@linaro.org>
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
rather than to a file scoped static object.

Move it into a new OrangePiMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20260816131300.51799-17-bin.meng@processmission.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/orangepi.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d84443bb7b3..0e149ed6c98 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -28,10 +28,18 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 
-static struct arm_boot_info orangepi_binfo;
+#define TYPE_ORANGEPI_MACHINE MACHINE_TYPE_NAME("orangepi-pc")
+OBJECT_DECLARE_SIMPLE_TYPE(OrangePiMachineState, ORANGEPI_MACHINE)
+
+struct OrangePiMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
 
 static void orangepi_init(MachineState *machine)
 {
+    OrangePiMachineState *opms = ORANGEPI_MACHINE(machine);
     AwH3State *h3;
     DriveInfo *di;
     BlockBackend *blk;
@@ -98,10 +106,10 @@ static void orangepi_init(MachineState *machine)
         /* Use Boot ROM to copy data from SD card to SRAM */
         allwinner_h3_bootrom_setup(h3, blk);
     }
-    orangepi_binfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
-    orangepi_binfo.ram_size = machine->ram_size;
-    orangepi_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    arm_load_kernel(&h3->cpus[0], machine, &orangepi_binfo);
+    opms->bootinfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
+    opms->bootinfo.ram_size = machine->ram_size;
+    opms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    arm_load_kernel(&h3->cpus[0], machine, &opms->bootinfo);
 }
 
 static void orangepi_machine_init(MachineClass *mc)
@@ -125,4 +133,6 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("orangepi-pc", orangepi_machine_init)
+DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
+                        orangepi_machine_init, false,
+                        arm_machine_interfaces)
-- 
2.43.0


