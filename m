Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A71C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OAF-0007pu-PG; Tue, 01 Sep 2026 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stanleyjhu@google.com>)
 id 1x1OAE-0007pi-I4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:04:34 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stanleyjhu@google.com>)
 id 1x1OAC-0004V6-Js
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:04:34 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-51c10e86e52so226411cf.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788267869; cv=none;
 d=google.com; s=arc-20260327;
 b=qApw2WHBcRQ8GmVDggt8yGVDwKOtF8MWfjjw0shdFI7ZQ2HXYdMhjz3er8T58tNRtH
 ZWAg005rn/SyxgQLPftJjB8wEggVda1A150Hz0RwbUT1Yatw4ZnxFCCnlNmn30UIBKR7
 ArQqGXVA79D1rl7k6z5G4pTD/vtOWF487NFjPpCISNH2ashBCtFAqKjRtmfdAV1u7vm7
 pwqdzCdyBwiy7WTJyGqalrLG7b+CeNoqc/BK9U61kaLzU679UNwaVys4NttpqcoBTMAn
 odBSYR/ylSmWQWgYAfvOwQsiJ3WxLuqjc+7ZNo/tPGWhmUhZNiL3AULRTvwW5EpGCNSD
 4mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=NVAk6GBl/Epdh6mN5LVBBwrLBYBnY5VNFtE6oeW+ccc=;
 fh=PJUBCGRQhFruHgZtFVzU33RxwcrkxyEpHEWT05+ZO68=;
 b=ZgVEYB3Tj8vlmCqy+ZYURVEfXn54ODD0WXy6iLQWujXZqFWQRhmmRdTe3o90wUbtCJ
 G01JQxsdCUQqtjEm/sHn0Nx385Yco4fChuab2tBk260+nz7giOXugJPCYVbV8j4xyIgt
 5mgulXkkegorEjQ2zFJcXGVv2Y4A8GDQNH4mqSjNZuRFkTHh8ZTUVZdE95uA3rfv/GKg
 EU3+ab9DNtRcIjQ/L+aKw8Zjo8vVCO4B1Fkufmy5Y7KgFtBCgLTLNUyM/RUXYNQuqsEi
 ng0h16TP59SCMAHcHQnwYCXXa0LA6OADgEYHagAOXhV5yq9yKLV/VqnfAQNYUfz4mNfH
 +NGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788267869; x=1788872669; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NVAk6GBl/Epdh6mN5LVBBwrLBYBnY5VNFtE6oeW+ccc=;
 b=MRZzl8F9Na9yuuj9zO9pttebt20YXhHfM56pyU1/7bLatLnMEFVb4fPM6MLateyZsv
 Ur8GKVu/xqn5mpJpH5/UYSbmDBDJ66MGaVoQ0W8kbMrkbRGLdCSxo5VyZi6anMmBH+Wq
 REQFyMs6SOPGf6jEXryIPnp3xWslKZ3FnR+o61M0Z5tpoxWL4pAi15qIXMNVQPDLxLsF
 /5XmavE905xvKgzAxXV4zGxXiqghiF+4unULhtSCEOdfIT+umtZ9VTBro7wwNa3pt0kc
 wIXW7c7p0Yf4JX0NV19Xvw4oGNkgY955TirJOyc0mNFuoIrxQjOQCSILaiRa0+UIucco
 BRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788267869; x=1788872669;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NVAk6GBl/Epdh6mN5LVBBwrLBYBnY5VNFtE6oeW+ccc=;
 b=DR9IcUIuKeEYy6Kn6tLdoeqXDgY7nrFP+A/PDskin7hwKMIsMTufLpncZZ2Vz5QHPt
 EOFUbgQS0k/kkAm6bNVToBKs1XxJ8cO2hx6euZhornPcY4v55Du1EYyXd58d2OxP8kKz
 tfsdwqiZlP9VoIB1hreJXqch5o2jPrXnOVXZMl/t4qlz/kNkLBE52o+Y2OAQDNPITkVm
 OcuasIK8K39Ok375TvhoxLxiVp5bEb1qEjWTKZPK6Wqcl2RIa7gkNxlegAqHVRS6f7vS
 a0kfEVxs9wKxxLvp7CkeO9gv5EoilDIBSWmC8YaayqRIrf1C6OQTLdY9BxB0xh8OXlSb
 G4vA==
