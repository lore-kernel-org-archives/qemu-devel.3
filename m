Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A97BD5E362
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9id9-0001e1-Ib; Sat, 09 Nov 2024 05:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iXr-0001Ev-3d; Sat, 09 Nov 2024 05:18:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iXp-0008B8-E1; Sat, 09 Nov 2024 05:18:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 80117A140C;
 Sat,  9 Nov 2024 13:13:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2DA1C167EF7;
 Sat,  9 Nov 2024 13:14:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anup Patel <apatel@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 39/49] hw/intc/riscv_aplic: Fix in_clrip[x] read
 emulation
Date: Sat,  9 Nov 2024 13:14:30 +0300
Message-Id: <20241109101443.312701-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Anup Patel <apatel@ventanamicro.com>

The reads to in_clrip[x] registers return rectified input values of the
interrupt sources.

A rectified input value of an interrupt source is defined by the section
"4.5.2 Source configurations (sourcecfg[1]–sourcecfg[1023])" of the RISC-V
AIA specification as:
"rectified input value = (incoming wire value) XOR (source is inverted)"

Update the riscv_aplic_read_input_word() implementation to match the above.

Fixes: e8f79343cfc8 ("hw/intc: Add RISC-V AIA APLIC device emulation")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240306095722.463296-3-apatel@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 0678e9f29c2301d0a1afc8d01a78cdfa7ad2ddbd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index ab23399a8d..71978b9870 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -162,7 +162,7 @@ static bool is_kvm_aia(bool msimode)
 static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
                                             uint32_t word)
 {
-    uint32_t i, irq, ret = 0;
+    uint32_t i, irq, sourcecfg, sm, raw_input, irq_inverted, ret = 0;
 
     for (i = 0; i < 32; i++) {
         irq = word * 32 + i;
@@ -170,7 +170,20 @@ static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
             continue;
         }
 
-        ret |= ((aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0) << i;
+        sourcecfg = aplic->sourcecfg[irq];
+        if (sourcecfg & APLIC_SOURCECFG_D) {
+            continue;
+        }
+
+        sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
+        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+            continue;
+        }
+
+        raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
+        irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
+                        sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
+        ret |= (raw_input ^ irq_inverted) << i;
     }
 
     return ret;
-- 
2.39.5


