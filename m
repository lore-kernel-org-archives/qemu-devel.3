Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307DACA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQHj-0003UB-08; Thu, 01 Oct 2026 19:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHg-0003TN-SH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:52 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHe-0002CX-US
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:52 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d6ff23d81eso5775945ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790897629; x=1791502429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z0CZJjgL7f++vEKCbjrGqpyRC/763kspkVSq1+XR7pY=;
 b=MrnCVv/1MdlJ2gjvqDJkV6pHcf9Y33MC+E3tQjqgsWqJAWjSin3yUQOojNKGXy23pi
 /LuxV07wbkdqRLtAT3KJmHG2qWQeDk0sYRfc3aD0wkPT2DtLTVFj9E0LSuZYB79Hy3Co
 mKRzJehRPOuoI6ZEw1VO41+e1loKxLPaDQvPZPJAIiR57ly3ZW/NQEOqyO/YHz1S8bGh
 N8UJQ7Z76LHa1VTdsJTtbFK2hJappsg9g+ISeAY1aZyPAPivWeOHVD6U9UjE0iw02/qj
 +DOH6BzMVkv7ZCa4eU4S5s/WFyi0v0t+qMczPDvQPkL//I9EOXoYgUKiuoy68vT9x+0q
 3gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790897629; x=1791502429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z0CZJjgL7f++vEKCbjrGqpyRC/763kspkVSq1+XR7pY=;
 b=2sPorHF8u1kRtZ46PDfOBlGrYDR2S7ANjuzxn7TkDT1zLzX3/mRPMZctg/mnZsZI+C
 GTSLkx4TKCfjG9S77lblfb3q0gNa/qrG3j5jPaIFRjPGLlgSSvg3UyMdM4KCap6DhwGX
 bpH0xfZWj5zg4BYbzRWJx8jlnTxH+REEwns0iE9M52FIe3pTT0euZlAhBmTYdQgYEmFM
 jeyncX8JF0903DDCgVLqRFsxUeHmvkaRRqqHsI+KQ6Cvh+TtGCJcK4+rUuEu7Jc1y2J4
 UUIwEXY4dXOw2ctGpWxjEB8h1FGGpihBf8mng9UQaCIQcohXzR4CIlIgc2z75r1xUmSq
 /07A==
X-Gm-Message-State: AFq9FYK+CGLa+3nnjhdYjkkQVm6Zg/OkbwWvezMyIXIfP2/0MPHFeRCM
 a9wAQUqrz8EB2nUhLOKeSuvtZ1HoCKlFyqv/dU8wjNKJfX+/JhMXpgH2cJXin8sk32NmHicTeNj
 FlKT+Ips=
X-Gm-Gg: AYBFou0ToAXcXikC/kZMUpWCnMEcZCIfViHhQE0kufnM9MOJaLLMS7WafqwFX2vDxd/
 XIQ5byO6HeeHkG+DxQQDBFu/A6Pz0VEHHh0ZSNBa2vWRoIHxU24LjA8fSHtx74yoYte05m8HnwR
 80CRc8ITIKg+oTRgepSvsKH7VmqN90rchhtXbq1e46RfmWynHLloMdvRQrXl69XrPqj1Y5Gt1HY
 /l7/JTMD+sR+Ao3WijQV95P1FG0XfXhxhztamcCLGdV0krVAz4wEbvFj225WX2I3Ah6xRy5trvJ
 T1+Nyb/GWeMV3heZKwN+90vdwYDGNP6/iVO3SVheFTLeGTjqoNHG+trXHwxjTssgFb6jWSotzCp
 i8rrbNH+LrD7Z5HG4/2an2R72yEz2mnMu5h1CseKvHdnHYspsDqMSAHdpJ1XQa3ThqoxQKxXKS2
 HcQemfh+VMQ08cLTTNbstilm7AmnaeckaMU98y8ARsk8JlFS8GTA8wvqj3SPpYFsLG19uEkbfHN
 MUBFTsqoEu8gWbBAFzuXf4IT1vLNBz6MrtZc1A/E3z2qVUiezDbikhtgA==
X-Received: by 2002:a17:902:da85:b0:2e2:dd98:59da with SMTP id
 d9443c01a7336-2e49b659ebfmr14081465ad.4.1790897629391; 
 Thu, 01 Oct 2026 16:33:49 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6aea97sm1851855ad.45.2026.10.01.16.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 16:33:49 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 3/4] hw/riscv/atlantis: Add machine property to select
 default uart
