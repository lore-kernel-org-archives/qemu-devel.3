Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACEBC27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5R2-0000E8-Bl; Tue, 11 Jun 2024 13:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5R0-0000Cv-V3
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qz-00005v-7h
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718127444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lv65QFUQSYP8QtBV0oK5wLlGxJlscP+ME8lnikpyAKI=;
 b=RQAOUr2GFo25N59Ff0Y9IJvrIGlvTUHWMML9R2fuvwjVs3cSqAdq8hPil5D61Df1JzgTsx
 b9N63jeVkGK7JXGfcwyK5cSsegFdqpvZfibuD+Wj7c/lfm1VKvA4T/5NPzCpnbAex2gBYs
 NkICwkcJ+qC+KQRF2ysnfWAQ6lI5qVM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-1K0sGGBHNOKk_ZSS8-hPRA-1; Tue,
 11 Jun 2024 13:37:20 -0400
X-MC-Unique: 1K0sGGBHNOKk_ZSS8-hPRA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCB071955D82; Tue, 11 Jun 2024 17:37:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.130])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8BC419560AB; Tue, 11 Jun 2024 17:37:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 8/8] crypto/block: drop qcrypto_block_open() n_threads argument
Date: Tue, 11 Jun 2024 19:36:58 +0200
Message-ID: <20240611173658.231831-9-kwolf@redhat.com>
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

The n_threads argument is no longer used since the previous commit.
Remove it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240527155851.892885-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 crypto/blockpriv.h             | 1 -
 include/crypto/block.h         | 2 --
 block/crypto.c                 | 1 -
 block/qcow.c                   | 2 +-
 block/qcow2.c                  | 5 ++---
 crypto/block-luks.c            | 1 -
 crypto/block-qcow.c            | 6 ++----
 crypto/block.c                 | 3 +--
 tests/unit/test-crypto-block.c | 4 ----
 9 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 4bf6043d5d..b8f77cb5eb 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -59,7 +59,6 @@ struct QCryptoBlockDriver {
                 QCryptoBlockReadFunc readfunc,
                 void *opaque,
                 unsigned int flags,
-                size_t n_threads,
                 Error **errp);
 
     int (*create)(QCryptoBlock *block,
diff --git a/include/crypto/block.h b/include/crypto/block.h
index 92e823c9f2..5b5d039800 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -76,7 +76,6 @@ typedef enum {
  * @readfunc: callback for reading data from the volume
  * @opaque: data to pass to @readfunc
  * @flags: bitmask of QCryptoBlockOpenFlags values
- * @n_threads: allow concurrent I/O from up to @n_threads threads
  * @errp: pointer to a NULL-initialized error object
  *
  * Create a new block encryption object for an existing
@@ -113,7 +112,6 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
-                                 size_t n_threads,
                                  Error **errp);
 
 typedef enum {
diff --git a/block/crypto.c b/block/crypto.c
index 21eed909c1..4eed3ffa6a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -363,7 +363,6 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
                                        block_crypto_read_func,
                                        bs,
                                        cflags,
-                                       1,
                                        errp);
 
     if (!crypto->block) {
diff --git a/block/qcow.c b/block/qcow.c
index ca8e1d5ec8..c2f89db055 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -211,7 +211,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto = qcrypto_block_open(crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, 1, errp);
+                                           NULL, NULL, cflags, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 956128b409..10883a2494 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -321,7 +321,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
                                            qcow2_crypto_hdr_read_func,
-                                           bs, cflags, QCOW2_MAX_THREADS, errp);
+                                           bs, cflags, errp);
             if (!s->crypto) {
                 return -EINVAL;
             }
@@ -1701,8 +1701,7 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags,
-                                           QCOW2_MAX_THREADS, errp);
+                                           NULL, NULL, cflags, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 3357852c0a..5b777c15d3 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1189,7 +1189,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         QCryptoBlockReadFunc readfunc,
                         void *opaque,
                         unsigned int flags,
-                        size_t n_threads,
                         Error **errp)
 {
     QCryptoBlockLUKS *luks = NULL;
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 02305058e3..42e9556e42 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -44,7 +44,6 @@ qcrypto_block_qcow_has_format(const uint8_t *buf G_GNUC_UNUSED,
 static int
 qcrypto_block_qcow_init(QCryptoBlock *block,
                         const char *keysecret,
-                        size_t n_threads,
                         Error **errp)
 {
     char *password;
@@ -100,7 +99,6 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
                         QCryptoBlockReadFunc readfunc G_GNUC_UNUSED,
                         void *opaque G_GNUC_UNUSED,
                         unsigned int flags,
-                        size_t n_threads,
                         Error **errp)
 {
     if (flags & QCRYPTO_BLOCK_OPEN_NO_IO) {
@@ -115,7 +113,7 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
             return -1;
         }
         return qcrypto_block_qcow_init(block, options->u.qcow.key_secret,
-                                       n_threads, errp);
+                                       errp);
     }
 }
 
@@ -135,7 +133,7 @@ qcrypto_block_qcow_create(QCryptoBlock *block,
         return -1;
     }
     /* QCow2 has no special header, since everything is hardwired */
-    return qcrypto_block_qcow_init(block, options->u.qcow.key_secret, 1, errp);
+    return qcrypto_block_qcow_init(block, options->u.qcow.key_secret, errp);
 }
 
 
diff --git a/crypto/block.c b/crypto/block.c
index ba6d1cebc7..3bcc4270c3 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -53,7 +53,6 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
-                                 size_t n_threads,
                                  Error **errp)
 {
     QCryptoBlock *block = g_new0(QCryptoBlock, 1);
@@ -73,7 +72,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
     block->driver = qcrypto_block_drivers[options->format];
 
     if (block->driver->open(block, options, optprefix,
-                            readfunc, opaque, flags, n_threads, errp) < 0)
+                            readfunc, opaque, flags, errp) < 0)
     {
         g_free(block);
         return NULL;
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 6cfc817a92..42cfab6067 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -303,7 +303,6 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              0,
-                             1,
                              NULL);
     g_assert(blk == NULL);
 
@@ -312,7 +311,6 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              QCRYPTO_BLOCK_OPEN_NO_IO,
-                             1,
                              &error_abort);
 
     g_assert(qcrypto_block_get_cipher(blk) == NULL);
@@ -327,7 +325,6 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              0,
-                             1,
                              &error_abort);
     g_assert(blk);
 
@@ -384,7 +381,6 @@ test_luks_bad_header(gconstpointer data)
                              test_block_read_func,
                              &buf,
                              0,
-                             1,
                              &err);
     g_assert(!blk);
     g_assert(err);
-- 
2.45.2


