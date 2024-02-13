Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD2C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxO-0000sU-5W; Tue, 13 Feb 2024 15:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxD-0000jL-Ml
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxB-0001j9-N7
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UcLQegnMEj2QqxMcZ4nrFanoPpIbn3t7tK5XSeRX+u0=; b=tyI6Xb+xl6FB2GEljcdfjKOmgA
 sY21XsQfZANUepFTKDv6lAtxfjbLAH6zajmq7mb4ajQJE/dJHpvNcIu5AI8JNTQM+0+dU/CTI8bd7
 kIS1ISy1S/R8Avj0ilqut6kfSt/XENJXygxvokUBKfBSrBiPjRsOlQxcyWdetdURfRrQnBOsi+BaQ
 5r2NO7p9lLFx7Y1bskIdyYYkQWusLIaNfQQxKdXDDhGuvvmm/UugnDhAbCrekvAAT1YnU3zVUzc4W
 hMIcOdZPd6R9n/f6oGhmz647mv2/upwe8sJpMLb4/AD18DxYQSeH1uDeXEFtOpnWqtXkCUONoDSKo
 b4aDE9/yldEYHO9/q18RZV1MAM0ZIpeAP+xbs8XYGvqTUnVLm92TXwXAJ73sz9zWFKklhJ6Nbm5Bb
 2MRh9/lSBe2eAtPqS3Y7zXy3f19is2M865YltDaI7aVROtArM4+CB9qlThqhg0ILfs328LGNwcpEp
 uu0TXiQSFYWdZJRkl1fElC1kUPgWEUTnSzelbq66HHLnT4l0Yo20MEeJgmw7hzROONutyt09f9kpf
 f9CfLigx+BgKtEjs0z/77SOk+9eicAHXl/Pn7O5NHg8xpldMUEdi6AWKcrO9D7V7NfiMA0njaOOxv
 LD7grMCJXUN6EBJfZhEuqFL0UV1mb0qj5CX/kbuyU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhL-0008m4-1Z; Tue, 13 Feb 2024 19:44:10 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:34 +0000
Message-Id: <20240213194052.1162753-71-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 70/88] esp.c: ensure that STAT_INT is cleared when reading
 ESP_RINTR
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

Both esp_raise_irq() and esp_lower_irq() check the STAT_INT bit in ESP_RSTAT
to ensure that the IRQ is raised or lowered if its state changes. When reading
ESP_RINTR, esp_lower_irq() was being called *after* ESP_RSTAT had been
cleared meaning that STAT_INT was already clear, and so if STAT_INT was
asserted beforehand then the esp_lower_irq() would have no effect.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-71-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6c62417985..604fb9235d 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1127,6 +1127,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
          */
         val = s->rregs[ESP_RINTR];
         s->rregs[ESP_RINTR] = 0;
+        esp_lower_irq(s);
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         /*
          * According to the datasheet ESP_RSEQ should be cleared, but as the
@@ -1137,7 +1138,6 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
          *
          * s->rregs[ESP_RSEQ] = SEQ_0;
          */
-        esp_lower_irq(s);
         break;
     case ESP_TCHI:
         /* Return the unique id if the value has never been written */
-- 
2.39.2


