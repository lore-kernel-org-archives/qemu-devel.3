Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08776112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M5S-0004NJ-Pt; Wed, 11 Mar 2026 12:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5L-00046S-Qh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5D-0005uG-3T
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FguOM5DVkqLFtBQkSA9wG1Nr+QxkYNGwvgghCA90PHc=;
 b=a3N1LkeuUthnT7T3uztSLact0MzcQgrN1VT7EddhDNNqfyrFcJs9zk7SXy5DVx4IQA6fY3
 j/Sr741ZeWgXFh8/fZi1JGgbqn5++yw81Lp/uWddgSEceHexzH5atGt+3fkXtonNfLSqLB
 vEGc7ClULPcv7Q9rJlVc7c43bjT05/s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-7FTxjHL2PyafLL4D6Hazdg-1; Wed, 11 Mar 2026 12:06:49 -0400
X-MC-Unique: 7FTxjHL2PyafLL4D6Hazdg-1
X-Mimecast-MFC-AGG-ID: 7FTxjHL2PyafLL4D6Hazdg_1773245208
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853b5b0fafso58345e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245208; x=1773850008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FguOM5DVkqLFtBQkSA9wG1Nr+QxkYNGwvgghCA90PHc=;
 b=BimtWXAPcZqg6QdYyYWOQ6uMYh4rZCCGYBtQa6BVIBvWLUj9o1/gM0TvZ/0tUcoent
 D7tFynM2C6oropp9MjcHi6qW2TNjsd2AytIyPrstPGs9iFeVjfe/F7nDW+4/LByshyv7
 O+HwSb4o7iLkwy4eHn/LQz/9QCyp4bW07Rmk9YxE4bX8OIbybqAJrlf6ULERdL9w5nuG
 +nz6DZRfGI8GOH9UmA+DhJMRzw8W2Wx4paUXzfVO2Lkf5ez9oJ/1NbqI01SIYj6Sg4sW
 J63e7RTRTLCHvbvBG+v9usF+68GG9mkEj+7bMWZvLAOKbDNABJlOeOoJRChEm1JIrW1X
 wG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245208; x=1773850008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FguOM5DVkqLFtBQkSA9wG1Nr+QxkYNGwvgghCA90PHc=;
 b=CQEYq2ZuLI/hvK1h1i7oDR77VuOHfJULJwa4+DxaIs4Cmm/rweQdtGZMPaCPzAH/LS
 mlz7q0Oq7O5RtYuVci3g5o1aELT7HCMLVvpD15T6QGquefOfGp4amQ3/BfXc4GNoJJaf
 Lc03wrwzg6XJV20YL2b8sIF6ErTGmDe3Mg7wzV3cFPBm0pOQI5EbXZqjC434/AiqLDVQ
 Lo47rE6bCm+awkDfyLT1t5I+hbSPVyN8RGj9HTBFDi7Ttl8fpDqo8EaJAPf0ONi55ziA
 wYZRT9amIFtP8fV86bGYcgPLpGYeHP+OwgR3/7H/bySPCJt28Y0DYhgAYuS0J/mBwGm2
 4Xvg==
X-Gm-Message-State: AOJu0YyRRtRbxVV6sKBMSSSTocna1rkr4cuI04sF6c5R8AcO2Z6TMNtn
 MGVBC6KUGuxw4fcXvg7N2ZT+ymz2Svo+mt7BZulEDDM1p7uQXd+PtOq5fTyQAr2BfMFdzM40Iho
 uaqLelD6Rcyv8SJr480a7o9WKnhByMVBs9bG43m0eoNKrX/FpC/qveUH5
X-Gm-Gg: ATEYQzwO/mVFZCqGABR1KbfDHpFLqSEZOtMeXzvSbSV8qvfFHS/zhXc35ZEo72xAEtb
 +e2njpsnKafagsyyfF/Ki6sLIRfmdH/RV+rf8yTmP0mtVU5x5jzau6CjVhHGJm2FznZsWbNVXPq
 6rRvHLCfmRwzFnb4yX5XQN2hwyKSQbjejTMrn3siN0ymIRr74l8F29rJLMzOG7CQSsKudQQBaSW
 C0s662gDo4NyUp9maZXc+TvS5gn2AFLsc7XILt73Yqub9UsocetTu97t/xZSLN8AwaFZ9zL58ah
 I5ipi6Gc/MHmhfiS+IUeior7KNLP7MYeJWARZcb5yEFdbykSlL2vLxvRmYZrsewcjBzgmBzZcZq
 bC+pzLFrUJ+2n6Wg1h5p4OB0TCPIh/QhiyQi0XXsfwh7ambefqLj4x6DK1C2mzsubVG1naym7SG
 14yD3N
X-Received: by 2002:a05:600c:1f0e:b0:485:35ba:1d81 with SMTP id
 5b1f17b1804b1-4854b12cee4mr55450365e9.21.1773245207405; 
 Wed, 11 Mar 2026 09:06:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1f0e:b0:485:35ba:1d81 with SMTP id
 5b1f17b1804b1-4854b12cee4mr55449685e9.21.1773245206950; 
 Wed, 11 Mar 2026 09:06:46 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0216f12b1cbc4c9e6fd.dip0.t-ipconnect.de.
 [2003:cf:d737:d021:6f12:b1cb:c4c9:e6fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e9179sm61447595e9.3.2026.03.11.09.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:45 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 5/6] qcow2: Suppress data-file WRITE/RESIZE if possible
Date: Wed, 11 Mar 2026 17:06:27 +0100
Message-ID: <20260311160628.344838-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311160628.344838-1-hreitz@redhat.com>
References: <20260311160628.344838-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

