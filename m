Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDABC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKRq-0007bq-JR; Wed, 13 Mar 2024 04:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRp-0007bQ-Jt
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRo-0002Ef-7x
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0fckCtdAs7r1KlB/LRZZ2cQg6ZKtZEkOPsZO/6bCfjc=; b=RtFVETXTd42mqQ0/q9V6ZSJxR5
 e2nSyBQusnW2quEFDBvf0RXGkL6oGbRn3XWjs/+282N0BcT38XKs5gVTcVMUGTIEYMMx30qmpiWzg
 EU8HjawFELNwf1ll8AqoYiL1nW/ATOyc/W1lVdnOhW4ujuPL6bKpXzZMwaNjC4mCb6OmU4xPH0if/
 pRNkrWqYlM74N9Mo8quaVZgk+efmbXudZoct/8jiA548Mhz64w8jttpoQyAW3U/EJxGAXAC/7pUU7
 A6Xr44+nL11tLVMEWZ7l1V4FlaOl+Pl4A7kJQYYqjORJzwvSu541wjTfG6yI/P8t4WyNFDf5hK/oa
 S7KGVYjjnxUQgf8e5ZR8FSjl7dYDvh0Xn1gP0j1pJRKdOYXLVFzVxFDFHrji985o8YVSNTQNuM4XA
 UD8BVjWsG3qg0DaY4/2ppuQiexdqBMy+X33IWC7Juul6iUYHbxc2AF0U2JtgL72fz8WO8PrwjcIQh
 +PIqxZubmkWqq+MQKBjAnaqB6LHVcugmF6YkHPYsAaz7jOd2tuJforG6j8JJ/KREPSQHCxXnKQXTo
 9PcLZ4/wIx+2cuHlczbUgIAnkviH11v001UtqYu51Ka+jIUjloy8TUvwvMayDdK3Abt+closle5G/
 ypFvneIB1XsR11iRKlJZNLSJNyMFf9LGa3OLvtvnM=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKQt-000CUN-PS; Wed, 13 Mar 2024 08:57:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:57:57 +0000
Message-Id: <20240313085810.2655062-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 03/16] esp.c: replace cmdfifo use of esp_fifo_pop() in
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


