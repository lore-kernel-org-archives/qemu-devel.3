Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588D606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGUU-0003Hp-ER; Sat, 14 Nov 2026 11:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGUC-0001Pk-RH; Sat, 14 Nov 2026 11:20:17 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGUB-0000Vi-4y; Sat, 14 Nov 2026 11:20:16 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBXX8M9ivhqLWQqBg--.60044S2; 
 Sun, 15 Nov 2026 00:20:13 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHQ6ivhq_9v6AA--.29619S3;
 Sun, 15 Nov 2026 00:20:10 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 35/35] hw/arm/smmuv3: Migrate the Secure register bank
Date: Sun, 15 Nov 2026 00:20:10 +0800
Message-Id: <20261114162010.3649075-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHQ6ivhq_9v6AA--.29619S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBmgAAs-
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF1UXrW5Aw18CFWDAr1rtFb_yoW5WF45pr
 n8Gwn8GryDGr43Za13Jan5CFs5Cr48WF4Ykr9rCa93K3WkJ3yaqrnIy340g34kJrWUXw47
 ZF1UuF9rGr47ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the optional smmuv3/bank_s migration subsection when secure-impl is
on. Serialize the Secure control, interrupt, error, stream table and
queue state using dedicated register-bank and queue descriptions.

Leave the subsection absent when the Secure programming interface is
disabled.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/arm/smmuv3.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6a00f6b99fa..a461da8759f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2568,6 +2568,54 @@ static const VMStateDescription vmstate_smmuv3_queue = {
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
+        VMSTATE_UINT32(gbpa, SMMUv3RegBank),
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
+    return s->secure_impl == ON_OFF_AUTO_ON;
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
@@ -2622,6 +2670,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_smmuv3_bank_s,
         NULL
     }
 };
-- 
2.34.1


