Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAABC79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOw-0003ih-GV; Sun, 06 Sep 2026 13:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOd-0003dG-8x
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOX-00007v-FZ
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rELTl1L6dhOx4ewh1dRu0iQeFA8YDJRonHYIrCsAfTY=;
 b=ErKWuzWWNMYVGs7ymQP10PM3ciONMSRNmLxUUGR8h4thRc/yVRTTGE+z4hK7a/8+WdsFBD
 yiz/M12Rei2jsncBcXYNJtVlk/GGXybzgaTXj0kx2+7DXMPlkjEE84rQgL7ctzma4qzEwQ
 Ftq0Bmmtk/jPWvIJuAQIdU885JdBewE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-XC8-27wgOim04848gKRYgw-1; Sun,
 06 Sep 2026 13:10:52 -0400
X-MC-Unique: XC8-27wgOim04848gKRYgw-1
X-Mimecast-MFC-AGG-ID: XC8-27wgOim04848gKRYgw_1788714645
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C68111954239; Sun,  6 Sep 2026 17:10:45 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60D6A1955F06; Sun,  6 Sep 2026 17:10:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/40] hw/misc/aspeed_acry: Add ASPEED ACRY model
Date: Sun,  6 Sep 2026 19:09:49 +0200
Message-ID: <20260906171021.26568-9-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce a ASPEED ACRY model, which performs RSA modular
exponentiation. The datasheet documents the engine as
supporting both RSA and ECDSA, but ECDSA is broken on this
hardware, so only RSA is modelled.

The engine DMAs its operands (data, exponent, modulus) from a guest
DRAM buffer and writes the result back into a memory-mapped SRAM
region. Both regions share the same interleaved byte/dword layout:
repeating 12-dword blocks of [4 dwords exponent][4 dwords modulus][4
dwords data], index 0 holding the least-significant word/byte of each
value.

The engine accesses DRAM by relative offset, so the CPU-visible
address written to the DMA source register has its top (base) bit
masked off.

The modular exponentiation itself is delegated to QEMU's generic
akcipher crypto API (crypto/akcipher.c) using raw (unpadded) RSA,
matching what the real hardware performs - PKCS1 padding is handled
by the guest's software crypto stack, not by this engine.

The RSA public-key operand DER encoding needed by that API is built with
crypto/der.h's generic encoder. Raw (unpadded) RSA is only implemented
by that API's libgcrypt backend (its nettle backend rejects raw
padding).

When that support is missing, the engine still completes and raises its
completion IRQ as real hardware would, but produces an all-zero result
so that whatever signature check the guest performs on it fails cleanly
instead of the guest hanging forever waiting for an interrupt that
would otherwise never come.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901081531.898176-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_acry.h |  39 +++
 hw/misc/aspeed_acry.c         | 481 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 hw/misc/trace-events          |   6 +
 4 files changed, 527 insertions(+)
 create mode 100644 include/hw/misc/aspeed_acry.h
 create mode 100644 hw/misc/aspeed_acry.c

