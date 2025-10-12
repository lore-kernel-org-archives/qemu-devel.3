Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D77CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xoG-0004hY-Bc; Sun, 12 Oct 2025 11:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xoE-0004gy-SW; Sun, 12 Oct 2025 11:16:30 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xoC-0002pR-Iu; Sun, 12 Oct 2025 11:16:30 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnr5tIxutobFqgAA--.6S2;
 Sun, 12 Oct 2025 23:16:24 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXO+lHxutohHhMAA--.1378S3;
 Sun, 12 Oct 2025 23:16:23 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 21/21] hw/arm/smmuv3: Add secure migration and enable secure
 state
Date: Sun, 12 Oct 2025 23:16:11 +0800
Message-Id: <20251012151611.4131627-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXO+lHxutohHhMAA--.1378S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBewAAsK
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw18uF1DKFW3XF4kKw4rZrb_yoW7ZF1fpr
 s8G3Z8GryDGF4fur4fJw48CFs5CrWfGF4YkrZrCa9aya1kJw42qrn2yayfW3s5JrWUXa17
 uF109FZrXw4UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Introduce a bool secure_impl field to SMMUv3State and expose it as
a secure-impl device property. The introduction of this property is the
culminating step that activates the entire secure access data path,
tying together all previously merged logic to provide full support for
secure state accesses.

Add live migration support for the SMMUv3 secure register bank.

To correctly migrate the secure state, the migration logic must know
if the secure functionality is enabled. To facilitate this, a bool
secure_impl field is introduced and exposed as the secure-impl device
property. This property is introduced at the point it is first
required—for migration—and serves as the final piece of the series.

The introduction of this property also completes and activates the
entire secure access data path, tying together all previously merged
logic to provide full support for secure state accesses.

Usage:
    -global arm-smmuv3,secure-impl=true

When this property is enabled, the capability is advertised to the
guest via the S_IDR1.SECURE_IMPL bit.

The migration is implemented as follows:

- A new vmstate_smmuv3_secure_bank, referenced by the smmuv3/bank_s
subsection, serializes the secure bank's registers and queues.

- A companion smmuv3/gbpa_secure subsection mirrors the non-secure
GBPA handling, migrating the register only if its value diverges
from the reset default.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c         | 75 +++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmuv3.h |  1 +
 2 files changed, 76 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0b366895ec..ce41a12a36 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -337,6 +337,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
 
     memset(sbk->idr, 0, sizeof(sbk->idr));
     sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, SMMU_IDR1_SIDSIZE);
+    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, SECURE_IMPL, s->secure_impl);
     sbk->gbpa = SMMU_GBPA_RESET_VAL;
     sbk->cmdq.entry_size = sizeof(struct Cmd);
     sbk->eventq.entry_size = sizeof(struct Evt);
@@ -2452,6 +2453,53 @@ static const VMStateDescription vmstate_smmuv3_queue = {
     },
 };
 
+static const VMStateDescription vmstate_smmuv3_secure_bank = {
+    .name = "smmuv3_secure_bank",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(features, SMMUv3RegBank),
+        VMSTATE_UINT8(sid_split, SMMUv3RegBank),
+        VMSTATE_UINT32_ARRAY(cr, SMMUv3RegBank, 3),
+        VMSTATE_UINT32(cr0ack, SMMUv3RegBank),
+        VMSTATE_UINT32(irq_ctrl, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror, SMMUv3RegBank),
+        VMSTATE_UINT32(gerrorn, SMMUv3RegBank),
+        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3RegBank),
+        VMSTATE_UINT64(strtab_base, SMMUv3RegBank),
+        VMSTATE_UINT32(strtab_base_cfg, SMMUv3RegBank),
+        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3RegBank),
+        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3RegBank),
+        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3RegBank),
+        VMSTATE_STRUCT(cmdq, SMMUv3RegBank, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_STRUCT(eventq, SMMUv3RegBank, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static bool smmuv3_secure_bank_needed(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    return s->secure_impl;
+}
+
+static const VMStateDescription vmstate_smmuv3_bank_s = {
+    .name = "smmuv3/bank_s",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smmuv3_secure_bank_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(bank[SMMU_SEC_SID_S], SMMUv3State, 0,
+                       vmstate_smmuv3_secure_bank, SMMUv3RegBank),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static bool smmuv3_gbpa_needed(void *opaque)
 {
     SMMUv3State *s = opaque;
@@ -2472,6 +2520,25 @@ static const VMStateDescription vmstate_gbpa = {
     }
 };
 
+static bool smmuv3_gbpa_secure_needed(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    return s->secure_impl &&
+           s->bank[SMMU_SEC_SID_S].gbpa != SMMU_GBPA_RESET_VAL;
+}
+
+static const VMStateDescription vmstate_gbpa_secure = {
+    .name = "smmuv3/gbpa_secure",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smmuv3_gbpa_secure_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(bank[SMMU_SEC_SID_S].gbpa, SMMUv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_smmuv3 = {
     .name = "smmuv3",
     .version_id = 1,
@@ -2506,6 +2573,8 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_smmuv3_bank_s,
+        &vmstate_gbpa_secure,
         NULL
     }
 };
@@ -2519,6 +2588,12 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /*
+     * SECURE_IMPL field in S_IDR1 register.
+     * Indicates whether secure state is implemented.
+     * Defaults to false (0)
+     */
+    DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e9012fcdb0..8fec3f8edb 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,6 +69,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    bool secure_impl;
 };
 
 typedef enum {
-- 
2.34.1


