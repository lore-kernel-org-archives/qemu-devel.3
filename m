Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38FAC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WTp-0007zO-Ky; Mon, 07 Sep 2026 06:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3WTn-0007yW-LJ; Mon, 07 Sep 2026 06:21:35 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3WTk-00025K-EW; Mon, 07 Sep 2026 06:21:35 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdjls638XzBqWv;
 Mon,  7 Sep 2026 12:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788776489;
 bh=oIW/gYq+b+6DHHgxAI1IguyZKIjL7ohsZG1rrnecv2E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=InpzH3sVcy1IBRKH7LIXXRa9Ys441TUf/yvdoHtAHpPJQsmgHsu4KCeHvqPUIdesj
 plZ9C60EeftMOUwmjScHhB1EA/PqzCfrYGk9VeD6i1dvkRLAX1H8ChvjGm3qM41IyN
 ZpTFzlJ2jLG2Jm3vOW5jkcW0Q/UIxflpQEhLlE7xHyv+najR+xik55CPM++/FoUQAr
 kCe+Cpe2yQanCv/ynvHG64ptBlLndPV+Dvkht/n3Kjx/HSLx4XArTP5fGyt74pojeJ
 Bs0cc86U4HC7Of7+n8ugI/Zv0UPAVHgzcnAub44loSBjZ7s4zCel8OBUidu3LXx8FG
 vmU6HQqbPQWOg==
Received: from localhost.localdomain (unknown [134.206.232.123])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdjls4wtxz7wpK;
 Mon,  7 Sep 2026 12:21:29 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH v3 32/36] hw/arm: add RP2040 synthetic boot ROM service tables
Date: Mon,  7 Sep 2026 12:21:24 +0200
Message-ID: <20260907102128.55676-2-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907102128.55676-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907102128.55676-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                               | 290 +++++++++++++++++-
 include/hw/arm/rp2040.h                       |   3 +
 tests/tcg/arm/system/meson.build              |   5 +
 tests/tcg/arm/system/rp2040-bootrom-helpers.S | 235 ++++++++++++++
 .../tcg/arm/system/rp2040-bootrom-helpers.ref |   5 +
 5 files changed, 534 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-helpers.S
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-helpers.ref

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 1b632be0b6..a3ad360462 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -44,6 +44,24 @@
 
 #define RP2040_PROC1          1
 
