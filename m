Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BDFC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0n-000572-KN; Tue, 13 Feb 2024 15:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz0e-0004rb-RO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:04:05 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz0d-0002I8-9I
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FH27qHWz11n07C8E0Vgf3CBwLl5tQW+/t0p2tOdInEU=; b=IJYGx0eei5sm9vvjgtk2v6EhwW
 Rabgl+i148UAuHa1U7YK8XkqYJrRToy1aiy4rM6VwAgpqZm3CtKuqXlhUg3Wy75EaxmaKf67IjkzX
 WRGlr0VqbypBHilWPGuzj+Wex7juTHcJ+ZrcuTQViAaLpjT1kEBeRkFnlLLfnbWeu6WP2W0XrBi3/
 mH/Rq/ZF1EpCmhfMI4ie6dycIIxfYo9Qg7uEG5mCHWi5qExYgSpPK5x9snH1gdQ8GkSkc12yS7O/i
 co4O+cq5oksQtD5JX/sxamyao4J6fGyVdn6xZnaTXrpZXlmzte7P2dEe7xC35SBsOh/FziYWEhfzp
 hlNqKQKRjr1E+6qNbnfkELEToKQL0053SwK+zepLaV6AS1sPF+l1KJdHf2m/dTo0OM2o9/se9HUr7
 izOQpM4Y6e0Njnvv0XUMxcT76DIH2gkcIT8L3+Ht23GL5WLFdzANJ06WPpfUN3AAUIn7XFoibh9bk
 /qg9WKwDbAQIaVGK5luhgd9XIxRbD6ZZwJ9eV32n2VpGteK7SaknWsBM9iAqE1Fd0jtzQtMqlvArk
 TjyHcfRoMJNDpaTkWbSlv8bvynefFbnbD7tI+KYyY8f4tLn8bAf/jRZ8rtHsaClJOuq9oe3qMku0P
 OS8Q6PAGxLWGUiBVXB6o6lhFviWxIsfyeMoHBXeko=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhq-0008m4-5l; Tue, 13 Feb 2024 19:44:42 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:44 +0000
Message-Id: <20240213194052.1162753-81-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 80/88] esp.c: consolidate DMA and PDMA logic in MESSAGE OUT
 phase
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This allows the removal of duplicate logic shared between the two implementations.
Note that we restrict esp_raise_drq() to PDMA to help reduce the log verbosity
for normal DMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-81-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 49fc059eaa..ae65c2ef37 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -436,17 +436,15 @@ static void esp_do_dma(ESPState *s)
         if (s->dma_memory_read) {
             len = MIN(len, fifo8_num_free(&s->cmdfifo));
             s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
-            s->cmdfifo_cdb_offset += len;
         } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-            s->cmdfifo_cdb_offset += n;
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            esp_raise_drq(s);
         }
 
-        esp_raise_drq(s);
+        fifo8_push_all(&s->cmdfifo, buf, len);
+        s->cmdfifo_cdb_offset += len;
 
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN | CMD_DMA:
-- 
2.39.2


