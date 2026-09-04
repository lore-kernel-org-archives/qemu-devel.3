Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA679C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MN1-0001Iq-UV; Fri, 04 Sep 2026 01:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMy-000111-CP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:44 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMw-0001TO-NH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:44 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so742546a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499301; x=1789104101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IS63YjbZimT+d/Zb2Wd4R8mti1Z4Mdnfs3R5KuYid8Q=;
 b=rOxFA4JXV4TXIQk/0aLoS0levbJWr4yCTJT3T0eo/gmPHLnW8dnAKC8Npao3YGFnVa
 oYwA2BLPLk9JvxR6OzK9LvKKHw2GNouQl/NV7uXBoPbzB6ykd2zdIduQn0eKQ/sKjzOO
 AWc9QGrf29m8iJE+/5gAeC2XWkhn33vHQAYaIyp/0haf7tDp0/BsLkm4Q7HMcDs5hBD1
 PWkLxqHAAmYbV3FzD8PfjFy6eByRe+oOHanAcm7IYnZYwfGGeaQ03mel4b0wj5nY7g/A
 MluImiOFtZjUZStwkwDZdMikniJrGijE95dZ/PyT/cOnNziJpnn+PjrVzLS71oY+0h7h
 oqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499301; x=1789104101;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IS63YjbZimT+d/Zb2Wd4R8mti1Z4Mdnfs3R5KuYid8Q=;
 b=EeUYJ0D3hDreMdZurkP6EVc8RxA7WwTWOBW8fjIpQEVIsaCuvAel3zvOeabBZBFEys
 NofVYOZUzPvAje1aDbHQXgGZsu/cuhyfIag50wF47rtaWjhDlYMpVVuAwZI4JCC0kWcP
 t9uLDNk5l+JlMama1nmV3BKdW0uK794gOis9I0wQzmbJamDd3LHjCMu+jI1SVOMWYQTk
 W66e2RymkqqWDx4+q2y7PIPKxq/QIHnWuShrXHoDKXtd3R2S9I3oB4b8uo4rTyypDd2s
 igJI5GEtN3dBfE3NCAftSqVsA6dlGUstpY6kMKxJ9025jOy5dsC31GhJ6XxG3VtaB5bu
 yc+Q==
X-Gm-Message-State: AFuF++lcMobwGZ8dTTf8dzdhTZ/4K/6WI0AyXF9UknRO9TbYg2EZAzj2
 9phzMxRBZAnVYWbNUciWaBiv1fez8U7Wagv22c2LKPinWcsOy74QxCahnp8SYA==
X-Gm-Gg: AYBFou3L//stQ4VhPcn3NKTK2BNp4bdUH98cSqvCjz8i9OvIoeLDUmXcKM5V7Wr6Dkl
 T/Xqj0ai7JVyjqt6J8bICLfjQwD7RgtoK/LK0jNRio6nPpCD8jqkPFT437pA5kR+h/bpvXxbZf1
 kkect7x2IQcY5yPrU2QQCemUNUo1y664SXOU6KIDQfeijSUxVRFu1RDHXlBy4jHh0zYLCcbqpHS
 t3pwfIohT8t1ayXNijF6X3ikwjRXdKkQE2QxZCD/z+T97nNrF7rnQ7Et8V6mXMzyT+azJXk62sO
 U99xz+sEu6m8qaMPiWQPYzTlyNKr8FtHV7AT7Um0/NlVQO+0Sq9636tdUHKPCinOXqjXpXt9+3R
 I0ed3PNO/VBqyxR0XnMi/z5YPmEht37pzwWmUOjQ+LvjDcN+4UpsVUGG5BnlheokRA+P39QEiLx
 KG2lHV3zRrQxp1DpsrpTC+Qog7FkRsuasL/Z+yxFQsEDEerFQ2FIlffexu4gLKFcp0b9veStWEJ
 oCazA==
X-Received: by 2002:a05:6a20:d80f:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3da39e70fc1mr5287630637.9.1788499301180; 
 Thu, 03 Sep 2026 22:21:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/47] hw/intc/riscv_imsic: Take a MemoryRegion for the created
 device
Date: Fri,  4 Sep 2026 15:19:30 +1000
Message-ID: <20260904051943.799041-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

riscv_imsic_create() maps the device it creates into system_memory,
which prevents its use by SoCs that map devices into their own memory
container.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). All callers pass system_memory, so there is
no change in behaviour.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-4-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_imsic.h | 3 ++-
 hw/intc/riscv_imsic.c         | 6 ++++--
 hw/riscv/aia.c                | 6 ++++--
 hw/riscv/xiangshan_kmh.c      | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index fae999731d..0a1df1c2f8 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -62,7 +62,8 @@ struct RISCVIMSICState {
     uint32_t num_irqs;
 };
 
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(MemoryRegion *container, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids);
 
 #endif
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index d6b46cdca2..cb9ce9612c 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -495,7 +495,8 @@ type_init(riscv_imsic_register_types)
 /*
  * Create IMSIC device.
  */
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(MemoryRegion *container, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids)
 {
     DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
@@ -518,7 +519,8 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
     qdev_prop_set_uint32(dev, "num-irqs", num_ids + 1);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(container, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     if (!kvm_irqchip_in_kernel()) {
         for (i = 0; i < num_pages; i++) {
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index e11382e512..eae7638f97 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -53,7 +53,8 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * m_imsic_stride,
+                riscv_imsic_create(container,
+                                   addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
@@ -62,7 +63,8 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
         /* Per-socket S-level IMSICs */
         addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
         for (i = 0; i < hart_count; i++) {
-            riscv_imsic_create(addr + i * s_imsic_stride,
+            riscv_imsic_create(container,
+                               addr + i * s_imsic_stride,
                                base_hartid + i, false, 1 + aia_guests,
                                num_msis);
         }
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 7ebe422dfc..bb9b1e05ef 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -64,14 +64,15 @@ static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
     /* M-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_M].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
+        riscv_imsic_create(get_system_memory(),
+                           addr + i * IMSIC_HART_SIZE(0), i, true,
                            1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
     }
 
     /* S-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_S].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr +
+        riscv_imsic_create(get_system_memory(), addr +
                            i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST_BITS),
                            i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
                            XIANGSHAN_KMH_IMSIC_NUM_IDS);
-- 
2.55.0


