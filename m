Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6A3C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxj-000115-G8; Tue, 13 Feb 2024 15:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxH-0000l3-HK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxG-0001kF-6U
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U4wFtyvUgxolXpHyM1ojgGUeq66JkAtIYffuiQI5DGM=; b=YuQymqtRV25pn4mWOAeNZlmJCq
 mx9UwxWimgbAOe+qVspjCQ2/4woEfl6CE7O0D73bP+OR/KkPeetZaKrF2mxvnwcduZ6tcGM3J+XHv
 3eeaPRzJqEIkYMVtcg6db71120vr8BxqPGtodTYeTpWY6zVV30KnZJ+fKSIn7Q3507sMIAFbbSUFo
 AGd2VRDniLa9uBvBUOuWTrZYYLIqjMQRMBictxWh2TlACaI3OhlXv6dbrBeKpr8TmQYxBLpobpLs5
 DOgTAimhaw0K3A5MrHYxuV3V8gxqQRBb1mKqG41d6lQL1bb6nU2K2ylSfuHvJhgQvzQL+CCmZur+0
 8Mnt/ac8+VOJ8yrplbdMfEGXihgww9SRQPmdPAsRZpGph9ibKhln48c3bK7qr1eKT1QeRZ+Afc7tq
 kpbzqjCGqlkiR+rvCDx9OewKcy+1spy2wA67gaO2BEWe7+KmVOdLaX8QkWglrakB8aePQohiNMnpO
 oVhIx78FwMaa+0ZJkN+NBFkNI0IkcSIa653krFS1NYxLCq0sDEHvVIbqwYhvcLpVnDt0iVaWpRo2K
 Esp4y/3xMOJGloZX66bNZSn7HZhzH/tW6W+kS4wbVSic5a0vYEwyjxbFdcY9zTfHk5Dn9xfsDTn3+
 9kwf/2QngA5tiluaSZCBiace3Jt8eCHPqV0RAszVw=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhu-0008m4-8p; Tue, 13 Feb 2024 19:44:45 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:45 +0000
Message-Id: <20240213194052.1162753-82-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 81/88] esp.c: remove redundant n variable in PDMA COMMAND phase
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

This variable can be replaced by the existing len variable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-82-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ae65c2ef37..8ef6d203e0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -427,7 +427,6 @@ static void esp_do_dma(ESPState *s)
 {
     uint32_t len, cmdlen;
     uint8_t buf[ESP_CMDFIFO_SZ];
-    int n;
 
     len = esp_get_tc(s);
 
@@ -494,10 +493,9 @@ static void esp_do_dma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
             esp_raise_drq(s);
         }
         trace_esp_handle_ti_cmd(cmdlen);
-- 
2.39.2


