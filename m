Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F24C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kKm-0006mj-9R; Wed, 16 Sep 2026 03:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kKg-0006OQ-6d; Wed, 16 Sep 2026 03:45:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kKd-0005Fe-Lo; Wed, 16 Sep 2026 03:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544614; bh=kMhCLQcBupnBgh6uJLc7Xa3JdBGKO67+7tOWDOI6asE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=blHW6RX8fgYJwhF2yJen1VCU8HY0UlvV7wXhKI2sIYEP/BfU9s5bw149x5vPedWY+
 nEDx72j+KaHMsNVry6cPKT52io8pGcDjy15LAbTXHPc6aV3dpUVCKJKWHmQQ442Q2o
 sgDrPl53+GQFTi5Lin0uAul6qDs+qJfJOq+CBrXlgr3JGtZpMF563Ns01TsyYhQ9uR
 40J8uaGn7VSpZL/Oy3OpRVH+ELn04dVJsXLnPW4gqHHQr0k1MGuG7dz++DrBN7UbGa
 Rg/sjtfVd+tU/ue/kpDGOhxYZTuZj8FLiaqYkMji86cIKIz8weeOxC4h0WxVRctVEV
 fhBrqjAIPHDxQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C40F71D55A3;
 Wed, 16 Sep 2026 10:43:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 538F2429B4A;
 Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4E6335A6EB; Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 21/49] vapic: confine the VAPIC region to
 0xc0000..0xe0000
Date: Wed, 16 Sep 2026 10:42:39 +0300
Message-ID: <20260916074346.671467-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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
index 14de9b7a820..2069a4b962a 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -30,6 +30,10 @@
 #define ROM_BLOCK_SIZE          512
 #define ROM_BLOCK_MASK          (~(ROM_BLOCK_SIZE - 1))
 
+/* Option ROM window on PC/Q35 machines; the vapic ROM must live in here. */
+#define OPTION_ROM_START        0xc0000
+#define OPTION_ROM_END          0xe0000
+
 typedef enum VAPICMode {
     VAPIC_INACTIVE = 0,
     VAPIC_ACTIVE   = 1,
@@ -586,6 +590,14 @@ static int vapic_map_rom_writable(VAPICROMState *s)
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
@@ -600,9 +612,10 @@ static int vapic_map_rom_writable(VAPICROMState *s)
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
@@ -610,6 +623,7 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     rom_size += rom_paddr & ~TARGET_PAGE_MASK;
     rom_paddr &= TARGET_PAGE_MASK;
     rom_size = TARGET_PAGE_ALIGN(rom_size);
+    assert(rom_paddr >= OPTION_ROM_START && rom_paddr + rom_size <= OPTION_ROM_END);
 
     memory_region_init_alias(&s->rom, OBJECT(s), "kvmvapic-rom", section.mr,
                              rom_paddr, rom_size);
-- 
2.47.3


