Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F0AC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 00:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u87LX-0006bS-KE; Thu, 24 Apr 2025 20:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LS-0006V1-HP
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LQ-0000i4-0E
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745542506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mp8jz+1BcXAdMIlc1C2i9pFAxzOJBCrZpHHsY/LwbF8=;
 b=M+NUYap5YEQHZgFqV2En2aJAIAVQ3aYshSzVGTRJHf4x27nK396TskAz99CuFSYoGZbxNK
 MNqlRNJ/l7ds/bc7eL3++ALl5QvkN8VZZEkJpPHYt3zATwfzJJxsBWhpsuJaKKdtPnoVn9
 QTEr2J4Yw91PYPWOchG8AjGRIXgvcXA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-JjXkulD3OyCak1KbLUJlng-1; Thu,
 24 Apr 2025 20:55:04 -0400
X-MC-Unique: JjXkulD3OyCak1KbLUJlng-1
X-Mimecast-MFC-AGG-ID: JjXkulD3OyCak1KbLUJlng_1745542503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B4DB1956088; Fri, 25 Apr 2025 00:55:03 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A40E1800378; Fri, 25 Apr 2025 00:55:01 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, stefanha@redhat.com,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 03/11] block: Let bdrv_co_is_zero_fast consolidate adjacent
 extents
Date: Thu, 24 Apr 2025 19:52:03 -0500
Message-ID: <20250425005439.2252467-16-eblake@redhat.com>
In-Reply-To: <20250425005439.2252467-13-eblake@redhat.com>
References: <20250425005439.2252467-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

---

v3: also tweak function comment
---
 block/io.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index 056af8198bc..d3bd1211acf 100644
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


