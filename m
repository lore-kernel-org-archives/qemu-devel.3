Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE80C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKRx-0007dY-FB; Wed, 13 Mar 2024 04:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRt-0007cL-5t
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:57 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRr-0002Fm-PW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PjRSzKrKLRaHnmivNuI06sMUXSnVympUdAmF8DrmVSs=; b=WuWwCkQ671+yNpXNOL1vF4A54C
 R3yy+8ZDUwPqOZB5cUYXgW76UM5T/T4BYJKhHM1M+cdWhmv00uHltKeMpiq912PxbNBJDd5t+iBvn
 Vl31gGiw3P3PmRQUPhydB9JAoxvunzHg9ao3ME2/1qUBFhYVdWTXCo0+W43TNli+lMNFj6NWH3doD
 NuHGZ3UjJvmGOMcCqiynzE6LotbHvfhqlI5n8Yqf2v1HMoTFBRJIr6oWgyMPDc2yRAQ6r33YsgNwD
 iVpdo9ixTfl4XHn0GgqIYMyd/qMTlazjdd+TcTBlNJ0sKju4qwI+3FubSTAWEKIkpj87hKicQ+d8P
 n1mFw82hv+zjGUFpq3ICBkBumEyPyUj0FUv8U/vuPwy04uiRNy22z8lYjlGHusqM0Wxr2rkuxr7T+
 vkzZWHG65VDFbULvsh6ibpaOUKDiQIg72ueYhNl1THi3nHe1C/8DfFhOib8/tz4i1FZQRPTDCd+7i
 aKmFoDRmCzrwQiBw7jIzN6xJJG2ot66A0cYqvHH3xvJ9AFwZo6XYLB1fK6XX4d5G4TcwgrkGWym1Y
 ywbtHMq584BdNfezrHW9VoaoGQ6RRevQPsW0Lp1Z/siiuRvLY1BgMmGBMlFyG4X3aQsgpJNUOtc07
 5VjesLGBxfnBL6mY9aOZ32s27X5hcX9IRh6LiEYDU=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKQz-000CUN-U3; Wed, 13 Mar 2024 08:58:02 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:57:59 +0000
Message-Id: <20240313085810.2655062-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 05/16] esp.c: change esp_fifo_pop() to take ESPState
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

Now that all users of esp_fifo_pop() operate on the main FIFO there is no need
to pass the FIFO explicitly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b898e43e2b..0e42ff50e7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -116,13 +116,13 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
     fifo8_push(&s->fifo, val);
 }
 
-static uint8_t esp_fifo_pop(Fifo8 *fifo)
+static uint8_t esp_fifo_pop(ESPState *s)
 {
-    if (fifo8_is_empty(fifo)) {
+    if (fifo8_is_empty(&s->fifo)) {
         return 0;
     }
 
-    return fifo8_pop(fifo);
+    return fifo8_pop(&s->fifo);
 }
 
 static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
@@ -212,7 +212,7 @@ static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
 
-    val = esp_fifo_pop(&s->fifo);
+    val = esp_fifo_pop(s);
     return val;
 }
 
@@ -1184,7 +1184,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
 
     switch (saddr) {
     case ESP_FIFO:
-        s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
+        s->rregs[ESP_FIFO] = esp_fifo_pop(s);
         val = s->rregs[ESP_FIFO];
         break;
     case ESP_RINTR:
-- 
2.39.2


