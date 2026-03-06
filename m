Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A77FCC05A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vya4X-0001P6-A7; Fri, 06 Mar 2026 13:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya4B-00015W-7J
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya48-00065c-Ol
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772822304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuTZteIe+ykuBflM5F6Q7j9etA3GKomQ8BBwdHEvyxY=;
 b=e7bVFGNBk/Y+Z8dyxUlwQ2DPYPTF7X3U1Z6yikJ9FQT19jqnmMgDqEcYvKQG37Ny0fR0l3
 7O01VzCKwTxl0B50UvINkbJHv0a3T6+DTRqCNZOBfqB0ACBUi4koMOQxvmCtkHJ3WG9lh5
 OjV7RK3pEvLSHLOW///wnnajkzLVF/U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-yoZqUgqnOfGo_Fh5XInQpQ-1; Fri,
 06 Mar 2026 13:38:22 -0500
X-MC-Unique: yoZqUgqnOfGo_Fh5XInQpQ-1
X-Mimecast-MFC-AGG-ID: yoZqUgqnOfGo_Fh5XInQpQ_1772822301
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4F7180049D; Fri,  6 Mar 2026 18:38:21 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C3871800361; Fri,  6 Mar 2026 18:38:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/12] qcow2: Add keep_data_file command-line option
Date: Fri,  6 Mar 2026 19:37:02 +0100
Message-ID: <20260306183705.410357-10-kwolf@redhat.com>
In-Reply-To: <20260306183705.410357-1-kwolf@redhat.com>
References: <20260306183705.410357-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hanna Czenczek <hreitz@redhat.com>

Add a command-line-only option to prevent overwriting the file specified
as external data file.

This option is only available on the qemu-img create command line, not
via blockdev-create, as it makes no sense there: That interface
separates file creation and formatting, so where the external data file
attached to a newly formatted qcow2 node comes from is completely up to
the user.

Implementation detail: Enabling this option will not only not overwrite
the external data file, but also assume it already exists, for two
reasons:
- It is simpler than checking whether the file exists, and only skipping
  creating it when it does not.  It is therefore also less error-prone,
  i.e. we can never accidentally overwrite an existing file because we
  made some mistake in checking whether it exists.
- I think it makes sense from a user's perspective: You set this option
  when you want to use an existing data file, and you unset it when you
  want a new one.  Getting an error when you expect to use an existing
  data file seems to me a nice warning that something is not right.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20250530084448.192369-2-hreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[kwolf: Removed redundant has_data_file_raw check]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h |  1 +
 block/qcow2.c                    | 72 ++++++++++++++++++++++++++++++--
 tests/qemu-iotests/082.out       | 18 ++++++++
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 9324af903d0..147c08155f7 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -56,6 +56,7 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_KEEP_DATA_FILE    "keep_data_file"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/block/qcow2.c b/block/qcow2.c
index e29810d86a3..e3728806203 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3991,6 +3991,8 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     BlockDriverState *bs = NULL;
     BlockDriverState *data_bs = NULL;
     const char *val;
