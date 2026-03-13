Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1473105F7AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13G9-0005T9-No; Fri, 13 Mar 2026 10:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fs-0005QL-HX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fl-0006O0-U3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so1812363f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411151; x=1774015951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lv8cYOpNkSeeqxeKbJ1G68OYSr/qDeNt7sRa838SjpY=;
 b=JPatPrlfjY+suhBbavLzhbRPW/TPwuNQHsWDLOoZobfCrdbE28cmB+bGm4m/sPnSad
 geK9gjgcSHFRq0/zVHr+97hTvOQGYmGkQfc3f//07jSCRssT9tYSSTkdZ1a1WNw9icbD
 co043sFi6lrDMuHySWuvwuQVzoO5AyoNZKSFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411151; x=1774015951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lv8cYOpNkSeeqxeKbJ1G68OYSr/qDeNt7sRa838SjpY=;
 b=hd08JXzkc2OLRmLOfIrxv2INBEiyUzJrX3GhQydJfvxamxH8XX1ozyacrs4onYyoAB
 2nVKsbgZpzjyNUXkHet3/WlK7dtSf4w35+tgRKuo5GDFyas/F8SLT5fYVENJjAWppXcU
 kKy8U93HNfSCf/dHd3CIedrhhv++AqHO2e0d9uMD3tq3vTr8une/lJdnR02Oyruu5Ahs
 Y8FBql/6zGsbQOzrn8k3xd1tO5DZ9B9ZxEUdzCl2fnLzKqyjNEjmOW7+Fyzvi3nsEBOi
 xf1FJgMkdV0M6E2rKALAHwJaRKYBs48auP8DbjwsHvbIQro+rN1qzIgGVn63v7ADnSDJ
 XkWg==
X-Gm-Message-State: AOJu0YyQpObfYj0BoZiAM4F3FWCHwNTz0jMMg8u6vLFVwzq2Ek6kAiAZ
 Ja6d6XxPwqsZobhqGAqHMz7UmwskAvS2P6YhzeBUtgB5BtaNxhqcdn8EqMLPA+z7NJ4Q+ElrtMO
 CAxMyaeY=
X-Gm-Gg: ATEYQzysBX+SymqOyPU6GMYxgft9clv5TvQt8ATNXEWmgFyTW+9fUI0wcOms3VE0ddF
 2paBbU4lNEuPe2G009YNTVO79MxqDRWrTYS+zKn7mriHj/H1579J9t8k8Kej3MUCjHF9ylxhs0r
 RMalYGbt8pZ/owsw3t9R8QfjLBPHjvyctrFUyDEwbaAPnguMPL21n+xuIju11JbR6YWu5dqBd9T
 MZ2kyi0Bvhr3TMftePxHap2WeREvlQAklHAV8n6kQiBw1wD+lBCv3QemSWXC+pZwg0AbYkObkDS
 HJUK2Lfhuoc8v3NLnMsMMJApEvXS/Fh/oc4oorTwI03UIY+WU5RZH5yeW609AyWBVs1fpnOLlTE
 MdxCV5HdCeVG6elgTVZlfRgI2wiTMv3WQrfZBTYXhWmH/5RiqT4KWWhBfxmHdypH2Vue1VSOYY4
 fSHVxcZo0bWsbstWFjpU3meOlpZ2B+QuaKTd8RigypcKI28RahWHvqI0j9pM80JkDWj1fIBzNWb
 R4ts9WwPuSoIA2UXdWW/JU=
X-Received: by 2002:a5d:5e01:0:b0:439:fcf4:32c6 with SMTP id
 ffacd0b85a97d-43a04dbec41mr6655959f8f.51.1773411151187; 
 Fri, 13 Mar 2026 07:12:31 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00321ddb23f48fbb73.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:321d:db23:f48f:bb73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm18580939f8f.7.2026.03.13.07.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:12:30 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 6/8] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Fri, 13 Mar 2026 15:12:19 +0100
Message-ID: <20260313141221.359503-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313141221.359503-1-alexander@mihalicyn.com>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x434.google.com
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

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 57 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9f9c9bcbead..68ce9802505 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4854,18 +4854,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -4895,6 +4891,18 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
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
@@ -5555,24 +5563,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -5590,6 +5590,21 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
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


