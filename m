Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA776C55177
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqFPz-0002xl-VO; Sat, 01 Aug 2026 15:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPv-0002wG-04
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPs-0002JY-UL
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so2216201a91.0
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785612639; x=1786217439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7hRPu+C0KkUU0VjTSzktZR1AdUmxXdimI6NZhYDwu5o=;
 b=AtKg/KDJbJlmdzo3PJlI+BiBUVWZxVHsK2lRDLbHT8Kq/nKOBrUFtYSKqdcTmDJAe0
 CZMftYXg6rKZ4OC20FxeG4f79RY9tKpXjJt3bCzClU0bUhFIQf8hUt5OdgShBjvmre8u
 3QSNNew5YcXeBSHl7nQS2/D3RaCEQeki5tQ441bJAcTNKogfyZ40n0Y23kIgAo9JeHW1
 C7Yw5RkzeheGlHWbNrId0NXIZBXFazZKJxSc2oqeayIra8BKYXYPtyUQjmwiF8BaFmBA
 xx5aJOu9fah2Dj4jUnO52Q/2ndcc/ZxJWmAXmtt7xhZzg33BtcJPPWucmQR7o+gv9GkB
 KS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785612639; x=1786217439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7hRPu+C0KkUU0VjTSzktZR1AdUmxXdimI6NZhYDwu5o=;
 b=gOinajmZSVoXyPJHteHRmvHGcKdwy9mUumHhAi7bhej8AcePiJWPKXprTRSt2k1rLE
 R1pJ6tv2lHVZbg+FIIdg2kOT/bj6imXkGdWgVEKzp6iHOucGcBwPUl2YljGcZ6oflIlk
 QPPCF+vY2fOu7FZBf6WMnQE49c2Sn0UOiWF4Xj21Ejwf6rI9dQ6gedLNoRIcrMHh6uq9
 MVK1DvF4yTzyTEa9bxmyszT8qL/RJKKSTgmShHCJhItkCkfHLkoADV+rPk80Z4l5AR14
 L3FQk9N4S06MTtbhkcQ4PxVc37Lh7nKucxb9/Dr9TQwoxiwgob5nUtxRfEF3PcGAj1mC
 NS6w==
X-Gm-Message-State: AOJu0Yz3wkOZgbukbrz8o5fNycaUptoyUB5/vD0zFR7xBhNVz2zPHIvh
 Y2CDbhMqtIlVsaK5CG40kwX0zTwc0eOGZ9CO9oaR3Wl38R5IytBy+dLw6w0LlyihIXARjg==
X-Gm-Gg: AR+sD137KacSL5rAWq94CHWZtuCIHuMQ10t31y4IRFxxfxXY34fE9UoJHs7FLCPUgVS
 oObk/6HDZXt0XgYx32Q2ZmuDPH7kykD5A6B4NI3wQ96lO2PRVRQhnNBLMdXmZOvcyKXBOE/5u3z
 L+2dGfYG8vC+g4f59q4jU4HX0WTGOjYGOCkou8bgoVBsJMfJUz0gzZYe1bVFCCoITGPJQySpud2
 oFP/FOuPgY4FQ+UPD0YNhP/ECTzwr4hJmtgfj6d5GIspR/Ox4XApe7loCvCLlize5DZWEGM6zXy
 LtyFCjBIpG6q6g+lawM/Qpwy7m7l6slzDWqdZ2ZPnxFfnRA0UhXN+omHZYhHDOQF+NffNIQnbGY
 DPN2SFmehI9NO/4Pm+7UznO092PB/kJeQ79DNDQPpytK9WQP9MUxpRUrV+kWbNzmouIBDJdkDAL
 8F06nlacWxOn0oSaXBUms9ZcYOUtrYUOAVRgb2ElJALkwPeTJidNTIGYj2Ab1F5/vl9RroMefzG
 uXLMJIUVw==
