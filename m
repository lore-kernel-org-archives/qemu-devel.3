Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF1C48286
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgqa-0002st-3t; Tue, 30 Jan 2024 00:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqW-0002rw-In
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:44 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqU-0001NJ-OI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:44 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59502aa878aso1803053eaf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593061; x=1707197861;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Zmg4sbSwcsBk7QBG9lZhae1I6QzpidLZEsTyVPwHJQ=;
 b=WV1D0NjD2ctIOMKVMJ314ln59FkZ0mEObSWnzHGGFniU6UcasUDBV2x76Yjma4um5/
 /gmUa5T8efYDqKoaB8BTanWi0xlv/5Gli1ReLaqvFGhQwpYXuXHS0b/44uTxy2ZzqQfp
 jnYZ7+NSyAqhFDdCmYTaIj2xaxq11BvKnpV0/75hkJHXe7E6ReNwT9jTuXEas6LbACLg
 1Ycqg8njBpyYT5qe1Y686hPVTHT5JcVgv2K/ZKxs88N1mtHSOInwNUAPag7dT3Zj1vax
 rwB3lgT4kRNPk8XtILX9xKG9t97Dtaacv+cEmCjHEkBUbOyVTGpsDgpO2gNfI0A8S3OW
 YjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593061; x=1707197861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Zmg4sbSwcsBk7QBG9lZhae1I6QzpidLZEsTyVPwHJQ=;
 b=lxUqiFPVIwvfNMtAed/PmULCnY1hB7RMU75uRpHnqdAvrGLpdwBwxQdrGe3ssGrWE/
 e7vyK9J9p+bIAXFiWX3/Wh3BmpNjV6ulQtf7GTRXMkI5jwh+ugZxDScgCNcu626hm/nH
 KXzK1fBijqQW4KO4q6crdaHqo69ZaQ1ABQ2wr7ff0HjKKocRHS/2M7Jkg9T/1L0ZrjQ+
 Kh2mVvFn4jI+YA+sWFASk013QByxpFV1dUdxDvzuu5qVYv6qvkh6H+Rv5L3lkVaMv3RM
 GvR/W72rrN5G+HDVYf6yEUNUxDRiXpUYAaO8J7/f0WR5kzhHNQISVmctKTDOBfjtkdnN
 8xRw==
X-Gm-Message-State: AOJu0YxzcMIkKdoCwFVHTCFvyUUpmjE8yV8ss3A2IOTKLiU9NgQHr0ZB
 G7RCiusk5k26YvNWTv8QZ+FBveeHv+RXBHIyf7i1VI0G6LgeeorU5V05dtXRWFCiOBHIem4QAwy
 qzI0=
X-Google-Smtp-Source: AGHT+IH/yItth8XF+5mVj37Yyx7z6K1F1FW6aeEqwAYcvco07wuR+knKc6CpofOhHp2en7k6V7u0JQ==
X-Received: by 2002:a05:6358:72a4:b0:178:7194:b543 with SMTP id
 w36-20020a05635872a400b001787194b543mr3729757rwf.41.1706593060480; 
 Mon, 29 Jan 2024 21:37:40 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:40 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 4/7] block: Support detached LUKS header creation using
 blockdev-create
Date: Tue, 30 Jan 2024 13:37:22 +0800
Message-Id: <9e35e621f12478822072e5c740ed65beb77f1238.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706586786.git.yong.huang@smartx.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 69a88d613d..eab15d7dd9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4960,6 +4960,8 @@
 # @file: Node to create the image format on, mandatory except when
 #        'preallocation' is not requested
 #
+# @header: Block device holding a detached LUKS header. (since 9.0)
+#
 # @size: Size of the virtual disk in bytes
 #
 # @preallocation: Preallocation mode for the new image (since: 4.2)
@@ -4970,6 +4972,7 @@
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
   'data': { '*file':            'BlockdevRef',
+            '*header':          'BlockdevRef',
             'size':             'size',
             '*preallocation':   'PreallocMode' } }
 
-- 
2.31.1


