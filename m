Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7A4C61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Yrj-0002pl-7s; Sun, 30 Aug 2026 02:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yrh-0002nO-RP; Sun, 30 Aug 2026 02:18:01 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yrd-0005Ja-At; Sun, 30 Aug 2026 02:18:01 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXhjq3DfbzBqYr;
 Sun, 30 Aug 2026 08:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070639;
 bh=9/cVQ+OzEfcAFmc0Zd/6Yh/NC+vg6zGNe5AE5sJhFKo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PvpOmCVgbWL+APptr/9WDFNzW7Vbbt9wr+hmxkgtePvJr2EtO1WiloKnL5F6+wSqx
 0VM1YgElt4VMaLFL48qE/mT2+71hsyXZhT7GqHTzYu0+TgH8IPKgk92VOtzAYzhmPo
 1+AngIEETtvkaSHpoUB4hmSHX2oubwKJ+0AtVVzUOXeTUlL2+YYqkIwTjHNS4UVFKv
 QvJS0NyMyuozn64wBLu9HhWDyMc3FuhrB4BfLpeWbPhbtkFcTyV0Ql09HVtEiP4DGc
 xh9/R/yd8nCuFABFL5TqcBs7J49DuVZNQ3CA5FWVLMLW2Yve5ETCzQxIqOmqjSmLzP
 2uls0K5WtPU4w==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjq1hVQz7xSW;
 Sun, 30 Aug 2026 08:17:19 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 28/30] hw/arm: add RP2040 synthetic boot ROM
 accelerated helpers
Date: Sun, 30 Aug 2026 08:15:59 +0200
Message-ID: <20260830061601.52136-14-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Provide float and double boot ROM helpers through the synthetic QEMU helper aperture, and accelerate the boot ROM flash entry points by calling the existing XIP flash model directly.

These shortcuts are installed only when the built-in synthetic ROM is selected. They are not RP2040 hardware interfaces; an external mask ROM continues to exercise the modeled SSI/XIP path.

Add check-tcg coverage for floating-point tables and multicore flash lockout.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                               | 930 +++++++++++++++++-
 hw/arm/trace-events                           |   3 +
 include/hw/arm/rp2040.h                       |   5 +
 tests/tcg/arm/Makefile.softmmu-target         |  21 +
 tests/tcg/arm/system/rp2040-bootrom-float.S   | 206 ++++
 tests/tcg/arm/system/rp2040-bootrom-float.ref |   4 +
 tests/tcg/arm/system/rp2040-flash-lockout.S   | 387 ++++++++
 tests/tcg/arm/system/rp2040-flash-lockout.ref |   6 +
 8 files changed, 1520 insertions(+), 42 deletions(-)
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-float.S
 create mode 100644 tests/tcg/arm/system/rp2040-bootrom-float.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-lockout.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-lockout.ref

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 6c2f62038e..6c06570586 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -16,10 +16,15 @@
 #include "hw/core/irq.h"
 #include "hw/misc/rp2040_nyi.h"
 #include "hw/misc/unimp.h"
+#include "fpu/softfloat.h"
 #include "qemu/datadir.h"
+#include "qemu/log.h"
 #include "system/address-spaces.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-qom.h"
+#include "trace.h"
+
+#include <math.h>
 
 #define RP2040_UART0_BASE 0x40034000
 #define RP2040_UART0_IRQ  20
@@ -64,6 +69,70 @@
 #define RP2040_BOOTROM_ROM_VERSION_OFFSET 0x13
 #define RP2040_BOOTROM_SYNTHETIC_ROM_VERSION 2
 #define RP2040_BOOTROM_FLOAT_TABLE_WORDS 32
+#define RP2040_BOOTROM_HELPER_NOARG_CODE_LITERAL_OFFSET 8
+#define RP2040_BOOTROM_HELPER_ARGS4_CODE_LITERAL_OFFSET 24
+#define RP2040_BOOTROM_HELPER_ARGS3_CODE_LITERAL_OFFSET 20
+#define RP2040_BOOTROM_FP_STUB_CODE_LITERAL_OFFSET 32
+#define RP2040_BOOTROM_FLOAT_STUBS_OFFSET 0x0600
+#define RP2040_BOOTROM_DOUBLE_STUBS_OFFSET 0x0b00
+#define RP2040_BOOTROM_FP_STUB_SIZE 36
+
+#define RP2040_SYNTHETIC_ROM_DBG_CMD  0x00
+#define RP2040_SYNTHETIC_ROM_DBG_ARG0 0x04
+#define RP2040_SYNTHETIC_ROM_DBG_ARG1 0x08
+#define RP2040_SYNTHETIC_ROM_DBG_ARG2 0x0c
+#define RP2040_SYNTHETIC_ROM_DBG_ARG3 0x10
+#define RP2040_SYNTHETIC_ROM_DBG_RESULT0 0x14
+#define RP2040_SYNTHETIC_ROM_DBG_RESULT1 0x18
+#define RP2040_SYNTHETIC_ROM_DBG_RESULT2 0x1c
+#define RP2040_SYNTHETIC_ROM_DBG_RESULT3 0x20
+#define RP2040_SYNTHETIC_ROM_DBG_FLASH_COUNT0 0x40
+
+#define RP2040_SYNTHETIC_FP_CMD_MASK   0xffffff00
+#define RP2040_SYNTHETIC_FP_CMD_FLOAT  0x80000000
+#define RP2040_SYNTHETIC_FP_CMD_DOUBLE 0x80000100
+
+enum RP2040SyntheticFlashHelper {
+    RP2040_SYNTHETIC_FLASH_CONNECT_INTERNAL_FLASH,
+    RP2040_SYNTHETIC_FLASH_EXIT_XIP,
+    RP2040_SYNTHETIC_FLASH_FLUSH_CACHE,
+    RP2040_SYNTHETIC_FLASH_ENTER_CMD_XIP,
+    RP2040_SYNTHETIC_FLASH_RANGE_ERASE,
+    RP2040_SYNTHETIC_FLASH_RANGE_PROGRAM,
+};
+
+#define RP2040_SF_TABLE_FADD            0x00
+#define RP2040_SF_TABLE_FSUB            0x04
+#define RP2040_SF_TABLE_FMUL            0x08
+#define RP2040_SF_TABLE_FDIV            0x0c
+#define RP2040_SF_TABLE_FCMP_FAST       0x10
+#define RP2040_SF_TABLE_FCMP_FAST_FLAGS 0x14
+#define RP2040_SF_TABLE_FSQRT           0x18
+#define RP2040_SF_TABLE_FLOAT2INT       0x1c
+#define RP2040_SF_TABLE_FLOAT2FIX       0x20
+#define RP2040_SF_TABLE_FLOAT2UINT      0x24
+#define RP2040_SF_TABLE_FLOAT2UFIX      0x28
+#define RP2040_SF_TABLE_INT2FLOAT       0x2c
+#define RP2040_SF_TABLE_FIX2FLOAT       0x30
+#define RP2040_SF_TABLE_UINT2FLOAT      0x34
+#define RP2040_SF_TABLE_UFIX2FLOAT      0x38
+#define RP2040_SF_TABLE_FCOS            0x3c
+#define RP2040_SF_TABLE_FSIN            0x40
+#define RP2040_SF_TABLE_FTAN            0x44
+#define RP2040_SF_TABLE_V3_FSINCOS      0x48
+#define RP2040_SF_TABLE_FEXP            0x4c
+#define RP2040_SF_TABLE_FLN             0x50
+#define RP2040_SF_TABLE_FCMP_BASIC      0x54
+#define RP2040_SF_TABLE_FATAN2          0x58
+#define RP2040_SF_TABLE_INT642FLOAT     0x5c
+#define RP2040_SF_TABLE_FIX642FLOAT     0x60
+#define RP2040_SF_TABLE_UINT642FLOAT    0x64
+#define RP2040_SF_TABLE_UFIX642FLOAT    0x68
+#define RP2040_SF_TABLE_FLOAT2INT64     0x6c
+#define RP2040_SF_TABLE_FLOAT2FIX64     0x70
+#define RP2040_SF_TABLE_FLOAT2UINT64    0x74
+#define RP2040_SF_TABLE_FLOAT2UFIX64    0x78
+#define RP2040_SF_TABLE_FLOAT2DOUBLE    0x7c
 
 /*
  * Temporary boot ROM used until a faithful RP2040 boot ROM is requested.  It
@@ -192,6 +261,7 @@ typedef struct RP2040BootromFunction {
     const char *name;
     const uint8_t *impl;
     size_t impl_size;
+    uint32_t code_literal_offset;
 } RP2040BootromFunction;
 
 typedef struct RP2040BootromData {
@@ -254,23 +324,98 @@ static const uint8_t rp2040_bootrom_memset4[] = {
     0x10, 0xbc, 0x70, 0x47,
 };
 
+static const uint8_t rp2040_bootrom_flash_noarg[] = {
+    /*
+     * Synthetic-ROM-only acceleration.  These stubs call the QEMU helper
+     * aperture directly; they do not model RP2040 SSI transactions.
+     */
+    0x01, 0x49,             /* ldr r1, [pc, #4] ; function code */
+    0x02, 0x48,             /* ldr r0, [pc, #8] ; debug base */
+    0x01, 0x60,             /* str r1, [r0] */
+    0x70, 0x47,             /* bx lr */
+    0x00, 0x00, 0x00, 0x00, /* function code literal */
+    0x00, 0x00, 0xff, 0x5f, /* 0x5fff0000 */
+};
+
+static const uint8_t rp2040_bootrom_flash_args4[] = {
+    0x10, 0xb5,             /* push {r4, lr} */
+    0x04, 0x4c,             /* ldr r4, [pc, #16] ; debug base */
+    0x60, 0x60,             /* str r0, [r4, #4] */
+    0xa1, 0x60,             /* str r1, [r4, #8] */
+    0xe2, 0x60,             /* str r2, [r4, #12] */
+    0x23, 0x61,             /* str r3, [r4, #16] */
+    0x02, 0x48,             /* ldr r0, [pc, #8] ; function code */
+    0x20, 0x60,             /* str r0, [r4] */
+    0x10, 0xbd,             /* pop {r4, pc} */
+    0xc0, 0x46,             /* nop; align literal */
+    0x00, 0x00, 0xff, 0x5f, /* 0x5fff0000 */
+    0x00, 0x00, 0x00, 0x00, /* function code literal */
+};
+
+static const uint8_t rp2040_bootrom_flash_args3[] = {
+    0x10, 0xb5,             /* push {r4, lr} */
+    0x03, 0x4c,             /* ldr r4, [pc, #12] ; debug base */
+    0x60, 0x60,             /* str r0, [r4, #4] */
+    0xa1, 0x60,             /* str r1, [r4, #8] */
+    0xe2, 0x60,             /* str r2, [r4, #12] */
+    0x02, 0x48,             /* ldr r0, [pc, #8] ; function code */
+    0x20, 0x60,             /* str r0, [r4] */
+    0x10, 0xbd,             /* pop {r4, pc} */
+    0x00, 0x00, 0xff, 0x5f, /* 0x5fff0000 */
+    0x00, 0x00, 0x00, 0x00, /* function code literal */
+};
+
+static const uint8_t rp2040_bootrom_fp_stub[] = {
+    0x10, 0xb5,             /* push {r4, lr} */
+    0x06, 0x4c,             /* ldr r4, [pc, #24] ; debug base */
+    0x60, 0x60,             /* str r0, [r4, #4] */
+    0xa1, 0x60,             /* str r1, [r4, #8] */
+    0xe2, 0x60,             /* str r2, [r4, #12] */
+    0x23, 0x61,             /* str r3, [r4, #16] */
+    0x04, 0x48,             /* ldr r0, [pc, #16] ; command */
+    0x20, 0x60,             /* str r0, [r4] */
+    0x60, 0x69,             /* ldr r0, [r4, #20] */
+    0xa1, 0x69,             /* ldr r1, [r4, #24] */
+    0xe2, 0x69,             /* ldr r2, [r4, #28] */
+    0x23, 0x6a,             /* ldr r3, [r4, #32] */
+    0x10, 0xbd,             /* pop {r4, pc} */
+    0xc0, 0x46,             /* nop; align literal */
+    0x00, 0x00, 0xff, 0x5f, /* 0x5fff0000 */
+    0x00, 0x00, 0x00, 0x00, /* command literal */
+};
+
 #define RP2040_BOOTROM_IMPL(_code, _name, _impl) \
