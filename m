Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EDEE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfP-0007an-7w; Thu, 12 Dec 2024 06:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfL-0007KZ-Lt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfJ-0007HU-M9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=sVfDf6CuLWJ2vcyhpvGqEE+6Q8qB7OuD42kP/5BqUuM=; b=SkKb7x6do/Q4SQlQ/zTJlAhm95
 F/ZSUA53QxWnEl6w4K/E9l8x+dxgCUVFvZwTQzVDk9CNrVIyDavmW4Zb2YftdVxRh0dzs2g0T3oi+
 tSC9ZbUbsxGoLsZfeXojh4UQDwAAzBaObTi8NAdkS0rsZDMF3MffwMLD/c5Q8WOsXgtSB2HKkRhlI
 viJ+eBIC2JJ6kXjFLdet9vaKAISIo9O6VxecNKrLanDf0JJi4aucGTdSYSMeOgRWCYcTyklTTAy3+
 lO1/+7YlyCev8bKyoJKuhK9ey/jrTyNJcRJ5vrdMX0njfbClt9smDU3WPpsFG/67aZXGBlUUkdWS2
 qakT6029zT4G6edkpMLGQ87kaR9wTxdXuLHERWB7uXrkBt7cX6wsRdju0FtFxx42AJPmZirX1C4Mn
 P/PfrAToqP1gswwl6/j4ayVuQ7nRoo9uxIqf/9GtmKSjF3ZFQsM4KYM2/iYXZPIgms3suarSfgk72
 G/eamn5qcnfub74xAryexbuQ3VCa7NMYLFqnUQxaCylWi8jqyJVgCvnGkoVN5HAtF3qH6MW/ue4my
 wqxcc80tqmwga/g1oEUGCYKrQ6JysvQ5/B3XmKBFGa3w07QueYamIw+m6Vl+jIkWS57J33D5rfBSI
 xCLNtvrvpI8OaxuqOTxOaSy9tp18SRorRz1Drp2so=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhec-00070a-Pd; Thu, 12 Dec 2024 11:46:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:03 +0000
Message-Id: <20241212114620.549285-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 17/34] next-cube: convert next-pc device to use Resettable
 interface
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
Acked-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 5333fc7bef..4a11fe6b39 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1009,9 +1009,9 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void next_pc_reset(DeviceState *dev)
+static void next_pc_reset_hold(Object *obj, ResetType type)
 {
-    NeXTPC *s = NEXT_PC(dev);
+    NeXTPC *s = NEXT_PC(obj);
 
     /* Set internal registers to initial values */
     /*     0x0000XX00 << vital bits */
@@ -1141,12 +1141,13 @@ static const VMStateDescription next_pc_vmstate = {
 static void next_pc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "NeXT Peripheral Controller";
     dc->realize = next_pc_realize;
-    device_class_set_legacy_reset(dc, next_pc_reset);
     device_class_set_props(dc, next_pc_properties);
     dc->vmsd = &next_pc_vmstate;
+    rc->phases.hold = next_pc_reset_hold;
 }
 
 static const TypeInfo next_pc_info = {
-- 
2.39.5


