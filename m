Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5337EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLf-0007MH-66; Sun, 24 Mar 2024 15:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLd-0007M0-NG
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:37 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLb-0005IH-Kk
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pKSrrMhc+il7zI+aEzPaBqzcuN7Odu07lp/3ZHiMCQM=; b=MMcdQ4/5rY4J2JMKC3lmRZXmQ9
 zJbu708T/kpSlqueqOrCj6Uvzo8f7oyO+s48OhgBL4fv4maI5GmFJWzzmeHfFChnRKDGZ9w3lMWYY
 Z90wlIK1YxYvtTkmHrkKf+49fJKlR5lXZlq44mEztB4xwluuUuJUMHYQY6ja7WowX0rWysrd3HeG1
 7xYDAJUg2lb6LkYUJRcunsLU8hWbXY7yfzpiNFO9J7EdjyZoJVhyD67a7aQe/+CfRNMaI2CnAJIi6
 47GEo+VmV0ACApWJPfEZCZl1NBqoT/tQE3lRgSAVQJpnRDO/LOmoc9ZdyoaDMMBIK9pGYOBvH4yNJ
 RFtLV7eh0pIws1T82vsW8IVGfz70r8/Qxh5NGRYRr8iClaC6O4S6O/OHsiMuhrsp6Sof9ScwWRuZP
 wO72wiNh2t01jn+O+Ak0XuHK1+A4hGaFwBMNsga/jFvEZQLiMbYHxesrkDUthPSa+3Gp67s69w+Ej
 g2WM3g4h94yQGPlSgnaCMo/QZnlwTx4GRSatpHIq9foxq2CQGFzkj5vjYlZsGRXvgffcGjT9V97ED
 aH3v4nsVdR+Rm6NmYZVSop2PxOVoe0VCiTHWrD+flOCuhTTzacsjQgRSePTiiNOais96cdZJcHTgb
 2MpnWxzgwzteIhoYp66OjX3Npv9NxsYWAsoPLyiGk=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKd-0000dj-Br; Sun, 24 Mar 2024 19:16:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:53 +0000
Message-Id: <20240324191707.623175-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 04/17] esp.c: replace cmdfifo use of esp_fifo_pop() in
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9386704a58..5b169b3720 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -315,7 +315,8 @@ static void do_command_phase(ESPState *s)
 static void do_message_phase(ESPState *s)
 {
     if (s->cmdfifo_cdb_offset) {
-        uint8_t message = esp_fifo_pop(&s->cmdfifo);
+        uint8_t message = fifo8_is_empty(&s->cmdfifo) ? 0 :
+                          fifo8_pop(&s->cmdfifo);
 
         trace_esp_do_identify(message);
         s->lun = message & 7;
-- 
2.39.2


