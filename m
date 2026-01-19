Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA72FD29C38
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqa8-0008P5-QD; Mon, 19 Jan 2026 09:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZl-00089t-8W; Mon, 19 Jan 2026 09:49:56 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZi-0008NU-DA; Mon, 19 Jan 2026 09:49:53 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BAE788079C;
 Mon, 19 Jan 2026 17:49:46 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gnaGbV0CCKo0-la3gfru8; Mon, 19 Jan 2026 17:49:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768834186;
 bh=ltRcaqsFk9h/Orn1pinLuc7naJ9gQSmnjhdHrEohM+8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=TpRyjDEPIutqLbDapwdq62yVivK4M3yz+T9YUBJj1g8FdZqL9uYby6rQ+xnk8PFpz
 hzSOY/NUnclPhQlcKe6WUzlOOVWQEUlnbGGTq5qgrXaMYgW+6CJ2fqEF1oIgKxRvmd
 Y6SU17axKmxJuf4qkF3NQ3dK1y/t7uabBxsqwWTA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v10 3/8] block: make bdrv_find_child() function public
Date: Mon, 19 Jan 2026 17:49:36 +0300
Message-ID: <20260119144941.87936-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119144941.87936-1-vsementsov@yandex-team.ru>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To be reused soon for blockdev-replace functionality.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block.c                      | 13 +++++++++++++
 blockdev.c                   | 14 --------------
 include/block/block_int-io.h |  2 ++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index 48a17f393c..b13d06f709 100644
--- a/block.c
+++ b/block.c
@@ -8288,6 +8288,19 @@ int bdrv_make_empty(BdrvChild *c, Error **errp)
     return 0;
 }
 
+BdrvChild *bdrv_find_child(BlockDriverState *parent_bs, const char *child_name)
+{
+    BdrvChild *child;
+
+    QLIST_FOREACH(child, &parent_bs->children, next) {
+        if (strcmp(child->name, child_name) == 0) {
+            return child;
+        }
+    }
+
+    return NULL;
+}
+
 /*
  * Return the child that @bs acts as an overlay for, and from which data may be
  * copied in COW or COR operations.  Usually this is the backing file.
diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..2540f991b3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3569,20 +3569,6 @@ unlock:
     }
 }
 
-static BdrvChild * GRAPH_RDLOCK
-bdrv_find_child(BlockDriverState *parent_bs, const char *child_name)
-{
-    BdrvChild *child;
-
-    QLIST_FOREACH(child, &parent_bs->children, next) {
-        if (strcmp(child->name, child_name) == 0) {
-            return child;
-        }
-    }
-
-    return NULL;
-}
-
 void qmp_x_blockdev_change(const char *parent, const char *child,
                            const char *node, Error **errp)
 {
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index ed8b5657d6..8ff3bc6d87 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -130,6 +130,8 @@ bdrv_co_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 int co_wrapper_mixed_bdrv_rdlock
 bdrv_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
+BdrvChild * GRAPH_RDLOCK
+bdrv_find_child(BlockDriverState *parent_bs, const char *child_name);
 BdrvChild * GRAPH_RDLOCK bdrv_cow_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_filter_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_filter_or_cow_child(BlockDriverState *bs);
-- 
2.52.0


