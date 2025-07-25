Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99300C87FCC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 02:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf8JZ-00060v-2a; Thu, 24 Jul 2025 22:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uf8JW-0005yI-6y; Thu, 24 Jul 2025 22:37:38 -0400
Received: from mail-m16.yeah.net ([220.197.32.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uf8JR-0001xq-Is; Thu, 24 Jul 2025 22:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XE
 47keZ2BqznQXDv9U1SHEM4o3k2Y3zH2e+VYsKpem8=; b=XKUzWx1qWqStxCaNue
 O3tGqjv+E+IbqcGQV9KaAJaQwYY85eVAN+suY5UAehnj0soit4WQIISiBGl2fqCF
 vP/nlb+njya8sPN2RGj0ZNsCBBsXI2dRLLTMDmFQl96C+5+ffC5twvbDrnbd3dMQ
 eXfEUivta41Nyhto5D0Bua0k4=
Received: from vcore-181.. (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgC3nx_V7YJof+FeAQ--.34326S2;
 Fri, 25 Jul 2025 10:37:11 +0800 (CST)
From: Yang Jialong <z_bajeer@yeah.net>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: yangjialong@rvcore.com, Yang Jialong <z_bajeer@yeah.net>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] intc/riscv_aplic: Fix target register read when source is
 inactive
Date: Fri, 25 Jul 2025 10:25:20 +0800
Message-ID: <20250724093426.4179617-1-z_bajeer@yeah.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgC3nx_V7YJof+FeAQ--.34326S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4UAFy3ZFW5CryDtrWfGrg_yoW8Gr45pr
 4fGFsIvFs8tF1UWa1kGr1UXF43GrZ8Wry5ur1DuryIkwsIyw4Fgryqk345Zr4ruFy3Cr1Y
 vFZ0kr1fCF42v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeBT5UUUUU=
X-Originating-IP: [49.7.252.142]
X-CM-SenderInfo: p2betyxhhuq5hhdkh0dhw/1tbiEhGVI2iCwcGawAAAsF
Received-SPF: pass client-ip=220.197.32.17; envelope-from=z_bajeer@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20250725022520.lJuPHeZNBehGPnPOL5xb96d_hJYQMtgXhtUgTY-UvEc@z>

The RISC-V Advanced interrupt Architecture:
4.5.16. Interrupt targets:
If interrupt source i is inactive in this domain, register target[i] is
read-only zero.

Signed-off-by: Yang Jialong <z_bajeer@yeah.net>
---
 hw/intc/riscv_aplic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

v1 --> v2:
- Use '&' replace the error '*'.

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4fa5f7597b..a1d9fa5085 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -628,7 +628,7 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
 
 static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
 {
-    uint32_t irq, word, idc;
+    uint32_t irq, word, idc, sm;
     RISCVAPLICState *aplic = opaque;
 
     /* Reads must be 4 byte words */
@@ -696,6 +696,10 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
     } else if ((APLIC_TARGET_BASE <= addr) &&
             (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
         irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
+        sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
+        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+            return 0;
+        }
         return aplic->target[irq];
     } else if (!aplic->msimode && (APLIC_IDC_BASE <= addr) &&
             (addr < (APLIC_IDC_BASE + aplic->num_harts * APLIC_IDC_SIZE))) {
-- 
2.34.1


