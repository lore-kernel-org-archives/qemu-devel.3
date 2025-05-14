Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B04C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHRR-0006hX-Eg; Wed, 14 May 2025 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHNE-0005pK-P6; Wed, 14 May 2025 15:02:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHNC-0007p4-O3; Wed, 14 May 2025 15:02:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C7A7121DA0;
 Wed, 14 May 2025 22:00:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2403120BA92;
 Wed, 14 May 2025 22:00:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 22/23] 9pfs: fix concurrent v9fs_reclaim_fd() calls
Date: Wed, 14 May 2025 22:00:34 +0300
Message-Id: <20250514190041.104759-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Even though this function is serialized to be always called from main
thread, v9fs_reclaim_fd() is dispatching the coroutine to a worker thread
in between via its v9fs_co_*() calls, hence leading to the situation where
v9fs_reclaim_fd() is effectively executed multiple times simultaniously,
which renders its LRU algorithm useless and causes high latency.

Fix this by adding a simple boolean variable to ensure this function is
only called once at a time. No synchronization needed for this boolean
variable as this function is only entered and returned on main thread.

Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <5c622067efd66dd4ee5eca740dcf263f41db20b2.1741339452.git.qemu_oss@crudebyte.com>
(cherry picked from commit 61da38db70affd925226ce1e8a61d761c20d045b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7cad2bce62..4f9c2dde9c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -435,6 +435,12 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
     GHashTableIter iter;
     gpointer fid;
 
+    /* prevent multiple coroutines running this function simultaniously */
+    if (s->reclaiming) {
+        return;
+    }
+    s->reclaiming = true;
+
     g_hash_table_iter_init(&iter, s->fids);
 
     QSLIST_HEAD(, V9fsFidState) reclaim_list =
@@ -510,6 +516,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
          */
         put_fid(pdu, f);
     }
+
+    s->reclaiming = false;
 }
 
 /*
@@ -4324,6 +4332,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
+    s->reclaiming = false;
+
     rc = 0;
 out:
     if (rc) {
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5e041e1f60..259ad32ed1 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -362,6 +362,7 @@ struct V9fsState {
     uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
     uint16_t qp_affix_next;
     uint64_t qp_fullpath_next;
+    bool reclaiming;
 };
 
 /* 9p2000.L open flags */
-- 
2.39.5


