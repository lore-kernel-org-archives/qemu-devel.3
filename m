Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522B7C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRWN-0003yX-TU; Fri, 09 Feb 2024 09:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVs-0003KU-O5
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVq-0004ON-Sm
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxwFy1JSP+pEi7BSGhQTS4DNX2/gM+JwwJoytAiX8Mg=;
 b=cvY9ugwoCwoJZBupNVO+wu+2IbocJhkVQvjLJCzU5My5Dc0qC1SHmZEWLVF4XtdR9hs/qh
 AONz7aYWiuEyqAx9bBfxgLyLzyXtAtf53q4vZ/y4pV1ej++3C4DEoBupAAifWRMPYumupx
 0Erd42A24AXIAUK6B2HMDTQnWvjFFiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-AH97b13zNnqH9xIJFh8Kng-1; Fri, 09 Feb 2024 09:05:48 -0500
X-MC-Unique: AH97b13zNnqH9xIJFh8Kng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D00B185A781;
 Fri,  9 Feb 2024 14:05:48 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9D1C111FF;
 Fri,  9 Feb 2024 14:05:45 +0000 (UTC)
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
Subject: [PULL 14/17] block: Support detached LUKS header creation using
 blockdev-create
Date: Fri,  9 Feb 2024 14:05:02 +0000
Message-ID: <20240209140505.2536635-15-berrange@redhat.com>
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

Firstly, enable the ability to choose the block device containing
a detachable LUKS header by adding the 'header' parameter to
BlockdevCreateOptionsLUKS.

Secondly, when formatting the LUKS volume with a detachable header,
truncate the payload volume to length without a header size.

Using the qmp blockdev command, create the LUKS volume with a
detachable header as follows:

1. add the secret to lock/unlock the cipher stored in the
   detached LUKS header
$ virsh qemu-monitor-command vm '{"execute":"object-add",
> "arguments":{"qom-type": "secret", "id": "sec0", "data": "foo"}}'

2. create a header img with 0 size
$ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> "arguments":{"job-id":"job0", "options":{"driver":"file",
> "filename":"/path/to/detached_luks_header.img", "size":0 }}}'

3. add protocol blockdev node for header
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments": {"driver":"file", "filename":
> "/path/to/detached_luks_header.img", "node-name":
> "detached-luks-header-storage"}}'

4. create a payload img with 0 size
$ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> "arguments":{"job-id":"job1", "options":{"driver":"file",
> "filename":"/path/to/detached_luks_payload_raw.img", "size":0}}}'

5. add protocol blockdev node for payload
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments": {"driver":"file", "filename":
> "/path/to/detached_luks_payload_raw.img", "node-name":
> "luks-payload-raw-storage"}}'

6. do the formatting with 128M size
$ virsh qemu-monitor-command c81_node1 '{"execute":"blockdev-create",
> "arguments":{"job-id":"job2", "options":{"driver":"luks", "header":
> "detached-luks-header-storage", "file":"luks-payload-raw-storage",
> "size":134217728, "preallocation":"full", "key-secret":"sec0" }}}'

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/crypto.c       | 101 +++++++++++++++++++++++++++++++++++++++----
 qapi/block-core.json |   3 ++
 2 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 1b3f87922a..8e7ee5e9ac 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -162,6 +162,48 @@ error:
     return ret;
 }
 
+static int coroutine_fn GRAPH_UNLOCKED
+block_crypto_co_format_luks_payload(BlockdevCreateOptionsLUKS *luks_opts,
+                                    Error **errp)
+{
+    BlockDriverState *bs = NULL;
+    BlockBackend *blk = NULL;
+    Error *local_error = NULL;
+    int ret;
+
+    if (luks_opts->size > INT64_MAX) {
+        return -EFBIG;
+    }
+
+    bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
+    if (bs == NULL) {
+        return -EIO;
+    }
+
+    blk = blk_co_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
+                             BLK_PERM_ALL, errp);
+    if (!blk) {
+        ret = -EPERM;
+        goto fail;
+    }
+
+    ret = blk_truncate(blk, luks_opts->size, true,
+                       luks_opts->preallocation, 0, &local_error);
+    if (ret < 0) {
+        if (ret == -EFBIG) {
+            /* Replace the error message with a better one */
+            error_free(local_error);
+            error_setg(errp, "The requested file size is too large");
+        }
+        goto fail;
+    }
+
+    ret = 0;
+
+fail:
+    bdrv_co_unref(bs);
+    return ret;
+}
 
 static QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
