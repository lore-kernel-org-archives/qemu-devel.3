Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB4CC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnb5V-0005zl-OX; Sat, 25 Jul 2026 08:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wnTQz-00054k-GS
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 23:52:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wnTQw-0005zI-OA
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 23:52:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso12466845ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 20:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784951537; x=1785556337; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ayrv9KOlmMCYHw6G8uVmOcbEgILQkAfO1hlEgsaxiK8=;
 b=ql1zsLUCp/Wp1/JfQTXgNr1ioPATxTy5/Np8rysPll2GxX/ibHbgi48RfoYrMSVXp+
 9UNrZouwuPVW3kHN+VhhEOpwju3YFfYBG1qgpC4hVM/1BMQgFQDEeDhvL4Nfy+qq5LS4
 UHeCwm+r8iGTgnjONlF2NsuUydB6mfkZHVIYAANc5MahDDW4uGh6J+XQ3YBMM7iBLGou
 j+KMBmbRSqylc2Y6lpuE5LsqYyQMMwm9Y8FND/6bGIOlAB0mn7HfZcGwFwwX+OHAGtI6
 LmswLbfs3PVpdn/2zIAFLnhj+bB2GIvJjAtLMGlR4yLAmRHeoOMuFsdTDAs2lmhGz8HX
 KWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784951537; x=1785556337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ayrv9KOlmMCYHw6G8uVmOcbEgILQkAfO1hlEgsaxiK8=;
 b=rt6jMebSEdA7ZCyGZb2LoAC7McV6x3kvvJF2VPymjivQt0qygLAx3efjdN5uSiyiMe
 VEzC6L+2zVsuS4OLpEnYD9PcBXrigJ1wD1kx3yA6i5xpq5+Rcb+apAevyETQRIfF3fkd
 izp2J35+BvslFmEHrXweffEqQTUw7NCMU4ue2ngWCAGhLFHJZ2mbAZVqXAPhPm2iZyhk
 VUQgx6nrg0Qz1HCMHeOT309bqKYb64mgVbtpm8KGJdCqAeFuJ5Qx3K+V1mZjE4om6Vpg
 f8lH3S4EwiCZafO2SOzYIFqphX0gZYQpYkxbA13ICdzI9Noea2+MRDLhgKaW+7eiMEH4
 fJhQ==
X-Gm-Message-State: AOJu0YzB2+AphHbiaZPcj+16PqbS22NOTqvZv4DK2KYeUZ6iScoCiEC7
 PnTDINUOo5ZYicBHlsxBX4j+y+DVDfPNfGufDajy1A+/YYiMvmL6RJsL
X-Gm-Gg: AR+sD10JNUnWHqdPlCvtEyZJ9sATZhiF4vbrsXzYbU/Qpg9SntAyoSTDM2w2etgyLif
 uSrj4DviyvdOGfQAcPrlj0/LoXQykAWA6xUYupPknZ9YotZdKZkR8/B3hUH7nn5LbKYoiEPkPSV
 Dv/eqmWwIAhYqflG4hWOcdDOiEn7mZkQ3EJy4ACh1kkhIf4ds4NmlxDaM0fwRzECVuuOz79PgKM
 wKR1I3+tS5mjLocrreSUYi2BLvD4GKy1M3cpSqc4At6nC+ra7ryeTLxCClyvekP8tx+VmrVjaRW
 aN3BRyupcGV1IGZtdJBzTRCAqzkrEsiE0+zx9OvtZs3X7n33ScLN/xK1x2WKzbIcBfdVz0sMqN1
 tGmrCeVWkr4lnXoZ02GGxd+xrEcbrLxw482SWJbSL0lGVn72Rg3lTqZLAf8p7X/RVWqeKy90wqn
 ZB
X-Received: by 2002:a17:903:17c8:b0:2ca:ea56:7a58 with SMTP id
 d9443c01a7336-2cfde851e69mr9220345ad.37.1784951537412; 
 Fri, 24 Jul 2026 20:52:17 -0700 (PDT)
