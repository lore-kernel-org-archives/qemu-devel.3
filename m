Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8BCD216A7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0i33-0004QM-1T; Tue, 15 Oct 2024 09:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t0i2w-0004P4-KU
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:57:11 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t0i2u-0007QQ-R5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:57:10 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1t0i2o-0006wE-48; Tue, 15 Oct 2024 15:57:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jlu@pengutronix.de>)
 id 1t0i2n-0022uc-M5; Tue, 15 Oct 2024 15:57:01 +0200
Received: from jlu by ptz.office.stw.pengutronix.de with local (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t0i2n-00HZp4-1x;
 Tue, 15 Oct 2024 15:57:01 +0200
From: Jan Luebbe <jlu@pengutronix.de>
To: qemu-devel@nongnu.org
Cc: Jan Luebbe <jlu@pengutronix.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
Date: Tue, 15 Oct 2024 15:56:49 +0200
Message-Id: <20241015135649.4189256-1-jlu@pengutronix.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=jlu@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For testing eMMC-specific functionality (such as handling boot
partitions), it would be very useful to attach them to generic VMs such
as x86_64 via the sdhci-pci device:
 ...
 -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
 -device sdhci-pci \
 -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
 ...

While most eMMCs are soldered to boards, they can also be connected to
SD controllers with just a passive adapter, such as:
 https://docs.radxa.com/en/accessories/emmc-to-usd
 https://github.com/voltlog/emmc-wfbga153-microsd

The only change necessary to make the options above work is to avoid
disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
kernel already supports this just fine.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 hw/sd/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a5d2d929a8af..2d3467c3d956 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2865,8 +2865,6 @@ static void emmc_class_init(ObjectClass *klass, void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-    /* Reason: Soldered on board */
-    dc->user_creatable = false;
 
     sc->proto = &sd_proto_emmc;
 
-- 
2.39.5


