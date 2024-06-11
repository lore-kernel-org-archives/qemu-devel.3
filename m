Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1254C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5R0-0000CI-6D; Tue, 11 Jun 2024 13:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qy-0000Bs-2p
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qv-0008VT-Hx
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718127441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcRdTc4kHZtT5Qcayg+eHXjNJM4Q40Gt/VxgdWyG7ks=;
 b=GY0PVxJQ+09Q3KhxaGIJ2Nq/MpUvE03wYUmjR+8B/s1f4eJBQBOGv5kOYCw7mNMcrPRSbR
 oQb/BRjywHst0tMVoHziUGLUZVRJn5ejEmASRTOUVtWHHqSn5qxmRCr43DId31BekX51TY
 95QMMqyHA1MS/ItqFM8LZgM8vAAz7Ng=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-ej_3CoUqNCyAR6EyAQPnfQ-1; Tue,
 11 Jun 2024 13:37:19 -0400
X-MC-Unique: ej_3CoUqNCyAR6EyAQPnfQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 687181955F30; Tue, 11 Jun 2024 17:37:18 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.130])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3999819560AB; Tue, 11 Jun 2024 17:37:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 7/8] block/crypto: create ciphers on demand
Date: Tue, 11 Jun 2024 19:36:57 +0200
Message-ID: <20240611173658.231831-8-kwolf@redhat.com>
In-Reply-To: <20240611173658.231831-1-kwolf@redhat.com>
References: <20240611173658.231831-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Ciphers are pre-allocated by qcrypto_block_init_cipher() depending on
the given number of threads. The -device
virtio-blk-pci,iothread-vq-mapping= feature allows users to assign
multiple IOThreads to a virtio-blk device, but the association between
the virtio-blk device and the block driver happens after the block
driver is already open.

When the number of threads given to qcrypto_block_init_cipher() is
smaller than the actual number of threads at runtime, the
block->n_free_ciphers > 0 assertion in qcrypto_block_pop_cipher() can
fail.

Get rid of qcrypto_block_init_cipher() n_thread's argument and allocate
ciphers on demand.

Reported-by: Qing Wang <qinwang@redhat.com>
Buglink: https://issues.redhat.com/browse/RHEL-36159
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240527155851.892885-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 crypto/blockpriv.h  |  12 +++--
 crypto/block-luks.c |   3 +-
 crypto/block-qcow.c |   2 +-
 crypto/block.c      | 111 ++++++++++++++++++++++++++------------------
 4 files changed, 78 insertions(+), 50 deletions(-)

diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 836f3b4726..4bf6043d5d 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -32,8 +32,14 @@ struct QCryptoBlock {
     const QCryptoBlockDriver *driver;
     void *opaque;
 
-    QCryptoCipher **ciphers;
-    size_t n_ciphers;
+    /* Cipher parameters */
+    QCryptoCipherAlgorithm alg;
+    QCryptoCipherMode mode;
+    uint8_t *key;
+    size_t nkey;
+
+    QCryptoCipher **free_ciphers;
+    size_t max_free_ciphers;
     size_t n_free_ciphers;
     QCryptoIVGen *ivgen;
     QemuMutex mutex;
@@ -130,7 +136,7 @@ int qcrypto_block_init_cipher(QCryptoBlock *block,
                               QCryptoCipherAlgorithm alg,
                               QCryptoCipherMode mode,
                               const uint8_t *key, size_t nkey,
-                              size_t n_threads, Error **errp);
+                              Error **errp);
 
 void qcrypto_block_free_cipher(QCryptoBlock *block);
 
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 3ee928fb5a..3357852c0a 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1262,7 +1262,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                       luks->cipher_mode,
                                       masterkey,
                                       luks->header.master_key_len,
-                                      n_threads,
                                       errp) < 0) {
             goto fail;
         }
