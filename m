Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7B0C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyeV-0002I0-GU; Tue, 13 Feb 2024 14:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeT-0002Gk-Hz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeR-0006DT-9j
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iLYkZARu1vtJ3SiTWVKioF4o+HiVbNwnzi4KqCUj564=; b=X69PTqMcK+VXusg/nzA854DFNG
 QBD1Alir6pgA8McyDqQNgm0G/SUbHidnB+BnhjOcYLkeU1jgiGGwUNelvAAyvJXlHVHyMZuC4T3dr
 7h9pOhk7VYjQ7fLoXJNCWmXOxUnAf7fJnsDbfygJp6LBLJ4Q32htLxD7ZEs3+z69QFPWhvMqRJd13
 865WirEPTM4BIL5loarpMikPAZbZfIkpiH7MsqFey605P+LLXgRhYGNDj+OZ2UMn5QLYVyxUMw5tn
 aufIQ06edGJkQExWI2uN/C2xzK95sf6HWNxyvcWz5nvwO9kFMIDGF7eghehIM9YRHBuHWqIzrzND4
 Cn1yk4T6Eqw2Ys95gHd8J6BBiE0pnQCxkberb2jN2DCnkzj9sfqTpqxYWlYOydzuFPd2UkJn+toF7
 kAwc7IUC1ImVmbK1vIEtNft4E9EKUnl5b2xibQ9jxZchCmjmF4gMlcQdDGSclQOOEfVyp9rGbT+H1
 Kq44r0NxqTDyTR7oA8kOf/q385y2NhARhkgI8fAnk53ui1mg0ffZPw+/gXg3GSmigZE35dbCUTrCW
 pq4azE9Ft6alGi18smocHP6zhoBDnJDZF5S/6kX0czhrFoVqlZwDCOITcGorw/iUffZG1VGklbEdK
 SemqkqqaovBOjljSXDGGUEdTJtCDtaQMuTsw5lSlI=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZydg-0008m4-4B; Tue, 13 Feb 2024 19:40:24 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:25 +0000
Message-Id: <20240213194052.1162753-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 01/88] esp.c: don't clear cmdfifo when esp_select() fails in
 get_cmd()
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

The FIFO contents should not be affected if the target selection fails.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3a1c9f7c3b..68d07edc05 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -252,11 +252,9 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
             fifo8_push_all(&s->cmdfifo, buf, dmalen);
         } else {
             if (esp_select(s) < 0) {
-                fifo8_reset(&s->cmdfifo);
                 return -1;
             }
             esp_raise_drq(s);
-            fifo8_reset(&s->cmdfifo);
             return 0;
         }
     } else {
@@ -271,7 +269,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
     trace_esp_get_cmd(dmalen, target);
 
     if (esp_select(s) < 0) {
-        fifo8_reset(&s->cmdfifo);
         return -1;
     }
     return dmalen;
-- 
2.39.2


