Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B77DE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLaQ-0005YM-A7; Sun, 22 Dec 2024 08:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZY-000542-Gt
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZW-0000bx-KN
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XB5Rvw+ccSqRmsKg4hyDOdasFsPgee45/SK39Wdy9z8=; b=wnhWuthGlka1NXoj3KQvPdI0HN
 4VdpkZH4MDuA/qHp2kJI8F9J0dGLycmA9+09r4tmpyHgg6133K9YVSMAZbmaff656T0TqfUi+h0JA
 n8uIZj0PBZ0YX5py3ePoeO0GsNu1MPK999YJdb9E0uY+9CY8YjtM3nXxNn7X8999N04Zu4dMRbsQ8
 S/pfAqwl96z4G/kMDNyq3sC6yoQc7UX/+rt09GIuYcASRL6KYjUqxVMdrp4vpIduSkBt47aKdefq6
 t2H9DPEGHv7CnbM2ZHyLw7uufMNsdWuxVyeqvaxMJJsYFCSQEoRopDkVjwPcnQCWillMxmbhZznEa
 BKJU8Us2jC7vEh6m0imNjcvkhRbtDqZrA2DL06HRHK7MPgK6o9vPs1T/493euF9wTNnm2nTbrV7Ux
 iJqsidS5WB66Na56amHNhZKvocXASBBWCFBAMVDNfnnxsyyFYoxrhiSUcqrvibIptrklSy1HkIt+z
 D2QsLjTMV33ce+UV67zSE6vmJ27WOpZVk3K1+ER/46tdojrJKrVG76I2Q1ubVXhDoBspuVLlTNO7I
 F5tIJe3qoInbQmT4VV4bO1aZFjQB6Ri3+LGSh7GM03w5shym8xWmTmQG8Lmukxr3ZmGt4i8CSRaja
 9Ya+sg2TSVSmhjX3Hhrxm3F0v/5P+1itvOYbfkasU=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLYs-0002L7-Op; Sun, 22 Dec 2024 13:00:03 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:43 +0000
Message-Id: <20241222130012.1013374-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 04/33] next-cube: move next_scsi_init() to next_pc_realize()
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
index 58b4762ecd..e023ca757c 100644
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
@@ -1050,8 +1053,6 @@ static void next_cube_init(MachineState *machine)
 
     /* TODO: */
     /* Network */
-    /* SCSI */
-    next_scsi_init(pcdev);
 
     /* DMA */
     memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
-- 
2.39.5


