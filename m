Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C289ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXb0-00011y-A2; Fri, 22 May 2026 17:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZt-0000HG-FQ; Fri, 22 May 2026 17:38:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZq-0002hA-LY; Fri, 22 May 2026 17:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485682; bh=mSinsD+phKazU46puRJGhH4gfhz+lqPEGRypjvVr2Y8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pwLFVBZ098fCxF175rEhly+m8LrFJE84zwZghs0OYMaXeQZZLPbVVKcoubLWpUT0B
 aGQIQvJi1HJ8/SRyGFP6TtV/TM9E2rgOOk6kcTr/hJ3NAl1HO3trgDZKka1sMKzGlb
 Kroif27BoMFk5uI/5nRb5MaswajPfrWzAuaHlSdEjMfOUc910J4la5LPXoptg84Rer
 BkMuBJiuO1PUvkQLbZKJd6zEHAjNCucprnJGPwMSvf9VXXTsiJ0XN/lmeg1kZSaECb
 6gY6ioRIZBGh7bbDGiuA+SQtRhU/wjliE/5DnrBKiqN7L3hMRoK27tJtR5fcUADZui
 AOy44BjJ8zsrA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D22611AFB00;
 Sat, 23 May 2026 00:34:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 039783B7180;
 Sat, 23 May 2026 00:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 111/136] hw/ufs: Reject zero-depth MCQ queues
Date: Sat, 23 May 2026 00:34:19 +0300
Message-ID: <20260522213446.806182-12-mjt@tls.msk.ru>
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

Reject SQATTR.SIZE and CQATTR.SIZE values that produce zero-entry MCQ
queues. Such queues can later trigger a divide-by-zero while advancing
queue pointers.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 4a909c00b9e18478e67a792c7f7cfae62cb6c865)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 531dcfc686..7734b35f08 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -40,10 +40,12 @@ ufs_err_mcq_db_wr_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_db_wr_invalid_db(uint8_t qid, uint32_t db) "invalid mcq doorbell sqid %"PRIu8", db %"PRIu32""
 ufs_err_mcq_create_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_create_sq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_sq_invalid_size(uint8_t qid) "invalid mcq sq size for sqid %"PRIu8""
 ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
 ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_cq_invalid_size(uint8_t qid) "invalid mcq cq size for cqid %"PRIu8""
 ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
 ufs_err_mcq_delete_cq_not_exists(uint8_t qid) "mcq cqid %"PRIu8 "not exists"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 31cf1b9434..c6415a4b96 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -506,6 +506,8 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     UfsMcqReg *reg = &u->mcq_reg[qid];
     UfsSq *sq;
     uint8_t cqid = FIELD_EX32(attr, SQATTR, CQID);
+    uint16_t qsize =
+        ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
 
     if (qid >= u->params.mcq_maxq) {
         trace_ufs_err_mcq_create_sq_invalid_sqid(qid);
@@ -527,12 +529,17 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (!qsize) {
+        trace_ufs_err_mcq_create_sq_invalid_size(qid);
+        return false;
+    }
+
     sq = g_malloc0(sizeof(*sq));
     sq->u = u;
     sq->sqid = qid;
     sq->cq = u->cq[cqid];
     sq->addr = ((uint64_t)reg->squba << 32) | reg->sqlba;
-    sq->size = ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
+    sq->size = qsize;
 
     sq->bh = qemu_bh_new_guarded(ufs_mcq_process_sq, sq,
                                  &DEVICE(u)->mem_reentrancy_guard);
@@ -576,6 +583,8 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
 {
     UfsMcqReg *reg = &u->mcq_reg[qid];
     UfsCq *cq;
+    uint16_t qsize =
+        ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
 
     if (qid >= u->params.mcq_maxq) {
         trace_ufs_err_mcq_create_cq_invalid_cqid(qid);
@@ -587,11 +596,16 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (!qsize) {
+        trace_ufs_err_mcq_create_cq_invalid_size(qid);
+        return false;
+    }
+
     cq = g_malloc0(sizeof(*cq));
     cq->u = u;
     cq->cqid = qid;
     cq->addr = ((uint64_t)reg->cquba << 32) | reg->cqlba;
-    cq->size = ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
+    cq->size = qsize;
 
     cq->bh = qemu_bh_new_guarded(ufs_mcq_process_cq, cq,
                                  &DEVICE(u)->mem_reentrancy_guard);
-- 
2.47.3


