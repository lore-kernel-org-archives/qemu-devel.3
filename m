Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1500C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujggh-0004wQ-0w; Wed, 06 Aug 2025 12:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfr4-0002u9-Nr; Wed, 06 Aug 2025 11:15:03 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfr2-0006Qn-PC; Wed, 06 Aug 2025 11:15:02 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3LTzcJNowCXWBA--.36S2;
 Wed, 06 Aug 2025 23:12:51 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S4;
 Wed, 06 Aug 2025 23:12:50 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 01/11] hw/arm/smmuv3: Introduce secure registers and commands
Date: Wed,  6 Aug 2025 23:11:24 +0800
Message-Id: <20250806151134.365755-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HHgAAsK
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr4rJF4rWr4xGw4rCr1UGFg_yoW5urW5pr
 48Arn3G3yDGF4xXr1fJw1UAFnxCrZ5AFyDKFsrAry3X3WrWry7Ary8Ka43CF1DWFyUAwsx
 GanFqayru34fZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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

The Arm SMMUv3 architecture defines a set of registers and commands for
managing secure transactions and context.

This patch introduces the definitions for these secure registers and
commands within the SMMUv3 device model internal header.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3-internal.h | 57 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmuv3.h  | 23 ++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b6b7399347..483aaa915e 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -179,6 +179,63 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
 
 #define A_IDREGS           0xfd0
 
+/* Secure registers */
+#define SMMU_SECURE_BASE_OFFSET  0x8000
+REG32(S_IDR0,               0x8000)
+REG32(S_IDR1,               0x8004)
+    FIELD(S_IDR1, S_SIDSIZE,    0 , 6)
+    FIELD(S_IDR1, SEL2,         29, 1)
+    FIELD(S_IDR1, SECURE_IMPL,  31, 1)
+
+REG32(S_IDR2,               0x8008)
+REG32(S_IDR3,               0x800c)
+REG32(S_IDR4,               0x8010)
+
+REG32(S_CR0,                0x8020)
+    FIELD(S_CR0, SMMUEN,      0, 1)
+    FIELD(S_CR0, EVENTQEN,    2, 1)
+    FIELD(S_CR0, CMDQEN,      3, 1)
+
+REG32(S_CR0ACK,             0x8024)
+REG32(S_CR1,                0x8028)
+REG32(S_CR2,                0x802c)
+
+REG32(S_INIT,               0x803c)
+    FIELD(S_INIT, INV_ALL,    0, 1)
+
+REG32(S_GBPA,               0x8044)
+    FIELD(S_GBPA, ABORT,     20, 1)
+    FIELD(S_GBPA, UPDATE,    31, 1)
+
+REG32(S_IRQ_CTRL,           0x8050)
+    FIELD(S_IRQ_CTRL, GERROR_IRQEN,    0, 1)
+    FIELD(S_IRQ_CTRL, EVENTQ_IRQEN,    2, 1)
+
+REG32(S_IRQ_CTRLACK,        0x8054)
+
+REG32(S_GERROR,             0x8060)
+    FIELD(S_GERROR, CMDQ_ERR,          0, 1)
+
+REG32(S_GERRORN,            0x8064)
+REG64(S_GERROR_IRQ_CFG0,    0x8068)
+REG32(S_GERROR_IRQ_CFG1,    0x8070)
+REG32(S_GERROR_IRQ_CFG2,    0x8074)
+REG64(S_STRTAB_BASE,        0x8080)
+REG32(S_STRTAB_BASE_CFG,    0x8088)
+    FIELD(S_STRTAB_BASE_CFG, LOG2SIZE, 0, 6)
+    FIELD(S_STRTAB_BASE_CFG, SPLIT,    6, 5)
+    FIELD(S_STRTAB_BASE_CFG, FMT,     16, 2)
+
+REG64(S_CMDQ_BASE,          0x8090)
+REG32(S_CMDQ_PROD,          0x8098)
+REG32(S_CMDQ_CONS,          0x809c)
+REG64(S_EVENTQ_BASE,        0x80a0)
+REG32(S_EVENTQ_PROD,        0x80a8)
+REG32(S_EVENTQ_CONS,        0x80ac)
+REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
+REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
+REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
+
 static inline int smmu_enabled(SMMUv3State *s)
 {
     return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..72ad042514 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -63,6 +63,29 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+
+    /* Secure state */
+    uint32_t secure_idr[5];
+    uint32_t secure_cr[3];
+    uint32_t secure_cr0ack;
+    uint32_t secure_init;
+    uint32_t secure_gbpa;
+    uint32_t secure_irq_ctrl;
+    uint32_t secure_gerror;
+    uint32_t secure_gerrorn;
+    uint64_t secure_gerror_irq_cfg0;
+    uint32_t secure_gerror_irq_cfg1;
+    uint32_t secure_gerror_irq_cfg2;
+    uint64_t secure_strtab_base;
+    uint32_t secure_strtab_base_cfg;
+    uint8_t  secure_sid_split;
+    uint32_t secure_features;
+
+    uint64_t secure_eventq_irq_cfg0;
+    uint32_t secure_eventq_irq_cfg1;
+    uint32_t secure_eventq_irq_cfg2;
+
+    SMMUQueue secure_eventq, secure_cmdq;
 };
 
 typedef enum {
-- 
2.34.1