When formatting a qcow2 image, we only need the WRITE permission on the
data-file child to preallocate data, so for metadata-only preallocation
(or none at all), we can suppress that permission via the BDRV_O_NO_IO
flag.  That promises to actually not do any I/O at all, but writing is
actually the only thing we would do, so it applies.  (BDRV_O_NO_IO does
not preclude reading/writing from/to the metadata file.)

Similarly, we will only resize the data-file if it is currently smaller
than the supposed virtual disk size; so it is already big enough, we can
suppress the RESIZE permission by removing the BDRV_O_RESIZE flag.

This commit allows creating a qcow2 image with an existing raw image as
its external data file while that raw image is in use by the VM.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index dd0f47c0ff..00958a0552 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3641,6 +3641,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     size_t cluster_size;
     int version;
     int refcount_order;
+    int blk_flags;
     uint64_t *refcount_table;
     int ret;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
@@ -3908,20 +3909,48 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
+         * If possible, suppress all permissions we can.  We must keep the
+         * BDRV_O_RDWR flag because the metadata child must still be written,
+         * but we can add BDRV_O_NO_IO if we know that the data file child will
+         * not receive any I/O, to suppress taking the WRITE permission on it.
+         * We can only do so as long as none of the operations on `blk` will
+         * do I/O on the data file.  Such I/O accesses can only happen during
+         * resize (which grows the image from length 0 to qcow2_opts->size) with
+         * data preallocation.  So as long as no data preallocation has been
+         * requested, BDRV_O_NO_IO will work.
+         */
+        if (qcow2_opts->preallocation == PREALLOC_MODE_METADATA ||
+            qcow2_opts->preallocation == PREALLOC_MODE_OFF) {
+            blk_flags |= BDRV_O_NO_IO;
+        }
+
+        /*
+         * Similarly for BDRV_O_RESIZE: Suppressing it means we will not take
+         * the RESIZE permission.  The data-file child is only grown if too
+         * small, never shrunk; so if it already is big enough, no need for
+         * BDRV_O_RESIZE.
+         */
+        bdrv_graph_co_rdlock();
+        if (bdrv_co_getlength(data_bs) >= (int64_t)qcow2_opts->size) {
+            blk_flags &= ~BDRV_O_RESIZE;
+        }
+        bdrv_graph_co_rdunlock();
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
+    /* BDRV_O_NO_IO note: No data-file I/O */
     ret = qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
     if (ret < 0) {
         bdrv_graph_co_rdunlock();
@@ -3940,7 +3969,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
-    /* Create a full header (including things like feature table) */
+    /*
+     * Create a full header (including things like feature table).
+     * BDRV_O_NO_IO note: No data-file I/O
+     */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
 
@@ -3949,7 +3981,13 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         goto out;
     }
 
-    /* Okay, now that we have a valid image, let's give it the right size */
+    /*
+     * Okay, now that we have a valid image, let's give it the right size.
+     * BDRV_O_NO_IO note: This will only read/write from/to data-file if data
+     * preallocation has been requested.
+     * BDRV_O_RESIZE note: We pass @exact = false, so the data-file is only
+     * resized if it is smaller than qcow2_opts->size.
+     */
     bdrv_graph_co_rdlock();
     ret = qcow2_co_truncate(blk_bs(blk), qcow2_opts->size, false,
                             qcow2_opts->preallocation, 0, errp);
@@ -3968,6 +4006,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
 
         bdrv_graph_co_rdlock();
+        /* BDRV_O_NO_IO note: No data-file I/O */
         ret = bdrv_co_change_backing_file(blk_bs(blk), qcow2_opts->backing_file,
                                           backing_format, false);
         bdrv_graph_co_rdunlock();
@@ -3983,6 +4022,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     /* Want encryption? There you go. */
     if (qcow2_opts->encrypt) {
         bdrv_graph_co_rdlock();
+        /* BDRV_O_NO_IO note: No data-file I/O */
         ret = qcow2_set_up_encryption(blk_bs(blk), qcow2_opts->encrypt, errp);
         bdrv_graph_co_rdunlock();
 
@@ -4481,6 +4521,15 @@ fail:
     return ret;
 }
 
+/**
+ * Resize the qcow2 image.
+ * To support BDRV_O_NO_IO and !BDRV_O_RESIZE from qcow2_co_create(), this
+ * function must:
+ * - If @exact is false, resize an external data file only if its size is less
+ *   than @offset
+ * - Only access (write to) an external data file if @prealloc prescribes data
+ *   preallocation (FALLOC/FULL).
+ */
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
                   PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
@@ -4634,6 +4683,11 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
         break;
 
     case PREALLOC_MODE_METADATA:
+        /*
+         * Note for BDRV_O_NO_IO and !BDRV_O_RESIZE: This will not do I/O on an
+         * external data file, and will only resize it if its current length is
+         * less than `offset`.
+         */
         ret = preallocate_co(bs, old_length, offset, prealloc, errp);
         if (ret < 0) {
             goto fail;
@@ -4652,6 +4706,11 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
         /* With a data file, preallocation means just allocating the metadata
          * and forwarding the truncate request to the data file */
         if (has_data_file(bs)) {
+            /*
+             * Note for BDRV_O_NO_IO and !BDRV_O_RESIZE: This *will* write data
+             * to an external data file, but only resize it if its current
+             * length is less than `offset`.
+             */
             ret = preallocate_co(bs, old_length, offset, prealloc, errp);
             if (ret < 0) {
                 goto fail;
-- 
2.53.0


