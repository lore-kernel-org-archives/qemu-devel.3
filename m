Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45842C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyxST-00028y-Af; Tue, 25 Aug 2026 16:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSR-000251-FU; Tue, 25 Aug 2026 16:09:19 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSP-0003Lz-2J; Tue, 25 Aug 2026 16:09:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B4AF600C4;
 Tue, 25 Aug 2026 20:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA341F000E9;
 Tue, 25 Aug 2026 20:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787688549;
 bh=K+iHgnhZpPLMCJVSJiBspKcNbZdBCypYJAqvU/cgBhg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IWW5mZwZZu4wAGVOvBBeI4JNO0IOmpWcXG+fg7Gft2q6QeXgBq7G31H6OBblgyA6c
 lifAY+svvxh3s0BgqP5rInKFl2dYICMq1z5EPT+0CDHSOLLBShTMkSBm3/Ukh0kkxN
 T+fF55m/f312w744s3bux1ZIE+4QdXHl4fgpSOu6Bk00qnIauMInxryDFXVdUVtLdf
 drLnl4TLOjFxQIjJsPRR7VLRGvUA73uJt+I6WJst5mbk5vzJhuK0TFvajNvRNzLtq+
 lx6E3uFQdWZvjt6WgZ6lwFOkHrOhqa0t5rZ/BzMpdy6sv4j0D9SdXGTB3/UEyk/EhO
 mjZhxwBlUMufQ==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Tue, 25 Aug 2026 22:08:01 +0200
Subject: [PATCH 1/5] hw/nvme: fix endianness handling in the atomic write path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-nvme-mam-v1-1-afc38ac713ef@samsung.com>
References: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
In-Reply-To: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787688545; l=3074;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=LObKqwvSfMPa+j8ZY+uXK3SSHFH3Na6h8R/mD+JvHBg=;
 b=WzkRVt6WmzJrRVUks39EUDt8muIlaxCEoRjjP6lNbi+O64O+/MRPApn7soAFFo9LFbSEZTuEN
 veK/s0y1WgzBUOB6K7oQlE3F2qjy2SKNpXnjJzZYay5zx7AgSJIQdg1
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Gomez <da.gomez@samsung.com>

NvmeCmd, NvmeRwCmd, and NvmeIdCtrl are NVMe data structures in
little-endian, fix the cases where their fields are used as host values.

Note that in the case of nvme_atomic_configure_max_write_size() we now
pass the clamped AWUPF instead of the unclamped one.

Fixes: ebd1568fc732 ("hw/nvme: add atomic write support")
Fixes: 3b41acc96299 ("hw/nvme: enable ns atomic writes")

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4893cf7e741..c884ca8a181 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7832,7 +7832,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
     int i;
 
     if ((cmd->opcode == NVME_CMD_READ) || ((cmd->opcode == NVME_CMD_WRITE) &&
-        ((rw->nlb + 1) > atomic->atomic_max_write_size))) {
+        ((nlb + 1) > atomic->atomic_max_write_size))) {
         cmd_atomic_wr = false;
     }
 
@@ -7869,7 +7869,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
 
             if (((req_rw->opcode == NVME_CMD_WRITE) ||
                  (req_rw->opcode == NVME_CMD_READ)) &&
-                (cmd->nsid == req->ns->params.nsid)) {
+                (le32_to_cpu(cmd->nsid) == req->ns->params.nsid)) {
                 req_slba = le64_to_cpu(req_rw->slba);
                 req_nlb = (uint32_t)le16_to_cpu(req_rw->nlb);
                 req_elba = req_slba + req_nlb;
@@ -7895,7 +7895,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
 
 static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
 {
-    NvmeNamespace *ns = nvme_ns(n, cmd->nsid);
+    NvmeNamespace *ns = nvme_ns(n, le32_to_cpu(cmd->nsid));
 
     if (ns && ns->atomic.atomic_writes) {
         return &ns->atomic;
@@ -8889,6 +8889,7 @@ static void nvme_init_state(NvmeCtrl *n)
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
     NvmeIdCtrl *id = &n->id_ctrl;
+    uint16_t awun, awupf;
     uint8_t max_vfs;
     int i;
 
@@ -8950,19 +8951,20 @@ static void nvme_init_state(NvmeCtrl *n)
     }
 
     /* Atomic Write */
-    id->awun = cpu_to_le16(n->params.atomic_awun);
-    id->awupf = cpu_to_le16(n->params.atomic_awupf);
     n->dn = n->params.atomic_dn;
+    awun = n->params.atomic_awun;
+    awupf = n->params.atomic_awupf;
 
-    if (id->awun || id->awupf) {
-        if (id->awupf > id->awun) {
-            id->awupf = 0;
+    if (awun || awupf) {
+        if (awupf > awun) {
+            awupf = 0;
         }
 
-        nvme_atomic_configure_max_write_size(n->dn, n->params.atomic_awun,
-                                             n->params.atomic_awupf,
-                                             &n->atomic);
+        nvme_atomic_configure_max_write_size(n->dn, awun, awupf, &n->atomic);
     }
+
+    id->awun = cpu_to_le16(awun);
+    id->awupf = cpu_to_le16(awupf);
 }
 
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)

-- 
2.55.0