-    { _code, _name, _impl, sizeof(_impl) }
+    { _code, _name, _impl, sizeof(_impl), UINT32_MAX }
+#define RP2040_BOOTROM_IMPL_CODE(_code, _name, _impl, _offset) \
+    { _code, _name, _impl, sizeof(_impl), _offset }
 #define RP2040_BOOTROM_NYI(_code, _name) \
-    { _code, _name, NULL, 0 }
+    { _code, _name, NULL, 0, UINT32_MAX }
 
 static const RP2040BootromFunction rp2040_bootrom_functions[] = {
-    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('C', 'X'),
-                       "flash_enter_cmd_xip"),
-    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('E', 'X'), "flash_exit_xip"),
-    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('F', 'C'),
-                       "flash_flush_cache"),
-    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('I', 'F'),
-                       "connect_internal_flash"),
-    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('R', 'E'),
-                       "flash_range_erase"),
-    RP2040_BOOTROM_NYI(RP2040_ROM_TABLE_CODE('R', 'P'),
-                       "flash_range_program"),
+    RP2040_BOOTROM_IMPL_CODE(RP2040_ROM_TABLE_CODE('C', 'X'),
+                             "flash_enter_cmd_xip",
+                             rp2040_bootrom_flash_noarg,
+                             RP2040_BOOTROM_HELPER_NOARG_CODE_LITERAL_OFFSET),
+    RP2040_BOOTROM_IMPL_CODE(RP2040_ROM_TABLE_CODE('E', 'X'),
+                             "flash_exit_xip",
+                             rp2040_bootrom_flash_noarg,
+                             RP2040_BOOTROM_HELPER_NOARG_CODE_LITERAL_OFFSET),
+    RP2040_BOOTROM_IMPL_CODE(RP2040_ROM_TABLE_CODE('F', 'C'),
+                             "flash_flush_cache",
+                             rp2040_bootrom_flash_noarg,
+                             RP2040_BOOTROM_HELPER_NOARG_CODE_LITERAL_OFFSET),
+    RP2040_BOOTROM_IMPL_CODE(RP2040_ROM_TABLE_CODE('I', 'F'),
+                             "connect_internal_flash",
+                             rp2040_bootrom_flash_noarg,
+                             RP2040_BOOTROM_HELPER_NOARG_CODE_LITERAL_OFFSET),
+    RP2040_BOOTROM_IMPL_CODE(RP2040_ROM_TABLE_CODE('R', 'E'),
+                             "flash_range_erase",
+                             rp2040_bootrom_flash_args4,
+                             RP2040_BOOTROM_HELPER_ARGS4_CODE_LITERAL_OFFSET),
+    RP2040_BOOTROM_IMPL_CODE(RP2040_ROM_TABLE_CODE('R', 'P'),
+                             "flash_range_program",
+                             rp2040_bootrom_flash_args3,
+                             RP2040_BOOTROM_HELPER_ARGS3_CODE_LITERAL_OFFSET),
     RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('C', '4'), "memcpy44",
                         rp2040_bootrom_memcpy44),
     RP2040_BOOTROM_IMPL(RP2040_ROM_TABLE_CODE('L', '3'), "clz32",
@@ -296,17 +441,38 @@ static const RP2040BootromData rp2040_bootrom_data[] = {
 };
 
 static const uint8_t rp2040_bootrom_lookup[] = {
-    0x02, 0x88, 0x00, 0x2a, 0x05, 0xd0, 0x91, 0x42,
-    0x01, 0xd0, 0x04, 0x30, 0xf8, 0xe7, 0x40, 0x88,
-    0x70, 0x47, 0x5f, 0x22, 0x12, 0x06, 0xff, 0x23,
-    0x1b, 0x04, 0x1a, 0x43, 0x11, 0x60, 0x00, 0xbe,
-    0x00, 0x20, 0x70, 0x47,
+    0x02, 0x88,             /* ldrh r2, [r0] */
+    0x00, 0x2a,             /* cmp r2, #0 */
+    0x05, 0xd0,             /* beq not_found */
+    0x91, 0x42,             /* cmp r1, r2 */
+    0x01, 0xd0,             /* beq found */
+    0x04, 0x30,             /* adds r0, #4 */
+    0xf8, 0xe7,             /* b loop */
+    0x40, 0x88,             /* found: ldrh r0, [r0, #2] */
+    0x70, 0x47,             /* bx lr */
+    0x5f, 0x22,             /* not_found: movs r2, #0x5f */
+    0x12, 0x06,             /* lsls r2, r2, #24 */
+    0xff, 0x23,             /* movs r3, #0xff */
+    0x1b, 0x04,             /* lsls r3, r3, #16 */
+    0x1a, 0x43,             /* orrs r2, r3 ; 0x5fff0000 */
+    0x11, 0x60,             /* str r1, [r2] */
+    0x00, 0xbe,             /* bkpt #0 */
+    0x00, 0x20,             /* movs r0, #0 */
+    0x70, 0x47,             /* bx lr */
 };
 
 static const uint8_t rp2040_bootrom_nyi_stub[] = {
-    0x04, 0x49, 0x5f, 0x20, 0x00, 0x06, 0xff, 0x22,
-    0x12, 0x04, 0x10, 0x43, 0x01, 0x60, 0x00, 0xbe,
-    0xfe, 0xe7, 0xc0, 0x46, 0x00, 0x00, 0x00, 0x00,
+    0x04, 0x49,             /* ldr r1, [pc, #16] ; function code */
+    0x5f, 0x20,             /* movs r0, #0x5f */
+    0x00, 0x06,             /* lsls r0, r0, #24 */
+    0xff, 0x22,             /* movs r2, #0xff */
+    0x12, 0x04,             /* lsls r2, r2, #16 */
+    0x10, 0x43,             /* orrs r0, r2 ; 0x5fff0000 */
+    0x01, 0x60,             /* str r1, [r0] */
+    0x00, 0xbe,             /* bkpt #0 */
+    0xfe, 0xe7,             /* b . */
+    0xc0, 0x46,             /* nop; align literal */
+    0x00, 0x00, 0x00, 0x00, /* function code literal */
 };
 
 static void rp2040_store_hword(uint8_t *rom, uint32_t offset, uint16_t value)
@@ -323,6 +489,56 @@ static void rp2040_store_word(uint8_t *rom, uint32_t offset, uint32_t value)
     rom[offset + 3] = value >> 24;
 }
 
