Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2476DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXaO-0000Rl-7E; Fri, 22 May 2026 17:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZo-0000Fi-2I; Fri, 22 May 2026 17:38:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZj-0002UV-V9; Fri, 22 May 2026 17:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485682; bh=RrhIRJ/LDvQkxQ4Mq2Od9Wj9IXgL5QT+Dkxl8e0XdW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jQpw/LZD9O03Ua2k12YgEyCgg2AZ2Fm0IreupxdhLbyGhRzw3vthd7YnN/lB8oiV9
 VPxrUySuEJeuvs+Hr1QRzoq3PYsfAdtFSteCY+HYN23RVqsf3jFAmryqlWVFUe+Ced
 nw2/uxrfUl/u3+8Iy6Fv6fWT9YiFDqSGgw/WBnwHAIy6T2CTWAwrNfE3Cp+5USo69r
 8LUGxq0gUlGcIbZjzK3XGAgEo/JzZd4zqwnj/2c4XDtNq1ygIOraiJcktYQlqHoYnY
 iCu/0vKCV0gWwY46Pug1fU36j8KvMFD04q4aGsfnFET9pBg597oaH9n+2q3M9SoNd5
 89TXpeLKs3aVw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B796F1AFAFE;
 Sat, 23 May 2026 00:34:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DBED63B717E;
 Sat, 23 May 2026 00:34:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 109/136] hw/ufs: Validate MCQ SQ references before use
Date: Sat, 23 May 2026 00:34:17 +0300
Message-ID: <20260522213446.806182-10-mjt@tls.msk.ru>
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

A guest can program an out-of-range SQATTR.CQID value, or ring an
MCQ SQ doorbell before the submission queue exists.

Reject SQ creation when the referenced CQ is invalid, and ignore SQ
doorbells for queues that have not been created. This prevents a
guest-triggerable out-of-bounds read and NULL pointer dereference.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Reported-by: Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 332ea29787800fff2b49e9b89ec93bd370a11965)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 202dae20f7..2469f29b41 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -517,8 +517,13 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (cqid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_create_sq_invalid_cqid(cqid);
+        return false;
+    }
+
     if (!u->cq[cqid]) {
-        trace_ufs_err_mcq_create_sq_invalid_cqid(qid);
+        trace_ufs_err_mcq_create_sq_invalid_cqid(cqid);
         return false;
     }
 
@@ -775,6 +780,11 @@ static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
     }
 
     sq = u->sq[qid];
+    if (!sq) {
+        trace_ufs_err_mcq_db_wr_invalid_sqid(qid);
+        return;
+    }
+
     if (sq->size * sizeof(UfsSqEntry) <= db) {
         trace_ufs_err_mcq_db_wr_invalid_db(qid, db);
         return;
@@ -788,7 +798,14 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
                                  unsigned size)
 {
     int qid = offset / sizeof(UfsMcqOpReg);
-    UfsMcqOpReg *opr = &u->mcq_op_reg[qid];
+    UfsMcqOpReg *opr;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_invalid_register_offset(offset);
+        return;
+    }
+
+    opr = &u->mcq_op_reg[qid];
 
     switch (offset % sizeof(UfsMcqOpReg)) {
     case offsetof(UfsMcqOpReg, sq.tp):
-- 
2.47.3


