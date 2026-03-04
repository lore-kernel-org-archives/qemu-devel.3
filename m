Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4196CEB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiHi-00013q-1U; Wed, 04 Mar 2026 04:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHa-00010n-3W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:43 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHX-0000IP-BH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:41 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b78b638eso3177689f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772615555; x=1773220355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpP959L10hBsg4INOewg8w8g5XRXZUc7QBJng71AuUU=;
 b=TiTEL0nGnMVnEbYs6tYd/Qk97RpZBWQEmikzZLKWM4gY9ogL3MwgMfHoUlvIr/OtND
 Hz+u5bEccJpUrOxmPrpAg5bPPwC5/mLGsiYH+gsWi7/m6y6f2W+gX5vOQm4/l/gOiBx1
 Es9aNbRUn+e+vjSTZq0niYHt4DGotPNcj2jFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772615555; x=1773220355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gpP959L10hBsg4INOewg8w8g5XRXZUc7QBJng71AuUU=;
 b=hoDN05hzKVcA7AcvgICntN58XM/3Yges8FZ2mp8v0XWbXQYNH17rBaIl+lVaZZ5fPL
 tLMvYsw4d1qh1yYftr1r57txVhGVAl4RaH12DXf41T7NHvEANEAuuXM9Gz03IfAk3Wf1
 ZsviBhCIpgoA4fCPW1cIBzqjQuPV5S5Ztg0MZkp8ofq/l7CSbYHV7W9YZKmffp8cce93
 zGxM9yVhl65d94wgsQ+VVxQHLQ/I3H33cDsnzt2xgP9kTjVQHO/4nN8hEzpI0dcLH/T2
 u/Dno5bAs8T+hpqLrXVr9P2purOhMDiri3xwdpDrLWaJl2cZnbr/QucO7fHtesxtyDqM
 ekSA==
X-Gm-Message-State: AOJu0Yx+4WmC/cqM9A5043W+lq7F3Zp3B0V35nJhKUvaWVjD2lfBxSa3
 zrpmNH8t4dmMVjsQ/cma+a0vKD/uWq803fftzN8GGKSWEU8CbzClezRhZ0WB2YiUboPPuOdGdgA
 5fmoS8QU=
X-Gm-Gg: ATEYQzx0kMv0rnEKRBUdxJxEmBcHxnme2v9BLDjUYheUh6lp4xBEc2DfuHFMeY+nUYd
 wb/fNWoiM0bCsLOlQGJiOnbNVxQeH3FB1s5s4/Nk/lAnZKpWFdcF38BN/h1ttPwFQlIK6GmmsJ/
 lLZ0ihhgP+0jJPzTR6LetRVZ8vr77s57GKvaN86JKzQp44k2ds/Ioz6pSMXZuN7FwNnDWBWxf/i
 LzDDM6kwb0SbzRXKzNrOp6aWPVZFl+yY2+YCRhO5KxsBzZr8BXbP0mvLFKjvGK5pXN+25EdbObr
 ssD8tSShI1QGnYv65zI0bfax6taCiJDz5HZDZXvirtrMjnNL5MAWm3qwK/u2WL2buAMPvaYx1qK
 kn/bSeRgUPciTjN6n2/gWMk8XZioDBBxML8sEqUPNajSGFYdZ+RNkrnm+fPOSubF7ERxjVYz1xx
 wFO/rEdRW9O3aUHzC7+QEo8vBPaWyGcoWdnNuyo5J6TOmWPkXfUhFO0s+e/snj/psgsPDoVDXzE
 opTpmEMMGrwUHdQRuRKBGs=
X-Received: by 2002:a05:6000:200c:b0:439:9282:e728 with SMTP id
 ffacd0b85a97d-439c7f64ff6mr2512939f8f.2.1772615554982; 
 Wed, 04 Mar 2026 01:12:34 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00bac66d1b6d99e025.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:bac6:6d1b:6d99:e025])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c4489279sm9674234f8f.20.2026.03.04.01.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:12:34 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 2/4] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Wed,  4 Mar 2026 10:12:27 +0100
Message-ID: <20260304091229.80725-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304091229.80725-1-alexander@mihalicyn.com>
References: <20260304091229.80725-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x430.google.com
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


