Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BB5D690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcIq-0000fQ-G9; Thu, 28 Nov 2024 06:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1tGcIh-0000dx-Mt; Thu, 28 Nov 2024 06:03:12 -0500
Received: from smtpnm6-12.21cn.com ([182.42.119.59] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>)
 id 1tGcId-0003Al-DT; Thu, 28 Nov 2024 06:03:11 -0500
HMM_SOURCE_IP: 192.168.137.232:0.1841577584
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-139.200.108.9 (unknown [192.168.137.232])
 by chinatelecom.cn (HERMES) with SMTP id 8B651110001B3;
 Thu, 28 Nov 2024 18:53:30 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([139.200.108.9])
 by gateway-ssl-dep-6977f57994-b9pvf with ESMTP id
 e2d79c8f05d146fd81dec2eac2d5e3ae for eblake@redhat.com; 
 Thu, 28 Nov 2024 18:53:33 CST
X-Transaction-ID: e2d79c8f05d146fd81dec2eac2d5e3ae
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 139.200.108.9
X-MEDUSA-Status: 0
From: tugy@chinatelecom.cn
To: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	tugy@chinatelecom.cn
Subject: [PATCH 1/2] crpyto: support encryt and decrypt parallelly using
 thread pool
Date: Thu, 28 Nov 2024 18:51:21 +0800
Message-Id: <7fea2c563ffafa2128fb5af07e98c8fa1aca9441.1732789721.git.tugy@chinatelecom.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1732789721.git.tugy@chinatelecom.cn>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
In-Reply-To: <cover.1732789721.git.tugy@chinatelecom.cn>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
Received-SPF: pass client-ip=182.42.119.59; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Guoyi Tu <tugy@chinatelecom.cn>

Currently, disk I/O encryption and decryption operations are performed sequentially
in the main thread or IOthread. When the number of I/O requests increases,
this becomes a performance bottleneck.

To address this issue, this patch using the thread pool to perform I/O encryption
and decryption in parallel to improving overall efficiency.

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
---
 block/crypto.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 6 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 80b2dba17a..c085f331ce 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -22,6 +22,7 @@
 
 #include "block/block_int.h"
 #include "block/qdict.h"
+#include "block/thread-pool.h"
 #include "sysemu/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
@@ -40,6 +41,7 @@ struct BlockCrypto {
     QCryptoBlock *block;
     bool updating_keys;
     BdrvChild *header;  /* Reference to the detached LUKS header */
+    bool encrypt_in_parallel;
 };
 
 
@@ -460,6 +462,94 @@ static int block_crypto_reopen_prepare(BDRVReopenState *state,
     return 0;
 }
 
+
+typedef struct CryptoAIOData {
+    QCryptoBlock *block;
+    uint64_t offset;
+    uint8_t *buf;
+    size_t len;
+    bool encrypt;
+    Error **errp;
+} CryptoAIOData;
+
+
+static int handle_aiocb_encdec(void *opaque)
+{
+    CryptoAIOData *aiocb = opaque;
+
+    if (aiocb->encrypt) {
+        if (qcrypto_block_encrypt(aiocb->block, aiocb->offset,
+                                  aiocb->buf, aiocb->len, aiocb->errp) < 0) {
+            return -EIO;
+        }
+    } else {
+        if (qcrypto_block_decrypt(aiocb->block, aiocb->offset,
+                                  aiocb->buf, aiocb->len, aiocb->errp) < 0) {
+            return -EIO;
+        }
+    }
+
+    return 0;
+}
+
+
+static int coroutine_fn block_crypto_submit_co(BlockDriverState *bs, uint64_t offset,
+                                               uint8_t *buf, size_t len, bool encrypt,
+                                               Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    CryptoAIOData acb;
+
+    acb = (CryptoAIOData) {
+        .block = crypto->block,
+        .offset = offset,
+        .buf = buf,
+        .len = len,
+        .encrypt = encrypt,
+        .errp = errp,
+    };
+    return thread_pool_submit_co(handle_aiocb_encdec, &acb);
+}
+
+
+static int coroutine_fn GRAPH_RDLOCK
+block_crypto_encrypt(BlockDriverState *bs, uint64_t offset,
+                     uint8_t *buf, size_t len, Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    int ret = 0;
+
+    if (crypto->encrypt_in_parallel) {
+        ret = block_crypto_submit_co(bs, offset, buf, len, true, errp);
+    } else {
+        if (qcrypto_block_encrypt(crypto->block, offset, buf, len, errp) < 0) {
+            ret = -EIO;
+        }
+    }
+
+    return ret;
+}
+
+
+static int coroutine_fn GRAPH_RDLOCK
+block_crypto_decrypt(BlockDriverState *bs, uint64_t offset,
+                     uint8_t *buf, size_t len, Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    int ret = 0;
+
+    if (crypto->encrypt_in_parallel) {
+        ret = block_crypto_submit_co(bs, offset, buf, len, false, errp);
+    } else {
+        if (qcrypto_block_decrypt(crypto->block, offset, buf, len, errp) < 0) {
+            ret = -EIO;
+        }
+    }
+
+    return ret;
+}
+
+
 /*
  * 1 MB bounce buffer gives good performance / memory tradeoff
  * when using cache=none|directsync.
@@ -508,9 +598,10 @@ block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
             goto cleanup;
         }
 
-        if (qcrypto_block_decrypt(crypto->block, offset + bytes_done,
-                                  cipher_data, cur_bytes, NULL) < 0) {
-            ret = -EIO;
+        ret = block_crypto_decrypt(bs, offset + bytes_done,
+                                   cipher_data, cur_bytes, NULL);
+
+        if (ret < 0) {
             goto cleanup;
         }
 
@@ -565,9 +656,9 @@ block_crypto_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
         qemu_iovec_to_buf(qiov, bytes_done, cipher_data, cur_bytes);
 
-        if (qcrypto_block_encrypt(crypto->block, offset + bytes_done,
-                                  cipher_data, cur_bytes, NULL) < 0) {
-            ret = -EIO;
+        ret = block_crypto_encrypt(bs, offset + bytes_done,
+                                   cipher_data, cur_bytes, NULL);
+        if (ret < 0) {
             goto cleanup;
         }
 
-- 
2.17.1


