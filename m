Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CADBD2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEB-00022j-Gq; Wed, 23 Oct 2024 05:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XE3-0001rw-GB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XE2-0000UE-40
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=AIl9dcgBjs/BNzbTjDq9bdKlGEB3p1fydOhN1x9h4+4=; b=bqYUwH3wr3nfmTLttUERPnlgYi
 x3j4hA5C58b3t5qyCbvVKx9GSE+0+KIroEJfz+JuDYCZYv7ilwmA70RPE+vYeQ9bCKwfH6qVl/kJd
 CtCUHZkHBsGxiucMe/PXfzpEdICenHEg/u8QVtt2Sn/gju2PnHwfgozpn6B77dSBwT631MwPgEvYG
 yPSk42cIsHTJXQokAEFdMb07iBKz4QyJo6mGFe4V9Awp1HTKqrx8Yn9HLQrAP9tWU0L4IY2VpNEqp
 0w7Muq2YwUv8s1KYdo5+ikERBs43Vw1S2TQFTgqF6V1exDBXP4Np0LOUCovcRui43F0/AMsL0vRJ7
 JimSni+KQozGLvpcUa/L5X6DdUmmKDW9IrsMgv5kgprfMx2u4hmqm4qP7nCvK3ukysKUMGqDCMG4P
 kXgw9dTWy4L1iTBFaX7wZNN+lKjT3jdVqp8S3lMcdZ3zTRQB+BDFow9dyDi0bffbj+9cyAxFYHO8v
 AVIyevWIF2hJdUdcGdZ94/c1G7sS5X74lx2MZ/5PQTVuyQuirDemM5NbKl8UAPqkfE77gbSJy16xr
 Gm5/MIMEWSncU+TROXcLBbujYPD/4VXz5rb9vG/msu+7TPiGIXEM2LPTusETFLrKkuU+m1vDkxLLV
 at8SPGiDHjyeTBKkc6Fv6Scquowxz1SIjwehxgDH8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDX-0008EL-QS; Wed, 23 Oct 2024 09:59:51 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:35 +0100
Message-Id: <20241023085852.1061031-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 19/36] next-cube: convert next-pc device to use Resettable
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
---
 hw/m68k/next-cube.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9829f49387..c44a1c6f0c 100644
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


