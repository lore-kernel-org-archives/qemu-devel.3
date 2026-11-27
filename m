Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=QyBg12G+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWowI-00058K-L2; Fri, 27 Nov 2026 00:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWow4-0004iE-IS; Fri, 27 Nov 2026 00:55:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWow2-0000Y3-Al; Fri, 27 Nov 2026 00:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758873; bh=oz3lx6F0WctTXoLzva3QVFF1Ke7nEvU8gnCJq690Uzc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QyBg12G+cn6K5p2FgWN7avLLsN0nwD26LUQoAzIPuZuc3gmdEWquBtrF65qnOhcpH
 CVG6l+tI4brwFOVVZ1WVv8x5k5/AeQlnmJBvS7mvWqa+iFIe8l+JYk7j2ZQIZ830yo
 +UVqeELVApRy142bQaJH+/zNUBMh4sFQyfGzBQdEpnyUJsS4auwgVYVX7LqCc29uJz
 OsOFs1P8L5G/7z/nyuAebDVoYx4NumCgOt9tOqNk/b7GdVK5ts0kF9mFLluM2QBMuS
 6QuI3squzlgL05+GSYvbkSzTqNJhchUmfsKB3SVonlYBsW/WnhIO6nV+oZgWgH24EW
 DA2DSrax6bP9g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1FD41EA2D6;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CFABB469913;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C5B1DCF232; Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?= <mankku@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 078/140] hw/nvme: prevent cq_pending underflow
Date: Fri, 27 Nov 2026 08:53:04 +0300
Message-ID: <20261127055421.39015-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markku Ahvenjärvi <mankku@gmail.com>

cq_pending counts interrupt-enabled completion queues with unconsumed
entries. nvme_cq_notifier() and nvme_process_db() decrement it whenever
a CQ becomes empty, but they may also process a notification or doorbell
write for a CQ that was already empty.

Decrement cq_pending only when the CQ contained pending completions
before its head update. Otherwise cq_pending may underflow and
prevent legacy INTx from being deasserted.

Cc: qemu-stable@nongnu.org
Fixes: 83d7ed5c570d ("hw/nvme: fix pin-based interrupt behavior (again)")
Fixes: 2e53b0b45024 ("hw/nvme: Use ioeventfd to handle doorbell updates")
Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit e019b94a0bca322b312b3843dd1a8cd9c475a50e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 60f67741f9e..94f52cb70f8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4741,6 +4741,7 @@ static void nvme_cq_notifier(EventNotifier *e)
 {
     NvmeCQueue *cq = container_of(e, NvmeCQueue, notifier);
     NvmeCtrl *n = cq->ctrl;
+    bool pending = cq->tail != cq->head;
 
     if (!event_notifier_test_and_clear(e)) {
         return;
@@ -4749,7 +4750,7 @@ static void nvme_cq_notifier(EventNotifier *e)
     nvme_update_cq_head(cq);
 
     if (cq->tail == cq->head) {
-        if (cq->irq_enabled) {
+        if (cq->irq_enabled && pending) {
             n->cq_pending--;
         }
 
@@ -8152,6 +8153,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         uint16_t new_head = val & 0xffff;
         NvmeCQueue *cq;
+        bool pending;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
         if (unlikely(nvme_check_cqid(n, qid))) {
@@ -8206,13 +8208,14 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             qemu_bh_schedule(cq->bh);
         }
 
+        pending = cq->tail != cq->head;
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
             stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
         }
 
         if (cq->tail == cq->head) {
-            if (cq->irq_enabled) {
+            if (cq->irq_enabled && pending) {
                 n->cq_pending--;
             }
 
-- 
2.47.3


