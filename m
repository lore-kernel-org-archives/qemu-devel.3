Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF8C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYa-0001PP-62; Mon, 24 Aug 2026 01:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNY5-0001EQ-FY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:46 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNY1-0001kJ-RN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:45 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so2251819a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550520; x=1788155320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ISGwObacQP6g+5gFiDUcuJ6IB5GVTpdCetCfXhn1piQ=;
 b=AF0OzTWtSYdTOBEpOpQdtVqcMDxb016n27QsJQn6v45ks79wrbK+5Tl3i4/XmzFelp
 mGunW8mS+GVR2DuD7wyUMAJeROfsevQfV5Y5cgbLAnWsxBRmdTTIuv6wRS8cImsjJ6r/
 YCXMExuTxn3aJvEq3PsUkSmLey+HJto8Jls4BwkJ5bgICDYKYiv0moAqJ/4c4diS3ibt
 u1HhBK8bI726C+Lw9Ra/3njE7UB/8NYzYv5CNVvoy+Laajs80nax30Px8syw7HKiREJI
 m7eUYsp2soJqDRbLb9uUrmAXGL+/rLiOh1deM8Vr6xf1PU7F4Gu/wthP82AF7yeYLTp4
 Js4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550520; x=1788155320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ISGwObacQP6g+5gFiDUcuJ6IB5GVTpdCetCfXhn1piQ=;
 b=KlbToagmQkRT4HtQhrX3BEvFLT+33E15eEhz1fSiNOCUE4+x18fPx5ZmHvelP7wuI3
 uPUhRTWQYK2FpWDRZ2QTYtYz9CP0UNK06zWcWOPg+2gjXanRNqRcS60G5ncyJJfPFi1A
 WO3nNJj8Ke8LTuQPe2iXXLn9lthXzzo7CrJErFRcnzGiQKWILu0UghwK9d1s5/dDCeJV
 9Fw4Xz+I/1qKnodyPpfFEjH1E9bP1KVLjGQ956AFXBb07SYgdkTPtoVbhuPkBQbj15bb
 /ElceF5pTuPeKKcGZlJn2/aTALhxza/+jTWXkDiIqNW6tXciE9EnYEIVJJqUdML1mXTh
 T4QA==
X-Gm-Message-State: AFuF++lnYF8idAAkvjQKzMV0vaIkBv0xvD4sP18zt3KTkttugyQuKC8o
 Dx+iYARfYEHzgDP8EVfQVscFv6Tt5dLKQbJA6v5fM3a8Qnixe1mJ3/wTQ2KSqA==
X-Gm-Gg: AR+sD125g+hBsTK4DT91Wm1tcunSF7Zi1znkfgjIfgLuVD6SX0C19QRLa0yQMKQoSdF
 izdWDcd/F1qvC0TpMieFi9f+tHG8osBOEt+sCG0Grjh/xIT/IXa3VTCtaGZlmQlFB8DegTAvcU2
 BUq12FB4/YC+INIf08fGVcMPFu3UqTJo8amnmc+6rc/KawzCQVZJD/OCcKaSWMASRFrXSaMvKmQ
 EDNKzz5985H/8zU51O8Wa/dDsoYbeJEbiycEqH9dHaLvWsTMbwrSqqfgdgMZH4u1dkkL3fTfkJK
 8LS+1fQY1NllTL/UgcX6zp+KcHdKaEbEeVY8B5Naulw3al0Rl1QX4j4VKtIqCAc8xjSiovBhSc0
 YcuPp+VXEkv0M7S4u6zG4BQSb1/CK/+1tTf9l8+LXZ13ld504ec54/XcCH7iWgdZBPdF/eA+chG
 SvoIVDGYO3PLrO2Z11xhVznCAFWYkJ31IulzAg+g4uLWcLlls02zkCShmFg/5GKgmOUot1qecWF
 kmTyQ==
X-Received: by 2002:a17:90b:528f:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-395c35636acmr43986128a91.7.1787550520076; 
 Sun, 23 Aug 2026 22:48:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Junze Cao <caojunze424@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 07/96] tests/qtest: add test for K230 gsdma
Date: Mon, 24 Aug 2026 15:46:37 +1000
Message-ID: <20260824054806.2790041-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Tao Ding <dingtao0430@163.com>

