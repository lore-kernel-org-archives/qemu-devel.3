Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF21CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 09:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqrGx-0006xR-SK; Wed, 18 Sep 2024 05:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqrGk-0006tp-9Y
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:46:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqrGg-00068N-M3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=QMp2RwAcPB10Y/NCxbIR5w0tfU+tZkdc3NSGX7eN+sY=; b=eH8NUIIqAA76Ir+tGuduQ7jaw0
 8GPBxSGmvFCEv+nJDOYSyeBt6fkPdtLPoEAoRw3nvUBw7PRXOji3A8iGRROsb1YbqeCoY2pYyTflo
 cV664Bd0D55CjysyM2jjlb00fnqS+rW+6kYJdJcMUd7+kURYbrocDeBcprUcRw65In21UdNxC326X
 xlkieu0hx2OZPMVFW/VuykF1RlnfRoxdz6p3JaHYYdSOj4TYlJQkszKdkz1RIRgRXnC6rsqA8fPlf
 p5pfS6eqtSJuUPBHFN7IkuSqiAeFPFE7d4mmuMjU+eWzQQmvZ4O7pxi5cczTjirUn7zJC1hrGN+ix
 o6Xu3yv7n/Ud5/ka0brbNlBagFp4e86q72clFDTyEl0pMFs2WQTdBSl1ULSQUA3XsdW7Xy4yM63uz
 ZhFJFqUilXD4/BOLfIaFutXZtH50ccZqB+H2DUmDtV34UPpuFsvLxCOkSoRLiCkpAn8+TstBy48Bt
 Pkc2+knw7RgxLvSizxAS6o1Ac6W8mt4XVH967kkesQQyZLyGlsqQoNloSHeeqNRS6dT2eEvCl+Z62
 /1DeXVZCPXi/wH2iIzmwCnMYMiUlvaKaDJEW4cjpcRBhOxfRTlTFeL8FuLMLPpOiv0uSZ4V8ZrMnl
 aekS9MMgywyxN8qyCfa3WHfPOUqhiUFAbw7kWMVMA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqrGX-000BB2-4M; Wed, 18 Sep 2024 10:46:33 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Wed, 18 Sep 2024 10:46:24 +0100
Message-Id: <20240918094624.938242-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918094624.938242-1-mark.cave-ayland@ilande.co.uk>
References: <20240918094624.938242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 1/1] mac_dbdma: Remove leftover `dma_memory_unmap` calls
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/ide/macio.c             | 6 ------
 include/hw/ppc/mac_dbdma.h | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index bec2e866d7..99477a3d13 100644
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


