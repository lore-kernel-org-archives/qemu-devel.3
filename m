Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC42C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8n0-0004rx-DR; Wed, 12 Aug 2026 09:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kq-0003df-UZ; Wed, 12 Aug 2026 09:12:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kk-0006Rl-O6; Wed, 12 Aug 2026 09:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=eb+TETTfG/DZiS5KgrG7GyW4LwtKPHZuCn3YtQOHfPc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GooOW2UY+//t0Rcy/WrdYbVmxLMbTpwEpZywkkSNmGJVo1gYRMr8btfrhKeu8r4+6
 tjXqr6VjWayKZUenSbmZxjAlLnU1dkiRiQiF6Y77zAhNq7FW+R7/LkNNMfFRUALbmJ
 E6jZGJvaC7F5ez6W/Ylzjuxsast59ernZ7zsV3nHvroxNEqvNxa7//mjFEMVi5oGi3
 4hOaZVFNvYZZj+yl+xS2jdPFnoPy3NIRn3eOPmqDbTWsDikIK+VKKPw5RcJ9tVygee
 6l80KAzE7TMC+DKqsMKIoj0SpYLebmEBciua5Umn4RtHmjKlNuZ/X62pEBaOwJrnlT
 GubcX3NUhG7zw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C2D251CA4DE;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0424D409BC1;
 Wed, 12 Aug 2026 16:03:16 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C9E102F952; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 095/102] hw/nvme: drop AER requests without aiocb in
 nvme_del_sq()
Date: Wed, 12 Aug 2026 16:02:10 +0300
Message-ID: <20260812130233.621965-95-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

nvme_del_sq() asserted r->aiocb was always set when canceling a
queue's inflight requests. A pending Async Event Request has no
aiocb (nvme_aer() parks it without issuing any block I/O), so
deleting a queue with an outstanding AER trips the assert instead of
just dropping the request.

Cc: qemu-stable@nongnu.org
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 1d5e53df1674e0e45be50a4a873e6deede2eecd7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e478e92d505..b17dd752260 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4841,12 +4841,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         r = QTAILQ_FIRST(&sq->out_req_list);
-        assert(r->aiocb);
         r->status = NVME_CMD_ABORT_SQ_DEL;
-        blk_aio_cancel(r->aiocb);
-    }
 
-    assert(QTAILQ_EMPTY(&sq->out_req_list));
+        if (r->aiocb) {
+            blk_aio_cancel(r->aiocb);
+        } else {
+            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
+        }
+    }
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
-- 
2.47.3