+static bool rp2040_bootrom_fp_supported(uint32_t offset)
+{
+    switch (offset) {
+    case RP2040_SF_TABLE_FADD:
+    case RP2040_SF_TABLE_FSUB:
+    case RP2040_SF_TABLE_FMUL:
+    case RP2040_SF_TABLE_FDIV:
+    case RP2040_SF_TABLE_FCMP_FAST:
+    case RP2040_SF_TABLE_FCMP_FAST_FLAGS:
+    case RP2040_SF_TABLE_FSQRT:
+    case RP2040_SF_TABLE_FLOAT2INT:
+    case RP2040_SF_TABLE_FLOAT2FIX:
+    case RP2040_SF_TABLE_FLOAT2UINT:
+    case RP2040_SF_TABLE_FLOAT2UFIX:
+    case RP2040_SF_TABLE_INT2FLOAT:
+    case RP2040_SF_TABLE_FIX2FLOAT:
+    case RP2040_SF_TABLE_UINT2FLOAT:
+    case RP2040_SF_TABLE_UFIX2FLOAT:
+    case RP2040_SF_TABLE_FCOS:
+    case RP2040_SF_TABLE_FSIN:
+    case RP2040_SF_TABLE_FTAN:
+    case RP2040_SF_TABLE_V3_FSINCOS:
+    case RP2040_SF_TABLE_FEXP:
+    case RP2040_SF_TABLE_FLN:
+    case RP2040_SF_TABLE_FCMP_BASIC:
+    case RP2040_SF_TABLE_FATAN2:
+    case RP2040_SF_TABLE_INT642FLOAT:
+    case RP2040_SF_TABLE_FIX642FLOAT:
+    case RP2040_SF_TABLE_UINT642FLOAT:
+    case RP2040_SF_TABLE_UFIX642FLOAT:
+    case RP2040_SF_TABLE_FLOAT2INT64:
+    case RP2040_SF_TABLE_FLOAT2FIX64:
+    case RP2040_SF_TABLE_FLOAT2UINT64:
+    case RP2040_SF_TABLE_FLOAT2UFIX64:
+    case RP2040_SF_TABLE_FLOAT2DOUBLE:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static void rp2040_install_bootrom_fp_stub(uint8_t *rom, uint32_t offset,
+                                          uint32_t command)
+{
+    memcpy(rom + offset, rp2040_bootrom_fp_stub,
+           sizeof(rp2040_bootrom_fp_stub));
+    rp2040_store_word(rom, offset + RP2040_BOOTROM_FP_STUB_CODE_LITERAL_OFFSET,
+                      command);
+}
+
 static void rp2040_install_synthetic_bootrom(void)
 {
     g_autofree uint8_t *rom = g_malloc0(RP2040_ROM_SIZE);
@@ -338,6 +554,7 @@ static void rp2040_install_synthetic_bootrom(void)
         RP2040_BOOTROM_SYNTHETIC_ROM_VERSION;
     memcpy(rom + RP2040_BOOTROM_LOOKUP_OFFSET, rp2040_bootrom_lookup,
            sizeof(rp2040_bootrom_lookup));
+
     rp2040_store_hword(rom, RP2040_BOOTROM_FUNC_TABLE_PTR_OFFSET,
                        RP2040_BOOTROM_FUNC_TABLE_OFFSET);
     rp2040_store_hword(rom, RP2040_BOOTROM_DATA_TABLE_PTR_OFFSET,
@@ -351,6 +568,10 @@ static void rp2040_install_synthetic_bootrom(void)
 
         if (func->impl) {
             memcpy(rom + func_base, func->impl, func->impl_size);
+            if (func->code_literal_offset != UINT32_MAX) {
+                rp2040_store_word(rom, func_base + func->code_literal_offset,
+                                  func->code);
+            }
             func_base += ROUND_UP(func->impl_size, 4);
         } else {
             memcpy(rom + func_base, rp2040_bootrom_nyi_stub,
@@ -361,6 +582,7 @@ static void rp2040_install_synthetic_bootrom(void)
                               func->code);
             func_base += ROUND_UP(sizeof(rp2040_bootrom_nyi_stub), 4);
         }
+
         rp2040_store_hword(rom, func_table +
                            i * RP2040_BOOTROM_FUNC_TABLE_ENTRY_SIZE,
                            func->code);
@@ -379,13 +601,34 @@ static void rp2040_install_synthetic_bootrom(void)
     rp2040_store_word(rom, RP2040_BOOTROM_DOUBLE_NYI_STUB_OFFSET +
                       RP2040_BOOTROM_NYI_CODE_LITERAL_OFFSET,
                       RP2040_ROM_TABLE_CODE('S', 'D'));
+
     rom[RP2040_BOOTROM_FLOAT_TABLE_OFFSET] = RP2040_BOOTROM_FLOAT_TABLE_WORDS;
     rom[RP2040_BOOTROM_DOUBLE_TABLE_OFFSET] = RP2040_BOOTROM_FLOAT_TABLE_WORDS;
     for (i = 0; i < RP2040_BOOTROM_FLOAT_TABLE_WORDS; i++) {
-        rp2040_store_word(rom, RP2040_BOOTROM_FLOAT_TABLE_OFFSET + 2 +
-                          i * sizeof(uint32_t), float_nyi);
-        rp2040_store_word(rom, RP2040_BOOTROM_DOUBLE_TABLE_OFFSET + 2 +
-                          i * sizeof(uint32_t), double_nyi);
+        uint32_t table_offset = i * sizeof(uint32_t);
+
+        if (rp2040_bootrom_fp_supported(table_offset)) {
+            uint32_t float_stub = RP2040_BOOTROM_FLOAT_STUBS_OFFSET +
+                                  i * RP2040_BOOTROM_FP_STUB_SIZE;
+            uint32_t double_stub = RP2040_BOOTROM_DOUBLE_STUBS_OFFSET +
+                                   i * RP2040_BOOTROM_FP_STUB_SIZE;
+
+            rp2040_install_bootrom_fp_stub(rom, float_stub,
+                                           RP2040_SYNTHETIC_FP_CMD_FLOAT |
+                                           table_offset);
+            rp2040_install_bootrom_fp_stub(rom, double_stub,
+                                           RP2040_SYNTHETIC_FP_CMD_DOUBLE |
+                                           table_offset);
+            rp2040_store_word(rom, RP2040_BOOTROM_FLOAT_TABLE_OFFSET + 2 +
+                              table_offset, float_stub | 1);
+            rp2040_store_word(rom, RP2040_BOOTROM_DOUBLE_TABLE_OFFSET + 2 +
+                              table_offset, double_stub | 1);
+        } else {
+            rp2040_store_word(rom, RP2040_BOOTROM_FLOAT_TABLE_OFFSET + 2 +
+                              table_offset, float_nyi);
+            rp2040_store_word(rom, RP2040_BOOTROM_DOUBLE_TABLE_OFFSET + 2 +
+                              table_offset, double_nyi);
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(rp2040_bootrom_data); i++) {
@@ -403,6 +646,21 @@ static void rp2040_install_synthetic_bootrom(void)
                        RP2040_ROM_BASE);
 }
 
+static uint32_t rp2040_apply_atomic_alias(uint32_t old, uint32_t value,
+                                          hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
 static MemTxResult rp2040_powered_off_read(void *opaque, hwaddr addr,
                                            uint64_t *data, unsigned size,
                                            MemTxAttrs attrs)
@@ -428,20 +686,6 @@ static const MemoryRegionOps rp2040_powered_off_ops = {
     },
 };
 
-static uint32_t rp2040_apply_atomic_alias(uint32_t old, uint32_t value,
-                                          hwaddr alias)
-{
-    switch (alias) {
-    case ATOMIC_XOR:
-        return old ^ value;
-    case ATOMIC_SET:
-        return old | value;
-    case ATOMIC_CLR:
-        return old & ~value;
-    default:
-        return value;
-    }
-}
 
 static void rp2040_update_mempowerdown(RP2040State *s)
 {
@@ -538,30 +782,632 @@ static const char *rp2040_bootrom_function_name(uint16_t code)
             return rp2040_bootrom_functions[i].name;
         }
     }
+
     return NULL;
 }
 
+static void rp2040_init_float_status(float_status *status)
+{
+    *status = (float_status) { 0 };
+    set_float_rounding_mode(float_round_nearest_even, status);
+}
+
+static void rp2040_synthetic_fp_nyi(bool is_double, uint32_t offset)
+{
+    g_autofree char *detail = g_strdup_printf("%s table offset 0x%02" PRIx32,
+                                              is_double ? "double" : "float",
+                                              offset);
+
+    rp2040_log_nyi("bootrom", "floating-point helper", detail);
+}
+
+static float rp2040_u32_to_host_float(uint32_t value)
+{
+    union {
+        uint32_t u;
+        float f;
+    } v = { .u = value };
+
+    return v.f;
+}
+
+static uint32_t rp2040_host_float_to_u32(float value)
+{
+    union {
+        float f;
+        uint32_t u;
+    } v = { .f = value };
+
+    return v.u;
+}
+
+static double rp2040_u64_to_host_double(uint64_t value)
+{
+    union {
+        uint64_t u;
+        double d;
+    } v = { .u = value };
+
+    return v.d;
+}
+
+static uint64_t rp2040_host_double_to_u64(double value)
+{
+    union {
+        double d;
+        uint64_t u;
+    } v = { .d = value };
+
+    return v.u;
+}
+
+static uint32_t rp2040_synthetic_fp_compare(double a, double b)
+{
+    if (isnan(a) || isnan(b)) {
+        return 1;
+    }
+    if (a < b) {
+        return -1;
+    }
+    if (a > b) {
+        return 1;
+    }
+    return 0;
+}
+
+static int32_t rp2040_synthetic_double_to_i32(double value)
+{
+    if (isnan(value)) {
+        return 0;
+    }
+    if (value >= INT32_MAX) {
+        return INT32_MAX;
+    }
+    if (value <= INT32_MIN) {
+        return INT32_MIN;
+    }
+    return value;
+}
+
+static uint32_t rp2040_synthetic_double_to_u32(double value)
+{
+    if (isnan(value) || value <= 0) {
+        return 0;
+    }
+    if (value >= UINT32_MAX) {
+        return UINT32_MAX;
+    }
+    return value;
+}
+
+static int64_t rp2040_synthetic_double_to_i64(double value)
+{
+    if (isnan(value)) {
+        return 0;
+    }
+    if (value >= 0x1p63) {
+        return INT64_MAX;
+    }
+    if (value <= -0x1p63) {
+        return INT64_MIN;
+    }
+    return value;
+}
+
+static uint64_t rp2040_synthetic_double_to_u64(double value)
+{
+    if (isnan(value) || value <= 0) {
+        return 0;
+    }
+    if (value >= 0x1p64) {
+        return UINT64_MAX;
+    }
+    return value;
+}
+
+static void rp2040_synthetic_float_op(RP2040State *s, uint32_t offset)
+{
+    float_status status;
+    float32 a = make_float32(s->synthetic_rom_dbg_arg[0]);
+    float32 b = make_float32(s->synthetic_rom_dbg_arg[1]);
+    float host_a = rp2040_u32_to_host_float(s->synthetic_rom_dbg_arg[0]);
+    float host_b = rp2040_u32_to_host_float(s->synthetic_rom_dbg_arg[1]);
+    float32 r32;
+    float64 r64;
+    uint64_t r;
+    double scaled;
+
+    rp2040_init_float_status(&status);
+    memset(s->synthetic_rom_dbg_result, 0, sizeof(s->synthetic_rom_dbg_result));
+    s->synthetic_rom_dbg_result[1] = 0;
+
+    switch (offset) {
+    case RP2040_SF_TABLE_FADD:
+        s->synthetic_rom_dbg_result[0] =
+            float32_val(float32_add(a, b, &status));
+        break;
+    case RP2040_SF_TABLE_FSUB:
+        s->synthetic_rom_dbg_result[0] =
+            float32_val(float32_sub(a, b, &status));
+        break;
+    case RP2040_SF_TABLE_FMUL:
+        s->synthetic_rom_dbg_result[0] =
+            float32_val(float32_mul(a, b, &status));
+        break;
+    case RP2040_SF_TABLE_FDIV:
+        s->synthetic_rom_dbg_result[0] =
+            float32_val(float32_div(a, b, &status));
+        break;
+    case RP2040_SF_TABLE_FCMP_FAST:
+    case RP2040_SF_TABLE_FCMP_FAST_FLAGS:
+    case RP2040_SF_TABLE_FCMP_BASIC:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_synthetic_fp_compare(host_a, host_b);
+        break;
+    case RP2040_SF_TABLE_FSQRT:
+        s->synthetic_rom_dbg_result[0] =
+            float32_val(float32_sqrt(a, &status));
+        break;
+    case RP2040_SF_TABLE_FLOAT2INT:
+        s->synthetic_rom_dbg_result[0] =
+            float32_to_int32_round_to_zero(a, &status);
+        break;
+    case RP2040_SF_TABLE_FLOAT2FIX:
+        scaled = ldexp((double)host_a, s->synthetic_rom_dbg_arg[1] & 0xff);
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_synthetic_double_to_i32(scaled);
+        break;
+    case RP2040_SF_TABLE_FLOAT2UINT:
+        s->synthetic_rom_dbg_result[0] =
+            float32_to_uint32_round_to_zero(a, &status);
+        break;
+    case RP2040_SF_TABLE_FLOAT2UFIX:
+        scaled = ldexp((double)host_a, s->synthetic_rom_dbg_arg[1] & 0xff);
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_synthetic_double_to_u32(scaled);
+        break;
+    case RP2040_SF_TABLE_INT2FLOAT:
+        s->synthetic_rom_dbg_result[0] =
+            float32_val(int32_to_float32(s->synthetic_rom_dbg_arg[0],
+                                         &status));
+        break;
+    case RP2040_SF_TABLE_FIX2FLOAT:
+        r32 = float64_to_float32(make_float64(rp2040_host_double_to_u64(
+                                  ldexp((double)(int32_t)
+                                        s->synthetic_rom_dbg_arg[0],
+                                        -(int)(s->synthetic_rom_dbg_arg[1] &
+                                               0xff)))),
+                                 &status);
+        s->synthetic_rom_dbg_result[0] = float32_val(r32);
+        break;
+    case RP2040_SF_TABLE_UINT2FLOAT:
+        s->synthetic_rom_dbg_result[0] =
+            float32_val(uint32_to_float32(s->synthetic_rom_dbg_arg[0],
+                                          &status));
+        break;
+    case RP2040_SF_TABLE_UFIX2FLOAT:
+        r32 = float64_to_float32(make_float64(rp2040_host_double_to_u64(
+                                  ldexp((double)
+                                        s->synthetic_rom_dbg_arg[0],
+                                        -(int)(s->synthetic_rom_dbg_arg[1] &
+                                               0xff)))),
+                                 &status);
+        s->synthetic_rom_dbg_result[0] = float32_val(r32);
+        break;
+    case RP2040_SF_TABLE_FCOS:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_host_float_to_u32(cosf(host_a));
+        break;
+    case RP2040_SF_TABLE_FSIN:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_host_float_to_u32(sinf(host_a));
+        s->synthetic_rom_dbg_result[1] =
+            rp2040_host_float_to_u32(cosf(host_a));
+        break;
+    case RP2040_SF_TABLE_FTAN:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_host_float_to_u32(tanf(host_a));
+        break;
+    case RP2040_SF_TABLE_V3_FSINCOS:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_host_float_to_u32(sinf(host_a));
+        s->synthetic_rom_dbg_result[1] =
+            rp2040_host_float_to_u32(cosf(host_a));
+        break;
+    case RP2040_SF_TABLE_FEXP:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_host_float_to_u32(expf(host_a));
+        break;
+    case RP2040_SF_TABLE_FLN:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_host_float_to_u32(logf(host_a));
+        break;
+    case RP2040_SF_TABLE_FATAN2:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_host_float_to_u32(atan2f(host_a, host_b));
+        break;
+    case RP2040_SF_TABLE_INT642FLOAT:
+        r = deposit64(s->synthetic_rom_dbg_arg[0], 32, 32,
+                      s->synthetic_rom_dbg_arg[1]);
+        r32 = int64_to_float32((int64_t)r, &status);
+        s->synthetic_rom_dbg_result[0] = float32_val(r32);
+        break;
+    case RP2040_SF_TABLE_FIX642FLOAT:
+        r = deposit64(s->synthetic_rom_dbg_arg[0], 32, 32,
+                      s->synthetic_rom_dbg_arg[1]);
+        r32 = float64_to_float32(make_float64(rp2040_host_double_to_u64(
+                                  ldexp((double)(int64_t)r,
+                                        -(int)(s->synthetic_rom_dbg_arg[2] &
+                                               0xff)))),
+                                 &status);
+        s->synthetic_rom_dbg_result[0] = float32_val(r32);
+        break;
+    case RP2040_SF_TABLE_UINT642FLOAT:
+        r = deposit64(s->synthetic_rom_dbg_arg[0], 32, 32,
+                      s->synthetic_rom_dbg_arg[1]);
+        r32 = uint64_to_float32(r, &status);
+        s->synthetic_rom_dbg_result[0] = float32_val(r32);
+        break;
+    case RP2040_SF_TABLE_UFIX642FLOAT:
+        r = deposit64(s->synthetic_rom_dbg_arg[0], 32, 32,
+                      s->synthetic_rom_dbg_arg[1]);
+        r32 = float64_to_float32(make_float64(rp2040_host_double_to_u64(
+                                  ldexp((double)r,
+                                        -(int)(s->synthetic_rom_dbg_arg[2] &
+                                               0xff)))),
+                                 &status);
+        s->synthetic_rom_dbg_result[0] = float32_val(r32);
+        break;
+    case RP2040_SF_TABLE_FLOAT2INT64:
+        r = float32_to_int64_round_to_zero(a, &status);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2FIX64:
+        scaled = ldexp((double)host_a, s->synthetic_rom_dbg_arg[1] & 0xff);
+        r = rp2040_synthetic_double_to_i64(scaled);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2UINT64:
+        r = float32_to_uint64_round_to_zero(a, &status);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2UFIX64:
+        scaled = ldexp((double)host_a, s->synthetic_rom_dbg_arg[1] & 0xff);
+        r = rp2040_synthetic_double_to_u64(scaled);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2DOUBLE:
+        r64 = float32_to_float64(a, &status);
+        r = float64_val(r64);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    default:
+        s->synthetic_rom_dbg_result[0] = 0;
+        rp2040_synthetic_fp_nyi(false, offset);
+        break;
+    }
+}
+
+static void rp2040_synthetic_double_op(RP2040State *s, uint32_t offset)
+{
+    float_status status;
+    uint64_t av = deposit64(s->synthetic_rom_dbg_arg[0], 32, 32,
+                            s->synthetic_rom_dbg_arg[1]);
+    uint64_t bv = deposit64(s->synthetic_rom_dbg_arg[2], 32, 32,
+                            s->synthetic_rom_dbg_arg[3]);
+    float64 a = make_float64(av);
+    float64 b = make_float64(bv);
+    double host_a = rp2040_u64_to_host_double(av);
+    double host_b = rp2040_u64_to_host_double(bv);
+    float64 r64;
+    float32 r32;
+    uint64_t r;
+    double scaled;
+
+    rp2040_init_float_status(&status);
+    memset(s->synthetic_rom_dbg_result, 0, sizeof(s->synthetic_rom_dbg_result));
+
+    switch (offset) {
+    case RP2040_SF_TABLE_FADD:
+        r64 = float64_add(a, b, &status);
+        goto return_double;
+    case RP2040_SF_TABLE_FSUB:
+        r64 = float64_sub(a, b, &status);
+        goto return_double;
+    case RP2040_SF_TABLE_FMUL:
+        r64 = float64_mul(a, b, &status);
+        goto return_double;
+    case RP2040_SF_TABLE_FDIV:
+        r64 = float64_div(a, b, &status);
+        goto return_double;
+    case RP2040_SF_TABLE_FCMP_FAST:
+    case RP2040_SF_TABLE_FCMP_FAST_FLAGS:
+    case RP2040_SF_TABLE_FCMP_BASIC:
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_synthetic_fp_compare(host_a, host_b);
+        s->synthetic_rom_dbg_result[1] = 0;
+        break;
+    case RP2040_SF_TABLE_FSQRT:
+        r64 = float64_sqrt(a, &status);
+        goto return_double;
+    case RP2040_SF_TABLE_FLOAT2INT:
+        s->synthetic_rom_dbg_result[0] =
+            float64_to_int32_round_to_zero(a, &status);
+        s->synthetic_rom_dbg_result[1] = 0;
+        break;
+    case RP2040_SF_TABLE_FLOAT2FIX:
+        scaled = ldexp(host_a, s->synthetic_rom_dbg_arg[2] & 0xff);
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_synthetic_double_to_i32(scaled);
+        s->synthetic_rom_dbg_result[1] = 0;
+        break;
+    case RP2040_SF_TABLE_FLOAT2UINT:
+        s->synthetic_rom_dbg_result[0] =
+            float64_to_uint32_round_to_zero(a, &status);
+        s->synthetic_rom_dbg_result[1] = 0;
+        break;
+    case RP2040_SF_TABLE_FLOAT2UFIX:
+        scaled = ldexp(host_a, s->synthetic_rom_dbg_arg[2] & 0xff);
+        s->synthetic_rom_dbg_result[0] =
+            rp2040_synthetic_double_to_u32(scaled);
+        s->synthetic_rom_dbg_result[1] = 0;
+        break;
+    case RP2040_SF_TABLE_INT2FLOAT:
+        r64 = int32_to_float64(s->synthetic_rom_dbg_arg[0], &status);
+        goto return_double;
+    case RP2040_SF_TABLE_FIX2FLOAT:
+        r64 = make_float64(rp2040_host_double_to_u64(
+              ldexp((double)(int32_t)s->synthetic_rom_dbg_arg[0],
+                    -(int)(s->synthetic_rom_dbg_arg[1] & 0xff))));
+        goto return_double;
+    case RP2040_SF_TABLE_UINT2FLOAT:
+        r64 = uint32_to_float64(s->synthetic_rom_dbg_arg[0], &status);
+        goto return_double;
+    case RP2040_SF_TABLE_UFIX2FLOAT:
+        r64 = make_float64(rp2040_host_double_to_u64(
+              ldexp((double)s->synthetic_rom_dbg_arg[0],
+                    -(int)(s->synthetic_rom_dbg_arg[1] & 0xff))));
+        goto return_double;
+    case RP2040_SF_TABLE_FCOS:
+        r64 = make_float64(rp2040_host_double_to_u64(cos(host_a)));
+        goto return_double;
+    case RP2040_SF_TABLE_FSIN:
+        r64 = make_float64(rp2040_host_double_to_u64(sin(host_a)));
+        goto return_double;
+    case RP2040_SF_TABLE_FTAN:
+        r64 = make_float64(rp2040_host_double_to_u64(tan(host_a)));
+        goto return_double;
+    case RP2040_SF_TABLE_V3_FSINCOS:
+        r = rp2040_host_double_to_u64(sin(host_a));
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        r = rp2040_host_double_to_u64(cos(host_a));
+        s->synthetic_rom_dbg_result[2] = r;
+        s->synthetic_rom_dbg_result[3] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FEXP:
+        r64 = make_float64(rp2040_host_double_to_u64(exp(host_a)));
+        goto return_double;
+    case RP2040_SF_TABLE_FLN:
+        r64 = make_float64(rp2040_host_double_to_u64(log(host_a)));
+        goto return_double;
+    case RP2040_SF_TABLE_FATAN2:
+        r64 = make_float64(rp2040_host_double_to_u64(atan2(host_a, host_b)));
+        goto return_double;
+    case RP2040_SF_TABLE_INT642FLOAT:
+        r64 = int64_to_float64((int64_t)av, &status);
+        goto return_double;
+    case RP2040_SF_TABLE_FIX642FLOAT:
+        r64 = make_float64(rp2040_host_double_to_u64(
+              ldexp((double)(int64_t)av,
+                    -(int)(s->synthetic_rom_dbg_arg[2] & 0xff))));
+        goto return_double;
+    case RP2040_SF_TABLE_UINT642FLOAT:
+        r64 = uint64_to_float64(av, &status);
+        goto return_double;
+    case RP2040_SF_TABLE_UFIX642FLOAT:
+        r64 = make_float64(rp2040_host_double_to_u64(
+              ldexp((double)av,
+                    -(int)(s->synthetic_rom_dbg_arg[2] & 0xff))));
+        goto return_double;
+    case RP2040_SF_TABLE_FLOAT2INT64:
+        r = float64_to_int64_round_to_zero(a, &status);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2FIX64:
+        scaled = ldexp(host_a, s->synthetic_rom_dbg_arg[2] & 0xff);
+        r = rp2040_synthetic_double_to_i64(scaled);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2UINT64:
+        r = float64_to_uint64_round_to_zero(a, &status);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2UFIX64:
+        scaled = ldexp(host_a, s->synthetic_rom_dbg_arg[2] & 0xff);
+        r = rp2040_synthetic_double_to_u64(scaled);
+        s->synthetic_rom_dbg_result[0] = r;
+        s->synthetic_rom_dbg_result[1] = r >> 32;
+        break;
+    case RP2040_SF_TABLE_FLOAT2DOUBLE:
+        r32 = float64_to_float32(a, &status);
+        s->synthetic_rom_dbg_result[0] = float32_val(r32);
+        s->synthetic_rom_dbg_result[1] = 0;
+        break;
+    default:
+        s->synthetic_rom_dbg_result[0] = 0;
+        s->synthetic_rom_dbg_result[1] = 0;
+        rp2040_synthetic_fp_nyi(true, offset);
+        break;
+    }
+    return;
+
+return_double:
+    r = float64_val(r64);
+    s->synthetic_rom_dbg_result[0] = r;
+    s->synthetic_rom_dbg_result[1] = r >> 32;
+}
+
+static bool rp2040_synthetic_fp_op(RP2040State *s, uint32_t command)
+{
+    uint32_t offset = command & 0xff;
+
+    switch (command & RP2040_SYNTHETIC_FP_CMD_MASK) {
+    case RP2040_SYNTHETIC_FP_CMD_FLOAT:
+        rp2040_synthetic_float_op(s, offset);
+        return true;
+    case RP2040_SYNTHETIC_FP_CMD_DOUBLE:
+        rp2040_synthetic_double_op(s, offset);
+        return true;
+    default:
+        return false;
+    }
+}
+
+static void rp2040_synthetic_flash_helper_hit(RP2040State *s,
+                                              unsigned int helper,
+                                              const char *name)
+{
+    uint32_t count;
+
+    g_assert(helper < RP2040_SYNTHETIC_ROM_FLASH_HELPER_COUNT);
+
+    count = ++s->synthetic_rom_flash_helper_count[helper];
+    trace_rp2040_synthetic_flash_helper(name, count);
+}
+
 static void rp2040_synthetic_rom_dbg_write(void *opaque, hwaddr addr,
                                            uint64_t value, unsigned size)
 {
+    RP2040State *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint32_t command = value;
     uint16_t code = value;
     const char *name = rp2040_bootrom_function_name(code);
     char feature[64];
     char detail[64];
+    Error *local_err = NULL;
+
+    switch (offset) {
+    case RP2040_SYNTHETIC_ROM_DBG_ARG0:
+    case RP2040_SYNTHETIC_ROM_DBG_ARG1:
+    case RP2040_SYNTHETIC_ROM_DBG_ARG2:
+    case RP2040_SYNTHETIC_ROM_DBG_ARG3:
+        s->synthetic_rom_dbg_arg[(offset - RP2040_SYNTHETIC_ROM_DBG_ARG0) /
+                                 sizeof(uint32_t)] = value;
+        return;
+    case RP2040_SYNTHETIC_ROM_DBG_CMD:
+        break;
+    default:
+        rp2040_log_nyi("bootrom", "synthetic diagnostic register write",
+                       "unknown register");
+        return;
+    }
+
+    if (rp2040_synthetic_fp_op(s, command)) {
+        return;
+    }
+
+    switch (code) {
+    case RP2040_ROM_TABLE_CODE('C', 'X'):
+        rp2040_synthetic_flash_helper_hit(
+            s, RP2040_SYNTHETIC_FLASH_ENTER_CMD_XIP,
+            "flash_enter_cmd_xip");
+        rp2040_log_nyi("bootrom", "flash_enter_cmd_xip",
+                       "synthetic helper does not reconfigure SSI hardware");
+        return;
+    case RP2040_ROM_TABLE_CODE('E', 'X'):
+        rp2040_synthetic_flash_helper_hit(
+            s, RP2040_SYNTHETIC_FLASH_EXIT_XIP, "flash_exit_xip");
+        rp2040_log_nyi("bootrom", "flash_exit_xip",
+                       "synthetic helper does not send serial flash commands");
+        return;
+    case RP2040_ROM_TABLE_CODE('F', 'C'):
+        rp2040_synthetic_flash_helper_hit(
+            s, RP2040_SYNTHETIC_FLASH_FLUSH_CACHE, "flash_flush_cache");
+        rp2040_log_nyi("bootrom", "flash_flush_cache",
+                       "XIP cache is not modeled");
+        return;
+    case RP2040_ROM_TABLE_CODE('I', 'F'):
+        rp2040_synthetic_flash_helper_hit(
+            s, RP2040_SYNTHETIC_FLASH_CONNECT_INTERNAL_FLASH,
+            "connect_internal_flash");
+        rp2040_log_nyi("bootrom", "connect_internal_flash",
+                       "synthetic helper assumes the QSPI flash is connected");
+        return;
+    case RP2040_ROM_TABLE_CODE('R', 'E'):
+        rp2040_synthetic_flash_helper_hit(
+            s, RP2040_SYNTHETIC_FLASH_RANGE_ERASE, "flash_range_erase");
+        if (!rp2040_xip_flash_range_erase(&s->xip,
+                                          s->synthetic_rom_dbg_arg[0],
+                                          s->synthetic_rom_dbg_arg[1],
+                                          s->synthetic_rom_dbg_arg[2],
+                                          s->synthetic_rom_dbg_arg[3],
+                                          &local_err)) {
+            warn_report_err(local_err);
+        }
+        return;
+    case RP2040_ROM_TABLE_CODE('R', 'P'):
+        rp2040_synthetic_flash_helper_hit(
+            s, RP2040_SYNTHETIC_FLASH_RANGE_PROGRAM, "flash_range_program");
+        if (!rp2040_xip_flash_range_program(&s->xip,
+                                            s->synthetic_rom_dbg_arg[0],
+                                            s->synthetic_rom_dbg_arg[1],
+                                            s->synthetic_rom_dbg_arg[2],
+                                            &local_err)) {
+            warn_report_err(local_err);
+        }
+        return;
+    }
 
     snprintf(feature, sizeof(feature), "boot ROM function '%c%c'",
              code & 0xff, (code >> 8) & 0xff);
-    snprintf(detail, sizeof(detail), "%s%s",
+    snprintf(detail, sizeof(detail), "%s%s%s",
              name ? "SDK name: " : "",
-             name ? name : "unknown lookup code");
+             name ? name : "unknown lookup code",
+             name ? "" : "");
     rp2040_log_nyi("bootrom", feature, detail);
 }
 
 static uint64_t rp2040_synthetic_rom_dbg_read(void *opaque, hwaddr addr,
                                               unsigned size)
 {
+    RP2040State *s = opaque;
+    hwaddr offset = addr & 0xfff;
+
+    if (offset >= RP2040_SYNTHETIC_ROM_DBG_ARG0 &&
+        offset <= RP2040_SYNTHETIC_ROM_DBG_ARG3 &&
+        QEMU_IS_ALIGNED(offset, sizeof(uint32_t))) {
+        return s->synthetic_rom_dbg_arg[(offset -
+                                         RP2040_SYNTHETIC_ROM_DBG_ARG0) /
+                                        sizeof(uint32_t)];
+    }
+    if (offset >= RP2040_SYNTHETIC_ROM_DBG_RESULT0 &&
+        offset <= RP2040_SYNTHETIC_ROM_DBG_RESULT3 &&
+        QEMU_IS_ALIGNED(offset, sizeof(uint32_t))) {
+        return s->synthetic_rom_dbg_result[(offset -
+                                            RP2040_SYNTHETIC_ROM_DBG_RESULT0) /
+                                           sizeof(uint32_t)];
+    }
+    if (offset >= RP2040_SYNTHETIC_ROM_DBG_FLASH_COUNT0 &&
+        offset < RP2040_SYNTHETIC_ROM_DBG_FLASH_COUNT0 +
+                 sizeof(s->synthetic_rom_flash_helper_count) &&
+        QEMU_IS_ALIGNED(offset, sizeof(uint32_t))) {
+        return s->synthetic_rom_flash_helper_count[
+            (offset - RP2040_SYNTHETIC_ROM_DBG_FLASH_COUNT0) /
+            sizeof(uint32_t)];
+    }
+
     rp2040_log_nyi("bootrom", "synthetic diagnostic register read",
-                   "write-only QEMU diagnostic channel");
+                   "unsupported register");
     return 0;
 }
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 1b16f710fe..a888466ca0 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -1,5 +1,8 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# rp2040.c
+rp2040_synthetic_flash_helper(const char *name, uint32_t count) "helper %s count %" PRIu32
+
 # omap1.c
 omap1_pwl_clocking_scheme(const char *scheme) "omap1 CLKM: clocking scheme set to %s"
 omap1_pwl_backlight(int output) "omap1 PWL: backlight now at %d/256"
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 58c524a341..29269c913b 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -54,6 +54,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
 #define RP2040_USBCTRL_REGS_SIZE  0x4000
 #define RP2040_SYNTHETIC_ROM_DBG_BASE 0x5fff0000
 #define RP2040_SYNTHETIC_ROM_DBG_SIZE 0x1000
+#define RP2040_SYNTHETIC_ROM_FLASH_HELPER_COUNT 6
 
 #define RP2040_NUM_CORES      2
 #define RP2040_NUM_IRQS       32
@@ -108,6 +109,10 @@ struct RP2040State {
     bool uart0_rx_pin_enabled;
     bool uart1_tx_pin_enabled;
     bool uart1_rx_pin_enabled;
+    uint32_t synthetic_rom_dbg_arg[4];
+    uint32_t synthetic_rom_dbg_result[4];
+    uint32_t synthetic_rom_flash_helper_count[
+        RP2040_SYNTHETIC_ROM_FLASH_HELPER_COUNT];
 
     Clock *sysclk;
 };
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index eb3de828c5..2f5878c1fa 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -131,6 +131,27 @@ run-rp2040-bootrom-helpers: rp2040-bootrom-helpers
 
 RP2040_TESTS+=rp2040-bootrom-helpers
 
+rp2040-bootrom-float rp2040-flash-lockout: %: %.S \
+		rp2040-boot2-w25q080.S rp2040.ld
+	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
+		-Wl,--build-id=none -x assembler-with-cpp \
+		$(ARM_SRC)/rp2040-boot2-w25q080.S $< \
+		-o $@ -nostdlib -static \
+		-T $(ARM_SRC)/rp2040.ld
+
+run-rp2040-bootrom-float run-rp2040-flash-lockout: QEMU_OPTS=\
+	-M raspi-pico,strict-uart-pins=off \
+	-serial chardev:output \
+	-semihosting-config enable=on,target=native -kernel
+run-rp2040-bootrom-float run-rp2040-flash-lockout: run-%: %
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  $(QEMU_OPTS) $<)
+	$(call diff-out,$<,$(ARM_SRC)/$<.ref)
+
+RP2040_TESTS+=rp2040-bootrom-float rp2040-flash-lockout
+
 ARM_TESTS+=$(RP2040_TESTS) $(RP2040_FLASH_TESTS) $(RP2040_DMA_TESTS)
 
 # These objects provide the basic boot code and helper functions for all tests
