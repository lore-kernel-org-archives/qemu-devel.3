Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ADECD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXlv-0001kQ-1G; Fri, 22 May 2026 17:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXls-0001gV-DG; Fri, 22 May 2026 17:51:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXlq-0003Xe-HO; Fri, 22 May 2026 17:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486560; bh=1oQODfCzhagCHMjdMI6rvA7VUlrtf/tSg+f7+6x7o90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NqTR6P8YieerK4cfX/7Rzj7codjnZob0thInr6O98SZtGXiLH1a8zPh4awAbe7XmL
 +mNLA3zII+TQIj39pmgmLDR8zNfrL0annTLK6Ep94EQDw0qFue2CRsuGbvt+IChyj7
 isXD9xJvjPmOyVr1uCSv0eZlOvAmR30qA+uiasMr1/VTWpd/t2+IsQO+bopzcpvlaW
 sNr2iOaa8hWosYeIxx5sdIJVvuWSuMhJJMahc62ZeTq8vCWBMg//TJpOH2cQZ5lIqi
 NtX1OErKhF4x3KFANPcgeJ1r5lF2doPIongUSZJxMPpEo58LO3xMEmhpxp1NWbFdrf
 ZuGeQhB1Z71Aw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6CAF11AFB6E;
 Sat, 23 May 2026 00:49:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9548E3B71BD;
 Sat, 23 May 2026 00:49:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 120/149] hw/ufs: Guard MCQ CQ accesses against missing
 queues
Date: Sat, 23 May 2026 00:48:52 +0300
Message-ID: <20260522214923.807017-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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

A guest can ring an MCQ CQ doorbell before the completion queue exists.
The CQ head write path then dereferences a NULL CQ through
ufs_mcq_cq_full().

Ignore CQ head updates for missing CQs, and make ufs_mcq_cq_full()
handle a missing CQ defensively.

Fixes: f78762a3cc8 ("hw/ufs: Fix mcq completion queue wraparound")
Reported-by: Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 283d921e771e8a98a5c3d1eed1ed791b89ba47a8)
Fixes: ad5f6ffcd04 ("hw/ufs: Fix mcq completion queue wraparound") in 10.2.x
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 5fe63b82ab..e01fc730fd 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -817,6 +817,10 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
     case offsetof(UfsMcqOpReg, cq.hp): {
         UfsCq *cq = u->cq[qid];
 
+        if (!cq) {
+            break;
+        }
+
         if (ufs_mcq_cq_full(u, qid) && !QTAILQ_EMPTY(&cq->req_list)) {
             /* Enqueueing to CQ was blocked because it was full */
             qemu_bh_schedule(cq->bh);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 13d964c5ae..9e800cafac 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -203,7 +203,14 @@ static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
 static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
 {
     uint32_t tail = ufs_mcq_cq_tail(u, qid);
-    uint16_t cq_size = u->cq[qid]->size;
+    UfsCq *cq = u->cq[qid];
+    uint16_t cq_size;
+
+    if (!cq) {
+        return false;
+    }
+
+    cq_size = cq->size;
 
     tail = (tail + sizeof(UfsCqEntry)) % (sizeof(UfsCqEntry) * cq_size);
     return tail == ufs_mcq_cq_head(u, qid);
-- 
2.47.3


