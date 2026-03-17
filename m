Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940E8FD7072
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ReQ-00020Z-1I; Tue, 17 Mar 2026 06:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdy-0001vr-Cm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdu-0006WP-4d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso45702115e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773743237; x=1774348037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lv8cYOpNkSeeqxeKbJ1G68OYSr/qDeNt7sRa838SjpY=;
 b=cFDRZc/lq4f6DtLkQi84W9LCVfaym3NbV8dycj06eL0A6vUjO7lbWAnW2NMwoUxJxL
 CZYr8u2YR7Iy5zCUyseEe8/QJKVNsIV1EtpRjwvoxms5/O/jSr4Iq2ZY/PZsafGRT1SZ
 bEjnfjdgFPoSz4X54E9V03BnQk+fNxhg/IqC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743237; x=1774348037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lv8cYOpNkSeeqxeKbJ1G68OYSr/qDeNt7sRa838SjpY=;
 b=S5xziEzGZUh24IeAjBotD0pY1vC+ic9MxXzlAX4tz0seBSgG4ZRn6CqzsydR3tfznr
 2rvLsxrXAs4wC+23i0QD5q+/3ZxOxS3qm7wQqQFOx3oVFJ3im4Y0Ig4eFqCFO0hxyBCt
 BpZ129NZT1Xgm/7WBSjn60BRpr6qIHVsX23Rwmn700Z5EArj9ounDuR7sbos4NrvEhVE
 oG17c1/p34AMXOs/JI5iY7OXloxBfJurvi3dgjvdKrLfoifhh6tB2xvrzfrrZbqXzO0G
 AmmdSMzFkfdP8H2ZvE9Y0zECu9Y7+TOilvl9EWei7aywoKMSXiZFpS3ABANYe4kszUVh
 z9HQ==
X-Gm-Message-State: AOJu0YyToVxlLJ7yOxpwtyFypjmVkQwoStV5ZMuH9+fd8JdLPUWH7gx9
 ORs0B0xuVQm8ptBaQA5hMG6RdeKGRogNURiwElFmNKLtjeq0n6vZLK3iTjbKDALoGl93gGbgY90
 CVRitNCk=
X-Gm-Gg: ATEYQzwOUd2ZZF0BC6QrlTKNALu5coSXpa2wuWipNwoZbqtmC4m/CFh9rnAU7iBrBHd
 m5ZWwmNQIdguVkweDM8lQousBFfAMWoue6QjUpO//JOPDvyqCtVv+i02TBzdp6aQJV9et0YG9M0
 21ZgSBLtQwZJT28uJkVDaGY91GPhWWzBnoMToxdNzKGqmbINC70uaTX+OzW02o/pMHpiQPPNdJ7
 knIy4IS27IiNmKzwrJzsL506B/kBg42SU84PqalJSMSefzZIJJPz5KQm9E/qEuvfR7y1/F2LNcR
 wm1XptrH53MedFxDnXpXUDowZqGwYGfZLRVPxDx2uKxh3Zs7yQON121/yQzyQT+OoxXvKpphFXb
 pqUXBBCpdHjRk/Ib84pXq12MjeFuyQrROzqvPmnjt/BT0QpMVt6bB4fJFFyRRAkiNaYX1mJNz3K
 Rv29h3MrC0mgy08HOI44FODbGCw9MaOLjhneYyZqU7BKKYCbGmUgSvdvT/0fa1QitdcwAIzVpUY
 KOL4HgAS+Fs7rGEp3/IEDU=
X-Received: by 2002:a05:600c:5247:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-485566fcaaemr284271005e9.17.1773743236605; 
 Tue, 17 Mar 2026 03:27:16 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0051af80c54da1a9bc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:51af:80c5:4da1:a9bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c36bsm61977665e9.9.2026.03.17.03.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:27:16 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 6/8] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Tue, 17 Mar 2026 11:27:06 +0100
Message-ID: <20260317102708.126725-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317102708.126725-1-alexander@mihalicyn.com>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
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


