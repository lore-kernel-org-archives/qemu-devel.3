Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D296DC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNrU-0001oO-Vs; Thu, 16 Jan 2025 06:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anasonov@astralinux.ru>)
 id 1tYNrS-0001o5-4k; Thu, 16 Jan 2025 06:16:30 -0500
Received: from mail-gw01.astralinux.ru ([37.230.196.243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anasonov@astralinux.ru>)
 id 1tYNrP-0002S1-SW; Thu, 16 Jan 2025 06:16:29 -0500
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw01.astralinux.ru (Postfix) with ESMTP id 5338424A2B;
 Thu, 16 Jan 2025 14:16:17 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru
 [10.177.185.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 14:16:16 +0300 (MSK)
Received: from localhost.localdomain (unknown [10.177.119.11])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4YYgKW6NsKz1gywd;
 Thu, 16 Jan 2025 14:16:15 +0300 (MSK)
From: Artem Nasonov <anasonov@astralinux.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org,
	jsnow@redhat.com
Cc: sdl.qemu@linuxtesting.org,
	Artem Nasonov <anasonov@astralinux.ru>
Subject: [PATCH] hw/ide: replace assert with proper error handling
Date: Thu, 16 Jan 2025 14:16:00 +0300
Message-Id: <20250116111600.2570490-1-anasonov@astralinux.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/01/16 09:51:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: anasonov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 astralinux.ru:7.1.1; gitlab.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190368 [Jan 16 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2025/01/16 07:50:00 #27039546
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/01/16 09:52:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=37.230.196.243;
 envelope-from=anasonov@astralinux.ru; helo=mail-gw01.astralinux.ru
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

This assert was found during fuzzing and can be triggered with some qtest commands.
So instead of assert failure I suggest to handle this error and abort the command.
This patch is required at least to improve fuzzing process and do not spam with this assert.
RFC.

Found by Linux Verification Center (linuxtesting.org) with libFuzzer.

Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in ide_dma_cb()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2777
Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
---
 hw/ide/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index f9baba59e9..baca7121ec 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -931,7 +931,10 @@ static void ide_dma_cb(void *opaque, int ret)
     s->io_buffer_size = n * 512;
     prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
     /* prepare_buf() must succeed and respect the limit */
-    assert(prep_size >= 0 && prep_size <= n * 512);
+    if (prep_size < 0 || prep_size > n * 512) {
+        ide_dma_error(s);
+        return;
+    }
 
     /*
      * Now prep_size stores the number of bytes in the sglist, and
-- 
2.39.5


