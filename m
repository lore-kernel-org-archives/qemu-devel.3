Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AC9CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXXB-00038k-ID; Mon, 25 May 2026 11:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRXX4-000373-Q1
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:48:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRXX2-0006d6-HQ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:47:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C8FF596946;
 Mon, 25 May 2026 17:47:53 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id w1qxnKlTNIvu; Mon, 25 May 2026 17:47:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7D39C596953; Mon, 25 May 2026 17:47:51 +0200 (CEST)
Message-ID: <add4cdf825fa6ad525f3e5012ef4162ded1d90c5.1779723483.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1779723483.git.balaton@eik.bme.hu>
References: <cover.1779723483.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 7/7] hw/xtensa/xtfpga: Fix leaking memory region
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 25 May 2026 17:47:51 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use memory_region_new_ram to avoid leaking memory region.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/xtensa/xtfpga.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 33a2d9485c..c826f6a308 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -161,9 +161,8 @@ static void xtfpga_net_init(MemoryRegion *address_space,
     memory_region_add_subregion(address_space, descriptors,
             sysbus_mmio_get_region(s, 1));
 
-    ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
-                           &error_fatal);
+    ram = memory_region_new_ram(OBJECT(s), "open_eth.ram", 16 * KiB,
+                                &error_fatal);
     memory_region_add_subregion(address_space, buffers, ram);
 }
 
-- 
2.41.3


