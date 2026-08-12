Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0051FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8n4-00055Z-Ve; Wed, 12 Aug 2026 09:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kz-0003hW-Um; Wed, 12 Aug 2026 09:12:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kw-0006U0-DV; Wed, 12 Aug 2026 09:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=8UCTFZCHZqIBMrdgyZWN/8lh3zerIx9tSDSECLIkk90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H+Hq3iaIF0/JwK4YH4GSi/nUUMmANS7rrr1rm80NndzYNu8oCtEq8v8/HCFH06csL
 hbP/tAyxCXJ+kx26jxC+MPPu56655bEeXlJfcqY41IQbg6yNDCcPR8pV90Zd2ftyLM
 cSRYOeBPYHaL5dJpP3f7aFZV3NjQW/7klbFc+32dgbWRLRrWFsQQsQsnS8Xzmy/kf9
 2Jaf/NLnTAwhCaJhy7TjUhvT4kDbot1ywIlI9O57qqREa9bopepL71D2rlZcwIqfkf
 gFxTIb76EPVbtegX+Fp2weaBZpllaeLjIBS6sHoxh8rE4EownXmlPV0qFb6atQxbp1
 YYBxoqliZRqPQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9E351CA4E0;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0C3D2409BC3;
 Wed, 12 Aug 2026 16:03:16 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CF2EA2F956; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 097/102] hw/nvme: cancel inflight requests on
 controller reset
Date: Wed, 12 Aug 2026 16:02:12 +0300
Message-ID: <20260812130233.621965-97-mjt@tls.msk.ru>
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

nvme_ctrl_reset() freed every SQ/CQ right after nvme_ns_drain(), which
only waits out requests on a per-namespace BlockBackend. That is safe
as long as the guest first tore down I/O queues gracefully (Delete
I/O SQ/CQ), since nvme_del_sq() already cancels and waits for
anything left on a queue before freeing it.

A reset that happens without that graceful sequence first (e.g. an
abrupt/asynchronous controller reset) can still have commands
inflight on blk_aio_*. Freeing sq/cq before those complete leaves
their completion callbacks (nvme_rw_cb() and friends) to run against
already-freed NvmeRequest/NvmeSQueue/NvmeCQueue memory via
nvme_enqueue_req_completion(), causing a use-after-free/segfault.

Run nvme_sq_cancel_inflight() over every queue in nvme_ctrl_reset()
before the free loops, so no in-flight blk_aio_* callback can fire
after sq/cq memory is freed.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3398
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3883
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4068
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4072
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 86f938333e2faae7c60ca66c0809f5495c59aa4b)
(Mjt: back-port across v11.0.0-2641-g9d378cab537d "hw/nvme: add basic live migration support"
 which changed by-queue loops upper bound from `n->params.max_ioqpairs + 1'
 to `n->num_queues')
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 64241cca8f7..325b06970c6 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7657,6 +7657,18 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
         nvme_ns_drain(ns);
     }
 
+    /*
+     * Cancel and wait out every inflight command on every queue first. A
+     * reset is not required to be preceded by the guest's graceful
+     * Delete I/O SQ/CQ sequence, so sq/cq must not be freed below while a
+     * blk_aio_* completion for them could still be in flight.
+     */
+    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
+        if (n->sq[i] != NULL) {
+            nvme_sq_cancel_inflight(n->sq[i], NVME_CMD_ABORT_SQ_DEL);
+        }
+    }
+
     for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
-- 
2.47.3


