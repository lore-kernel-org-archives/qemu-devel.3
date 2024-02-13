Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA668C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyeY-0002Ii-3N; Tue, 13 Feb 2024 14:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeU-0002Hk-Ef
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeT-0006EC-2P
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ufc3Eg8hezOcAS6d9idy+jWAkfMlLCSSNAhNoTUn1bc=; b=dRooZi5KpagC+f3RacrRAOh+Ew
 YVNeng0BF7Ju/cFMoEGqDnYpoXHZG9mJmFUwL6W0pFZeKgmnXt2xusM7CqQplUZ+rJqnJRhcEVoZj
 ViIGxn0I9L8cslBcs7hmyDHJFBV/PxFkgDaWDwEF/3HdfaNFISOEl2BEmo0eGy8YM3mJ9UFzXZvxp
 uH9vwprxsBNBMGl13Qo90NBz9q+YGGcagBGOTWdVcHOefG90o5lEGODL1ehz4g5JRdny8A1bNkIvz
 E2eftzJG/YyXTxTvKxRpAWTeb3oqUwye+Yj43d3p7jVTXOyCaDXZZr3viXEAk5Kx0XyNTy9Q7t631
 GUXvhfI855YCr5lPx31lI1bqlb35KPhw3nrO/oLxYQ+iS1dkNuJNUulclYKUzCVxfuhTFFjSb81+A
 8FYrRISKXiZdHulsZOBXZuibkXuTyIAeFi7ww6ZByZ+vV/rccyJLcZYuyVyYVIzKZjC3626vEHV+3
 QFD1JXLbeCGEeONein9fCdNQgRkkQWxEU/lebaPd4bOl1lwMtWP2xRoO7I6jnWXexp2Kj1B3D1mH3
 3DXIHfTXWYxMI5lHGxn7t35scNvkPoayjvLItOUe3cu2dbi97m0NN+1x/jWm/L+EppjnESn1TRV2h
 wj1BhFg2o6TH0mRw/ZPx3lTkQCZC5dYHSCWf/l+rI=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZydk-0008m4-7G; Tue, 13 Feb 2024 19:40:28 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:26 +0000
Message-Id: <20240213194052.1162753-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 02/88] esp.c: move existing request cancel check into
 esp_select()
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

Since get_cmd() can be called multiple times during a mixed FIFO/DMA request,
move the existing request cancel check into esp_select() which always occurs
at the start of new SCSI request.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 68d07edc05..b382865426 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -209,6 +209,11 @@ static int esp_select(ESPState *s)
     s->ti_size = 0;
     fifo8_reset(&s->fifo);
 
+    if (s->current_req) {
+        /* Started a new command before the old one finished. Cancel it. */
+        scsi_req_cancel(s->current_req);
+    }
+
     s->current_dev = scsi_device_find(&s->bus, 0, target, 0);
     if (!s->current_dev) {
         /* No such drive */
@@ -235,11 +240,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
     uint32_t dmalen, n;
     int target;
 
-    if (s->current_req) {
-        /* Started a new command before the old one finished.  Cancel it.  */
-        scsi_req_cancel(s->current_req);
-    }
-
     target = s->wregs[ESP_WBUSID] & BUSID_DID;
     if (s->dma) {
         dmalen = MIN(esp_get_tc(s), maxlen);
-- 
2.39.2


