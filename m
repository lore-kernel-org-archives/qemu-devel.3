Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF805606A89F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iBcqqD4G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Fn-0008EA-95; Mon, 16 Nov 2026 15:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3FQ-0007zj-Fo; Mon, 16 Nov 2026 15:24:19 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3FO-0004K9-Ii; Mon, 16 Nov 2026 15:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860377; bh=j2hHRS5f4ap7+3MeG3E5aWclqzwGN0li/WRdHxI/FrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iBcqqD4GcMekCTFbA2uUCK5pwfD0bJ9XVb9Dm559GArKE+88wQimlBSMnUxD6ScoI
 V+oFvXXz2TWA5bRpKdSY+PtVBirjqRHJzkkSjRzLxoNhTD7DkzZD7LIDXMa8XPAUEH
 YU5vFm5DqmNuI1Nhr7JWJ/DOyQs+jsx43zSJD0PtVcvqnkvZV73RaOrd/u3JG0ZaTZ
 4PWwsnM53//agoJLsjcnEL8An5oLzOYAoXwkalDY1u66yZPzVlcTmJewA8it/MRcgH
 7zAph4aJjYx0FWGex7W2gIdXlinu7XC9ghHNr+VyoPw9Lhijj5VvMv6mQh28c8Ima0
 024tRvEHl0liQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7A511E716C;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A538F45FBA1;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8E03EB8E32; Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 50/59] qcow2: fix snapshot data corruption with
 discard-no-unref=on
Date: Mon, 16 Nov 2026 23:18:54 +0300
Message-ID: <20261116201922.534306-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Whenever option discard-no-unref=on is enabled, we bypass refcount
machinery and unconditionally punch hole in the data on 'discard' and
'write -z -u' paths.  However, when this same cluster is also referenced
by an internal snapshot, such operations lead to problems.  The active L2
table is copied before it is changed, so the snapshot metadata stays
correct, but the host range under it is punched out and the snapshot reads
zeroes there afterwards. qemu-img check finds nothing wrong.

Fix this by guarding the 'keep_reference' flag by the presence of the
QCOW_OFLAG_COPIED bit.  I.e. only proceed with unconditional data
punching if we own this cluster exclusively.

Cc: qemu-stable@nongnu.org
Fixes: 42a2890a76f4 ("qcow2: add discard-no-unref option")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20261105161515.794213-3-andrey.drobyshev@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 3fe45543bf42ae60be1fb20e7f0b5dba6210e810)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 23eeb9fc560..8543c3b4873 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1953,6 +1953,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
         QCow2ClusterType cluster_type =
             qcow2_get_cluster_type(bs, old_l2_entry);
         bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED) &&
                               !full_discard &&
                               (s->discard_no_unref &&
                                type == QCOW2_DISCARD_REQUEST);
@@ -2099,8 +2100,9 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
         bool unmap = (type == QCOW2_CLUSTER_COMPRESSED) ||
             ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
-        bool keep_reference =
-            (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
+        bool keep_reference = s->discard_no_unref &&
+                              type != QCOW2_CLUSTER_COMPRESSED &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED);
         uint64_t new_l2_entry = old_l2_entry;
         uint64_t new_l2_bitmap = old_l2_bitmap;
 
-- 
2.47.3


