Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FEFCD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMeyG-0006My-1O; Tue, 12 May 2026 00:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexq-0006Ht-Th
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexo-00076n-01
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:26 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ba928852a5so33270005ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778561002; x=1779165802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uenl0enR9nzgcOfC5e4ACNKv62NFjpchkb2UC2eCaLo=;
 b=jmCM2x8EE1cnePqD0xRqfPVx8jgaFclB2DS/O9vYgnNzIl4M6VQQIrCpqToHt/Toa+
 vNLRSd7s/LHNchexImYKGBzwEDKQp+eXerXxlVod0urTR+ofMef4MzBO2b8d7ebw5RkA
 YNEAHuIL5zBAE7P33omyasV09nk5uUr02zT6T2btxgZp34e31RwdfNdq2Jt+JGTx6y+D
 CROflfNvqz98RUnELK5vIz/y5zCPLfWgZaRLEvVhAI/5I15/h/utFpxedxhaxdR5sF1/
 TO86lcNH56ewkUsiKKPu0+ThAPrsosi/LNGbcfCFLziGv15tv6+GN4BWyvvrLnH3rNNg
 4Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778561002; x=1779165802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uenl0enR9nzgcOfC5e4ACNKv62NFjpchkb2UC2eCaLo=;
 b=oMrYvS6yuuMbtXt2nSE0SGWO6V7xpMds13MFKyf3y8oykecTR4Y1R0yW7lDGNWMVpG
 DAjT76098LQm/EURm4konzM6sI/AR8WfsjGF9JdyzQ1tenJ3BeeshMuiIoXIqFNHtRKg
 TwDUdaYX9x4FoDtv0g1ypGkuv4x8ZQZEN3iq1tLoY5C4SWXkpW+ovigZoLHgi6PbFiDN
 kIYcTA+Dg9EY61k0LTgsROqMeWXMDkU+VYPL5Vdb2vmDzKN/huAqHvqpmmHC/49LyOCf
 vJerZSPd11v83Z/XMfLqSXzqLLOLJ1aEp9Zee+oY/NTVS+q3ECRfunpHxtzd/fws21V5
 b3zA==
X-Gm-Message-State: AOJu0YyVVKNMYgZ5OYsp1xcOwrpzYT9rj4M3JAxjyjhKtc8pAdAaZt+9
 QIVJYYnG1B7g5pOgH7QK+um5bpCwGhhWntmYCbl7yhWYNX9l8YeXZ3B/dztKuw==
X-Gm-Gg: Acq92OHDY1t9AyooPr3U/Vfcm/fXgF387kijUY2G+WZGQiPfXIDFebiXtr9c4j7TUuj
 bG0VOCFtsDJTHvtVJrYbVa81CTYGTZak/IsviTHqru7NpO2P9Fbu+dXraM2vl8CKwj25XxdkJZj
 vdBBRl45O9VUGlVgMMo81v8y9XCBM3HatuNSbvV9eWf+AX1Y/vg9splcvdg+PbQWOkqw1zaf9nm
 qk8NwIk8G7F1nOP0YsVehcuxIjQ0BZQfrGqczz9ivCrr8Rf3p9Y7ESi4NXXRohFEgqSx/V5GkE5
 f9ZUBA/B0d6grigjDXo+bgOTACQtqPPYtZW6nLxUA+HlakXYwxGHTbzEWplWLOaDpGKVbYawJ3j
 KSt74Jho+615Ii9nW9OIiSU0cKeb45fXJuXpB2lKMi5xuUQdadL3UshajgYcEY2KavAAtGFitfW
 9dtl8M07J3ykoLzGTAs8jtioUi945U
X-Received: by 2002:a17:903:1ab0:b0:2b2:a267:784a with SMTP id
 d9443c01a7336-2bc7aa20417mr132376525ad.24.1778561001570; 
 Mon, 11 May 2026 21:43:21 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebe7f1sm108938215ad.78.2026.05.11.21.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 21:43:21 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 4/5] hw/ufs: Keep MCQ SQs alive while requests are outstanding
Date: Tue, 12 May 2026 13:42:54 +0900
Message-ID: <619c2da19a05668dabe7912afb789e50b8635c4d.1778560533.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778560533.git.jeuk20.kim@samsung.com>
References: <cover.1778560533.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MCQ requests are allocated with their SQ, but can remain in flight on the
CQ list or in the SCSI layer after leaving the SQ free list.

Reject runtime SQ deletion while any request is still outstanding, and
use separate teardown helpers so device exit can still release MCQ
queues after child devices have been unrealized.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 49 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 7734b35f08..6f7ea9c95f 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -44,6 +44,7 @@ ufs_err_mcq_create_sq_invalid_size(uint8_t qid) "invalid mcq sq size for sqid %"
 ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
+ufs_err_mcq_delete_sq_busy(uint8_t qid) "mcq sqid %"PRIu8" has outstanding requests"
 ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
 ufs_err_mcq_create_cq_invalid_size(uint8_t qid) "invalid mcq cq size for cqid %"PRIu8""
 ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 4ccd7aa64d..6548f0f637 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -556,6 +556,31 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     return true;
 }
 
+static bool ufs_mcq_sq_has_outstanding_req(UfsSq *sq)
+{
+    UfsRequest *req;
+    uint16_t free_reqs = 0;
+
+    QTAILQ_FOREACH(req, &sq->req_list, entry)
+    {
+        free_reqs++;
+    }
+
+    return free_reqs != sq->size;
+}
+
+static void ufs_mcq_free_sq(UfsSq *sq)
+{
+    qemu_bh_delete(sq->bh);
+
+    for (int i = 0; i < sq->size; i++) {
+        ufs_clear_req(&sq->req[i]);
+    }
+
+    g_free(sq->req);
+    g_free(sq);
+}
+
 static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
 {
     UfsSq *sq;
@@ -572,9 +597,12 @@ static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
 
     sq = u->sq[qid];
 
-    qemu_bh_delete(sq->bh);
-    g_free(sq->req);
-    g_free(sq);
+    if (ufs_mcq_sq_has_outstanding_req(sq)) {
+        trace_ufs_err_mcq_delete_sq_busy(qid);
+        return false;
+    }
+
+    ufs_mcq_free_sq(sq);
     u->sq[qid] = NULL;
     return true;
 }
@@ -617,6 +645,12 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
     return true;
 }
 
+static void ufs_mcq_free_cq(UfsCq *cq)
+{
+    qemu_bh_delete(cq->bh);
+    g_free(cq);
+}
+
 static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
 {
     UfsCq *cq;
@@ -640,8 +674,7 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
 
     cq = u->cq[qid];
 
-    qemu_bh_delete(cq->bh);
-    g_free(cq);
+    ufs_mcq_free_cq(cq);
     u->cq[qid] = NULL;
     return true;
 }
@@ -1884,12 +1917,14 @@ static void ufs_exit(PCIDevice *pci_dev)
 
     for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
         if (u->sq[i]) {
-            ufs_mcq_delete_sq(u, i);
+            ufs_mcq_free_sq(u->sq[i]);
+            u->sq[i] = NULL;
         }
     }
     for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
         if (u->cq[i]) {
-            ufs_mcq_delete_cq(u, i);
+            ufs_mcq_free_cq(u->cq[i]);
+            u->cq[i] = NULL;
         }
     }
 }
-- 
2.43.0


