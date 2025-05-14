Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5309C3ABDE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBgm-0002cU-WF; Wed, 14 May 2025 08:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgL-0001qH-5y; Wed, 14 May 2025 08:58:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgJ-0007ng-1T; Wed, 14 May 2025 08:57:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9754C121AD1;
 Wed, 14 May 2025 15:56:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 42BD120B849;
 Wed, 14 May 2025 15:56:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 17/18] 9pfs: fix concurrent v9fs_reclaim_fd() calls
Date: Wed, 14 May 2025 15:56:23 +0300
Message-Id: <20250514125640.91677-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
References: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
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
index d950ad6de6..0afaf93645 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -441,6 +441,12 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
@@ -516,6 +522,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
          */
         put_fid(pdu, f);
     }
+
+    s->reclaiming = false;
 }
 
 /*
@@ -4300,6 +4308,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
+    s->reclaiming = false;
+
     rc = 0;
 out:
     if (rc) {
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 2fce4140d1..1f0449f305 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -363,6 +363,7 @@ struct V9fsState {
     uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
     uint16_t qp_affix_next;
     uint64_t qp_fullpath_next;
+    bool reclaiming;
 };
 
 /* 9p2000.L open flags */
-- 
2.39.5


