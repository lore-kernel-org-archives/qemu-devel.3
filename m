Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC53E909CC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNMA-0002KC-Vu; Tue, 17 Feb 2026 10:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx4-0003bX-VT
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx3-0005fo-A3
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48372efa020so31710535e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1771341923; x=1771946723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpP959L10hBsg4INOewg8w8g5XRXZUc7QBJng71AuUU=;
 b=U4XIah9PEwipknD1wF6QX1V0A8n9YkVLGzK/y7x2BQ7ThJ3vsDikGIiJL//kyExl4U
 f3mhA5RLLffAbvn6tTaK3eNoBFkSSnrUVRbDKuYMklKQcHA2dlq9rIRMKO3mZqk1Z80P
 mqje8khLXsiGJAbbw9YBMVRoNo25mX0qLleU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771341923; x=1771946723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gpP959L10hBsg4INOewg8w8g5XRXZUc7QBJng71AuUU=;
 b=lsVwzwQn4eNmxZ5/iK+LlGzGGqDMk9ePpobZFyL9E4H0HcSqqc7KFImlSQogpDimhk
 woeBEMBPq1+nZ9tNyxQ0l+D7DtUV2+m79NmivWrxC3w3Y/I8Q3JrUqg+fV1FUv7MrhI0
 ho2Iox66iBixjxu2nsn20/h+6Kgf4XL1kUpfjaxxCl1HyqQ4+5W9Xr+Yk286kLq5Ingh
 ecFAaD1niiuk/eRTy4olHfN2ekC9CoK4sZfZyfugLhY8ms/AukBqVSl+saXmEK5vrQuE
 SYlVbjBmA9lng8mAwzEE27Zwb3p6voPBhmVCpvVgPoYUfpX5oQHviVU+AUrlQeCFFAbj
 h+Lw==
X-Gm-Message-State: AOJu0Yw3FGoceBtHnFbxA7cjdmtUPuchz3vBe3gSt0zENX75dh/QVIZ9
 WqnOSPlCDEexHpy7PUx7ZNCzjklDABGFMwpRQXilH3D13jUXg0VGwajK7Cu7PTPNwbXiX1fR5fG
 FLJYu
X-Gm-Gg: AZuq6aI1+VaEhPH6bdEyRizV2dLNh/ffcvj2kyO52QljQ0kkstl0f0bi0wvsszd/l5Y
 0FYmvEmrMgu/ckw/Ynd39QcXEnQMvURVMeMrKXQrpvGljLmk3CfAWVUkYZKqYlC65gFJBCyhz13
 A5OZukL/uDxVPkdx9x8DwiqObySK++hT/9SQxcrKqS+RtMQSHt/R6bj/KxdWZGJL9jxOGa55Cvd
 WDcIxjlo1oxAd4GP+Z1jDOPubZgNe9Tuvb6et4c3bjFpe17cGpT2hUjVvdc1PoRwEMhAEY6oLWY
 IOGxG0arMQeWGnv7PWIqJ36b9L5iv1OwsFjborHKvsKM+/bbZCEyG+AQqAW7yPjDJKJR3GFF3Ez
 1E1ZZ/gj7kg/0S5QB3+o+nXXmlXcQdUCCtBfuy1Zs9evfhUPX6n66hPe6Ewc6hsalol4q5vCyLd
 VtDpWdBXtxF9RMOhM1P0bqxlIl3fv3xyaqaAD1zfTUTHh0j0HsnPqS2gt18TUp8WRNoSWeGEepd
 YoFNyB03FKSc5InvsxYbN8=
X-Received: by 2002:a05:600c:46c9:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-48379bfd71cmr178343185e9.19.1771341922297; 
 Tue, 17 Feb 2026 07:25:22 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf574bcf00ffb15ba913f79a3b.dip0.t-ipconnect.de.
 [2003:cf:574b:cf00:ffb1:5ba9:13f7:9a3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm519169015e9.14.2026.02.17.07.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:25:21 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 2/4] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Tue, 17 Feb 2026 16:25:15 +0100
Message-ID: <20260217152517.271422-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217152517.271422-1-alexander@mihalicyn.com>
References: <20260217152517.271422-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Feb 2026 10:51:21 -0500
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