diff --git a/tests/tcg/arm/system/rp2040-bootrom-float.S b/tests/tcg/arm/system/rp2040-bootrom-float.S
new file mode 100644
index 0000000000..57d60b9fd9
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-bootrom-float.S
@@ -0,0 +1,206 @@
+/*
+ * Raspberry Pi Pico boot ROM floating-point table test.
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
+#define ROM_DATA_TABLE_PTR     0x00000016
+#define ROM_TABLE_LOOKUP_PTR   0x00000018
+#define ROM_DATA_FLOAT_TABLE   0x4653
+#define ROM_DATA_DOUBLE_TABLE  0x4453
+#define FP_TABLE_FADD          0x00
+#define FP_TABLE_FMUL          0x08
+#define FP_TABLE_FDIV          0x0c
+#define FP_TABLE_FLOAT2DOUBLE  0x7c
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.macro lookup_data code, dst
+    ldr r0, =\code
+    bl rom_data_lookup
+    cmp r0, 0
+    bne 0f
+    b fail_lookup
+0:
+    mov \dst, r0
+.endm
+
+.macro load_table_func basereg, offset
+    mov r4, \basereg
+    adds r4, \offset
+    ldrb r3, [r4]
+    ldrb r5, [r4, 1]
+    lsls r5, 8
+    orrs r3, r5
+    ldrb r5, [r4, 2]
+    lsls r5, 16
+    orrs r3, r5
+    ldrb r5, [r4, 3]
+    lsls r5, 24
+    orrs r3, r5
+    mov r4, r3
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
+    lookup_data ROM_DATA_FLOAT_TABLE, r6
+
+    /* 1.25f + 2.5f = 3.75f. */
+    load_table_func r6, FP_TABLE_FADD
+    ldr r0, =0x3fa00000
+    ldr r1, =0x40200000
+    blx r4
+    fail_if_ne r0, 0x40700000, fail_single
+
+    /* 3.75f * 2.0f = 7.5f. */
+    load_table_func r6, FP_TABLE_FMUL
+    ldr r0, =0x40700000
+    ldr r1, =0x40000000
+    blx r4
+    fail_if_ne r0, 0x40f00000, fail_single
+
+    /* 7.5f / 3.0f = 2.5f. */
+    load_table_func r6, FP_TABLE_FDIV
+    ldr r0, =0x40f00000
+    ldr r1, =0x40400000
+    blx r4
+    fail_if_ne r0, 0x40200000, fail_single
+
+    /* Convert 1.25f to 0x3ff4000000000000. */
+    load_table_func r6, FP_TABLE_FLOAT2DOUBLE
+    ldr r0, =0x3fa00000
+    blx r4
+    fail_if_ne r0, 0x00000000, fail_single
+    fail_if_ne r1, 0x3ff40000, fail_single
+
+    ldr r0, =single_ok_message
+    bl puts
+
+    lookup_data ROM_DATA_DOUBLE_TABLE, r7
+
+    /* 1.5 + 4.0 = 5.5. */
+    load_table_func r7, FP_TABLE_FADD
+    movs r0, 0
+    ldr r1, =0x3ff80000
+    movs r2, 0
+    ldr r3, =0x40100000
+    blx r4
+    fail_if_ne r0, 0x00000000, fail_double
+    fail_if_ne r1, 0x40160000, fail_double
+
+    /* The SD entry at 0x7c converts 1.5 to the float 1.5f. */
+    load_table_func r7, FP_TABLE_FLOAT2DOUBLE
+    movs r0, 0
+    ldr r1, =0x3ff80000
+    blx r4
+    fail_if_ne r0, 0x3fc00000, fail_double
+
+    ldr r0, =double_ok_message
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
+fail_single:
+    ldr r0, =fail_single_message
+    b test_failed
+
+fail_double:
+    ldr r0, =fail_double_message
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
+rom_data_lookup:
+    push {r4, lr}
+    mov r1, r0
+    ldr r0, =ROM_DATA_TABLE_PTR
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
+    .asciz "PICO TCG BOOTROM FLOAT START\n"
+single_ok_message:
+    .asciz "PICO TCG BOOTROM FLOAT SF OK\n"
+double_ok_message:
+    .asciz "PICO TCG BOOTROM FLOAT SD OK\n"
+ok_message:
+    .asciz "PICO TCG BOOTROM FLOAT OK\n"
+fail_lookup_message:
+    .asciz "PICO TCG BOOTROM FLOAT FAIL: LOOKUP\n"
+fail_single_message:
+    .asciz "PICO TCG BOOTROM FLOAT FAIL: SF\n"
+fail_double_message:
+    .asciz "PICO TCG BOOTROM FLOAT FAIL: SD\n"
+fail_exception_message:
+    .asciz "PICO TCG BOOTROM FLOAT FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-bootrom-float.ref b/tests/tcg/arm/system/rp2040-bootrom-float.ref
new file mode 100644
index 0000000000..d1eb0e7463
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-bootrom-float.ref
@@ -0,0 +1,4 @@
+PICO TCG BOOTROM FLOAT START
+PICO TCG BOOTROM FLOAT SF OK
+PICO TCG BOOTROM FLOAT SD OK
+PICO TCG BOOTROM FLOAT OK
diff --git a/tests/tcg/arm/system/rp2040-flash-lockout.S b/tests/tcg/arm/system/rp2040-flash-lockout.S
new file mode 100644
index 0000000000..a7be6bbb51
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-lockout.S
@@ -0,0 +1,387 @@
+/*
+ * Raspberry Pi Pico multicore flash lockout test.
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
+#define CORE1_STACK            0x20041000
+#define PAGE_BUFFER            0x20000000
+#define UART0_DR               0x40034000
+#define SIO_BASE               0xd0000000
+#define SIO_FIFO_ST            0x50
+#define SIO_FIFO_WR            0x54
+#define SIO_FIFO_RD            0x58
+#define SIO_SPINLOCK0          0x100
+#define SIO_FIFO_ST_VLD        0x01
+#define SIO_FIFO_ST_RDY        0x02
+#define NVIC_ISER              0xe000e100
+#define SIO_IRQ_PROC1_MASK     0x00010000
+#define DEBUG_BASE             0x5fff0000
+#define DEBUG_CMD              0x00
+#define DEBUG_ARG0             0x04
+#define DEBUG_ARG1             0x08
+#define DEBUG_ARG2             0x0c
+#define DEBUG_ARG3             0x10
+#define DEBUG_COUNT_ERASE      0x50
+#define DEBUG_COUNT_PROGRAM    0x54
+#define DEBUG_FLASH_ERASE      0x4552
+#define DEBUG_FLASH_PROGRAM    0x5052
+#define FLASH_OFFSET           0x00101000
+#define FLASH_ADDRESS          0x10101000
+#define LOCK_REQUEST           0xfacefeed
+#define LOCK_ACK               0xface0001
+#define RELEASE_REQUEST        0xfacebeef
+#define RELEASE_ACK            0xface0002
+#define BAD_ACK                0xbad10002
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.section .vectors, "a", %progbits
+.global vector_table
+vector_table:
+    .word SRAM_END
+    .word reset_handler + 1
+    .word default_handler + 1
+    .word default_handler + 1
+    .rept 28
+    .word default_handler + 1
+    .endr
+    .word core1_fifo_irq + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    ldr r0, =start_message
+    bl puts
+    bl launch_core1
+
+    ldr r0, =launch_message
+    bl puts
+    bl claim_spinlock
+    ldr r0, =LOCK_REQUEST
+    bl fifo_push
+    sev
+    ldr r0, =LOCK_ACK
+    bl fifo_pop_expect
+
+    ldr r0, =locked_message
+    bl puts
+    bl flash_erase_program_verify
+
+    ldr r0, =flash_message
+    bl puts
+    ldr r0, =RELEASE_REQUEST
+    bl fifo_push
+    sev
+    ldr r0, =RELEASE_ACK
+    bl fifo_pop_expect
+    bl release_spinlock
+
+    ldr r0, =released_message
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
+.thumb_func
+core1_entry:
+    ldr r0, =NVIC_ISER
+    ldr r1, =SIO_IRQ_PROC1_MASK
+    str r1, [r0]
+    cpsie i
+
+2:
+    wfe
+    b 2b
+
+.thumb_func
+core1_fifo_irq:
+    push {r0, r1, r2, r3, r4, lr}
+    bl fifo_pop
+    ldr r1, =LOCK_REQUEST
+    cmp r0, r1
+    bne core1_bad_request
+    ldr r0, =LOCK_ACK
+    bl fifo_push
+
+3:
+    wfe
+    ldr r0, =SIO_BASE
+    ldr r1, [r0, SIO_FIFO_ST]
+    movs r0, SIO_FIFO_ST_VLD
+    tst r1, r0
+    beq 3b
+    bl fifo_pop
+    ldr r1, =RELEASE_REQUEST
+    cmp r0, r1
+    bne core1_bad_request
+    ldr r0, =RELEASE_ACK
+    bl fifo_push
+    pop {r0, r1, r2, r3, r4, pc}
+
+core1_bad_request:
+    ldr r0, =BAD_ACK
+    bl fifo_push
+
+4:
+    b 4b
+
+.thumb_func
+launch_core1:
+    push {r4, r5, lr}
+    ldr r4, =launch_sequence
+    movs r5, 6
+
+5:
+    ldr r0, [r4]
+    cmp r0, 0
+    bne 6f
+    bl fifo_drain
+    sev
+    ldr r0, [r4]
+
+6:
+    bl fifo_push
+    sev
+    bl fifo_pop
+    ldr r1, [r4]
+    cmp r0, r1
+    bne fail_launch
+    adds r4, 4
+    subs r5, 1
+    bne 5b
+    pop {r4, r5, pc}
+
+.thumb_func
+claim_spinlock:
+    ldr r0, =(SIO_BASE + SIO_SPINLOCK0)
+    ldr r1, [r0]
+    cmp r1, 0
+    beq fail_spinlock
+    bx lr
+
+.thumb_func
+release_spinlock:
+    ldr r0, =(SIO_BASE + SIO_SPINLOCK0)
+    movs r1, 0
+    str r1, [r0]
+    bx lr
+
+.thumb_func
+flash_erase_program_verify:
+    push {r4, r5, r6, lr}
+    ldr r0, =PAGE_BUFFER
+    movs r1, 0
+    movs r2, 0
+    movs r3, 1
+    lsls r3, r3, 8
+
+7:
+    strb r1, [r0, r2]
+    adds r1, 1
+    adds r2, 1
+    cmp r2, r3
+    bne 7b
+
+    ldr r4, =DEBUG_BASE
+    ldr r0, =FLASH_OFFSET
+    str r0, [r4, DEBUG_ARG0]
+    movs r0, 1
+    lsls r0, r0, 12
+    str r0, [r4, DEBUG_ARG1]
+    movs r0, 0
+    str r0, [r4, DEBUG_ARG2]
+    movs r0, 0x20
+    str r0, [r4, DEBUG_ARG3]
+    ldr r0, =DEBUG_FLASH_ERASE
+    str r0, [r4, DEBUG_CMD]
+
+    ldr r0, =FLASH_ADDRESS
+    movs r2, 0
+    movs r3, 1
+    lsls r3, r3, 8
+
+8:
+    ldrb r5, [r0, r2]
+    movs r6, 0xff
+    cmp r5, r6
+    bne fail_flash
+    adds r2, 1
+    cmp r2, r3
+    bne 8b
+
+    ldr r0, =FLASH_OFFSET
+    str r0, [r4, DEBUG_ARG0]
+    ldr r0, =PAGE_BUFFER
+    str r0, [r4, DEBUG_ARG1]
+    movs r0, 1
+    lsls r0, r0, 8
+    str r0, [r4, DEBUG_ARG2]
+    ldr r0, =DEBUG_FLASH_PROGRAM
+    str r0, [r4, DEBUG_CMD]
+
+    ldr r0, =FLASH_ADDRESS
+    movs r1, 0
+    movs r2, 0
+    movs r3, 1
+    lsls r3, r3, 8
+
+9:
+    ldrb r5, [r0, r2]
+    cmp r5, r1
+    bne fail_flash
+    adds r1, 1
+    adds r2, 1
+    cmp r2, r3
+    bne 9b
+
+    ldr r0, [r4, DEBUG_COUNT_ERASE]
+    cmp r0, 1
+    bne fail_flash
+    ldr r0, [r4, DEBUG_COUNT_PROGRAM]
+    cmp r0, 1
+    bne fail_flash
+    pop {r4, r5, r6, pc}
+
+.thumb_func
+fifo_push:
+    push {r1, r2, r3, lr}
+    ldr r1, =SIO_BASE
+
+10:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_RDY
+    tst r2, r3
+    beq 10b
+    str r0, [r1, SIO_FIFO_WR]
+    pop {r1, r2, r3, pc}
+
+.thumb_func
+fifo_pop:
+    push {r1, r2, r3, lr}
+    ldr r1, =SIO_BASE
+
+11:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_VLD
+    tst r2, r3
+    beq 11b
+    ldr r0, [r1, SIO_FIFO_RD]
+    pop {r1, r2, r3, pc}
+
+.thumb_func
+fifo_drain:
+    push {r0, r1, r2, r3, lr}
+    ldr r1, =SIO_BASE
+
+12:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_VLD
+    tst r2, r3
+    beq 13f
+    ldr r0, [r1, SIO_FIFO_RD]
+    b 12b
+
+13:
+    pop {r0, r1, r2, r3, pc}
+
+.thumb_func
+fifo_pop_expect:
+    push {r4, lr}
+    mov r4, r0
+    bl fifo_pop
+    cmp r0, r4
+    bne fail_fifo
+    pop {r4, pc}
+
+fail_launch:
+    ldr r0, =fail_launch_message
+    b test_failed
+
+fail_spinlock:
+    ldr r0, =fail_spinlock_message
+    b test_failed
+
+fail_fifo:
+    ldr r0, =fail_fifo_message
+    b test_failed
+
+fail_flash:
+    ldr r0, =fail_flash_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+14:
+    b 14b
+
+.thumb_func
+default_handler:
+    ldr r0, =fail_exception_message
+    b test_failed
+
+.thumb_func
+puts:
+    push {r1, r2, lr}
+    ldr r1, =UART0_DR
+
+15:
+    ldrb r2, [r0]
+    cmp r2, 0
+    beq 16f
+    str r2, [r1]
+    adds r0, 1
+    b 15b
+
+16:
+    pop {r1, r2, pc}
+
+.section .rodata, "a", %progbits
+.align 2
+launch_sequence:
+    .word 0
+    .word 0
+    .word 1
+    .word vector_table
+    .word CORE1_STACK
+    .word core1_entry + 1
+
+start_message:
+    .asciz "PICO TCG FLASH LOCKOUT START\n"
+launch_message:
+    .asciz "PICO TCG FLASH LOCKOUT CORE1 OK\n"
+locked_message:
+    .asciz "PICO TCG FLASH LOCKOUT LOCKED\n"
+flash_message:
+    .asciz "PICO TCG FLASH LOCKOUT PROGRAM OK\n"
+released_message:
+    .asciz "PICO TCG FLASH LOCKOUT RELEASED\n"
+ok_message:
+    .asciz "PICO TCG FLASH LOCKOUT OK\n"
+fail_launch_message:
+    .asciz "PICO TCG FLASH LOCKOUT FAIL: LAUNCH\n"
+fail_spinlock_message:
+    .asciz "PICO TCG FLASH LOCKOUT FAIL: SPINLOCK\n"
+fail_fifo_message:
+    .asciz "PICO TCG FLASH LOCKOUT FAIL: FIFO\n"
+fail_flash_message:
+    .asciz "PICO TCG FLASH LOCKOUT FAIL: FLASH\n"
+fail_exception_message:
+    .asciz "PICO TCG FLASH LOCKOUT FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-flash-lockout.ref b/tests/tcg/arm/system/rp2040-flash-lockout.ref
new file mode 100644
index 0000000000..300d9b134b
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-lockout.ref
@@ -0,0 +1,6 @@
+PICO TCG FLASH LOCKOUT START
+PICO TCG FLASH LOCKOUT CORE1 OK
+PICO TCG FLASH LOCKOUT LOCKED
+PICO TCG FLASH LOCKOUT PROGRAM OK
+PICO TCG FLASH LOCKOUT RELEASED
+PICO TCG FLASH LOCKOUT OK
-- 
2.55.0


