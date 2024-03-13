Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097B0C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKSF-0008K9-H8; Wed, 13 Mar 2024 04:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSD-0008Du-5S
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSB-0002Jc-PE
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zo6qBEL1QSeFZLNolV3DrVpqMBTkyiEf6bkbgHwJp1M=; b=VF33LB3X0NMWtsV9JEm4ag0k4n
 svLqY8LdaJpJMyO6pZIS0LBK0zeHQfBSFJNiHBqAkbwvYus9X5508z3i7xLesGS1vzPsHDWinXhmn
 dC72KyCxN2Jfx0lXaIqfzktxFe6gd7PQAU3II3VF7A1ISfeyXoeM3RngInlZVxgdxyXejTQmPjxM2
 kq+dQzj16VhXTlGSjZADz149VscRFJfqYWGRev5rpZfhsrJP7BtekyfCIcOAWXbF3f8ojKeWwuBYv
 tsg6EVBwziSNWqFR6qeX5q5KT+DXzfC5yw5eeKynCPTH1hYkOVyQK2WxdnIl6umjVWHP61vlaht36
 K7j/X02Y6Zil0WLMAC9eFxxbp+yQAEmS2CFsdJd+56qJ6seZSybQXcx+AtnH9TDcsUMqNKiQKS08L
 tSMXMaF7PjVMX9PQRHrPZQlExpWGlcdeWmLR5XPxp4hPWQXvgOAVL4Lk5Rnue1Y0pwdKuZT96zO51
 afbLgUuA12FnR5h1khcdT6RaupOWluobFSpAwIPUDSnTutBljPEPdH66Fm2DU3zVrNs4MLUi1P7zG
 KuCcBvI/9kjXegKKj8Cj1QFRFmOTaRD/uy9PtPrExRaqQee5coPlgYFKBPrd2Kg3J5V27MYrfRSM9
 dVZGHujqj16PTi8BRJJc1u2Z2aEOUZM7ObkzMsva4=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRG-000CUN-TO; Wed, 13 Mar 2024 08:58:23 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:04 +0000
Message-Id: <20240313085810.2655062-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 10/16] esp.c: don't assert() if FIFO empty when executing
 esp_cdb_length()
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

This does not happen during normal usage, but can occur if the guest issues an
invalid ESP command sequence.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 55143a1208..0050493e18 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -431,7 +431,7 @@ static int esp_cdb_length(ESPState *s)
     int cmdlen, len;
 
     cmdlen = fifo8_num_used(&s->cmdfifo);
-    if (cmdlen < s->cmdfifo_cdb_offset) {
+    if (cmdlen == 0 || cmdlen < s->cmdfifo_cdb_offset) {
         return 0;
     }
 
-- 
2.39.2


