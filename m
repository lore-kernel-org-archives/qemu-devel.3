Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA27C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPT-0006NW-7D; Tue, 11 Aug 2026 12:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPC-0005g9-CX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPA-00015n-Ha
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOIiYpEcEVjua90l0i/4yf5V22rbX8J41GaCPa9EA+I=;
 b=dLxgOa1I0Q/XNpOJvAtnHMPC3gifweIULSSBYBL1iLdl2qoO1C3BfmEZMsSFksoqF055eu
 aj88Uqjn1+7Yb+k/A8zccocv1Lzvf6KQJIr9VZXOf/jlh6dIF2P7LK6YRtc9H4GWcVq3nq
 Oy+kt20BtCYDn7LmH3dTAxR4d4IVYZ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-TTvvk7ohNNGFIJ2QuPyQog-1; Tue,
 11 Aug 2026 12:32:39 -0400
X-MC-Unique: TTvvk7ohNNGFIJ2QuPyQog-1
X-Mimecast-MFC-AGG-ID: TTvvk7ohNNGFIJ2QuPyQog_1786465958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0E231956063; Tue, 11 Aug 2026 16:32:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47FBB195DF91; Tue, 11 Aug 2026 16:32:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 81/83] hw/misc/aspeed_hace: Support the AES-GCM mode for the
 crypto command
Date: Tue, 11 Aug 2026 18:29:36 +0200
Message-ID: <20260811162938.1403216-82-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement the AES-GCM mode (HACE10[6:4] = 0b101) used by the AST2700
crypto engine: decode the GCM selection, read the 96-bit IV from the
context buffer, operate on the exact data length (GCM handles a partial
final block itself), and write the 128-bit authentication tag to the tag
buffer (HACE18/HACE8C). The hardware GCM path is only used without
associated data (the driver falls back to software otherwise), so AAD is
not modelled and a non-zero HACE14 is reported as unimplemented.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-15-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 70 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 0a6e2fa82914..23dacc9be85e 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -31,6 +31,9 @@
 /* HACE0C[27:0] holds the crypto data length */
 #define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF
 #define R_CRYPT_CMD         (0x10 / 4)
+/* AES-GCM associated data length (HACE14) and tag write buffer (HACE18) */
+#define R_CRYPT_GCM_ADD_LEN (0x14 / 4)
+#define R_CRYPT_GCM_TAG     (0x18 / 4)
 /* Crypto engine command register (HACE10) bits */
 #define  CRYPT_CMD_ENCRYPT          BIT(7)
 #define  CRYPT_CMD_ISR_EN           BIT(12)
@@ -42,6 +45,7 @@
 #define  CRYPT_CMD_ECB              (0x0 << 4)
 #define  CRYPT_CMD_CBC              (0x1 << 4)
 #define  CRYPT_CMD_CTR              (0x4 << 4)
+#define  CRYPT_CMD_GCM              (0x5 << 4)
 /* AES key length HACE10[3:2] */
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
 #define  CRYPT_CMD_AES256           (0x2 << 2)
@@ -57,10 +61,15 @@
 #define CRYPT_CTX_KEY_OFFSET        0x10
 #define CRYPT_CTX_SIZE              0x30
 
+/* AES-GCM uses a 96-bit IV and a 128-bit authentication tag */
+#define CRYPT_GCM_IV_LEN            12
+#define CRYPT_GCM_TAG_LEN           16
+
 /* AST2700 64-bit DMA high address registers for the crypto command */
 #define R_CRYPT_SRC_HI      (0x80 / 4)
 #define R_CRYPT_DEST_HI     (0x84 / 4)
 #define R_CRYPT_CONTEXT_HI  (0x88 / 4)
+#define R_CRYPT_GCM_TAG_HI  (0x8c / 4)
 
 #define R_STATUS        (0x1c / 4)
 #define HASH_IRQ        BIT(9)
@@ -596,6 +605,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,
     case CRYPT_CMD_CTR:
         *mode = QCRYPTO_CIPHER_MODE_CTR;
         break;
+    case CRYPT_CMD_GCM:
+        *mode = QCRYPTO_CIPHER_MODE_GCM;
+        break;
     default:
         return false;
     }
