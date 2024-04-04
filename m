Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF15CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO2i-0004IV-FT; Thu, 04 Apr 2024 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2g-0004C6-5z
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2e-00063S-LK
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8huvZxxDZ50KjAkufas2ax+LG6HAGS4cWRATyXbJKwo=; b=quFS0K5xvG1tqOf1u2JkSnyEBS
 KGVGCIHg/8Jobf1hft64eCvwE4Zz4ngkNIKLjm1ce4/ojHu7ra3ZqbJx9BE6OKfbz6iRNve42vzjB
 woasqgO32FKrER3A1/6m1+3vtttXF8CHK7touMPzxiA6XgyXRH6c/9/IpekaUkfr/Xsgs8eqnYJlA
 qfW/LGPUtSSk7J4QQrmgtt0pS8NIUPSICodwcF/qf4EMsReLxuPJjKPyKLTIQvlS62q/dlFtEBeXh
 aMlVL7nIHFesmUBKY6VTek0W6kYJ2SzF9ZBlNoQEs/ma/7tbQcNcf7hstKoelUrSbUMsqdsNaTjtL
 RaSRR3jo2FHcSyLjPxDQxwE2Q5oZrOEKv4neq89OEE4t8MMaiPVGzHmEWCHQug+AVNNiN7HtEE3av
 NgpXAG5uT6MA0ikekmzj7yuOrzkaU3yMhc+S6q+CKY5eSS+D0IzywJKqDQR0H22U4DNNFijY7JCM7
 TbZJS9JXvEZ+NCynQDCukviDiHTNm2g+TT0Z6jm+mo9pHv4VCuYIrFb+ChIYmAzjj7/0LCjbQCdqY
 6KoGEz4yVNrUM6mk/6F16tPYKqLo+cUfD8KMC4wQULrDhQ1hKVJmI5SrQdzdI3PBC7RpexoW7K6vj
 OlIEf58wFZ9KGQZf7O9J8d/Jfh5HAHQxVvs/8kjpY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO1g-000Bmt-6i; Thu, 04 Apr 2024 15:25:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:26 +0100
Message-Id: <20240404142539.711134-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 04/17] esp.c: replace cmdfifo use of esp_fifo_pop() in
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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


