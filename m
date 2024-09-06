Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB63E6FE31
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 16:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smcAA-0004dX-Sv; Fri, 06 Sep 2024 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1smcA8-0004bz-2o
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 12:50:20 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1smcA5-0006A3-Lr
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 12:50:19 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1smc9z-0004Em-6x; Fri, 06 Sep 2024 18:50:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jlu@pengutronix.de>)
 id 1smc9y-005zT0-Lk; Fri, 06 Sep 2024 18:50:10 +0200
Received: from jlu by ptz.office.stw.pengutronix.de with local (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1smc9y-000Xve-1t;
 Fri, 06 Sep 2024 18:50:10 +0200
From: Jan Luebbe <jlu@pengutronix.de>
To: qemu-devel@nongnu.org
Cc: Jan Luebbe <jlu@pengutronix.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PATCH] hw/sd/sdcard: Fix handling of disabled boot partitions
Date: Fri,  6 Sep 2024 18:48:34 +0200
Message-Id: <20240906164834.130257-1-jlu@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The enable bits in the EXT_CSD_PART_CONFIG ext_csd register do *not*
specify whether the boot partitions exist, but whether they are enabled
for booting. Existence of the boot partitions is specified by a
EXT_CSD_BOOT_MULT != 0.

Currently, in the case of boot-partition-size=1M and boot-config=0,
Linux detects boot partitions of 1M. But as sd_bootpart_offset always
returns 0, all reads/writes are mapped to the same offset in the backing
file.

Fix this bug by calculating the offset independent of which partition is
enabled for booting.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 hw/sd/sd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a140a32ccd46..26d6eebe898d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -774,19 +774,12 @@ static uint32_t sd_blk_len(SDState *sd)
  */
 static uint32_t sd_bootpart_offset(SDState *sd)
 {
-    bool partitions_enabled;
     unsigned partition_access;
 
     if (!sd->boot_part_size || !sd_is_emmc(sd)) {
         return 0;
     }
 
-    partitions_enabled = sd->ext_csd[EXT_CSD_PART_CONFIG]
-                                   & EXT_CSD_PART_CONFIG_EN_MASK;
-    if (!partitions_enabled) {
-        return 0;
-    }
-
     partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                                  & EXT_CSD_PART_CONFIG_ACC_MASK;
     switch (partition_access) {
-- 
2.39.2


