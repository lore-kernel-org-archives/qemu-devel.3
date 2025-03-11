Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8229EC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzK8-0006nm-UK; Tue, 11 Mar 2025 09:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFD-0006Gy-NP; Tue, 11 Mar 2025 09:02:08 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzF8-0000N4-4n; Tue, 11 Mar 2025 09:02:03 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so8662566a91.0; 
 Tue, 11 Mar 2025 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698113; x=1742302913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ag/IQcoVCKBwm3hoxb2LywEaHZGgEXDr7bl00iOZl08=;
 b=eOdkHY4BYQI4L1Defs19wLjxkEydc/X49RZsYiUSeUp8AoWN6gXiy+8YUwUIwCdR2w
 bYlflupRIDriAcerPBLzWmVBtHcpMnT+PSd9cDKiuWXuMJhamluUNG4AHr4BKrSP68WX
 iBppjdkmoHiI8RIgslXapl5/Y1Stpvo1hDpWfiCT5kdDzLCxPI2nGQcit4J/WjUwKQUQ
 Gbhrhx41EgGYMHxWYKvkFyUY4LQrxbthj6CILcuv1pH6bOZMwi8sqIk8JE5UIHjmQgEm
 INZsFOX1JymnN3CAkni7H4wpWzm/kiBvfMxF/jQ20Vj61ZJavnJoTxOE8cV69lzr7t8H
 /JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698113; x=1742302913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ag/IQcoVCKBwm3hoxb2LywEaHZGgEXDr7bl00iOZl08=;
 b=V4YSvJRvXVaev+yK9zIkcX0pZ+B8JTeQnbUYsPy5ZvAG7kqFMFHJm1Ezv/MibAEWxz
 cxjq+pU55LytlaLCmHoH0d41OROdE+a6+YX99dIGkUxQjE67Tv9gpCEWt3y+qoftJgOT
 3lX5nUITlYvC2abVZw4cor513iEd641ppFFwidrPysiVq+hfbAy117o6vbCp8N7XfNZ+
 Sn2lKdH52o9Pf0Ehzszy3agNuVJZasdWArEJh/xIHqQV9NMO4JdfBkLOaQp3CSsLHB31
 6EADahqIuR0vToY6qR8Rc6mEsGfIo+usAvf7PAspdYvG6LpYCh1JZpb3YfQBPZpVuCsw
 iN0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa4eU1T2hJs+nM8BzGyQs93UgoxRsFW36ZXQN9tPYe6GNRos6sz/w1bhdG8o6y3GW0kxdvLYIgfg==@nongnu.org
X-Gm-Message-State: AOJu0Yzr2wovBbKy5bupC2/NvodXWeWKIfQQLlIB5M2FouZilRd+81ev
 jAG5YV4/VEANvLAfdBwZhl5CxbVRXQwf126ypwU0YNzGdODyZ3c2Ds+SZQ==
X-Gm-Gg: ASbGncswSE0s//1IQFzL3/C7oPCOq9Wv2PWEOiew8Kn2TIPaUdqfmdGm068mFG75B3q
 soiOzJ5jS2ECLg1CkCHlP3+EBKp59K+iqb8Tm3uvAs+CN/95lJqBT05ZkS0Mk7iCP8QB8QJDgLL
 TVONdk6GTzOE+gy5fwwzXe1jc0lv/GSOSMCMiE7+CL/9ggD5Q177BffwVnRUg4ES1YuCwzyfcpt
 uoIG2zWvUhh81nxy50WYySpMvHzVTKwZ42rMFSnuKoFIpBAOJlnlt//bO225TsxWpB8CnVbXAXq
 7+dbuTuFNiaVM/MApXcLl+Dz4H1LAQnQE1ck51c9l1eju1o0+ns=
X-Google-Smtp-Source: AGHT+IHGHi0YCKuzUX2ZW2gAJ1JVM7T7aSD2GJjt+xBz2msrBMmquFvOwCCHIZJ3MejaLnEfiScxNQ==
X-Received: by 2002:a17:90b:1b0b:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-2ff7cea9a99mr30670044a91.18.1741698112616; 
 Tue, 11 Mar 2025 06:01:52 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 68/72] ppc/amigaone: Implement NVRAM emulation
Date: Tue, 11 Mar 2025 22:58:02 +1000
Message-ID: <20250311125815.903177-69-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

