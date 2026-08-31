Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0C9C61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rZl-0004cw-0n; Sun, 30 Aug 2026 22:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZi-0004NX-IC
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZg-0007eZ-LI
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ceab75934dso33503085ad.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142599; x=1788747399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YAXZV6zAbM1l8BTrMY8dps++9Fqi8o3MB24YeyVs67U=;
 b=TtUGVv2wpen+0GnmNep6czQWJAXXPBK5SYQtTPe+pKkGfg4HqLpJOs+hTIgCylRa0B
 twSdACHvNS1xmVJpvaBhgtx/+9FvXYGoO1u27ybm8Tc/y6sbpGD3UQpo2PTK8hPSqphG
 /dN74rjNlrYolqJX8U2bYrRSG2bwXcNI25uWdobPzeSD4/Jcjxoq00lQT/BbVxd8SJT+
 FIav79ugJl4lWCAuK5+3jX6lX+uG92yxg0qwcc/CMqMNu7LZCcEVNQCbZRsiy9P9fYSk
 ZdyAhKcvlR6jYvUiKlh91Du4HLuL5xoOacNOeXTXnlG5CMOx6l9Qati6xMdYtt9CvdMf
 jLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142599; x=1788747399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YAXZV6zAbM1l8BTrMY8dps++9Fqi8o3MB24YeyVs67U=;
 b=LiJql0vWlS+aOi3VmktGYsEvp3Q56UEsmi1OjG1CJ7vNXU91KnBFJEn2WOsCu9NNfk
 vGpT4Larv9Bgt4dNusVzlaQ5xUSBzwnYgyEprT8MNpbEZxJSp5+kQY7hlgdF9GMHxqrO
 M5E3RJ7lrQ5SAawTFGslmoN8Hd4QfeTP47jcSx8gecxEl7T/1sZjbxgKkLRnrdyxQbcX
 zRaIuJa0xFZ4IHSloLK85AWbZsIwlTrx2DnSrf2Qo6aYIfILkiQ8K0RLQHHWMr3aodTS
 8y8LBfvN4tvkZNmxuTQI5vxqXAxQJ31sm5iGOEqiIX9o5G/Z04p11K5fI8Q6KzGTkAFW
 dY0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOwvcKAl9Tb8CX65STJsa4a0Q24/y7VWRYoP9bIlKfyr+uTt5Fl3hCcbNsIhj+43mxjAaqMujtgM1v@nongnu.org
X-Gm-Message-State: AFuF++m545g85mmeL+AP6XSG8rKPyRXVUjnOesmF1MNCsaOptKlJ8LSd
 Vvy6E3g0jnyUSRA4VxmkcX5S574Mo1Sn6eWr/0K3FErYM/pwykpyPEp+8rPNYWCS
X-Gm-Gg: AYBFou3FujNuJakXAlJtWkTlT7SOcLkymCzoR/6NeQCOSpT9LYq7kU91Zercsi+xkW5
 L4HlJIFlImGyMFmV+zeMfBpylahfMSqY6jwZJJzUHNpWq3tU15j5JfGRYvy2WNmm5nf1a0qB/dB
 Yjgum9maZqtWCrChv5g2vXAUbovHviaYOoaZWnr5jlwTfDxICPcd6dF5+LyTlpqygK9MILfXxW7
 /gKF5j7oIyoAPfHDAEptb5br5kbcAlkAqoktkevQD60ND3Iu8vdTHiGYw7ONY/gxeOz+snXIcTI
 nUtshhJx7ZoNM5VBwf13Iy8Yfk/V68FwVi1y2jm0B6NVsRbQ8ix8Uwzyj8SUREI2CYUbfOgRYIb
 eLtpGgGtOtW2hIj4oo16x6SQ375hNC5Pw0i9Q8GfHYVEJyzr00JuvRy65fI6TSUFw+FH/YFCyMz
 YApla+8ok/mPg5VHOyLhn8CVw47lRyy4zUioghtxbUhHm7GYCGpgOYZL0Y5KMrP8OvxWyqeuN09
 U8CJieDlXmjZv+55yb+12C9JkM8EQMWkIJL+1wTrn7A3H3UluwvQba9bw8NK2k1cwkZTHNLV2kb
 5i3jYymE+nAhJs9pD+DliA==
X-Received: by 2002:a17:90b:4a52:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-396d0eda189mr32644038a91.10.1788142599259; 
 Sun, 30 Aug 2026 19:16:39 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:16:38 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 13/16] hw/riscv/atlantis: Make TTAtlantisState own memory
 containers
Date: Mon, 31 Aug 2026 11:44:54 +0930
Message-ID: <20260831021500.82565-14-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The DRAM hi, DRAM low and bootrom memory containers can be owned by the
TTAtlantisState.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  4 ++++
 hw/riscv/tt_atlantis.c         | 15 ++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 2ec283d0fd7b..9ca98bfb8478 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -31,10 +31,14 @@ struct TTAtlantisState {
 
     MemoryRegion *memory;
     MemoryRegion *dram;
+    MemoryRegion ram_hi;
+    MemoryRegion ram_lo;
+
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
+    MemoryRegion bootrom;
 };
 
 enum {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 7a9f5872c7c0..b80bdf54c40b 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -483,9 +483,6 @@ static void tt_atlantis_machine_init(MachineState *machine)
 {
     TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
 
-    MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
-    MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
-    MemoryRegion *bootrom = g_new(MemoryRegion, 1);
     ram_addr_t lo_ram_size, ram_size;
     int hart_count = machine->smp.cpus;
 
@@ -543,22 +540,22 @@ static void tt_atlantis_machine_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", s->dram,
+    memory_region_init_alias(&s->ram_hi, OBJECT(machine), "ram.high", s->dram,
                              0, ram_size);
     memory_region_add_subregion(s->memory,
-                                s->memmap[TT_ATL_DDR_HI].base, ram_hi);
+                                s->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
 
     lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
-    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", s->dram,
+    memory_region_init_alias(&s->ram_lo, OBJECT(machine), "ram.low", s->dram,
                              0, lo_ram_size);
     memory_region_add_subregion(s->memory,
-                                s->memmap[TT_ATL_DDR_LO].base, ram_lo);
+                                s->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
 
     /* Boot ROM */
-    memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
+    memory_region_init_rom(&s->bootrom, NULL, "tt-atlantis.bootrom",
                            s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
-                                bootrom);
+                                &s->bootrom);
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
     serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
-- 
2.47.3