Date: Fri,  2 Oct 2026 09:33:23 +1000
Message-ID: <20261001233324.2636629-4-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
References: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Atlantis SoC has 5 UARTs. This adds a machine property to set
which uart is on the first serial interface. This is the same pattern
that is used by aspeed. The rest of the uart's will be added in
sequential order starting at serial interface 1.

The default value is uart1 which means the Ascalon console will be on
serial interface 0 by default.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/tt_atlantis.c         | 77 ++++++++++++++++++++++++++++++----
 include/hw/riscv/tt_atlantis.h |  1 +
 2 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 2342edce93..7a5e1ddcd1 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
+#include "qapi/visitor.h"
 
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
@@ -422,6 +423,26 @@ static void load_fdt(TTAtlantisState *ams)
     create_fdt_memory(ms->fdt, &ams->soc);
 }
 
+static inline int tt_atlantis_uart_index(int uart_dev)
+{
+    return uart_dev - TT_ATL_UART0;
+}
+
+static void tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState *ams)
+{
+    TTAtlantisSoCState *s = &ams->soc;
+    int uart_index = tt_atlantis_uart_index(ams->uart_chosen);
+
+    qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "chardev", serial_hd(0));
+
+    for (int i = 1, uart = 0; i < TT_ATL_NUM_UARTS; uart++) {
+        if (uart == uart_index) {
+            continue;
+        }
+        qdev_prop_set_chr(DEVICE(&s->uart[uart]), "chardev", serial_hd(i++));
+    }
+}
+
 static void tt_atlantis_machine_done(Notifier *n, void *data)
 {
     TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
@@ -484,11 +505,6 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
                               fdt_load_addr);
 }
 
-static inline int tt_atlantis_uart_index(int uart_dev)
-{
-    return uart_dev - TT_ATL_UART0;
-}
-
 static void tt_atlantis_soc_init(Object *obj)
 {
     TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
@@ -592,10 +608,6 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 &s->bootrom);
 
-    /* UART1, the soc console (UART0 is for the boot microcontroller */
-    qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
-                      "chardev", serial_hd(0));
-
     for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
         if (!sysbus_realize(sbd, errp)) {
@@ -663,6 +675,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
                              OBJECT(&ams->soc_memory), &error_abort);
     object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
                              &error_abort);
+
+    /* Map serial interfaces to uart */
+    tt_atlantis_connect_serial_hds_to_uarts(ams);
+
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
@@ -680,6 +696,47 @@ static void tt_atlantis_machine_init(MachineState *machine)
     qemu_add_machine_init_done_notifier(&ams->machine_done);
 }
 
+static void tt_atlantis_get_console(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
+    uint32_t uart_index = tt_atlantis_uart_index(ams->uart_chosen);
+
+    visit_type_uint32(v, name, &uart_index, errp);
+}
+
+static void tt_atlantis_set_console(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value >= TT_ATL_NUM_UARTS) {
+        error_setg(errp, "\"console\" should be in range [%d - %d]",
+                   0, TT_ATL_NUM_UARTS - 1);
+        return;
+    }
+    ams->uart_chosen = value + TT_ATL_UART0;
+}
+
+static void tt_atlantis_machine_class_props_init(ObjectClass *oc)
+{
+    ObjectProperty *console;
+
+    console = object_class_property_add(oc, "console", "uint32_t",
+                                        tt_atlantis_get_console,
+                                        tt_atlantis_set_console, NULL, NULL);
+    object_class_property_set_description(oc, "console",
+            "Change the default UART index on -serial. Valid values are 0 " \
+            "through 4");
+    /* Default to UART1, the Ascalon console */
+    object_property_set_default_uint(console, 1);
+}
+
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -693,6 +750,8 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->default_ram_id = "tt_atlantis.ram";
+
+    tt_atlantis_machine_class_props_init(oc);
 }
 
 static const TypeInfo tt_atlantis_types[] = {
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index b81b7c8abd..7bd46e9c9b 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -56,6 +56,7 @@ struct TTAtlantisState {
 
     MemoryRegion soc_memory;
     TTAtlantisSoCState soc;
+    uint32_t uart_chosen;
 };
 
 enum {
-- 
2.43.0


