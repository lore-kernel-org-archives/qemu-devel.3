Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FA5C48BF3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5QQ-000696-F9; Fri, 16 Feb 2024 16:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QJ-00062s-WA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:08 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Q6-0005Kf-S3
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ou60ZFfGz5wGuATfQwlf3o/Sr8yITEBKcHYAHL8PJg=; b=Dr6x5iYAX4hTuGmV8ahyMigVPe
 Mb6EkGCJk2swfG8rV5MkEKX+4KK4I7ojfT+vVA1E2bnAyfd1h1Zf6kJEarg1L9EE+IJk3spgleYeL
 oPUPApjiKUJWRazz/uKDyBFHjyKwWhyMIw8q/vKxe61Q3ChUfawtVp+/lva/2eEBT8p/omDHlD5Ug
 Fr0V5SdLewKf60NATYuSGH/uNX2e8WHZlyqS3KMj9MRfVIYSX98fCDpgXK4ORbvrnJfmwxMBS/vuB
 GMGTmmWyDS6xGD5QUqVJ6B0OY9OfYesQAIthTd50dU0988CiEwxeUlriqYGb82GTYDGGvcmAGJdwq
 8cV1jD4zpBtRv00ntBZ83ABBfkoQ0lBJAx4XkC/UOrVs1LO8nutl49koHCdnm8iElFNf79mlO/Iuc
 2BzTpLlcHGlh6lKbVj3HYf7ryBJ0m8p62ak4LapL2rdYqksFM9ImL2g3TPpHwIoCUvBIoldwN7xa1
 WvuVovn4pSyrx8g8qoi0kw1/4NKzkC54zsfEZSdXrB5OtiOYtRIjyhHMZWj9I8W3CItcnOO3ewy/k
 x+cLsZDyHkDh7T+AsSQXZW5ka++2V/6ip0sa7DtifSFwMPWqtsW8Szu3/mN4CWjBCSPgj2wv3q/Xf
 jWil4ZwQYeTnW2uYM4nlmQqaYSFwwzOv1Qln7WYvg=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5PI-0000vT-9p; Fri, 16 Feb 2024 21:06:08 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:21 +0000
Message-Id: <20240216210633.1376066-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/13] esp.c: replace cmdfifo use of esp_fifo_pop_buf() in
 do_command_phase()
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

The aim is to restrict the esp_fifo_*() functions so that they only operate on
the hardware FIFO. When reading from cmdfifo in do_command_phase() use the
underlying Fifo8 functions directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 590ff99744..f8230c74b3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -265,7 +265,7 @@ static void esp_do_nodma(ESPState *s);
 
 static void do_command_phase(ESPState *s)
 {
-    uint32_t cmdlen;
+    uint32_t cmdlen, n;
     int32_t datalen;
     SCSIDevice *current_lun;
     uint8_t buf[ESP_CMDFIFO_SZ];
@@ -275,7 +275,7 @@ static void do_command_phase(ESPState *s)
     if (!cmdlen || !s->current_dev) {
         return;
     }
-    esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
+    memcpy(buf, fifo8_pop_buf(&s->cmdfifo, cmdlen, &n), cmdlen);
 
     current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
     if (!current_lun) {
-- 
2.39.2


