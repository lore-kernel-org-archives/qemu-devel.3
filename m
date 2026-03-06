Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139C4FCB609
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWie-0007q4-4M; Fri, 06 Mar 2026 10:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWia-0007i8-Qu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWiY-0003Kz-Vb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so7181087f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772809433; x=1773414233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpP959L10hBsg4INOewg8w8g5XRXZUc7QBJng71AuUU=;
 b=Axyj4MNH+RGBrjyeNA93sq56r1V3eRQBhUC64tYn2zv1hQV7AiNN1xaONZA3+J5crk
 FMxlr5U3B93fG60iAA80z2HcnSwjXQh7FG0rtDbQ2FFaoQVTjp3OsMDbHiQ5TNqnAL39
 It1Hr6UcXTzbx+sm3eTDUthk3goh9Kud9vfJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809433; x=1773414233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gpP959L10hBsg4INOewg8w8g5XRXZUc7QBJng71AuUU=;
 b=cfOJ9vibXiz/XmP8sFwI5oBDQOyPAyt5BB1eQYAg81Ntb15X2RzPBU4oUf/fJPxBLR
 +r7CJb4zldD+DebOELSHeA46cMRCZM7OENkPn87UEzE4u5YgtFTkUhwrQrc6uuvJNwnM
 VRPfFN5l3TPoq/y/nGrsKfatl5cG4ezwrrRxhjVOVVN18Eajp4Wv+Hzts8prZIVXJEXT
 +PTI6wDslixKT3piUf+rP1Q1xQ+OHLC3CtFifMbzSkG0SbVJowBPTdnZwC+UYAKqQO7D
 jouY4tTznjveg+TEHRQcJCf6tmghboR2gMWQ9C/46sdGVJPg06dE1MsXH98b3Qw1RxzY
 4unQ==
X-Gm-Message-State: AOJu0Yy/xuUzxSkBpYFUnBFaI5RWlLinxbduzjTAJde/6XgSh11Sm7Xq
 zf1vPbHfMdd1embxgYBhspge0EaJxngHBJYeO4+3X+ygQPjZBm3zuTokAJsS6b2iXn7xOYhLeXK
 bFRiS0Qo=
X-Gm-Gg: ATEYQzx5r+HK4tWPAqFN0uiLjvtY8OAoLln/RFGiIJv//UpNXz21mwpEQMjqQqpJPb4
 WzEVYr4ZzIE6+br/X3mcBthwV3bqXaqX5YQQVWIvLG78w7sd7diRb3fM5WWuj/M75F3DTz4en6B
 SuzT01w7UBEXsNkbiXO4VycQZP+Gbg76oGEQFuM1ssw5jjA/cQudk+2CkCjjnlCbWLo8U37QCay
 AU8j9C/QRnFrc8Dtn29iVYy2AYjYvwKDWIjUVEzzxS0/qTkfPi5OGwjTWVsNSpqL1aWVeXkp8nC
 wLMzUOGIOHlrgneAjVbXmcT6c5BYZ5JdYrMcV28ZQkX5wmIWwMPtMWNFGFgSxoke2kR3bh0BUvS
 fwqxWMyOtdVAs749j1kjSfQkgnmwMJCi0xUCrmDmKnnn9L7pCb3BFkaUeQYW13idyxCbFfcGZS7
 erIZPPCFmmvRqma5MHhXyCmgz3c5jbXMmK7FnZk7vAsXtd/DNa19f0Z7i0IVt9BxUeTu9jFe1sa
 QsboZ05zUbGNmRbUJereww=
X-Received: by 2002:a05:6000:24c1:b0:439:bf2f:123e with SMTP id
 ffacd0b85a97d-439da55aa93mr3929690f8f.11.1772809428239; 
 Fri, 06 Mar 2026 07:03:48 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00583f1937c9b9cecc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:583f:1937:c9b9:cecc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm4703623f8f.27.2026.03.06.07.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:03:47 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 4/6] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Fri,  6 Mar 2026 16:03:40 +0100
Message-ID: <20260306150342.395923-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306150342.395923-1-alexander@mihalicyn.com>
References: <20260306150342.395923-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 57 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4694bdb4d02..89cc26d745b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4852,18 +4852,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -4893,6 +4889,18 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
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
@@ -5553,24 +5561,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
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
 
-    if (msix_enabled(pci) && irq_enabled) {
-        msix_vector_use(pci, vector);
+    if (msix_enabled(pci) && cq->irq_enabled) {
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
     QTAILQ_INIT(&cq->req_list);
     QTAILQ_INIT(&cq->sq_list);
     if (n->dbbuf_enabled) {
@@ -5588,6 +5588,21 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
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
+    __nvme_init_cq(cq);
+}
+
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
-- 
2.47.3


