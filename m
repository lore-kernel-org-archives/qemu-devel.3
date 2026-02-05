Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A24E83F1F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0ek-0007p3-3G; Thu, 05 Feb 2026 09:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eW-0007mx-Kz
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eP-0004DB-1I
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770302888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3seRjL0k8dNcaI66dd3c3Rct/8NtSmjoxT2fcuE65g=;
 b=N1WoWSxxlgNJTkg4mPebXV8nmniZi0OMIsp70dFxQ4GuCBXqDce+5m6queK7978//kzV0z
 ic10Bb68hrt9iT4M1oFHu2+gAhkgP9c9W/GgnjIygauz/diC5QOyPzeCtrcbYMjxBxrVWQ
 9v/s+b+X1BimOJJ1gbnpNuDQOShhjjA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-3BBno-KOPleD8x1zZyHWiw-1; Thu, 05 Feb 2026 09:48:07 -0500
X-MC-Unique: 3BBno-KOPleD8x1zZyHWiw-1
X-Mimecast-MFC-AGG-ID: 3BBno-KOPleD8x1zZyHWiw_1770302886
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4831192e66aso9720735e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 06:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770302885; x=1770907685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3seRjL0k8dNcaI66dd3c3Rct/8NtSmjoxT2fcuE65g=;
 b=t+xqkW51zyNyXBD75QnI9f16nF+L8XXLZSoKlSKCfEumPRCDbz+i/Pq1O7jH5Lu/+9
 QsiZrZ2CNsCL2uvPK0QENIxnFuiQYCQkyMFSkkwcKDk9SfQ8ZmimvmX6ehgyIZBJ+9jP
 bl4+/b2yzMPVWahnvZSrYTnpFdB608YMq+1PPdGogwNJr34fWl7WA6jisn9YvsLUOcjr
 b96ehD6fujrFUK2hgHz/hmk/r3QDjj0hYkUUI+XmYJ73NTAM9x/SvLf0YTd7wlRUH2GQ
 xAplFu36Jy78Iaangzmy5gWwxtjxq1FiC93yG1l6Ka+RtL3qSEJl0ICbaYVVeWHePSYJ
 csKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770302885; x=1770907685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N3seRjL0k8dNcaI66dd3c3Rct/8NtSmjoxT2fcuE65g=;
 b=Fv7rzOvtGexX9u8EGBYSX3iVeyR2D8B0xvpT2WmdgRZ3sKyWh/ZxtJ+HazYTEfI6Cz
 18rAJTmr/kd5ABa8vM3k6EmEs+fEc1CaFSVh5DAYo/8pvMNvIpll2S8aywKqOCSQBf3m
 aMCxA/faS8aPhB5vTH69EC1jvIU4Z5RUARrUJpkLC9DQiBoHhVlGMEKlTfMzDhXwQV04
 NaDLoxmUD/vO9wQjLjahwZqgM/kvHDvEkI+f7ARQs0dwIoZAqBP6Uhvz9UYoZFP/sXcw
 Ljb+UykokhItTE0TnhiAIwtBOX6yFv5YVkyWkwij4LhiJUEq9KDP2elvcy1E1U/aRUDR
 zG1g==
X-Gm-Message-State: AOJu0YyBhLPVAx/vR7FGDUWr0cyh2TI25DUXzHsBOx+eMYpzw2Kygl7x
 mXsI+LKIZ0nUIRgBHXN5PwxsliegvyEl6fcwuPlylitdS6xAFYsqVYIBLdDUhrpLx/6yqXwC4TE
 WrwAwbGobcim99BWQ9XRavZmBqMU02T78uNivNkRbSPjcER3KtIdPturABghpJThu
X-Gm-Gg: AZuq6aJWILujgPBdWqahRvrDUXZTsp9PoF1tJULev1iYFPe5OFr/uFQNO6uko3W1cL1
 8zkvM3RJwTqxp96AjhLy+c6h3sIRfjXpzDzfsEf+Fe2Qp1o0U2hXH1fP6wkss6MJxUrvZVGz6tR
 5PRCmACpf4YnqayEibl7pwVDCMQx3RDTbLl9Z5zffb96ZRnreAN8pq9ntwnjhKTMM7z8RLbZeAG
 p3A7JT/3JArpBrJbOZleEG9ECjKJJb5zswdeDsUL3CerNgU/aNRx4iL6SnRlyQKrlli7OngPqSE
 zPVY8Uom8094xOxt5zqjepwpYBg1ohUnK3GQnw1klre0C1IdImGPEGMBjtQzod/MpidP8kdliJS
 z+6nVioXTtpFwvElpm0BbW50ecMirA6xff/lJ4lm8KRAEGSxkM6jetSqtOGLe4rboLlNX
X-Received: by 2002:a05:600c:468b:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-4830e99d4cfmr93238575e9.33.1770302885069; 
 Thu, 05 Feb 2026 06:48:05 -0800 (PST)
X-Received: by 2002:a05:600c:468b:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-4830e99d4cfmr93238205e9.33.1770302884631; 
 Thu, 05 Feb 2026 06:48:04 -0800 (PST)
