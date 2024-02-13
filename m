Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ABCC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyer-0002aJ-UZ; Tue, 13 Feb 2024 14:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyep-0002Y8-T8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyen-0006Gc-BL
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gL3rxkF+WyxBCs1v0/c31P8hNMH9IELl4XbMUORFGh4=; b=wYGIPipJGIHCc9w5qdfe7apKdG
 VP/+CH1G86f6zmfnRZHBHSzfagfmmWFAkLPwvmMZ1VCM/8QGxGPhtlAx3kA8A6BgORhAiByadiqbP
 1VYM3oM0c83hw+Kd+Odh69kM1LrcnVWh78cUJJmhm8bE6n+9xZqA0N8Pmf7u8GNVNZ+LxbOfOIpVs
 HhMOlTfxu29yJ7bERwesHO1s3LCKh+kOr28DVmAOYZuym85FtMqHN8fNbuIFPkrLI8bBalM6MQLL8
 sTPK4kVNOxkeRKB9Sb5Nl/9G8WPCbZK7DbdQBBr7AlPgS47hFXMJg3DqYXFjVGd0xMFwNWBIQx2eE
 PJ/+DVnp5J5Yawxi9LEIzcUSSuedgJuqfXQeHHTes1GNEP2ID6Y+gttYxxMac4afR2rJHnCpv17xs
 NaH2VrUtCI3rIYiJIk+Ynddvv1HRTB3jaadmNF8UQm1XvGILGSZgRdgLKZhAGf1rNUZD8d6+ZI7Ux
 0zpA/zbjtoOoiqYpkJOiNP7Q2JTA7cfbSaAKzwdV19zEHCSNs6y7JkT9wT+E+YIRiKBt3jDmnaQEA
 Svoji56SdZPIsCOWk5whZGUDuebijCGg6QQxik2u/+0JfsqZKLFSRFlPTRcgKf3ZHbzZCuwW7nVxG
 VjWC7mLX4OmZefqd6CK5VEc0NfWkWPq0ZFgvnL9Fw=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZye4-0008m4-Mh; Tue, 13 Feb 2024 19:40:48 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:31 +0000
Message-Id: <20240213194052.1162753-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 07/88] esp.c: start removal of manual STAT_TC setting when
 transfer counter reaches zero
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

This should be exclusively managed by esp_set_tc() rather than being manually
set in multiple places. Start by removing the occurrences exclusive to PDMA
and command completion which are those that can be currently removed without
affecting any test images.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-8-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c7b79a2949..e717b2e216 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -611,11 +611,6 @@ static void do_dma_pdma_cb(ESPState *s)
             s->async_len -= len;
             s->ti_size -= len;
             esp_set_tc(s, esp_get_tc(s) - len);
-
-            if (esp_get_tc(s) == 0) {
-                /* Indicate transfer to FIFO is complete */
-                 s->rregs[ESP_RSTAT] |= STAT_TC;
-            }
             return;
         }
 
@@ -720,9 +715,6 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-
-            /* Indicate transfer to FIFO is complete */
-            s->rregs[ESP_RSTAT] |= STAT_TC;
             return;
         }
     }
@@ -870,7 +862,8 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
      * transfers from the target the last byte is still in the FIFO
      */
     if (s->ti_size == 0) {
-        s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+        s->rregs[ESP_RSTAT] &= ~7;
+        s->rregs[ESP_RSTAT] |= STAT_ST;
         esp_dma_done(s);
         esp_lower_drq(s);
     }
-- 
2.39.2


