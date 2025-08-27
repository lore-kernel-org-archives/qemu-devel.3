Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AC4CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHgu-0002j7-Ia; Wed, 27 Aug 2025 11:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgl-0002gu-0l; Wed, 27 Aug 2025 11:03:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgf-0004ol-Sd; Wed, 27 Aug 2025 11:03:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA5AB14C532;
 Wed, 27 Aug 2025 18:02:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DAD6326983A;
 Wed, 27 Aug 2025 18:03:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Stable-10.0.4 10/59] roms/Makefile: fix npcmNxx_bootrom build rules
Date: Wed, 27 Aug 2025 18:02:15 +0300
Message-ID: <20250827150323.2694101-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

Since commit 70ce076fa6dff60, the actual rom source dirs
are subdirs of vbootrom/ submodule, not in top-level of it.

Fixes: 70ce076fa6dff60 "roms: Update vbootrom to 1287b6e"
Fixes: 269b7effd90 ("pc-bios: Add NPCM8XX vBootrom")

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250727215511.807880-1-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 653a75a9d7f957c4ba9387d1a54bccfdce49cb9c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/roms/Makefile b/roms/Makefile
index beff58d9d5..6af68a922f 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -193,12 +193,12 @@ qboot:
 	cp qboot/build/bios.bin ../pc-bios/qboot.rom
 
 npcm7xx_bootrom:
-	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
-	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
+	$(MAKE) -C vbootrom/npcm7xx CROSS_COMPILE=$(arm_cross_prefix)
+	cp vbootrom/npcm7xx/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
 
 npcm8xx_bootrom:
-	$(MAKE) -C vbootrom CROSS_COMPILE=$(aarch64_cross_prefix)
-	cp vbootrom/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
+	$(MAKE) -C vbootrom/npcm8xx CROSS_COMPILE=$(aarch64_cross_prefix)
+	cp vbootrom/npcm8xx/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
 
 hppa-firmware:
 	$(MAKE) -C seabios-hppa parisc
-- 
2.47.2


