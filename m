Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E02CEE326
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYmm-00022c-8p; Wed, 09 Oct 2024 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syYmg-00021k-6e; Wed, 09 Oct 2024 11:39:30 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syYme-0002xo-94; Wed, 09 Oct 2024 11:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=9Me8+M24oeDdSkwQMSL03lioi+ooJD4Td8kWHGwxc9o=; b=Fx90vqUDHTbV
 DUK0EFB13p3QOU/KtmNGQWLkoCiBUrF14V/TbVVtPyv3xx6k2cViFEtTBcmcDn/c6kzJ1GNzz7W35
 r2FMXYnzrAjlm2500le++8wdSU8vfi+TYAIviROWWOrtqR2AsQkIyg0G97eHByRKT4HBpfka7T5mE
 EeOBaHCulEze6bF2ly87sUmfPmItM1ccH2uTTb1ebePRmq5scNSxLdmKjyl9etSZ+WFOLuSP8lK8K
 yQWrAfxnBrT7yIiK3T72LJ4tE0Ky57mdyrD+QXIB6iU4S1sWsq/Xv7wl4IHXNnl6+18g91WPNeA6e
 JA4NOYRL05/fTqSUIvPisQ==;
Received: from [130.117.225.1] (helo=dev007.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1syYj2-00AZwM-2f;
 Wed, 09 Oct 2024 17:39:11 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/2] preallocate: do not allow to change BDS permission
 improperly
Date: Wed,  9 Oct 2024 18:37:36 +0300
Message-ID: <20241009153924.158721-2-den@openvz.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241009153924.158721-1-den@openvz.org>
References: <20241009153924.158721-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RW permissions could not be lifted from the preallocation filter if
truncate operation has not been finished. In the other case this would
mean WRITE operation (image truncate) called after the return from
inactivate call. This is definitely a contract violation.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Kevin Wolf <kwolf@redhat.com>
---
 block/preallocate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/preallocate.c b/block/preallocate.c
index d215bc5d6d..1016c511cb 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -594,6 +594,17 @@ static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
     }
 }
 
+static int preallocate_check_perm(BlockDriverState *bs, uint64_t perm,
+                                  uint64_t shared, Error **errp)
+{
+    BDRVPreallocateState *s = bs->opaque;
+    if (!can_write_resize(perm) && s->data_end != -EINVAL) {
+        error_setg_errno(errp, EPERM, "Write access is required for truncate");
+        return -EPERM;
+    }
+    return 0;
+}
+
 static BlockDriver bdrv_preallocate_filter = {
     .format_name = "preallocate",
     .instance_size = sizeof(BDRVPreallocateState),
@@ -615,6 +626,7 @@ static BlockDriver bdrv_preallocate_filter = {
 
     .bdrv_set_perm = preallocate_set_perm,
     .bdrv_child_perm = preallocate_child_perm,
+    .bdrv_check_perm = preallocate_check_perm,
 
     .is_filter = true,
 };
-- 
2.43.5


