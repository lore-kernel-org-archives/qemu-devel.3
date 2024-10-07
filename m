Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9353CFB455
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtFC-0005am-WF; Mon, 07 Oct 2024 15:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtF9-0005Wf-5q; Mon, 07 Oct 2024 15:18:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtF7-0004CB-KW; Mon, 07 Oct 2024 15:18:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 186B29624D;
 Mon,  7 Oct 2024 22:16:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E797714F72D;
 Mon,  7 Oct 2024 22:16:55 +0300 (MSK)
Received: (nullmailer pid 2592749 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mattias Nissler <mnissler@rivosinc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 16/32] mac_dbdma: Remove leftover `dma_memory_unmap`
 calls
Date: Mon,  7 Oct 2024 22:16:33 +0300
Message-Id: <20241007191654.2592616-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mattias Nissler <mnissler@rivosinc.com>

These were passing a NULL buffer pointer unconditionally, which happens
to behave in a mostly benign way (except for the chance of an excess
memory region unref and a bounce buffer leak). Per the function comment,
this was never meant to be accepted though, and triggers an assertion
with the "softmmu: Support concurrent bounce buffers" change.

Given that the code in question never sets up any mappings, just remove
the unnecessary dma_memory_unmap calls along with the DBDMA_io struct
fields that are now entirely unused.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Message-Id: <20240916175708.1829059-1-mnissler@rivosinc.com>
Fixes: be1e343995 ("macio: switch over to new byte-aligned DMA helpers")
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit 2d0a071e625d7234e8c5623b7e7bf445e1bef72c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index e84bf2c9f6..15dd40138e 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void *opaque, int ret)
     return;
 
 done:
-    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
-                     io->dir, io->dma_len);
-
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->blk), &s->acct);
     } else {
@@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
     return;
 
 done:
-    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
-                     io->dir, io->dma_len);
-
     if (s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) {
         if (ret < 0) {
             block_acct_failed(blk_get_stats(s->blk), &s->acct);
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 4a3f644516..c774f6bf84 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -44,10 +44,6 @@ struct DBDMA_io {
     DBDMA_end dma_end;
     /* DMA is in progress, don't start another one */
     bool processing;
-    /* DMA request */
-    void *dma_mem;
-    dma_addr_t dma_len;
-    DMADirection dir;
 };
 
 /*
-- 
2.39.5


