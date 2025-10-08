Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9792ECCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6TEU-0000lY-Tm; Wed, 08 Oct 2025 08:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v6TEQ-0000lP-BG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:25:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v6TEG-00068Q-6R
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:25:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A2C4956F30C;
 Wed, 08 Oct 2025 14:25:04 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id yAy7HB7JqwRX; Wed,  8 Oct 2025 14:25:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9DA8956F301; Wed, 08 Oct 2025 14:25:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] i2c/smbus_eeprom: Add minimum write recovery time for DDR2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
Message-Id: <20251008122502.9DA8956F301@zero.eik.bme.hu>
Date: Wed, 08 Oct 2025 14:25:02 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This is needed for newer u-boot-sam460ex versions to pass the DRAM
setup.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/i2c/smbus_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 0a1088fbb0..26e211b31a 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -288,6 +288,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
     spd[33] = 8;    /* addr/cmd hold time */
     spd[34] = 20;   /* data input setup time */
     spd[35] = 8;    /* data input hold time */
+    spd[36] = (type == DDR2 ? 13 << 2 : 0); /* min. write recovery time */
 
     /* checksum */
     for (i = 0; i < 63; i++) {
-- 
2.41.3


