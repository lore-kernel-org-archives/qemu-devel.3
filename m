Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89409CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9LS-0001eH-EF; Wed, 14 Oct 2026 20:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LM-0001dD-Uz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:12 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LL-0000x0-9o
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:12 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-396affa9420so579361a91.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792024150; x=1792628950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=96m7yUeEnu5RNF8FuHUfexVxOzeNw847xHOd8FX3/3U=;
 b=glqtFOXMzq7wVTsLQSQzd9vWuPTjrcGENlH5FO9VziWsxJMsFW8vb8DZEe+uuhPN2t
 RO9aXkrAZdHFxAyZwGuCeaIjNsTr4OcLKIfAyIdtJ34NkLxHCrzSmenjoYHWXMJWiVuq
 5kTmPjlKTBTzOktzqz4oqsEC4WINoT9vUpAMPwbapamcrGBaUyK5jFzko3wHrHAW6J3G
 OPI9OyZ8n0FqhIRUGrDxSyaFG8IMSp2kq99gqxjOQ5AMQlFGyKlsHNkSspSL8EF05SDD
 HgUcZgr+nbu7IfJ6q61SEicjAukPL9d9uDf0z4yTKuotKHd/NnrOrYS9uB1Gn4M3pbn8
 LqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792024150; x=1792628950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=96m7yUeEnu5RNF8FuHUfexVxOzeNw847xHOd8FX3/3U=;
 b=PdJ+BYBsx/EI5jf3KF81WnIYWXbsz/haZiGVftHFKeaElxUp6rZQzJ2Ae2U0MzdxOB
 6bzxkVbfd02gisj+VTIE625H8WaiV5aIbEury7N5/dzZ82KtpfrpdQF0MepNgeqeDtJi
 cEG2y5HzoHTe7vh58QmIJ+ma+/sxfnBivytlUl66Wza8OM1Uent3+IrBKlbXyxnJ/CVJ
 YeYE8sq+0ty1shWlljPj7WSbCIQrpDlWx9d6odUg2fl6yyZ3yg8ZrhBcnE6Wtl8l1cp3
 xYIjO/YoF89hggpvYhutdvH6ZOwvh52v1nCoPM+Efz5YqYexvXZjH9CbQw/fsI2y3f3D
 D3Cg==
X-Gm-Message-State: AFq9FYJsyMMmdlUWhJj9ECJnCPmZ9yMOkJOeO4BElH42vspelJOZTRyf
 A8IkFEoqYI1VStdyJmLWK05hr6bYXAdG+llSOQIUS91U16mHXjVAwwd6IMwDuEJfBU5CtPuYl/Y
 TnAVVjYU=
X-Gm-Gg: AYBFou1THqyotDjebkCaHtdHWZc6E2qB8tiavZjwMa7gG4bIpvxbZU+qNYA7PmodyUy
 ZTJRVtjRv0xFznzbpCqm30LRzJmYlo/iJEsD5gOZeELnwNDjLDrurnNeABWB5RRs9HuUOSq3n+b
 TIGUGDrvaTcO9+P7HxRTgQliL/qj/5vRCFoNyhgnZB28KGOLKQXxW/1qwTqf5MVN7wlFyaCX3i4
 KAL+Wcg/iA+OfwznZigP7m+kfp091FseZmhv27pJHvxAbwCBHIZFZp9q2ym36GqwujbZUELEJl/
 Yk1staVkRl0cK+6v9zhh0zDQlghA1qcson/+yabDnhyEorp4rN4SsVYO4guemMUQ6NHtFCg1so2
 +HwkO9JNAPuFEb8Irhn7vXEAX37A/TcbvznRBVRyx/tQT/j3B8PJvYerjenmPul4ZqRLh3gfCrQ
 x86YeFk0HZIu03TAaWBTjQXPEEdYaLCHhSoGkSG4n92lhjqPyamBe0nWKXMmbA5CtC73APILJG/
 hFcq0aGWS8zESAd4I/L3LMG/Usi1+cSvULbTdn49IvI1vcNxNF7wLtNsg==
