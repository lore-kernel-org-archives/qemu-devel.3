Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFFDC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyeZ-0002MM-N7; Tue, 13 Feb 2024 14:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeY-0002In-C5
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeX-0006Ew-0q
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4jW7lXLEbxFgTtylTDdvoHs79P2KJ++hoi/n37K19Ho=; b=GiSgqyWP0EVzcXKKt4GOR7VVat
 0Z5DS/gYc2PS0PnzTBae7PMUayxVr1pZBJrJPCl8jFG92yfdeduN6bbNzKiH4oOV6BdDI27uZhh1Z
 D452QUn9AhqHNzUMFGVc3/InSU7M1Uy+qWtH/5+h1wqhgmB/wOMYsgz8FyOV19aCHKqGw2LENFFVw
 CFhHMLd4tgY/EU+8hqQCienKsIseo7zXosnYoHk5viYAmnXZGPtfFIsvhKfDG3BpW9wOESB4LZQ++
 vR9CBWxzbcRXHdG3txiFbjlIFUdZ1vQ0JA+f6fqWp0iZSg/Dg6tdz9VKlQKqnF/EOoGO5kYSiAotH
 /jaIgMD5bxwD88TS3p5kxRDIB52usd3sTBg2dhxmnyAqKCZgEVek+ouf/wuN9gXXQaZgiC5CFle1h
 LRxCACutKwxciuGIRSWJLfcAqXgYij0tWnJiLJO1OOonizOYbBJk3joIhAS7fD706rldWPgj5HrpY
 4USFTPcc0je2/nQ3AGVFmwdt22Im1xORWS5XnF13v44ptEgtBBfXhiAzsRaZayvAYWJJZf0XuxzvU
 zajUZunpplKvPj5DcF5S2ftIsR4HOfAa4m2YSPd8zcgxf3HC2gdMaKExQnQc1zsQcVUxj4Euk4m44
 T/fz6qnA1IfZzXJd+K7yxmpR3eJjVdbUUqt+sTfbU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZydo-0008m4-AL; Tue, 13 Feb 2024 19:40:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:27 +0000
Message-Id: <20240213194052.1162753-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 03/88] esp.c: add FIFO wraparound support to esp_fifo_pop_buf()
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

The fifo8_pop_buf() function returns a pointer to the FIFO buffer up to the
specified length. Since the FIFO buffer is modelled as an array then once
the FIFO wraps around, only the continuous portion of the buffer can be
returned.

In future the use of continuous and unaligned accesses will advance the
internal FIFO head pointer, so modify esp_fifo_pop_buf() to ensure that
any wraparound content is also returned up to the requested length.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b382865426..8d8f6a817a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -121,17 +121,30 @@ static uint8_t esp_fifo_pop(Fifo8 *fifo)
 static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
 {
     const uint8_t *buf;
-    uint32_t n;
+    uint32_t n, n2;
+    int len;
 
     if (maxlen == 0) {
         return 0;
     }
 
-    buf = fifo8_pop_buf(fifo, maxlen, &n);
+    len = maxlen;
+    buf = fifo8_pop_buf(fifo, len, &n);
     if (dest) {
         memcpy(dest, buf, n);
     }
 
+    /* Add FIFO wraparound if needed */
+    len -= n;
+    len = MIN(len, fifo8_num_used(fifo));
+    if (len) {
+        buf = fifo8_pop_buf(fifo, len, &n2);
+        if (dest) {
+            memcpy(&dest[n], buf, n2);
+        }
+        n += n2;
+    }
+
     return n;
 }
 
-- 
2.39.2


