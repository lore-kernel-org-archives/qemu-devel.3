Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF58CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuAp-0000cW-Ty; Tue, 12 May 2026 16:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuAf-00087t-MA; Tue, 12 May 2026 16:57:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuAd-0003dS-Q3; Tue, 12 May 2026 16:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619275; bh=8UNfDJdHb+yrzOTJNdqGfFYwGI+KsYdynfiB9eZpL4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wasoQNPF9dwGewKcyOr4piBVic9IBnZu74SniQRlc0KIY0Udn+JJkNhdIuLlRxyhI
 O9HKYE8hzJ3EwpCpmCF480K5To52RU4zpH0PRHMw64O+ra1Wr9FblygfD4JDv4+WQ0
 u43idFoNYxN0dT8om0vAXm1ICDLVpAVjiCbufT+1UmsG+/xwCBZ9qvS0b2BG5Jj6/k
 Rfk4BqYCWbhzkDUL1u2+0UnRI0KNBwsS3skEcYdkDCX7FNoOk0tPOBk95FEbrh52x7
 0yI+6Hmt3IOZvjGb4Aie9PyVsmGLEPoBMg/mO/Rv7D8loGWKNiKj4hFIbAXyHi4Sx/
 cUeHY2J/RFKhg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3AD311AA2EA;
 Tue, 12 May 2026 23:54:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 483E03ABC5B;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kaixuan Li <kaixuanli@ntu.edu.sg>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 030/107] hw/nvme: fix heap-buffer-overflow in
 nvme_abort
Date: Tue, 12 May 2026 23:53:17 +0300
Message-ID: <20260512205437.360850-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Kaixuan Li <kaixuanli@ntu.edu.sg>

In nvme_abort(), the submission queue pointer is dereferenced from the
guest-controlled sqid before validating it with nvme_check_sqid():

    NvmeSQueue *sq = n->sq[sqid];

Since sqid is a 16-bit value (range 0-65535) taken directly from CDW10,
and n->sq[] is typically only max_ioqpairs+1 (65) entries, a malicious
guest can trigger an out-of-bounds heap read by sending an Abort command
with a large sqid.

ASan reports this as heap-buffer-overflow in nvme_abort.

Fix this by moving the array dereference to after the nvme_check_sqid()
bounds validation.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3348
Fixes: 75209c071a ("hw/nvme: actually implement abort")
Cc: qemu-stable@nongnu.org
Signed-off-by: Kaixuan Li <kaixuanli@ntu.edu.sg>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit eb5cc99aff17cbfdad16b18d3503c6f22233eeb5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c93039ba23..60738e3466 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6109,7 +6109,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
     uint16_t cid  = (le32_to_cpu(req->cmd.cdw10) >> 16) & 0xffff;
-    NvmeSQueue *sq = n->sq[sqid];
+    NvmeSQueue *sq;
     NvmeRequest *r, *next;
     int i;
 
@@ -6118,6 +6118,8 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    sq = n->sq[sqid];
+
     if (sqid == 0) {
         for (i = 0; i < n->outstanding_aers; i++) {
             NvmeRequest *re = n->aer_reqs[i];
-- 
2.47.3


