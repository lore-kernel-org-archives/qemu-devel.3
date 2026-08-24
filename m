Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483FBC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNXx-0001Cw-Rz; Mon, 24 Aug 2026 01:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXm-0001Bd-JD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:28 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXj-0001fV-VN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:26 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2501925a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550502; x=1788155302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v+sECY3ATOpspmun2v/pmM0HIUARTgenM86VzLHZI6Q=;
 b=IEAjHmNqyqspMg0aca79wxTFivgmRSB8IoCNSv8byMMesgCzryVWYL2GURTr5D25kS
 22hXyfsAbltv0qwlU9jauxKqy74uMfVEsUR+aRijnbJJ3LM8LrA1vC6e27kWSHmVKsCi
 NmsF+n3NAW34zTGX3klEnveo7Ij682lBX7C6NIScWQJR8qz0cxOaWyPDLYr26dMj9Lvw
 mRV3yphF+KBL/sMJf/iM51LnsAhaTpFY7EzTWR42Ssbm/YdR9KL3i35NX2AJriIgaRYm
 28g+iM1nXI+W+VHiKlJHFkCIpuzUrZpj2CQGgxY6mCy04LDoSJTdvfeOLjUSnIvzG4Se
 MbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550502; x=1788155302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v+sECY3ATOpspmun2v/pmM0HIUARTgenM86VzLHZI6Q=;
 b=TlzKWOHin8Jb9mnn2OluvuJ5zbOsX8iVBKMEfhHK4BVMZYKHq4I9mgHDzcHIbXH0s3
 V790TpFYKyjLjkF0sTER9g/0koyzz2hvP17+db4ct+/lf7LXi0pxY2zqNhaaLKExPen6
 dGXNdQfdDyGnMgnqdojyIQ6QAOvqkqHEo/RoAgs1QsQJWge+vTXwJrtHLxsc0+oANzFl
 eH6I/QzgBGa6/U5gIo/PQblP4D7lNLKlr8Hb37+1mZ2AdKGyQ8/VDbxSAGp4CqFtUyvj
 L25s9w1EUI4XdWvoUgmNHSl63uRYiommtukrP+ZpkNakilvBl9dCKf36QXTJjfxNQGmX
 g4lg==
X-Gm-Message-State: AFuF++nREgFF0U5RnuEJb2JrFnPLj/+PAT+RHvnkQ4bDjQ3i8JHhsUzD
 ygLB1xRKMYKND7r17ZaGlR8Trn+5p7xCYKjjsDihObtMgyVyAxPYirgwiS4Tjg==
X-Gm-Gg: AR+sD10Ps0W6VJ1V0j9l1201YbZ5+fE4aXqrQEq0zfrB4bc38R+IcU5N4pC2zZkmM9n
 x0YO6e/2aCRVUPMC1kG/axHIxJJ5HyCnDaFHnhWJKZVdQ5kvx16JdjFnpfpCmc6wPnUJSNOML6X
 mBdMXJOCmNqPpX4fdHH54MqLeDqZmDm0iyIGygYwyy79LhGSGAOPdc/nMuA6+c7yd7VbrLeEAhE
 o3xsbFSmrONMw+EqOon/wkDeqa18cl0HfaheCUI6cIMfKTd0YA5xbuCZpvE73ZHl6tC4Fwr7nsT
 eznHuWmxOb+eWVxflq7eemhI/GnepKo3Rk7bmOHBCbsvrjz+f1dashUqTghxBdVTa8SC/iFAnR0
 wsq6huJGsPnVb66CIAphcTIv2JGdil3NndsUfASEPPNAtKM7vGDZIadLZsKs11Kbg1IGfugeujZ
 CF0owPrFnytqzEkQ59YXaBmFW8L4t3VDeHP9q61s+AAtDwt1ev4KwHIefQY9W+5+llG+25XTU6K
 EBHL7Q9ZuI=
