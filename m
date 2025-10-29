Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F02ECCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0RQ-0007gn-A2; Wed, 29 Oct 2025 03:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vE0RL-0007eu-In; Wed, 29 Oct 2025 03:17:51 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vE0RI-0005w4-1n; Wed, 29 Oct 2025 03:17:51 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id CB1B51A0004;
 Wed, 29 Oct 2025 07:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com CB1B51A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1761722260; bh=dF/c3yYAPjfNe1SB3tUNXCQLPVaC/iWuGkW+IviFGzg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=g2NVXCYh9tFXDyKGxfbgU6CPyk/6LWFWwvTe7jWx4TacbOp17Yg3n1DX1xrOR4IXN
 xsLVlM1GtqihsfHuauvokk2Jt7Pll9Y39dR2CHMvYOkmqIDgf1y65VGW2ZCcF6YsW3
 3gJiO31ntHftSlGW7I7XPRRwTshOO6zxFmXx8CzjrT44MGcC+AC5vZ6DwWM6cLSHKd
 bnu0GD2Kd8dW1XS+/EQ9xogZ9Isl4WN/nsQC7NHVXD00N76BP6fbZOJ5QHsXxXFO9W
 vKOSdkQCadGBz+aY/yE+hExCaQzkkjsAUL4S1sDIyoitREnPs6rIBP2QzAPWhwqdog
 f4l1hIlNhIHcQ==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Wed, 29 Oct 2025 07:17:40 +0000 (UTC)
Received: from mail.syntacore.com (172.17.58.29) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 29 Oct 2025 10:17:35 +0300
From: Nikita Novikov <n.novikov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Nikita Novikov <n.novikov@syntacore.com>, <qemu-riscv@nongnu.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/2] hw/intc/riscv_aplic: Expand inactive source handling for
 AIA target[i]
Date: Wed, 29 Oct 2025 10:17:12 +0300
Message-ID: <20251029-n-novikov-aplic_aia_ro-v1-1-39fec74c918a@syntacore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
References: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761722114; l=3042;
 i=n.novikov@syntacore.com; s=20251028; h=from:subject:message-id;
 bh=j/rGdgBW6paBVwktG3cecuNOZmIhYHkDBXERYNaefKs=;
 b=CzWzJ42IFJCwdGzGZzJrfsByAaEsWgKdobskYAn7LCUcVXYorXmp6o2p35c/V1AjLxNySnnTd
 Z/Gd28ap1bQAkladL41HryHB9fm0BdNriPtkly8kmPoCq9Uvv8RoKY0
X-Developer-Key: i=n.novikov@syntacore.com; a=ed25519;
 pk=b3kqL1EmXxsQV/ZvSbT5Us5pjaKldmMgJuniTm3uLSM=
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.58.29]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/10/29 02:43:00 #27799423
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=n.novikov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

According to the RISC-V AIA v1.0, section 4.5.2 ("Source configurations"),
register target[i] shall be read-only zero when interrupt source i is inactive
in this domain. A source is inactive if it is delegated to a child domain or
its source mode is INACTIVE.

The previous implementation only checked SM == INACTIVE. This patch adds
full compliance:
- Return zero on read if D == 1 or SM == INACTIVE
- Ignore writes in both cases

Fixes: b6f1244678 ("intc/riscv_aplic: Fix target register read when source is inactive")
Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
---
 hw/intc/riscv_aplic.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a2041e702245211ba3bcf4334301d7c86272e36f..8c3b16074cd3ca1bc3004cfaaa13f34b8860bd48 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -193,6 +193,26 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
 #endif
 }
 
+/*
+ * APLIC target[i] must be read-only zero if the source i is inactive
+ * in this domain (delegated or SM == INACTIVE)
+ */
+static inline bool riscv_aplic_source_active(RISCVAPLICState *aplic,
+                                             uint32_t irq)
+{
+    uint32_t sc, sm;
+
+    if ((irq == 0) || (aplic->num_irqs <= irq)) {
+        return false;
+    }
+    sc = aplic->sourcecfg[irq];
+    if (sc & APLIC_SOURCECFG_D) {
+        return false;
+    }
+    sm = sc & APLIC_SOURCECFG_SM_MASK;
+    return sm != APLIC_SOURCECFG_SM_INACTIVE;
+}
+
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
@@ -635,7 +655,7 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
 
 static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
 {
-    uint32_t irq, word, idc, sm;
+    uint32_t irq, word, idc;
     RISCVAPLICState *aplic = opaque;
 
     /* Reads must be 4 byte words */
@@ -703,8 +723,7 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
     } else if ((APLIC_TARGET_BASE <= addr) &&
             (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
         irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
-        sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
-        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+        if (!riscv_aplic_source_active(aplic, irq)) {
             return 0;
         }
         return aplic->target[irq];
@@ -841,6 +860,9 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if ((APLIC_TARGET_BASE <= addr) &&
             (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
         irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
+        if (!riscv_aplic_source_active(aplic, irq)) {
+            return;
+        }
         if (aplic->msimode) {
             aplic->target[irq] = value;
         } else {

-- 
2.51.0