This commit adds test cases for GSDMA.
Imitate the behavior of the driver, set LLT and sdma registers.
After the data transmission is completed, check the destination address data.

Update MAINTAINERS for this test.

Run this qtest:
    $ mkdir build && cd build && ../configure --target-list="riscv64-softmmu"
    $ QTEST_QEMU_BINARY=./qemu-system-riscv64   tests/qtest/k230-gsdma-test

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Junze Cao <caojunze424@gmail.com>
Message-ID: <20260808062227.66961-4-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                        |   3 +
 docs/system/riscv/k230.rst         |   1 +
 include/hw/misc/k230_decomp_gzip.h |  92 ++++++
 hw/misc/k230_decomp_gzip.c         | 511 +++++++++++++++++++++++++++++
 tests/qtest/k230-gsdma-test.c      | 201 ++++++++++++
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 hw/misc/trace-events               |   8 +-
 tests/qtest/meson.build            |   2 +-
 9 files changed, 816 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/misc/k230_decomp_gzip.h
 create mode 100644 hw/misc/k230_decomp_gzip.c
 create mode 100644 tests/qtest/k230-gsdma-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 027db78b39..ff804b3310 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1848,13 +1848,16 @@ F: hw/misc/k230_ddr.c
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: hw/dma/k230_gsdma.c
+F: hw/misc/k230_decomp_gzip.c
 F: include/hw/misc/k230_ddr.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: include/hw/dma/k230_gsdma.h
+F: include/hw/misc/k230_decomp_gzip.h
 F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-ddr-test.c
 F: tests/qtest/k230-wdt-test.c
+F: tests/qtest/k230-gsdma-test.c
 
 RX Machines
 -----------
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 5cbc0b14bc..237611eddf 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -22,6 +22,7 @@ The ``k230`` machine supports the following devices:
 * 5 UART
 * K230 DDRC CFG and DDR PHY
 * System Direct Memory Access (SDMA)
+* GZIP Decompress Engine (Decomp_gzip)
 
 Boot options
 ------------