X-Received: by 2002:a17:90b:1d51:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-395a06b9c5emr37608644a91.15.1787550502260; 
 Sun, 23 Aug 2026 22:48:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Junze Cao <caojunze424@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 02/96] hw/riscv: Connect K230 DDR controller and PHY models
Date: Mon, 24 Aug 2026 15:46:32 +1000
Message-ID: <20260824054806.2790041-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Junze Cao <caojunze424@gmail.com>

Replace the unimplemented K230 DDR configuration region with the DDRC
model and map the PHY model at 0x9a000000.

Connect the controller to the PHY so DFI status reflects PHY training and
initialization state.

Suggested-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Junze Cao <caojunze424@gmail.com>
Message-ID: <20260807-k230-ddr-v2-v2-2-c531308ae819@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/k230.rst |  4 ++++
 include/hw/riscv/k230.h    |  4 ++++
 hw/riscv/k230.c            | 19 ++++++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..06a819fbdb 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,12 +20,16 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* K230 DDRC CFG and DDR PHY
 
 Boot options
 ------------
 The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then
 starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
 
+The DDRC CFG and DDR PHY models allow the K230 SDK U-Boot SPL to complete DDR
+initialization before loading the next boot stage.
+
 K230 SDK Linux kernels use T-HEAD C9xx private MAEE page table attributes. QEMU
 does not implement MAEE in the generic RISC-V MMU, so such kernels need to be
 built with standard RISC-V PTE bits before they can boot under QEMU.
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..80ca16338c 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -16,6 +16,7 @@
 #define HW_K230_H
 
 #include "hw/core/boards.h"
+#include "hw/misc/k230_ddr.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
 
@@ -32,6 +33,8 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230DDRCfgState ddr_cfg;
+    K230DDRPhyState ddr_phy;
     K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
@@ -112,6 +115,7 @@ enum {
     K230_DEV_SPI,
     K230_DEV_HI_SYS_CFG,
     K230_DEV_DDRC_CFG,
+    K230_DEV_DDR_PHY,
     K230_DEV_FLASH,
     K230_DEV_PLIC,
     K230_DEV_CLINT,
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..627150b463 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -97,6 +97,7 @@ static const MemMapEntry memmap[] = {
     [K230_DEV_SPI] =          { 0x91584000,  0x00001000 },
     [K230_DEV_HI_SYS_CFG] =   { 0x91585000,  0x00000400 },
     [K230_DEV_DDRC_CFG] =     { 0x98000000,  0x02000000 },
+    [K230_DEV_DDR_PHY] =      { 0x9A000000,  0x00400000 },
     [K230_DEV_FLASH] =        { 0xC0000000,  0x08000000 },
     [K230_DEV_PLIC] =         { 0xF00000000, 0x00400000 },
     [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
@@ -108,6 +109,11 @@ static void k230_soc_init(Object *obj)
     RISCVHartArrayState *cpu0 = &s->c908_cpu;
 
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
+                            TYPE_K230_DDR_CFG);
+    object_initialize_child(obj, "ddr-phy", &s->ddr_phy,
+                            TYPE_K230_DDR_PHY);
+    s->ddr_cfg.phy = &s->ddr_phy;
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
 
@@ -158,6 +164,16 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     int c908_cpus;
 
     sysbus_realize(SYS_BUS_DEVICE(&s->c908_cpu), &error_fatal);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ddr_cfg), errp)) {
+        return;
+    }
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ddr_phy), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_cfg), 0,
+                    memmap[K230_DEV_DDRC_CFG].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_phy), 0,
+                    memmap[K230_DEV_DDR_PHY].base);
 
     c908_cpus = s->c908_cpu.num_harts;
 
@@ -361,9 +377,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
                                 memmap[K230_DEV_HI_SYS_CFG].size);
 
-    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
-                                memmap[K230_DEV_DDRC_CFG].size);
-
     create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
                                 memmap[K230_DEV_FLASH].size);
 }
-- 
2.54.0


