Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB79C5AC80
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 11:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt1yb-0002xT-JZ; Sun, 09 Aug 2026 07:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itai.handler@gmail.com>)
 id 1wswOs-0002fm-7K
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 01:48:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itai.handler@gmail.com>)
 id 1wswOq-0001t5-Go
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 01:48:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4956d1d9fb2so1082415e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 22:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786254522; x=1786859322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IOeHt9nsOmgApfugujVJopkZKUUbjS5NZATb0Mf3lhk=;
 b=bcw6gRl2Kd+UU1Km88Nx/GnjUtmE3mLCz7I1lxhcmGomt67xY1okHmrqN8C5wYOS4C
 jR/ezDQXRXydUZ+1i6gUCiyVnug5s1/TvQIOZvOjTJ7oZmaBbIEM2HsMcAzujYgKVN4Y
 ElCk9b1T4I7Rq4aSndvx3EHzkJUm62qB90K1qF8g1Berm9kf7n7j3ar6HCT+L2LrjTiL
 orMo18avZxhaFqsRoAZhDn2Rj/Vu7kiDyPoJ6DPhbLcrHNslnY31kNSQkrUHRtdS5tpX
 Q2Uj+51O6vPPdNI5oijVXqOqkqcYfMMC0Q0OiwZqMMqmOXx8O315slaoN4OJtccFz6PA
 x8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786254522; x=1786859322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IOeHt9nsOmgApfugujVJopkZKUUbjS5NZATb0Mf3lhk=;
 b=M/LK/+TU1N8kiRmmPZAIAUFGtpcT1u6+CrTlg9QEaOiIDWVoGcDrImrewjKcC2KF5J
 WBEWMfvemKjGRbycdHyV30/S+bqwPtx1AYP9ZEoyMPoYHlwQD7+NQs4FKFgD7mgwYEQb
 4hAZVGV01gRvCZA86jhbGGf9f1XSQAC8krIMcFiV8e9sAwugEc6yBevsNiej8ZCWqePx
 o9lH+4SfVrDFZQcn9itHRRpaz/8MH/V/eem7Ds9YziGZUkqlB/PVBDrwFC/NIepavjEx
 2mnXWSCPNU0rafq/s7mNH0VlCVzfwEByAF2XNR0IwRuuQiRglNnlQ1Z6dhDLvS3ifT2a
 oD8g==
X-Gm-Message-State: AOJu0YzsWT6vngivIBjYMnH+IFyMihn0A9fIO0ndaBd8w4OrtU2upag/
 820cT+iwx1AcN1POPGVmSpdPDDojZ9PpVnTrpFQXPyOfDrs4XSKJgkOOAJTEINdHsSY=
X-Gm-Gg: AR+sD12umZnCUrDAvQccCwBwM6l4yWuN8C35XERs1yehgw4yZ/HQ+tZ2A+wM+OiQcvi
 Liid/ZmXNNh5qiFkx3uppO0SombPF+p5KIrN3Xp/C0UUtQBb0c6bFB7jb9K2RBRqGJxLa59RaJk
 3JLRdfO6m/ZUN/HE/4IXvlshiKYmm2Lm41r2wtrMJu0w6x+FfzpSN2egr+fM0klh+JZ+xWhv1jI
 x5jYQkPfiJ0neBtq8FRR3qVjh6Sj+Iz/WdhNJM7StsPZI9Rikz5LYV+aUiFx5AqsTzKOW3mfnJo
 xoDlzcK8bJyN8+a8FzT+pVkDZym7b0NAoaIfjvUlPppEe+xmqkqiP2qsICFMzyjfqa3lt2LQFfM
 0NsYmeZsH2PGCmITN4q4/ngTuJHbZfP/4LFi0JFTv+fA0J4q2RW/85Ub+BZP9XaCk7Owh9P8p6t
 0RKtUetZlbDmZP8FFx36fDsIf8HRDq3N6/nCxF3ADX0dueCQrgDyH9AemaN8+N8sKIUifdo6lFz
 xGbaozV
X-Received: by 2002:a05:600c:b85:b0:495:4505:dad0 with SMTP id
 5b1f17b1804b1-4994e7ba5efmr255422225e9.2.1786254522290; 
 Sat, 08 Aug 2026 22:48:42 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e702dsm199791005e9.3.2026.08.08.22.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:48:41 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it,
 qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Itai Handler <itai.handler@gmail.com>
Subject: [PATCH] hw/nvme: fix cq_pending underflow that wedges pin-based
 interrupts
Date: Sun,  9 Aug 2026 08:48:37 +0300
Message-Id: <20260809054837.67255-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=itai.handler@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 09 Aug 2026 07:45:41 -0400
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

n->cq_pending counts the completion queues that hold CQEs the host has
not acknowledged yet. With pin-based interrupts it is what keeps the
line asserted while any queue still has unacknowledged CQEs:
nvme_irq_deassert() clears the vector's bit in irq_status only when the
count drops to zero.

The accounting is not symmetric. nvme_post_cqes() increments the
counter once per empty -> non-empty transition of a CQ, but the two CQ
head doorbell paths, nvme_process_db() and nvme_cq_notifier(),
decrement it on every update that leaves the queue empty, including an
update to a queue that was already empty. nvme_del_cq() gets this right
and checks cq->tail != cq->head before decrementing; the doorbell paths
do not. A host that writes the CQ head doorbell without having consumed
a CQE - a redundant write, e.g. from a completion path racing with
another one that already drained the queue - thus decrements more often
than the device incremented, and cq_pending goes negative.

Once it is negative it never gets back to zero: nvme_irq_deassert()
stops clearing irq_status, nvme_irq_check() keeps re-asserting the pin,
and the guest takes an endless interrupt for an empty completion queue.
Linux eventually gives up on the line

  irq 26: nobody cared (try booting with the "irqpoll" option)
  handlers: [<...>] nvme_irq
  Disabling IRQ #26

and all I/O to the device hangs. MSI-X guests are not affected, they
never look at cq_pending.

Only decrement when the queue actually had unacknowledged CQEs. That
restores the pairing with the increment in nvme_post_cqes() and makes
the counter unable to underflow.

Cc: qemu-stable@nongnu.org
Fixes: 83d7ed5c570d ("hw/nvme: fix pin-based interrupt behavior (again)")
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 hw/nvme/ctrl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index bd6ad64..655af08 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4761,15 +4761,18 @@ static void nvme_cq_notifier(EventNotifier *e)
 {
     NvmeCQueue *cq = container_of(e, NvmeCQueue, notifier);
     NvmeCtrl *n = cq->ctrl;
+    bool pending;
 
     if (!event_notifier_test_and_clear(e)) {
         return;
     }
 
+    pending = cq->tail != cq->head;
+
     nvme_update_cq_head(cq);
 
     if (cq->tail == cq->head) {
-        if (cq->irq_enabled) {
+        if (cq->irq_enabled && pending) {
             n->cq_pending--;
         }
 
@@ -8509,6 +8512,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         uint16_t new_head = val & 0xffff;
         NvmeCQueue *cq;
+        bool pending;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
         if (unlikely(nvme_check_cqid(n, qid))) {
@@ -8563,13 +8567,14 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
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
 

