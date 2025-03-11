Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1BAC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKY-0008CH-3O; Tue, 11 Mar 2025 09:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFN-0006MY-TJ; Tue, 11 Mar 2025 09:02:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFE-0000Nx-MI; Tue, 11 Mar 2025 09:02:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2255003f4c6so49959605ad.0; 
 Tue, 11 Mar 2025 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698121; x=1742302921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elAFXUjF+R6E0+41mljzNOshBJCWfVTXW/A0lm/eOnM=;
 b=h0SwqOnbiIrZA3nYF4zqtGvYwIn3rpHrgX2XC9MxhsU45poFy58FFxMwy5fWpy3Hz8
 qs0fWH26AA5O9AscypFWDLRI1142924qgJC5zHLKqnUzJP07JZpHpcqKnWWrXilSM3eV
 JmNdhx3ptMxFEaXGEBwAMcx8/fBIzG7V3OfVHgRy9l61dQnr85AsEn3CfQQe1JCIFSpK
 XCYiS6NSQEd/op0a6XsalPk69YKZz9OqU++rhR2HynxWTVIJmugT4CxwIbLSaN6L9rBJ
 gbwPx0G+Fn0KiV1nlLufRlJmzX0bxlPVfTEHbQkaqu6vU7p0BGZlQ+U9nkM8SBWwh2A6
 4Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698121; x=1742302921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elAFXUjF+R6E0+41mljzNOshBJCWfVTXW/A0lm/eOnM=;
 b=Geypf3Id3a6lYFvK2P2aligOQYz6GwbfhgM5FFMQJK+wRaHi/ofZw85cxgLTeBpwiS
 rlDJ7fWra84yDftRkxxVVGEYFkMjyo7mqQ4bG0uHwC+/RlYt8IxrmZ98GMvHhsqY/1KJ
 COp9j+BQlQQrPTxH8sCeo2hs2glu0HUM2IvfZ6QWzgHf7mV/1GamukUobLH6UWnDucUv
 wVTCQZX3LCkm8XnKwguuswUb8UFTU6pMdhJsr/utTFPE8XTIzGxWPmSgaDbw2l5uVGI+
 4fkDLmPi35ZYy1SYfVemh40miQZFd7Ad/OX1IVIHGV4Tcq6mXC+XylsM7XT9eIoRPDoC
 l90A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaD2tT9Tj9fTdrupHGxgysO6exY1AiQfpEMUkhovngq+2u1tf0GYchYr81Q9SIvCgnV+rf3G6djw==@nongnu.org
X-Gm-Message-State: AOJu0YylgSZ4PEtlS5B+Hvg2bhbsUb1LHUBxDNpZ8W4V1OHLF7sgdw6W
 6l0hNr0HuOsd2Q707WM3WfT5XLJ+xgwIaVBI6SjVrA1giLEWhitQ6g+vOw==
X-Gm-Gg: ASbGncvXxqvrlUmkVY0aZzZvCfKdCJpPeSqO0ciMue7GUzI661dpOp0MEOUi+NBbtej
 4rJEiyqSDbrEzjJFBKm2QJsBKmu72d4qJ/V+C4+Fg/Ov3s0K9IWgOavH3V6K613kqIFYeNfnxTk
 Te36+0380gNEs3QNiSzQt615U7E64obvjR0eaCeDP6OJK3SF4TVXeJ0zZTahnM0PKWBqW3Ok3S2
 3L5mJV3ERkutC5AB39gMChCbHnsqH9+4yfWScvuBlsgvs/RRvIpOM6sfWVG6AdxTlPuxsqu+Cl7
 vYFPhN7Z7h+ghw5pA7M0rMY2SUF0d1SFsDe3AdUA92h7U6UvQzw=
X-Google-Smtp-Source: AGHT+IEvfuD1NrKWI+2Dv0OL8sLBjxEo6/deJYw1ULxKFwwvAOvUHJYL0oPwf2abozxnkGOzQeBWUA==
X-Received: by 2002:a17:90b:528a:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-300ff34d5c3mr4672098a91.28.1741698121189; 
 Tue, 11 Mar 2025 06:02:01 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:02:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 71/72] ppc/amigaone: Add #defines for memory map constants
Date: Tue, 11 Mar 2025 22:58:05 +1000
Message-ID: <20250311125815.903177-72-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <3b8e54ad9220d57e7b0a33f3570e880f26677ce8.1740673173.git.balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 359f5fa125..483512125f 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -32,6 +32,14 @@
 #define BUS_FREQ_HZ 100000000
 
 #define INITRD_MIN_ADDR 0x600000
+#define INIT_RAM_ADDR 0x40000000
+
+#define PCI_HIGH_ADDR 0x80000000
+#define PCI_HIGH_SIZE 0x7d000000
+#define PCI_LOW_ADDR  0xfd000000
+#define PCI_LOW_SIZE  0xe0000
+
+#define ARTICIA_ADDR 0xfe000000
 
 /*
  * Firmware binary available at
@@ -287,7 +295,7 @@ static void amigaone_init(MachineState *machine)
         /* Firmware uses this area for startup */
         mr = g_new(MemoryRegion, 1);
         memory_region_init_ram(mr, NULL, "init-cache", 32 * KiB, &error_fatal);
-        memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
+        memory_region_add_subregion(get_system_memory(), INIT_RAM_ADDR, mr);
     }
 
     /* nvram */
@@ -322,7 +330,7 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* Articia S */
-    dev = sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL);
+    dev = sysbus_create_simple(TYPE_ARTICIA, ARTICIA_ADDR, NULL);
 
     i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
     if (machine->ram_size > 512 * MiB) {
@@ -339,12 +347,12 @@ static void amigaone_init(MachineState *machine)
     pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
-                             0, 0xe0000);
-    memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
+                             0, PCI_LOW_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
-                             0x80000000, 0x7d000000);
-    memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
+                             PCI_HIGH_ADDR, PCI_HIGH_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
     /* VIA VT82c686B South Bridge (multifunction PCI device) */
-- 
2.47.1


