Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491E6C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNE-0002Og-AN; Fri, 04 Sep 2026 01:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNC-0002Ab-Cc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNA-0001UR-Mv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:58 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so785550a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499315; x=1789104115; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JXEnbYfcUl5mDB9qpNPQJf6ih6p+ATX6+LsjzGlAEAs=;
 b=riMihX4jcPQesLBSp4zsMUkR2SeVYM3V6LQDrUnxreNXe4JdBB+3xiw0ZsjKkXxkig
 flRmG1ApV3Yf0jhXLmazk2vAKDkP580sNW5uSzw3FiNg5mOByT4YZd2sw2WWj1G1dw7F
 ZqXAn+cMizC0Yg/kz+16Ilu9ZYJfe9hKZNfURRtWtu80DnYNxBSz1sA6jPds0ddJY0CI
 6QW1zu0Z9WXA5AHp73uyzjssowErVZeg1bSq4LJJBE2ZhWSrj2m371OLiokUQh43PgD0
 ArF9IDUzDfF3uCiX7wn0Ez4SdsIUXpJoLCHAXosDv0c2Szqs7xfKAfbklMHjV4k/zCbj
 zgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499315; x=1789104115;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JXEnbYfcUl5mDB9qpNPQJf6ih6p+ATX6+LsjzGlAEAs=;
 b=KnI3ttZMB6g7ipx2Yw3DAH/xH3xSEDEOi0wSyKSWpD01YbH57vHlbnO3wmGj6BU9RA
 8Ce2eXWMrWZx/CMbXhgKOX7WJCFEgL5MAt5HA8s8GebM2itBAS6XpQZhAQO7xyU9Bn2e
 PBND4iBQTd3SOsVOXDWaNj5tdYQ7qv7RbW9/ZonnO3a6YNpFvSRjAWpI5rZ+pCwiaEGt
 bfAIqTZnL5A1Yc8XCmjojm7cmc4VEWDqx/aAquxQ8viZ13OrMM/92BkgmVy9SEThlbiP
 zKNe5YHPmUpaJpfz7+OhS1F45YznZGuVAQ5gRfpD1uJPSN1XAKfJG+s/EDA1xF79j/hK
 ALUQ==
X-Gm-Message-State: AFuF++nOmvT7YLBwjtLp96d8f6RttzxiT4s6PDcfQLe5/R8zSWk96R7F
 44WchNsxiZG+DJpJglaEKl5q7HeR/c5DE4Nix+l17uuvRE8VMx7PM5A2tzjn5A==
X-Gm-Gg: AYBFou3lY7fzrRc7Zt6r468F76/HkMZ41V45xt4gDvXhCucrJ2srf3N4/eVUI8r7EqV
 n6B36l8uNlzg+SpRHLvJc5GycXD34DyQo/pfnqCP+1LyMjVDyO3KBP54EGXwUH0ltMgd/awv8KP
 K0mJCIclQlBOIey1Ib6qlD+NTwnFHhDpJVDYNRn3N96uK48/URvsut8mjmVOtezQYEFGdlPb9u9
 vZQPjCwT9q+qJbjoQGbC752YASY435MwOF672M/dXJ8qzaRXNGM+kLsRHJPQuDuZZqZ3zfvi54j
 xlgG8OWFpyxTmk494vR4G8sX7KwUhHT5+TzxCyE8gg5FJcStySO1m1F8LxeAhvDyHkPNMqpgscz
 IyXx6fGicXWopvOzfe+T2zsLWTT0GXn6vVXy54PyXD/m2enLx0qIqzeVc0sDWWTQoFsXYm3bjRe
 naDuh/cNjDJtBoRvWcdRmpVey4s1iNjjKPg5wTXuaPJ+ChSwNjKBIBLuf1bcAFM7snNphprGb4k
 y+TsQ==
X-Received: by 2002:a05:6a21:e0a7:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3da3a03cc31mr5482939637.13.1788499315176; 
 Thu, 03 Sep 2026 22:21:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/47] hw/riscv/atlantis: Make UART unimp region a SoC device
Date: Fri,  4 Sep 2026 15:19:34 +1000
Message-ID: <20260904051943.799041-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Joel Stanley <joel@jms.id.au>

Make the unimplemented region covering the remainder of the console
UART's register space a SoC child device, mapped using a helper. This
makes it easier to map it into the SoC's memory container along with
the other devices in the future.

While here, rename the region from uart0 to uart1. The uart0 name was
a leftover from an earlier revision that used a different device for
the console.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-8-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h |  2 ++
 hw/riscv/tt_atlantis.c         | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 7f7d4a5a59..c9308aa570 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,6 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/misc/unimp.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -31,6 +32,7 @@ struct TTAtlantisState {
     RISCVHartArrayState soc;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
+    UnimplementedDeviceState uart1;
 
     int fdt_size;
 };
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 8b07218152..6e1e50aaf6 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -410,6 +410,17 @@ static void load_fdt(TTAtlantisState *s)
     create_fdt_memory(s);
 }
 
+static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
+                                   const char *name, hwaddr addr, uint64_t size)
+{
+    qdev_prop_set_string(DEVICE(dev), "name", name);
+    qdev_prop_set_uint64(DEVICE(dev), "size", size);
+    sysbus_realize(dev, &error_abort);
+
+    memory_region_add_subregion_overlap(memory, addr,
+                                        sysbus_mmio_get_region(dev, 0), -1000);
+}
+
 static void tt_atlantis_machine_done(Notifier *notifier, void *data)
 {
     TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
@@ -561,9 +572,11 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * Create an unimplemented device region so writes don't fault
      * and reads return zero, which keeps Linux happy.
      */
-    create_unimplemented_device("tt-atlantis.uart0",
-                                s->memmap[TT_ATL_UART1].base,
-                                s->memmap[TT_ATL_UART1].size);
+    object_initialize_child(OBJECT(s), "uart1", &s->uart1,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    mmio_map_unimplemented(system_memory, SYS_BUS_DEVICE(&s->uart1),
+                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
+                           s->memmap[TT_ATL_UART1].size);
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
-- 
2.55.0


