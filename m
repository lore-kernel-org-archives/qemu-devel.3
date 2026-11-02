Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B43606A935
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jKQwIIVy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvp-0006jv-PF; Mon, 02 Nov 2026 11:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvj-0006ex-Gz
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvg-0002LA-JF
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9hhlAkcrGliWFggE7ppOGsL+hEkXQAdW19xosQy6t8=;
 b=jKQwIIVymTKZmYtloa/Zg+dtw/jvoZKNllb3GjipFKP9VAVpBBrqjTjr6kbZ/lelqHpnvj
 /HNfiAp3JiDWU+LmVoTnaVVowoHcpXV65VmmnOdsSJAe4KhJ8FNtLQEw0J2rJd1IuSDR2R
 2eO7t0Qj7+kICtMwNeViMmTa38vJMjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-lBsGuWbtOUioSG_ZCmZldg-1; Mon,
 02 Nov 2026 11:30:37 -0500
X-MC-Unique: lBsGuWbtOUioSG_ZCmZldg-1
X-Mimecast-MFC-AGG-ID: lBsGuWbtOUioSG_ZCmZldg_1793637036
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 277201801354; Mon,  2 Nov 2026 16:30:36 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2B011956087; Mon,  2 Nov 2026 16:30:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 17/17] block/vmdk: add eos marker for stream optimized disks
Date: Mon,  2 Nov 2026 17:29:55 +0100
Message-ID: <20261102162955.268763-18-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sanne Raymaekers <sraymaek@redhat.com>

The end of stream marker should be at the very end of a stream optimized
disk. It consists of a regular marker struct with `val`, `size` and
`type` set to 0. It is then padded with more 0s to fill out a
sector. This effectively results in 512 zero bytes.[^1]

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
Message-ID: <20261016123750.94769-4-sraymaek@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index e090e122f11..b6e78a2b5d9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -195,6 +195,13 @@ typedef struct VmdkGrainMarker {
     uint8_t  data[];
 } QEMU_PACKED VmdkGrainMarker;
 
+typedef struct EosMarker {
+    uint64_t val;
+    uint32_t size;
+    uint32_t type;
+    uint8_t pad[512 - 16];
+} QEMU_PACKED EosMarker;
+
 enum {
     MARKER_END_OF_STREAM    = 0,
     MARKER_GRAIN_TABLE      = 1,
@@ -987,12 +994,7 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
             VMDK4Header header;
             uint8_t pad[512 - 4 - sizeof(VMDK4Header)];
 
-            struct {
-                uint64_t val;
-                uint32_t size;
-                uint32_t type;
-                uint8_t pad[512 - 16];
-            } QEMU_PACKED eos_marker;
+            EosMarker eos_marker;
         } QEMU_PACKED footer;
 
         ret = bdrv_pread(file, bs->file->bs->total_sectors * 512 - 1536,
@@ -2182,23 +2184,29 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
                            QEMUIOVector *qiov)
 {
     if (bytes == 0) {
-        /* The caller will write bytes 0 to signal EOF.
-         * When receive it, we align EOF to a sector boundary. */
+        /* The caller will write bytes 0 to signal EOF. */
         BDRVVmdkState *s = bs->opaque;
-        int i, ret;
+        int ret;
         int64_t length;
+        QEMU_AUTO_VFREE EosMarker *eos_marker = NULL;
 
-        for (i = 0; i < s->num_extents; i++) {
-            length = bdrv_co_getlength(s->extents[i].file->bs);
-            if (length < 0) {
-                return length;
-            }
-            length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
-            ret = bdrv_co_truncate(s->extents[i].file, length, false,
-                                   PREALLOC_MODE_OFF, 0, NULL);
-            if (ret < 0) {
-                return ret;
-            }
+        /* Stream optimized disks should only contain a single extent. */
+        assert(s->num_extents == 1);
+
+        /*
+         * Stream optimized disks end with an EOS marker,
+         * consisting of 512 null bytes.
+         */
+        eos_marker = qemu_blockalign0(bs, sizeof(EosMarker));
+        length = bdrv_co_getlength(s->extents[0].file->bs);
+        if (length < 0) {
+            return length;
+        }
+        length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
+        ret = bdrv_co_pwrite(s->extents[0].file, length, sizeof(EosMarker),
+                             eos_marker, 0);
+        if (ret < 0) {
+            return ret;
         }
         return 0;
     }
-- 
2.56.0


