Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC29D2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XD8-0007sc-M3; Wed, 23 Oct 2024 04:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD6-0007pM-Sw
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD5-0000Jz-JL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9m9pzuk+kU/pCkEvHTiuX7N97trMmOECKRPZTVqE0YU=; b=KA8aKAENO0UyPlXF6H/UqDu62u
 Nd5GbqD/KoQA0IPd4EkzgZ5hJuoQYzVEo37bsgiEWcBZF35k2y2n2J2zP1FZCfpRhe2Ynf0RUHkfP
 8I29vcsJFGVf3ahc3DcemSXLFzQG2qidJl4Ib0yovAClALrh1vucE/yktPt98Y0kb0mSDexov64eH
 JrpM0kl2ojcYywIo/+aDCyCy0W1dmg+mxpsFAkZmiQ5PmvlevvoT/Hr2Yzvo7kD+rmRyOEmfAMjdT
 ABu00U3mXNQCphAUYfQRaoNALO2uYaDoe+bJ7WWu+ru6b12KffzMx531gZTNDS6OCi02t1tzT2yzs
 wjeD7w1ZDOSUNAcDyj7193HLYHdGUW2E3zsolEz7kownc7zIgZbCDUtcXCqG37oX6Zocsz3oq4Ioe
 g7Wts6Ga6lDr41woDMTLcKCqeu9eibKh1JXMfy/EJVTYmnCtZHVnmP/JNOPIpTclQzG/9rfFdm7Lj
 yOJFqERRYKZW6Cv6CxPqBbayIZixDQHkZQFrR5LaZxPe1ul0vK0Hmgw4vs5KXdyGAnsq1gYZ3lhgf
 VyocaT2BdepjgaWCt0Y2zhxuUgUsrhnVQu6ZersETNNnAsKhlAJqhKkiV6OK9TJo2sIBS1mIYiLRI
 cAd8q5MptwZ6mLvcYSrAi2x9BR9qnvE55VdDmlXtA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCl-0008EL-CV; Wed, 23 Oct 2024 09:59:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:20 +0100
Message-Id: <20241023085852.1061031-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 04/36] next-cube: remove cpu parameter from next_scsi_init()
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

The parameter is not used.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e1d94c1ce0..6bdd91c9c6 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -824,7 +824,7 @@ static void nextscsi_write(void *opaque, uint8_t *buf, int size)
     nextdma_write(opaque, buf, size, NEXTDMA_SCSI);
 }
 
-static void next_scsi_init(DeviceState *pcdev, M68kCPU *cpu)
+static void next_scsi_init(DeviceState *pcdev)
 {
     struct NeXTPC *next_pc = NEXT_PC(pcdev);
     DeviceState *dev;
@@ -1046,7 +1046,7 @@ static void next_cube_init(MachineState *machine)
     /* TODO: */
     /* Network */
     /* SCSI */
-    next_scsi_init(pcdev, cpu);
+    next_scsi_init(pcdev);
 
     /* DMA */
     memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
-- 
2.39.5


