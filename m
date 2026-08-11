Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF09C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPD-0005c0-7d; Tue, 11 Aug 2026 12:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOh-0005K8-Im
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOf-0000zu-EU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5i8fAqmvBOs5CSe7JCfox0Xx51je6cRjK3GGRkRNLk=;
 b=gtTVi7DNnGmhsEYTwzilNM/3s7jKUvYEjUReYbNfOnGAzxrFROAwmJAZqIEpnxJ9v6Nf7y
 y1R3/43JwelW2GEhtzi0Pr14IA1kuuZboN7v2sHFQSm7WwQb3oAGWCNWIkKJTE/yPxXc+G
 N90znXQGl125kEKpcoSYNOVUdryR/VY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-k7rh2HDjOW2Rt71L524KfA-1; Tue,
 11 Aug 2026 12:32:09 -0400
X-MC-Unique: k7rh2HDjOW2Rt71L524KfA-1
X-Mimecast-MFC-AGG-ID: k7rh2HDjOW2Rt71L524KfA_1786465928
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AC8E1800148; Tue, 11 Aug 2026 16:32:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96FB8195DF91; Tue, 11 Aug 2026 16:32:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 68/83] hw/misc/aspeed_hace: Support the crypto command in
 direct access mode
Date: Tue, 11 Aug 2026 18:29:23 +0200
Message-ID: <20260811162938.1403216-69-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The crypt command register was previously stubbed out. Implement it for
the direct access mode, where HACE00/HACE04 point directly at contiguous
source and destination buffers. AES-128/192/256, DES and 3DES are
supported in ECB and CBC modes via the qcrypto cipher API; the IV and
key are read from the context buffer (HACE08) and, for CBC, the
resulting chaining IV is written back to the context.

The completion interrupt is now raised for every HACE variant as the
hardware does, which fixes the crypt command hang on the AST2500, AST2600
and AST1030. The AST2700 crypto engine still needs 64-bit DMA and
AES-GCM, which are added later, so it keeps its temporary interrupt-only
workaround until then.

For debugging, the context, source and destination buffers are dumped
through the existing aspeed_hace_hexdump trace event (disabled by
default). CTR mode, scatter-gather mode and AES-GCM are added separately.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 283 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 268 insertions(+), 15 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index c61efe50c4ff..0f35d74137b1 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -18,11 +18,43 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "crypto/hash.h"
+#include "crypto/cipher.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
 #include "trace.h"
 
-#define R_CRYPT_CMD     (0x10 / 4)
+/* Crypto engine registers */
+#define R_CRYPT_SRC         (0x00 / 4)
+#define R_CRYPT_DEST        (0x04 / 4)
+#define R_CRYPT_CONTEXT     (0x08 / 4)
+#define R_CRYPT_DATA_LEN    (0x0c / 4)
+/* HACE0C[27:0] holds the crypto data length */
+#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF
+#define R_CRYPT_CMD         (0x10 / 4)
+/* Crypto engine command register (HACE10) bits */
+#define  CRYPT_CMD_ENCRYPT          BIT(7)
+#define  CRYPT_CMD_ISR_EN           BIT(12)
+#define  CRYPT_CMD_DES_SELECT       BIT(16)
+#define  CRYPT_CMD_TRIPLE_DES       BIT(17)
+#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)
+/* Operation mode HACE10[6:4] */
+#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)
+#define  CRYPT_CMD_ECB              (0x0 << 4)
+#define  CRYPT_CMD_CBC              (0x1 << 4)
+/* AES key length HACE10[3:2] */
+#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
+#define  CRYPT_CMD_AES256           (0x2 << 2)
+#define  CRYPT_CMD_AES192           (0x1 << 2)
+#define  CRYPT_CMD_AES128           (0x0 << 2)
+
+/*
+ * Crypto context buffer layout (HACE08). The IV is at the start of the buffer
+ * (DES places its 8 byte IV at offset 8) and the cipher key at offset 0x10.
+ */
+#define CRYPT_CTX_IV_OFFSET         0x00
+#define CRYPT_CTX_DES_IV_OFFSET     0x08
+#define CRYPT_CTX_KEY_OFFSET        0x10
+#define CRYPT_CTX_SIZE              0x30
 
 #define R_STATUS        (0x1c / 4)
 #define HASH_IRQ        BIT(9)
