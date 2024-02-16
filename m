Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C1C48BF3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5QL-00065w-Hd; Fri, 16 Feb 2024 16:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QK-000632-3G
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:08 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QE-0005LI-4Z
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0fckCtdAs7r1KlB/LRZZ2cQg6ZKtZEkOPsZO/6bCfjc=; b=ZV6a8NPtXlnyXE32YZfhi30KwN
 EOmCnsQF0xuJ+16VbAB5sQVmrCF97URmVIIttjTuXvLOBUfYNFxxLA023cn5yuT9CZiB3agTE+mIA
 RvTaGvabWAT5KYPCLHSWvu0F5OhIyTMhEdgxRBpbW8cyHT1NbgRrIs/oBa9eBH00+CqRc7th8bs3K
 WPQS643kUZ/0fK0SJNtQjWuTod29v5r08B5C6UarjxmyTqAv8GrcFmYSwv6YKH1BrbLCHsg8Zgwjy
 diAxKiqkUytzlgRmgjQl9QYtboriqyHNOy4TxA/MHquqqYqFDuaRICKvPpk8mfOQcbOqZCD+oP12U
 CP7kkjxc+8DaS4GMQemkbmK+2g1SLkwVo16K/NC0PhaGif91BCswnbA6fwH/CJE/me+hW55EmxQe3
 62S8k/vOc1zGThvJzwTo1YX1tK+G457e6nYOl0vOMC1h7nU04i6C3V0URPE8rWrqZtqKfOx5mWuPv
 nVXLkzNqtoP0AzP0h6sHK72f2dj+QrIx7JlMIglYMAzQP2wOQN9/YFLrBcwFXzlkuJ1Y+6K44GdjJ
 QgtDXD3lN+H85uMp67KQrzOh0nhR/RWat2QZ30UhYsEnA5YSZx7daeozP6HbD9nKoZBjGlo5d2S7z
 jw+l2LYO4JIVS/IDc2Pse5C4Anw5EBsysM3M4k3pA=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5PQ-0000vT-Md; Fri, 16 Feb 2024 21:06:16 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:23 +0000
Message-Id: <20240216210633.1376066-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/13] esp.c: replace cmdfifo use of esp_fifo_pop() in
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 100560244b..7a24515bb9 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -312,7 +312,8 @@ static void do_message_phase(ESPState *s)
     uint32_t n;
 
     if (s->cmdfifo_cdb_offset) {
-        uint8_t message = esp_fifo_pop(&s->cmdfifo);
+        uint8_t message = fifo8_is_empty(&s->cmdfifo) ? 0 :
+                          fifo8_pop(&s->cmdfifo);
 
         trace_esp_do_identify(message);
         s->lun = message & 7;
-- 
2.39.2


