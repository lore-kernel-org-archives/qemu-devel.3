Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B264C5AD2B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 02:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsWtD-0000H2-Mg; Fri, 07 Aug 2026 22:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wsWsy-0000Cb-IL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 22:34:13 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wsWsu-0007E9-41
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 22:34:08 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-381b831d535so231817a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 19:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786156430; x=1786761230; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DrxZzHUwdc5+GfibuEQ6wnGR+ecsPhEIDC0zKF5DI/I=;
 b=CDvnCebMk9ad9pl21nIDkRiR5u3uVWSmHNFN6fOniH2qoa5rIXCuUkX1vK41anpNZ4
 BFuuVFFv+6tAQ5GFuGz/LeVjj2kCamGr907WF8/qiEFaTwMC3JhGhahnH+um/2Gpg5Pp
 O8IZbIwuIk+WDhj99wfUSsC6b51hIzlPEh6E5xAbKM7RqPcayd2FupzRGyXs8ZP9zTuh
 SLLjq9CLh3lE2FUX78BONgRgThCd7F0Jd5TL7ESpq4y6VtNeICztsT94bZcqIaHa7uLY
 0NttbwzVg2TxHU0anO+LYu0TZxCSPnxAhVlEgwLV/D1ozEQHHmtYor+deLrOC/JehMLk
 Y8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786156430; x=1786761230;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrxZzHUwdc5+GfibuEQ6wnGR+ecsPhEIDC0zKF5DI/I=;
 b=ADQUIEd9gRcG1XtHN26ZWQu2R7ZOelJImxz+ZkGac9owQss0xsXsg4rcR7T6OcZDY9
 Bxsva6RKuu1VAJ3+rwGEP951x5biQ41zUTM86v+qqmmdonu/fXavN2wNSFU2YKeduGhZ
 JN7rSfuqi8rO1ItNeyNs0BeVmO1anaRO5Llnb2t1CRUkBGK4p4EsuZqKslMT70RLpB+d
 Ok3vwfukpua3ZYsCeCql9I7N8GM3Uw88Dn8UJJzjzcTGEuodveW9zgewJ/dsuT50c/7k
 ZRVLRRVj/hlNS09V2/4kvdYYgpIo4b8cdu05z0/C1cWN+o1rQYgnjPHea3wtFcZ9lPsV
 X5MA==
X-Gm-Message-State: AOJu0YyMZOFCcaWfOZaHdxBvmKxExM6DkDgPM3u6yqL6E7l/cDrwvSvQ
 DB0hd25rAEtp6KoYdK4gPXZs4heaI5R7r+9G5xtFa3eBllU26dWa7/sx
X-Gm-Gg: AR+sD13oVsNpI6d4JlALVkCNl94B5b3oNWhRJKmT1ZaAOxkSXJ5G9kmp67ZbuiyiAO7
 9/gkEoGGYAWXoq26bRKW8HIC0LN1htC/H3ZgNAnzbyGxdk1oD3906h28dAAX+Qx4gw71BQiSJmO
 S2nFsYBRm0nyhc7CoJiFnY1IZ3fuaI9GtGEwQ5TvM0PC6W+OHtn62Jfx7CAv2krljl7TkXHxTBZ
 YMlP9XFuXvcbaXkHTRea3ITaqHN30+4uozZkAqPJQN8esBoWLyTgawR7hKBF7QyrRFFUxUFm0rh
 sqCKfUC9ylYqTj1cEPgJXthgtNh4vn9n9E7HgJ6gWuJnxZMKgAvIr0VUVYVAU+GKDbyBddidf7X
 oFndPNXhh/Wi/qy1qgJRxTrhZ696t2vRl1RRfn1fanQ9iwYPFFFqDaoO0kBDRehwu3WcEvshXKu
 hUxblde+vesmanX7Y9GJElS2X1zRXJP7vn/YohAbrZ7yaLQzUp9lEULyuW5g==
X-Received: by 2002:a17:90b:4c03:b0:38e:655c:6516 with SMTP id
 98e67ed59e1d1-39261d10765mr6461637a91.0.1786156430391; 
 Fri, 07 Aug 2026 19:33:50 -0700 (PDT)
Received: from [127.0.1.1] ([14.19.40.154]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925ff69eabsm4475835a91.15.2026.08.07.19.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 19:33:49 -0700 (PDT)
From: WX Chen <wxchen0913@gmail.com>
Date: Sat, 08 Aug 2026 10:32:43 +0800
Subject: [PATCH v3 2/3] hw/riscv: k230: connect DW 8250 UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-feat-k230-uart-v3-v3-2-d73b31f0034b@gmail.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
In-Reply-To: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786156416; l=4451;
 i=wxchen0913@gmail.com; s=20260725; h=from:subject:message-id;
 bh=asIegPxVJrAEDP8njRhzW1M1nb230OJXI4U9qipMm0o=;
 b=8FcruHZRT3nIK85M2aJlUgTIRtybHxD9ol3URb2PgNCophjIBSMnqFlDnVFWuYoFgYe/DC0kx
 T6NFG/l7o4xBYZHS9ZlsCveXNN+R06T4WEcLKINvcYZ6ERAXQfBZ2Hz
X-Developer-Key: i=wxchen0913@gmail.com; a=ed25519;
 pk=FX63IRxmtz1BCNzHxOOWDPTo8L/D0YUxlIKc1WKi7wo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=wxchen0913@gmail.com; helo=mail-pj1-x102c.google.com
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

Replace the generic serial-mm device with the K230 DW 8250-compatible
UART model added in the previous patch.

Signed-off-by: WX Chen <wxchen0913@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


