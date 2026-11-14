Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F3606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGOB-0000MK-TY; Sat, 14 Nov 2026 11:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGO7-0000HZ-1b; Sat, 14 Nov 2026 11:13:59 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGO5-0002Fv-G9; Sat, 14 Nov 2026 11:13:58 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAHD5_CiPhq7kkqBg--.42919S2; 
 Sun, 15 Nov 2026 00:13:54 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwR3bAiPhqudv6AA--.34439S3;
 Sun, 15 Nov 2026 00:13:52 +0800 (CST)
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
Subject: [PATCH v6 05/35] hw/arm/smmu-common: Add security-aware address space
 selector
Date: Sun, 15 Nov 2026 00:13:51 +0800
Message-Id: <20261114161351.3639925-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwR3bAiPhqudv6AA--.34439S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBZQAAsA
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7try7XFW3Ary5WF1DWw4UArb_yoW8ZFWxpa
 n7Cr95JrykKF1I9r93Xr4avFy5Wws3Gr1UJry29FyDuw17tr1fAr1UKw1YkrZrCrsYqr43
 uFWxZFs5W3W5trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce SMMU_SEC_SID_S to represent SEC_SID == 1, meaning Secure. And
then provide smmu_get_address_space, a SMMU instance-based address space
selector. The helper returns the per-device memory or secure-memory
AddressSpace selected by SEC_SID.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 include/hw/arm/smmu-common.h |  3 +++
 hw/arm/smmu-common.c         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 6ea40f6b074..9d6e2d3038f 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -43,6 +43,7 @@
 /* StreamID Security state */
 typedef enum SMMUSecSID {
     SMMU_SEC_SID_NS = 0,
+    SMMU_SEC_SID_S,
     SMMU_SEC_SID_NUM,
 } SMMUSecSID;
 
@@ -188,6 +189,8 @@ struct SMMUBaseClass {
 #define TYPE_ARM_SMMU "arm-smmu"
 OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
 
+AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid);
+
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8e40ba603d3..95ef9f50a23 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,6 +30,20 @@
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
+{
+    switch (sec_sid) {
+    case SMMU_SEC_SID_NS:
+        return &s->memory_as;
+    case SMMU_SEC_SID_S:
+        g_assert(s->secure_memory);
+        return &s->secure_memory_as;
+    case SMMU_SEC_SID_NUM:
+        g_assert_not_reached();
+    }
+    g_assert_not_reached();
+}
+
 /* IOTLB Management */
 
 static guint smmu_iotlb_key_hash(gconstpointer v)
-- 
2.34.1


