Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3746FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKRn-0007b9-NF; Wed, 13 Mar 2024 04:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRm-0007ay-1u
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRk-0002Dn-LL
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+WHNdaOKHm7Ucu9jlXaFyhsYY37eka0uaRCKHKRa+UA=; b=icG4CAJ1Uees4OVM/Mg7ePPDeL
 Y45qyMyFlPBkuulUqyqaFV6/CuWrAewkb0crpw/TEGK0BJqmxhE3hfw3/xGtiHUVrdGtyWzJLwT+t
 SuvhlkTqaqmub3WfbAq8YrKfAUdm4mRLQngklayxAN6n2kKVTH2lOZG7TKEjBS4CWzhVpbeXtHTzL
 jiksq1Ogx1KfnLFrAjk1xHeYKR+D6Y5X7V+Bb7bCKxv3FEqYakHGV3jpVdLKQF/DqX+aDOvLYCXyK
 hnZKXRnvscxG6AdCYxRYWwteIdUPH2Uu5XVTwSsSA617CtB3uD/daPkRf3HVixH7pBzAQgfr0mGVA
 TLWSG/HKJJqbOu3U/tb+JFrKvpOcTTj1TkraY/MAxG1MyZ36clcNR/e4rnY/cjs3S6llXrkMCIXXg
 R3jvJyB0ET6eh2DoC5zCYBNKrGGo9exRrW1kH4QrnokFrTNk9een3rLH4GYnesKVpdMNxuo6jO8CO
 Ec30L5KylO+pEEKFpeW4NZl1Z60kwTAEHPuB6oL2NGQoTC92HbI9jcvVP+8OxR/gsoJ1I43PIK6bA
 POAWnnp86BlcRCzLmgtKzfFj3ytGLuQyfzW4yyukdImcnmhD7CF5W+V6KSzh03lfFRIJOn1XBkx5w
 YJUVdj//ZEd2Xx216aNHLxC/gfOJ2xQqqN8dAv4gs=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKQp-000CUN-JI; Wed, 13 Mar 2024 08:57:55 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:57:56 +0000
Message-Id: <20240313085810.2655062-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 02/16] esp.c: replace cmdfifo use of esp_fifo_pop_buf() in
 do_message_phase()
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

The aim is to restrict the esp_fifo_*() functions so that they only operate on
the hardware FIFO. When reading from cmdfifo in do_message_phase() use the
underlying Fifo8 functions directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f8230c74b3..100560244b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -309,6 +309,8 @@ static void do_command_phase(ESPState *s)
 
 static void do_message_phase(ESPState *s)
 {
+    uint32_t n;
+
     if (s->cmdfifo_cdb_offset) {
         uint8_t message = esp_fifo_pop(&s->cmdfifo);
 
@@ -320,7 +322,10 @@ static void do_message_phase(ESPState *s)
     /* Ignore extended messages for now */
     if (s->cmdfifo_cdb_offset) {
         int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
-        esp_fifo_pop_buf(&s->cmdfifo, NULL, len);
+
+        if (len) {
+            fifo8_pop_buf(&s->cmdfifo, len, &n);
+        }
         s->cmdfifo_cdb_offset = 0;
     }
 }
-- 
2.39.2


