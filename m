Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F272CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq2T-0007wq-Ry; Tue, 26 May 2026 07:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2G-0007se-RW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:26 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2B-0002JD-4a
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:23 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so1933669566b.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1779795197; x=1780399997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGye7z+1HEZD5bcZTG4AJTnCZQ0xFPkypcZSAsOjjsM=;
 b=jTJ0FweW8IWgfKIpARW4Lvk9bKGX5YaiJjsnHPUoaNEL8WhDwr1AZts7lItYun1tc5
 sHSdPBi2tp0S2r6HdCtBSXQwM9EUj98UJphm32Xoq6wT0oUsRAxJCRbYE4Ec84rV2tfy
 YrAETw0yIoFlifFRnh2KhIjqxMtXSl/5BHCvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795197; x=1780399997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IGye7z+1HEZD5bcZTG4AJTnCZQ0xFPkypcZSAsOjjsM=;
 b=mcmjCw3d7+p5bFboUh9xk2J6IU+Y+rJPMxjlCb7Tr5DBA/528CRY9YvzC5p4lG30Td
 4SQ9W5L6PmZRcWSZ5qKYDSa2ra66f9vZo5iQUbLkCSTfBlbagbF9TErvqm8tVt/cYU8Y
 X5KNWB9Y7MIfNh0BCtnS9KWxbi2koJDWUjC3q2zJbKqBg/3zyOZDERpnLiiOeuUQ1ReC
 liu9xizmyg2QAK+RerRNzUh839xTYDn/3feZoEgmaldsNDLIIP6OL+UDqfw4ByynxDQJ
 7iWODDfXxYtvHZ35FijAIy7LfrWLq/FQA3KSZd9YBMqDunNweGp8bFxv9neI+J8Y/w/E
 qvWQ==
X-Gm-Message-State: AOJu0YxzNp4wzaqwRW/cabznff/GBSuYCBXtlpsxnq7jlgBEtjuuw8Yd
 EKDLlnMlXLi9SXfvyvCVm6rLxoFX6C0T3Zoj43oTnlchAqKSLRYouwDsLVvJ63tpcBH50gJYCtI
 6Bo8yQ3A=
X-Gm-Gg: Acq92OGNxK1UVLSgbIlvW2zwhZtOeGBU+cSQpNgMSs9bPiPWHTwUsj43oCDMOBc0ubn
 j1eOU96Mq5zXgeK41EqIjaT+mwqxbFJmb9xM0pddcaGGPEcbXbw/0eBW6qtCwGygYAI9JTztycy
 ZwxTthYPo2K1pGaIg9G/hGkAIdAXANmiHjX1Heaa+qjYK4BdGnD0wcnQvWVc4IO7MwIR6u5SgFg
 FMMSzK1zBSpSyo1jLyE6ucIHsGQd5c2KzAsTHPPtKQpChwcgmOg1c1PSsgPDiJ2OsjAQaXRgoSj
 I04fSE8dAvn4SMSHgPGzOjRqyK4YxAEmsbRhEnk2GMsZrVTdXR47vgIgtSFWdpCMyPstZjgx/mv
 iwtNiJCgFiS9Lahvp8QgSGX7BQxF0xNA7hmQ4yDQejqEk43qiW19CDkJSSFvF3dXReYevYVwab6
 /YzmEijL0sBUlgRLKkvy8o0s75SSvbdPWQecFqA7D0nfttniEHhkhn4EMdtgJwsj/yHWbT9NfA+
 1G2l/GT9fpIi56CWx0ezUUzLKez6CRq7w==
X-Received: by 2002:a05:6000:200f:b0:450:b883:dd3c with SMTP id
 ffacd0b85a97d-45ea31a36c0mr36932042f8f.20.1779795186627; 
 Tue, 26 May 2026 04:33:06 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00840292fb31d0d80a.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:8402:92fb:31d0:d80a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm34366870f8f.18.2026.05.26.04.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:33:06 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v8 3/8] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Tue, 26 May 2026 13:32:56 +0200
Message-ID: <20260526113301.91492-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526113301.91492-1-alexander@mihalicyn.com>
References: <20260526113301.91492-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

We will make a benefit from this split in later patches.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 59 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 6ecaa67f3f5..718459ae1e3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4856,18 +4856,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
-static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
-                         uint16_t sqid, uint16_t cqid, uint16_t size)
+static void __nvme_init_sq(NvmeSQueue *sq)
 {
+    NvmeCtrl *n = sq->ctrl;
+    uint16_t sqid = sq->sqid;
+    uint16_t cqid = sq->cqid;
     int i;
     NvmeCQueue *cq;
 
-    sq->ctrl = n;
-    sq->dma_addr = dma_addr;
-    sq->sqid = sqid;
-    sq->size = size;
-    sq->cqid = cqid;
-    sq->head = sq->tail = 0;
     sq->io_req = g_new0(NvmeRequest, sq->size);
 
     QTAILQ_INIT(&sq->req_list);
@@ -4897,6 +4893,18 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     n->sq[sqid] = sq;
 }
 
+static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
+                         uint16_t sqid, uint16_t cqid, uint16_t size)
+{
+    sq->ctrl = n;
+    sq->dma_addr = dma_addr;
+    sq->sqid = sqid;
+    sq->size = size;
+    sq->cqid = cqid;
+    sq->head = sq->tail = 0;
+    __nvme_init_sq(sq);
+}
+
 static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeSQueue *sq;
@@ -5557,25 +5565,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
-static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
-                         uint16_t cqid, uint16_t vector, uint16_t size,
-                         uint16_t irq_enabled)
+static void __nvme_init_cq(NvmeCQueue *cq)
 {
+    NvmeCtrl *n = cq->ctrl;
     PCIDevice *pci = PCI_DEVICE(n);
+    uint16_t cqid = cq->cqid;
 
-    if (msix_present(pci) && irq_enabled) {
-        msix_vector_use(pci, vector);
+    if (msix_present(pci) && cq->irq_enabled) {
+        msix_vector_use(pci, cq->vector);
     }
 
-    cq->ctrl = n;
-    cq->cqid = cqid;
-    cq->size = size;
-    cq->dma_addr = dma_addr;
-    cq->phase = 1;
-    cq->irq_enabled = irq_enabled;
-    cq->vector = vector;
-    cq->head = cq->tail = 0;
-    QTAILQ_INIT(&cq->req_list);
     QTAILQ_INIT(&cq->sq_list);
     if (n->dbbuf_enabled) {
         cq->db_addr = n->dbbuf_dbs + (cqid << 3) + (1 << 2);
@@ -5592,6 +5591,22 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
                                  &DEVICE(cq->ctrl)->mem_reentrancy_guard);
 }
 
+static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
+                         uint16_t cqid, uint16_t vector, uint16_t size,
+                         uint16_t irq_enabled)
+{
+    cq->ctrl = n;
+    cq->cqid = cqid;
+    cq->size = size;
+    cq->dma_addr = dma_addr;
+    cq->phase = 1;
+    cq->irq_enabled = irq_enabled;
+    cq->vector = vector;
+    cq->head = cq->tail = 0;
+    QTAILQ_INIT(&cq->req_list);
+    __nvme_init_cq(cq);
+}
+
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
-- 
2.47.3


