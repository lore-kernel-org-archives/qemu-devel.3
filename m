Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83409F513F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 05:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyNUo-0006qx-Cy; Fri, 06 Mar 2026 00:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyNUk-0006qZ-Iw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:13:02 -0500
Received: from qs-2005f-snip4-11.eps.apple.com ([57.103.86.191]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyNUh-0000zp-RT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:13:02 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-14 (Postfix) with ESMTPS id
 75C4918000EE; Fri,  6 Mar 2026 05:12:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772773977; x=1775365977;
 bh=898eIGoLOpYlcd+UUxhcKOH95en53IGLXOoElDDvJmE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FGS+BCE20TGguUl1zkGla6QODuC7CN6xiLhp6vZ4C8hHLqwPJLE4wAqHC2KEip7EcpoqEz/Tihk3s9Hff3Uwpy4O3l+Jhh90nThxUjDx7hhRYAMCdxDbFqIenUQD3iRaFSkDW8fSZ1BHl4fcGLprYZBVJXxTUZSB4bRwdvV1Y8vVBigok8I53lq5IpSHo+DHN7eaQ7yp0UWcNP48clXb/IbNgPUiKI6+fuQKG8OJrUbhFI4zhfI/oDzQGF88MRknm0BZjKAg0d8cEC++MOI+Twf5sEDWlvKBVwO8WgVyrzIDMWwhbNRt95SsvlSZPOKpJmdjUwD7PAwmQlyaJ4ZlNA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-14 (Postfix) with ESMTPSA id
 126E81800104; Fri,  6 Mar 2026 05:12:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] hvf: arm: fix SME capabilities reporting
Date: Fri,  6 Mar 2026 06:12:52 +0100
Message-ID: <20260306051252.91660-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 50cpm4J6B64yOI7tXEvCCk1zZA6YyNrn
X-Authority-Info-Out: v=2.4 cv=RKu+3oi+ c=1 sm=1 tr=0 ts=69aa6259
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-YisE-5-8EYoV4yVs6QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA0OCBTYWx0ZWRfX45XnGVaiQ6Ku
 sH7GWjBKsiA55JzV9sBwKhxWBZKqCaTSqadjAYO8wj5QK5/KM5F3Zso3iNyajxKfg3NAQ94GO6o
 XorC0LEsNgf62BF8GMFfmqqizt+7Sb5OguMU1Nq6/4Ke6J6T+/RLqEvYP56e7qwHsZgIyb7AJ7z
 GYEiWaUW3Aj0SQiLSwiehmbW09MLexjl4+xByTxXtYr1052n4FzmNd5mRy9fcQX13RjXev8656H
 lXpndCHfCz8ak9c6jecqhhfQCPW8XWZVWsSumNQbYD3jIB4ZT6MeiG13kteQCuiHcJXRnjUaK2E
 KhpTf/lD4nhekl+IycsRjnzZeun2KC6mkV13Ntejcj7MIkg/4rG8xaYWOh993Q=
X-Proofpoint-GUID: 50cpm4J6B64yOI7tXEvCCk1zZA6YyNrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=738 clxscore=1030 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060048
X-JNJ: AAAAAAABeQwDY0rcZQhVaduRsLBcqCoTRPUYMw2gaHiptHXIYtQm1BSOkMGa6cQ/3llKzWyZCuAaE/9SmCKy2lIw7iJFnCNidmcxlvAITCmA3PBiMuR1S/YB5p3ssDwjHu8/WIaWC+IQnFWpx+DYowFFQPfbXXByXtU84zQnOQvMj03l1M+82zk53skNp88hgN2yJptbEE9TygHZNE3ApfaiBXagQQzN5iPqHcdX/uLQ4N4OFmDVKiUtmxMMdsolyFCoPR2+phGnBOc4Tw+sRggKCcqRTglH1b13K22LgfhiGwlQljCqHvTmX3u8xwGgbNBCkdM8TQvdqLB+Vm+kvUaeCx7eIEQ02FfU9vMJ4g/VAI28x2VnCjly82MaSWs5ubAUkZYlG/nLYnwWKtjVAhJy5oP2w5phkxxiwL/4xV3cwuM/fVLqxd7lYxnA3+403rSLnVuQZkbhUlNP38/RJAVp44VBzDVfgZyVdDi3p0TJFR1akQnT1tLvM0ACFK6FvHIq1mR9bFGevdjKabl2mVug++QUfFU12ddh8JnzWAu18sFFF7qQp6DKV4oYqGmTDmn/THfvg6GcXdUU7UniF24jmVjBKluAwDjVEKnCEyKX5tyKb2wky1SVSsaOV6LmXM3lHaRvHh01H5ggGVJ2Yoo9PUQM7pEA4MAEyKI=
Received-SPF: pass client-ip=57.103.86.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sync capabilities for the SME-specific ID registers to the host CPU config.
This fixes SME2 functionality.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Based-on: <20260306041747.54554-1-mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index cb05db2358..b7c5aea505 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1126,6 +1126,15 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_FEATURE_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
         /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
+
+    API_AVAILABLE(macos(15.2)) static const struct sme_isar_regs {
+        hv_feature_reg_t reg;
+        ARMIDRegisterIdx index;
+    } sme_regs[] = {
+        { HV_FEATURE_REG_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_IDX },
+    };
+
     hv_return_t r = HV_SUCCESS;
     hv_vcpu_config_t config = hv_vcpu_config_create();
     uint64_t t;
@@ -1146,6 +1155,16 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
     }
+
+    if (__builtin_available(macOS 15.2, *)) {
+        if (hvf_arm_sme2_supported()) {
+            for (i = 0; i < ARRAY_SIZE(sme_regs); i++) {
+                r |= hv_vcpu_config_get_feature_reg(config, sme_regs[i].reg,
+                                            &host_isar.idregs[sme_regs[i].index]);
+            }
+        }
+    }
+
     os_release(config);
 
     /*
-- 
2.50.1 (Apple Git-155)


