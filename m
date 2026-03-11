Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A0B1125893
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0POw-00019O-GQ; Wed, 11 Mar 2026 15:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POt-0000qX-S5; Wed, 11 Mar 2026 15:39:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POs-0000l3-0p; Wed, 11 Mar 2026 15:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257670; bh=0AjJCEY3OniQicr/5x6Rf/4txbaYcDKZPAUmt5ItGJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n0YEMJAJ0EfTJFCAIfa/Hj3c4LZ538akP7LVQItI9s81P08HiCXngRmvTZfFw1z0q
 rC4NOQo8q1+u8CRJkTXEkOgXtmlQzUiti8Edae4/Ef5zHlOqoHn14kepudDLRb10DL
 447iNIjSrUZRDA++4al12uCHdmHxUdgXYU1H1TWCo+nyn+WRCkpbFjWGAOENuH7SgB
 Thm1VP6/Zr8cwz2E6xrtB8M+CHsxII4m2NIXd6Nic5aC1uMwvMR2V48By7nNE9l15D
 g2l47V+g7d8QRhsFvZX15F885RWiQIksPlV4qC90YVtZSWSdrfP9FGhzaTbdUPeMIa
 9RLSBkdu+5Dbg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FD05192119;
 Wed, 11 Mar 2026 22:34:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7296B37C47E;
 Wed, 11 Mar 2026 22:35:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 49/53] hw/net/npcm_gmac: Catch accesses off the end of
 the register array
Date: Wed, 11 Mar 2026 22:34:42 +0300
Message-ID: <20260311193449.1096110-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
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
index 5e32cd3edf..176cd604d8 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -700,6 +700,13 @@ static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
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
@@ -724,6 +731,13 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
 
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