Received: from localhost
 (p200300cfd737d06375fda007e5d3c5c8.dip0.t-ipconnect.de.
 [2003:cf:d737:d063:75fd:a007:e5d3:c5c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d345c2sm81379965e9.6.2026.02.05.06.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:48:03 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 4/5] qcow2: Suppress data-file WRITE/RESIZE if possible
Date: Thu,  5 Feb 2026 15:47:34 +0100
Message-ID: <20260205144737.31131-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205144737.31131-1-hreitz@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When formatting a qcow2 image, we only need the WRITE permission on the
data-file child to preallocate data, so for metadata-only preallocation
(or none at all), we can suppress that permission via the
BDRV_O_NO_DATA_WRITE flag.

Similarly, we will only resize the data-file if it is currently smaller
than the supposed virtual disk size; so it is already big enough, we can
suppress the RESIZE permission via the BDRV_O_NO_DATA_RESIZE flag.

This commit allows creating a qcow2 image with an existing raw image as
its external data file while that raw image is in use by the VM.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b601bd540d..3adc06a9ee 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3627,6 +3627,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     size_t cluster_size;
     int version;
     int refcount_order;
+    int blk_flags;
     uint64_t *refcount_table;
     int ret;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
@@ -3887,20 +3888,42 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
      * table)
      */
     options = qdict_new();
+    blk_flags = BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH;
     qdict_put_str(options, "driver", "qcow2");
     qdict_put_str(options, "file", bs->node_name);
     if (data_bs) {
         qdict_put_str(options, "data-file", data_bs->node_name);
+
+        /*
+         * If possible, suppress the WRITE permission for the data-file child.
+         * We can only do so as long as none of the operations on `blk` will
+         * write to the data file.  Such writes can only happen during resize
+         * (which grows the image from length 0 to qcow2_opts->size) with data
+         * preallocation.  As long as no data preallocation has been requested,
+         * we can suppress taking the WRITE permission on data-file.
+         */
+        if (qcow2_opts->preallocation == PREALLOC_MODE_METADATA ||
+            qcow2_opts->preallocation == PREALLOC_MODE_OFF) {
+            blk_flags |= BDRV_O_NO_DATA_WRITE;
+        }
+
+        /*
+         * The data-file child is only grown if too small, never shrunk.  So if
+         * it already is big enough, we can suppress taking the RESIZE
+         * permission on it.
+         */
+        if (bdrv_co_getlength(data_bs) >= qcow2_opts->size) {
+            blk_flags |= BDRV_O_NO_DATA_RESIZE;
+        }
     }
-    blk = blk_co_new_open(NULL, NULL, options,
-                          BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
-                          errp);
+    blk = blk_co_new_open(NULL, NULL, options, blk_flags, errp);
     if (blk == NULL) {
         ret = -EIO;
         goto out;
     }
 
     bdrv_graph_co_rdlock();
+    /* O_NO_DATA_WRITE note: This will not write to data-file */
     ret = qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
     if (ret < 0) {
         bdrv_graph_co_rdunlock();
@@ -3919,7 +3942,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
-    /* Create a full header (including things like feature table) */
+    /*
+     * Create a full header (including things like feature table).
+     * O_NO_DATA_WRITE note: This will not write to data-file.
+     */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
 
@@ -3928,7 +3954,13 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         goto out;
     }
 
-    /* Okay, now that we have a valid image, let's give it the right size */
+    /*
+     * Okay, now that we have a valid image, let's give it the right size.
+     * O_NO_DATA_WRITE note: This will only write to data-file if data
+     * preallocation has been requested.
+     * O_NO_DATA_RESIZE note: We pass @exact = false, so the data-file is only
+     * resized if it is smaller than qcow2_opts->size.
+     */
     ret = blk_co_truncate(blk, qcow2_opts->size, false,
                           qcow2_opts->preallocation, 0, errp);
     if (ret < 0) {
@@ -3945,6 +3977,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
 
         bdrv_graph_co_rdlock();
+        /* O_NO_DATA_WRITE note: This will not write to data-file */
         ret = bdrv_co_change_backing_file(blk_bs(blk), qcow2_opts->backing_file,
                                           backing_format, false);
         bdrv_graph_co_rdunlock();
@@ -3960,6 +3993,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     /* Want encryption? There you go. */
     if (qcow2_opts->encrypt) {
         bdrv_graph_co_rdlock();
+        /* O_NO_DATA_WRITE note: This will not write to data-file */
         ret = qcow2_set_up_encryption(blk_bs(blk), qcow2_opts->encrypt, errp);
         bdrv_graph_co_rdunlock();
 
@@ -4401,6 +4435,15 @@ fail:
     return ret;
 }
 
+/**
+ * Resize the qcow2 image.
+ * To support BDRV_O_NO_DATA_WRITE and BDRV_O_NO_DATA_RESIZE from
+ * qcow2_co_create(), this function must:
+ * - If @exact is false, resize an external data file only if its size is less
+ *   than @offset
+ * - Only write to an external data file if @prealloc prescribes data
+ *   preallocation (FALLOC/FULL).
+ */
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
                   PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
@@ -4554,6 +4597,11 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
         break;
 
     case PREALLOC_MODE_METADATA:
+        /*
+         * Note for BDRV_O_NO_DATA_RESIZE and BDRV_O_NO_DATA_WRITE: This will
+         * not write data to an external data file, and will only resize it if
+         * its current length is less than `offset`.
+         */
         ret = preallocate_co(bs, old_length, offset, prealloc, errp);
         if (ret < 0) {
             goto fail;
@@ -4572,6 +4620,11 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
         /* With a data file, preallocation means just allocating the metadata
          * and forwarding the truncate request to the data file */
         if (has_data_file(bs)) {
+            /*
+             * Note for BDRV_O_NO_DATA_RESIZE and BDRV_O_NO_DATA_WRITE: This
+             * *will* write data to an external data file, but only resize it
+             * if its current length is less than `offset`.
+             */
             ret = preallocate_co(bs, old_length, offset, prealloc, errp);
             if (ret < 0) {
                 goto fail;
-- 
2.52.0


