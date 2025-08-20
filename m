Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD9CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 19:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoorg-0007rh-Ca; Wed, 20 Aug 2025 15:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blast@llvm>) id 1uolZT-00025p-QI
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 12:21:55 -0400
Received: from 2001-b011-3808-3444-a66b-b6ff-fe3d-469a.dynamic-ip6.hinet.net
 ([2001:b011:3808:3444:a66b:b6ff:fe3d:469a] helo=llvm)
 by eggs.gnu.org with esmtp (Exim 4.90_1) (envelope-from <blast@llvm>)
 id 1uolZR-0006Fn-VV
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 12:21:55 -0400
Received: from blast (uid 1001) (envelope-from blast@llvm) id 2abde
 by llvm (DragonFly Mail Agent v0.13+ on llvm);
 Wed, 20 Aug 2025 12:16:41 -0400
From: ShengYi Hung <aokblast@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 ShengYi Hung <aokblast@FreeBSD.org>
Subject: [PATCH] ii6300esb: fix incorrect mask for interrupt type
Date: Wed, 20 Aug 2025 12:16:41 -0400
Message-ID: <20250820161641.25789-1-aokblast@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:b011:3808:3444:a66b:b6ff:fe3d:469a;
 envelope-from=blast@llvm; helo=llvm
X-Spam_score_int: 29
X-Spam_score: 2.9
X-Spam_bar: ++
X-Spam_report: (2.9 / 5.0 requ) BAYES_00=-1.9, FSL_HELO_NON_FQDN_1=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.029, HELO_NO_DOMAIN=0.001,
 KHOP_HELO_FCRDNS=0.4, RCVD_IN_PBL=3.335, RDNS_DYNAMIC=0.982, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 Aug 2025 15:52:52 -0400
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

According to Intel 6300ESB Controller Hub Datasheet 14.4.15, the interrupt type
mask should be 0x03 (0b11) instead of 0x11. In the original
implementation, when we want to disable all interrupt by setting the
value to 0x03, we will get 0x01 which will be incorrect when we reading
the value again. However, there is no problem since 0x1 is reserved and
unused.

Signed-off-by: ShengYi Hung <aokblast@FreeBSD.org>
Sponsored by:   The FreeBSD Foundation
---
 hw/watchdog/wdt_i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index bb8a2766b6..3aa01b8d68 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -55,7 +55,7 @@
 /* Config register bits */
 #define ESB_WDT_REBOOT  (0x01 << 5)   /* Enable reboot on timeout          */
 #define ESB_WDT_FREQ    (0x01 << 2)   /* Decrement frequency               */
-#define ESB_WDT_INTTYPE (0x11 << 0)   /* Interrupt type on timer1 timeout  */
+#define ESB_WDT_INTTYPE (0x03 << 0)   /* Interrupt type on timer1 timeout  */
 
 /* Reload register bits */
 #define ESB_WDT_RELOAD  (0x01 << 8)    /* prevent timeout                   */
-- 
2.50.1


