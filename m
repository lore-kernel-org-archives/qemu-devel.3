Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A4606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=eSEz67x8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWozX-0006vM-SR; Fri, 27 Nov 2026 00:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozT-0006ds-Ob; Fri, 27 Nov 2026 00:59:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozR-0002PH-Jh; Fri, 27 Nov 2026 00:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=+Ov4+wDKhNFACKwe0hTPi92XzMwD4dZfyl/InoyTUnA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eSEz67x8w8Kto6wD7fiLaacAIP+8g3Brni4xPC/YDNUq+tNwqbubu3TZow5NaWj0v
 8myHPJYpKO58YXnkkhvycwnncwAQs8sSim4218vmLfXOuq5OsuwqXjraTHLoAJcFcK
 vzSngrYwRdGO4UNsY1TfQfIIx7Z/LVWZ9K9DJpJHICBb20CgMtpiTkv90hJzRwjT5T
 vti+yxvVvqnx4X5VVe1ewKJ7KhD2JTS0NO/wWtgvLXSfSYGyQ1virbJU76/RS+o7Jl
 yeNe7hJjt5m8tk1ZgQMNsYOGeGgq/q37QR8lgVjKZKRe2B4/OQdjviKRa4ucCihKIm
 26BtQbH7zELlQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF8B31EA2FA;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id ED43E469935;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BEFD8CF276; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 112/140] hw/nvme: report data transfer error on
 failed dma
Date: Fri, 27 Nov 2026 08:53:38 +0300
Message-ID: <20261127055421.39015-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_tx discards the MemTxResult returned by dma_buf_read/write and only
inspects the residual. dma_buf_rw already accounts failed transactions
against the residual, so a full-length transfer to or from unmapped
memory results in a zero residual and an apparently successful transfer.

Check the memory transaction result instead and complete the command
with a Data Transfer Error on error and add a new trace event that
actually describe the event correctly.

Cc: qemu-stable@nongnu.org
Fixes: f02b664aad8f ("hw/dma: Let dma_buf_read() / dma_buf_write() propagate MemTxResult")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4700
Reported-by: Karl Mehltretter
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit c448f7d21250a703fb0b2b0720d987c9671558ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8b34d6f0946..c01900a8cad 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1371,11 +1371,17 @@ static uint16_t nvme_tx(NvmeCtrl *n, NvmeSg *sg, void *ptr, uint32_t len,
     if (sg->flags & NVME_SG_DMA) {
         const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
         dma_addr_t residual;
+        MemTxResult res;
 
         if (dir == NVME_TX_DIRECTION_TO_DEVICE) {
-            dma_buf_write(ptr, len, &residual, &sg->qsg, attrs);
+            res = dma_buf_write(ptr, len, &residual, &sg->qsg, attrs);
         } else {
-            dma_buf_read(ptr, len, &residual, &sg->qsg, attrs);
+            res = dma_buf_read(ptr, len, &residual, &sg->qsg, attrs);
+        }
+
+        if (unlikely(res != MEMTX_OK)) {
+            trace_pci_nvme_err_data_transfer(res);
+            return NVME_DATA_TRAS_ERROR;
         }
 
         if (unlikely(residual)) {
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 6be0bfa1c1f..a11853c90a4 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -129,6 +129,7 @@ pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_cfs(void) "controller fatal status"
 pci_nvme_err_aio(uint16_t cid, const char *errname, uint16_t status) "cid %"PRIu16" err '%s' status 0x%"PRIx16""
 pci_nvme_err_copy_invalid_format(uint8_t format) "format 0x%"PRIx8""
+pci_nvme_err_data_transfer(int result) "result %d"
 pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint32_t residual) "residual %"PRIu32""
-- 
2.47.3