@@ -65,7 +97,6 @@
 /* Other cmd bits */
 #define  HASH_IRQ_EN                    BIT(9)
 #define  HASH_SG_EN                     BIT(18)
-#define  CRYPT_IRQ_EN                   BIT(12)
 /* Scatter-gather data list */
 #define SG_LIST_LEN_SIZE                4
 #define SG_LIST_LEN_MASK                0x0FFFFFFF
@@ -501,6 +532,216 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
     }
 }
 
+static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg, size_t *keylen)
+{
+    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {
+    case CRYPT_CMD_AES128:
+        *alg = QCRYPTO_CIPHER_ALGO_AES_128;
+        *keylen = 16;
+        break;
+    case CRYPT_CMD_AES192:
+        *alg = QCRYPTO_CIPHER_ALGO_AES_192;
+        *keylen = 24;
+        break;
+    case CRYPT_CMD_AES256:
+        *alg = QCRYPTO_CIPHER_ALGO_AES_256;
+        *keylen = 32;
+        break;
+    default:
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * Decode the crypto command register into a libqcrypto algorithm/mode pair
+ * and the block/IV geometry. Returns false for unsupported selections.
+ */
+static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,
+                             QCryptoCipherMode *mode, size_t *keylen,
+                             size_t *blocklen, size_t *iv_offset)
+{
+    if (cmd & CRYPT_CMD_DES_SELECT) {
+        *blocklen = 8;
+        *iv_offset = CRYPT_CTX_DES_IV_OFFSET;
+        if (cmd & CRYPT_CMD_TRIPLE_DES) {
+            *alg = QCRYPTO_CIPHER_ALGO_3DES;
+            *keylen = 24;
+        } else {
+            *alg = QCRYPTO_CIPHER_ALGO_DES;
+            *keylen = 8;
+        }
+    } else {
+        *blocklen = 16;
+        *iv_offset = CRYPT_CTX_IV_OFFSET;
+        if (!crypt_aes_alg(cmd, alg, keylen)) {
+            return false;
+        }
+    }
+
+    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {
+    case CRYPT_CMD_ECB:
+        *mode = QCRYPTO_CIPHER_MODE_ECB;
+        break;
+    case CRYPT_CMD_CBC:
+        *mode = QCRYPTO_CIPHER_MODE_CBC;
+        break;
+    default:
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * Direct access mode: the source/destination register (HACE00/HACE04) points
+ * at a single contiguous buffer in DRAM. Copy @len bytes between it and the
+ * bounce buffer @buf; when @to_dram is true @buf is written out, otherwise it
+ * is read in. Returns true on success.
+ */
+static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,
+                                 uint8_t *buf, uint32_t len, bool to_dram)
+{
+    return !address_space_rw(&s->dram_as, addr, MEMTXATTRS_UNSPECIFIED,
+                             buf, len, to_dram);
+}
+
+/*
+ * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the source
+ * and destination are single contiguous buffers (HACE00/HACE04) and the IV/key
+ * come from the context buffer (HACE08). For CBC the resulting chaining IV is
+ * written back to the context buffer so the driver can continue the chain.
+ */
+static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
+{
+    uint32_t len = s->regs[R_CRYPT_DATA_LEN];
+    bool encrypt = cmd & CRYPT_CMD_ENCRYPT;
+    g_autoptr(QCryptoCipher) cipher = NULL;
+    g_autofree uint8_t *src_buf = NULL;
+    g_autofree uint8_t *dst_buf = NULL;
+    uint8_t ctx[CRYPT_CTX_SIZE];
+    Error *local_err = NULL;
+    QCryptoCipherMode mode;
+    QCryptoCipherAlgo alg;
+    const uint8_t *next_iv;
+    uint64_t ctx_addr;
+    uint64_t src_addr;
+    uint64_t dst_addr;
+    size_t iv_offset;
+    size_t blocklen;
+    size_t keylen;
+
+    if (len == 0) {
+        return;
+    }
+
+    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen, &iv_offset)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Unsupported crypt command 0x%x\n", __func__, cmd);
+        return;
+    }
+
+    if (!qcrypto_cipher_supports(alg, mode)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: cipher mode not supported by the crypto backend\n",
+                      __func__);
+        return;
+    }
+
+    /* Fetch the IV and key from the context buffer in DRAM. */
+    ctx_addr = s->regs[R_CRYPT_CONTEXT];
+    if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,
+                           ctx, sizeof(ctx))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to read context, addr=0x%" HWADDR_PRIx "\n",
+                      __func__, ctx_addr);
+        return;
+    }
+
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {
+        hace_hexdump("context", (char *)ctx, sizeof(ctx));
+    }
+
+    cipher = qcrypto_cipher_new(alg, mode, ctx + CRYPT_CTX_KEY_OFFSET, keylen,
+                                &local_err);
+    if (cipher == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new failed: %s\n",
+                      __func__, error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    if (mode != QCRYPTO_CIPHER_MODE_ECB &&
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,
+                             &local_err) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %s\n",
+                      __func__, error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    src_buf = g_malloc0(len);
+    dst_buf = g_malloc0(len);
+
+    src_addr = s->regs[R_CRYPT_SRC];
+    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to read src, addr=0x%" HWADDR_PRIx "\n",
+                      __func__, src_addr);
+        return;
+    }
+
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {
+        hace_hexdump("src", (char *)src_buf, len);
+    }
+
+    if (encrypt) {
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,
+                                   &local_err) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",
+                          __func__, error_get_pretty(local_err));
+            error_free(local_err);
+            return;
+        }
+    } else {
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,
+                                   &local_err) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",
+                          __func__, error_get_pretty(local_err));
+            error_free(local_err);
+            return;
+        }
+    }
+
+    dst_addr = s->regs[R_CRYPT_DEST];
+    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to write dst, addr=0x%" HWADDR_PRIx "\n",
+                      __func__, dst_addr);
+        return;
+    }
+
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {
+        hace_hexdump("dst", (char *)dst_buf, len);
+    }
+
+    if (mode == QCRYPTO_CIPHER_MODE_CBC) {
+        /*
+         * CBC chains on the last ciphertext block: the final block of the
+         * output when encrypting, or of the input when decrypting. Write it
+         * back as the IV for the next request.
+         */
+        next_iv = (encrypt ? dst_buf : src_buf) + len - blocklen;
+        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,
+                                MEMTXATTRS_UNSPECIFIED, next_iv, blocklen)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Failed to write IV, addr=0x%" HWADDR_PRIx "\n",
+                          __func__, ctx_addr + iv_offset);
+        }
+    }
+}
+
 static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedHACEState *s = ASPEED_HACE(opaque);
