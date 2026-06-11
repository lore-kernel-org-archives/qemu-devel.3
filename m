Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA4ECD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjpn-00071p-26; Thu, 11 Jun 2026 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpk-0006zy-UK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjph-0002Gr-JX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so694365e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781201328; x=1781806128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nza7GQuI/kpEISd3D+sr2iIcoZ5Psm5cIZXdAsY0e74=;
 b=es6sH7piJH0eVoCr/EUOclhMu5nqnDMqNYKkUJgU1Wp5IuH+IQ16mCHz8dG4Hi3ior
 /toGX3qg6HqBNiGfuQ5CH7kIiJujY9rZCSGwp+gWXxzQR3w2A4pCs85VNDr1rFg0EHDF
 Z7keUXOInsNQVu/SrTdvCg4G1orMX/pBWut28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201328; x=1781806128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nza7GQuI/kpEISd3D+sr2iIcoZ5Psm5cIZXdAsY0e74=;
 b=IwR6G7IaIVMUlC/h2aODcJyuoRap5hesBLsxwQKZADs/gZ5ZA4IndSwGEey6C/xEw9
 gxwc6xEbLH7Jv0q+K2MV10wt9J1XijD92xXF4Z4MfmiN3rbWYm8XslQC2hbiQ+IE2+K4
 WL5qcaAjyeF0kdPPOHaeluia8Gt7nu00JDPDRdaLEWrM4YeRIyxwJySC6g0o70ta2yAs
 n7+aOhxRhLqnRILtW28pVxhcDWV/wznVt/mh25BIubu5b/6vMwh6CfiB0p6eXju/V7gK
 frxVCxZPQ5oGdhm+iadGcnp2HWsGn5BNzDvepoiOZFqNB++kj6J6cecFj6oiDaGDiQYd
 vFJw==
X-Gm-Message-State: AOJu0Yy0hS5ujryRZCxSR44XEbKFYZvsb+W48wlWvGo7r2NpFXh0gsgO
 D+w2IUwEE4C75DS/uw6qKKGJH4tFtv5S2Dt9sS7DbR3qT7ULSUVsoxYgCb6r15ClvN7y71/GAZB
 PMweZMoo=
X-Gm-Gg: Acq92OEqmtdAdEXCgAZJt4RGPurLyqkizkOQuPB3BjJuLcfO04V8Qwgcgk4hHIsdc4f
 UTXW0QBj8zhaBezbXizxNKyB377lu+77G9vLw4H+ymJ+qrODdRIlVi1A9G+slxBj0IUjJvHaJeL
 ICPlCiGKNsdsw+68PnFmMtUR6mahVw+yTz++HgjgUe+pJlPmc7yar23qSDbE6akUgAuIpL5tYjW
 DTZYygnVooomtslazJWqzs6BLkhPlbSRKwHuRqGXbesnbfQPuOp1ntPOmtm2RHW/NokaUh45ZT9
 dDDaN8cLGWyfxYtxE6mK0pQ3cyl9buWF6Hd6nyagdblsJ9iw8jdW8f1GmXHKrP0eu8nLqq8dKVU
 dx3qyZITDmpKdIw3Otwbv7WceAhLJS2qqrMhoaA43Y4ODQCisOLDoO/WVDHDKbN1CdHlpnVDX8O
 gTb6iY1aLs/6J9qajOO75mwsH9MrRGpF+xxEfNW9I7D4IVw3V3W9kd0pn7pRncDcJey29igSaOx
 78uN5m/mpjvcFRijlUM7devGNJP+x8ryA==
X-Received: by 2002:a05:600c:4fd0:b0:490:be78:1861 with SMTP id
 5b1f17b1804b1-490e55a5d64mr51998895e9.4.1781201327069; 
 Thu, 11 Jun 2026 11:08:47 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006f778db3bc22ef81.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6f77:8db3:bc22:ef81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm6563345e9.0.2026.06.11.11.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:08:46 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v10 3/8] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Thu, 11 Jun 2026 20:08:36 +0200
Message-ID: <20260611180842.6390-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611180842.6390-1-alexander@mihalicyn.com>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
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

We will make a benefit from this split in later patches.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 59 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index b4a9728e06b..dcdb9bd66f8 100644
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


