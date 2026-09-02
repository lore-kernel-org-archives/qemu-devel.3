Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86590C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1fmp-0006PC-TU; Wed, 02 Sep 2026 03:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stanleyjhu@google.com>)
 id 1x1fmo-0006Op-LN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:53:34 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stanleyjhu@google.com>)
 id 1x1fmm-0007H2-NF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:53:34 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-52fac937235so116591cf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 00:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788335612; cv=none;
 d=google.com; s=arc-20260327;
 b=TrJp3ozuXASCut14Y4RpFHWjbbdW41xiXoZFXAsyjZnX/wwNwnfcfKauNq1kkIaSHO
 +hcSifGCBvvp/ioV+F6eq5gkHP+rsRpLUW89V6QQj2Rl1Oknz0nszS/qujJX+7kVLuPo
 5T2mlcb69lyCfTNECG3paBwynf/8RfwVGqvwhJcL/9eT0HWpS1F9oqEa3sZ5eG9MAfuJ
 2KJRms8wktCLN9TJlBHSJSgAIFqyR7OdGL6nPsN24kBqb8O0uoLwNxK1BKJMX3AFFtLe
 NWLxaxAw3JUe0OhUH2b4bFU2B5z9cPSHq3LTkgx9vq0ff9Z3nL/1yGVDChIe4WMdnI10
 emRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=PfaLzZerxFLunMgLpS/gaZxp2YqbVEJ8PvbY/ZvlMaM=;
 fh=Q+ExfNvaVpPKDM9b/hN1ymGqm/OkETLmcZN9xCJzdWM=;
 b=CI1GTXSa0MnC0bb32FkxObauZHiDpxpD8PmKjCokN3w6eCvfDu52FWnKgM9FEPNWlW
 yy02MWZTJ5DOzLvHnl+hqn4FdTwcutNCmdW5kcOG095NTYgO16kVtBJETRU2nGCZ2yrk
 DMcw3hM2+qlfVlPeGltXzROVqp3H3TzxWBCpwhT8mJgMwAZLWNy76dA9ADm9uaSOEwYc
 zWdV34qQPztWRKEuYtrBCK0m/mIAG9wnylH4bmlxKvFYlXNpm9Qql78vIX3Jx+gWpmMQ
 4oQi9ZcqcTMUUqdsao6gM2k3z49v/w3pGk/bcvooE/2Hm2YYFbTlsPOPUngDkn1vDe8Z
 OExg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788335612; x=1788940412; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PfaLzZerxFLunMgLpS/gaZxp2YqbVEJ8PvbY/ZvlMaM=;
 b=D/NvR9hWyU1CgDj5fVKwUr/5ZJ57OPsIl3RHggj6m4bDidtnjEkoHZtxJr8z2tybaZ
 GjfUyN6NjL5o9FDA4ftAcSjA0OxvCotJUb5SGpQFlvdoY9v0/A/TlOIa/YF6yYFHQtQL
 kbBM+vvZo5Q8x23FZEy3i+XAzgctYCLVXo6i5ftDrq0bkq3mACLV7Yet2pfz1cGAlEAK
 Dky3PNUqB/9SajsjiNVo1mLbfC6Rn+Jxi7x5Bh+BGSk+GujLCgbj+zcKVeM7VPQcPiR6
 jDg0DNtxJiT6TIF6zN90syoxuoOa5wNrtPWk/PUxxugA2pL+VI9/cIKT8FTse0qY3QPT
 duHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788335612; x=1788940412;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PfaLzZerxFLunMgLpS/gaZxp2YqbVEJ8PvbY/ZvlMaM=;
 b=mPL861UBqw5onDXZIDkmCX69Ld9pAhIFWJHQnupX1E7mErGPoEK0oPx3RESP6cLk1n
 m8aspFAx9JwOlDE3o2H4T3MsZ43bbqo6F8vo4eFqGXAKmO0J/aVuelrfDmrHDP09Hxu0
 0o+zUbFksootRI+9LmaLpXmuGsGOJoF7mVi5y7QL3hkxtOMCi26ZX0QLBEY3UORJeVWE
 GiCTsGeup3H3qJuC5gpq6GYVX42Fy7BHwGxezbUV9Z+2SNPtlqVLQ+i0XrwwQK+/qy/w
 R7ez1l4SGVXmA8Xs40e+Ighbz7bOpSzf3XJNby7aNflSgmIN5huBlte5Yhdh6mcdVVi4
 vQFA==
