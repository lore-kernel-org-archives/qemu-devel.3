Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDE1C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP2-0003sc-NW; Sun, 06 Sep 2026 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOg-0003df-94
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOe-00009o-6H
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1R8/6V/7PQGUxsw8Fn8Fd+h8UxzqEM8z4CLkVbTCV7c=;
 b=DZi7cHxsPfknf97mIfWh2dWybmAQCLmAwLZGnotrMoXn4ChS/iU2J9bCrCNu0RGPzM9yVR
 ExnOIrorB6iy2Fm5V7eq4BPyan1d9tYMiia/1sH4K3xo5nLhT7h/2ec0K+PkFXJTG/QRQ+
 +fdaEzhrd6VerAAsFIS1V1jnJBFmkRM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-AX7N5xSLNymJclDjdcQtWw-1; Sun,
 06 Sep 2026 13:11:10 -0400
X-MC-Unique: AX7N5xSLNymJclDjdcQtWw-1
X-Mimecast-MFC-AGG-ID: AX7N5xSLNymJclDjdcQtWw_1788714669
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 228E21954102; Sun,  6 Sep 2026 17:11:09 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4E0A1955F08; Sun,  6 Sep 2026 17:11:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/40] hw/misc/aspeed_sbc: Support the ECDSA verify command
Date: Sun,  6 Sep 2026 19:10:00 +0200
Message-ID: <20260906171021.26568-20-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The AST10x0 secure boot controller register block also hosts an ECDSA
engine. Emulate its secp384r1 "verify" command: on a trigger write to
the command register, read the public key, signature and SHA-384 digest
that the firmware staged in the SEC SRAM and defer the verification to the
crypto akcipher backend, reporting the result through the status
register.

The model reads its operands from the SEC SRAM through a dedicated
address space, using a 'sram' link. The SEC SRAM is mapped at offset 0
of that address space, so the engine addresses each operand directly
with its SRAM-relative offset.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sbc.c | 141 +++++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |   2 +
 2 files changed, 143 insertions(+)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index f10f7ac578d8..5c193d9086ed 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -10,11 +10,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/misc/aspeed_sbc.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "crypto/akcipher.h"
 #include "trace.h"
 
 #define R_PROT          (0x000 / 4)
@@ -24,8 +26,22 @@
 #define R_CAMP1         (0x020 / 4)
 #define R_CAMP2         (0x024 / 4)
 #define R_QSR           (0x040 / 4)
+#define R_SEC_TRIGGER   (0x0bc / 4)
+
+/*
+ * SEC SRAM layout for a secp384r1 ECDSA verify operation. All operands are
+ * 48-byte big-endian values.
+ */
+#define ECDSA_SRAM_QX   0x2080
+#define ECDSA_SRAM_QY   0x20c0
+#define ECDSA_SRAM_R    0x21c0
+#define ECDSA_SRAM_S    0x2200
+#define ECDSA_SRAM_M    0x2240
+#define ECDSA_P384_COORD_LEN    48
 
 /* R_STATUS */
+#define ECDSA_VERIFY_PASS       BIT(21)
+#define ECDSA_VERIFY_DONE       BIT(20)
 #define ABR_EN                  BIT(14) /* Mirrors SCU510[11] */
 #define ABR_IMAGE_SOURCE        BIT(13)
 #define SPI_ABR_IMAGE_SOURCE    BIT(12)
@@ -42,6 +58,10 @@
 #define OTP_MEM_IDLE            BIT(1)
 #define OTP_COMPARE_STATUS      BIT(0)
 
+/* R_SEC_TRIGGER */
+#define ECDSA_CMD_TRIGGER BIT(1)
+#define RSA_CMD_TRIGGER   BIT(0)
+
 /* QSR */
 #define QSR_RSA_MASK           (0x3 << 12)
 #define QSR_HASH_MASK          (0x3 << 10)
@@ -220,10 +240,111 @@ static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
     s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
 }
 
