Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7243FC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevlY-0002lC-5z; Thu, 24 Jul 2025 09:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uesXI-0000OR-JY; Thu, 24 Jul 2025 05:46:48 -0400
Received: from mail-m16.yeah.net ([1.95.21.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uesX9-0008DS-5m; Thu, 24 Jul 2025 05:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U+
 bEyJCRkOOjW2WuDRHjgnixsRl5GRu1j6nn0Pr0hMQ=; b=GE0QmRhyvM7c7TtqMd
 JzZLTxVNsB/soA6HyzTYo5Bqgh3Mh/h/zcN5fZ/UwLEPI7ltatX451bU2Gap5+5k
 8A4ft0YL266FnT6v+syKQkTvq4hHp3r/QohGj/+Gn7APRLAaU/DPipD8Q+UVW+s0
 YhBDAtSG8amL4CwAhnDXT1z+A=
Received: from vcore-181.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3P93kAIJoQlVNAQ--.8853S2;
 Thu, 24 Jul 2025 17:46:14 +0800 (CST)
From: Yang Jialong <z_bajeer@yeah.net>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: yangjialong@rvcore.com, Yang Jialong <z_bajeer@yeah.net>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v1] intc/riscv_aplic: Fix target register read when source is
 inactive
Date: Thu, 24 Jul 2025 17:34:26 +0800
Message-Id: <20250724093426.4179617-1-z_bajeer@yeah.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgD3P93kAIJoQlVNAQ--.8853S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4UAFy3ZFWDKF18AFWDArb_yoW8JFW5pr
 s3GFsIvrs8tF1UGa1kJr18XF4UGr98Wr98ur1DuryIkwsxtw4FgrykK345Zr48CFy5Cr1Y
 vFZ0kr13CF4jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeBT5UUUUU=
X-Originating-IP: [103.233.53.226]
X-CM-SenderInfo: p2betyxhhuq5hhdkh0dhw/1tbiNQbzF2iCAOb+RQAA3g
Received-SPF: pass client-ip=1.95.21.14; envelope-from=z_bajeer@yeah.net;
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
X-Mailman-Approved-At: Thu, 24 Jul 2025 09:13:42 -0400
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

The RISC-V Advanced interrupt Architecture:
4.5.16. Interrupt targets:
If interrupt source i is inactive in this domain, register target[i] is
read-only zero.

Signed-off-by: Yang Jialong <z_bajeer@yeah.net>
---
 hw/intc/riscv_aplic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4fa5f75..cfef69f 100644
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
+        sm = aplic->sourcecfg[irq] * APLIC_SOURCECFG_SM_MASK;
+        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+            return 0;
+        }
         return aplic->target[irq];
     } else if (!aplic->msimode && (APLIC_IDC_BASE <= addr) &&
             (addr < (APLIC_IDC_BASE + aplic->num_harts * APLIC_IDC_SIZE))) {
-- 
2.34.1


