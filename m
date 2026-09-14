Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA7C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x66BJ-0002PI-Us; Mon, 14 Sep 2026 08:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x66BA-0002Ox-Ng; Mon, 14 Sep 2026 08:53:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x66Az-0008Up-Jv; Mon, 14 Sep 2026 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=YeJFgPuWf5lPadsoAjbY95FQTJuQKtxAU2lz+LLpgjA=; b=wEpIjc48pXAbFJi7N4RavRAW4k
 GXYKl2D1E+V6DHvu//TATICXzv7d5jNqZEZv0wzvDwo0wGQaYd1VtOcaRT5gbTFUMFPTaSf+z2XKB
 Mb8yF53n4oQpJLjcxl4rXyYNH/X3IkMOafhM8ee1CGJCR2jO+RIUJynsaiEbZojC7wyqAVA9Gc0Gd
 IMuQv1gxoVD1QXERHguTglM0GLvQ3aQJ6ftFf4M4f2nEOH+T/MTL3Cx2Oa79ZtJ1mcXl4X/zITGFW
 AW3f++Jb99zsj0OldwlDczzW1xRmhXtlxs7xFDWb2Ix8Cfm5CCO7bowrnr8nHIyE8vH5kF4Pkn2WC
 ErNXwFX+hiU1gFMNbH+VRS3xVs6IPN1evZ81iny6Y73gI9t7woRDpyj7sN6C1NUvTRmBdnYh+6Vlf
 Ysxl8dQqGXk06dqLyeO5jOgp8xkXWwKOsh5+TmleYlpw44gkG1QN6yD/uU2cYll6zshF9q9JcFUO0
 vVehCrFULi6oxkhEZ9+jQHukeTRYwT2p/sIwLJuYKwrnPN7QvWGXWops2NVzJEyaMmAs6CffV0Tfk
 Eygxlwh+3B8wiUto8Gqttq12AtyJmVfhsczwMeqf0aL/rKKpeUD9JfsBBgIwj8oe48dvgZ+K5mc9t
 pSNg/jq0RTwIKI45tNIfCH9rtOpsYOLkte6da+3uc=;
Received: from [217.155.175.48] (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x66AP-00Dvwi-6P; Mon, 14 Sep 2026 13:52:13 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Mon, 14 Sep 2026 13:52:17 +0100
Message-ID: <20260914125236.820155-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] mac_dbdma: ensure only implemented DBDMA registers are
 accessed
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Whilst the DBDMA memory region is 4K in size, only the bottom 16 registers are
implemented in the Power Macintosh DBDMA controller. If an attempt is made to
access any unimplemented registers then an out-of-bounds array access occurs.

Rework the switch() statements in dbdma_read() and dbdma_write() to handle each
individual register access, as well as providing a safe default for all other
unimplemented registers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/mac_dbdma.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index a55c9c99824..d00181b9781 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -715,22 +715,25 @@ static void dbdma_write(void *opaque, hwaddr addr,
         return;
     }
 
-    ch->regs[reg] = value;
-
     switch(reg) {
     case DBDMA_CONTROL:
+        ch->regs[DBDMA_CONTROL] = value;
         dbdma_control_write(ch);
         break;
     case DBDMA_CMDPTR_LO:
         /* 16-byte aligned */
-        ch->regs[DBDMA_CMDPTR_LO] &= ~0xf;
+        ch->regs[DBDMA_CMDPTR_LO] = value & ~0xf;
         dbdma_cmdptr_load(ch);
         break;
     case DBDMA_STATUS:
     case DBDMA_INTR_SEL:
     case DBDMA_BRANCH_SEL:
     case DBDMA_WAIT_SEL:
-        /* nothing to do */
+    case DBDMA_RES1:
+    case DBDMA_RES2:
+    case DBDMA_RES3:
+    case DBDMA_RES4:
+        ch->regs[reg] = value;
         break;
     case DBDMA_XFER_MODE:
     case DBDMA_CMDPTR_HI:
@@ -738,12 +741,11 @@ static void dbdma_write(void *opaque, hwaddr addr,
     case DBDMA_DATA2PTR_LO:
     case DBDMA_ADDRESS_HI:
     case DBDMA_BRANCH_ADDR_HI:
-    case DBDMA_RES1:
-    case DBDMA_RES2:
-    case DBDMA_RES3:
-    case DBDMA_RES4:
         /* unused */
         break;
+    default:
+        /* do nothing */
+        break;
     }
 }
 
@@ -756,8 +758,6 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
     DBDMA_channel *ch = &s->channels[channel];
     int reg = (addr - (channel << DBDMA_CHANNEL_SHIFT)) >> 2;
 
-    value = ch->regs[reg];
-
     switch(reg) {
     case DBDMA_CONTROL:
         value = ch->regs[DBDMA_STATUS];
@@ -767,7 +767,11 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
     case DBDMA_INTR_SEL:
     case DBDMA_BRANCH_SEL:
     case DBDMA_WAIT_SEL:
-        /* nothing to do */
+    case DBDMA_RES1:
+    case DBDMA_RES2:
+    case DBDMA_RES3:
+    case DBDMA_RES4:
+        value = ch->regs[reg];
         break;
     case DBDMA_XFER_MODE:
     case DBDMA_CMDPTR_HI:
@@ -778,11 +782,9 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
         /* unused */
         value = 0;
         break;
-    case DBDMA_RES1:
-    case DBDMA_RES2:
-    case DBDMA_RES3:
-    case DBDMA_RES4:
-        /* reserved */
+    default:
+        /* unimplemented */
+        value = 0;
         break;
     }
 
-- 
2.47.3


