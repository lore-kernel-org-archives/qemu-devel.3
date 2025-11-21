Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7980CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdBb-0000wj-Kr; Fri, 21 Nov 2025 21:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd1f-00011x-US; Fri, 21 Nov 2025 21:06:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd1C-0002JY-T7; Fri, 21 Nov 2025 21:06:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 39BB916C6E0;
 Fri, 21 Nov 2025 16:51:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 92F64321957;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jialong Yang <z_bajeer@yeah.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 08/76] aplic: fix mask for smsiaddrcfgh
Date: Fri, 21 Nov 2025 16:50:46 +0300
Message-ID: <20251121135201.1114964-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jialong Yang <z_bajeer@yeah.net>

 4.5.4. Supervisor MSI address configuration (smsiaddrcfg and
   smsiaddrcfgh)
smsiaddrcfgh:
        bits 22:20 LHXS(WARL)
        bits 11:0  High Base PPN(WARL)

Signed-off-by: Jialong Yang <z_bajeer@yeah.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <44f3e0d1.161.199d0c338b0.Coremail.z_bajeer@yeah.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 5e3e066e4ac894aff3e8dd3a072bca9c1986b2ff)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..6dccca73af 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -96,7 +96,7 @@
     (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
      APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
 
-#define APLIC_xMSICFGADDRH_VALID_MASK   \
+#define APLIC_MMSICFGADDRH_VALID_MASK   \
     (APLIC_xMSICFGADDRH_L | \
      (APLIC_xMSICFGADDRH_HHXS_MASK << APLIC_xMSICFGADDRH_HHXS_SHIFT) | \
      (APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
@@ -104,6 +104,10 @@
      (APLIC_xMSICFGADDRH_LHXW_MASK << APLIC_xMSICFGADDRH_LHXW_SHIFT) | \
      APLIC_xMSICFGADDRH_BAPPN_MASK)
 
+#define APLIC_SMSICFGADDRH_VALID_MASK   \
+    ((APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
+     APLIC_xMSICFGADDRH_BAPPN_MASK)
+
 #define APLIC_SETIP_BASE               0x1c00
 #define APLIC_SETIPNUM                 0x1cdc
 
@@ -184,7 +188,7 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
         addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
         aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
-                                 APLIC_xMSICFGADDRH_VALID_MASK;
+                                 APLIC_MMSICFGADDRH_VALID_MASK;
     }
 #endif
 }
@@ -409,13 +413,8 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
         msicfgaddr = aplic->kvm_msicfgaddr;
         msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
     } else {
-        if (aplic->mmode) {
-            msicfgaddr = aplic_m->mmsicfgaddr;
-            msicfgaddrH = aplic_m->mmsicfgaddrH;
-        } else {
-            msicfgaddr = aplic_m->smsicfgaddr;
-            msicfgaddrH = aplic_m->smsicfgaddrH;
-        }
+        msicfgaddr = aplic_m->mmsicfgaddr;
+        msicfgaddrH = aplic_m->mmsicfgaddrH;
     }
 
     lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
@@ -427,6 +426,14 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     hhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
             APLIC_xMSICFGADDRH_HHXW_MASK;
 
+    if (!aplic->kvm_splitmode && !aplic->mmode) {
+        msicfgaddrH = aplic_m->smsicfgaddrH;
+        msicfgaddr = aplic_m->smsicfgaddr;
+
+        lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
+            APLIC_xMSICFGADDRH_LHXS_MASK;
+    }
+
     group_idx = hart_idx >> lhxw;
 
     addr = msicfgaddr;
@@ -771,7 +778,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDRH)) {
         if (!(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->mmsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->mmsicfgaddrH = value & APLIC_MMSICFGADDRH_VALID_MASK;
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_SMSICFGADDR)) {
@@ -792,7 +799,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
                (addr == APLIC_SMSICFGADDRH)) {
         if (aplic->num_children &&
             !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->smsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->smsicfgaddrH = value & APLIC_SMSICFGADDRH_VALID_MASK;
         }
     } else if ((APLIC_SETIP_BASE <= addr) &&
             (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
-- 
2.47.3


