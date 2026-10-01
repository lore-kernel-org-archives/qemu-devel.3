Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA0CA5FC1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 03:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC7Ir-0005pH-SH; Wed, 30 Sep 2026 23:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7Iq-0005mz-Cx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:17:48 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7Io-00078S-Im
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:17:48 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39666e7c9efso639531a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790824665; x=1791429465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4c5FfX5EP1m/8GM0Bx9eKe2xi/9IKqhmT/IEJvJNlUo=;
 b=E7c3FUFtjKGfgKyXu0adBkVYvR7f1L2xNwmLSUfP41MCa9DbMPXkzym0F0bfUr+H0j
 rMM8mD0GoyTBCLFV3OT5m0HQMM+sWu69yxy6eZVNM1nrzKGe21LINALS/SNyZnw/QFaZ
 X+O1MGpsqLJ0+ABf0yxSKa4HgmHVPtMs+bncYCF1RBTetlQJF1h93vHaLjdgCqiqRBuC
 dOHPZGBiDaGaO2mJrbaKVrRKXZMzOxM1Ln2yUbU6jX2wdZITMFsREsGMaGlqq/JM0PxI
 CuYvctM924suSg16dYQbPYUQriRwAfGMRJu2q0BnBBTyYIW76i8XiSATReWunfouJ8yR
 iHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790824665; x=1791429465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4c5FfX5EP1m/8GM0Bx9eKe2xi/9IKqhmT/IEJvJNlUo=;
 b=sgTFbT3w0otGrPpSwk3Kh0uh1U+43sAnjr0vTtT9DmY4LfddiDoYdf9K+RAbRPt4x0
 zE1NZReV07+si9fsuH8XAsBYAXkPnQZs/VlgDQxl+8foCxCg6jhml69gxb/qTgXkcdpY
 fS/y1SSL19CKkGaD2gi5+g50ifIfJS24v1RVeDtoGpG2dISsp2Pl2gqeMlYAcPCRQVRI
 q+zVTcl3Dyz+0Krr0dvTELAB8qF336uOKGeOJ+L7p3vCod2A2zx/ABytG/uh/uesFn20
 PDfCvTnUnV+tfvAXQBVhFUEIz1YI6KHaSNSseG5R9EF64FAynkcMp9waJAWqpXB9LBNv
 G7VQ==
X-Gm-Message-State: AFq9FYI2s9L1hbwInEa+TKexnEIrVMLv89jX60DjgmNJSUfnkmLiMFvr
 H7C/blIF2SlV3WLRzZKuop8Z0CegwvnfQhl4f+LLofPiysF7BgVVBKr6AvvjztbYe0vgogHCnWp
 It6okjfI=
X-Gm-Gg: AYBFou0NiK8l5ircQrdIU/YPNLXKxNeoKl7THupgYo8WxwbUcmIE7nGehO4c0Mt6sbR
 ojtEYilE5i9uuILcZfRhKLFQbjtREhMXwJAgqfwUlsqlcH7ETejaY43DPhkR1b6YtyaVdBvzEAO
 UKb7Gol9wLnWTzF6rqCsUSqKdZ9Z5sQunvwC3Da+6PlhGt4fNTRmy1ti4bBoqTGpvSbLfwaikmt
 jfJLtt1xdtrP6SKjn/sYH+cd4fpmS3wKsNbfh0OdNZxwwAh576jVldMldJ0uM9JiyQVz1v6HiRd
 m6fRFH6+v3dS/248tn/FzoeOYUBeobdq3pyb5AobreFtTpvTfJ/6dNbXn+5j1a6+rhxsJsVIf6i
 2W8uWPXOFo6Vb7nuL6fRkw62G8Md3ANsnhEbpy35tlmEiyn7SO31VTXL5kW2NONXzyYAyQk/Vxb
 iM+D6Iq9MuI58LxZWDU4+su0fazu5/9MpVYebV7QENxgOCdI9wBqd+Dt8YZXmIO5fBxXG3E6cZv
 8zpWRDH1cKUTJFqxDxo2Av/91rj6Tu4KbI2sRTOFt92SRbVhYAhLzTimQ==
X-Received: by 2002:a17:90b:5890:b0:39e:2f57:67c0 with SMTP id
 98e67ed59e1d1-3a4d05a57famr4289384a91.0.1790824665267; 
 Wed, 30 Sep 2026 20:17:45 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f43f833asm2255552a91.6.2026.09.30.20.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 20:17:44 -0700 (PDT)
From: 'Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2 3/4] hw/riscv/atlantis: Add machine property to select
 default uart
Date: Thu,  1 Oct 2026 13:17:19 +1000
Message-ID: <20261001031720.2334056-4-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
References: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x11.google.com
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The Atlantis SoC has 5 UARTs. This adds a machine property to set
which uart is on the first serial interface. This is the same pattern
that is used by aspeed. The rest of the uart's will be added in
sequential order starting at serial interface 1.

The default value is uart1 which means the Ascalon console will be on
serial interface 0 by default.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c         | 76 ++++++++++++++++++++++++++++++----
 include/hw/riscv/tt_atlantis.h |  1 +
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 2342edce93..9534ce0031 100644
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
@@ -680,6 +696,46 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
+    console = object_class_property_add(oc, "console", "uint32_t", tt_atlantis_get_console,
+                                  tt_atlantis_set_console, NULL, NULL);
+    object_class_property_set_description(oc, "console",
+            "Change the default UART index on -serial. Valid values are 0 \
+            through 4 (default: 1, the Ascalon console. 0 for the RCPU console");
+    /* Default to UART1, the Ascalon console */
+    object_property_set_default_uint(console, 1);
+}
+
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -693,6 +749,8 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
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


