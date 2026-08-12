Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01961C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAPj-0006qK-1Y; Wed, 12 Aug 2026 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAP2-0005Mj-Ox; Wed, 12 Aug 2026 10:58:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAP0-0000zq-Q5; Wed, 12 Aug 2026 10:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=OSzWGsOR1abOhW645vogr5qkbRsdgNgE4GhouxF/q0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hWFMKuW3/wrz4wRS4L3mJrUAaXVlfOTnGiPivTP3IUCUrjSQzIT7TEqg6JXZc33fO
 d/2GsMCIarTgm7EG7DBrZYDH7Jn/6/cC9h0Fhot9PjFZY9XDVevkLhqBkF+H3I3gZh
 EDGkNWw5oZ9mdk7F58wX58B9RM5AHNWnoJ+ALpTigKrvC3Xlht2+0OynytNosdfcK5
 dd4STRTUisnV4MIQLYpgszfOEVpXOlTQsv2fI/dzlz+MgEjfsnNkte1RdFRmOdt78w
 sRGTq0TgJRKBW7S4G9v/xNvIYCLKCXYcdAPMHk/i5xHOvjVpiMKHssICvey6TWuoxu
 9ixJoTuy06MaQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C2F5F1CA64D;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 29082409D8F;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 887B92F9F5; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 073/120] hw/sd/sdhci: Extract uSDHC-specific quirk
Date: Wed, 12 Aug 2026 17:48:56 +0300
Message-ID: <20260812144955.649205-73-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

In Linux, the ESDHC_MIX_CTRL quirk is guarded by esdhc_is_usdhc() while
the eSDHC code path uses the standard SDHC interface. Extract the quirk
into a new `usdhc_write()` function.

Fixes file system corruption on emulated i.MX53 where Linux'
esdhc_is_usdhc() returns false. The same likely happens on e500 and
imx25-pdk machines.

Cc: qemu-stable@nongnu.org
Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260720201133.24796-3-shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 11ed6b92130a3b075cd6528e991c78538685d56a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c86dfa281f4..e58a6103970 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_write(opaque, offset, value, size);
         break;
 
-    case ESDHC_MIX_CTRL:
-        /*
-         * So, when SD/MMC stack in Linux tries to write to "Transfer
-         * Mode Register", ESDHC i.MX quirk code will translate it
-         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
-         * order to get where we started
-         *
-         * Note that Auto CMD23 Enable bit is located in a wrong place
-         * on i.MX, but since it is not used by QEMU we do not care.
-         *
-         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
-         * here because it will result in a call to
-         * sdhci_send_command(s) which we don't want.
-         *
-         */
-        s->trnmod = value & UINT16_MAX;
-        break;
-    case SDHC_TRNMOD:
-        /*
-         * Similar to above, but this time a write to "Command
-         * Register" will be translated into a 4-byte write to
-         * "Transfer Mode register" where lower 16-bit of value would
-         * be set to zero. So what we do is fill those bits with
-         * cached value from s->trnmod and let the SDHCI
-         * infrastructure handle the rest
-         */
-        sdhci_write(opaque, offset, val | s->trnmod, size);
-        break;
     case SDHC_BLKSIZE:
         /*
          * ESDHCI does not implement "Host SDMA Buffer Boundary", and
@@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
+static void
+usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    SDHCIState *s = SYSBUS_SDHCI(opaque);
+    uint32_t value = (uint32_t)val;
+
+    switch (offset) {
+    case ESDHC_MIX_CTRL:
+        /*
+         * So, when SD/MMC stack in Linux tries to write to "Transfer
+         * Mode Register", uSDHC i.MX quirk code will translate it
+         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
+         * order to get where we started.
+         *
+         * Note that Auto CMD23 Enable bit is located in a wrong place
+         * on i.MX, but since it is not used by QEMU we do not care.
+         *
+         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
+         * here because it will result in a call to
+         * sdhci_send_command(s) which we don't want.
+         *
+         */
+        s->trnmod = value & UINT16_MAX;
+        break;
+
+    case SDHC_TRNMOD:
+        /*
+         * Similar to above, but this time a write to "Command
+         * Register" will be translated into a 4-byte write to
+         * "Transfer Mode register" where lower 16-bit of value would
+         * be set to zero. So what we do is fill those bits with
+         * cached value from s->trnmod and let the SDHCI
+         * infrastructure handle the rest
+         */
+        sdhci_write(opaque, offset, val | s->trnmod, size);
+        break;
+
+    default:
+        esdhc_write(opaque, offset, val, size);
+        break;
+    }
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = esdhc_read,
-    .write = esdhc_write,
+    .write = usdhc_write,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
-- 
2.47.3