@@ -1456,7 +1455,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     /* Setup the block device payload encryption objects */
     if (qcrypto_block_init_cipher(block, luks_opts.cipher_alg,
                                   luks_opts.cipher_mode, masterkey,
-                                  luks->header.master_key_len, 1, errp) < 0) {
+                                  luks->header.master_key_len, errp) < 0) {
         goto error;
     }
 
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 4d7cf36a8f..02305058e3 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -75,7 +75,7 @@ qcrypto_block_qcow_init(QCryptoBlock *block,
     ret = qcrypto_block_init_cipher(block, QCRYPTO_CIPHER_ALG_AES_128,
                                     QCRYPTO_CIPHER_MODE_CBC,
                                     keybuf, G_N_ELEMENTS(keybuf),
-                                    n_threads, errp);
+                                    errp);
     if (ret < 0) {
         ret = -ENOTSUP;
         goto fail;
diff --git a/crypto/block.c b/crypto/block.c
index 506ea1d1a3..ba6d1cebc7 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/lockable.h"
 #include "blockpriv.h"
 #include "block-qcow.h"
 #include "block-luks.h"
@@ -57,6 +58,8 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
 {
     QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
+    qemu_mutex_init(&block->mutex);
+
     block->format = options->format;
 
     if (options->format >= G_N_ELEMENTS(qcrypto_block_drivers) ||
@@ -76,8 +79,6 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
         return NULL;
     }
 
-    qemu_mutex_init(&block->mutex);
-
     return block;
 }
 
@@ -92,6 +93,8 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
 {
     QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
+    qemu_mutex_init(&block->mutex);
+
     block->format = options->format;
 
     if (options->format >= G_N_ELEMENTS(qcrypto_block_drivers) ||
@@ -111,8 +114,6 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
         return NULL;
     }
 
-    qemu_mutex_init(&block->mutex);
-
     return block;
 }
 
@@ -227,37 +228,42 @@ QCryptoCipher *qcrypto_block_get_cipher(QCryptoBlock *block)
      * This function is used only in test with one thread (it's safe to skip
      * pop/push interface), so it's enough to assert it here:
      */
-    assert(block->n_ciphers <= 1);
-    return block->ciphers ? block->ciphers[0] : NULL;
+    assert(block->max_free_ciphers <= 1);
+    return block->free_ciphers ? block->free_ciphers[0] : NULL;
 }
 
 
-static QCryptoCipher *qcrypto_block_pop_cipher(QCryptoBlock *block)
+static QCryptoCipher *qcrypto_block_pop_cipher(QCryptoBlock *block,
+                                               Error **errp)
 {
-    QCryptoCipher *cipher;
-
-    qemu_mutex_lock(&block->mutex);
-
-    assert(block->n_free_ciphers > 0);
-    block->n_free_ciphers--;
-    cipher = block->ciphers[block->n_free_ciphers];
-
-    qemu_mutex_unlock(&block->mutex);
+    /* Usually there is a free cipher available */
+    WITH_QEMU_LOCK_GUARD(&block->mutex) {
+        if (block->n_free_ciphers > 0) {
+            block->n_free_ciphers--;
+            return block->free_ciphers[block->n_free_ciphers];
+        }
+    }
 
-    return cipher;
+    /* Otherwise allocate a new cipher */
+    return qcrypto_cipher_new(block->alg, block->mode, block->key,
+                              block->nkey, errp);
 }
 
 
 static void qcrypto_block_push_cipher(QCryptoBlock *block,
                                       QCryptoCipher *cipher)
 {
-    qemu_mutex_lock(&block->mutex);
+    QEMU_LOCK_GUARD(&block->mutex);
 
-    assert(block->n_free_ciphers < block->n_ciphers);
-    block->ciphers[block->n_free_ciphers] = cipher;
-    block->n_free_ciphers++;
+    if (block->n_free_ciphers == block->max_free_ciphers) {
+        block->max_free_ciphers++;
+        block->free_ciphers = g_renew(QCryptoCipher *,
+                                      block->free_ciphers,
+                                      block->max_free_ciphers);
+    }
 
-    qemu_mutex_unlock(&block->mutex);
+    block->free_ciphers[block->n_free_ciphers] = cipher;
+    block->n_free_ciphers++;
 }
 
 
