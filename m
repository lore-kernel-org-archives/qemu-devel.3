Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C8BC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lcv-0002iz-86; Wed, 16 Sep 2026 05:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcs-0002a6-MU; Wed, 16 Sep 2026 05:08:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcq-0007NE-UX; Wed, 16 Sep 2026 05:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549560; bh=6S37LGv4xZrnPOvo7jIWNJFbDlnTyubGmAE+MGmoafY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RqsemVza7UjhujbN45KCAS4A8RSgklX37m6QMXwX3QhuP3zX3UsLIStZBdYItix7o
 eubBONHROM6MjDxVYfop/f0DpgWDzFHJODhaq2X8qb2q15dtVHs1O6dxrcNigQVJcK
 pj/6NyossLPydX1F8yH7n4sBx2xYKOYv5fnydUVvrz/xLFi2uPvj8NOLG/dPYIb/Bb
 iTm0/2crKVNLu65+i3cSbiHSvo4OcQgFoWJ4RFenhs9lsw/dL9mVbqF6YGv6nJiFJO
 NL21YwvO0j9bEQxs58c12IyrggLony/GGWPyg7abOKG+bxbDvhHq5paq7lt9tlS7Mn
 hpF78uLn2OMzQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C87F91D56CC;
 Wed, 16 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74330429E16;
 Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6D1915A787; Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 23/57] vapic: confine the VAPIC region to
 0xc0000..0xe0000
Date: Wed, 16 Sep 2026 12:03:47 +0300
Message-ID: <20260916090516.677749-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

The VAPIC region is mapped as writable RAM, at very high priority,
above existing memory.  If the guest is allowed to map it everywhere,
it can overlap PCI BARs or even SMRAM.  Ensure that the whole
region first in the 128K of low memory that are reserved to
option ROMs.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4206
Reported-by: Artem Dinaburg <https://gitlab.com/artem35>
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d61c8a6fb7388486353aa267ba0d75b098f16662)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 1acb9f91b2a..a61ab19a676 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -33,6 +33,10 @@
 #define ROM_BLOCK_SIZE          512
 #define ROM_BLOCK_MASK          (~(ROM_BLOCK_SIZE - 1))
 
+/* Option ROM window on PC/Q35 machines; the vapic ROM must live in here. */
+#define OPTION_ROM_START        0xc0000
+#define OPTION_ROM_END          0xe0000
+
 typedef enum VAPICMode {
     VAPIC_INACTIVE = 0,
     VAPIC_ACTIVE   = 1,
@@ -590,6 +594,14 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     size_t rom_size;
     uint8_t *ram;
 
+    /*
+     * The VAPIC region should be mapped in place, refuse mapping it
+     * outside of the option ROM window.
+     */
+    if (rom_paddr < OPTION_ROM_START || rom_paddr >= OPTION_ROM_END) {
+        return -1;
+    }
+
     if (s->rom_mapped_writable) {
         memory_region_del_subregion(mr, &s->rom);
         object_unparent(OBJECT(&s->rom));
@@ -604,9 +616,10 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     }
     ram = memory_region_get_ram_ptr(section.mr);
     rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
-    if (rom_size == 0) {
+    if (rom_size == 0 || rom_size > OPTION_ROM_END - rom_paddr) {
         return -1;
     }
+
     s->rom_size = rom_size;
 
     /* We need to round to avoid creating subpages
@@ -614,6 +627,7 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     rom_size += rom_paddr & ~TARGET_PAGE_MASK;
     rom_paddr &= TARGET_PAGE_MASK;
     rom_size = TARGET_PAGE_ALIGN(rom_size);
+    assert(rom_paddr >= OPTION_ROM_START && rom_paddr + rom_size <= OPTION_ROM_END);
 
     memory_region_init_alias(&s->rom, OBJECT(s), "kvmvapic-rom", section.mr,
                              rom_paddr, rom_size);
-- 
2.47.3


