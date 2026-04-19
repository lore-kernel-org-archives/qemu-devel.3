Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F94EA719B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wERn8-00012E-BJ; Sun, 19 Apr 2026 09:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmh-0000tt-IO
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:02:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmZ-0008Is-Lu
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:01:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so12686945e9.2
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776603706; x=1777208506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BC7q9hzRbwtGtEYWubxXb/HFj+bPnVoN51st/id0Ug8=;
 b=KOInC/WrTA2FAWYIZ7+8yLDBgHC/q5rybwn/1vwRiKFtr0l8BxY6hCn/1CSfE1RUp0
 +yZ8lYsVQIuZPAJfcI+MQRRJj2/UgPKv13NrLlUNC5gqxGuVznOYKZcmWp4fard01KFS
 oTfawGO8MsPDROQ3JTbW7rHaNvCe08zo3RpX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776603706; x=1777208506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BC7q9hzRbwtGtEYWubxXb/HFj+bPnVoN51st/id0Ug8=;
 b=E5GKM223HfQvtbGMMVqtw39t5Kej1OOvbw0kDS2WGOYLlFOrVH7oL8jxlu/0XpCaMs
 XI+aNsX7It2xIDyIW25BKrbnFeoD3Tj+XWzeSfzhWK3oSG2OR4dwHLuzqJEpzh8RCcyw
 HxQszkC5g+C5mqC421fceZTfkpHULr7hOct2xAYhvxSM5hrezR+d/dHBjVusa+/FcdHq
 33RjIKYbyV9hEGnLQZyXBCBVg183bkz5TLDSSxwVJvVjm4wIeHoRDRUqvxEG8whG4BJv
 iWlKook+sO2uXrhfpHWkOEqfa2i4uIz/kS3clSVfb/hG9b+93X1JSSoVfMMVlFi5GN4A
 fxHw==
X-Gm-Message-State: AOJu0YzXHJtytwa6DyzCc1nwUd6N5cy89Eysn13sN94j2ky7iK2rQXKO
 F+s1oFD27b7dcsrKbCKLMh9XSagpnnI50/XskW9mKrEaI8N53gk/2hwSoUD8EY73l03I8F3nCwQ
 QHMUIZgg=
X-Gm-Gg: AeBDies3RE9zQnZzTJBW8QBCfAHxjH4Yh8uJn4SShpFLujdQq/cdGzkpAUUGJcw4kAm
 oxXvcALOsAqzMaMiQLOJNgBR+COqjSA8lNml75OqBdEqp2ae7x86Uhr++fQkRKm8r0mfjadvahS
 pX5iuNT+Td6wCO872t6AHdTB+d0nAlEgKtrwNYmTCQs/e0GSzzPYUiq5xUyO1tuwBXJqeHOBbSi
 HK3CeArUPHsHHqlGAHr5caXSrYqBeYpLtu82FP7v2swMdATR89IECRtmjcbbbqQcNdpFJw+vaVt
 oS5ua9WlgG7Wpxp9BK2VUgoQrFiXKIkknt35dWG8ihRUvEPpMBNQFgkVTb8ZIAhw4GkktHRXWbB
 3Esh3kdD8yHv+hvRmZi0qRZDBm5GtfYwsbtg27dnb3qhrD4HUYgcxk+Rg/VR5mgvvaeU5QZO2nT
 2ycYNQ8wrTv1uJDoTOzub6bt0tHj1omUQsYsEWLt7aEmT/3IzEc2GnF2QuZpND7rwyMNMoqBTx4
 cfZVpJEJecIdTQp7ybT4yxjIv5mSRd7Iw==
X-Received: by 2002:a05:600c:8587:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-488fb7856b9mr97480865e9.20.1776603705515; 
 Sun, 19 Apr 2026 06:01:45 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00995e4e0d3496e07b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:995e:4e0d:3496:e07b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm20734304f8f.13.2026.04.19.06.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 06:01:45 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v6 3/8] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Sun, 19 Apr 2026 15:01:34 +0200
Message-ID: <20260419130139.15554-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419130139.15554-1-alexander@mihalicyn.com>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32e.google.com
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
 hw/nvme/ctrl.c | 59 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9f9c9bcbead..191398e700f 100644
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
@@ -5555,25 +5563,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
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
-    QTAILQ_INIT(&cq->req_list);
     QTAILQ_INIT(&cq->sq_list);
     if (n->dbbuf_enabled) {
         cq->db_addr = n->dbbuf_dbs + (cqid << 3) + (1 << 2);
@@ -5590,6 +5589,22 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
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


