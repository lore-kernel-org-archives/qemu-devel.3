Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46556E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 12:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOcWz-0001SX-Te; Fri, 20 Dec 2024 07:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1tOcWx-0001Rh-AM; Fri, 20 Dec 2024 07:54:59 -0500
Received: from mail-gw02.astralinux.ru ([195.16.41.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1tOcWu-0006kC-3J; Fri, 20 Dec 2024 07:54:58 -0500
Received: from gca-msk-a-srv-ksmg02.astralinux.ru (localhost [127.0.0.1])
 by mail-gw02.astralinux.ru (Postfix) with ESMTP id DECE71F9B2;
 Fri, 20 Dec 2024 15:54:48 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru
 [10.177.185.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
 Fri, 20 Dec 2024 15:54:47 +0300 (MSK)
Received: from localhost.localdomain (unknown [10.198.51.228])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4YF6nc2gFDzkWSm;
 Fri, 20 Dec 2024 15:54:43 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Anastasia Belova <abelova@astralinux.ru>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: [PATCH v2] hw/arm_sysctl: fix extracting 31th bit of val
Date: Fri, 20 Dec 2024 15:54:27 +0300
Message-ID: <20241220125429.7552-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb,
 {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 189972 [Dec 20 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2024/12/20 10:24:00 #26911498
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=195.16.41.108; envelope-from=abelova@astralinux.ru;
 helo=mail-gw02.astralinux.ru
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

1 << 31 is casted to uint64_t while bitwise and with val.
So this value may become 0xffffffff80000000 but only
31th "start" bit is required.

Use the bitfield extract() API instead.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
v2: make extracting more clear
 hw/misc/arm_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 69e379fa10..c4e93da3cd 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -520,7 +520,7 @@ static void arm_sysctl_write(void *opaque, hwaddr offset,
          * as zero.
          */
         s->sys_cfgctrl = val & ~((3 << 18) | (1 << 31));
-        if (val & (1 << 31)) {
+        if (extract64(val, 31, 1)) {
             /* Start bit set -- actually do something */
             unsigned int dcc = extract32(s->sys_cfgctrl, 26, 4);
             unsigned int function = extract32(s->sys_cfgctrl, 20, 6);
-- 
2.47.0