X-Gm-Message-State: AFuF++mB/lrnij7vSz/lI8FIQxz8wPuqPyA/89j4aIFIpVNTkvAV2in1
 yw/6zOdUSeoWA0wvRtJmmU2rK55TeBILP8lHnBWr8nFpj8NtKnT79iJrfNKR2WRJr+bITr0N4w+
 x3C6DPQcYqGQI/pyMP8WQqHfEAdo6SjjETEy57PMi
X-Gm-Gg: AR+sD10YuWgPrT2XV9WlIXLnf0sm8pWiEnHV1XAyXasGaTX/Guy2HFNyd6ax/2TLx86
 k/9QZLUNGutq+FiirDMY3gM2A416vwtdqKKee55s231PcojAw9rwm3GSmziBSQKHze7O1QmR3v3
 ESulwH7OeHoWMKCJFMolObv2iBaloONZnx3Tbx4qt6s8u7oIOshvHJUOWtTc8+S+ZyKPaNN2Ic3
 6HJv1kitvAA6S3gZUgabPxAA22WMXsm9uWkU9VQPprswVYMWNTGK8S3EaeYN2v9M+Qz0OvMN/+L
 zY2j7MP6VEMVoP7IrsxOuKnpKWabcPce1c/cLSaW/Zi8skgRBAzLOA==
X-Received: by 2002:ac8:5cce:0:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-53033b5642dmr13655851cf.14.1788335610960; Wed, 02 Sep 2026
 00:53:30 -0700 (PDT)
MIME-Version: 1.0
From: Stanley Jhu <stanleyjhu@google.com>
Date: Wed, 2 Sep 2026 15:52:54 +0800
X-Gm-Features: AcwNN1WPLhrJYxcAB2wobjcst3EgHWGpWz1r18aHMk7Bfn_Tc2XG7X1y4j8c-aU
Message-ID: <CAE14pdeFtCpRNa8ps7ix2STOk3r8MmtPrkze=aNqgoES1iPkrg@mail.gmail.com>
Subject: [PATCH v2] hw/ufs: Reset controller and MCQ state on HCE transition
 to 0
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@gmail.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=stanleyjhu@google.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

According to the JEDEC Universal Flash Storage Host Controller Interface
(UFSHCI) specification (Section 5.2.1 "Host Controller Enable"):
when Host Controller Enable (HCE) transitions from 1 to 0, a host
controller reset is initiated. The host controller shall abort all
active transfers, return internal state machines to idle, and de-assert
all interrupts.

Currently, QEMU's UFS emulator only clears HCS and HCE registers upon
HCE=0, leaving internal state active. Specifically:
- Outstanding SCSI requests in the block layer are not purged.
- Active bottom halves (doorbell_bh, complete_bh, and MCQ sq/cq BHs)
  remain scheduled.
- Allocated MCQ Submission and Completion Queues (sq and cq) are
  not freed.
- Dynamic MCQ queue registers, legacy UTRL request states, and status
  registers (UTRLCNR, UTRLRSR) remain stale.

Implement ufs_hce_reset() to:
1. Implement .cancel callback in ufs_scsi_info to properly unref
   scsi_req and prevent reference leaks when SCSI requests are purged.
2. Cancel active bottom halves (doorbell_bh, complete_bh, and MCQ sq/cq
   BHs) and guard them with a resetting flag before purging requests,
   ensuring blk_drain() cannot run or reschedule request-producing BHs.
3. Purge outstanding SCSI requests for all logical units via
   scsi_device_purge_requests().
