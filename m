Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AD1D5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kU2-0005xe-QK; Sat, 09 Nov 2024 07:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRi-0002nP-SB; Sat, 09 Nov 2024 07:20:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRf-0005Yb-3O; Sat, 09 Nov 2024 07:20:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BA357A165A;
 Sat,  9 Nov 2024 15:08:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7EF90167FE0;
 Sat,  9 Nov 2024 15:09:04 +0300 (MSK)
Received: (nullmailer pid 3296276 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jan Luebbe <jlu@pengutronix.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 48/58] hw/sd/sdcard: Fix calculation of size when using
 eMMC boot partitions
Date: Sat,  9 Nov 2024 15:08:49 +0300
Message-Id: <20241109120901.3295995-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The sd_bootpart_offset() function calculates the *runtime* offset which
changes as the guest switches between accessing the main user data area
and the boot partitions by writing to the EXT_CSD_PART_CONFIG_ACC_MASK
bits, so it shouldn't be used to calculate the main user data area size.

Instead, subtract the boot_part_size directly (twice, as there are two
identical boot partitions defined by the eMMC spec).

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Fixes: c8cb19876d3e ("hw/sd/sdcard: Support boot area in emmc image")
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit c078298301a8c72fe12da85d94372689196628bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e96181385f..a639ff674c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -834,7 +834,9 @@ static void sd_reset(DeviceState *dev)
         sect = 0;
     }
     size = sect << HWBLOCK_SHIFT;
-    size -= sd_bootpart_offset(sd);
+    if (sd_is_emmc(sd)) {
+        size -= sd->boot_part_size * 2;
+    }
 
     sect = sd_addr_to_wpnum(size) + 1;
 
-- 
2.39.5