diff --git a/include/hw/misc/aspeed_acry.h b/include/hw/misc/aspeed_acry.h
new file mode 100644
index 000000000000..5ca80deec4d1
--- /dev/null
+++ b/include/hw/misc/aspeed_acry.h
@@ -0,0 +1,39 @@
+/*
+ * ASPEED ACRY Engine
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_ACRY_H
+#define ASPEED_ACRY_H
+
+#include "hw/core/sysbus.h"
+#include "system/memory.h"
+
+#define TYPE_ASPEED_ACRY "aspeed.acry"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedACRYState, ASPEED_ACRY)
+
+#define ASPEED_ACRY_NR_REGS     (0x400 >> 2)
+/* Max size of the "data" (message) field within the SRAM buffer. */
+#define ASPEED_ACRY_DATA_MAX_LEN 0x800
+#define ASPEED_ACRY_MAX_BITS     4096
+/* Max exponent/modulus size for a 4096-bit RSA key, in bytes. */
+#define ASPEED_ACRY_MAX_BYTES    (ASPEED_ACRY_MAX_BITS / 8)
+
+struct AspeedACRYState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t regs[ASPEED_ACRY_NR_REGS];
+
+    MemoryRegion *dram_mr;
+    MemoryRegion *sram_mr;
+    AddressSpace dram_as;
+    AddressSpace sram_as;
+};
+
+#endif /* ASPEED_ACRY_H */
diff --git a/hw/misc/aspeed_acry.c b/hw/misc/aspeed_acry.c
new file mode 100644
index 000000000000..41eac7295fd7
--- /dev/null
+++ b/hw/misc/aspeed_acry.c
@@ -0,0 +1,481 @@
+/*
+ * ASPEED ACRY Engine
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The datasheet documents the ACRY engine as supporting both RSA and
+ * ECDSA, but ECDSA is broken on this hardware, so only RSA is modelled
+ * here.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "hw/misc/aspeed_acry.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "qapi/error.h"
+#include "crypto/akcipher.h"
+#include "crypto/der.h"
+#include "trace.h"
+
+REG32(ACRY_TRIGGER, 0x000)
+    FIELD(ACRY_TRIGGER, RSA_START, 0, 1)
+REG32(ACRY_DMA_SRC, 0x04C)
+REG32(ACRY_DMA_LEN, 0x050)
+    FIELD(ACRY_DMA_LEN, DATALEN, 0, 16)
+REG32(ACRY_INT_MASK, 0x3F8)
+    FIELD(ACRY_INT_MASK, RSA_DMA_MASK, 2, 1)
+    FIELD(ACRY_INT_MASK, RSA_ENG_MASK, 1, 1)
+REG32(ACRY_STATUS, 0x3FC)
+    FIELD(ACRY_STATUS, RSA_DMA_DONE, 2, 1)
+    FIELD(ACRY_STATUS, RSA_ENG_DONE, 1, 1)
+
+/*
+ * Total size of the interleaved buffer. Data is 4 of every 12
+ * dwords of a block, one third of the buffer, so the whole buffer is 3x
+ * the data region.
+ */
+#define ASPEED_ACRY_SRAM_SIZE   (3 * ASPEED_ACRY_DATA_MAX_LEN)
+
+#define ASPEED_ACRY_BYTES_PER_DWORD  4
+#define ASPEED_ACRY_LANES_PER_BLOCK  4
+/* Each block holds 3 regions (exp, mod, data) of LANES_PER_BLOCK dwords. */
+#define ASPEED_ACRY_DWORDS_PER_BLOCK (3 * ASPEED_ACRY_LANES_PER_BLOCK)
+
+/* Dwords into each block where each operand's region starts. */
+#define ASPEED_ACRY_EXP_OFFSET   (0 * ASPEED_ACRY_LANES_PER_BLOCK)
+#define ASPEED_ACRY_MOD_OFFSET   (1 * ASPEED_ACRY_LANES_PER_BLOCK)
+#define ASPEED_ACRY_DATA_OFFSET  (2 * ASPEED_ACRY_LANES_PER_BLOCK)
+
+static void aspeed_acry_hexdump(const char *desc, const uint8_t *buf,
+                                size_t size)
+{
+    g_autoptr(GString) str = g_string_sized_new(64);
+    size_t len;
+    size_t i;
+
+    for (i = 0; i < size; i += len) {
+        len = MIN(16, size - i);
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, buf + i, len, 1, 4);
+        trace_aspeed_acry_hexdump(desc, i, str->str);
+    }
+}
+
+/*
+ * The interleaved buffer is a series of 12-dword blocks, each split into
+ * three 4-dword regions - exp, mod, data:
+ *
+ *   dword in block:  0    1    2    3    4    5    6    7    8    9   10   11
+ *   region:          \---- exp ----/    \---- mod ----/    \---- data ----/
+ *   lane:            0    1    2    3    0    1    2    3    0    1    2    3
+ *
+ * Successive blocks hold the next 4 dwords of each operand, so operand
+ * dword d is in block (d / 4), lane (d % 4). Dwords are little-endian, so
+ * byte b of dword D is at byte D * 4 + b.
+ *
+ * Return the buffer offset of byte 'op_byte' (op_byte = 0 = least
+ * significant) of the operand whose region starts 'region' dwords into
+ * each block (0 = exp, 4 = mod, 8 = data).
+ */
+static int aspeed_acry_operand_offset(int region, int op_byte)
+{
+    int byte_in_dword;
+    int op_dword;
+    int offset;
+    int block;
+    int lane;
+
+    op_dword = op_byte / ASPEED_ACRY_BYTES_PER_DWORD;
+    byte_in_dword = op_byte % ASPEED_ACRY_BYTES_PER_DWORD;
+    block = op_dword / ASPEED_ACRY_LANES_PER_BLOCK;
+    lane = op_dword % ASPEED_ACRY_LANES_PER_BLOCK;
+
+    offset = (block * ASPEED_ACRY_DWORDS_PER_BLOCK + region + lane)
+             * ASPEED_ACRY_BYTES_PER_DWORD + byte_in_dword;
+    assert(offset < ASPEED_ACRY_SRAM_SIZE);
+
+    return offset;
+}
+
+/*
+ * Read one operand out of the buffer as a big-endian magnitude.
+ *
+ * The operand's bytes are scattered through buf; byte k (significance level
+ * k, k = 0 = least significant) is at aspeed_acry_operand_offset(region, k).
+ * Walk from the top down, drop leading zero bytes, and write the result most
+ * significant byte first into out[]. Returns the number of bytes written
+ * (the value 0 yields a single 0x00 byte, so always >= 1).
+ */
+static int aspeed_acry_extract_be(const uint8_t *buf, int region,
+                                  int max_bytes, uint8_t *out)
+{
+    int offset;
+    int msb;
+    int len;
+    int k;
+
+    /* Highest significance level holding a non-zero byte (skip leading 0s). */
+    for (msb = max_bytes - 1; msb >= 0; msb--) {
+        offset = aspeed_acry_operand_offset(region, msb);
+        if (buf[offset] != 0) {
+            break;
+        }
+    }
+
+    /* All bytes zero: the value is 0. */
+    if (msb < 0) {
+        out[0] = 0;
+        return 1;
+    }
+
+    /* Copy most significant byte first: level msb down to level 0. */
+    len = 0;
+    for (k = msb; k >= 0; k--) {
+        offset = aspeed_acry_operand_offset(region, k);
+        out[len++] = buf[offset];
+    }
+
+    return len;
+}
+
+/*
+ * Return a DER INTEGER body for the unsigned big-endian magnitude 'be'.
+ *
+ * DER INTEGERs are signed, so if the top byte has bit 7 set the value
+ * would decode as negative; prepend a 0x00 guard byte in that case.
+ *
+ * The padded copy is written into 'pad_buf' (caller-owned, sized len + 1)
+ * rather than a local, because qcrypto_der_encode_int() only stores the
+ * pointer we hand it - the bytes are not copied until
+ * qcrypto_der_encode_ctx_flush_and_free() - so the body must stay valid
+ * until then. Returns a pointer into 'be' or 'pad_buf' as appropriate,
+ * with the body length in *body_len.
+ */
+static const uint8_t *aspeed_acry_der_uint_body(const uint8_t *be, size_t len,
+                                                uint8_t *pad_buf,
+                                                size_t *body_len)
+{
+    if (be[0] & 0x80) {
+        pad_buf[0] = 0x00;
+        memcpy(pad_buf + 1, be, len);
+        *body_len = len + 1;
+        return pad_buf;
+    }
+
+    *body_len = len;
+    return be;
+}
+
+/*
+ * DER-encode a "RsaPubKey ::= SEQUENCE { n INTEGER, e INTEGER }" (see
+ * crypto/rsakey.h), the format expected by qcrypto_akcipher_new(). n and e
+ * are minimal big-endian magnitudes (as produced by
+ * aspeed_acry_extract_be()); the engine does a raw modexp, so the guest's
+ * exponent is always encoded here as the public 'e'.
+ */
+static uint8_t *aspeed_acry_der_encode_pubkey(const uint8_t *n, size_t n_len,
+                                              const uint8_t *e, size_t e_len,
+                                              size_t *out_len)
+{
+    QCryptoEncodeContext *ctx = qcrypto_der_encode_ctx_new();
+    uint8_t n_pad[ASPEED_ACRY_MAX_BYTES + 1];
+    uint8_t e_pad[ASPEED_ACRY_MAX_BYTES + 1];
+    const uint8_t *n_body;
+    const uint8_t *e_body;
+    size_t n_body_len;
+    size_t e_body_len;
+    uint8_t *buf;
+
+    n_body = aspeed_acry_der_uint_body(n, n_len, n_pad, &n_body_len);
+    e_body = aspeed_acry_der_uint_body(e, e_len, e_pad, &e_body_len);
+
+    qcrypto_der_encode_seq_begin(ctx);
+    qcrypto_der_encode_int(ctx, n_body, n_body_len);
+    qcrypto_der_encode_int(ctx, e_body, e_body_len);
+    qcrypto_der_encode_seq_end(ctx);
+
+    *out_len = qcrypto_der_encode_ctx_buffer_len(ctx);
+    buf = g_malloc(*out_len);
+    qcrypto_der_encode_ctx_flush_and_free(ctx, buf);
+
+    return buf;
+}
+
+/*
+ * Store the RSA result into the output SRAM data region as 'n_len' bytes
+ * (the key size): the low 'result_len' bytes are result_be (big-endian),
+ * the rest is zero. sram_as is a 0-based AddressSpace over the SRAM, so the
+ * offset from aspeed_acry_operand_offset() is used directly; each data dword
+ * is written as a little-endian word.
+ */
+static bool aspeed_acry_store_result(AspeedACRYState *s,
+                                     const uint8_t *result_be,
+                                     int result_len, int n_len, Error **errp)
+{
+    uint32_t result_word;
+    MemTxResult res;
+    int offset;
+    int src;
+    int i;
+    int j;
+
+    /* result_be is MSB-first; take bytes from its LSB end. */
+    src = result_len - 1;
+    for (i = 0; i < n_len / ASPEED_ACRY_BYTES_PER_DWORD; i++) {
+        /* Pack up to 4 result bytes (LSB first) into a little-endian dword. */
+        result_word = 0;
+        for (j = 0; j < ASPEED_ACRY_BYTES_PER_DWORD; j++) {
+            if (src >= 0) {
+                result_word |= (uint32_t)result_be[src--] << (8 * j);
+            }
+        }
+
+        offset = aspeed_acry_operand_offset(ASPEED_ACRY_DATA_OFFSET,
+                                            ASPEED_ACRY_BYTES_PER_DWORD * i);
+        address_space_stl_le(&s->sram_as, offset, result_word,
+                             MEMTXATTRS_UNSPECIFIED, &res);
+        if (res != MEMTX_OK) {
+            error_setg(errp, "failed to write result to SRAM");
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static void aspeed_acry_clear_result(AspeedACRYState *s)
+{
+    MemTxResult res;
+    int offset;
+    int i;
+
+    for (i = 0; i < ASPEED_ACRY_MAX_BYTES / ASPEED_ACRY_BYTES_PER_DWORD; i++) {
+        offset = aspeed_acry_operand_offset(ASPEED_ACRY_DATA_OFFSET,
+                                            ASPEED_ACRY_BYTES_PER_DWORD * i);
+        address_space_stl_le(&s->sram_as, offset, 0,
+                             MEMTXATTRS_UNSPECIFIED, &res);
+        if (res != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to clear result\n",
+                          __func__);
+            return;
+        }
+    }
+}
+
+static bool aspeed_acry_do_rsa(AspeedACRYState *s, Error **errp)
+{
+    QCryptoAkCipherOptions opts = {
+        .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
+        .u.rsa = {
+            .padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW,
+        },
+    };
+    uint32_t len = FIELD_EX32(s->regs[R_ACRY_DMA_LEN], ACRY_DMA_LEN, DATALEN);
+    g_autofree uint8_t *src_buf = g_malloc0(ASPEED_ACRY_SRAM_SIZE);
+    g_autofree uint8_t *data = g_malloc0(ASPEED_ACRY_DATA_MAX_LEN);
+    uint8_t result[ASPEED_ACRY_MAX_BYTES] = { 0 };
+    uint64_t src_addr = s->regs[R_ACRY_DMA_SRC];
+    g_autofree uint8_t *der_key = NULL;
+    uint8_t n[ASPEED_ACRY_MAX_BYTES];
+    uint8_t e[ASPEED_ACRY_MAX_BYTES];
+    QCryptoAkCipher *cipher = NULL;
+    int result_len = 0;
+    size_t der_len;
+    int data_len;
+    int n_len;
+    int e_len;
+
+    if (!qcrypto_akcipher_supports(&opts)) {
+        error_setg(errp, "RSA ModExp not supported by the crypto backend");
+        return false;
+    }
+
+    if (len == 0 || len > ASPEED_ACRY_SRAM_SIZE) {
+        error_setg(errp, "invalid DMA length %u", len);
+        return false;
+    }
+
+    trace_aspeed_acry_rsa_trigger(src_addr, len);
+
+    if (address_space_read(&s->dram_as, src_addr, MEMTXATTRS_UNSPECIFIED,
+                           src_buf, len) != MEMTX_OK) {
+        error_setg(errp, "failed to read DMA buffer at 0x%" PRIx64, src_addr);
+        return false;
+    }
+
+    n_len = aspeed_acry_extract_be(src_buf, ASPEED_ACRY_MOD_OFFSET,
+                                   ASPEED_ACRY_MAX_BYTES, n);
+    e_len = aspeed_acry_extract_be(src_buf, ASPEED_ACRY_EXP_OFFSET,
+                                   ASPEED_ACRY_MAX_BYTES, e);
+    data_len = aspeed_acry_extract_be(src_buf, ASPEED_ACRY_DATA_OFFSET,
+                                      ASPEED_ACRY_DATA_MAX_LEN, data);
+
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {
+        aspeed_acry_hexdump("buf", src_buf, len);
+        aspeed_acry_hexdump("n", n, n_len);
+        aspeed_acry_hexdump("e", e, e_len);
+        aspeed_acry_hexdump("data", data, data_len);
+    }
+
+    der_key = aspeed_acry_der_encode_pubkey(n, n_len, e, e_len, &der_len);
+    cipher = qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
+                                  der_key, der_len, errp);
+    if (!cipher) {
+        error_prepend(errp, "failed to create RSA cipher: ");
+        return false;
+    }
+
+    result_len = qcrypto_akcipher_encrypt(cipher, data, data_len,
+                                          result, sizeof(result), errp);
+    qcrypto_akcipher_free(cipher);
+    if (result_len < 0) {
+        error_prepend(errp, "RSA modexp failed: ");
+        return false;
+    }
+
+    if (!aspeed_acry_store_result(s, result, result_len, n_len, errp)) {
+        return false;
+    }
+
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {
+        aspeed_acry_hexdump("result", result, result_len);
+    }
+
+    return true;
+}
+
+static uint64_t aspeed_acry_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    AspeedACRYState *s = ASPEED_ACRY(opaque);
+    uint32_t reg = offset >> 2;
+
+    trace_aspeed_acry_read(offset, s->regs[reg]);
+
+    return s->regs[reg];
+}
+
+static void aspeed_acry_write(void *opaque, hwaddr offset, uint64_t data,
+                              unsigned int size)
+{
+    AspeedACRYState *s = ASPEED_ACRY(opaque);
+    uint32_t reg = offset >> 2;
+    Error *local_err = NULL;
+
+    trace_aspeed_acry_write(offset, data);
+
+    switch (reg) {
+    case R_ACRY_DMA_SRC:
+        /*
+         * The DMA source register holds a CPU-visible DRAM address (e.g.
+         * 0x8xxxxxxx on AST2600); the engine addresses DRAM from offset 0,
+         * so mask off the top bit to get the DRAM-relative offset.
+         */
+        data &= 0x7FFFFFFF;
+        break;
+    case R_ACRY_STATUS:
+        data = s->regs[R_ACRY_STATUS] & ~data;
+        if (!(data & (R_ACRY_STATUS_RSA_ENG_DONE_MASK |
+                      R_ACRY_STATUS_RSA_DMA_DONE_MASK))) {
+            qemu_irq_lower(s->irq);
+        }
+        break;
+    case R_ACRY_TRIGGER:
+        if (FIELD_EX32(data, ACRY_TRIGGER, RSA_START)) {
+            if (!aspeed_acry_do_rsa(s, &local_err)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: %s\n", __func__,
+                              error_get_pretty(local_err));
+                error_free(local_err);
+                aspeed_acry_clear_result(s);
+            }
+
+            s->regs[R_ACRY_STATUS] |= R_ACRY_STATUS_RSA_ENG_DONE_MASK |
+                                      R_ACRY_STATUS_RSA_DMA_DONE_MASK;
+            if (s->regs[R_ACRY_INT_MASK] &
+                (R_ACRY_INT_MASK_RSA_ENG_MASK_MASK |
+                 R_ACRY_INT_MASK_RSA_DMA_MASK_MASK)) {
+                qemu_irq_raise(s->irq);
+            }
+        }
+        break;
+    default:
+        break;
+    }
+
+    s->regs[reg] = data;
+}
+
+static const MemoryRegionOps aspeed_acry_ops = {
+    .read = aspeed_acry_read,
+    .write = aspeed_acry_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_acry_reset_hold(Object *obj, ResetType type)
+{
+    AspeedACRYState *s = ASPEED_ACRY(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void aspeed_acry_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedACRYState *s = ASPEED_ACRY(dev);
+
+    if (!s->dram_mr) {
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'dram' link not set");
+        return;
+    }
+
+    if (!s->sram_mr) {
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'sram' link not set");
+        return;
+    }
+
+    address_space_init(&s->dram_as, s->dram_mr, "dram");
+    address_space_init(&s->sram_as, s->sram_mr, "sram");
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_acry_ops, s,
+                          TYPE_ASPEED_ACRY, ASPEED_ACRY_NR_REGS << 2);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static const Property aspeed_acry_properties[] = {
+    DEFINE_PROP_LINK("dram", AspeedACRYState, dram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_LINK("sram", AspeedACRYState, sram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static void aspeed_acry_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->desc = "ASPEED ACRY Engine";
+    dc->realize = aspeed_acry_realize;
+    rc->phases.hold = aspeed_acry_reset_hold;
+    device_class_set_props(dc, aspeed_acry_properties);
+}
+
+static const TypeInfo aspeed_acry_types[] = {
+    {
+        .name = TYPE_ASPEED_ACRY,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedACRYState),
+        .class_init = aspeed_acry_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_acry_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 54e07aacda1d..9790afa1044f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -139,6 +139,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+  'aspeed_acry.c',
   'aspeed_hace.c',
   'aspeed_lpc.c',
   'aspeed_ltpi.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0b8be3d0f226..0053de29ade5 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -331,6 +331,12 @@ aspeed_peci_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%"
 aspeed_peci_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_peci_raise_interrupt(uint32_t ctrl, uint32_t status) "ctrl 0x%" PRIx32 " status 0x%" PRIx32
 
+# aspeed_acry.c
+aspeed_acry_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_acry_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_acry_rsa_trigger(uint64_t src_addr, uint32_t len) "src_addr 0x%" PRIx64 " len 0x%" PRIx32
+aspeed_acry_hexdump(const char *desc, uint32_t offset, const char *s) "%s: 0x%08x: %s"
+
 # aspeed_hace.c
 aspeed_hace_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
-- 
2.55.0


