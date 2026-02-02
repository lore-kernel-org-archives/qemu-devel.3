Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D893E7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn177-0007A4-FM; Mon, 02 Feb 2026 16:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn175-00077V-IT; Mon, 02 Feb 2026 16:05:39 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn173-0005HF-UV; Mon, 02 Feb 2026 16:05:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 399421851D4;
 Mon, 02 Feb 2026 23:57:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 025DA35B34B;
 Mon, 02 Feb 2026 23:58:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilia Levi <ilia.levi@intel.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 72/74] hw/ufs: Fix mcq completion queue wraparound
Date: Mon,  2 Feb 2026 23:58:23 +0300
Message-ID: <20260202205833.941615-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Ilia Levi <ilia.levi@intel.com>

Currently, ufs_mcq_process_cq() writes to the CQ without checking whether
there is available space. This can cause CQ entries to be discarded and
overwritten. The solution is to stop writing when CQ is full and exert
backpressure on the affected SQs. This is similar to how NVMe CQs operate.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit f78762a3cc81ca9842907a5fc1b2280083ac51ba)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 128e2b1ea8..8fdc0854eb 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -447,6 +447,10 @@ static void ufs_mcq_process_cq(void *opaque)
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next)
     {
+        if (ufs_mcq_cq_full(u, cq->cqid)) {
+            break;
+        }
+
         ufs_dma_write_rsp_upiu(req);
 
         /* UTRD/CQE are LE; round-trip through host to keep BE correct. */
@@ -478,6 +482,12 @@ static void ufs_mcq_process_cq(void *opaque)
         tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
         ufs_mcq_update_cq_tail(u, cq->cqid, tail);
 
+        if (QTAILQ_EMPTY(&req->sq->req_list) &&
+            !ufs_mcq_sq_empty(u, req->sq->sqid)) {
+            /* Dequeueing from SQ was blocked due to lack of free requests */
+            qemu_bh_schedule(req->sq->bh);
+        }
+
         ufs_clear_req(req);
         QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
     }
@@ -787,10 +797,18 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         }
         opr->sq.tp = data;
         break;
-    case offsetof(UfsMcqOpReg, cq.hp):
+    case offsetof(UfsMcqOpReg, cq.hp): {
+        UfsCq *cq = u->cq[qid];
+
+        if (ufs_mcq_cq_full(u, qid) && !QTAILQ_EMPTY(&cq->req_list)) {
+            /* Enqueueing to CQ was blocked because it was full */
+            qemu_bh_schedule(cq->bh);
+        }
+
         opr->cq.hp = data;
         ufs_mcq_update_cq_head(u, qid, data);
         break;
+    }
     case offsetof(UfsMcqOpReg, cq_int.is):
         opr->cq_int.is &= ~data;
         break;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 3799d97f30..13d964c5ae 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -200,6 +200,15 @@ static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
     return ufs_mcq_cq_tail(u, qid) == ufs_mcq_cq_head(u, qid);
 }
 
+static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
+{
+    uint32_t tail = ufs_mcq_cq_tail(u, qid);
+    uint16_t cq_size = u->cq[qid]->size;
+
+    tail = (tail + sizeof(UfsCqEntry)) % (sizeof(UfsCqEntry) * cq_size);
+    return tail == ufs_mcq_cq_head(u, qid);
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
-- 
2.47.3


