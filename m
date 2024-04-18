Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AE1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVvv-0004aa-ST; Thu, 18 Apr 2024 13:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVvc-0004Kx-Sk; Thu, 18 Apr 2024 13:52:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVvb-0007i3-9u; Thu, 18 Apr 2024 13:52:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F75A5FD7A;
 Thu, 18 Apr 2024 20:50:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 666D1B9354;
 Thu, 18 Apr 2024 20:50:03 +0300 (MSK)
Received: (nullmailer pid 947881 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 113/116] hw/isa/vt82c686: Keep track of PIRQ/PINT pins
 separately
Date: Thu, 18 Apr 2024 20:49:43 +0300
Message-Id: <20240418174955.947730-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Move calculation of mask after the switch which sets the function
number for PIRQ/PINT pins to make sure the state of these pins are
kept track of separately and IRQ is raised if any of them is active.

Cc: qemu-stable@nongnu.org
Fixes: 7e01bd80c1 hw/isa/vt82c686: Bring back via_isa_set_irq()
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240410222543.0EA534E6005@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit f33274265a242df5d9fdb00915fe72fbb1b2a3c4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 9c2333a277..0334431219 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -613,7 +613,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     ViaISAState *s = VIA_ISA(pci_get_function_0(d));
     uint8_t irq = d->config[PCI_INTERRUPT_LINE], max_irq = 15;
     int f = PCI_FUNC(d->devfn);
-    uint16_t mask = BIT(f);
+    uint16_t mask;
 
     switch (f) {
     case 0: /* PIRQ/PINT inputs */
@@ -628,6 +628,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     }
 
     /* Keep track of the state of all sources */
+    mask = BIT(f);
     if (level) {
         s->irq_state[0] |= mask;
     } else {
-- 
2.39.2


