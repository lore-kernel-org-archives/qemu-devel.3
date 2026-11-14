Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47139606A334
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGT4-0007mB-OV; Sat, 14 Nov 2026 11:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGSE-00078q-S5; Sat, 14 Nov 2026 11:18:22 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGS8-0003E5-AT; Sat, 14 Nov 2026 11:18:14 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAXTaW4ifhqylkqBg--.44579S2; 
 Sun, 15 Nov 2026 00:18:00 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHSyifhq4Nv6AA--.29617S8;
 Sun, 15 Nov 2026 00:17:59 +0800 (CST)
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
Subject: [PATCH v6 15/35] hw/arm/smmuv3: Limit IOMMU notifications to
 Non-secure targets
Date: Sun, 15 Nov 2026 00:17:49 +0800
Message-Id: <20261114161753.3645568-6-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHSyifhq4Nv6AA--.29617S8
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBegAAsf
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF4fKFyfZr15Jw1kXF48tFb_yoWrJFy8pr
 47KrZ5urZ8Aa93Ja12vw4UCFy3Xw1qkryrtrW5WF95t3WDJryaqFWkGryYkryDCr1UZrZ3
 Z3yUWF43ua17t3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

IOMMU notifiers are supported only for Non-secure devices. Add a wrapper
for full invalidation notifications and filter range notifications by
the target SEC_SID before walking the registered notifier list.

Keep the underlying common notifier helpers unchanged. Command handlers
can then select whether to notify according to the invalidation target.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f7ca3859bc2..ce00461210b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1307,10 +1307,16 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages, int stage)
+                                      uint64_t num_pages, int stage,
+                                      SMMUSecSID sec_sid)
 {
     SMMUDevice *sdev;
 
+    /* IOMMU notifiers are supported only for Non-secure devices. */
+    if (sec_sid != SMMU_SEC_SID_NS) {
+        return;
+    }
+
     QLIST_FOREACH(sdev, &s->devices_with_notifiers, next) {
         IOMMUMemoryRegion *mr = &sdev->iommu;
         IOMMUNotifier *n;
@@ -1324,6 +1330,14 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
     }
 }
 
+static void smmuv3_inv_notifiers_all(SMMUState *s, SMMUSecSID sec_sid)
+{
+    /* IOMMU notifiers are supported only for Non-secure devices. */
+    if (sec_sid == SMMU_SEC_SID_NS) {
+        smmu_inv_notifiers_all(s);
+    }
+}
+
 static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
                                SMMUSecSID sec_sid)
 {
@@ -1352,7 +1366,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
     if (!tg) {
         trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
                                  tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage,
+                                  sec_sid);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
         } else {
@@ -1376,7 +1391,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
         trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
                                  num_pages, ttl, leaf, stage);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
-                                  num_pages, stage);
+                                  num_pages, stage, sec_sid);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
                                 num_pages, ttl, sec_sid);
@@ -1530,7 +1545,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             }
 
             trace_smmuv3_cmdq_tlbi_nh_asid(sec_sid, asid);
-            smmu_inv_notifiers_all(&s->smmu_state);
+            smmuv3_inv_notifiers_all(bs, sec_sid);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid, sec_sid);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1561,7 +1576,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
         }
         case SMMU_CMD_TLBI_NSNH_ALL:
             trace_smmuv3_cmdq_tlbi_nsnh();
-            smmu_inv_notifiers_all(&s->smmu_state);
+            smmuv3_inv_notifiers_all(bs, SMMU_SEC_SID_NS);
             smmu_iotlb_inv_all(bs);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1590,7 +1605,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             }
 
             trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
-            smmu_inv_notifiers_all(&s->smmu_state);
+            smmuv3_inv_notifiers_all(bs, SMMU_SEC_SID_NS);
             smmu_iotlb_inv_vmid(bs, vmid, SMMU_SEC_SID_NS);
             break;
         }
-- 
2.34.1