@@ -531,16 +772,22 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
                 qemu_irq_lower(s->irq);
             }
         }
-        if (ahc->raise_crypt_interrupt_workaround) {
-            if (data & CRYPT_IRQ) {
-                data &= ~CRYPT_IRQ;
+        if (data & CRYPT_IRQ) {
+            data &= ~CRYPT_IRQ;
 
-                if (s->regs[addr] & CRYPT_IRQ) {
-                    qemu_irq_lower(s->irq);
-                }
+            if (s->regs[addr] & CRYPT_IRQ) {
+                qemu_irq_lower(s->irq);
             }
         }
         break;
+    case R_CRYPT_SRC:
+    case R_CRYPT_DEST:
+    case R_CRYPT_CONTEXT:
+        data &= ahc->src_mask;
+        break;
+    case R_CRYPT_DATA_LEN:
+        data &= CRYPT_DATA_LEN_MASK;
+        break;
     case R_HASH_SRC:
         data &= ahc->src_mask;
         break;
@@ -589,13 +836,19 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     }
     case R_CRYPT_CMD:
-        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not implemented\n",
-                       __func__);
-        if (ahc->raise_crypt_interrupt_workaround) {
-            s->regs[R_STATUS] |= CRYPT_IRQ;
-            if (data & CRYPT_IRQ_EN) {
-                qemu_irq_raise(s->irq);
-            }
+        /*
+         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which are
+         * added later; until then it keeps the temporary workaround of only
+         * raising the completion interrupt without running the command.
+         */
+        if (!ahc->raise_crypt_interrupt_workaround) {
+            do_crypt_operation(s, data);
+        }
+
+        /* Hardware raises the crypt interrupt once the command finishes. */
+        s->regs[R_STATUS] |= CRYPT_IRQ;
+        if (data & CRYPT_CMD_ISR_EN) {
+            qemu_irq_raise(s->irq);
         }
         break;
     case R_HASH_SRC_HI:
-- 
2.55.0


