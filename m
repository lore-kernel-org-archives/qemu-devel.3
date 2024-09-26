Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A257BCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 10:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stlpI-0007On-Rk; Thu, 26 Sep 2024 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66f53402.v1-468271bc01d8452aa5f20c3e490bcf15@bounce.vates.tech>)
 id 1stlpD-0006q7-AB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:34:19 -0400
Received: from mail177-9.suw61.mandrillapp.com ([198.2.177.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66f53402.v1-468271bc01d8452aa5f20c3e490bcf15@bounce.vates.tech>)
 id 1stlp3-0002IQ-JW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1727345667; x=1727606167;
 bh=DRimZkyYpcmRSMJFhksb4hjZDJ7L7Xbrn74CwG57nLQ=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=YxtWIggBTflIkpwreiigs3s3C/ixmLF6QvMrUtb/1YvQ5nYUTgxJvLoKQtMbpigA4
 mlxy+iQrNCUdUa0HbzUEgVo73HkzkTwQy88XYMc8LJhgyOXJIZg2jpRPMWDSxSSzNw
 wCkSsWpwoDoHg6cQlvr1gBxBU/WygD3ki25nUfrp1+byiPW516Ek9aNtqMuzW/YEvs
 SIgewiGjh5NQ6lo2EWi+Mj+P8s4C2G4lNjK0arUuh8yUK7ahOT94zg3fhVCJaAAJzm
 mLHvfufez3qWfDS1CS9Kpk63pLdrSGTzHqqXEFauEi0foa9c+/8IbBf0mVkzPggi7D
 uGCB02oVTWimA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1727345667; x=1727606167; i=anthony.perard@vates.tech;
 bh=DRimZkyYpcmRSMJFhksb4hjZDJ7L7Xbrn74CwG57nLQ=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=a/jTHymjWLABeOl0YvoklvLJ2raGhtWUw1L62ibkXJLEUMfhATptKhYvxfIcmXSZ5
 yUr5kgIVpmLSLRlWVwpGvlIb7wgsC5fKxTeL0MCaYG2LCZGZZqKjMn2HAm8YiuZ7+g
 xo2bOrnKK6yzPhVZ+W1iQ2JyfjpJJdnHifFe/ksEHQXUsS1UDoNls4kipG6qNYFJoP
 wZY3v/Qq6FT/CLtbMoEbtaABtABH/9m7RoUNX0BGzsERlfPa8uz1TyIXDmVMnT2UtZ
 KaOrhrn87tnyXw8ic3k8SWNeR5OBC3IKGwHMo6ihLQTEuN1Ykf+WFcpGEzWEvZb9d5
 LxQ4i4izMNnBA==
Received: from pmta14.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail177-9.suw61.mandrillapp.com (Mailchimp) with ESMTP id 4XDqFv0WdkzK5vrsx
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 10:14:27 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PATCH=202/2]=20hw/block/xen-block:=20Update=20sector-size=20handling?=
Received: from [37.26.189.201] by mandrillapp.com id
 468271bc01d8452aa5f20c3e490bcf15; Thu, 26 Sep 2024 10:14:26 +0000
X-Mailer: git-send-email 2.39.2
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1727345665867
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@vates.tech>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Message-Id: <20240926101334.2388-3-anthony.perard@vates.tech>
In-Reply-To: <20240926101334.2388-1-anthony.perard@vates.tech>
References: <20240926101334.2388-1-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.468271bc01d8452aa5f20c3e490bcf15?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240926:md
Date: Thu, 26 Sep 2024 10:14:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.177.9;
 envelope-from=bounce-md_30504962.66f53402.v1-468271bc01d8452aa5f20c3e490bcf15@bounce.vates.tech;
 helo=mail177-9.suw61.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The use of "feature-large-sector-size" have been removed from the
protocol, as it hasn't been evenly implemented across all backend and
frontend. Linux for example will happily expose "sector-size" != 512
even when "feature-large-sector-size" hasn't been set by the frontend.

The specification have been clarified regarding what "sector" is by
Xen commit 221f2748e8da ("blkif: reconcile protocol specification with
in-use implementations").

https://xenbits.xenproject.org/gitweb/?p=xen.git;a=commit;h=221f2748e8dabe8361b8cdfcffbeab9102c4c899

So change QEMU to follow the updated specification.

Frontends that exposes "feature-large-sector-size" will most certainly
misbehave if "sector-size" is different than 512, so don't even try.
(Windows driver is likely to be the only one having implemented it.)

Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/block/dataplane/xen-block.c | 31 ++++++++++++++++++++++---------
 hw/block/xen-block.c           |  8 ++++----
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 98501e6885..43be97b4f3 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -176,7 +176,11 @@ static int xen_block_parse_request(XenBlockRequest *request)
         goto err;
     }
 
