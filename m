Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59521CFB454
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtHN-0002u0-3B; Mon, 07 Oct 2024 15:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtGK-0007Jq-MA; Mon, 07 Oct 2024 15:19:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtGJ-0004SK-0M; Mon, 07 Oct 2024 15:19:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 15AD39625B;
 Mon,  7 Oct 2024 22:16:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E4A7014F73B;
 Mon,  7 Oct 2024 22:16:56 +0300 (MSK)
Received: (nullmailer pid 2592792 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jan Luebbe <jlu@pengutronix.de>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 30/32] hw/sd/sdcard: Fix handling of disabled boot
 partitions
Date: Mon,  7 Oct 2024 22:16:47 +0300
Message-Id: <20241007191654.2592616-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jan Luebbe <jlu@pengutronix.de>

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

This bug is unlikely to affect many users with QEMU's current set of
boards, because only aspeed sets boot-partition-size, and it also
sets boot-config to 8. So to run into this a user would have to
manually mark the boot partition non-booting from within the guest.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Message-id: 20240906164834.130257-1-jlu@pengutronix.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added note to commit message about effects of bug]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 9601076b3b0bced7ed597d1470e3ff2f4e7177d6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a140a32ccd..26d6eebe89 100644
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
2.39.5


