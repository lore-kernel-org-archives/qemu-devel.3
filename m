Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05830D10C01
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 16:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4jgv-0007u3-Ji; Sat, 26 Oct 2024 12:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jgg-0007rz-BP; Sat, 26 Oct 2024 12:30:51 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be ([2a02:2c40:0:c0::25:134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jge-0003be-05; Sat, 26 Oct 2024 12:30:49 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1347A120.A0028
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:139:242:ac11:49])
 by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 1347A120;
 Sat, 26 Oct 2024 18:30:38 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (236.58-240-81.adsl-dyn.isp.belgacom.be
 [81.240.58.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id ED8DBD4F17F51; 
 Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id B07114B91F0; Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v4 4/5] block: allow commit to unmap zero blocks
Date: Sat, 26 Oct 2024 18:30:08 +0200
Message-ID: <20241026163010.2865002-5-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
References: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2c40:0:c0::25:134;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-4.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Non-active block commits do not discard blocks only containing zeros,
causing images to lose sparseness after the commit. This commit fixes
that by writing zero blocks using blk_co_pwrite_zeroes rather than
writing them out as any other arbitrary data.

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 5c24c8b80a..ca1a367b41 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -149,19 +149,39 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset,
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
2.44.1


