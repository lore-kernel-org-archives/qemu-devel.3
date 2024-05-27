Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10A1C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBckk-0005rB-1x; Mon, 27 May 2024 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBcki-0005pt-5Q
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBcke-0007Yi-Ky
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716825548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkZeoONnHelc7TbdUriioLuLewq8fWIEJyE/oTn1ZVY=;
 b=fL66rE9NjY4+tMQpr6Bpsv1h4X9CfLA7AX4rIFYo2onR8lM7an9m75Ykfo4CaQUPCdEsZA
 C9cGIMfWiG98+vs5iKRbt2j1amNSuowivonNoW4kVH+n7Vir+5DUk+YlUe6VnKBDHuGjD6
 qupjnaACxSNA1d39eJgi8yHU/khAd+0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-50H8FlcyOXSlDOWhTtKBaQ-1; Mon,
 27 May 2024 11:59:04 -0400
X-MC-Unique: 50H8FlcyOXSlDOWhTtKBaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68D7B1C0512D;
 Mon, 27 May 2024 15:59:04 +0000 (UTC)
Received: from localhost (unknown [10.39.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CDDE200A610;
 Mon, 27 May 2024 15:59:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Qing Wang <qinwang@redhat.com>
Subject: [PATCH 1/2] block/crypto: create ciphers on demand
Date: Mon, 27 May 2024 11:58:50 -0400
Message-ID: <20240527155851.892885-2-stefanha@redhat.com>
In-Reply-To: <20240527155851.892885-1-stefanha@redhat.com>
References: <20240527155851.892885-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 crypto/blockpriv.h  |  12 +++--
 crypto/block-luks.c |   3 +-
 crypto/block-qcow.c |   2 +-
 crypto/block.c      | 113 ++++++++++++++++++++++++++------------------
 4 files changed, 79 insertions(+), 51 deletions(-)

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
-
-    return cipher;
+    /* Usually there is a free cipher available */
+    WITH_QEMU_LOCK_GUARD(&block->mutex) {
+        if (block->n_free_ciphers > 0) {
+            block->n_free_ciphers--;
+            return block->free_ciphers[block->n_free_ciphers];
+        }
+    }
+
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
+    if (block->n_free_ciphers == block->max_free_ciphers) {
+        block->max_free_ciphers++;
+        block->free_ciphers = g_renew(QCryptoCipher *,
+                                      block->free_ciphers,
+                                      block->max_free_ciphers);
+    }
+
+    block->free_ciphers[block->n_free_ciphers] = cipher;
     block->n_free_ciphers++;
-
-    qemu_mutex_unlock(&block->mutex);
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
2.45.1


