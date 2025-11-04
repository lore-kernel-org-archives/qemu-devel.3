Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E902CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGrQ-0002sR-Bu; Tue, 04 Nov 2025 08:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202511041303533eeb05fe5500020700-tN64DA@rts-flowmailer.siemens.com>)
 id 1vGGrK-0002q7-Pa
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:02 -0500
Received: from mta-64-226.siemens.flowmailer.net ([185.136.64.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202511041303533eeb05fe5500020700-tN64DA@rts-flowmailer.siemens.com>)
 id 1vGGrG-0005VV-Rf
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:02 -0500
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202511041303533eeb05fe5500020700 for <qemu-devel@nongnu.org>;
 Tue, 04 Nov 2025 14:03:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=65LeBGkfIIfi1HTBLnsw67VOKiKIzyfOPCsCx2gtwJI=;
 b=lkOhyVyDoxDo/Afltpc+RoitISLlz2Nue57uyUsaJzYpRmH1jkYBpdk1tWE2Nb9gRqu4M9
 QvmXCaKEGeqyj68J0NVyEtuCoUvs8x4mgGSgnAP9SegECR9VFgFBYkkVzGX/EDSMGS2Ea0CG
 YfdwFPaefB37dstAyxtYgCv4sawlKibNuBe+CG5N+UCUd1sYdOe9GMim0fOMn/R8++z8doYJ
 Uthb7+XoC5FjGOx7iIVFn6DfrB3CkEU/1efaBXQSVqr+PDkw0uGL2Zz45tzRsLCozWfWn1V9
 dTQW/kgq3kdscBL7Ro5SJqtRBJzyfHUKs3b8sgT792WJqJM5dI8ncWVg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v6 4/6] hw/sd/sdcard: Handle RPMB MAC field
Date: Tue,  4 Nov 2025 14:03:48 +0100
Message-ID: <b6f5698c0ca017871d54834f0c7bd4b4b6316bbd.1762261430.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762261430.git.jan.kiszka@siemens.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.226;
 envelope-from=fm-294854-202511041303533eeb05fe5500020700-tN64DA@rts-flowmailer.siemens.com;
 helo=mta-64-226.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/sd/sd.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cee738be11..61754bf108 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -51,6 +51,7 @@
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
+#include "crypto/hmac.h"
 
 //#define DEBUG_SD 1
 
@@ -121,6 +122,7 @@ typedef struct SDProto {
 #define RPMB_KEY_MAC_LEN    32
 #define RPMB_DATA_LEN       256     /* one RPMB block is half a sector */
 #define RPMB_NONCE_LEN      16
+#define RPMB_HASH_LEN       284
 
 typedef struct QEMU_PACKED {
     uint8_t stuff_bytes[RPMB_STUFF_LEN];
@@ -1128,6 +1130,68 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
+static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
+                           unsigned int num_blocks, uint8_t *mac)
+{
+    g_autoptr(QCryptoHmac) hmac = NULL;
+    size_t mac_len = RPMB_KEY_MAC_LEN;
+    bool success = true;
+    Error *err = NULL;
+    uint64_t offset;
+
+    hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALGO_SHA256, sd->rpmb.key,
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
+        void *buf = sd->data;
+
+        assert(RPMB_HASH_LEN <= sizeof(sd->data));
+
+        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
+               RPMB_HASH_LEN - RPMB_DATA_LEN);
+        offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN +
+            sd_part_offset(sd);
+        do {
+            if (blk_pread(sd->blk, offset, RPMB_DATA_LEN, buf, 0) < 0) {
+                error_report("sd_blk_read: read error on host side");
+                success = false;
+                break;
+            }
+            if (qcrypto_hmac_bytes(hmac, buf, RPMB_HASH_LEN, NULL, NULL,
+                                   &err) < 0) {
+                error_report_err(err);
+                success = false;
+                break;
+            }
+            offset += RPMB_DATA_LEN;
+        } while (--num_blocks > 1);
+    }
+
+    if (success &&
+        qcrypto_hmac_bytes(hmac, frame->data, RPMB_HASH_LEN, &mac,
+                           &mac_len, &err) < 0) {
+        error_report_err(err);
+        success = false;
+    }
+    assert(!success || mac_len == RPMB_KEY_MAC_LEN);
+
+    return success;
+}
+
 static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     uint16_t resp = lduw_be_p(&sd->rpmb.result.req_resp);
@@ -1151,6 +1215,17 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
                      RPMB_RESULT_READ_FAILURE |
                      (result & RPMB_RESULT_COUTER_EXPIRED));
         }
+        if (sd->multi_blk_cnt == 1 &&
+            !rpmb_calc_hmac(sd, &sd->rpmb.result,
+                            lduw_be_p(&sd->rpmb.result.block_count),
+                            sd->rpmb.result.key_mac)) {
+            memset(sd->rpmb.result.data, 0, sizeof(sd->rpmb.result.data));
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_AUTH_FAILURE);
+        }
+    } else if (!rpmb_calc_hmac(sd, &sd->rpmb.result, 1,
+                               sd->rpmb.result.key_mac)) {
+        memset(sd->rpmb.result.data, 0, sizeof(sd->rpmb.result.data));
+        stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_AUTH_FAILURE);
     }
     memcpy(sd->data, &sd->rpmb.result, sizeof(sd->rpmb.result));
 
@@ -1162,6 +1237,7 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
     uint16_t req = lduw_be_p(&frame->req_resp);
+    uint8_t mac[RPMB_KEY_MAC_LEN];
 
     if (req == RPMB_REQ_READ_RESULT) {
         /* just return the current result register */
@@ -1199,6 +1275,11 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
             stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_WRITE_FAILURE);
             break;
         }
+        if (!rpmb_calc_hmac(sd, frame, 1, mac) ||
+            memcmp(frame->key_mac, mac, RPMB_KEY_MAC_LEN) != 0) {
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_AUTH_FAILURE);
+            break;
+        }
         if (ldl_be_p(&frame->write_counter) != sd->rpmb.write_counter) {
             stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_COUNTER_FAILURE);
             break;
@@ -3128,6 +3209,8 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
 
+    assert(qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256));
+
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-- 
2.51.0


