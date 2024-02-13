Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081A4C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxk-00015P-Dv; Tue, 13 Feb 2024 15:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxK-0000qY-RY
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:39 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxI-0001kx-Px
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f1NEFO4A0Vqg4tfIZJi/bQTZ9CGMao8x83kojNhLktk=; b=T1KdvEqQUD6rfsiY0u+o9+CBq1
 qvXjjqIAiNm7Tmct0gKtztsm+b9i1Ty7Glw/60WEW60ZrpB/1REbajNhmdQVFxyuCKg48kIK7j/Gu
 Q8eBt78sD4yonEFPCBJaMZZZmczDFGs8oqYKj6aZo3roTJvi+wFb9pkUK0p+cLVmeFh9O4v9k8MH8
 KC6ExYI5qGCx3F4S7JqF73pW4rGLwkhJoH+i6n25DQ3AoiaslNlAa8gvr73rmd2U7ibXC0f+CBnZT
 yBz69iUyxWbQ3L0b54LsY5kPaRZ/xah/2eP92J9nY3SlhEZIUohruuSWAMIPrNALKui1FzVhDj9m/
 s2UAU8FVDjTxS//i3q6j4qDS6T0H6//WhjGnOyP9ec/4l/6VlIFhxhIMPWF+5JLgU1OzE8+I8sUab
 lQ5ntY6waqSa/sDTzV3Oa8Re3paF2s4fGkv5wk/ndH38JBR6R1eU2tb/SVJivPKp6Avm0t/qJt3Q2
 bflfPZbpYzK+X4s+7vxBB/ES7PUh3kXVvnhoI7q77qQ7hLNWOBCWBqCsYkxDx78wQ8sCs6pZrVfA7
 JJ+gHp8aCk5ftFkRSFveEITpK2e/JIZuj9ImE0YSqHCbxlHgKDMGbalJe7tiB3gsNU98EWcaY9C1q
 92J1YeoZW6402xoBSv9Oj8LQhtWNKaNaWjv01gjgQ=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh1-0008m4-9D; Tue, 13 Feb 2024 19:43:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:28 +0000
Message-Id: <20240213194052.1162753-65-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 64/88] esp.c: don't raise INTR_BS interrupt in DATA IN phase
 until TI command issued
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

In the case where a SCSI command with a DATA IN phase has been issued, the host
may preload the FIFO with unaligned bytes before issuing the main DMA transfer.

When accumulating data in the FIFO don't raise the INTR_BS interrupt until the
TI command is issued, otherwise the unexpected interrupt can confuse the host.
In particular this is needed to prevent the MacOS Disk Utility from failing
when switching non-DMA transfers to use esp_do_nodma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-65-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index bcebd00831..dd6bf6f033 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -786,6 +786,11 @@ static void esp_do_nodma(ESPState *s)
             return;
         }
 
+        /* If preloading the FIFO, defer until TI command issued */
+        if (s->rregs[ESP_CMD] != CMD_TI) {
+            return;
+        }
+
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
         break;
-- 
2.39.2