@@ -265,24 +271,31 @@ int qcrypto_block_init_cipher(QCryptoBlock *block,
                               QCryptoCipherAlgorithm alg,
                               QCryptoCipherMode mode,
                               const uint8_t *key, size_t nkey,
-                              size_t n_threads, Error **errp)
+                              Error **errp)
 {
-    size_t i;
+    QCryptoCipher *cipher;
 
-    assert(!block->ciphers && !block->n_ciphers && !block->n_free_ciphers);
+    assert(!block->free_ciphers && !block->max_free_ciphers &&
+           !block->n_free_ciphers);
 
-    block->ciphers = g_new0(QCryptoCipher *, n_threads);
+    /* Stash away cipher parameters for qcrypto_block_pop_cipher() */
+    block->alg = alg;
+    block->mode = mode;
+    block->key = g_memdup2(key, nkey);
+    block->nkey = nkey;
 
-    for (i = 0; i < n_threads; i++) {
-        block->ciphers[i] = qcrypto_cipher_new(alg, mode, key, nkey, errp);
-        if (!block->ciphers[i]) {
-            qcrypto_block_free_cipher(block);
-            return -1;
-        }
-        block->n_ciphers++;
-        block->n_free_ciphers++;
+    /*
+     * Create a new cipher to validate the parameters now. This reduces the
+     * chance of cipher creation failing at I/O time.
+     */
+    cipher = qcrypto_block_pop_cipher(block, errp);
+    if (!cipher) {
+        g_free(block->key);
+        block->key = NULL;
+        return -1;
     }
 
+    qcrypto_block_push_cipher(block, cipher);
     return 0;
 }
 
@@ -291,19 +304,23 @@ void qcrypto_block_free_cipher(QCryptoBlock *block)
 {
     size_t i;
 
-    if (!block->ciphers) {
+    g_free(block->key);
+    block->key = NULL;
+
+    if (!block->free_ciphers) {
         return;
     }
 
-    assert(block->n_ciphers == block->n_free_ciphers);
+    /* All popped ciphers were eventually pushed back */
+    assert(block->n_free_ciphers == block->max_free_ciphers);
 
-    for (i = 0; i < block->n_ciphers; i++) {
-        qcrypto_cipher_free(block->ciphers[i]);
+    for (i = 0; i < block->max_free_ciphers; i++) {
+        qcrypto_cipher_free(block->free_ciphers[i]);
     }
 
-    g_free(block->ciphers);
-    block->ciphers = NULL;
-    block->n_ciphers = block->n_free_ciphers = 0;
+    g_free(block->free_ciphers);
+    block->free_ciphers = NULL;
+    block->max_free_ciphers = block->n_free_ciphers = 0;
 }
 
 QCryptoIVGen *qcrypto_block_get_ivgen(QCryptoBlock *block)
@@ -311,7 +328,7 @@ QCryptoIVGen *qcrypto_block_get_ivgen(QCryptoBlock *block)
     /* ivgen should be accessed under mutex. However, this function is used only
      * in test with one thread, so it's enough to assert it here:
      */
-    assert(block->n_ciphers <= 1);
+    assert(block->max_free_ciphers <= 1);
     return block->ivgen;
 }
 
@@ -446,7 +463,10 @@ int qcrypto_block_decrypt_helper(QCryptoBlock *block,
                                  Error **errp)
 {
     int ret;
-    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block);
+    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block, errp);
+    if (!cipher) {
+        return -1;
+    }
 
     ret = do_qcrypto_block_cipher_encdec(cipher, block->niv, block->ivgen,
                                          &block->mutex, sectorsize, offset, buf,
@@ -465,7 +485,10 @@ int qcrypto_block_encrypt_helper(QCryptoBlock *block,
                                  Error **errp)
 {
     int ret;
-    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block);
+    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block, errp);
+    if (!cipher) {
+        return -1;
+    }
 
     ret = do_qcrypto_block_cipher_encdec(cipher, block->niv, block->ivgen,
                                          &block->mutex, sectorsize, offset, buf,
-- 
2.45.2