X-Received: by 2002:a17:90b:4d85:b0:387:d5bd:6231 with SMTP id
 98e67ed59e1d1-38fbcaf9ea4mr2920106a91.20.1785612639466; 
 Sat, 01 Aug 2026 12:30:39 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2bac654sm2148766a91.10.2026.08.01.12.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 12:30:39 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v2 5/5] hw/riscv/k230: Attach a standard SPI NOR flash
Date: Sun,  2 Aug 2026 03:28:48 +0800
Message-ID: <20260801192848.30606-6-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x102d.google.com
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

Add the optional spi-flash machine property and attach the selected
M25P80-compatible flash device to logical spi0 chip select 0.

Use the supplied MTD backend when present and retain the erased-flash
default otherwise. Document the machine option and add qtests for Standard
1-1-1 JEDEC identification and fixed-address reads.

Standard 1-1-1 transfers were also exercised manually through the K230
SDK U-Boot and Linux SPI paths against the attached flash.

The enhanced SPI and IDMA boot paths are outside the scope of this series.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst     |  1 +
 hw/riscv/Kconfig               |  1 +
 hw/riscv/k230.c                | 63 ++++++++++++++++++++++++++++++++++
 include/hw/riscv/k230.h        |  2 ++
 tests/qtest/k230-dw-ssi-test.c | 55 +++++++++++++++++++++++++++++
 5 files changed, 122 insertions(+)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 7a49cac95b..620ef263de 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -21,6 +21,7 @@ The ``k230`` machine supports the following devices:
 * 2 K230 Watchdog Timer
 * 5 UART
 * 3 K230 SSI controllers for SPI only
+* Optional SPI NOR flash on spi0 CS0
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 60a260691c..9d59465ad6 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -163,3 +163,4 @@ config K230
     select UNIMP
     select K230_WDT
     select DW_SSI
+    select SSI_M25P80
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index d856864839..5dd49a6752 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -33,6 +33,7 @@
 #include "hw/intc/sifive_plic.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
+#include "hw/ssi/ssi.h"
 
 /* Align K230_SDK k230_canmv_defconfig */
 #define K230_DIRECT_OPENSBI_ADDR 0x8000000
@@ -543,6 +544,49 @@ static void k230_firmware_boot(K230MachineState *s, MachineState *machine)
                               memmap[K230_DEV_BOOTROM].size, 0, 0);
 }
 
+static char *k230_machine_get_spi_flash(Object *obj, Error **errp)
+{
+    K230MachineState *s = RISCV_K230_MACHINE(obj);
+
+    return g_strdup(s->spi_flash_model);
+}
+
+static void k230_machine_set_spi_flash(Object *obj, const char *value,
+                                       Error **errp)
+{
+    K230MachineState *s = RISCV_K230_MACHINE(obj);
+
+    g_free(s->spi_flash_model);
+    s->spi_flash_model = g_strdup(value);
+}
+
+static void k230_connect_spi_flash(DwSsiState *ssi, unsigned int cs,
+                                   const char *flash_type, DriveInfo *dinfo)
+{
+    ObjectClass *flash_class;
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash_class = module_object_class_by_name(flash_type);
+    if (!flash_class || object_class_is_abstract(flash_class) ||
+        !object_class_dynamic_cast(flash_class, TYPE_M25P80)) {
+        error_report("'%s' is either abstract or not a subtype of m25p80",
+                     flash_type);
+        exit(EXIT_FAILURE);
+    }
+
+    flash = qdev_new(flash_type);
+
+    if (dinfo) {
+        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+
+    qdev_realize_and_unref(flash, BUS(ssi->spi), &error_fatal);
+
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(ssi), "cs", cs, flash_cs);
+}
+
 static void k230_machine_done(Notifier *notifier, void *data)
 {
     K230MachineState *s = container_of(notifier, K230MachineState,
@@ -574,6 +618,12 @@ static void k230_machine_init(MachineState *machine)
                             TYPE_RISCV_K230_SOC);
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
+    if (s->spi_flash_model) {
+        k230_connect_spi_flash(&s->soc.dw_ssi[2], 0,
+                               s->spi_flash_model,
+                               drive_get(IF_MTD, 0, 0));
+    }
+
     /* Data Memory */
     memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
                                 machine->ram);
