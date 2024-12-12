Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FA4E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLheb-0006s5-8D; Thu, 12 Dec 2024 06:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheX-0006rR-Pm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:45 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheV-0007Bh-Pl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=TW6acEL97ls8l8AGKBm2A8W3Y/leu7DELxMRD7Pnh6E=; b=Rqw8GQO5p5fOfFwYT1RUCmQJql
 61/E43t4pZWIzWKj2uDNbONhgfmXm+KCpRjdyNVbDCJxbMuZaDNRP1PlSmK0JqojsPa8ka1jFNhkz
 tUrNfvVm3XqsxBDKsaQV7q7Y20NReY/MQy14smRmvF5WC7Ia6QFPvbdkwZG3G/tPYepdQmOLXD07o
 31mNpEb3bvkn3/QkDZLgWUEFc2xiEhSxaTg2/Pp/ygvrAxMMa9v2+RfYnR2LkqV/Lc3Y1ZgckI7Fc
 CoTAWt+jcWOkVh2FE0RPSEDs51UCsbZ2bNq4pkk9QIpHiRB9zYs0Fw7+ha1GPkVRp7Q8j0Smmnnty
 I7jbXIgDri93yTFJkK0JooDpT9CAZ6TYcNlHq7SNlWX7+GQWLg6sNbBaFyOtns0+ChbC1aB5E7xVf
 zr61Qnd85H9WNNVn+kY9XgoFm9UO9Cfg0E2/40SABglmbcmxzadgkZL2o6JUDmJhExT0Ew1D9u9/t
 2BjWi2MMUPcgFP3jTE3t1WoYqJOwCmS5oP966eK0inAJR6k2FhQSEcPmeangU/flqnvFlWlglV4do
 hLZpHK0Ji9wv6WIPrPdHLLqRyODBEArzfAbgQz5Ws5vNft4cBBSIT2u0SnwGfA5OPa5hlyEf0lg+e
 J/l836s6nNaWTblbtebSMnxirYd4w6x03yv7wmQgg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhdv-00070a-FT; Thu, 12 Dec 2024 11:46:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:50 +0000
Message-Id: <20241212114620.549285-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 04/34] next-cube: move next_scsi_init() to next_pc_realize()
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

This reflects that the SCSI interface exists within the NeXT Peripheral
Controller (PC).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index f95ed4a170..9b3578cd4f 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -908,6 +908,9 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
                           "next.scr", 0x20000);
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
+
+    /* SCSI */
+    next_scsi_init(dev);
 }
 
 /*
@@ -1051,8 +1054,6 @@ static void next_cube_init(MachineState *machine)
 
     /* TODO: */
     /* Network */
-    /* SCSI */
-    next_scsi_init(pcdev);
 
     /* DMA */
     memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
-- 
2.39.5