X-Gm-Message-State: AFuF++mkt4h1f1bwCjMjbLrDQJBCzqrsuGY9Vib6YdxR0JXS8Hv5J6dW
 rZeg9iR0XO1Eqh+zNFGx78VE1oY/8bY1QvdP9GvOXBw3o/Pn4SF2cDUP0okqZXaAJvu7atOb5oN
 rGR8rlBf1EMbfCD1BOfLMCBJQnX6Kqd75jJkFEta7
X-Gm-Gg: AR+sD10FZL1E2gq8rRqbBpyTx7490Sews3AKo28QVCSgUcEiK05v7z7L40kN3rW6hMS
 FTNoPygzZoS6t7ZkQgfI7GL5KAX8Zg5v8CK+ZmfL7m6ooWjxNWOfai7gDEtnDumckNEtolvfCBX
 0jgUoQsy0Gbb+Wb6YlcxWJHlOyllERxjsQojSS5Q+yE3T4403Ga/e+UpFALJpkuZyK3KTt2Hfm+
 9MSRHQHDTA0/+d6FIOAVQA8paFZz9LrasMOBohQC1yugfQMnSGZtrRmf6fVvY+DF/v8lTXPjR4M
 vmVhLKJRhoQTBjgPKPdvBVPqN8YR1N2kEiKhR0/FMLLA6LRzI9u5ICU=
X-Received: by 2002:a05:622a:428b:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-53024be8e1cmr14966921cf.0.1788267868402; Tue, 01 Sep 2026
 06:04:28 -0700 (PDT)
MIME-Version: 1.0
From: Stanley Jhu <stanleyjhu@google.com>
Date: Tue, 1 Sep 2026 21:03:52 +0800
X-Gm-Features: AcwNN1WQesaLm-6c_6dsMTJeHwrXmMQl7lGutVxeZ-CH3CyKQ7dKIvnZ8k0UBfc
Message-ID: <CAE14pdd_8whV+A_2qpujNTS+zeCes8M0e53LfN_zLY+v7iKPcw@mail.gmail.com>
Subject: [PATCH] hw/ufs: Reset controller and MCQ state on HCE transition to 0
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=stanleyjhu@google.com; helo=mail-qt1-x82b.google.com
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
- Active bottom halves (doorbell_bh and complete_bh) remain scheduled.
- Allocated MCQ Submission and Completion Queues (sq and cq) are not freed.
- Dynamic MCQ queue registers and legacy UTRL request states remain stale.

Implement ufs_hce_reset() to:
1. Purge outstanding SCSI requests for all logical units via
   scsi_device_purge_requests().
2. Cancel active bottom halves (doorbell_bh and complete_bh).
3. Clear standard request list slots and release SGLs via
   ufs_clear_req().
4. Free allocated MCQ queues and clear dynamic queue registers while
   preserving static capability offsets.
5. De-assert interrupts via ufs_irq_check().
6. Add a trace_ufs_hce_reset() trace event.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 64 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

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
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index a8e2df8087..b729b247f1 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -679,6 +679,69 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
     return true;
 }

+static void ufs_hce_reset(UfsHc *u)
+{
+    int i;
+
+    trace_ufs_hce_reset();
+
+    /* 1. Purge outstanding SCSI requests for all logical units */
+    for (i = 0; i < UFS_MAX_LUS; i++) {
+        if (u->lus[i] && u->lus[i]->scsi_dev) {
+            scsi_device_purge_requests(u->lus[i]->scsi_dev, SENSE_CODE(RESET));
+        }
+    }
+
+    /* 2. Cancel active Bottom Halves */
+    if (u->doorbell_bh) {
+        qemu_bh_cancel(u->doorbell_bh);
+    }
+    if (u->complete_bh) {
+        qemu_bh_cancel(u->complete_bh);
+    }
+
+    /* 3. Reset standard request list slots and doorbells */
+    for (i = 0; i < u->params.nutrs; i++) {
+        ufs_clear_req(&u->req_list[i]);
+        u->req_list[i].state = UFS_REQUEST_IDLE;
+    }
+    u->reg.utrldbr = 0;
+    u->reg.utmrldbr = 0;
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
+        /* Clear dynamic queue configuration without touching static offsets */
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
+        memset(&u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
+    }
+
+    /* 5. De-assert IRQ */
+    ufs_irq_check(u);
+}
+
 static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data,
unsigned size)
 {
     switch (offset) {
@@ -696,6 +759,7 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset,
uint32_t data, unsigned size)
             u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 1);
         } else if (FIELD_EX32(u->reg.hce, HCE, HCE) &&
                    !FIELD_EX32(data, HCE, HCE)) {
+            ufs_hce_reset(u);
             u->reg.hcs = 0;
             u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 0);
         }
--
2.43.0

