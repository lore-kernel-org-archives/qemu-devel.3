Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE49CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXah-0000aw-JQ; Fri, 22 May 2026 17:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZw-0000HT-7t; Fri, 22 May 2026 17:38:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZq-0002hD-LU; Fri, 22 May 2026 17:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485682; bh=Ut3R3oMAcPO1UtBljC2SxEXddYzO4+92BlrarOBehwg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qCLg3dQ76RdrmuBov8Ikh6S0FFd7dD1pmBL0TQOeoJMhAt2GuZoYlZRa0bKaEN23g
 /DQl7XTk/u6R5QuU69sHjdGM9NO3dZevkImbBA54kCdxkYQiBmjaBAwKTFJbcnDSMh
 PogUvz90p3bvXWopAFd4ETHIVAZPIi7z9qx0BfB8p4HR9aowgCI5Ue6ft0W5h0EmGh
 HIYtkCAMqmO8DdciCGyaelocIyDu1t9j94qYMnGGP2TGwxxJ7cd86R+mJTE8WL3ez3
 6+rOcY7DqXdHIACtE3Ux7m10riTsfR1599pNnKENH+GWYaPzRyrWM3dZH45VwYZ3XP
 JEcU3ugqsypYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF6701AFB01;
 Sat, 23 May 2026 00:34:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 101053B7181;
 Sat, 23 May 2026 00:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 112/136] hw/ufs: Keep MCQ SQs alive while requests
 are outstanding
Date: Sat, 23 May 2026 00:34:20 +0300
Message-ID: <20260522213446.806182-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jeuk Kim <jeuk20.kim@samsung.com>

MCQ requests are allocated with their SQ, but can remain in flight on the
CQ list or in the SCSI layer after leaving the SQ free list.

Reject runtime SQ deletion while any request is still outstanding, and
use separate teardown helpers so device exit can still release MCQ
queues after child devices have been unrealized.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 619c2da19a05668dabe7912afb789e50b8635c4d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 7734b35f08..6f7ea9c95f 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -44,6 +44,7 @@ ufs_err_mcq_create_sq_invalid_size(uint8_t qid) "invalid mcq sq size for sqid %"
 ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
+ufs_err_mcq_delete_sq_busy(uint8_t qid) "mcq sqid %"PRIu8" has outstanding requests"
 ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
 ufs_err_mcq_create_cq_invalid_size(uint8_t qid) "invalid mcq cq size for cqid %"PRIu8""
 ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index c6415a4b96..6144e727dd 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -556,6 +556,31 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     return true;
 }
 
+static bool ufs_mcq_sq_has_outstanding_req(UfsSq *sq)
+{
+    UfsRequest *req;
+    uint16_t free_reqs = 0;
+
+    QTAILQ_FOREACH(req, &sq->req_list, entry)
+    {
+        free_reqs++;
+    }
+
+    return free_reqs != sq->size;
+}
+
+static void ufs_mcq_free_sq(UfsSq *sq)
+{
+    qemu_bh_delete(sq->bh);
+
+    for (int i = 0; i < sq->size; i++) {
+        ufs_clear_req(&sq->req[i]);
+    }
+
+    g_free(sq->req);
+    g_free(sq);
+}
+
 static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
 {
     UfsSq *sq;
@@ -572,9 +597,12 @@ static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
 
     sq = u->sq[qid];
 
-    qemu_bh_delete(sq->bh);
-    g_free(sq->req);
-    g_free(sq);
+    if (ufs_mcq_sq_has_outstanding_req(sq)) {
+        trace_ufs_err_mcq_delete_sq_busy(qid);
+        return false;
+    }
+
+    ufs_mcq_free_sq(sq);
     u->sq[qid] = NULL;
     return true;
 }
@@ -617,6 +645,12 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
     return true;
 }
 
+static void ufs_mcq_free_cq(UfsCq *cq)
+{
+    qemu_bh_delete(cq->bh);
+    g_free(cq);
+}
+
 static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
 {
     UfsCq *cq;
@@ -640,8 +674,7 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
 
     cq = u->cq[qid];
 
-    qemu_bh_delete(cq->bh);
-    g_free(cq);
+    ufs_mcq_free_cq(cq);
     u->cq[qid] = NULL;
     return true;
 }
@@ -1884,12 +1917,14 @@ static void ufs_exit(PCIDevice *pci_dev)
 
     for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
         if (u->sq[i]) {
-            ufs_mcq_delete_sq(u, i);
+            ufs_mcq_free_sq(u->sq[i]);
+            u->sq[i] = NULL;
         }
     }
     for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
         if (u->cq[i]) {
-            ufs_mcq_delete_cq(u, i);
+            ufs_mcq_free_cq(u->cq[i]);
+            u->cq[i] = NULL;
         }
     }
 }
-- 
2.47.3


