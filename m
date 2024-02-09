Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D81C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVr-0003FN-Ph; Fri, 09 Feb 2024 09:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVp-00039Q-9g
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVn-0004NV-4p
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ol6utk6ZKSy102uzMMxIgtGhjug+Eb/5A5Rg7knA2bs=;
 b=hx02EGEPh4wbJ9Y6xIbnFi2fv8wf7ihwfnLwl9ZVVTdo4MoXMv5iwVrFWdIXWgyjKbCfK1
 7v69sHkvWPbba5TbupZIyrvskXxXcQRs9evMhZU3dVXUL3xMCl1/VjLEvomulKiP7+kSi+
 ctlFihvpfY5DsJcmacM89tUCXHJeNTU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-x15cVBTKOcW_5F7AhCNy7g-1; Fri,
 09 Feb 2024 09:05:46 -0500
X-MC-Unique: x15cVBTKOcW_5F7AhCNy7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A4463C23FD0;
 Fri,  9 Feb 2024 14:05:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF7C8112A1;
 Fri,  9 Feb 2024 14:05:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 13/17] crypto: Modify the qcrypto_block_create to support
 creation flags
Date: Fri,  9 Feb 2024 14:05:01 +0000
Message-ID: <20240209140505.2536635-14-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Expand the signature of qcrypto_block_create to enable the
formation of LUKS volumes with detachable headers. To accomplish
that, introduce QCryptoBlockCreateFlags to instruct the creation
process to set the payload_offset_sector to 0.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/crypto.c                 |  1 +
 block/qcow.c                   |  2 +-
 block/qcow2.c                  |  2 +-
 crypto/block-luks.c            | 28 +++++++++++++++++++++-------
 crypto/block.c                 |  4 +++-
 crypto/blockpriv.h             |  2 ++
 include/crypto/block.h         | 11 +++++++++++
 tests/unit/test-crypto-block.c |  2 ++
 8 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index e87dc84111..1b3f87922a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -369,6 +369,7 @@ block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
                                   block_crypto_create_init_func,
                                   block_crypto_create_write_func,
                                   &data,