+    bool keep_data_file = false;
+    BlockdevCreateOptionsQcow2 *qcow2_opts;
     int ret;
 
     /* Only the keyval visitor supports the dotted syntax needed for
@@ -4022,6 +4024,22 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v3");
     }
 
+    val = qdict_get_try_str(qdict, BLOCK_OPT_KEEP_DATA_FILE);
+    if (val) {
+        if (!strcmp(val, "on")) {
+            keep_data_file = true;
+        } else if (!strcmp(val, "off")) {
+            keep_data_file = false;
+        } else {
+            error_setg(errp,
+                       "Invalid value '%s' for '%s': Must be 'on' or 'off'",
+                       val, BLOCK_OPT_KEEP_DATA_FILE);
+            ret = -EINVAL;
+            goto finish;
+        }
+        qdict_del(qdict, BLOCK_OPT_KEEP_DATA_FILE);
+    }
+
     /* Change legacy command line options into QMP ones */
     static const QDictRenames opt_renames[] = {
         { BLOCK_OPT_BACKING_FILE,       "backing-file" },
@@ -4058,9 +4076,11 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     /* Create and open an external data file (protocol layer) */
     val = qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
     if (val) {
-        ret = bdrv_co_create_file(val, opts, false, errp);
-        if (ret < 0) {
-            goto finish;
+        if (!keep_data_file) {
+            ret = bdrv_co_create_file(val, opts, false, errp);
+            if (ret < 0) {
+                goto finish;
+            }
         }
 
         data_bs = bdrv_co_open(val, NULL, NULL,
@@ -4073,6 +4093,11 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
 
         qdict_del(qdict, BLOCK_OPT_DATA_FILE);
         qdict_put_str(qdict, "data-file", data_bs->node_name);
+    } else if (keep_data_file) {
+        error_setg(errp, "Must not use '%s=on' without '%s'",
+                   BLOCK_OPT_KEEP_DATA_FILE, BLOCK_OPT_DATA_FILE);
+        ret = -EINVAL;
+        goto finish;
     }
 
     /* Set 'driver' and 'node' options */
@@ -4093,6 +4118,37 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         goto finish;
     }
 
+    qcow2_opts = &create_options->u.qcow2;
+
+    if (!qcow2_opts->has_preallocation) {
+        qcow2_opts->preallocation = PREALLOC_MODE_OFF;
+    }
+
+    if (keep_data_file &&
+        qcow2_opts->preallocation != PREALLOC_MODE_OFF &&
+        qcow2_opts->preallocation != PREALLOC_MODE_METADATA)
+    {
+        error_setg(errp, "Preallocating more than only metadata would "
+                   "overwrite the external data file's content and is "
+                   "therefore incompatible with '%s=on'",
+                   BLOCK_OPT_KEEP_DATA_FILE);
+        ret = -EINVAL;
+        goto finish;
+    }
+
+    if (keep_data_file &&
+        qcow2_opts->preallocation == PREALLOC_MODE_OFF &&
+        !qcow2_opts->data_file_raw)
+    {
+        error_setg(errp, "'%s=on' requires '%s=metadata' or '%s=on', or the "
+                   "file contents will not be visible",
+                   BLOCK_OPT_KEEP_DATA_FILE,
+                   BLOCK_OPT_PREALLOC,
+                   BLOCK_OPT_DATA_FILE_RAW);
+        ret = -EINVAL;
+        goto finish;
+    }
+
     /* Silently round up size */
     create_options->u.qcow2.size = ROUND_UP(create_options->u.qcow2.size,
                                             BDRV_SECTOR_SIZE);
@@ -4103,7 +4159,9 @@ finish:
     if (ret < 0) {
         bdrv_graph_co_rdlock();
         bdrv_co_delete_file_noerr(bs);
-        bdrv_co_delete_file_noerr(data_bs);
+        if (!keep_data_file) {
+            bdrv_co_delete_file_noerr(data_bs);
+        }
         bdrv_graph_co_rdunlock();
     } else {
         ret = 0;
@@ -6202,6 +6260,12 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Compression method used for image cluster "        \
                     "compression",                                      \
             .def_value_str = "zlib"                                     \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_KEEP_DATA_FILE,                           \
+            .type = QEMU_OPT_BOOL,                                      \
+            .help = "Assume the external data file already exists and " \
+                    "do not overwrite it"                               \
         },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index d0dd333117a..e0463815c65 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -66,6 +66,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -92,6 +93,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -118,6 +120,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -144,6 +147,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -170,6 +174,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -196,6 +201,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -222,6 +228,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -248,6 +255,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -288,6 +296,7 @@ Supported qcow2 options:
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -376,6 +385,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -402,6 +412,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -428,6 +439,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -454,6 +466,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -480,6 +493,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -506,6 +520,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -532,6 +547,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -558,6 +574,7 @@ Supported options:
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -598,6 +615,7 @@ Supported qcow2 options:
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   extended_l2=<bool (on/off)> - Extended L2 tables
+  keep_data_file=<bool (on/off)> - Assume the external data file already exists and do not overwrite it
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
-- 
2.53.0