@@ -689,11 +701,12 @@ static uint64_t crypt_get_addr(AspeedHACEState *s, int reg, int reg_hi)
 }
 
 /*
- * Perform an AES/DES/3DES ECB/CBC operation. The source and destination are
- * either single contiguous buffers (direct access mode) or scatter-gather
- * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come from
- * the context buffer (HACE08). For CBC the resulting chaining IV is written
- * back to the context buffer so the driver can continue the chain.
+ * Perform an AES/DES/3DES ECB/CBC/CTR or AES-GCM operation. The source and
+ * destination are either single contiguous buffers (direct access mode) or
+ * scatter-gather lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the
+ * IV/key come from the context buffer (HACE08). For CBC and CTR the resulting
+ * chaining state is written back to the context buffer so the driver can
+ * continue; for GCM the authentication tag is written to the tag buffer.
  */
 static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
 {
@@ -703,6 +716,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     g_autoptr(QCryptoCipher) cipher = NULL;
     g_autofree uint8_t *src_buf = NULL;
     g_autofree uint8_t *dst_buf = NULL;
+    uint8_t tag[CRYPT_GCM_TAG_LEN];
     uint8_t ctx[CRYPT_CTX_SIZE];
     Error *local_err = NULL;
     QCryptoCipherMode mode;
@@ -711,10 +725,13 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     uint64_t ctx_addr;
     uint64_t src_addr;
     uint64_t dst_addr;
+    uint64_t tag_addr;
+    uint32_t aad_len;
     size_t iv_offset;
     size_t blocklen;
     size_t buf_len;
     size_t keylen;
+    size_t ivlen;
     bool status;
 
     if (len == 0) {
@@ -734,6 +751,20 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
         return;
     }
 
+    /* GCM uses a 96-bit IV; the block modes use a full-block IV. */
+    ivlen = (mode == QCRYPTO_CIPHER_MODE_GCM) ? CRYPT_GCM_IV_LEN : blocklen;
+
+    /*
+     * The hardware GCM path is only exercised without associated data (the
+     * driver falls back to software when there is any), so AAD is not modelled.
+     */
+    aad_len = s->regs[R_CRYPT_GCM_ADD_LEN];
+    if (mode == QCRYPTO_CIPHER_MODE_GCM && aad_len != 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: GCM associated data is not implemented\n", __func__);
+        return;
+    }
+
     /* Fetch the IV and key from the context buffer in DRAM. */
     ctx_addr = crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);
     if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,
@@ -758,7 +789,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     }
 
     if (mode != QCRYPTO_CIPHER_MODE_ECB &&
-        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, ivlen,
                              &local_err) < 0) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %s\n",
                       __func__, error_get_pretty(local_err));
@@ -769,9 +800,11 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     /*
      * Round the working buffers up to a whole block. Block modes are already
      * block-aligned; the stream-like CTR mode may leave a partial final block
-     * that the engine still processes a full block at a time.
+     * that the engine still processes a full block at a time. GCM handles a
+     * partial final block itself, so it operates on the exact length.
      */
-    buf_len = QEMU_ALIGN_UP(len, blocklen);
+    buf_len = (mode == QCRYPTO_CIPHER_MODE_GCM) ?
+              len : QEMU_ALIGN_UP(len, blocklen);
     src_buf = g_malloc0(buf_len);
     dst_buf = g_malloc0(buf_len);
 
@@ -855,6 +888,24 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
                           "%s: Failed to write IV, addr=0x%" HWADDR_PRIx "\n",
                           __func__, ctx_addr + iv_offset);
         }
+    } else if (mode == QCRYPTO_CIPHER_MODE_GCM) {
+        /*
+         * GCM authenticates the message and writes the resulting tag to the
+         * dedicated tag buffer (HACE18/HACE8C).
+         */
+        if (qcrypto_cipher_gettag(cipher, tag, sizeof(tag), &local_err) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher gettag failed: "
+                          "%s\n", __func__, error_get_pretty(local_err));
+            error_free(local_err);
+            return;
+        }
+        tag_addr = crypt_get_addr(s, R_CRYPT_GCM_TAG, R_CRYPT_GCM_TAG_HI);
+        if (address_space_write(&s->dram_as, tag_addr, MEMTXATTRS_UNSPECIFIED,
+                                tag, sizeof(tag))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Failed to write tag, addr=0x%" HWADDR_PRIx "\n",
+                          __func__, tag_addr);
+        }
     }
 }
 
@@ -899,9 +950,11 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
     case R_CRYPT_SRC:
     case R_CRYPT_DEST:
     case R_CRYPT_CONTEXT:
+    case R_CRYPT_GCM_TAG:
         data &= ahc->src_mask;
         break;
     case R_CRYPT_DATA_LEN:
+    case R_CRYPT_GCM_ADD_LEN:
         data &= CRYPT_DATA_LEN_MASK;
         break;
     case R_HASH_SRC:
@@ -980,6 +1033,7 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
         data &= ahc->src_hi_mask;
         break;
     case R_CRYPT_DEST_HI:
+    case R_CRYPT_GCM_TAG_HI:
         data &= ahc->dest_hi_mask;
         break;
     case R_CRYPT_CONTEXT_HI:
-- 
2.55.0


