Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1E6C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2ri-0006Ap-U3; Wed, 29 Jul 2026 07:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20j-00017z-5r
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:41 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20f-0004Dp-TX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:40 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 d9443c01a7336-2ce7ac92dfcso7097135ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785322776; x=1785927576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AA4kbnvcGIDYoqgEXcU+45vYtoc2rnZEFSQgdt/3/7Y=;
 b=RN/48wKRE2tgeu7wPFWccrzjq+imzseK4jqr3pt5lk2mMFxt+1WUF56h3HaeWYvHQS
 nzm+tSzmCzxVocibgupNqW1oFBXf9CufPqFiQMJ/28xsczoSNRJcMhffZgmN1QZskfyu
 m/8Facpgg6e37ZabJoyHD0za932Ugln4WtaexZ63oleDJ0TM+0pMCNlqrBiGPKG3cF4/
 ExRTsBX/sl/mZuX5zl22ajogIf8ZkywGeUF0Yjub3kqOwqEa/fLFcggre83voP6ztcw+
 4WokBAPxKNZPT892qOKbEnmO9cpNu5K3nm4zI2pVCmxhV5scium5gJq5oww5vfC89sJq
 moFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785322776; x=1785927576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AA4kbnvcGIDYoqgEXcU+45vYtoc2rnZEFSQgdt/3/7Y=;
 b=bzAqXYWph+wmkIrrGjNKe3TZFpJeqYcAdgF4oIFIfW86ZfVd0kAg/cf4CcSaMK4E34
 sxKAh17n5bu4Fuy58hYIRha+7DPG4CNk/sYNgNxNVKDFQtf7YNPZRcqXbixBZqmoleg4
 bUDtjnyar3PNCqUVnekT0SoPNR41KNY+XxbsC3hlrMSvP0dZ5/ttNigEFFmhymnuwzkh
 cwZvS6Qqo7JMZjrNFdJJCYJhFu2PLMAtuUPZzJTh90KjzoadjUKu5iLlmlpoj2BOFcvr
 Mf9JjiHOl65LPpEaaqsfZORt3zRiQqN8rLi7cqc9Y9nVrIQ10XJYAbQagf4sDKfCbk54
 huCw==
X-Gm-Message-State: AOJu0YzdVZ2O7QfKPPPL1Y4g1Qy8NW5pW2DnxYtjwUmTIdplWiNK4HAm
 NfjzrUHHzAsNBzH03SWfLJ0uAPC5sRWeDIPrqaD60rbEEPUMfd3GX4axlaPcCXWKtu/+tQ==
X-Gm-Gg: AR+sD100iN/k+tOpz62bDOS9NZVUJZejvDymv/Maf874W+p+X6JrX4JiI7j9NXSjc1v
 ypYoVrYaWpICSifHLsozT/ZVRhjdsEWLQzQEmuxjXyRAtuKEFgPjE78bx3FkDbwKwlxNmdwTlJo
 2z1IwtvpUdDaHEqsreH4Ywcgldncb72r6WT5XDKof7CCtmQNZ5TNEqBYiz5QArpsQIiFzUN2DOY
 t5OohWdWuLtn+SDDmG+pAmwTF+OoGle/62fpFzsQUZrRUgk2zLINTGMr0q8J0/UvCp9nMOZVjPL
 P0jlbjOIV32+Hsvq+0nNZTM3fJ+/N8Uy1Nxam+iICrQEe34Rdtc4t59tz+qh2z6EcMdoQH3igE6
 OqFkr1GQs5ioQ9OVfXv/87wIbBqBiY8Gx8ttV9Hm8F9ZacWj18twCaZGHeId4QTaFqfHT6eUtmS
 vUtojK+Zwv5k2jppp3ifve4ykx3NKSUTp88asoQrjyydxtPWoRlAeKXIgWlCJ9+6Lsh34hMZUTe
 ygCRl4zig==
X-Received: by 2002:a17:903:166e:b0:2ce:fa3a:45f7 with SMTP id
 d9443c01a7336-2d015d1eb47mr65436735ad.16.1785322776228; 
 Wed, 29 Jul 2026 03:59:36 -0700 (PDT)