diff --git a/include/hw/misc/k230_decomp_gzip.h b/include/hw/misc/k230_decomp_gzip.h
new file mode 100644
index 0000000000..9911af0095
--- /dev/null
+++ b/include/hw/misc/k230_decomp_gzip.h
@@ -0,0 +1,92 @@
+/*
+ * K230 Decompress Engine
+ *
+ * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_K230_DECOMP_GZIP_H
+#define HW_MISC_K230_DECOMP_GZIP_H
+
+#include <zlib.h>
+#include "hw/core/sysbus.h"
+
+#define TYPE_K230_DECOMP_GZIP "riscv.k230.decomp-gzip"
+OBJECT_DECLARE_SIMPLE_TYPE(K230DecompGzipState, K230_DECOMP_GZIP)
+
+/* K230 DECOMP GZIP ACK input */
+enum {
+    K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK,
+    K230_DECOMP_GZIP_GPIO_DMA_READ_ACK,
+    K230_DECOMP_GZIP_NUM_GPIOS_IN,
+};
+
+/* K230 DECOMP GZIP REQ output */
+enum {
+    K230_DECOMP_GZIP_GPIO_DECOMP_CTRL_EN,
+    K230_DECOMP_GZIP_GPIO_DMA_WRITE_REQ,
+    K230_DECOMP_GZIP_GPIO_DMA_READ_REQ,
+    K230_DECOMP_GZIP_NUM_GPIOS_OUT,
+};
+
+#define K230_DECOMP_GZIP_MMIO_SIZE       0x4000
+
+/* K230 DECOMP GZIP Registers map */
+/* Start decompression controller */
+#define K230_DECOMP_GZIP_DECOMP_START    0x00
+/* Source data length register */
+#define K230_DECOMP_GZIP_GZIP_SRC_SIZE   0x04
+/* Output data length register */
+#define K230_DECOMP_GZIP_GZIP_OUT_SIZE   0x08
+/* Decompress status register */
+#define K230_DECOMP_GZIP_DECOMP_STAT     0x0c
+
+/* Start decompression controller */
+#define K230_DECOMP_GZIP_START           (1U << 0)
+
+#define K230_DECOMP_GZIP_CTRL_EN         (1U << 31)
+#define K230_DECOMP_GZIP_DMA_IN_MASK     0x7fffffffU
+
+#define K230_DECOMP_GZIP_STAT_CRC_OK     (1U << 10)
+#define K230_DECOMP_GZIP_STAT_STATE_MASK 0xfU
+
+#define K230_DECOMP_GZIP_BLOCK_SIZE      0x00020000
+#define K230_DECOMP_GZIP_SRAM_IN_BASE    0x80000
+#define K230_DECOMP_GZIP_SRAM_OUT_BASE   0
+
+typedef struct K230DecompGzipSlotState {
+    uint32_t slot;  /* Slot index */
+    /*
+     * Data offset in current slot.
+     * First valid data in input buffer. Last valid data in output buffer.
+     */
+    uint32_t current_offset;
+} K230DecompGzipSlotState;
+
+struct K230DecompGzipState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    hwaddr sram_base;
+    qemu_irq signal_out[K230_DECOMP_GZIP_NUM_GPIOS_OUT];
+    uint32_t decomp_start;
+    uint32_t gzip_src_size;
+    uint32_t gzip_out_size;
+    uint32_t decomp_stat;
+    K230DecompGzipSlotState input;  /* decomp gzip ring input */
+    K230DecompGzipSlotState output; /* decomp gzip ring output */
+    uint32_t total_requested;
+    uint32_t total_produced;
+    bool active;
+    bool in_kick;
+    bool zstream_inited;
+    bool stream_end;
+    /* Read from ring input. */
+    uint8_t input_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
+    /* Write to ring output. */
+    uint8_t output_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
+    z_stream zs;
+};
+
+#endif
diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
new file mode 100644
index 0000000000..0d8a3b2d2e
--- /dev/null
+++ b/hw/misc/k230_decomp_gzip.c
@@ -0,0 +1,511 @@
+/*
+ * Kendryte K230 GZIP decompression engine
+ *
+ * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Decompression accelerator is mainly used to implement hardware
+ * GZIP decompression function. (K230 TRM section 15)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+#include "hw/core/irq.h"
+#include "hw/misc/k230_decomp_gzip.h"
+#include "trace.h"
+
+#define GZIP_METHOD_DEFLATE    8
+#define GZIP_METHOD_VENDOR_9   9
+
+#define DEFLATE_BTYPE_DYNAMIC  2
+
+#define K230_DECOMP_GZIP_OUTPUT_SLOTS 4
+#define K230_DECOMP_GZIP_INPUT_SLOTS 2
+
+static void k230_decomp_gzip_set_output(K230DecompGzipState *s, int line,
+                                        int level)
+{
+    qemu_set_irq(s->signal_out[line], level);
+}
+
+static bool k230_decomp_gzip_read_mem(K230DecompGzipState *s, hwaddr addr,
+                                      void *buf, size_t len)
+{
+    MemTxResult ret = address_space_read(&address_space_memory,
+                                         s->sram_base + addr,
+                                         MEMTXATTRS_UNSPECIFIED, buf, len);
+
+    return ret == MEMTX_OK;
+}
+
+static bool k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
+                                       const void *buf, size_t len)
+{
+    return address_space_write(&address_space_memory, s->sram_base + addr,
+                               MEMTXATTRS_UNSPECIFIED, buf, len) == MEMTX_OK;
+}
+
+static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
+{
+    return K230_DECOMP_GZIP_SRAM_OUT_BASE +
+           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+           s->output.current_offset;
+}
+
+static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
+{
+    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+           K230_DECOMP_GZIP_SRAM_IN_BASE;
+}
+
+static uint32_t k230_decomp_gzip_current_input_size(K230DecompGzipState *s)
+{
+    if (s->total_requested == 0) {
+        return 0;
+    }
+
+    return ((s->total_requested - 1) % K230_DECOMP_GZIP_BLOCK_SIZE) + 1;
+}
+
+static void k230_decomp_gzip_update_ctrl_en(K230DecompGzipState *s)
+{
+    int level = s->active && !!(s->gzip_src_size & K230_DECOMP_GZIP_CTRL_EN);
+
+    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DECOMP_CTRL_EN,
+                                level);
+}
+
+static void k230_decomp_gzip_reset_stream(K230DecompGzipState *s)
+{
+    if (s->zstream_inited) {
+        inflateEnd(&s->zs);
+        s->zstream_inited = false;
+    }
+    memset(&s->zs, 0, sizeof(s->zs));
+}
+
+static void k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
+{
+    s->active = false;
+    k230_decomp_gzip_reset_stream(s);
+    k230_decomp_gzip_update_ctrl_en(s);
+    if (crc_ok) {
+        s->decomp_stat |= K230_DECOMP_GZIP_STAT_CRC_OK;
+    } else {
+        s->decomp_stat &= ~K230_DECOMP_GZIP_STAT_CRC_OK;
+    }
+}
+
+static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
+                                        uint32_t addr, uint32_t size)
+{
+    s->input.current_offset = 0;
+
+    return k230_decomp_gzip_read_mem(s, addr, s->input_buf, size);
+}
+
+static bool k230_decomp_gzip_request_input(K230DecompGzipState *s)
+{
+    uint32_t total_requested = s->total_requested;
+
+    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DMA_WRITE_REQ, 1);
+    if (s->total_requested == total_requested) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: dma write request not acknowledged\n",
+                      TYPE_K230_DECOMP_GZIP);
+        return false;
+    }
+    return true;
+}
+
+static bool k230_decomp_gzip_request_output(K230DecompGzipState *s)
+{
+    uint32_t slot = s->output.slot;
+    uint32_t current_offset = s->output.current_offset;
+
+    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DMA_READ_REQ, 1);
+    if (s->output.slot == slot &&
+        s->output.current_offset == current_offset) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: dma read request not acknowledged\n",
+                      TYPE_K230_DECOMP_GZIP);
+        return false;
+    }
+    return true;
+}
+
+static bool k230_decomp_gzip_init_stream(K230DecompGzipState *s)
+{
+    uint8_t btype = (s->input_buf[10] >> 1) & 0x3;
+    if (btype != DEFLATE_BTYPE_DYNAMIC) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unsupported DEFLATE BTYPE %u\n",
+                      TYPE_K230_DECOMP_GZIP, btype);
+        return false;
+    }
+
+    /* The compression script for K230 will modify the third byte to 0x9 */
+    if (s->input_buf[2] == GZIP_METHOD_VENDOR_9) {
+        s->input_buf[2] = GZIP_METHOD_DEFLATE;
+    }
+
+    if (inflateInit2(&s->zs, 15 + 16) != Z_OK) {
+        return false;
+    }
+
+    s->zstream_inited = true;
+    return true;
+}
+
+static bool k230_decomp_gzip_run_inflate(K230DecompGzipState *s)
+{
+    uint32_t output_size = s->gzip_out_size;
+    uint32_t current_input_size = k230_decomp_gzip_current_input_size(s);
+    uint32_t avail_in;
+    uint32_t avail_out;
+    uint32_t consumed;
+    uint32_t produced;
+    int ret;
+
+    avail_in = current_input_size - s->input.current_offset;
+    avail_out = K230_DECOMP_GZIP_BLOCK_SIZE - s->output.current_offset;
+
+    s->zs.next_in = s->input_buf + s->input.current_offset;
+    s->zs.avail_in = avail_in;
+    s->zs.next_out = s->output_buf;
+    s->zs.avail_out = avail_out;
+
+    ret = inflate(&s->zs, Z_NO_FLUSH);
+    if (ret != Z_OK && ret != Z_STREAM_END && ret != Z_BUF_ERROR) {
+        return false;
+    }
+
+    consumed = avail_in - s->zs.avail_in;
+    produced = avail_out - s->zs.avail_out;
+
+    if (produced) {
+        if (s->total_produced + produced > output_size ||
+            !k230_decomp_gzip_write_mem(s, k230_decomp_gzip_output_addr(s),
+                                        s->output_buf, produced)) {
+            return false;
+        }
+        s->output.current_offset += produced;
+        s->total_produced += produced;
+    }
+
+    if (consumed) {
+        s->input.current_offset += consumed;
+    }
+
+    if (ret == Z_STREAM_END) {
+        s->stream_end = true;
+        if (s->total_produced != output_size) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static void k230_decomp_gzip_kick(K230DecompGzipState *s)
+{
+    if (!s->active || s->in_kick) {
+        return;
+    }
+
+    uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
+    s->in_kick = true;
+    while (s->active) {
+        uint32_t current_input_size = k230_decomp_gzip_current_input_size(s);
+        /* Output is full or last block */
+        if (s->output.current_offset == K230_DECOMP_GZIP_BLOCK_SIZE ||
+            (s->stream_end && s->output.current_offset != 0)) {
+            if (!k230_decomp_gzip_request_output(s)) {
+                k230_decomp_gzip_finish(s, false);
+                break;
+            }
+            continue;
+        }
+
+        if (!s->zstream_inited) {
+            if (!k230_decomp_gzip_request_input(s) ||
+                !k230_decomp_gzip_init_stream(s)) {
+                k230_decomp_gzip_finish(s, false);
+                break;
+            }
+            continue;
+        }
+
+        /* Transfer finish */
+        if (s->stream_end) {
+            k230_decomp_gzip_finish(s,
+                                    s->total_produced == s->gzip_out_size);
+            break;
+        }
+
+        /* Input buf has has been fully decompreed, need request more */
+        if (s->input.current_offset == current_input_size) {
+            if (s->total_requested < input_size) {
+                if (!k230_decomp_gzip_request_input(s)) {
+                    k230_decomp_gzip_finish(s, false);
+                    break;
+                }
+                continue;
+            }
+            k230_decomp_gzip_finish(s, false);
+            break;
+        }
+
+        /* Decompress the data, input buf or output buf are consumed in one block */
+        if (!k230_decomp_gzip_run_inflate(s)) {
+            k230_decomp_gzip_finish(s, false);
+            break;
+        }
+    }
+    s->in_kick = false;
+}
+
+static void k230_decomp_gzip_handle_ack(void *opaque, int n, int level)
+{
+    K230DecompGzipState *s = opaque;
+
+    if (!level || !s->active) {
+        return;
+    }
+
+    switch (n) {
+    case K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK:
+    {
+        uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
+        uint32_t chunk = MIN(K230_DECOMP_GZIP_BLOCK_SIZE,
+                             input_size - s->total_requested);
+
+        if (!k230_decomp_gzip_load_input(s, k230_decomp_gzip_input_addr(s),
+                                         chunk)) {
+            k230_decomp_gzip_finish(s, false);
+            return;
+        }
+        s->total_requested += chunk;
+        s->input.slot = (s->input.slot + 1) % K230_DECOMP_GZIP_INPUT_SLOTS;
+        break;
+    }
+    case K230_DECOMP_GZIP_GPIO_DMA_READ_ACK:
+        if (s->output.current_offset == 0) {
+            k230_decomp_gzip_finish(s, false);
+            return;
+        }
+        s->output.slot = (s->output.slot + 1) % K230_DECOMP_GZIP_OUTPUT_SLOTS;
+        s->output.current_offset = 0;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid DMA acknowledgment signal %d\n",
+                      TYPE_K230_DECOMP_GZIP, n);
+        return;
+    }
+
+    k230_decomp_gzip_kick(s);
+}
+
+static void k230_decomp_gzip_start(K230DecompGzipState *s)
+{
+    uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
+
+    k230_decomp_gzip_reset_stream(s);
+    s->decomp_stat &= ~K230_DECOMP_GZIP_STAT_CRC_OK;
+    s->total_requested = 0;
+    s->total_produced = 0;
+    s->stream_end = false;
+    memset(&s->input, 0, sizeof(s->input));
+    memset(&s->output, 0, sizeof(s->output));
+
+    if (!(s->gzip_src_size & K230_DECOMP_GZIP_CTRL_EN) ||
+        input_size == 0 || s->gzip_out_size == 0) {
+        k230_decomp_gzip_finish(s, false);
+        return;
+    }
+
+    s->active = true;
+    k230_decomp_gzip_update_ctrl_en(s);
+    k230_decomp_gzip_kick(s);
+}
+
+static uint64_t k230_decomp_gzip_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    K230DecompGzipState *s = opaque;
+    uint64_t value = 0;
+
+    switch (offset) {
+    case K230_DECOMP_GZIP_DECOMP_START:
+        value = s->decomp_start & ~K230_DECOMP_GZIP_START; /* start bit is write only */
+        break;
+    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
+        value = s->gzip_src_size;
+        break;
+    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
+        value = s->gzip_out_size;
+        break;
+    case K230_DECOMP_GZIP_DECOMP_STAT:
+        value = s->decomp_stat;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_K230_DECOMP_GZIP, offset);
+        break;
+    }
+
+    trace_k230_decomp_gzip_read(offset, size, value);
+    return value;
+}
+
+static void k230_decomp_gzip_write(void *opaque, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    K230DecompGzipState *s = opaque;
+
+    trace_k230_decomp_gzip_write(offset, size, value);
+
+    switch (offset) {
+    case K230_DECOMP_GZIP_DECOMP_START:
+        s->decomp_start = value;
+        if (value & K230_DECOMP_GZIP_START) {
+            k230_decomp_gzip_start(s);
+        }
+        break;
+    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
+        s->gzip_src_size = value;
+        k230_decomp_gzip_update_ctrl_en(s);
+        break;
+    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
+        s->gzip_out_size = value;
+        break;
+    case K230_DECOMP_GZIP_DECOMP_STAT:
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_K230_DECOMP_GZIP, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_decomp_gzip_ops = {
+    .read = k230_decomp_gzip_read,
+    .write = k230_decomp_gzip_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+static const VMStateDescription vmstate_k230_decomp_gzip_slot = {
+    .name = "k230.decomp-gzip.slot",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(slot, K230DecompGzipSlotState),
+        VMSTATE_UINT32(current_offset, K230DecompGzipSlotState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_k230_decomp_gzip = {
+    .name = "k230.decomp-gzip",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(decomp_start, K230DecompGzipState),
+        VMSTATE_UINT32(gzip_src_size, K230DecompGzipState),
+        VMSTATE_UINT32(gzip_out_size, K230DecompGzipState),
+        VMSTATE_UINT32(decomp_stat, K230DecompGzipState),
+        VMSTATE_STRUCT(input, K230DecompGzipState, 1,
+                       vmstate_k230_decomp_gzip_slot,
+                       K230DecompGzipSlotState),
+        VMSTATE_STRUCT(output, K230DecompGzipState, 1,
+                       vmstate_k230_decomp_gzip_slot,
+                       K230DecompGzipSlotState),
+        VMSTATE_UINT32(total_requested, K230DecompGzipState),
+        VMSTATE_UINT32(total_produced, K230DecompGzipState),
+        VMSTATE_BOOL(active, K230DecompGzipState),
+        VMSTATE_BOOL(in_kick, K230DecompGzipState),
+        VMSTATE_BOOL(zstream_inited, K230DecompGzipState),
+        VMSTATE_BOOL(stream_end, K230DecompGzipState),
+        VMSTATE_UINT8_ARRAY(input_buf, K230DecompGzipState,
+                            K230_DECOMP_GZIP_BLOCK_SIZE),
+        VMSTATE_UINT8_ARRAY(output_buf, K230DecompGzipState,
+                            K230_DECOMP_GZIP_BLOCK_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_decomp_gzip_reset_hold(Object *obj, ResetType type)
+{
+    K230DecompGzipState *s = K230_DECOMP_GZIP(obj);
+
+    k230_decomp_gzip_reset_stream(s);
+    memset(&s->zs, 0, sizeof(s->zs));
+    s->decomp_start = 0;
+    s->gzip_src_size = 0;
+    s->gzip_out_size = 0;
+    s->decomp_stat = 0;
+    memset(&s->input, 0, sizeof(s->input));
+    memset(&s->output, 0, sizeof(s->output));
+    s->total_requested = 0;
+    s->total_produced = 0;
+    s->active = false;
+    s->in_kick = false;
+    s->stream_end = false;
+}
+
+static void k230_decomp_gzip_realize(DeviceState *dev, Error **errp)
+{
+    K230DecompGzipState *s = K230_DECOMP_GZIP(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &k230_decomp_gzip_ops, s,
+                          TYPE_K230_DECOMP_GZIP,
+                          K230_DECOMP_GZIP_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    qdev_init_gpio_in(dev, k230_decomp_gzip_handle_ack,
+                      K230_DECOMP_GZIP_NUM_GPIOS_IN);
+    qdev_init_gpio_out(dev, s->signal_out,
+                       K230_DECOMP_GZIP_NUM_GPIOS_OUT);
+}
+
+static const Property k230_decomp_gzip_properties[] = {
+    DEFINE_PROP_UINT64("sram-base", K230DecompGzipState, sram_base, 0),
+};
+
+static void k230_decomp_gzip_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    dc->realize = k230_decomp_gzip_realize;
+    rc->phases.hold = k230_decomp_gzip_reset_hold;
+    device_class_set_props(dc, k230_decomp_gzip_properties);
+    dc->vmsd = &vmstate_k230_decomp_gzip;
+    dc->desc = "Kendryte K230 GZIP decompression engine";
+}
+
+static const TypeInfo k230_decomp_gzip_info = {
+    .name = TYPE_K230_DECOMP_GZIP,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230DecompGzipState),
+    .class_init = k230_decomp_gzip_class_init,
+};
+
+static void k230_decomp_gzip_register_types(void)
+{
+    type_register_static(&k230_decomp_gzip_info);
+}
+
+type_init(k230_decomp_gzip_register_types)
diff --git a/tests/qtest/k230-gsdma-test.c b/tests/qtest/k230-gsdma-test.c
new file mode 100644
index 0000000000..44d4248739
--- /dev/null
+++ b/tests/qtest/k230-gsdma-test.c
@@ -0,0 +1,201 @@
+/*
+ * QTest testcase for K230 GSDMA
+ *
+ * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "exec/hwaddr.h"
+#include "hw/dma/k230_gsdma.h"
+#include "libqtest.h"
+
+#define K230_GSDMA_BASE              0x80800000
+#define TEST_LLT_ADDR0               0x10000
+#define TEST_LLT_ADDR1               0x10040
+#define TEST_LLT_ADDR2               0x10080
+
+#define TEST_SRC_ADDR0               0x20000
+#define TEST_SRC_ADDR1               0x22000
+#define TEST_SRC_ADDR2               0x23000
+#define TEST_DST_ADDR0               0x30000
+#define TEST_DST_ADDR1               0x32000
+#define TEST_DST_ADDR2               0x33000
+
+static inline uint64_t gsdma_reg(hwaddr off)
+{
+    return K230_GSDMA_BASE + off;
+}
+
+static inline uint64_t gsdma_ch_reg(unsigned int ch, hwaddr off)
+{
+    return K230_GSDMA_BASE + K230_GSDMA_CH_BASE +
+           ch * K230_GSDMA_CH_STRIDE + off;
+}
+
+static void write_sdma_llt_node_full(QTestState *qts, hwaddr addr,
+                                     uint32_t cfg, hwaddr src,
+                                     uint32_t size, hwaddr dst,
+                                     hwaddr next)
+{
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, cfg), cfg);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, src_addr), src);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_size), size);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_cfg), 0x1);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, dst_addr), dst);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, next_llt_addr), next);
+}
+
+static void write_sdma_llt_node(QTestState *qts, hwaddr addr, uint32_t cfg,
+                                uint32_t next)
+{
+    write_sdma_llt_node_full(qts, addr, cfg, 0x11110000, 0x200,
+                             0x22220000, next);
+}
+
+static void fill_pattern(uint8_t *buf, size_t size, uint8_t seed)
+{
+    for (size_t i = 0; i < size; i++) {
+        buf[i] = seed + i * 37;
+    }
+}
+
+static void test_global_registers(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), ==,
+                    K230_GSDMA_DMA_CFG_RESET);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), 0xff);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN)), ==,
+                    K230_GSDMA_DMA_CH_EN_MASK);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK), 0x12345);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK)), ==,
+                    0x12345);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CFG), 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), ==,
+                    0xa5a5a5a5);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT), 0xff55aa55);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT)), ==,
+                    0x55aa55);
+
+    qtest_quit(qts);
+}
+
+static void test_sdma_pause_resume(void)
+{
+    uint32_t int_stat;
+    QTestState *qts = qtest_init("-machine k230");
+
+    write_sdma_llt_node(qts, TEST_LLT_ADDR0, K230_GSDMA_LLT_PAUSE,
+                        TEST_LLT_ADDR1);
+    write_sdma_llt_node(qts, TEST_LLT_ADDR1, K230_GSDMA_LLT_NODE_INTR, 0);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR0);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
+                    K230_GSDMA_SDMA_STATUS_PAUSE);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR0);
+
+    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), ==,
+                    K230_GSDMA_SDMA_PAUSE_INT(0));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==, 0);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT), int_stat);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_RESUME);
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
+                    0);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR1);
+
+    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==,
+                    K230_GSDMA_SDMA_DONE_INT(0));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_ITEM_INT(0), ==,
+                    K230_GSDMA_SDMA_ITEM_INT(0));
+
+    qtest_quit(qts);
+}
+
+static void test_sdma_three_llt_copy(void)
+{
+    uint8_t src0[0x1000];
+    uint8_t src1[1];
+    uint8_t src2[511];
+    uint8_t dst0[sizeof(src0)];
+    uint8_t dst1[sizeof(src1)];
+    uint8_t dst2[sizeof(src2)];
+    uint32_t int_stat;
+    QTestState *qts = qtest_init("-machine k230");
+
+    fill_pattern(src0, sizeof(src0), 0x10);
+    fill_pattern(src1, sizeof(src1), 0x31);
+    fill_pattern(src2, sizeof(src2), 0x52);
+    memset(dst0, 0xa5, sizeof(dst0));
+    memset(dst1, 0xa5, sizeof(dst1));
+    memset(dst2, 0xa5, sizeof(dst2));
+
+    qtest_memwrite(qts, TEST_SRC_ADDR0, src0, sizeof(src0));
+    qtest_memwrite(qts, TEST_SRC_ADDR1, src1, sizeof(src1));
+    qtest_memwrite(qts, TEST_SRC_ADDR2, src2, sizeof(src2));
+    qtest_memwrite(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
+    qtest_memwrite(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
+    qtest_memwrite(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
+
+    write_sdma_llt_node_full(qts, TEST_LLT_ADDR0, 0, TEST_SRC_ADDR0,
+                             sizeof(src0), TEST_DST_ADDR0, TEST_LLT_ADDR1);
+    write_sdma_llt_node_full(qts, TEST_LLT_ADDR1, 0, TEST_SRC_ADDR1,
+                             sizeof(src1), TEST_DST_ADDR1, TEST_LLT_ADDR2);
+    write_sdma_llt_node_full(qts, TEST_LLT_ADDR2, 0, TEST_SRC_ADDR2,
+                             sizeof(src2), TEST_DST_ADDR2, 0);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR0);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
+                    0);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR2);
+
+    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==,
+                    K230_GSDMA_SDMA_DONE_INT(0));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), ==, 0);
+
+    memset(dst0, 0, sizeof(dst0));
+    memset(dst1, 0, sizeof(dst1));
+    memset(dst2, 0, sizeof(dst2));
+    qtest_memread(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
+    qtest_memread(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
+    qtest_memread(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
+
+    g_assert_cmpmem(dst0, sizeof(dst0), src0, sizeof(src0));
+    g_assert_cmpmem(dst1, sizeof(dst1), src1, sizeof(src1));
+    g_assert_cmpmem(dst2, sizeof(dst2), src2, sizeof(src2));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-gsdma/global-registers", test_global_registers);
+    qtest_add_func("/k230-gsdma/sdma-pause-resume", test_sdma_pause_resume);
+    qtest_add_func("/k230-gsdma/sdma-three-llt-copy",
+                   test_sdma_three_llt_copy);
+
+    return g_test_run();
+}
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b8860dd3e7..46e3c03cc8 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -260,4 +260,7 @@ config XLNX_ZYNQ_DDRC
 config AXIADO_CLK
     bool
 
+config K230_DECOMP_GZIP
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index cbeecbf1e0..54e07aacda 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
+system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_decomp_gzip.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 2d6d2238c5..16db4ba0cc 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -443,8 +443,6 @@ iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actu
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
 
-# vmlaunchupdate.c
-launch_update_write(void) ""
-vmlaunch_reset_enter(void) ""
-vm_launchupdate_finalize(void) ""
-restore_host_x86_igvm(void) ""
+# k230_decomp_gzip.c
+k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
+k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 663a66bded..84756ba823 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -300,7 +300,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
   (config_all_devices.has_key('CONFIG_K230') ?
-   ['k230-ddr-test', 'k230-wdt-test'] : [])
+   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test'] : [])
 
 qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
 
-- 
2.54.0


