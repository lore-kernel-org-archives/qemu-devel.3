Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C02CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0RN-0007ey-5Y; Wed, 29 Oct 2025 03:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vE0RK-0007eW-4Z; Wed, 29 Oct 2025 03:17:50 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vE0RG-0005wE-Kc; Wed, 29 Oct 2025 03:17:49 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id 809D71A0005;
 Wed, 29 Oct 2025 07:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 809D71A0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1761722264; bh=YJGVliqenItPfXmFgXw7zMsjaTNeX8YAjNRruO4xHo8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=GpbKQA832Ulf7lVcdKbhw4ithuJUaqzoWJBhkkrU6nu8t7K0JT5pbuRfMxpi88/gF
 uN+K+H2wSgLU0wtjNfHKyKESyYfJx173JsKkUwwFgqn6OLq2KHg7tbqcWgui5ak28b
 UGVVZgIbs6qZkjw+PiahKXTXO92pbt5yocx+wRnbhcd99KjA2/qQTbr2MhtYLBS0xC
 ieNKhFkEz6XIc8BdWJx0o6116wm1Mjj/eF+DhFTSEb+F9qh6c8qdSRy0THFWLX3XWJ
 gRC1Y1vvih9ISFWoXpU8fw31kkOvSuHIe15ghKTS7wEz+j8xfHq0eI/7LvxT6glI0b
 q0YkHuYQxCyvw==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Wed, 29 Oct 2025 07:17:43 +0000 (UTC)
Received: from mail.syntacore.com (172.17.58.29) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 29 Oct 2025 10:17:38 +0300
From: Nikita Novikov <n.novikov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Nikita Novikov <n.novikov@syntacore.com>, <qemu-riscv@nongnu.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 2/2] hw/intc/riscv_aplic: Factor out source_active() and
 remove duplicate checks
Date: Wed, 29 Oct 2025 10:17:13 +0300
Message-ID: <20251029-n-novikov-aplic_aia_ro-v1-2-39fec74c918a@syntacore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
References: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761722114; l=2968;
 i=n.novikov@syntacore.com; s=20251028; h=from:subject:message-id;
 bh=jNhz21qMMPjj9BorlQDIHcDoXk3KtnEbQex2fn3RXlk=;
 b=4cXq5RIAnpdxZtvwid/Hm78ZHjzMAMBAMnfssdYmtk0F0q9i1Q6qgNaZ3TbnUTMK+c4P7oV0R
 GMg0ZQk0j42AChM0AegfUojXO4ItIRrFH32JhwJs5tU74afWjWVgcTQ
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

Refactor the APLIC code to consolidate repeated conditions checking
whether an interrupt source is valid, delegated, or inactive.

Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
---
 hw/intc/riscv_aplic.c | 44 +++++++-------------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8c3b16074cd3ca1bc3004cfaaa13f34b8860bd48..ccfbc9b4656f3e2a69eb5bcd1cee9e5762020351 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -216,22 +216,13 @@ static inline bool riscv_aplic_source_active(RISCVAPLICState *aplic,
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
-    uint32_t sourcecfg, sm, raw_input, irq_inverted;
+    uint32_t sm, raw_input, irq_inverted;
 
-    if (!irq || aplic->num_irqs <= irq) {
-        return false;
-    }
-
-    sourcecfg = aplic->sourcecfg[irq];
-    if (sourcecfg & APLIC_SOURCECFG_D) {
-        return false;
-    }
-
-    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+    if (!riscv_aplic_source_active(aplic, irq)) {
         return false;
     }
 
+    sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
     raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
     irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
                     sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
@@ -284,22 +275,13 @@ static void riscv_aplic_set_pending_raw(RISCVAPLICState *aplic,
 static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
                                     uint32_t irq, bool pending)
 {
-    uint32_t sourcecfg, sm;
+    uint32_t sm;
 
-    if ((irq <= 0) || (aplic->num_irqs <= irq)) {
-        return;
-    }
-
-    sourcecfg = aplic->sourcecfg[irq];
-    if (sourcecfg & APLIC_SOURCECFG_D) {
-        return;
-    }
-
-    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+    if (!riscv_aplic_source_active(aplic, irq)) {
         return;
     }
 
+    sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
     if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
         (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
         if (!aplic->msimode) {
@@ -370,19 +352,7 @@ static void riscv_aplic_set_enabled_raw(RISCVAPLICState *aplic,
 static void riscv_aplic_set_enabled(RISCVAPLICState *aplic,
                                     uint32_t irq, bool enabled)
 {
-    uint32_t sourcecfg, sm;
-
-    if ((irq <= 0) || (aplic->num_irqs <= irq)) {
-        return;
-    }
-
-    sourcecfg = aplic->sourcecfg[irq];
-    if (sourcecfg & APLIC_SOURCECFG_D) {
-        return;
-    }
-
-    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+    if (!riscv_aplic_source_active(aplic, irq)) {
         return;
     }
 

-- 
2.51.0