Received: from LAPTOP-LOCIFOSI.localdomain ([123.127.39.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bfa240sm9627135ad.65.2026.07.29.03.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:59:35 -0700 (PDT)
From: Xin Xie <xinxie908@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Xin Xie <xinxie908@gmail.com>
Subject: [PATCH v1 2/3] hw/riscv: enable SDHCI controllers on K230
Date: Wed, 29 Jul 2026 18:59:02 +0800
Message-ID: <20260729105904.272939-3-xinxie908@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729105904.272939-1-xinxie908@gmail.com>
References: <20260729105904.272939-1-xinxie908@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=xinxie908@gmail.com; helo=mail-pj2-x01.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Jul 2026 07:54:23 -0400
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

Replace the two unimplemented K230 SD controller regions with K230 SDHCI
devices.  Map them at 0x91580000 and 0x91581000 and connect their
interrupts to PLIC inputs 142 and 144 respectively.

Create an SD card on each controller when a corresponding
-drive if=sd,index=N backend is provided.

Update the K230 machine documentation to list the controllers as
supported and remove the instructions that disabled the SDHCI device
tree nodes before booting Linux.

Signed-off-by: Xin Xie <xinxie908@gmail.com>
---
 docs/system/riscv/k230.rst |  6 ++----
 hw/riscv/Kconfig           |  1 +
 hw/riscv/k230.c            | 34 ++++++++++++++++++++++++++++++----
 include/hw/riscv/k230.h    |  4 ++++
 4 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..6e8286a0df 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* 2 SDHCI controllers
 
 Boot options
 ------------
@@ -100,14 +101,11 @@ Press Enter to stop autoboot. At the U-Boot prompt, run these commands:
    K230# fdt resize 8192
    K230# fdt set /chosen linux,initrd-start <0x0 0xa100000>
    K230# fdt set /chosen linux,initrd-end <0x0 ${INITRD_END}>
-   K230# fdt set /soc/sdhci0@91580000 status disabled
-   K230# fdt set /soc/sdhci1@91581000 status disabled
    K230# bootm 0xc100000 - 0xa000000
 
 Use ``setenv`` so ``bootm`` writes the kernel command line into
 ``/chosen/bootargs``. The ``fdt`` commands select the loaded DTB, add space for
-edits, describe the initrd range in ``/chosen``, and disable SDHCI nodes because
-this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
+edits, and describe the initrd range in ``/chosen``. Replace ``${INITRD_END}``
 with the host-calculated value above when typing the command. ``cma=0`` avoids
 the SDK kernel reserving too much of the little-core memory window for initramfs
 boot.
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..e4a0616c16 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_SDHCI
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..7ea69084ae 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,8 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "sdhci0", &s->sdhci[0], TYPE_K230_SDHCI);
+    object_initialize_child(obj, "sdhci1", &s->sdhci[1], TYPE_K230_SDHCI);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -343,11 +345,21 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("usb1", memmap[K230_DEV_USB1].base,
                                 memmap[K230_DEV_USB1].size);
 
-    create_unimplemented_device("sd0", memmap[K230_DEV_SD0].base,
-                                memmap[K230_DEV_SD0].size);
+    for (int i = 0; i < 2; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci[i]), errp)) {
+            return;
+        }
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
+                    memmap[K230_DEV_SD0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
+                       qdev_get_gpio_in(s->c908_plic, K230_SD0_IRQ));
 
-    create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
-                                memmap[K230_DEV_SD1].size);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[1]), 0,
+                    memmap[K230_DEV_SD1].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[1]), 0,
+                       qdev_get_gpio_in(s->c908_plic, K230_SD1_IRQ));
 
     create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
                                 memmap[K230_DEV_QSPI0].size);
@@ -490,6 +502,20 @@ static void k230_machine_init(MachineState *machine)
                             TYPE_RISCV_K230_SOC);
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
+    for (int i = 0; i < 2; i++) {
+        DriveInfo *dinfo = drive_get(IF_SD, 0, i);
+        DeviceState *card;
+
+        if (!dinfo) {
+            continue;
+        }
+
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, s->soc.sdhci[i].bus, &error_fatal);
+    }
+
     /* Data Memory */
     memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
                                 machine->ram);
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..8e73366e56 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/sd/k230_sdhci.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230SDHCIState sdhci[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -129,6 +131,8 @@ enum {
     K230_UART4_IRQ  = 20,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
+    K230_SD0_IRQ    = 142,
+    K230_SD1_IRQ    = 144,
 };
 
 #define K230_UART_COUNT 5
-- 
2.43.0


