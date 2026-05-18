Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B37CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsV8-000112-PK; Mon, 18 May 2026 03:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUX-0000hJ-KR
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUS-0000Ww-Bs
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso1160190f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089655; x=1779694455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzWzoTmlyJ+ulEDvy/SGgv3VFS2OT2P9OMuzim+8Q8o=;
 b=JtHVOjMV+HWLf5jJhVlazatsNoi0r6LtMK7M7M/MBDcJ6t31KAf4sEoBr/GXk0VDkl
 Ko7FEYO5GepS0GYmdPSwZrCOU8HYKa1hcmBeyvOp4HJD9AVUsCyheTQSPHNUtOfme4XP
 jr7rmTgYQUQ2+uUXr86Eo5bdG7WztLioaUsa5dXv4KOTmoXhJqo3PlkrxWJT0B+dbsS3
 o80h4N80ZIIt9e24lOXvHBwxFMYUwQKcmd5abjnqIMoBQBC4Knb3Bmhaaf/sC+2fCuRW
 AgZKihQUxDqU1+b9D2QpK54qWJpl8VlFnM6dVWQO46JTGR13nAVjf+NviGtLjKdmLIzE
 qSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089655; x=1779694455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gzWzoTmlyJ+ulEDvy/SGgv3VFS2OT2P9OMuzim+8Q8o=;
 b=Yx35P0KJ35Vb4R0eW9iIC3yuwNRIC81+N/HD+FUMxvCoFnANu3iPAb8GfqwQO9YVXO
 cbIaYi/MUIl+KXqE2My65eBR5hQRk8UMqHRthVARyed+yLoNKiAJ5ZVnicJgzM89VB++
 j/HUGrujrpDuUOI7SiPFCzmv2z+mP2+bb03T3hu/d3b6dzZinAP1rE+wFsZR1PMV8uAK
 S1CsrkKIOxl1Po3s1ki6Q6nxzg4IgkuTMi99PTtWtdDBFyz60LjUZh/bjVk1N76CJiBq
 PC9Ivwn4/cLY0uaffp/FLw9jxmNk7do3Z93IW5RCZ47wXowIkSyKvWgcnX4PHXb5vp7L
 JrZQ==
X-Gm-Message-State: AOJu0YzYUb28Pyq29uOFEGw5RQLygR7RLeJDQ1zCy7EMs8anL9z5I6ab
 0Wg+dF1qKzwAWH42DZWmPU4RGP5uMVHYNRMjtFupGTrrMpXuz5Fn1PDExqe1aPQd
X-Gm-Gg: Acq92OEcxdNsDmIWRDsYJ9cNYmSaUTKTbrxgUUK6DYGJoh3BSG2KYtHPXLvVmJPDVye
 QyA/3FNLHGrxlfRzXnwOj/PrdLVjcrYhL1qD5rdpCM0xKcUIXwi+2tYj9SFff5+eMJ9g1D91KCS
 n6HsgRBEnX9F3n9nVbZzvC83GxkJN4Eab0He4N0iU7jilJOjB+zD+/MMrRV/CP+OTQfoUQqH5ce
 JZ7DIuzdR7o9TihejhqY7q0vZRGqK4y3IlhKi6u4fSFX583A3B6fLXnbJ6BbkHhIUbzZTUDfc+J
 F5/7nOvyZ7tAQRvw1/nw2lVH+M343iV+kXYvRC/m2mff3JBIdAqjNPL2YMrzN9VQfMf8XNerJGv
 i6jI5IkXe32GP0ep5TyJrWspe5s3eV1g/VoxMfKW2MKiKoGxkUfH/ia9LJxXEsIokBuZX+9Gd2f
 rji4L/nJ+15zsUg1QVyUz5j6mvbIOcekvk2k9oVzHRBDEsDq4Aa9JJbO2q
X-Received: by 2002:a5d:584c:0:b0:45d:4020:8b59 with SMTP id
 ffacd0b85a97d-45e5c5877admr21798375f8f.24.1779089654737; 
 Mon, 18 May 2026 00:34:14 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:14 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 11/16] hw/arm/xilinx_zynq: Add flash type as machine class
 property
Date: Mon, 18 May 2026 09:33:56 +0200
Message-ID: <20260518073401.11279-12-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

Introduce ZynqMachineClass with qspi_flash_type field to allow
different Zynq-based machines to specify their flash device
type. The base Zynq machine defaults to n25q128.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c         | 21 ++++++++++++++++-----
 include/hw/arm/xilinx_zynq.h |  8 +++++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6c83439017..52c9e41a76 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -120,7 +120,8 @@ static void gem_init(uint32_t base, qemu_irq irq)
 }
 
 static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
-                                        bool is_qspi, int unit0)
+                                        bool is_qspi, int unit0,
+                                        const char *flash_type)
 {
     int unit = unit0;
     DeviceState *dev;
@@ -152,7 +153,11 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
         for (j = 0; j < num_ss; ++j) {
             DriveInfo *dinfo = drive_get(IF_MTD, 0, unit++);
-            flash_dev = qdev_new("n25q128");
+
+            if (!flash_type || !flash_type[0]) {
+                flash_type = "n25q128";
+            }
+            flash_dev = qdev_new(flash_type);
             if (dinfo) {
                 qdev_prop_set_drive_err(flash_dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
@@ -204,6 +209,7 @@ static void ddr_ctrl_init(uint32_t base)
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
+    ZynqMachineClass *zmc = ZYNQ_MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev, *slcr;
@@ -283,9 +289,12 @@ static void zynq_init(MachineState *machine)
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0);
-    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n);
-    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n);
+    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0,
+                              zmc->qspi_flash_type);
+    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n,
+                              zmc->qspi_flash_type);
+    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n,
+                              zmc->qspi_flash_type);
 
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
@@ -460,6 +469,7 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
+    ZynqMachineClass *zmc = ZYNQ_MACHINE_CLASS(oc);
     ObjectProperty *prop;
     mc->desc = "Xilinx Zynq 7000 Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
@@ -473,6 +483,7 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
                                           "Supported boot modes:"
                                           " jtag qspi sd nor");
     object_property_set_default_str(prop, "qspi");
+    zmc->qspi_flash_type = "n25q128";
 }
 
 static const TypeInfo zynq_machine_type = {
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index cefb7789ff..662b390431 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -12,11 +12,12 @@
 #ifndef QEMU_ARM_ZYNQ_H
 #define QEMU_ARM_ZYNQ_H
 
+#include "hw/core/boards.h"
 #include "target/arm/cpu-qom.h"
 #include "hw/core/qdev-clock.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
-OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
+OBJECT_DECLARE_TYPE(ZynqMachineState, ZynqMachineClass, ZYNQ_MACHINE)
 
 #define ZYNQ_MAX_CPUS 2
 
@@ -27,4 +28,9 @@ struct ZynqMachineState {
     uint8_t boot_mode;
 };
 
+struct ZynqMachineClass {
+    MachineClass parent_class;
+    const char *qspi_flash_type;
+};
+
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.47.3


