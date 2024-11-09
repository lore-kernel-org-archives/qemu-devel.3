Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0640D5E366
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kLE-0004iF-PW; Sat, 09 Nov 2024 07:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kL7-0003wH-W5; Sat, 09 Nov 2024 07:13:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kL5-0004dA-Tn; Sat, 09 Nov 2024 07:13:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 72E5BA1614;
 Sat,  9 Nov 2024 15:07:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2EECE167FA2;
 Sat,  9 Nov 2024 15:08:04 +0300 (MSK)
Received: (nullmailer pid 3295388 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 44/57] hw/intc/riscv_aplic: Check and update pending
 when write sourcecfg
Date: Sat,  9 Nov 2024 15:07:46 +0300
Message-Id: <20241109120801.3295120-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The section 4.5.2 of the RISC-V AIA specification says that any write
to a sourcecfg register of an APLIC might (or might not) cause the
corresponding interrupt-pending bit to be set to one if the rectified
input value is high (= 1) under the new source mode.

If an interrupt is asserted before the driver configs its interrupt
type to APLIC, it's pending bit will not be set except a relevant
write to a setip or setipnum register. When we write the interrupt
type to sourcecfg register, if the APLIC device doesn't check
rectified input value and update the pending bit, this interrupt
might never becomes pending.

For APLIC.m, we can manully set pending by setip or setipnum
registers in driver. But for APLIC.w, the pending status totally
depends on the rectified input value, we can't control the pending
status via mmio registers. In this case, hw should check and update
pending status for us when writing sourcecfg registers.

Update QEMU emulation to handle "pre-existing" interrupts.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241004104649.13129-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 2ae6cca1d3389801ee72fc5e58c52573218f3514)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 32edd6d07b..4a262c82f0 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -159,31 +159,42 @@ static bool is_kvm_aia(bool msimode)
     return kvm_irqchip_in_kernel() && msimode;
 }
 
+static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
+                                          uint32_t irq)
+{
+    uint32_t sourcecfg, sm, raw_input, irq_inverted;
+
+    if (!irq || aplic->num_irqs <= irq) {
+        return false;
+    }
+
+    sourcecfg = aplic->sourcecfg[irq];
+    if (sourcecfg & APLIC_SOURCECFG_D) {
+        return false;
+    }
+
+    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
+    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+        return false;
+    }
+
+    raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
+    irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
+                    sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
+
+    return !!(raw_input ^ irq_inverted);
+}
+
 static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
                                             uint32_t word)
 {
-    uint32_t i, irq, sourcecfg, sm, raw_input, irq_inverted, ret = 0;
+    uint32_t i, irq, rectified_val, ret = 0;
 
     for (i = 0; i < 32; i++) {
         irq = word * 32 + i;
-        if (!irq || aplic->num_irqs <= irq) {
-            continue;
-        }
 
-        sourcecfg = aplic->sourcecfg[irq];
-        if (sourcecfg & APLIC_SOURCECFG_D) {
-            continue;
-        }
-
-        sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
-            continue;
-        }
-
-        raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
-        irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
-                        sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
-        ret |= (raw_input ^ irq_inverted) << i;
+        rectified_val = riscv_aplic_irq_rectified_val(aplic, irq);
+        ret |= rectified_val << i;
     }
 
     return ret;
@@ -702,6 +713,10 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
             (aplic->sourcecfg[irq] == 0)) {
             riscv_aplic_set_pending_raw(aplic, irq, false);
             riscv_aplic_set_enabled_raw(aplic, irq, false);
+        } else {
+            if (riscv_aplic_irq_rectified_val(aplic, irq)) {
+                riscv_aplic_set_pending_raw(aplic, irq, true);
+            }
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDR)) {
-- 
2.39.5


