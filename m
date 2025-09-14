Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E066CAC594
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 13:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxmIZ-0004bv-C9; Sun, 14 Sep 2025 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509141246493afec731d3000207c2-KEw2AH@rts-flowmailer.siemens.com>)
 id 1uxmIE-0004Wc-Cv
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:23 -0400
Received: from mta-64-226.siemens.flowmailer.net ([185.136.64.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509141246493afec731d3000207c2-KEw2AH@rts-flowmailer.siemens.com>)
 id 1uxmI0-0002Na-8x
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:21 -0400
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202509141246493afec731d3000207c2 for <qemu-devel@nongnu.org>;
 Sun, 14 Sep 2025 14:46:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9hvqbXXknAWKoD8HDVYgVeJRmyNtPk4inrajVRBMyzE=;
 b=pb51RhGsROqeszWyFpAVSojI+r7BqxPT3+Bidi5cFdfa+XmzeK0b/ihM6F2T13Dj0qSvSb
 27pJRPyA7fLOPjy0E84sZjf7YJu4eRrl8BKyj5hLqCEyRkWk0lX6VanEQWDdo7+mpPb6wE+k
 yue63kA9QSo1uacNWdaMyQOhMQfR4moe2JuPlofE+aIJ5qctPU/MFJk06AbOUuhSYfPL9b+v
 I5qCmcbvcHiKc6jH0gyoM0hmnKsdtmbJwpzYp43XpZvsWWapOYAobCjMPAtZRMmGW3jWhtjy
 /ZjQLek9qJhmzmeax0e6rBh5WUXS2iHM0rI9J0VswqY9btTwaKVxMEOQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 4/6] hw/sd/sdcard: Handle RPMB MAC field
Date: Sun, 14 Sep 2025 14:46:44 +0200
Message-ID: <826132eea90f9381f7ed1646a8cb2b21a1e7dc7a.1757854006.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757854006.git.jan.kiszka@siemens.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.226;
 envelope-from=fm-294854-202509141246493afec731d3000207c2-KEw2AH@rts-flowmailer.siemens.com;
 helo=mta-64-226.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Implement correct setting of the MAC field when passing RPMB frames back
to the guest. Also check the MAC on authenticated write requests.

This depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256 which is
always available via glib - assert this, just to be safe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f7e41512a1..0656d7a374 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -51,6 +51,7 @@
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
+#include "crypto/hmac.h"
 
 //#define DEBUG_SD 1
 
@@ -118,6 +119,7 @@ typedef struct SDProto {
 } SDProto;
 
 #define RPMB_KEY_MAC_LEN    32
+#define RPMB_HASH_LEN       284
 
 typedef struct {
     uint8_t stuff_bytes[196];
@@ -1120,6 +1122,66 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
+static bool rpmb_calc_hmac(SDState *sd, RPMBDataFrame *frame,
+                           unsigned int num_blocks, uint8_t *mac)
+{
+    size_t mac_len = RPMB_KEY_MAC_LEN;
+    bool success = true;
+    Error *err = NULL;
+    QCryptoHmac *hmac;
+    uint64_t addr;
+
+    hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALGO_SHA256, sd->rpmb_key,
+                            RPMB_KEY_MAC_LEN, &err);
+    if (!hmac) {
+        error_report_err(err);
+        return false;
+    }
+
+    /*
+     * This implies a read request because we only support single-block write
+     * requests so far.
+     */
+    if (num_blocks > 1) {
+        /*
+         * Unfortunately, the underlying crypto libraries do not allow us to
+         * migrate an active QCryptoHmac state. Therefore, we have to calculate
+         * the HMAC in one run. To avoid buffering a complete read sequence in
+         * SDState, reconstruct all frames except for the last one.
+         */
+        char *buf = (char *)sd->data;
+
+        memcpy(buf, frame->data, RPMB_HASH_LEN);
+        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
+        do {
+            if (blk_pread(sd->blk, addr, 256, buf, 0) < 0) {
+                fprintf(stderr, "sd_blk_read: read error on host side\n");
+                success = false;
+                break;
+            }
+            if (qcrypto_hmac_bytes(hmac, buf, RPMB_HASH_LEN, NULL, NULL,
+                                   &err) < 0) {
+                error_report_err(err);
+                success = false;
+                break;
+            }
+            addr += 256;
+        } while (--num_blocks > 1);
+    }
+
+    if (success &&
+        qcrypto_hmac_bytes(hmac, (const char*)frame->data, RPMB_HASH_LEN, &mac,
+                           &mac_len, &err) < 0) {
+        error_report_err(err);
+        success = false;
+    }
+    assert(!success || mac_len == RPMB_KEY_MAC_LEN);
+
+    qcrypto_hmac_free(hmac);
+
+    return success;
+}
+
 static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
@@ -1142,6 +1204,17 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
             sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_READ_FAILURE |
                 (result & RPMB_RESULT_COUTER_EXPIRED));
         }
+        if (sd->multi_blk_cnt == 1 &&
+            !rpmb_calc_hmac(sd, &sd->rpmb_result,
+                            be16_to_cpu(sd->rpmb_result.block_count),
+                            sd->rpmb_result.key_mac)) {
+            memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
+        }
+    } else if (!rpmb_calc_hmac(sd, &sd->rpmb_result, 1,
+                               sd->rpmb_result.key_mac)) {
+        memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
+        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
     }
     memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
 
@@ -1153,6 +1226,7 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
     uint16_t req = be16_to_cpu(frame->req_resp);
+    uint8_t mac[RPMB_KEY_MAC_LEN];
 
     if (req == RPMB_REQ_READ_RESULT) {
         /* just return the current result register */
@@ -1190,6 +1264,11 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
             sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
             break;
         }
+        if (!rpmb_calc_hmac(sd, frame, 1, mac) ||
+            memcmp(frame->key_mac, mac, RPMB_KEY_MAC_LEN) != 0) {
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
+            break;
+        }
         if (be32_to_cpu(frame->write_counter) != sd->rpmb_write_counter) {
             sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
             break;
@@ -3114,6 +3193,8 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
 
+    assert(qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256));
+
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-- 
2.51.0


