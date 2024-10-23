Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86521D2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDI-00082q-1l; Wed, 23 Oct 2024 04:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDF-00082M-N5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDE-0000KM-HI
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=vWjh/gwcLsyGVJPFskE13EAEEA5NiODuqjD9lHpFOSQ=; b=K0xhTouU/RtoLHrOv7fvhYv0/P
 5p1uAyKedYy5C8HEigemtYkedlzXut3N1MDMTNclpbZyV1f+WFiV+hEQnL1lkK1mlGzYbrzzpPJls
 vvzOiEgqBjAlg+BEWkMlpAj9ijjJZAExk/Y0TRNWLH5YuXRb1M0I94xPHFPT8ykqn+suxmB1Gej0y
 AYX9APbu8L1SH2PYOJ9C/Iv2iHVoTu1kW9i1y4w58Kw5Ma2b29abzD+HyhOQXjVLy0Alw+fsGweRi
 TZUeUlIJHTIAiH8Xv9T883UpF6ZCi6dHELLFWSccYSsEwM+1gTLZIIjrmdR3Px6h0x1iswlHThPNS
 67NdUNgGEcZSsEBdzhNLAvipBGnnBuEUb3OYd+fUDM49pt7wqYAvRHTkzkf9gLSgf8sq2+Ef0OJZd
 rSUenS0Deoo8TPzTimGXgCBYbKY8w70zaLqPxeM53Pt+02RlNjybjV3KCsCm8rHjciNgQku706lD+
 CliJsHmJzx51d4DWn9z4lpt+kfqMTfiXcCkmeg6FbRjB+qXgqsSeNH9WTcdYEoL8aHpORO75ib+Mg
 lSRzvm/5zT52Y1WBF3248/YbsUGWyaGpyd1LrKyZXWYceokKA/70+8MoAfVHifYxjs4HZOKIRHNnf
 mO4ICXbhFf695qQrqs3jnZ/01VAnV2EMUOz3xgJ1I=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCu-0008EL-Ci; Wed, 23 Oct 2024 09:59:12 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:22 +0100
Message-Id: <20241023085852.1061031-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/36] next-cube: move next_scsi_init() to next_pc_realize()
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
---
 hw/m68k/next-cube.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9e457fdf12..0c3f8780a1 100644
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