The board has a battery backed NVRAM where U-Boot environment is
stored which is also accessed by AmigaOS and e.g. C:NVGetVar command
crashes without it having at least a valid checksum.

[npiggin: 32-bit compile fix]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <7e4c0107ef6bdc2b20fb1e780a188275c7dc1e49.1740673173.git.balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 113 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 4290d58613..feb2cf452c 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -21,10 +21,13 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/ppc/ppc.h"
+#include "system/block-backend.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "kvm_ppc.h"
 
+#include <zlib.h> /* for crc32 */
+
 #define BUS_FREQ_HZ 100000000
 
 /*
@@ -46,6 +49,100 @@ static const char dummy_fw[] = {
     0x4e, 0x80, 0x00, 0x20, /* blr */
 };
 
+#define NVRAM_ADDR 0xfd0e0000
+#define NVRAM_SIZE (4 * KiB)
+
+#define TYPE_A1_NVRAM "a1-nvram"
+OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
+
+struct A1NVRAMState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mr;
+    BlockBackend *blk;
+};
+
+static uint64_t nvram_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    /* read callback not used because of romd mode */
+    g_assert_not_reached();
+}
+
+static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
+                        unsigned int size)
+{
+    A1NVRAMState *s = opaque;
+    uint8_t *p = memory_region_get_ram_ptr(&s->mr);
+
+    p[addr] = val;
+    if (s->blk) {
+        blk_pwrite(s->blk, addr, 1, &val, 0);
+    }
+}
+
+static const MemoryRegionOps nvram_ops = {
+    .read = nvram_read,
+    .write = nvram_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void nvram_realize(DeviceState *dev, Error **errp)
+{
+    A1NVRAMState *s = A1_NVRAM(dev);
+    void *p;
+    uint32_t *c;
+
+    memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
+                                  NVRAM_SIZE, &error_fatal);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+    c = p = memory_region_get_ram_ptr(&s->mr);
+    if (s->blk) {
+        if (blk_getlength(s->blk) != NVRAM_SIZE) {
+            error_setg(errp, "NVRAM backing file size must be %" PRId64 "bytes",
+                       NVRAM_SIZE);
+            return;
+        }
+        blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                     BLK_PERM_ALL, &error_fatal);
+        if (blk_pread(s->blk, 0, NVRAM_SIZE, p, 0) < 0) {
+            error_setg(errp, "Cannot read NVRAM contents from backing file");
+            return;
+        }
+    }
+    if (*c == 0) {
+        *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
+        if (s->blk) {
+            blk_pwrite(s->blk, 0, 4, p, 0);
+        }
+    }
+}
+
+static const Property nvram_properties[] = {
+    DEFINE_PROP_DRIVE("drive", A1NVRAMState, blk),
+};
+
+static void nvram_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = nvram_realize;
+    device_class_set_props(dc, nvram_properties);
+}
+
+static const TypeInfo nvram_types[] = {
+    {
+        .name = TYPE_A1_NVRAM,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(A1NVRAMState),
+        .class_init = nvram_class_init,
+    },
+};
+DEFINE_TYPES(nvram_types)
+
 static void amigaone_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -72,7 +169,7 @@ static void amigaone_init(MachineState *machine)
     DeviceState *dev;
     I2CBus *i2c_bus;
     uint8_t *spd_data;
-    int i;
+    DriveInfo *di;
 
     /* init CPU */
     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -97,6 +194,16 @@ static void amigaone_init(MachineState *machine)
         memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
     }
 
+    /* nvram */
+    dev = qdev_new(TYPE_A1_NVRAM);
+    di = drive_get(IF_MTD, 0, 0);
+    if (di) {
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    memory_region_add_subregion(get_system_memory(), NVRAM_ADDR,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+
     /* allocate and load firmware */
     rom = g_new(MemoryRegion, 1);
     memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
@@ -136,7 +243,7 @@ static void amigaone_init(MachineState *machine)
     pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
-                             0, 0x1000000);
+                             0, 0xe0000);
     memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
@@ -153,7 +260,7 @@ static void amigaone_init(MachineState *machine)
     qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
                                 qdev_get_gpio_in(DEVICE(cpu),
                                 PPC6xx_INPUT_INT));
-    for (i = 0; i < PCI_NUM_PINS; i++) {
+    for (int i = 0; i < PCI_NUM_PINS; i++) {
         qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
                                                              "pirq", i));
     }
-- 
2.47.1


