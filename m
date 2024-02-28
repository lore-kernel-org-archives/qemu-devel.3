Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55913C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 14:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfKij-0003td-4o; Wed, 28 Feb 2024 09:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfKiZ-0003p4-Dk; Wed, 28 Feb 2024 09:15:32 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfKiV-00025r-HQ; Wed, 28 Feb 2024 09:15:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 97E5360AD1;
 Wed, 28 Feb 2024 17:15:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a522::1:14])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4FaAWa1Of0U0-7apANUOm; Wed, 28 Feb 2024 17:15:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709129716;
 bh=L5q+CYOmRfNevs8m8vD/BAKMWEc8QPFpWMwHiaSeWUk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pTU7XF0F0+05E2q1ba5WZSujAfBoY1p/ISC1sXl0rl9nXjCGUYPdnF/Mbh24M91AR
 eJgOo1aOUzzx2QngdFYG0By/2Z4D3lwPLTNd89rkiUgUDSqSf8mkM9cBT0oWFSlVOM
 rb2g/ExIwWn4RXU3HNaS2jdXFtKhZ0ya7d9qLdcM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com, den@virtuozzo.com, alexander.ivanov@virtuozzo.com
Subject: [PATCH v3 1/5] block/copy-before-write: fix permission
Date: Wed, 28 Feb 2024 17:14:57 +0300
Message-Id: <20240228141501.455989-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228141501.455989-1-vsementsov@yandex-team.ru>
References: <20240228141501.455989-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In case when source node does not have any parents, the condition still
works as required: backup job do create the parent by

  block_job_create -> block_job_add_bdrv -> bdrv_root_attach_child

Still, in this case checking @perm variable doesn't work, as backup job
creates the root blk with empty permissions (as it rely on CBW filter
to require correct permissions and don't want to create extra
conflicts).

So, we should not check @perm.

The hack may be dropped entirely when transactional insertion of
filter (when we don't try to recalculate permissions in intermediate
state, when filter does conflict with original parent of the source
node) merged (old big series
"[PATCH v5 00/45] Transactional block-graph modifying API"[1] and it's
current in-flight part is "[PATCH v8 0/7] blockdev-replace"[2])

[1] https://patchew.org/QEMU/20220330212902.590099-1-vsementsov@openvz.org/
[2] https://patchew.org/QEMU/20231017184444.932733-1-vsementsov@yandex-team.ru/

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/copy-before-write.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 0842a1a6df..3919d495d7 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -364,9 +364,13 @@ cbw_child_perm(BlockDriverState *bs, BdrvChild *c, BdrvChildRole role,
                            perm, shared, nperm, nshared);
 
         if (!QLIST_EMPTY(&bs->parents)) {
-            if (perm & BLK_PERM_WRITE) {
-                *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
-            }
+            /*
+             * Note, that source child may be shared with backup job. Backup job
+             * does create own blk parent on copy-before-write node, so this
+             * works even if source node does not have any parents before backup
+             * start
+             */
+            *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
             *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
         }
     }
-- 
2.34.1


