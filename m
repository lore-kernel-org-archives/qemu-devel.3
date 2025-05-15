Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE5C3ABD8
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOLm-0007ES-EG; Wed, 14 May 2025 22:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLg-0007Cp-Kb
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLe-00044j-53
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNn7XmBDCdTmBMEw7iLABOhXxi/Bie5Kt8CPOKA+jNE=;
 b=OETPs5FbzyZxyoQnTmGe6cmn+LGOQtLgPssNDrLeWL717/IqQzjZwgBcl/G9UYnJbL81wA
 HrEHkw/EPDp35AUD5ObJ4AnZcisPh6u+1S0JG54kwswe2Oe+W2Gwl7baCy6aTW49rDK73v
 POn381r3/6g0pcDQeGodXJK88YPsC94=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-3rX4luaoMjS1lAtoMEC52w-1; Wed,
 14 May 2025 22:29:21 -0400
X-MC-Unique: 3rX4luaoMjS1lAtoMEC52w-1
X-Mimecast-MFC-AGG-ID: 3rX4luaoMjS1lAtoMEC52w_1747276161
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B7B9195608A; Thu, 15 May 2025 02:29:20 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2EC71953B80; Thu, 15 May 2025 02:29:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block I/O path)
Subject: [PULL 03/14] block: Let bdrv_co_is_zero_fast consolidate adjacent
 extents
Date: Wed, 14 May 2025 21:28:46 -0500
Message-ID: <20250515022904.575509-19-eblake@redhat.com>
In-Reply-To: <20250515022904.575509-16-eblake@redhat.com>
References: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Some BDS drivers have a cap on how much block status they can supply
in one query (for example, NBD talking to an older server cannot
inspect more than 4G per query; and qcow2 tends to cap its answers
rather than cross a cluster boundary of an L1 table).  Although the
existing callers of bdrv_co_is_zero_fast are not passing in that large
of a 'bytes' parameter, an upcoming caller wants to query the entire
image at once, and will thus benefit from being able to treat adjacent
zero regions in a coalesced manner, rather than claiming the region is
non-zero merely because pnum was truncated and didn't match the
incoming bytes.

While refactoring this into a loop, note that there is no need to
assign pnum prior to calling bdrv_co_common_block_status_above() (it
is guaranteed to be assigned deeper in the callstack).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250509204341.3553601-18-eblake@redhat.com>
---
 block/io.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index b5b143cd1b0..50dc0e193f0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2751,28 +2751,31 @@ int coroutine_fn bdrv_co_block_status(BlockDriverState *bs, int64_t offset,
  * by @offset and @bytes is known to read as zeroes.
  * Return 1 if that is the case, 0 otherwise and -errno on error.
  * This test is meant to be fast rather than accurate so returning 0
- * does not guarantee non-zero data.
+ * does not guarantee non-zero data; but a return of 1 is reliable.
  */
 int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
                                       int64_t bytes)
 {
     int ret;
-    int64_t pnum = bytes;
+    int64_t pnum;
     IO_CODE();

-    if (!bytes) {
-        return 1;
+    while (bytes) {
+        ret = bdrv_co_common_block_status_above(bs, NULL, false,
+                                                BDRV_WANT_ZERO, offset, bytes,
+                                                &pnum, NULL, NULL, NULL);
+
+        if (ret < 0) {
+            return ret;
+        }
+        if (!(ret & BDRV_BLOCK_ZERO)) {
+            return 0;
+        }
+        offset += pnum;
+        bytes -= pnum;
     }

-    ret = bdrv_co_common_block_status_above(bs, NULL, false, BDRV_WANT_ZERO,
-                                            offset, bytes, &pnum, NULL, NULL,
-                                            NULL);
-
-    if (ret < 0) {
-        return ret;
-    }
-
-    return (pnum == bytes) && (ret & BDRV_BLOCK_ZERO);
+    return 1;
 }

 int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset,
-- 
2.49.0