-    request->start = request->req.sector_number * dataplane->sector_size;
+    request->start = request->req.sector_number * XEN_BLKIF_SECTOR_SIZE;
+    if (!QEMU_IS_ALIGNED(request->start, dataplane->sector_size)) {
+        error_report("error: sector_number missaligned with sector-size");
+        goto err;
+    }
     for (i = 0; i < request->req.nr_segments; i++) {
         if (i == BLKIF_MAX_SEGMENTS_PER_REQUEST) {
             error_report("error: nr_segments too big");
@@ -186,14 +190,23 @@ static int xen_block_parse_request(XenBlockRequest *request)
             error_report("error: first > last sector");
             goto err;
         }
-        if (request->req.seg[i].last_sect * dataplane->sector_size >=
+        if (request->req.seg[i].last_sect * XEN_BLKIF_SECTOR_SIZE >=
             XEN_PAGE_SIZE) {
             error_report("error: page crossing");
             goto err;
         }
+        if (!QEMU_IS_ALIGNED(request->req.seg[i].first_sect,
+                             dataplane->sector_size / XEN_BLKIF_SECTOR_SIZE)) {
+            error_report("error: first_sect missaligned with sector-size");
+            goto err;
+        }
 
         len = (request->req.seg[i].last_sect -
-               request->req.seg[i].first_sect + 1) * dataplane->sector_size;
+               request->req.seg[i].first_sect + 1) * XEN_BLKIF_SECTOR_SIZE;
+        if (!QEMU_IS_ALIGNED(len, dataplane->sector_size)) {
+            error_report("error: segment size missaligned with sector-size");
+            goto err;
+        }
         request->size += len;
     }
     if (request->start + request->size > blk_getlength(dataplane->blk)) {
@@ -227,17 +240,17 @@ static int xen_block_copy_request(XenBlockRequest *request)
         if (to_domain) {
             segs[i].dest.foreign.ref = request->req.seg[i].gref;
             segs[i].dest.foreign.offset = request->req.seg[i].first_sect *
-                dataplane->sector_size;
+                XEN_BLKIF_SECTOR_SIZE;
             segs[i].source.virt = virt;
         } else {
             segs[i].source.foreign.ref = request->req.seg[i].gref;
             segs[i].source.foreign.offset = request->req.seg[i].first_sect *
-                dataplane->sector_size;
+                XEN_BLKIF_SECTOR_SIZE;
             segs[i].dest.virt = virt;
         }
         segs[i].len = (request->req.seg[i].last_sect -
                        request->req.seg[i].first_sect + 1) *
-                      dataplane->sector_size;
+                      XEN_BLKIF_SECTOR_SIZE;
         virt += segs[i].len;
     }
 
@@ -331,12 +344,12 @@ static bool xen_block_split_discard(XenBlockRequest *request,
 
     /* Wrap around, or overflowing byte limit? */
     if (sec_start + sec_count < sec_count ||
-        sec_start + sec_count > INT64_MAX / dataplane->sector_size) {
+        sec_start + sec_count > INT64_MAX / XEN_BLKIF_SECTOR_SIZE) {
         return false;
     }
 
-    byte_offset = sec_start * dataplane->sector_size;
-    byte_remaining = sec_count * dataplane->sector_size;
+    byte_offset = sec_start * XEN_BLKIF_SECTOR_SIZE;
+    byte_remaining = sec_count * XEN_BLKIF_SECTOR_SIZE;
 
     do {
         byte_chunk = byte_remaining > BDRV_REQUEST_MAX_BYTES ?
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..8c150c6c69 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -189,10 +189,10 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
         feature_large_sector_size = 0;
     }
 
-    if (feature_large_sector_size != 1 &&
+    if (feature_large_sector_size == 1 &&
         conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
-        error_setg(errp, "logical_block_size != %u not supported by frontend",
-                   XEN_BLKIF_SECTOR_SIZE);
+        error_setg(errp,
+                   "\"feature-large-sector-size\" not supported by backend");
         return;
     }
 
@@ -294,7 +294,7 @@ static void xen_block_set_size(XenBlockDevice *blockdev)
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->props.vdev;
     BlockConf *conf = &blockdev->props.conf;
-    int64_t sectors = blk_getlength(conf->blk) / conf->logical_block_size;
+    int64_t sectors = blk_getlength(conf->blk) / XEN_BLKIF_SECTOR_SIZE;
     XenDevice *xendev = XEN_DEVICE(blockdev);
 
     trace_xen_block_size(type, vdev->disk, vdev->partition, sectors);
-- 


Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

