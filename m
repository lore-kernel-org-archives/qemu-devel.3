Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B53C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAUi-0007Lz-IR; Wed, 12 Aug 2026 11:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuASf-0004Xn-Ou; Wed, 12 Aug 2026 11:01:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuASe-0002S6-5i; Wed, 12 Aug 2026 11:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=cjD3FK1fKKeUBrNfJ6lHawusnsaZT+/UDQNhmCtKVNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CYIYCDZxAzdCRnJyS1Sh34MQgUdthy8B4nLXpiND9QJFGGAtNWHEPxiQStPonNIux
 qVcemiyM1XuJwwkRDliBJWMhMCPZjQEduUjPxqkqnwcgG/shs9mbJA2xolcRPA6M4K
 dtxXy/FdHXdQReivWyOMGIPKVAw2xs54oiUs1VjsVxcJ+qTol7fpVlmIU14SXnKUn1
 YPCL8bx1BIsu1WenllVDPvpVF9gDQm5rc4GjzRvnMNlYzGNzVmy9xk0CKn1MS1fzEd
 n+JoO4PJqOeN+pVM2sSmfKSrdvxUeXPod6zpwbOFWwfSoj1cbkTqujdP057wKfZeZB
 yG8aixwOD6JSw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F30E51CA674;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 58113409DB9;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B55112FA43; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 112/120] hw/nvme: factor out nvme_sq_cancel_inflight()
Date: Wed, 12 Aug 2026 17:49:35 +0300
Message-ID: <20260812144955.649205-112-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Minwoo Im <minwoo.im.dev@gmail.com>

Factor the cancel-and-wait loop used by nvme_del_sq() into
nvme_sq_cancel_inflight(), so it can be reused to drain queues on
controller reset.

Cc: qemu-stable@nongnu.org
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 849ea354ddc1c9a4c2af03d57f75acf106ff6b45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4e5c6e65995..857dc4fa1d5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4808,6 +4808,26 @@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
     return 0;
 }
 
+/*
+ * A pending Async Event Request has no aiocb (nvme_aer() parks it without
+ * issuing any block I/O), so there is nothing to cancel; just drop it.
+ */
+static void nvme_sq_cancel_inflight(NvmeSQueue *sq, uint16_t status)
+{
+    NvmeRequest *r;
+
+    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
+        r = QTAILQ_FIRST(&sq->out_req_list);
+        r->status = status;
+
+        if (r->aiocb) {
+            blk_aio_cancel(r->aiocb);
+        } else {
+            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
+        }
+    }
+}
+
 static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
 {
     uint16_t offset = sq->sqid << 3;
@@ -4842,16 +4862,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_del_sq(qid);
 
     sq = n->sq[qid];
-    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
-        r = QTAILQ_FIRST(&sq->out_req_list);
-        r->status = NVME_CMD_ABORT_SQ_DEL;
-
-        if (r->aiocb) {
-            blk_aio_cancel(r->aiocb);
-        } else {
-            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
-        }
-    }
+    nvme_sq_cancel_inflight(sq, NVME_CMD_ABORT_SQ_DEL);
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
-- 
2.47.3