4. Clear standard request list slots and release SGLs via
   ufs_clear_req(), and clear doorbells and status registers (UTRLCNR,
   UTRLRSR).
5. Free allocated MCQ queues and clear dynamic queue registers while
   preserving static capability offsets.
6. De-assert interrupts via ufs_irq_check().
7. Add a trace_ufs_hce_reset() trace event.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
v1 -> v2:
- Added ufs_scsi_command_cancelled() as .cancel callback in ufs_scsi_info
  to drop scsi_req reference and avoid leaks upon purge (Jeuk Kim).
- Reordered sequence to cancel all active BHs before
  scsi_device_purge_requests() and introduced resetting flag to prevent
  CQ BH from rescheduling SQ BH during blk_drain() (Jeuk Kim).
- Cleared UTRLCNR and UTRLRSR registers upon reset (Jeuk Kim).
- Guarded ufs_process_req() and ufs_complete_req() against execution while
  resetting is in progress.
---
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.h        |  2 ++
 hw/ufs/lu.c         |  7 +++++
 hw/ufs/ufs.c        | 94 +++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 00e263c7ba..1eb85c6978 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -14,6 +14,7 @@ ufs_process_uiccmd(uint32_t uiccmd, uint32_t
ucmdarg1, uint32_t ucmdarg2, uint
 ufs_mcq_complete_req(uint8_t qid) "sqid %"PRIu8""
 ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t
size) "mcq create sq sqid %"PRIu8", cqid %"PRIu8", addr 0x%"PRIx64",
size %"PRIu16""
 ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq
create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
+ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ
and request lists"

 # error condition
 ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read
utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index a9cb8e9df6..42e7713837 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -147,6 +147,8 @@ typedef struct UfsHc {
     UfsSq *sq[UFS_MAX_MCQ_QNUM];
     UfsCq *cq[UFS_MAX_MCQ_QNUM];

+    bool resetting;
+
     uint8_t temperature;
 } UfsHc;

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index a792c342f5..4f9d0c2429 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -74,6 +74,12 @@ static void ufs_scsi_command_complete(SCSIRequest
*scsi_req, size_t resid)
     scsi_req_unref(scsi_req);
 }

