Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6EACAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ons-0006JC-PN; Thu, 25 Sep 2025 12:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1onp-0006IT-M4; Thu, 25 Sep 2025 12:26:41 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1onj-0004kI-14; Thu, 25 Sep 2025 12:26:41 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3bUybdVoYwo6CQ--.582S2;
 Fri, 26 Sep 2025 00:26:26 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLestbdVoW_MeAA--.7120S6;
 Fri, 26 Sep 2025 00:26:23 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 03/14] hw/arm/smmuv3: Introduce secure registers and
 commands
Date: Fri, 26 Sep 2025 00:26:07 +0800
Message-Id: <20250925162618.191242-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHLestbdVoW_MeAA--.7120S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHswAAsC
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr4rJF4rWr4xXrWUtF4xZwb_yoW5Zw48pr
 40yFyrC3yDJF4xWw1fGa1UAF13Crs5A34UGFZFkr1ava4rWryfArW8Ka4fGrykWF1rZF1D
 J3Wqv34F93ySyr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Arm SMMUv3 architecture defines a set of registers and commands for
managing secure transactions and context.

This patch introduces the definitions for these secure registers and
commands within the SMMUv3 device model internal header.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3-internal.h | 72 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 71a3c0c02c..3820157eaa 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -38,7 +38,7 @@ typedef enum SMMUTranslationClass {
     SMMU_CLASS_IN,
 } SMMUTranslationClass;
 
-/* MMIO Registers */
+/* MMIO Registers. The offsets are shared by Non-secure/Realm/Root states. */
 
 REG32(IDR0,                0x0)
     FIELD(IDR0, S2P,         0 , 1)
@@ -121,6 +121,7 @@ REG32(CR0,                 0x20)
     FIELD(CR0, CMDQEN,        3, 1)
 
 #define SMMU_CR0_RESERVED 0xFFFFFA20
+#define SMMU_S_CR0_RESERVED 0xFFFFFC12
 
 
 REG32(CR0ACK,              0x24)
@@ -180,6 +181,75 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
 
 #define A_IDREGS           0xfd0
 
+/* Secure registers. The offsets are begin with SMMU_SECURE_BASE_OFFSET */
+#define SMMU_SECURE_BASE_OFFSET  0x8000
+
+REG32(S_IDR0,               0x8000)
+REG32(S_IDR1,               0x8004)
+    FIELD(S_IDR1, S_SIDSIZE,          0 , 6)
+    FIELD(S_IDR1, SEL2,               29, 1)
+    FIELD(S_IDR1, SECURE_IMPL,        31, 1)
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
+/* Alias for the S_INIT offset to match in the dispatcher switch */
+#define A_S_INIT_ALIAS         0x3c
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
+#define SMMU_GERROR_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
+#define SMMU_GERROR_IRQ_CFG2_RESERVED   0x000000000000003F
+
+#define SMMU_STRTAB_BASE_RESERVED       0x40FFFFFFFFFFFFC0
+#define SMMU_QUEUE_BASE_RESERVED        0x40FFFFFFFFFFFFFF
+#define SMMU_EVENTQ_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
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
+    FIELD(S_CMDQ_CONS, ERR,           24, 7)
+
+REG64(S_EVENTQ_BASE,        0x80a0)
+REG32(S_EVENTQ_PROD,        0x80a8)
+REG32(S_EVENTQ_CONS,        0x80ac)
+REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
+REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
+REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
+
 static inline int smmu_enabled(SMMUv3State *s)
 {
     return FIELD_EX32(s->cr[0], CR0, SMMUEN);
-- 
2.34.1