Received: from [127.0.1.1] ([183.6.125.102]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde5c8337sm4109975ad.20.2026.07.24.20.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:52:16 -0700 (PDT)
From: WX Chen <wxchen0913@gmail.com>
Date: Sat, 25 Jul 2026 11:52:04 +0800
Subject: [PATCH RESEND v2 2/3] hw/riscv: k230: connect DW 8250 UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-feat-k230-uart-v2-v2-2-d5fe82c47c28@gmail.com>
References: <20260725-feat-k230-uart-v2-v2-0-d5fe82c47c28@gmail.com>
In-Reply-To: <20260725-feat-k230-uart-v2-v2-0-d5fe82c47c28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 WX Chen <wxchen0913@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784951524; l=4379;
 i=wxchen0913@gmail.com; s=20260725; h=from:subject:message-id;
 bh=wTtU9/wv9XY+zL7PXDpOxalw5XS6oOWy8XhPBbBdXLg=;
 b=fdMX+5kqzEiBTu+2L5LdGLaYVekk9z0xQQVtsBvhiYgHj6JW4AJYhzQLPD+OOQmbxSWcG2N7e
 67wvZxo0C+YBswo/Sasa7PlFVdGUs4Q4F2Wc9OmVsr9LfcafaZpjwA4
X-Developer-Key: i=wxchen0913@gmail.com; a=ed25519;
 pk=FX63IRxmtz1BCNzHxOOWDPTo8L/D0YUxlIKc1WKi7wo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=wxchen0913@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Jul 2026 08:02:38 -0400
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

Replace the generic serial-mm device with the K230 DW 8250-compatible
UART model added in the previous patch.

Signed-off-by: WX Chen <wxchen0913@gmail.com>
---
 hw/riscv/k230.c         | 33 ++++++++++++++++++++++-----------
 include/hw/riscv/k230.h |  6 ++++--
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 502281c52cff1dce6febb7487dfdefefe6363e9c..d49fa23448f38dfed45a570eb5bece64519bfe27 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -29,7 +29,6 @@
 #include "hw/riscv/machines-qom.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
-#include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 
 /* Align K230_SDK k230_canmv_defconfig */
@@ -111,6 +110,11 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
 
+    for (int i = 0; i < K230_UART_COUNT; i++) {
+        g_autofree char *name = g_strdup_printf("k230-uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_K230_UART);
+    }
+
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
     qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
@@ -136,19 +140,26 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
                               memmap[K230_DEV_PLIC].size);
 }
 
-static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
-                             int index)
+static void k230_create_uart(K230SoCState *s, DeviceState *plic, int index)
 {
     int uart_dev = K230_DEV_UART0 + index;
-    g_autofree char *name = g_strdup_printf("uart%d", index);
+    g_autofree char *unimpl_name = g_strdup_printf("uart%d", index);
+    DeviceState *dev = DEVICE(&s->uart[index]);
 
-    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
-    create_unimplemented_device(name, memmap[uart_dev].base,
-                                memmap[uart_dev].size);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(index));
 
-    serial_mm_init(sys_mem, memmap[uart_dev].base, 2,
-                   qdev_get_gpio_in(plic, K230_UART0_IRQ + index),
-                   399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal)) {
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, memmap[uart_dev].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(plic, K230_UART0_IRQ + index));
+
+    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
+    create_unimplemented_device(unimpl_name,
+                                memmap[uart_dev].base + 0x100,
+                                memmap[uart_dev].size - 0x100);
 }
 
 static void k230_soc_realize(DeviceState *dev, Error **errp)
@@ -188,7 +199,7 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
 
     /* UART */
     for (int i = 0; i < K230_UART_COUNT; i++) {
-        k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
+        k230_create_uart(s, DEVICE(s->c908_plic), i);
     }
 
     /* Watchdog */
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf8a8f8a1c66653ff9b568fbfe98a3ea..fed0357c2b9e1f5254cb157e0cd4d75d4946d1a1 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -17,10 +17,13 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/char/k230_uart.h"
 #include "hw/watchdog/k230_wdt.h"
 
 #define C908_CPU_HARTID   (0)
 
+#define K230_UART_COUNT 5
+
 #define TYPE_RISCV_K230_SOC "riscv.k230.soc"
 #define RISCV_K230_SOC(obj) \
     OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
@@ -32,6 +35,7 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230UartState uart[K230_UART_COUNT];
     K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
@@ -131,8 +135,6 @@ enum {
     K230_WDT1_IRQ   = 108,
 };
 
-#define K230_UART_COUNT 5
-
 /*
  * Integrates with the interrupt controller (PLIC),
  * which can process 208 interrupt external sources

-- 
2.48.1


