Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A5606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivrHdm03
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHjL-0000aH-Hh; Mon, 26 Oct 2026 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHiZ-0008Vt-Vl; Mon, 26 Oct 2026 06:14:23 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHiW-0001YN-F0; Mon, 26 Oct 2026 06:14:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCF2A404C9;
 Mon, 26 Oct 2026 10:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB71B1F01825;
 Mon, 26 Oct 2026 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009648;
 bh=06kZN96W0Fky4x0ckmWfnaBpOAPPCwfW81AIcrztJV8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ivrHdm03xJAj3nVUKx4DcGbuQ0Sc1Xf803fAMymErSVJoZ/J3l5PaoQSzOpifCEBT
 9vNf+f6+XtSIGHWaqdjiAWHOV1A7xfSA2XevBbqN8XP+f0+hUnU0Aeao2Ppt7XaUwI
 qCUEMUJes96Jwyi8Ep7XzaD3T3zGYeDGumDew8hD3kTOBKU+TqYjKrgbg2jehA2qy9
 6yDL+0k7erBvY2RcxtjLakQu6EOT7Yq3Tn3B0ufXioAl06iJswexqRniBAO/ZM2XjY
 +s4whgkd/gdZUOL4Y48o2E8RyALtY5SwDG7FCM3fAPm5+IclMPIxQ12zGUvuZdgS0p
 WkN1CyWStmExQ==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:13:56 +0100
Subject: [PATCH RESEND 1/5] hw/nvme: fix endianness handling in the atomic
 write path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-nvme-mam-v1-1-5d53b5529ffa@samsung.com>
References: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
In-Reply-To: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009644; l=3074;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=hcZnxiyOddDYkYIcf5kC/OwheUIkcjOWEc63dAMui+o=;
 b=IDzreIbqH7YzqnMAAQqXr1ayU73YS3SKRtabZq/wJUkxrrSzpTtejooLjbDqU4x8/oXLQVNN8
 6TdCL5OSvh3DnUPinp+2H2tKOWoBc/0Ho/eMjGSYiDPLNVcQyV7AdA0
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0


