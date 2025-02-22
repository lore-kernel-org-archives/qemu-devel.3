Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BA0C021B2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 12:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlocy-0005dt-Vm; Sat, 22 Feb 2025 07:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tlocv-0005dK-FP; Sat, 22 Feb 2025 07:29:01 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tlocs-0006bT-0b; Sat, 22 Feb 2025 07:29:00 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 91DE54E6036;
 Sat, 22 Feb 2025 13:28:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hMDmdZj47xeO; Sat, 22 Feb 2025 13:28:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D8B84E603D; Sat, 22 Feb 2025 13:28:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/misc/macio: Improve trace logs
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jd Lyons <lyons_dj@yahoo.com>
Message-Id: <20250222122850.9D8B84E603D@zero.eik.bme.hu>
Date: Sat, 22 Feb 2025 13:28:50 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Add macio_gpio_read trace event and use that in macio_gpio_read()
instead of macio_gpio_write. Also change log message to match
macio_timer_{read,write}.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/misc/macio/gpio.c       | 2 +-
 hw/misc/macio/trace-events | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 7cad62819a..4364afc84a 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -135,7 +135,7 @@ static uint64_t macio_gpio_read(void *opaque, hwaddr addr, unsigned size)
         }
     }
 
-    trace_macio_gpio_write(addr, val);
+    trace_macio_gpio_read(addr, val);
     return val;
 }
 
diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
index ad4b9d1c08..055a407aeb 100644
--- a/hw/misc/macio/trace-events
+++ b/hw/misc/macio/trace-events
@@ -18,7 +18,8 @@ macio_timer_read(uint64_t addr, unsigned len, uint32_t val) "read addr 0x%"PRIx6
 macio_set_gpio(int gpio, bool state) "setting GPIO %d to %d"
 macio_gpio_irq_assert(int gpio) "asserting GPIO %d"
 macio_gpio_irq_deassert(int gpio) "deasserting GPIO %d"
-macio_gpio_write(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64" value: 0x%"PRIx64
+macio_gpio_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
+macio_gpio_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
 
 # pmu.c
 pmu_adb_poll(int olen) "ADB autopoll, olen=%d"
-- 
2.30.9


