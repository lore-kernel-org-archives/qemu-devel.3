Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179E0C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKS9-0007w8-Ay; Wed, 13 Mar 2024 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKS7-0007m5-Tn
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKS6-0002JF-FW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=joJZwegwbCqnRe+4e8PodTC16lX8ha3QZwpNcj9I3iQ=; b=isaKPJ56t3c2jW669Gfg3QADTc
 ZJe7PB3VWNJd2osIuozsk0eRzJFYln3eFYrqr8RjgUcPY3Ld4igEpy3Z6yeDchUN3s8dT1i9dDXPT
 i0XjiDEXzL8C6vKDiJb/AJaOZ5ZarpqvLu7IA7t/TINOhD8XC7+6QJ9iZuCtbaDnnCWxE9lFIoSjI
 diXCJZfnqMhSz5wvXZEbgp8eDR0M8ttYnPZ1XFHBElKazYWMCIdjdhh+IBAaKpZi3uNyX+UDL41e+
 d0ZbXEXvBITt0Yju8ZIPWNYLvGKd0R8+InwafwkA+UeVdFTYvVmbEdEfgEQNVMFLXImI5mLymWOzd
 pB0udbjSJkRrlEAiazO/7/uw4pDi2O1H+OGlBUKKkOHPx3dPNPrQGm5vlJBMiTHcDrYRAm8Vp+rjC
 Wp5TT6C74ktB8W/hI0zPvoKVM7Is9rnipiKFnknpOX0MRYAbOHQkMxzVfK7P3oe5X5lQAChXfGmDb
 5PaXX0soDz0neP+nIH7UNtSEt6+NQH1J9RspWqZroC9HZL9XUZ4LLW6by5/EMP1lhwFkJrynWAblq
 gfPgYT/T0uauacO53E+MMkV4c7nw42c7rthar18tYMp9fyj2tx8QqalB9fdJEmhPiT0WE469Orxr4
 ozovg6JdzaaHkMZZl0IJw320/aMGgqceOWhL34W80=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRC-000CUN-P6; Wed, 13 Mar 2024 08:58:18 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:03 +0000
Message-Id: <20240313085810.2655062-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 09/16] esp.c: don't assert() if FIFO empty when executing
 non-DMA SELATNS
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

The current logic assumes that at least 1 byte is present in the FIFO when
executing a non-DMA SELATNS command, but this may not be the case if the
guest executes an invalid ESP command sequence.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6b7a972947..55143a1208 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -762,7 +762,8 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SELATNS:
             /* Copy one byte from FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(s, buf, 1);
+            len = esp_fifo_pop_buf(s, buf,
+                                   MIN(fifo8_num_used(&s->fifo), 1));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
-- 
2.39.2