X-Received: by 2002:a17:90a:d44d:b0:3a6:e1d1:e511 with SMTP id
 98e67ed59e1d1-3ab3aaf4689mr23525449a91.4.1792024149904; 
 Wed, 14 Oct 2026 17:29:09 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a49d7bsm795730a91.0.2026.10.14.17.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:29:09 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v5 2/3] hw/riscv/atlantis: Add all UARTs for Atlantis SoC
Date: Thu, 15 Oct 2026 10:28:48 +1000
Message-ID: <20261015002849.1640109-3-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
References: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Previously only the Ascalon console UART was enabled, this enables all 5
UARTs on the SoC. Only UART1 is added to the serial interface for now.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/tt_atlantis.c         | 36 ++++++++++++++++++++++++++--------
 include/hw/riscv/tt_atlantis.h | 11 ++++++++++-
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index dfd6bc6ba6..311de64eda 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -64,7 +64,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
     [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
     [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
+    [TT_ATL_UART0] =            { 0xd4100000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
+    [TT_ATL_UART2] =            { 0xd4120000,       0x10000 },
+    [TT_ATL_UART3] =            { 0xd4130000,       0x10000 },
+    [TT_ATL_UART4] =            { 0xd4140000,       0x10000 },
     [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
     [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
     [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
@@ -531,13 +535,21 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
                               fdt_load_addr);
 }
 
+static inline int tt_atlantis_uart_index(int uart_dev)
+{
+    return uart_dev - TT_ATL_UART0;
+}
+
 static void tt_atlantis_soc_init(Object *obj)
 {
     TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
+    for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i],
+                                TYPE_DW8250);
+    }
 
     object_initialize_child(obj, "prcm-rcpu",
                             &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU],
@@ -682,13 +694,21 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
-    memory_region_add_subregion(s->memory,
-                                s->memmap[TT_ATL_UART1].base,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
-                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
+    qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
+                      "chardev", serial_hd(0));
+
+    for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
+        if (!sysbus_realize(sbd, errp)) {
+            return;
+        }
+
+        memory_region_add_subregion(s->memory,
+                                    s->memmap[TT_ATL_UART0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ + i));
+    }
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index fc7a4337cc..f965bf23fc 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -25,6 +25,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
 
 #define TT_ATL_NUM_I2C 5
 #define TT_ATL_NUM_PRCM 4
+#define TT_ATL_NUM_UARTS 5
 
 struct TTAtlantisSoCState {
     /*< private >*/
@@ -41,7 +42,7 @@ struct TTAtlantisSoCState {
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
-    DW8250State uart1;
+    DW8250State uart[TT_ATL_NUM_UARTS];
     MemoryRegion bootrom;
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
@@ -66,7 +67,11 @@ enum {
     TT_ATL_I2C2_IRQ = 35,
     TT_ATL_I2C3_IRQ = 36,
     TT_ATL_I2C4_IRQ = 37,
+    TT_ATL_UART0_IRQ = 38,
     TT_ATL_UART1_IRQ = 39,
+    TT_ATL_UART2_IRQ = 40,
+    TT_ATL_UART3_IRQ = 41,
+    TT_ATL_UART4_IRQ = 42,
 };
 
 enum {
@@ -83,7 +88,11 @@ enum {
     TT_ATL_MIMSIC,
     TT_ATL_SAPLIC,
     TT_ATL_SIMSIC,
+    TT_ATL_UART0,
     TT_ATL_UART1,
+    TT_ATL_UART2,
+    TT_ATL_UART3,
+    TT_ATL_UART4,
     TT_ATL_PRCM_RCPU,
     TT_ATL_PRCM_HSIO,
     TT_ATL_PRCM_PCIE,
-- 
2.43.0


