Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129FCC3DA40
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMREC-0006Ks-DQ; Wed, 26 Jun 2024 07:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMREB-0006KW-8F; Wed, 26 Jun 2024 07:54:19 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMRE4-0007Hi-U5; Wed, 26 Jun 2024 07:54:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4D9A060E2D;
 Wed, 26 Jun 2024 14:54:10 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id prOe6Z0rMmI0-VYC6R2g3; Wed, 26 Jun 2024 14:54:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719402849;
 bh=/pnmAqrbOXFL3OPHCDjHkuJp9TZyJdxaMJV1Ci8Hhq0=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OArfMQVkPkfaBl9LT7bfNaSMuA+5jJTNC/HaEEU+I2TiHKedpRCB+CigHJQ1rl3n/
 SJ+UGYHfX9yntk73eG1NuKdA/hrxrxrVIr9QziUHNDkjujZVf1ThLoMi7s9JO+Uthv
 mMw4YiEOPSQ4puXEVczZLPzobpkEmMUuIal1z3Ds=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v9 3/7] block: make bdrv_find_child() function public
Date: Wed, 26 Jun 2024 14:53:46 +0300
Message-Id: <20240626115350.405778-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626115350.405778-1-vsementsov@yandex-team.ru>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

To be reused soon for blockdev-replace functionality.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block.c                      | 13 +++++++++++++
 blockdev.c                   | 14 --------------
 include/block/block_int-io.h |  2 ++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index 468cf5e67d..f6292f459a 100644
--- a/block.c
+++ b/block.c
@@ -8174,6 +8174,19 @@ int bdrv_make_empty(BdrvChild *c, Error **errp)
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
index 835064ed03..ba7e90b06e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3452,20 +3452,6 @@ void qmp_blockdev_del(const char *node_name, Error **errp)
     bdrv_unref(bs);
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
index 4a7cf2b4fd..11ed4aa927 100644
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
2.34.1


