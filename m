Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221E4D2E02C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEh-0004GC-DV; Wed, 23 Oct 2024 05:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEe-0003tw-CC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:56 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEc-0000ds-RM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NVM1a7JPqNMZo7+ti/aMMMUS2mvWk/Skn52FPAnUgng=; b=MM4EJiAJJyHTRf7pdjgeLpid7Y
 8Y9x0EMlWp6XOM0EW6WDv/zLkaxXOYBvFRAIQHGjLKLYY460xCcGi868cdKMvDnmp93xClYGpo1qv
 GAeM9E39u78BGzq9bRqMPht+2AQTFSWBvT2mJgybFrnXZB6o1j3xDiicuB5vfyyQgNFbJ4dZMTstj
 kj9G/ZbOW7hOTKsXOeIz6Qdn8eGKacm/QITcIEgIKjRF1TWAiRqX4Ym0aE1smZuaJd9DL5aAZGlj7
 wJ7sa/Nlvm6SghMnUWT//M+Z/CtatYMX+bC4e+UzRUdg7UIO7Z6DexwQ2w3sIjAFG9lLdhWqWbe2v
 xlDoCLdQKok/9QavhoPFIkWdSRAEv0qKXLONivNogv6PgmJLt0Pg2TlGmZmgZecbIzlRIgAhocgyd
 zP3W7DIk25OWxFeLrr9QJ3tVN+eHDl1wyHv3vrptLHZQTF9xqCWB4i8uAA/DiQm1cJsxfvf/AYL49
 dGbK/pD0BJs5o9V2rZunYo32DW6AZ5hglUvAY8RV6Ubs/dyjyJ06jjd4aIj0dH8qYHAjlnLWhFExf
 jgrnfd7nkvZzgXpY5SqQgqasH6VSzj9Kzc1NGTJ9EukN/1jWyRKHem7+eQhLnlj7Bt1isCbPOpYL/
 Yq1OkhcQUsI7JUVOFcd/GMeJ1/dnnpaswSViD8g/Y=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XE8-0008EL-Lm; Wed, 23 Oct 2024 10:00:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:44 +0100
Message-Id: <20241023085852.1061031-29-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 28/36] next-cube: move reset of next-rtc fields from next-pc
 to next-rtc
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
---
 hw/m68k/next-cube.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 6b574d39cf..24f59480c5 100644
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