+static void sbc_ecdsa_hexdump(const char *desc, const char *buf, size_t size)
+{
+    g_autoptr(GString) str = g_string_sized_new(64);
+    size_t len;
+    size_t i;
+
+    for (i = 0; i < size; i += len) {
+        len = MIN(16, size - i);
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, buf + i, len, 1, 4);
+        trace_aspeed_sbc_ecdsa_hexdump(desc, i, str->str);
+    }
+}
+
+/*
+ * The hardware only supports ECDSA secp384r1 (NIST P-384). The firmware has
+ * already staged the public key, signature and digest in the SEC SRAM; read
+ * them out and defer the actual verification to the crypto backend.
+ */
+static bool aspeed_sbc_ecdsa_verify(AspeedSBCState *s)
+{
+    QCryptoAkCipherOptions opts = {
+        .alg = QCRYPTO_AK_CIPHER_ALGO_ECDSA,
+        .u.ecdsa.curve_id = QCRYPTO_CURVE_ID_SECP384R1,
+    };
+    g_autoptr(QCryptoAkCipher) akcipher = NULL;
+    uint8_t pubkey[ECDSA_P384_COORD_LEN * 2];
+    uint8_t sig[ECDSA_P384_COORD_LEN * 2];
+    uint8_t dgst[ECDSA_P384_COORD_LEN];
+    Error *err = NULL;
+
+    if (!qcrypto_akcipher_supports(&opts)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: ECDSA secp384r1 is not supported by the crypto "
+                      "backend\n", __func__);
+        return false;
+    }
+
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QX,
+                           MEMTXATTRS_UNSPECIFIED, pubkey,
+                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to read ECDSA QX from SEC SRAM\n", __func__);
+        return false;
+    }
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QY,
+                           MEMTXATTRS_UNSPECIFIED,
+                           pubkey + ECDSA_P384_COORD_LEN,
+                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to read ECDSA QY from SEC SRAM\n", __func__);
+        return false;
+    }
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_R,
+                           MEMTXATTRS_UNSPECIFIED, sig,
+                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to read ECDSA R from SEC SRAM\n", __func__);
+        return false;
+    }
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_S,
+                           MEMTXATTRS_UNSPECIFIED, sig + ECDSA_P384_COORD_LEN,
+                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to read ECDSA S from SEC SRAM\n", __func__);
+        return false;
+    }
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_M,
+                           MEMTXATTRS_UNSPECIFIED, dgst,
+                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to read ECDSA M from SEC SRAM\n",
+                      __func__);
+        return false;
+    }
+
+    if (trace_event_get_state_backends(TRACE_ASPEED_SBC_ECDSA_HEXDUMP)) {
+        sbc_ecdsa_hexdump("pubkey", (char *)pubkey, sizeof(pubkey));
+        sbc_ecdsa_hexdump("signature", (char *)sig, sizeof(sig));
+        sbc_ecdsa_hexdump("digest", (char *)dgst, sizeof(dgst));
+    }
+
+    akcipher = qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
+                                    pubkey, sizeof(pubkey), &err);
+    if (!akcipher) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s\n", __func__,
+                      error_get_pretty(err));
+        error_free(err);
+        return false;
+    }
+
+    if (qcrypto_akcipher_verify(akcipher, sig, sizeof(sig),
+                                dgst, sizeof(dgst), &err) != 0) {
+        error_free(err);
+        return false;
+    }
+
+    return true;
+}
+
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                               unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(s);
 
     addr >>= 2;
 
@@ -244,6 +365,26 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
     case R_CMD:
         aspeed_sbc_handle_command(opaque, data);
         return;
+    case R_SEC_TRIGGER:
+        if (data & RSA_CMD_TRIGGER) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: RSA is not supported\n", __func__);
+        }
+        if (data & ECDSA_CMD_TRIGGER) {
+            if (!sc->has_ecdsa) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: ECDSA is not supported\n", __func__);
+                return;
+            }
+            s->regs[R_STATUS] &= ~(ECDSA_VERIFY_DONE | ECDSA_VERIFY_PASS);
+            if (aspeed_sbc_ecdsa_verify(s)) {
+                s->regs[R_STATUS] |= ECDSA_VERIFY_PASS;
+            }
+            s->regs[R_STATUS] |= ECDSA_VERIFY_DONE;
+            trace_aspeed_sbc_ecdsa_verify(
+                (s->regs[R_STATUS] & ECDSA_VERIFY_PASS) ? "pass" : "fail");
+        }
+        return;
     default:
         break;
     }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0053de29ade5..6db4934dc585 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -95,6 +95,8 @@ aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%" PRIx32
 aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
 aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr 0x%" PRIx32 " value 0x%" PRIx32
 aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr 0x%" PRIx32 " value 0x%" PRIx32
+aspeed_sbc_ecdsa_verify(const char *result) "ECDSA verify done: %s"
+aspeed_sbc_ecdsa_hexdump(const char *desc, uint32_t offset, const char *s) "%s: 0x%08x: %s"
 
 # aspeed_scu.c
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
-- 
2.55.0


