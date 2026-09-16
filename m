Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE496C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n2b-0006IR-OM; Wed, 16 Sep 2026 06:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n1m-0005VQ-0r; Wed, 16 Sep 2026 06:38:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n1f-0001uI-6o; Wed, 16 Sep 2026 06:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554956; bh=trgaEh0+rftKXzvocmulAxOTaOYdHrK15S3lCEHVrSU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QXEJ6DN5nfDpRDMG7oQhRemm7Z4S3XC5GxpgK8ZRoc1949Ur6Ho0BQd0sB++kcrhx
 W2HrqjxCiRXx7ZxwQSRV1MbTEC6tetH58fLf7ElL5z53//bCIL+Ne3lwqpjwpnzo6c
 Gzhr412VMxIoY7gRZpoqmCYaEcuOKBgyRttaW2iGPuBJtOfzozHvySZ40sgimnY30g
 vjo74nUXnlDf7v1WqgRjvzf70/BGNL/MujWThAbkIpryLT9eOn71zxno00T4ei1xq2
 JfNT+g2CvA6cauKHLE5zT52gH7SdNkHc70ZmEphcCNOcwR3h3yAMR71rkbTDtw1ZdW
 Ffef2BgpgWAHQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E09A21D5809;
 Wed, 16 Sep 2026 13:35:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AA8EB429F67;
 Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A211C5A80B; Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 21/56] vapic: confine the VAPIC region to
 0xc0000..0xe0000
Date: Wed, 16 Sep 2026 13:35:39 +0300
Message-ID: <20260916103622.684817-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
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
index 8dd9188d96f..9adce172621 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -34,6 +34,10 @@
 #define ROM_BLOCK_SIZE          512
 #define ROM_BLOCK_MASK          (~(ROM_BLOCK_SIZE - 1))
 
+/* Option ROM window on PC/Q35 machines; the vapic ROM must live in here. */
+#define OPTION_ROM_START        0xc0000
+#define OPTION_ROM_END          0xe0000
+
 typedef enum VAPICMode {
     VAPIC_INACTIVE = 0,
     VAPIC_ACTIVE   = 1,
@@ -592,6 +596,14 @@ static int vapic_map_rom_writable(VAPICROMState *s)
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
@@ -606,9 +618,10 @@ static int vapic_map_rom_writable(VAPICROMState *s)
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
@@ -616,6 +629,7 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     rom_size += rom_paddr & ~TARGET_PAGE_MASK;
     rom_paddr &= TARGET_PAGE_MASK;
     rom_size = TARGET_PAGE_ALIGN(rom_size);
+    assert(rom_paddr >= OPTION_ROM_START && rom_paddr + rom_size <= OPTION_ROM_END);
 
     memory_region_init_alias(&s->rom, OBJECT(s), "kvmvapic-rom", section.mr,
                              rom_paddr, rom_size);
-- 
2.47.3