+static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
+{
+    scsi_req->hba_private = NULL;
+    scsi_req_unref(scsi_req);
+}
+
 static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
 {
     UfsRequest *req = scsi_req->hba_private;
@@ -88,6 +94,7 @@ static const struct SCSIBusInfo ufs_scsi_info = {

     .get_sg_list = ufs_get_sg_list,
     .complete = ufs_scsi_command_complete,
+    .cancel = ufs_scsi_command_cancelled,
 };

 static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index a8e2df8087..def9935105 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -415,6 +415,10 @@ static void ufs_mcq_process_sq(void *opaque)
     uint16_t head = ufs_mcq_sq_head(u, sq->sqid);
     int err;

+    if (u->resetting) {
+        return;
+    }
+
     while (!(ufs_mcq_sq_empty(u, sq->sqid) || QTAILQ_EMPTY(&sq->req_list))) {
         addr = sq->addr + head;
         err = ufs_addr_read(sq->u, addr, (void *)&sqe, sizeof(sqe));
@@ -482,7 +486,7 @@ static void ufs_mcq_process_cq(void *opaque)
         tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
         ufs_mcq_update_cq_tail(u, cq->cqid, tail);

-        if (QTAILQ_EMPTY(&req->sq->req_list) &&
+        if (!u->resetting && QTAILQ_EMPTY(&req->sq->req_list) &&
             !ufs_mcq_sq_empty(u, req->sq->sqid)) {
             /* Dequeueing from SQ was blocked due to lack of free requests */
             qemu_bh_schedule(req->sq->bh);
@@ -679,6 +683,87 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
     return true;
 }

+static void ufs_hce_reset(UfsHc *u)
+{
+    int i;
+
+    trace_ufs_hce_reset();
+
+    u->resetting = true;
+
+    /* 1. Cancel active Bottom Halves before purging requests */
+    if (u->doorbell_bh) {
+        qemu_bh_cancel(u->doorbell_bh);
+    }
+    if (u->complete_bh) {
+        qemu_bh_cancel(u->complete_bh);
+    }
+    if (u->params.mcq) {
+        for (i = 0; i < ARRAY_SIZE(u->sq); i++) {
+            if (u->sq[i] && u->sq[i]->bh) {
+                qemu_bh_cancel(u->sq[i]->bh);
+            }
+        }
+        for (i = 0; i < ARRAY_SIZE(u->cq); i++) {
+            if (u->cq[i] && u->cq[i]->bh) {
+                qemu_bh_cancel(u->cq[i]->bh);
+            }
+        }
+    }
+
+    /* 2. Purge outstanding SCSI requests for all logical units */
+    for (i = 0; i < UFS_MAX_LUS; i++) {
+        if (u->lus[i] && u->lus[i]->scsi_dev) {
+            scsi_device_purge_requests(u->lus[i]->scsi_dev, SENSE_CODE(RESET));
+        }
+    }
+
+    /* 3. Reset standard request list slots, doorbells, and status registers */
+    for (i = 0; i < u->params.nutrs; i++) {
+        ufs_clear_req(&u->req_list[i]);
+        u->req_list[i].state = UFS_REQUEST_IDLE;
+    }
+    u->reg.utrldbr = 0;
+    u->reg.utmrldbr = 0;
+    u->reg.utrlcnr = 0;
+    u->reg.utrlrsr = 0;
+    u->reg.is = 0;
+
+    /* 4. Free MCQ Queues and reset MCQ dynamic registers */
+    if (u->params.mcq) {
+        for (i = 0; i < ARRAY_SIZE(u->sq); i++) {
+            if (u->sq[i]) {
+                ufs_mcq_free_sq(u->sq[i]);
+                u->sq[i] = NULL;
+            }
+        }
+        for (i = 0; i < ARRAY_SIZE(u->cq); i++) {
+            if (u->cq[i]) {
+                ufs_mcq_free_cq(u->cq[i]);
+                u->cq[i] = NULL;
+            }
+        }
+
+        /* Clear dynamic queue configuration registers without
overwriting static capability offsets */
+        for (i = 0; i < ARRAY_SIZE(u->mcq_reg); i++) {
+            u->mcq_reg[i].sqattr = 0;
+            u->mcq_reg[i].sqlba = 0;
+            u->mcq_reg[i].squba = 0;
+            u->mcq_reg[i].sqcfg = 0;
+            u->mcq_reg[i].cqattr = 0;
+            u->mcq_reg[i].cqlba = 0;
+            u->mcq_reg[i].cquba = 0;
+            u->mcq_reg[i].cqcfg = 0;
+        }
+        memset(u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
+    }
+
+    u->resetting = false;
+
+    /* 5. De-assert IRQ */
+    ufs_irq_check(u);
+}
+
 static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data,
unsigned size)
 {
     switch (offset) {
@@ -696,6 +781,7 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset,
uint32_t data, unsigned size)
             u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 1);
         } else if (FIELD_EX32(u->reg.hce, HCE, HCE) &&
                    !FIELD_EX32(data, HCE, HCE)) {
+            ufs_hce_reset(u);
             u->reg.hcs = 0;
             u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 0);
         }
@@ -1631,6 +1717,10 @@ static void ufs_process_req(void *opaque)
     UfsRequest *req;
     int slot;

+    if (u->resetting) {
+        return;
+    }
+
     for (slot = 0; slot < u->params.nutrs; slot++) {
         req = &u->req_list[slot];

@@ -1656,6 +1746,10 @@ void ufs_complete_req(UfsRequest *req,
UfsReqResult req_result)
     }

     req->state = UFS_REQUEST_COMPLETE;
+
+    if (u->resetting) {
+        return;
+    }

     if (ufs_mcq_req(req)) {
         trace_ufs_mcq_complete_req(req->sq->sqid);
--
2.43.0

