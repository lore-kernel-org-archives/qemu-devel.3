Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ED3D5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kUk-0007I7-93; Sat, 09 Nov 2024 07:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSU-0003x9-LN; Sat, 09 Nov 2024 07:20:54 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSR-0005s8-OY; Sat, 09 Nov 2024 07:20:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 663DEA1662;
 Sat,  9 Nov 2024 15:08:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 216C8167FE8;
 Sat,  9 Nov 2024 15:09:05 +0300 (MSK)
Received: (nullmailer pid 3296301 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Waldemar Kozaczuk <jwkozaczuk@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 56/58] hw/nvme: fix handling of over-committed queues
Date: Sat,  9 Nov 2024 15:08:57 +0300
Message-Id: <20241109120901.3295995-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
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

From: Klaus Jensen <k.jensen@samsung.com>

If a host chooses to use the SQHD "hint" in the CQE to know if there is
room in the submission queue for additional commands, it may result in a
situation where there are not enough internal resources (struct
NvmeRequest) available to process the command. For a lack of a better
term, the host may "over-commit" the device (i.e., it may have more
inflight commands than the queue size).

For example, assume a queue with N entries. The host submits N commands
and all are picked up for processing, advancing the head and emptying
the queue. Regardless of which of these N commands complete first, the
SQHD field of that CQE will indicate to the host that the queue is
empty, which allows the host to issue N commands again. However, if the
device has not posted CQEs for all the previous commands yet, the device
will have less than N resources available to process the commands, so
queue processing is suspended.

And here lies an 11 year latent bug. In the absense of any additional
tail updates on the submission queue, we never schedule the processing
bottom-half again unless we observe a head update on an associated full
completion queue. This has been sufficient to handle N-to-1 SQ/CQ setups
(in the absense of over-commit of course). Incidentially, that "kick all
associated SQs" mechanism can now be killed since we now just schedule
queue processing when we return a processing resource to a non-empty
submission queue, which happens to cover both edge cases. However, we
must retain kicking the CQ if it was previously full.

So, apparently, no previous driver tested with hw/nvme has ever used
SQHD (e.g., neither the Linux NVMe driver or SPDK uses it). But then OSv
shows up with the driver that actually does. I salute you.

Fixes: f3c507adcd7b ("NVMe: Initial commit for new storage interface")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2388
Reported-by: Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 9529aa6bb4d18763f5b4704cb4198bd25cbbee31)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9f277b81d8..fe822f63b3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1516,9 +1516,16 @@ static void nvme_post_cqes(void *opaque)
             stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
             break;
         }
+
         QTAILQ_REMOVE(&cq->req_list, req, entry);
+
         nvme_inc_cq_tail(cq);
         nvme_sg_unmap(&req->sg);
+
+        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
+            qemu_bh_schedule(sq->bh);
+        }
+
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail != cq->head) {
@@ -7806,7 +7813,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         /* Completion queue doorbell write */
 
         uint16_t new_head = val & 0xffff;
-        int start_sqs;
         NvmeCQueue *cq;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
@@ -7857,18 +7863,15 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
 
-        start_sqs = nvme_cq_full(cq) ? 1 : 0;
+        /* scheduled deferred cqe posting if queue was previously full */
+        if (nvme_cq_full(cq)) {
+            qemu_bh_schedule(cq->bh);
+        }
+
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
             stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
         }
-        if (start_sqs) {
-            NvmeSQueue *sq;
-            QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
-                qemu_bh_schedule(sq->bh);
-            }
-            qemu_bh_schedule(cq->bh);
-        }
 
         if (cq->tail == cq->head) {
             if (cq->irq_enabled) {
-- 
2.39.5


