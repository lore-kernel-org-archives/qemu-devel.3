Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C008112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBL-0007xS-Nm; Wed, 11 Mar 2026 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8g-0003MY-V8; Wed, 11 Mar 2026 11:06:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8f-0004mr-7j; Wed, 11 Mar 2026 11:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241306; bh=R/u0rugd00vx2T4UY6BiXP1jI7CxGPC3DrYf5zPxN4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BMc/m82HeX9CiqhiNcpt4RwEQfSb2hJZ2Jdbel+yFkJ0Et5NV8t2i2jITBptmd6id
 w7tu0v5ivPNDVQCpElJ3aiAawGpCYqWoQbZOyaLWWGwoYeHApuUVQaUM6ipJuMfwXm
 ZesUUArn4vB1AgFW3Vyd/D+SrPSBGE3k8rJz8R37jwc8H1JTPTu5JZQmvfj5WzvHuu
 NAoPS4/s7MTimP9Ycq/QP8fdQr3cnlx5VuIW8H1KzIsKSfrIlkX1KHvw14anpR7klW
 rXJOCE1OXt9qEOlxXRzL4tb1t3PIEqtpfAk0QgampGL+55ZhMBC4eRc1Dl10KTVXI0
 PAvfw3FrPN/nQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E90C191E68;
 Wed, 11 Mar 2026 18:01:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C26B37C2BA;
 Wed, 11 Mar 2026 18:02:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 42/44] hw/net/npcm_gmac: Catch accesses off the end of
 the register array
Date: Wed, 11 Mar 2026 18:02:14 +0300
Message-ID: <20260311150221.1084186-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In the npcm_gmac device, we create the iomem MemoryRegion with
a size of 8KB, but NPCM_GMAC_NR_REGS is only 0x1060 / 4. This
means there's a range of offsets that the guest can access
that don't have gmac->regs[] entries. We weren't catching this,
so the guest could get us to index off the end of the regs array.

Catch and log these invalid accesses.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3316
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260306154016.2194091-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 550391c7134d295d73b2b0e7a1111a922b78c13c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index d4dba630ac..e9dd5e68ae 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -703,6 +703,13 @@ static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
     NPCMGMACState *gmac = opaque;
     uint32_t v = 0;
 
+    if (offset >= NPCM_GMAC_REG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid register offset: 0x%04" HWADDR_PRIx"\n",
+                      DEVICE(gmac)->canonical_path, offset);
+        return v;
+    }
+
     switch (offset) {
     /* Write only registers */
     case A_NPCM_DMA_XMT_POLL_DEMAND:
@@ -727,6 +734,13 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
 
     trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
 
+    if (offset >= NPCM_GMAC_REG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid register offset: 0x%04" HWADDR_PRIx"\n",
+                      DEVICE(gmac)->canonical_path, offset);
+        return;
+    }
+
     switch (offset) {
     /* Read only registers */
     case A_NPCM_GMAC_VERSION:
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index 6340ffe92c..0c21b25a82 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -24,7 +24,8 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 
-#define NPCM_GMAC_NR_REGS (0x1060 / sizeof(uint32_t))
+#define NPCM_GMAC_REG_SIZE 0x1060
+#define NPCM_GMAC_NR_REGS (NPCM_GMAC_REG_SIZE / sizeof(uint32_t))
 
 #define NPCM_GMAC_MAX_PHYS 32
 #define NPCM_GMAC_MAX_PHY_REGS 32
-- 
2.47.3


