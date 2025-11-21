Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62275CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd6B-00046u-Tl; Fri, 21 Nov 2025 21:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcsv-0007fj-Qe; Fri, 21 Nov 2025 20:57:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcrX-0007RP-TZ; Fri, 21 Nov 2025 20:57:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0DEB016CA78;
 Fri, 21 Nov 2025 21:44:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BFFA5321CB4;
 Fri, 21 Nov 2025 21:44:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vincent Vanlaer <libvirt-e6954efa@volkihar.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 61/81] block: allow commit to unmap zero blocks
Date: Fri, 21 Nov 2025 21:44:00 +0300
Message-ID: <20251121184424.1137669-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>

Non-active block commits do not discard blocks only containing zeros,
causing images to lose sparseness after the commit. This commit fixes
that by writing zero blocks using blk_co_pwrite_zeroes rather than
writing them out as any other arbitrary data.

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20241026163010.2865002-5-libvirt-e6954efa@volkihar.be>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 6f3199f99600fe75f32f78574e507f347de80854)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/commit.c b/block/commit.c
index 5c6596a52e..7cc8c0f0df 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -150,19 +150,39 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset,
     }
 
     if (ret & BDRV_BLOCK_ALLOCATED) {
-        assert(bytes < SIZE_MAX);
+        if (ret & BDRV_BLOCK_ZERO) {
+            /*
+             * If the top (sub)clusters are smaller than the base
+             * (sub)clusters, this will not unmap unless the underlying device
+             * does some tracking of these requests. Ideally, we would find
+             * the maximal extent of the zero clusters.
+             */
+            ret = blk_co_pwrite_zeroes(s->base, offset, bytes,
+                                       BDRV_REQ_MAY_UNMAP);
+            if (ret < 0) {
+                error_in_source = false;
+                goto fail;
+            }
+        } else {
+            assert(bytes < SIZE_MAX);
 
-        ret = blk_co_pread(s->top, offset, bytes, buf, 0);
-        if (ret < 0) {
-            goto fail;
-        }
+            ret = blk_co_pread(s->top, offset, bytes, buf, 0);
+            if (ret < 0) {
+                goto fail;
+            }
 
-        ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
-        if (ret < 0) {
-            error_in_source = false;
-            goto fail;
+            ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
+            if (ret < 0) {
+                error_in_source = false;
+                goto fail;
+            }
         }
 
+        /*
+         * Whether zeroes actually end up on disk depends on the details of
+         * the underlying driver. Therefore, this might rate limit more than
+         * is necessary.
+         */
         block_job_ratelimit_processed_bytes(&s->common, bytes);
     }
 
-- 
2.47.3


