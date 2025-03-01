Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BA1C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 14:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toNx2-0001Mo-6N; Sat, 01 Mar 2025 09:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwM-00019n-5c
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwJ-000187-Vh
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 44FDB4E610A;
 Sat, 01 Mar 2025 15:35:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id IntMI6M68Kor; Sat,  1 Mar 2025 15:35:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 569254E6106; Sat, 01 Mar 2025 15:35:35 +0100 (CET)
Message-Id: <ff281851e6d824ecd01b8b5cd955328dae1515a0.1740839457.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740839457.git.balaton@eik.bme.hu>
References: <cover.1740839457.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/4] hw/nvram/eeprom_at24c: Remove memset after g_malloc0
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Date: Sat, 01 Mar 2025 15:35:35 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Calling memset to zero memory is not needed after g_malloc0 which
already clears memory. These used to be in separate functions but
after some patches the memset ended up after g_malloc0 and thus can be
dropped.

Fixes: 4f2c6448c3 (hw/nvram/eeprom_at24c: Make reset behavior more like hardware)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/nvram/eeprom_at24c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 9f606842eb..78c81bea77 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -190,7 +190,6 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
     }
 
     ee->mem = g_malloc0(ee->rsize);
-    memset(ee->mem, 0, ee->rsize);
 
     if (ee->init_rom) {
         memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
-- 
2.30.9


