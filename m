Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2428C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLX-0007Ko-Jt; Sun, 24 Mar 2024 15:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLV-0007Kb-Ua
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLU-0005Hf-Fd
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IGx7Zn87s247DEoGXYBeiyvlE89hVCd2NcRN2W6Cp98=; b=SYgFmDljWYJmzmNmM8d2aS3dMv
 S2aaPlmN+Dk0G7BYhz+Ofomc02dbB+Rx0t92d1+0r/TusEBnblLaWnkkTrBCsD5WS7nZAsg8TBaOn
 4rZ7rcH1MxkjoeoTEAnYbVcNJ5/mNJGNBlotZGla66odUrMc1uWGaPKUGIl7cDUkC9HkxN3rkfm6Q
 bMRL8+AL0D1VxygDG5F9seKG2D/UuZvnruZrkFbAgs++BIcOZ7KHLBbdT3Zq+AAcALlLToCiRf24U
 Ivd7fZhtxvMFJvQBxIFDiVNEUmePym895q5Adt0QYoGJlMto5tE/pALDrATJ/3uuJ5ShIspK1ldIK
 KhyplQs9nminTqkTy94xu5+1dXlV86AqFQM3NS8UBJfrWBLB823lk0u5eOR1/Jtgw3n+Zpj7YdHBi
 QX/sH8CM028t8pRbkgNGBvyJakbGy+E7nmfM3YRll3yjwCcj7a/AYqKpTu8mNuWjKTv+c1rLPArjS
 5HYFZfHFTNkCxbM7RSNkCxBavF8kb7LvKRMCtgEpW0YlEWQA3xiLTK2eAiN7BPeDTVEqLo0VQ95Xb
 h+ybP/0Nukw/4ad4MMuiNQRPP4B1JrLJNnN3I/t8e7xDa5/0mGKt0hsls6whYmLY9HRqC0EeJISUh
 ZFUX6hSPHR3Dq3GqeDLBHzFxL0p7TsDH08WaMt+V4=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKV-0000dj-2f; Sun, 24 Mar 2024 19:16:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:51 +0000
Message-Id: <20240324191707.623175-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 02/17] esp.c: replace esp_fifo_pop_buf() with
 esp_fifo8_pop_buf() in do_command_phase()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The aim is to restrict the esp_fifo_*() functions so that they only operate on
the hardware FIFO. When reading from cmdfifo in do_command_phase() use the
underlying esp_fifo8_pop_buf() function directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1b7b118a0b..ff51145da7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -280,7 +280,7 @@ static void do_command_phase(ESPState *s)
     if (!cmdlen || !s->current_dev) {
         return;
     }
-    esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
+    esp_fifo8_pop_buf(&s->cmdfifo, buf, cmdlen);
 
     current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
     if (!current_lun) {
-- 
2.39.2