+#define RP2040_BOOTROM_FUNC_TABLE_PTR_OFFSET 0x14
+#define RP2040_BOOTROM_DATA_TABLE_PTR_OFFSET 0x16
+#define RP2040_BOOTROM_TABLE_LOOKUP_PTR_OFFSET 0x18
+#define RP2040_BOOTROM_LOOKUP_OFFSET 0x0100
+#define RP2040_BOOTROM_STUBS_OFFSET 0x0120
+#define RP2040_BOOTROM_FUNC_TABLE_OFFSET 0x0300
+#define RP2040_BOOTROM_DATA_TABLE_OFFSET 0x0340
+#define RP2040_BOOTROM_FLOAT_NYI_STUB_OFFSET 0x0360
+#define RP2040_BOOTROM_DOUBLE_NYI_STUB_OFFSET 0x0380
+#define RP2040_BOOTROM_FLOAT_TABLE_OFFSET 0x03c0
+#define RP2040_BOOTROM_DOUBLE_TABLE_OFFSET 0x0460
+#define RP2040_BOOTROM_FUNC_TABLE_ENTRY_SIZE 4
+#define RP2040_BOOTROM_DATA_TABLE_ENTRY_SIZE 4
+#define RP2040_BOOTROM_NYI_CODE_LITERAL_OFFSET 20
+#define RP2040_BOOTROM_ROM_VERSION_OFFSET 0x13
+#define RP2040_BOOTROM_SYNTHETIC_ROM_VERSION 2
+#define RP2040_BOOTROM_FLOAT_TABLE_WORDS 32
+
 /*
  * Temporary boot ROM used until a faithful RP2040 boot ROM is requested.  It
  * uses SIO_CPUID to split core behavior: core 0 copies the 256-byte XIP
@@ -166,6 +184,222 @@ static const struct {
     { "rp2040.pio1",     0x50300000, 0x10000 },
 };
 
+typedef struct RP2040BootromFunction {
+    uint16_t code;
+    const char *name;
+    const uint8_t *impl;
+    size_t impl_size;
+} RP2040BootromFunction;
+
+typedef struct RP2040BootromData {
+    uint16_t code;
+    uint16_t offset;
+} RP2040BootromData;
+
+#define RP2040_ROM_TABLE_CODE(c1, c2) ((uint16_t)(c1) | ((uint16_t)(c2) << 8))
+
+static const uint8_t rp2040_bootrom_clz32[] = {
+    0x00, 0x21, 0x00, 0x28, 0x01, 0xd1, 0x20, 0x20,
+    0x70, 0x47, 0x00, 0x28, 0x02, 0xd4, 0x40, 0x00,
+    0x01, 0x31, 0xfa, 0xe7, 0x08, 0x46, 0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_ctz32[] = {
+    0x00, 0x21, 0x00, 0x28, 0x01, 0xd1, 0x20, 0x20,
+    0x70, 0x47, 0x01, 0x22, 0x10, 0x42, 0x02, 0xd1,
+    0x40, 0x08, 0x01, 0x31, 0xf9, 0xe7, 0x08, 0x46,
+    0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_popcount32[] = {
+    0x00, 0x21, 0x00, 0x28, 0x04, 0xd0, 0x01, 0x22,
+    0x02, 0x40, 0x89, 0x18, 0x40, 0x08, 0xf8, 0xe7,
+    0x08, 0x46, 0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_reverse32[] = {
+    0x00, 0x21, 0x20, 0x22, 0x49, 0x00, 0x01, 0x23,
+    0x03, 0x40, 0x19, 0x43, 0x40, 0x08, 0x01, 0x3a,
+    0xf8, 0xd1, 0x08, 0x46, 0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_memcpy[] = {
+    0x10, 0xb4, 0x03, 0x46, 0x00, 0x2a, 0x05, 0xd0,
+    0x0c, 0x78, 0x04, 0x70, 0x01, 0x31, 0x01, 0x30,
+    0x01, 0x3a, 0xf7, 0xe7, 0x18, 0x46, 0x10, 0xbc,
+    0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_memset[] = {
+    0x03, 0x46, 0x00, 0x2a, 0x03, 0xd0, 0x01, 0x70,
+    0x01, 0x30, 0x01, 0x3a, 0xf9, 0xe7, 0x18, 0x46,
+    0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_memcpy44[] = {
+    0x10, 0xb4, 0x03, 0x46, 0x00, 0x2a, 0x05, 0xd0,
+    0x0c, 0x68, 0x04, 0x60, 0x04, 0x31, 0x04, 0x30,
+    0x04, 0x3a, 0xf7, 0xe7, 0x18, 0x46, 0x10, 0xbc,
+    0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_memset4[] = {
+    0x10, 0xb4, 0x03, 0x46, 0xc9, 0xb2, 0x0c, 0x46,
+    0x24, 0x02, 0x21, 0x43, 0x0c, 0x46, 0x24, 0x04,
+    0x21, 0x43, 0x00, 0x2a, 0x03, 0xd0, 0x01, 0x60,
+    0x04, 0x30, 0x04, 0x3a, 0xf9, 0xe7, 0x18, 0x46,
+    0x10, 0xbc, 0x70, 0x47,
+};
+
+#define RP2040_BOOTROM_IMPL(_code, _name, _impl) \
+    { _code, _name, _impl, sizeof(_impl) }
+#define RP2040_BOOTROM_NYI(_code, _name) \
+    { _code, _name, NULL, 0 }
+
+static const RP2040BootromFunction rp2040_bootrom_functions[] = {
+    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('C', 'X'),
+                       "flash_enter_cmd_xip"),
+    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('E', 'X'), "flash_exit_xip"),
+    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('F', 'C'),
+                       "flash_flush_cache"),
+    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('I', 'F'),
+                       "connect_internal_flash"),
+    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('R', 'E'),
+                       "flash_range_erase"),
+    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('R', 'P'),
+                       "flash_range_program"),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('C', '4'), "memcpy44",
+                        rp2040_bootrom_memcpy44),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('L', '3'), "clz32",
+                        rp2040_bootrom_clz32),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('M', 'C'), "memcpy",
+                        rp2040_bootrom_memcpy),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('M', 'S'), "memset",
+                        rp2040_bootrom_memset),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('P', '3'), "popcount32",
+                        rp2040_bootrom_popcount32),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('R', '3'), "reverse32",
+                        rp2040_bootrom_reverse32),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('S', '4'), "memset4",
+                        rp2040_bootrom_memset4),
+    RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('T', '3'), "ctz32",
+                        rp2040_bootrom_ctz32),
+    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('U', 'B'), "reset_usb_boot"),
+};
+
+static const RP2040BootromData rp2040_bootrom_data[] = {
+    { RP2040_ROM_TABLE_CODE('S', 'F'), RP2040_BOOTROM_FLOAT_TABLE_OFFSET + 2 },
+    { RP2040_ROM_TABLE_CODE('S', 'D'), RP2040_BOOTROM_DOUBLE_TABLE_OFFSET + 2 },
+};
+
+static const uint8_t rp2040_bootrom_lookup[] = {
+    0x02, 0x88, 0x00, 0x2a, 0x05, 0xd0, 0x91, 0x42,
+    0x01, 0xd0, 0x04, 0x30, 0xf8, 0xe7, 0x40, 0x88,
+    0x70, 0x47, 0x5f, 0x22, 0x12, 0x06, 0xff, 0x23,
+    0x1b, 0x04, 0x1a, 0x43, 0x11, 0x60, 0x00, 0xbe,
+    0x00, 0x20, 0x70, 0x47,
+};
+
+static const uint8_t rp2040_bootrom_nyi_stub[] = {
+    0x04, 0x49, 0x5f, 0x20, 0x00, 0x06, 0xff, 0x22,
+    0x12, 0x04, 0x10, 0x43, 0x01, 0x60, 0x00, 0xbe,
+    0xfe, 0xe7, 0xc0, 0x46, 0x00, 0x00, 0x00, 0x00,
+};
+
+static void rp2040_store_hword(uint8_t *rom, uint32_t offset, uint16_t value)
+{
+    rom[offset] = value;
+    rom[offset + 1] = value >> 8;
+}
+
+static void rp2040_store_word(uint8_t *rom, uint32_t offset, uint32_t value)
+{
+    rom[offset] = value;
+    rom[offset + 1] = value >> 8;
+    rom[offset + 2] = value >> 16;
+    rom[offset + 3] = value >> 24;
+}
+
+static void rp2040_install_synthetic_bootrom(void)
+{
+    g_autofree uint8_t *rom = g_malloc0(RP2040_ROM_SIZE);
+    uint32_t func_base = RP2040_BOOTROM_STUBS_OFFSET;
+    uint32_t func_table = RP2040_BOOTROM_FUNC_TABLE_OFFSET;
+    uint32_t data_table = RP2040_BOOTROM_DATA_TABLE_OFFSET;
+    uint32_t float_nyi = RP2040_BOOTROM_FLOAT_NYI_STUB_OFFSET | 1;
+    uint32_t double_nyi = RP2040_BOOTROM_DOUBLE_NYI_STUB_OFFSET | 1;
+    int i;
+
+    memcpy(rom, rp2040_bootrom, sizeof(rp2040_bootrom));
+    rom[RP2040_BOOTROM_ROM_VERSION_OFFSET] =
+        RP2040_BOOTROM_SYNTHETIC_ROM_VERSION;
+    memcpy(rom + RP2040_BOOTROM_LOOKUP_OFFSET, rp2040_bootrom_lookup,
+           sizeof(rp2040_bootrom_lookup));
+    rp2040_store_hword(rom, RP2040_BOOTROM_FUNC_TABLE_PTR_OFFSET,
+                       RP2040_BOOTROM_FUNC_TABLE_OFFSET);
+    rp2040_store_hword(rom, RP2040_BOOTROM_DATA_TABLE_PTR_OFFSET,
+                       RP2040_BOOTROM_DATA_TABLE_OFFSET);
+    rp2040_store_hword(rom, RP2040_BOOTROM_TABLE_LOOKUP_PTR_OFFSET,
+                       RP2040_BOOTROM_LOOKUP_OFFSET | 1);
+
+    for (i = 0; i < ARRAY_SIZE(rp2040_bootrom_functions); i++) {
+        const RP2040BootromFunction *func = &rp2040_bootrom_functions[i];
+        uint32_t entry = func_base | 1;
+
+        if (func->impl) {
+            memcpy(rom + func_base, func->impl, func->impl_size);
+            func_base += ROUND_UP(func->impl_size, 4);
+        } else {
+            memcpy(rom + func_base, rp2040_bootrom_nyi_stub,
+                   sizeof(rp2040_bootrom_nyi_stub));
+            rp2040_store_word(rom,
+                              func_base +
+                              RP2040_BOOTROM_NYI_CODE_LITERAL_OFFSET,
+                              func->code);
+            func_base += ROUND_UP(sizeof(rp2040_bootrom_nyi_stub), 4);
+        }
+        rp2040_store_hword(rom, func_table +
+                           i * RP2040_BOOTROM_FUNC_TABLE_ENTRY_SIZE,
+                           func->code);
+        rp2040_store_hword(rom, func_table +
+                           i * RP2040_BOOTROM_FUNC_TABLE_ENTRY_SIZE + 2,
+                           entry);
+    }
+
+    memcpy(rom + RP2040_BOOTROM_FLOAT_NYI_STUB_OFFSET, rp2040_bootrom_nyi_stub,
+           sizeof(rp2040_bootrom_nyi_stub));
+    rp2040_store_word(rom, RP2040_BOOTROM_FLOAT_NYI_STUB_OFFSET +
+                      RP2040_BOOTROM_NYI_CODE_LITERAL_OFFSET,
+                      RP2040_ROM_TABLE_CODE('S', 'F'));
+    memcpy(rom + RP2040_BOOTROM_DOUBLE_NYI_STUB_OFFSET, rp2040_bootrom_nyi_stub,
+           sizeof(rp2040_bootrom_nyi_stub));
+    rp2040_store_word(rom, RP2040_BOOTROM_DOUBLE_NYI_STUB_OFFSET +
+                      RP2040_BOOTROM_NYI_CODE_LITERAL_OFFSET,
+                      RP2040_ROM_TABLE_CODE('S', 'D'));
+    rom[RP2040_BOOTROM_FLOAT_TABLE_OFFSET] = RP2040_BOOTROM_FLOAT_TABLE_WORDS;
+    rom[RP2040_BOOTROM_DOUBLE_TABLE_OFFSET] = RP2040_BOOTROM_FLOAT_TABLE_WORDS;
+    for (i = 0; i < RP2040_BOOTROM_FLOAT_TABLE_WORDS; i++) {
+        rp2040_store_word(rom, RP2040_BOOTROM_FLOAT_TABLE_OFFSET + 2 +
+                          i * sizeof(uint32_t), float_nyi);
+        rp2040_store_word(rom, RP2040_BOOTROM_DOUBLE_TABLE_OFFSET + 2 +
+                          i * sizeof(uint32_t), double_nyi);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(rp2040_bootrom_data); i++) {
+        const RP2040BootromData *data = &rp2040_bootrom_data[i];
+
+        rp2040_store_hword(rom, data_table +
+                           i * RP2040_BOOTROM_DATA_TABLE_ENTRY_SIZE,
+                           data->code);
+        rp2040_store_hword(rom, data_table +
+                           i * RP2040_BOOTROM_DATA_TABLE_ENTRY_SIZE + 2,
+                           data->offset);
+    }
+
+    rom_add_blob_fixed("rp2040.bootrom", rom, RP2040_ROM_SIZE,
+                       RP2040_ROM_BASE);
+}
+
 static uint64_t rp2040_usbctrl_regs_read(void *opaque, hwaddr addr,
                                          unsigned size)
 {
@@ -194,8 +428,8 @@ static uint64_t rp2040_usbctrl_regs_read(void *opaque, hwaddr addr,
         } else {
             value = 0;
             qemu_log_mask(LOG_UNIMP,
-                      "%s: unimplemented read at offset 0x%"
-                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
+                          "%s: unimplemented read at offset 0x%"
+                          HWADDR_PRIx "\n", __func__, addr & 0xfff);
         }
         break;
     }
@@ -233,6 +467,48 @@ static const MemoryRegionOps rp2040_usbctrl_regs_ops = {
     },
 };
 
+static const char *rp2040_bootrom_function_name(uint16_t code)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(rp2040_bootrom_functions); i++) {
+        if (rp2040_bootrom_functions[i].code == code) {
+            return rp2040_bootrom_functions[i].name;
+        }
+    }
+    return NULL;
+}
+
+static void rp2040_synthetic_rom_dbg_write(void *opaque, hwaddr addr,
+                                           uint64_t value, unsigned size)
+{
+    uint16_t code = value;
+    const char *name = rp2040_bootrom_function_name(code);
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented boot ROM function '%c%c' (%s)\n",
+                  __func__, code & 0xff, (code >> 8) & 0xff,
+                  name ? name : "unknown lookup code");
+}
+
+static uint64_t rp2040_synthetic_rom_dbg_read(void *opaque, hwaddr addr,
+                                              unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: read from write-only synthetic register\n",
+                  __func__);
+    return 0;
+}
+
+static const MemoryRegionOps rp2040_synthetic_rom_dbg_ops = {
+    .read = rp2040_synthetic_rom_dbg_read,
+    .write = rp2040_synthetic_rom_dbg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void rp2040_update_nmi(RP2040State *s)
 {
     unsigned core;
@@ -498,6 +774,13 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
     memory_region_add_subregion(s->board_memory, RP2040_USBCTRL_REGS_BASE,
                                 &s->usbctrl_regs);
 
+    memory_region_init_io(&s->synthetic_rom_dbg, OBJECT(s),
+                          &rp2040_synthetic_rom_dbg_ops, s,
+                          "rp2040.synthetic-rom-dbg",
+                          RP2040_SYNTHETIC_ROM_DBG_SIZE);
+    memory_region_add_subregion(s->board_memory,
+                                 RP2040_SYNTHETIC_ROM_DBG_BASE,
+                                 &s->synthetic_rom_dbg);
     return true;
 }
 
@@ -506,8 +789,7 @@ static bool rp2040_load_bootrom(RP2040State *s, Error **errp)
     g_autofree char *filename = NULL;
 
     if (!s->bootrom_file) {
-        rom_add_blob_fixed("rp2040.bootrom", rp2040_bootrom,
-                           sizeof(rp2040_bootrom), RP2040_ROM_BASE);
+        rp2040_install_synthetic_bootrom();
         return true;
     }
 
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 0daa7d6ba1..17235827c4 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -52,6 +52,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
 #define RP2040_USBCTRL_DPRAM_SIZE (4 * KiB)
 #define RP2040_USBCTRL_REGS_BASE  0x50110000
 #define RP2040_USBCTRL_REGS_SIZE  0x4000
+#define RP2040_SYNTHETIC_ROM_DBG_BASE 0x5fff0000
+#define RP2040_SYNTHETIC_ROM_DBG_SIZE 0x1000
 
 #define RP2040_NUM_CORES      2
 #define RP2040_NUM_IRQS       32
@@ -90,6 +92,7 @@ struct RP2040State {
     MemoryRegion sram[6];
     MemoryRegion usbctrl_dpram;
     MemoryRegion usbctrl_regs;
+    MemoryRegion synthetic_rom_dbg;
     uint32_t usbctrl_reg[0x100 / sizeof(uint32_t)];
     char *bootrom_file;
 
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index a12aed74fa..9e1024cf11 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -157,6 +157,11 @@ tests += {
     'qemu_args': rp2040_uart1_qemu_args,
     'expected_output': 'rp2040-dma-uart1.ref',
   },
+  'rp2040-bootrom-helpers.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-bootrom-helpers.ref',
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/rp2040-bootrom-helpers.S b/tests/tcg/arm/system/rp2040-bootrom-helpers.S
new file mode 100644
index 0000000000..e48230a875
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-bootrom-helpers.S
@@ -0,0 +1,235 @@
+/*
+ * Raspberry Pi Pico boot ROM integer and memory helper test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END               0x20042000
+#define UART0_DR               0x40034000
+#define ROM_FUNC_TABLE_PTR     0x00000014
+#define ROM_TABLE_LOOKUP_PTR   0x00000018
+#define ROM_FUNC_POPCOUNT32    0x3350
+#define ROM_FUNC_CLZ32         0x334c
+#define ROM_FUNC_CTZ32         0x3354
+#define ROM_FUNC_REVERSE32     0x3352
+#define ROM_FUNC_MEMSET        0x534d
+#define ROM_FUNC_MEMCPY        0x434d
+#define ROM_FUNC_MEMSET4       0x3453
+#define ROM_FUNC_MEMCPY44      0x3443
+#define TEST_BUFFER            0x20000000
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.macro lookup code
+    ldr r0, =\code
+    bl rom_func_lookup
+    cmp r0, 0
+    bne 0f
+    b fail_lookup
+0:
+    mov r4, r0
+.endm
+
+.macro fail_if_ne reg, expected, target
+    ldr r2, =\expected
+    cmp \reg, r2
+    beq 0f
+    b \target
+0:
+.endm
+
+.section .vectors, "a", %progbits
+.global vector_table
+vector_table:
+    .word SRAM_END
+    .word reset_handler + 1
+    .word default_handler + 1
+    .word default_handler + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    ldr r0, =start_message
+    bl puts
+
+    lookup ROM_FUNC_POPCOUNT32
+    ldr r0, =0xf0f00f0f
+    blx r4
+    fail_if_ne r0, 16, fail_bits
+
+    lookup ROM_FUNC_CLZ32
+    ldr r0, =0x00f00000
+    blx r4
+    fail_if_ne r0, 8, fail_bits
+
+    lookup ROM_FUNC_CTZ32
+    ldr r0, =0x00008000
+    blx r4
+    fail_if_ne r0, 15, fail_bits
+
+    lookup ROM_FUNC_REVERSE32
+    ldr r0, =0x80000001
+    blx r4
+    fail_if_ne r0, 0x80000001, fail_bits
+
+    ldr r0, =bits_ok_message
+    bl puts
+
+    lookup ROM_FUNC_MEMSET
+    ldr r0, =TEST_BUFFER
+    movs r1, 0x5a
+    movs r2, 4
+    blx r4
+    ldr r5, =TEST_BUFFER
+    ldrb r0, [r5]
+    fail_if_ne r0, 0x5a, fail_byte_memory
+    ldrb r0, [r5, 3]
+    fail_if_ne r0, 0x5a, fail_byte_memory
+
+    ldr r5, =TEST_BUFFER + 0x20
+    ldr r0, =0x11223344
+    str r0, [r5]
+    lookup ROM_FUNC_MEMCPY
+    ldr r0, =TEST_BUFFER + 0x10
+    ldr r1, =TEST_BUFFER + 0x20
+    movs r2, 4
+    blx r4
+    ldr r5, =TEST_BUFFER + 0x10
+    ldr r0, [r5]
+    fail_if_ne r0, 0x11223344, fail_byte_memory
+
+    ldr r0, =byte_memory_ok_message
+    bl puts
+
+    lookup ROM_FUNC_MEMSET4
+    ldr r5, =TEST_BUFFER + 0x30
+    ldr r0, =0xdeadbeef
+    str r0, [r5, 8]
+    ldr r0, =TEST_BUFFER + 0x30
+    movs r1, 0x5a
+    movs r2, 8
+    blx r4
+    ldr r5, =TEST_BUFFER + 0x30
+    ldr r0, [r5]
+    fail_if_ne r0, 0x5a5a5a5a, fail_word_memory
+    ldr r0, [r5, 4]
+    fail_if_ne r0, 0x5a5a5a5a, fail_word_memory
+    ldr r0, [r5, 8]
+    fail_if_ne r0, 0xdeadbeef, fail_word_memory
+
+    ldr r5, =TEST_BUFFER + 0x40
+    ldr r0, =0x55667788
+    str r0, [r5]
+    ldr r0, =0x99aabbcc
+    str r0, [r5, 4]
+    ldr r5, =TEST_BUFFER + 0x50
+    ldr r0, =0xdeadbeef
+    str r0, [r5, 8]
+    lookup ROM_FUNC_MEMCPY44
+    ldr r0, =TEST_BUFFER + 0x50
+    ldr r1, =TEST_BUFFER + 0x40
+    movs r2, 8
+    blx r4
+    ldr r5, =TEST_BUFFER + 0x50
+    ldr r0, [r5]
+    fail_if_ne r0, 0x55667788, fail_word_memory
+    ldr r0, [r5, 4]
+    fail_if_ne r0, 0x99aabbcc, fail_word_memory
+    ldr r0, [r5, 8]
+    fail_if_ne r0, 0xdeadbeef, fail_word_memory
+
+    ldr r0, =word_memory_ok_message
+    bl puts
+    ldr r0, =ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
+
+fail_lookup:
+    ldr r0, =fail_lookup_message
+    b test_failed
+
+fail_bits:
+    ldr r0, =fail_bits_message
+    b test_failed
+
+fail_byte_memory:
+    ldr r0, =fail_byte_memory_message
+    b test_failed
+
+fail_word_memory:
+    ldr r0, =fail_word_memory_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+2:
+    b 2b
+
+.thumb_func
+rom_func_lookup:
+    push {r4, lr}
+    mov r1, r0
+    ldr r0, =ROM_FUNC_TABLE_PTR
+    ldrh r0, [r0]
+    ldr r4, =ROM_TABLE_LOOKUP_PTR
+    ldrh r4, [r4]
+    blx r4
+    pop {r4, pc}
+
+.thumb_func
+default_handler:
+    ldr r0, =fail_exception_message
+    b test_failed
+
+.thumb_func
+puts:
+    ldr r2, =UART0_DR
+
+3:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 4f
+    str r1, [r2]
+    adds r0, 1
+    b 3b
+
+4:
+    bx lr
+
+.section .rodata, "a", %progbits
+start_message:
+    .asciz "PICO TCG BOOTROM HELPERS START\n"
+bits_ok_message:
+    .asciz "PICO TCG BOOTROM HELPERS BITS OK\n"
+byte_memory_ok_message:
+    .asciz "PICO TCG BOOTROM HELPERS BYTE MEMORY OK\n"
+word_memory_ok_message:
+    .asciz "PICO TCG BOOTROM HELPERS WORD MEMORY OK\n"
+ok_message:
+    .asciz "PICO TCG BOOTROM HELPERS OK\n"
+fail_lookup_message:
+    .asciz "PICO TCG BOOTROM HELPERS FAIL: LOOKUP\n"
+fail_bits_message:
+    .asciz "PICO TCG BOOTROM HELPERS FAIL: BITS\n"
+fail_byte_memory_message:
+    .asciz "PICO TCG BOOTROM HELPERS FAIL: BYTE MEMORY\n"
+fail_word_memory_message:
+    .asciz "PICO TCG BOOTROM HELPERS FAIL: WORD MEMORY\n"
+fail_exception_message:
+    .asciz "PICO TCG BOOTROM HELPERS FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-bootrom-helpers.ref b/tests/tcg/arm/system/rp2040-bootrom-helpers.ref
new file mode 100644
index 0000000000..b1b4346bf4
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-bootrom-helpers.ref
@@ -0,0 +1,5 @@
+PICO TCG BOOTROM HELPERS START
+PICO TCG BOOTROM HELPERS BITS OK
+PICO TCG BOOTROM HELPERS BYTE MEMORY OK
+PICO TCG BOOTROM HELPERS WORD MEMORY OK
+PICO TCG BOOTROM HELPERS OK
-- 
2.55.0