@@ -341,7 +383,9 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 static int coroutine_fn GRAPH_UNLOCKED
 block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
                                QCryptoBlockCreateOptions *opts,
-                               PreallocMode prealloc, Error **errp)
+                               PreallocMode prealloc,
+                               unsigned int flags,
+                               Error **errp)
 {
     int ret;
     BlockBackend *blk;
@@ -369,7 +413,7 @@ block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
                                   block_crypto_create_init_func,
                                   block_crypto_create_write_func,
                                   &data,
-                                  0,
+                                  flags,
                                   errp);
 
     if (!crypto) {
@@ -656,16 +700,26 @@ static int coroutine_fn GRAPH_UNLOCKED
 block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsLUKS *luks_opts;
+    BlockDriverState *hdr_bs = NULL;
     BlockDriverState *bs = NULL;
     QCryptoBlockCreateOptions create_opts;
     PreallocMode preallocation = PREALLOC_MODE_OFF;
+    unsigned int cflags = 0;
     int ret;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
     luks_opts = &create_options->u.luks;
 
-    if (luks_opts->file == NULL) {
-        error_setg(errp, "Formatting LUKS disk requires parameter 'file'");
+    if (luks_opts->header == NULL && luks_opts->file == NULL) {
+        error_setg(errp, "Either the parameter 'header' or 'file' must "
+                   "be specified");
+        return -EINVAL;
+    }
+
+    if ((luks_opts->preallocation != PREALLOC_MODE_OFF) &&
+        (luks_opts->file == NULL)) {
+        error_setg(errp, "Parameter 'preallocation' requires 'file' to be "
+                   "specified for formatting LUKS disk");
         return -EINVAL;
     }
 
@@ -678,14 +732,38 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         preallocation = luks_opts->preallocation;
     }
 
-    if (luks_opts->file) {
+    if (luks_opts->header) {
+        /* LUKS volume with detached header */
+        hdr_bs = bdrv_co_open_blockdev_ref(luks_opts->header, errp);
+        if (hdr_bs == NULL) {
+            return -EIO;
+        }
+
+        cflags |= QCRYPTO_BLOCK_CREATE_DETACHED;
+
+        /* Format the LUKS header node */
+        ret = block_crypto_co_create_generic(hdr_bs, 0, &create_opts,
+                                             PREALLOC_MODE_OFF, cflags, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        /* Format the LUKS payload node */
+        if (luks_opts->file) {
+            ret = block_crypto_co_format_luks_payload(luks_opts, errp);
+            if (ret < 0) {
+                goto fail;
+            }
+        }
+    } else if (luks_opts->file) {
+        /* LUKS volume with none-detached header */
         bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
         if (bs == NULL) {
             return -EIO;
         }
 
         ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
-                                             preallocation, errp);
+                                             preallocation, cflags, errp);
         if (ret < 0) {
             goto fail;
         }
@@ -693,7 +771,13 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
 
     ret = 0;
 fail:
-    bdrv_co_unref(bs);
+    if (hdr_bs != NULL) {
+        bdrv_co_unref(hdr_bs);
+    }
+
+    if (bs != NULL) {
+        bdrv_co_unref(bs);
+    }
     return ret;
 }
 
@@ -747,7 +831,8 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     }
 
     /* Create format layer */
-    ret = block_crypto_co_create_generic(bs, size, create_opts, prealloc, errp);
+    ret = block_crypto_co_create_generic(bs, size, create_opts,
+                                         prealloc, 0, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 77d1f50d55..e4ef36d2aa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4958,6 +4958,8 @@
 # @file: Node to create the image format on, mandatory except when
 #        'preallocation' is not requested
 #
+# @header: Block device holding a detached LUKS header. (since 9.0)
+#
 # @size: Size of the virtual disk in bytes
 #
 # @preallocation: Preallocation mode for the new image (since: 4.2)
@@ -4968,6 +4970,7 @@
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
   'data': { '*file':            'BlockdevRef',
+            '*header':          'BlockdevRef',
             'size':             'size',
             '*preallocation':   'PreallocMode' } }
 
-- 
2.43.0