@@ -586,6 +636,13 @@ static void k230_machine_instance_init(Object *obj)
 {
 }
 
+static void k230_machine_instance_finalize(Object *obj)
+{
+    K230MachineState *s = RISCV_K230_MACHINE(obj);
+
+    g_clear_pointer(&s->spi_flash_model, g_free);
+}
+
 static void k230_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -596,6 +653,11 @@ static void k230_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "riscv.K230.ram"; /* DDR */
     mc->default_ram_size = memmap[K230_DEV_DDRC].size;
 
+    object_class_property_add_str(oc, "spi-flash",
+                                  k230_machine_get_spi_flash,
+                                  k230_machine_set_spi_flash);
+    object_class_property_set_description(
+        oc, "spi-flash", "Attach an M25P80-compatible flash to spi0 CS0");
 }
 
 static const TypeInfo k230_machine_typeinfo = {
@@ -603,6 +665,7 @@ static const TypeInfo k230_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
+    .instance_finalize = k230_machine_instance_finalize,
     .instance_size = sizeof(K230MachineState),
     .interfaces = riscv64_machine_interfaces,
 };
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 275b6b62c3..80fb4c0e69 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -52,6 +52,8 @@ typedef struct K230MachineState {
     /*< public >*/
     K230SoCState soc;
     Notifier machine_done;
+
+    char *spi_flash_model;
 } K230MachineState;
 
 enum {
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index 7252302c0e..f381be14b5 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -474,6 +474,59 @@ static void test_icr_total_clear(void)
     qtest_quit(qts);
 }
 
+static void test_flash_jedec_id(void)
+{
+    QTestState *qts = qtest_init("-machine k230,spi-flash=m25p80");
+    uint32_t id;
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_enable_cs(qts, K230_SPI0_BASE, BIT(0));
+
+    /* JEDEC RDID (0x9f): m25p80 reports 0x20 0x20 0x14. */
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x9f);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    id = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(id & 0xff, ==, 0x20);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    id = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(id & 0xff, ==, 0x20);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    id = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(id & 0xff, ==, 0x14);
+
+    qtest_quit(qts);
+}
+
+static void test_flash_fixed_read(void)
+{
+    QTestState *qts = qtest_init("-machine k230,spi-flash=m25p80");
+    uint32_t byte;
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_TR, 8, 0);
+    k230_ssi_enable_cs(qts, K230_SPI0_BASE, BIT(0));
+
+    /* Standard 1-1-1 READ (0x03) at address 0x000000. */
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x03);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    (void)k230_ssi_read_frame(qts, K230_SPI0_BASE);
+
+    /* Without a backend the flash is erased and reads back 0xff. */
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    byte = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(byte & 0xff, ==, 0xff);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x00);
+    byte = k230_ssi_read_frame(qts, K230_SPI0_BASE);
+    g_assert_cmphex(byte & 0xff, ==, 0xff);
+
+    qtest_quit(qts);
+}
+
 static void test_unsupported_registers(void)
 {
     QTestState *qts = k230_ssi_start();
@@ -510,5 +563,7 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dw-ssi/icr-total-clear", test_icr_total_clear);
     qtest_add_func("/k230-dw-ssi/unsupported-registers",
                    test_unsupported_registers);
+    qtest_add_func("/k230-dw-ssi/flash-jedec-id", test_flash_jedec_id);
+    qtest_add_func("/k230-dw-ssi/flash-fixed-read", test_flash_fixed_read);
     return g_test_run();
 }
-- 
2.43.0


