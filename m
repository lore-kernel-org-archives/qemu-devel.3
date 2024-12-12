Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8C4E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfw-0001pX-1n; Thu, 12 Dec 2024 06:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhft-0001cA-Pl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfs-0007Kz-8x
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0IEac+MD2XseUwlUfXn1cSvlMGCGK8NijvCEHeo0/TU=; b=RDidW958icdbOMFkFMPtyYnRMa
 wSHFJBz5wZEBpom2pZM1yzbpzDEzDlnl1w8NZ26aXM1HmdqBs9eZJ80wEBKd+p4btA2UmvIK663Tt
 0J1zXoNez5gLoV2ph4JJ/xnQA3q5agdIjfPxCAWxQrkT5MC5lBfb1elLIJ/HYRkjWdA64obHZPgQC
 5O+jwMogJQSTr//E0UMvKMmHfrbmer4eF6UUntISvoKLBzMkHXpO7kTVYNSpnxZj54+RrRztm/CyS
 v+iZV0tooVia1YYQTFqzArbXVBZcwBQWunAGzflJL50KJordbWt1waEVINsXPOuBHtprYeMI2LuxK
 6xxsfTNWLAwD/3s2WwNCQyXca0gCIDstMmxh0cAAGi0l6cGV9/1PKwZZCVN6Fio0XTUzBkn4L1xLn
 XV6HqLJK/yOFiNko1qMOea2R+oDS9rq0tNduzTkBNVYlAokUOdY3hL3i6W2bk1kftBoJ9wMGg60aE
 JAOozNnky3PvCDaFj8GBA5QSRfF7AEhLqjt7exIZwSNg34tB/CZxoOe3SxOKkKIqxMtmD6PAVNbFk
 8P/uY3n9lqNH79mHnrZLe8c5llI/E2mHSx9sXp+uKvTzvl8A7/b4/vaYWh91srF85z7gxFAEtPMAx
 NoWYzVUcmEBjTXpmwhV0AOxbdD+eK2qW73PoPO43M=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhf8-00070a-JK; Thu, 12 Dec 2024 11:47:26 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:12 +0000
Message-Id: <20241212114620.549285-27-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 26/34] next-cube: move reset of next-rtc fields from
 next-pc to next-rtc
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index c947af65e2..a7a8b3cbbf 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1018,6 +1018,16 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_rtc_reset_hold(Object *obj, ResetType type)
+{
+    NeXTRTC *rtc = NEXT_RTC(obj);
+
+    rtc->status = 0x90;
+
+    /* Load RTC RAM - TODO: provide possibility to load contents from file */
+    memcpy(rtc->ram, rtc_ram2, 32);
+}
+
 static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 3,
@@ -1037,9 +1047,11 @@ static const VMStateDescription next_rtc_vmstate = {
 static void next_rtc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "NeXT RTC";
     dc->vmsd = &next_rtc_vmstate;
+    rc->phases.hold = next_rtc_reset_hold;
 }
 
 static const TypeInfo next_rtc_info = {
@@ -1072,11 +1084,6 @@ static void next_pc_reset_hold(Object *obj, ResetType type)
     s->scr1 = 0x00011102;
     s->scr2 = 0x00ff0c80;
     s->old_scr2 = s->scr2;
-
-    s->rtc.status = 0x90;
-
-    /* Load RTC RAM - TODO: provide possibility to load contents from file */
-    memcpy(s->rtc.ram, rtc_ram2, 32);
 }
 
 static void next_pc_realize(DeviceState *dev, Error **errp)
-- 
2.39.5


