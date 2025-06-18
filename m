Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8734AC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRm2o-00023E-H5; Wed, 18 Jun 2025 02:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2j-00022J-CR
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2g-0003xK-6N
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=1Hk+cnruCZZ0eODjDssR0hqnYTsJleDpqgxxa3KIy0w=; b=V8Qu7vtx+DZNnVyJm6suMtD0yW
 8mCoddRRs1rIkSSOQ+Pt156Jyi3MC0eXMAjdv0G8SkHy16hKOn74NEmnL/iad1MTDsmzcz4mTvj0c
 pdQ0WRbaaTbuDguaOT7gibDOzkfR89CZfjUvh2n9bqrajyEG2uDAfX8C7jev3X5usYbZ9WRICex7E
 DmFqhvp6PFEFBpbOMHpEdetkT78Jb/7Bdv6UBNPSF+nYViibslNALZo/XerA6wLmkUpL2xt1wLeYO
 XkTFOk1TYW9sPmSEbmkoQ/rIu1t2bIEQsPa2Tl5cxYMMw0UcE8Qt+wZuw/oUe2s1lLJy2OEhK+F0j
 C3sOusLfQld7PzXm20OXGytTDcwbpfjhNyP5+wRO5CjsBLrbTz55NzCRoR0zdNF+j7pZsKn7fR9Lp
 qyIGCjFs44z3N/C1waFDM09j7eVNdDxv30BFxZswfCauluF300FWAmSnJy8jhWAcd0IOw3G4/iSma
 qndHIGmgjWvotj19GgFeBuGzomjE5g2Bz1DbK8D7uC7C2kiu3Bno6oAwho/kXhavvGxc604KBNeRy
 0r8SzbTkst1kczpJF86T917szxBRRhJauEwS6fyXXuMZsGMZv51vpy3Nu7noktuD4p4b1UMG04ecm
 IDUorRnWUuyrn6I4Y0+igxWPINsiVw4t0/ZbiOeG8=;
Received: from [2a02:8012:2f01:0:737f:96a4:fe2:308c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm19-0007ok-OI; Wed, 18 Jun 2025 07:11:27 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 07:12:47 +0100
Message-Id: <20250618061249.743897-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:737f:96a4:fe2:308c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 5/7] esp.c: only call dma_memory_write function if transfer
 length is non-zero
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

In the cases where mixed DMA/non-DMA transfers are used or no data is
available, it is possible to for the calculated transfer length to be
zero. Only call the dma_memory_write function where the transfer length
is non-zero to avoid invoking the DMA engine for a zero length transfer
which can have side-effects (along with generating additional tracing
noise).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ec9fcbeddf..1c7bad8fc0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -631,7 +631,9 @@ static void esp_do_dma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI | CMD_DMA:
             if (s->dma_memory_write) {
-                s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+                if (len) {
+                    s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+                }
             } else {
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
@@ -681,6 +683,7 @@ static void esp_do_dma(ESPState *s)
                 buf[0] = s->status;
 
                 if (s->dma_memory_write) {
+                    /* Length already non-zero */
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
                     esp_fifo_push_buf(s, buf, len);
@@ -715,6 +718,7 @@ static void esp_do_dma(ESPState *s)
                 buf[0] = 0;
 
                 if (s->dma_memory_write) {
+                    /* Length already non-zero */
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
                     esp_fifo_push_buf(s, buf, len);
-- 
2.39.5