+                                  0,
                                   errp);
 
     if (!crypto) {
diff --git a/block/qcow.c b/block/qcow.c
index c6d0e15f1e..ca8e1d5ec8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -885,7 +885,7 @@ qcow_co_create(BlockdevCreateOptions *opts, Error **errp)
         header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
 
         crypto = qcrypto_block_create(qcow_opts->encrypt, "encrypt.",
-                                      NULL, NULL, NULL, errp);
+                                      NULL, NULL, NULL, 0, errp);
         if (!crypto) {
             ret = -EINVAL;
             goto exit;
diff --git a/block/qcow2.c b/block/qcow2.c
index 9bee66fff5..204f5854cf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3216,7 +3216,7 @@ qcow2_set_up_encryption(BlockDriverState *bs,
     crypto = qcrypto_block_create(cryptoopts, "encrypt.",
                                   qcow2_crypto_hdr_init_func,
                                   qcow2_crypto_hdr_write_func,
-                                  bs, errp);
+                                  bs, 0, errp);
     if (!crypto) {
         return -EINVAL;
     }
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 7e1235c213..ab52c9dce1 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1315,6 +1315,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     const char *hash_alg;
     g_autofree char *cipher_mode_spec = NULL;
     uint64_t iters;
+    uint64_t detached_header_size;
 
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
     if (!luks_opts.has_iter_time) {
@@ -1543,19 +1544,32 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         slot->stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
     }
 
-    /* The total size of the LUKS headers is the partition header + key
-     * slot headers, rounded up to the nearest sector, combined with
-     * the size of each master key material region, also rounded up
-     * to the nearest sector */
-    luks->header.payload_offset_sector = header_sectors +
-            QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
+    if (block->detached_header) {
+        /*
+         * For a detached LUKS header image, set the payload_offset_sector
+         * to 0 to specify the starting point for read/write
+         */
+        luks->header.payload_offset_sector = 0;
+    } else {
+        /*
+         * The total size of the LUKS headers is the partition header + key
+         * slot headers, rounded up to the nearest sector, combined with
+         * the size of each master key material region, also rounded up
+         * to the nearest sector
+         */
+        luks->header.payload_offset_sector = header_sectors +
+                QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
+    }
 
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset_sector *
         block->sector_size;
+    detached_header_size =
+        (header_sectors + QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS *
+         split_key_sectors) * block->sector_size;
 
     /* Reserve header space to match payload offset */
-    initfunc(block, block->payload_offset, opaque, &local_err);
+    initfunc(block, detached_header_size, opaque, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
diff --git a/crypto/block.c b/crypto/block.c
index 7bb4b74a37..506ea1d1a3 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -87,6 +87,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
                                    QCryptoBlockInitFunc initfunc,
                                    QCryptoBlockWriteFunc writefunc,
                                    void *opaque,
+                                   unsigned int flags,
                                    Error **errp)
 {
     QCryptoBlock *block = g_new0(QCryptoBlock, 1);
@@ -102,6 +103,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
     }
 
     block->driver = qcrypto_block_drivers[options->format];
+    block->detached_header = flags & QCRYPTO_BLOCK_CREATE_DETACHED;
 
     if (block->driver->create(block, options, optprefix, initfunc,
                               writefunc, opaque, errp) < 0) {
@@ -146,7 +148,7 @@ qcrypto_block_calculate_payload_offset(QCryptoBlockCreateOptions *create_opts,
         qcrypto_block_create(create_opts, optprefix,
                              qcrypto_block_headerlen_hdr_init_func,
                              qcrypto_block_headerlen_hdr_write_func,
-                             len, errp);
+                             len, 0, errp);
     return crypto != NULL;
 }
 
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 3c7ccea504..836f3b4726 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -42,6 +42,8 @@ struct QCryptoBlock {
     size_t niv;
     uint64_t payload_offset; /* In bytes */
     uint64_t sector_size; /* In bytes */
+
+    bool detached_header; /* True if disk has a detached LUKS header */
 };
 
 struct QCryptoBlockDriver {
diff --git a/include/crypto/block.h b/include/crypto/block.h
index d0d97f5d12..92e823c9f2 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -116,6 +116,10 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  size_t n_threads,
                                  Error **errp);
 
+typedef enum {
+    QCRYPTO_BLOCK_CREATE_DETACHED = (1 << 0),
+} QCryptoBlockCreateFlags;
+
 /**
  * qcrypto_block_create:
  * @options: the encryption options
@@ -123,6 +127,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
  * @initfunc: callback for initializing volume header
  * @writefunc: callback for writing data to the volume header
  * @opaque: data to pass to @initfunc and @writefunc
+ * @flags: bitmask of QCryptoBlockCreateFlags values
  * @errp: pointer to a NULL-initialized error object
  *
  * Create a new block encryption object for initializing
@@ -134,6 +139,11 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
  * generating new master keys, etc as required. Any existing
  * data present on the volume will be irrevocably destroyed.
  *
+ * If @flags contains QCRYPTO_BLOCK_CREATE_DETACHED then
+ * the open process will set the payload_offset_sector to 0
+ * to specify the starting point for the read/write of a
+ * detached LUKS header image.
+ *
  * If any part of initializing the encryption context
  * fails an error will be returned. This could be due
  * to the volume being in the wrong format, a cipher
@@ -147,6 +157,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
                                    QCryptoBlockInitFunc initfunc,
                                    QCryptoBlockWriteFunc writefunc,
                                    void *opaque,
+                                   unsigned int flags,
                                    Error **errp);
 
 /**
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 347cd5f3d7..6cfc817a92 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -283,6 +283,7 @@ static void test_block(gconstpointer opaque)
                                test_block_init_func,
                                test_block_write_func,
                                &header,
+                               0,
                                &error_abort);
     g_assert(blk);
 
@@ -362,6 +363,7 @@ test_luks_bad_header(gconstpointer data)
                                test_block_init_func,
                                test_block_write_func,
                                &buf,
+                               0,
                                &error_abort);
     g_assert(blk);
 
-- 
2.43.0


