Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C613C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKvMd-0005A0-9r; Fri, 30 May 2025 04:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMS-00053m-5q
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMO-0000jQ-9F
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748594703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/2Ra3xOF2Xk1EgqPad2PlpU9ziLUGgRLqoaKoZcQW8=;
 b=OjNNBXiUaMNijcHgpbM/MGe9xviiNvHneVMt6I0mBeV5Y76bYFfGFA/ZOmTAXPvzy6Dw7a
 dzumHtxGTCJlzK5oTx/ZO0IA8d7XF/twnGTrLbr5Dh1rtdEts3ZbKhKmrELH3GOw6PbwMr
 Fci/BwkqjH1hv1TdlRDaHqDMDaKzO0o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-D432dj4LOjuTTUf-om7dtA-1; Fri, 30 May 2025 04:45:01 -0400
X-MC-Unique: D432dj4LOjuTTUf-om7dtA-1
X-Mimecast-MFC-AGG-ID: D432dj4LOjuTTUf-om7dtA_1748594701
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso41198f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748594700; x=1749199500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/2Ra3xOF2Xk1EgqPad2PlpU9ziLUGgRLqoaKoZcQW8=;
 b=Y877vzXouOeh4drHGBRAQcqxHX3cJ7Xy4Un3tyalg0iQ7si7EO0qlJafRw8a4FcYuZ
 +nZrwodIxWqiEGj6mV/hgs72bgHfasbLeWU9YLvO9g1+FeNzQKDz3Gkx7w+uUmiziDzN
 RpORqZ1+NB9r5bN6BG/NYHeFB7KB3OpeG2HUybtukDj14rZT0i6tEJ63/jsFxmydCUBt
 znCOo1byrcxOjrtQNYV+IGjVsR4f2IslRtwKJ2nEfQsqDA1o62Nbw+MrDECnC6Ie36xK
 bP484qBkljmo6coyHyADFXJ99kTtB8nv86I4dO3+ScgFTN4lsRVUPe13kLXJCYKkSBA2
 W/WQ==
X-Gm-Message-State: AOJu0YwWVCthPZn28WAYmmPdMdbBBoBQrj5RsZ3+6knpNdGiedpJlurm
 hnL83we0K1mTloznt/AnYOA+Bd2bIyaZgIr0gTN8mEAolIKDBg//1Hy58auln87LtykDiuOWCBz
 Bepaw9WYyDA5qYEHHY8Qlzf0yEKdmk6lpiP8jBPoHf+016M8LQ8ZF54y3
X-Gm-Gg: ASbGncsThKJl+Rf4tUIDQjepOz5c1b5tPt3wfQlp69oH1g1ovaCQNFBo2o2Dh5W0s+K
 0KmCaKThtuFtR1XdpTmpVAr7vL3ZbDsrB3Wozajq+OjobPuvvnFPOsNT1xUXQE8vgbmn8QvJrED
 EyPs4BUdv3lKr6TE4ibvhfWJrkBYb0dG4U5UuuJwgh11rkZdpWhxKlAFYYKf+uXdC9WGu2rkEhY
 jsMzBHyB6Ylc3Xei6EUfv1esPgSVhbDOXjbPDNJJ6JXwtX8dWsItDS8qrNUVSLvWiwBjh2XBAVv
 hcJI5Gb1jRsxLLm34uguGpO7AyuL6gaalQSAa27w5q2egR2BQmDM3cHcXJ88j+29j58SNg==
X-Received: by 2002:a05:6000:22c3:b0:3a4:eeb6:3b6b with SMTP id
 ffacd0b85a97d-3a4f7a6d218mr1895444f8f.43.1748594700343; 
 Fri, 30 May 2025 01:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIAR5pg+VPt9A7j2XOVfGOG12DylkyqP/x0l9RkdRkwt4V7ChfwB/eUeGnAod4xuIBEEFZFQ==
X-Received: by 2002:a05:6000:22c3:b0:3a4:eeb6:3b6b with SMTP id
 ffacd0b85a97d-3a4f7a6d218mr1895421f8f.43.1748594699835; 
 Fri, 30 May 2025 01:44:59 -0700 (PDT)
Received: from localhost
 (p200300cfd700f320acd9b9a35df3ddfd.dip0.t-ipconnect.de.
 [2003:cf:d700:f320:acd9:b9a3:5df3:ddfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f22sm4167030f8f.43.2025.05.30.01.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:44:57 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/4] qcow2: Add keep_data_file command-line option
Date: Fri, 30 May 2025 10:44:44 +0200
Message-ID: <20250530084448.192369-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530084448.192369-1-hreitz@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 include/block/block_int-common.h |  1 +
 block/qcow2.c                    | 75 ++++++++++++++++++++++++++++++--
 tests/qemu-iotests/082.out       | 18 ++++++++
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 2982dd3118..b52e441b42 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,7 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_KEEP_DATA_FILE    "keep_data_file"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 66fba89b41..b11cbfd859 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3902,6 +3902,8 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     BlockDriverState *bs = NULL;
     BlockDriverState *data_bs = NULL;
     const char *val;
+    bool keep_data_file = false;
+    BlockdevCreateOptionsQcow2 *qcow2_opts;
     int ret;
 
     /* Only the keyval visitor supports the dotted syntax needed for
@@ -3933,6 +3935,22 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
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
@@ -3969,9 +3987,11 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     /* Create and open an external data file (protocol layer) */
     val = qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
     if (val) {
-        ret = bdrv_co_create_file(val, opts, errp);
-        if (ret < 0) {
-            goto finish;
+        if (!keep_data_file) {
+            ret = bdrv_co_create_file(val, opts, errp);
+            if (ret < 0) {
+                goto finish;
+            }
         }
 
         data_bs = bdrv_co_open(val, NULL, NULL,
@@ -3984,6 +4004,11 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
 
         qdict_del(qdict, BLOCK_OPT_DATA_FILE);
         qdict_put_str(qdict, "data-file", data_bs->node_name);
+    } else if (keep_data_file) {
+        error_setg(errp, "Must not use '%s=on' without '%s'",
+                   BLOCK_OPT_KEEP_DATA_FILE, BLOCK_OPT_DATA_FILE);
+        ret = -EINVAL;
+        goto finish;
     }
 
     /* Set 'driver' and 'node' options */
@@ -4004,6 +4029,40 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         goto finish;
     }
 
+    qcow2_opts = &create_options->u.qcow2;
+
+    if (!qcow2_opts->has_preallocation) {
+        qcow2_opts->preallocation = PREALLOC_MODE_OFF;
+    }
+    if (!qcow2_opts->has_data_file_raw) {
+        qcow2_opts->data_file_raw = false;
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
@@ -4014,7 +4073,9 @@ finish:
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
@@ -6113,6 +6174,12 @@ static QemuOptsList qcow2_create_opts = {
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
index d0dd333117..e0463815c6 100644
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
2.49.0


