Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083F7C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTgN-0003ms-Mm; Thu, 15 May 2025 04:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTft-0003Ia-2N; Thu, 15 May 2025 04:10:41 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTfq-00011Y-Sj; Thu, 15 May 2025 04:10:40 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 May
 2025 16:10:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 May 2025 16:10:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 08/28] hw/misc/aspeed_hace: Extract accumulation-mode hash
 execution into helper function
Date: Thu, 15 May 2025 16:09:40 +0800
Message-ID: <20250515081008.583578-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
References: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To improve code readability and maintainability of do_hash_operation(), this
commit introduces a new helper function: hash_execute_acc_mode().

This function encapsulates the full flow for accumulation mode, including
context initialization, update, conditional finalization, and digest writeback
with I/O vector unmapping.

No functional changes are introduced.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_hace.c | 74 ++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index c50e228cdf..33e13974fe 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -267,26 +267,57 @@ static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
     hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
 }
 
-static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
-                              bool acc_mode)
+static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
+                                  struct iovec *iov, int iov_idx,
+                                  bool final_request)
 {
     g_autofree uint8_t *digest_buf = NULL;
-    struct iovec iov[ASPEED_HACE_MAX_SG];
-    bool acc_final_request = false;
     Error *local_err = NULL;
     size_t digest_len = 0;
-    int iov_idx = -1;
 
-    if (acc_mode && s->hash_ctx == NULL) {
+    if (s->hash_ctx == NULL) {
         s->hash_ctx = qcrypto_hash_new(algo, &local_err);
         if (s->hash_ctx == NULL) {
-            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash failed : %s",
-                          error_get_pretty(local_err));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash new failed : %s",
+                          __func__, error_get_pretty(local_err));
             error_free(local_err);
             return;
         }
     }
 
+    if (qcrypto_hash_updatev(s->hash_ctx, iov, iov_idx, &local_err) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash updatev failed : %s",
+                      __func__, error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    if (final_request) {
+        if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
+                                        &digest_len, &local_err)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: qcrypto hash finalize bytes failed : %s",
+                          __func__, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+        }
+
+        qcrypto_hash_free(s->hash_ctx);
+
+        s->hash_ctx = NULL;
+        s->total_req_len = 0;
+    }
+
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
+}
+
+static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
+                              bool acc_mode)
+{
+    struct iovec iov[ASPEED_HACE_MAX_SG];
+    bool acc_final_request = false;
+    int iov_idx = -1;
+
     /* Prepares the iov for hashing operations based on the selected mode */
     if (sg_mode) {
         iov_idx = hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_request);
@@ -300,32 +331,9 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
          return;
     }
 
+    /* Executes the hash operation */
     if (acc_mode) {
-        if (qcrypto_hash_updatev(s->hash_ctx, iov, iov_idx, &local_err) < 0) {
-            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash update failed : %s",
-                          error_get_pretty(local_err));
-            error_free(local_err);
-            return;
-        }
-
-        if (acc_final_request) {
-            if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
-                                            &digest_len, &local_err)) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "qcrypto hash finalize failed : %s",
-                              error_get_pretty(local_err));
-                error_free(local_err);
-                local_err = NULL;
-            }
-
-            qcrypto_hash_free(s->hash_ctx);
-
-            s->hash_ctx = NULL;
-            s->total_req_len = 0;
-        }
-
-        hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf,
-                                        digest_len);
+        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);
     } else {
         hash_execute_non_acc_mode(s, algo, iov, iov_idx);
     }
-- 
2.43.0


