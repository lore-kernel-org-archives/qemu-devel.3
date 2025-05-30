Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF9DC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PZ-0004Ro-3b; Fri, 30 May 2025 11:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PX-0004M9-70; Fri, 30 May 2025 11:12:43 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PV-0002Kb-EB; Fri, 30 May 2025 11:12:42 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BE7BF44979;
 Fri, 30 May 2025 17:11:47 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 32/48] block/snapshot: mark bdrv_all_delete_snapshot() as
 GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:09 +0200
Message-Id: <20250530151125.955508-33-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function bdrv_all_delete_snapshot() calls bdrv_drain_all_begin(),
which must be called with the graph unlocked.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 include/block/snapshot.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 304cc6ea61..2316a43e26 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -90,9 +90,9 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
 
 bool bdrv_all_can_snapshot(bool has_devices, strList *devices,
                            Error **errp);
-int bdrv_all_delete_snapshot(const char *name,
-                             bool has_devices, strList *devices,
-                             Error **errp);
+int GRAPH_UNLOCKED
+bdrv_all_delete_snapshot(const char *name, bool has_devices, strList *devices,
+                         Error **errp);
 int bdrv_all_goto_snapshot(const char *name,
                            bool has_devices, strList *devices,
                            Error **errp);
-- 
2.39.5



