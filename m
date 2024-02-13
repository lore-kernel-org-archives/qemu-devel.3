Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96307C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfn-0004et-NO; Tue, 13 Feb 2024 14:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfe-00049W-Oq
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfc-0006MP-AB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=taIgXtH5PF98j3TWyQtb+SKAB0L35TLaLRp9AOCoESk=; b=WHTNtzyo2hQpxczWDHlPjME1Ks
 JD7nQ9ZWVh98uPvA2qbkTgpT3s2Z5xe9F9pDfYupPCNTZvA/Pfact8lAn0D6FS/bx21JmAScY/v8g
 BtGX4CC6XZkwl4mzd8Gbbf4B4KnK3vbGhLgNJiX2Et9rAXL2UhgAfvhFXD3Bo8v5/uOCBrnqL8FWZ
 xEY5r3Ldyg1a5tC8HRjimM7/D6uv/bH/l1LaoNwhHzIipLSaaHzPb7+ESRDcbC60J6UCWmYmxvLxv
 8mLqtPcU7DcB6aFwHjGY+BKfs68COtSlTwiECe3InL9E+eHHEgqBwHMru0DiBziKkTNKo/FO0FEW8
 sfFg5k1LlnsY6ElEM/+E5StOZSEvFikwgRf0BGISnTPvinJfljd00MBe8nE4TI4aaDzvuebww2C36
 MWfRxlHcMoh+ay0ZSo88G53ULZJH7qQ/neyDO6lJNtqDYFHiE6MTtpyWKwRwq1SCID1gf5RsXDDRY
 /2XVvk75WNW9MHOp1zIcDAAG230U7X0cLRkA+hkgq75W9Y7Y+wHTmMZ6pabcD5KmB50B8o9BdSnwj
 RMIz/r6E/78gfrqBpIz31mc+ykh5YDZMnn/U+JJLz2mLIEtJtu1tFUSyrk4CryRc3txWlQMY5yVxs
 lwIq6bXCbid6hpbEdfFc0laKt1kapHU6lkee/cOrU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyej-0008m4-LT; Tue, 13 Feb 2024 19:41:29 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:43 +0000
Message-Id: <20240213194052.1162753-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 19/88] esp.c: remove zero transfer size check from esp_do_dma()
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

The TI end of transfer interrupt only occurs when the TC reaches zero and is
not related to the SCSI layer transfer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-20-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5b9c3f1e5e..dc515e6435 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -748,7 +748,7 @@ static void esp_do_dma(ESPState *s)
                  * complete the DMA operation immediately.  Otherwise defer
                  * until the scsi layer has completed.
                  */
-                if (esp_get_tc(s) != 0 || s->ti_size == 0) {
+                if (esp_get_tc(s) != 0) {
                     return;
                 }
             }
-- 
2.39.2


