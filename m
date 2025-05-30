Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1EFC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PX-0004Mn-Qv; Fri, 30 May 2025 11:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PU-0004Fz-UD; Fri, 30 May 2025 11:12:40 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PT-0002Jy-A6; Fri, 30 May 2025 11:12:40 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 98D1C44B90;
 Fri, 30 May 2025 17:11:47 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 29/48] blockdev: avoid locking and draining multiple times
 in external_snapshot_abort()
Date: Fri, 30 May 2025 17:11:06 +0200
Message-Id: <20250530151125.955508-30-f.ebner@proxmox.com>
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

By using the appropriate variants bdrv_set_backing_hd_drained() and
bdrv_try_change_aio_context_locked(), there only needs to be a single
drained and write-locked section in external_snapshot_abort().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

The assumption in the added code comment about the reference is AFAIU
it. Is this correct?

And unrelated, but I'm wondering, isn't this dead code? It's only
executed if state->overlay_appended is set, which happens at the very
end of external_snapshot_action(). How can the transaction still be
aborted after that?

 blockdev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index e625534925..3c53472a23 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1580,11 +1580,19 @@ static void external_snapshot_abort(void *opaque)
             AioContext *tmp_context;
             int ret;
 
+            bdrv_graph_wrlock_drained();
+
             aio_context = bdrv_get_aio_context(state->old_bs);
 
-            bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backind_hd()
-                                          close state->old_bs; we need it */
-            bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
+            /*
+             * Note that state->old_bs would not disappear during the
+             * write-locked section, because the unref from
+             * bdrv_set_backing_hd_drained() only happens at the end of the
+             * write-locked section. However, just be explicit about keeping a
+             * reference and don't rely on that implicit detail.
+             */
+            bdrv_ref(state->old_bs);
+            bdrv_set_backing_hd_drained(state->new_bs, NULL, &error_abort);
 
             /*
              * The call to bdrv_set_backing_hd() above returns state->old_bs to
@@ -1593,16 +1601,14 @@ static void external_snapshot_abort(void *opaque)
              */
             tmp_context = bdrv_get_aio_context(state->old_bs);
             if (aio_context != tmp_context) {
-                ret = bdrv_try_change_aio_context(state->old_bs,
-                                                  aio_context, NULL, NULL);
+                ret = bdrv_try_change_aio_context_locked(state->old_bs,
+                                                         aio_context, NULL,
+                                                         NULL);
                 assert(ret == 0);
             }
 
-            bdrv_drained_begin(state->new_bs);
-            bdrv_graph_wrlock();
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
             bdrv_graph_wrunlock();
-            bdrv_drained_end(state->new_bs);
 
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_bs */
         }
-- 
2.39.5



