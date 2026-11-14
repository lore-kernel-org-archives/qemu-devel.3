Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64614606A334
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGT7-00080a-46; Sat, 14 Nov 2026 11:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGSC-00078S-EL; Sat, 14 Nov 2026 11:18:18 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGS8-0003EK-9r; Sat, 14 Nov 2026 11:18:12 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAXH5+7ifhqaloqBg--.64105S2; 
 Sun, 15 Nov 2026 00:18:03 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHSyifhq4Nv6AA--.29617S12;
 Sun, 15 Nov 2026 00:18:02 +0800 (CST)
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
Subject: [PATCH v6 19/35] hw/arm/smmuv3: Keep accelerated invalidation
 Non-secure-only
Date: Sun, 15 Nov 2026 00:17:53 +0800
Message-Id: <20261114161753.3645568-10-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHSyifhq4Nv6AA--.29617S12
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBfgAAsb
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw4UXr47CrWUtr17CrWruFg_yoWrJF1UpF
 4UWwn8Wr45JasYyay2yw48uw4ft3WUKr4fGr1Yga4Syw1DAr98XrsY9r1F9r9rCr13ZrZx
 Z3y8Wa15Z3WjyrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

The accelerated backend supports only the Non-secure programming
interface. Filter configuration and TLB invalidations by their target
SEC_SID in the command handlers before calling the backend. Keep the
backend APIs unchanged.

A legal ATC invalidation still targets Non-secure streams when issued
from a Secure command queue. Continue forwarding Non-secure stage-1
CMD_TLBI_NH_ALL to the host.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 93d5b900806..98e45e33082 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1493,7 +1493,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sec_sid, ssec, sid);
-            if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
+            if (ssec == SMMU_SEC_SID_NS &&
+                !smmuv3_accel_install_ste(s, sdev, sid, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1513,7 +1514,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 
             trace_smmuv3_cmdq_cfgi_ste_range(sec_sid, ssec,
                                              sid_range.start, sid_range.end);
-            if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
+            if (ssec == SMMU_SEC_SID_NS &&
+                !smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1541,7 +1543,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 
             trace_smmuv3_cmdq_cfgi_cd(sec_sid, ssec, sid);
             smmuv3_flush_config_by_sec_sid(sdev, ssec);
-            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+            if (ssec == SMMU_SEC_SID_NS &&
+                !smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1568,7 +1571,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             trace_smmuv3_cmdq_tlbi_nh_asid(sec_sid, asid);
             smmuv3_inv_notifiers_all(bs, sec_sid);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid, sec_sid);
-            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+            if (sec_sid == SMMU_SEC_SID_NS &&
+                !smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1596,7 +1600,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
             smmuv3_inv_notifiers_all(bs, sec_sid);
             smmu_iotlb_inv_by_sec_sid(bs, sec_sid);
-            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+            if (sec_sid == SMMU_SEC_SID_NS &&
+                !smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1616,7 +1621,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             trace_smmuv3_cmdq_tlbi_nsnh(sec_sid, target_sec_sid);
             smmuv3_inv_notifiers_all(bs, target_sec_sid);
             smmu_iotlb_inv_by_sec_sid(bs, target_sec_sid);
-            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+            if (target_sec_sid == SMMU_SEC_SID_NS &&
+                !smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1630,7 +1636,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_sid,
                                queue_stage2_supported);
-            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+            if (sec_sid == SMMU_SEC_SID_NS &&
+                !smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-- 
2.34.1


