Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F671C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRWM-0003hS-2y; Fri, 09 Feb 2024 09:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVv-0003Lh-Ct
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVt-0004Ou-E2
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLgfjikfK3wvRHOW/nCIfB/m2zAiiNoOHbvMIsbcyig=;
 b=G/tgueLAveKG6UJl4VnHzIuj/aRYmxKJfETLUbecvqigTeGxvcuRVgUxNp/Y9Cc5Tb9EPT
 qYbZ9aAbqxZsN9wNxcCU40i52ijBOx5WTucLy4jGi4n6i5Mv9/3RBqYPS4zr6za8IEpOqP
 pSDnKjQLge9Sl2kNrzRuuPgPaZ4uEV4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-vRf2gGohO-iX5DfQ_sy5Jw-1; Fri, 09 Feb 2024 09:05:51 -0500
X-MC-Unique: vRf2gGohO-iX5DfQ_sy5Jw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E707E108BDD4;
 Fri,  9 Feb 2024 14:05:50 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A501112A1;
 Fri,  9 Feb 2024 14:05:48 +0000 (UTC)
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
Subject: [PULL 15/17] block: Support detached LUKS header creation using
 qemu-img
Date: Fri,  9 Feb 2024 14:05:03 +0000
Message-ID: <20240209140505.2536635-16-berrange@redhat.com>
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
 SPF_PASS=-0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Even though a LUKS header might be created with cryptsetup,
qemu-img should be enhanced to accommodate it as well.

Add the 'detached-header' option to specify the creation of
a detached LUKS header. This is how it is used:
$ qemu-img create --object secret,id=sec0,data=abc123 -f luks
> -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0
> -o detached-header=true header.luks

Using qemu-img or cryptsetup tools to query information of
an LUKS header image as follows:

Assume a detached LUKS header image has been created by:
$ dd if=/dev/zero of=test-header.img bs=1M count=32
$ dd if=/dev/zero of=test-payload.img bs=1M count=1000
$ cryptsetup luksFormat --header test-header.img test-payload.img
> --force-password --type luks1

Header image information could be queried using cryptsetup:
$ cryptsetup luksDump test-header.img

or qemu-img:
$ qemu-img info 'json:{"driver":"luks","file":{"filename":
> "test-payload.img"},"header":{"filename":"test-header.img"}}'

When using qemu-img, keep in mind that the entire disk
information specified by the JSON-format string above must be
supplied on the commandline; if not, an overlay check will reveal
a problem with the LUKS volume check logic.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[changed to pass 'cflags' to block_crypto_co_create_generic]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block.c          |  5 ++++-
 block/crypto.c   | 12 ++++++++++--
 block/crypto.h   |  8 ++++++++
 qapi/crypto.json |  5 ++++-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 30afdcbba6..1ed9214f66 100644
--- a/block.c
+++ b/block.c
@@ -7357,7 +7357,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
         goto out;
     }
 
-    if (size == -1) {
+    /* Parameter 'size' is not needed for detached LUKS header */
+    if (size == -1 &&
+        !(!strcmp(fmt, "luks") &&
+          qemu_opt_get_bool(opts, "detached-header", false))) {
         error_setg(errp, "Image creation needs a size parameter");
         goto out;
     }
diff --git a/block/crypto.c b/block/crypto.c
index 8e7ee5e9ac..21eed909c1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -231,6 +231,7 @@ static QemuOptsList block_crypto_create_opts_luks = {
         BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_DETACHED_HEADER(""),
         { /* end of list */ }
     },
 };
@@ -405,7 +406,7 @@ block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
 
     data = (struct BlockCryptoCreateData) {
         .blk = blk,
-        .size = size,
+        .size = flags & QCRYPTO_BLOCK_CREATE_DETACHED ? 0 : size,
         .prealloc = prealloc,
     };
 
@@ -791,6 +792,9 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     PreallocMode prealloc;
     char *buf = NULL;
     int64_t size;
+    bool detached_hdr =
+        qemu_opt_get_bool(opts, "detached-header", false);
+    unsigned int cflags = 0;
     int ret;
     Error *local_err = NULL;
 
@@ -830,9 +834,13 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
         goto fail;
     }
 
+    if (detached_hdr) {
+        cflags |= QCRYPTO_BLOCK_CREATE_DETACHED;
+    }
+
     /* Create format layer */
     ret = block_crypto_co_create_generic(bs, size, create_opts,
-                                         prealloc, 0, errp);
+                                         prealloc, cflags, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/crypto.h b/block/crypto.h
index 72e792c9af..dc3d2d5ed9 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -41,6 +41,7 @@
 #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
+#define BLOCK_CRYPTO_OPT_LUKS_DETACHED_HEADER "detached-header"
 #define BLOCK_CRYPTO_OPT_LUKS_KEYSLOT "keyslot"
 #define BLOCK_CRYPTO_OPT_LUKS_STATE "state"
 #define BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET "old-secret"
@@ -100,6 +101,13 @@
         .help = "Select new state of affected keyslots (active/inactive)",\
     }
 
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_DETACHED_HEADER(prefix)     \
+    {                                                         \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_DETACHED_HEADER, \
+        .type = QEMU_OPT_BOOL,                                \
+        .help = "Create a detached LUKS header",              \
+    }
+
 #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT(prefix)              \
     {                                                          \
         .name = prefix BLOCK_CRYPTO_OPT_LUKS_KEYSLOT,          \
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 2f2aeff5fd..22c6cce3ae 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -226,6 +226,8 @@
 # @iter-time: number of milliseconds to spend in PBKDF passphrase
 #     processing.  Currently defaults to 2000. (since 2.8)
 #
+# @detached-header: create a detached LUKS header. (since 9.0)
+#
 # Since: 2.6
 ##
 { 'struct': 'QCryptoBlockCreateOptionsLUKS',
@@ -235,7 +237,8 @@
             '*ivgen-alg': 'QCryptoIVGenAlgorithm',
             '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
             '*hash-alg': 'QCryptoHashAlgorithm',
-            '*iter-time': 'int'}}
+            '*iter-time': 'int',
+            '*detached-header': 'bool'}}
 
 ##
 # @QCryptoBlockOpenOptions:
-- 
2.43.0


