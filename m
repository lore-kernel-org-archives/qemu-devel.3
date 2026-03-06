Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CDCFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqO-0004Mq-4k; Fri, 06 Mar 2026 11:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqL-0004Lj-SR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:01 -0500
Received: from p-west3-cluster3-host4-snip4-6.eps.apple.com ([57.103.72.187]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqJ-0007Dx-B2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:01 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 9CFF618007AF; Fri,  6 Mar 2026 16:15:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813758; x=1775405758;
 bh=kOA1yy4anKfg0TU4LmBU8Uljdi+od0eTtMcvlK7MTEY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=f8lXDTYXLN1HzTes37p3QLo9+gt2A0RGmTq1ibpXgnuY56NXkjcgNBplajGDJgzOkQFA2NBw/ulNnnzJRrwUGjeDQ0bPHkB1rqA89a2gcVlFpgprFs6gSKiuBopeniD/Rz1j2kOiLzp2QtlsuMIXfe4ScKcRb1uHHMpgADUciiHA21x01ZbRPm0UM4J/UEcLdAxYnYLRUDPLV7WccmPI+dE6oSaxzLBPVQxYfnzYwKUrrBfkWCcPUUZItNb5o5b6XudbrWq3Uq7CzVHVZEulD5BjXAG03OIwRSBYJVuQJqfWT5EMaX81iPyBEHIcMow9VX5d6Uxb1htw2hKwFxiYzQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 E057518007BC; Fri,  6 Mar 2026 16:15:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 16/17] hvf: arm: disable SME when nested virt is active
Date: Fri,  6 Mar 2026 17:15:08 +0100
Message-ID: <20260306161509.79712-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MN1tWcZl c=1 sm=1 tr=0 ts=69aafdbd
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=h9724yil-ocX87RSi0QA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX1aIKJfMIeB+A
 0aEa/RM1TQJZz9z3sBEWJ0Z7iwaLd7ay1frsYDS2jCcQWhuhjWA/q9rmpQ5s3PCd/3vpXnc91z/
 31WzsL1XQzHADSvNOpgz0iqA1O6bOMpKpXPTkcyIDTvwmOHepvI5jiusczS8FZ5fPCflEJRuqSt
 +Z+9rNde9wpv/0Zw6K7TLGJ86bf5WqCEhnFgc09JjaKavrNmKkYTFmox/DTTopjZkJuz0FCMqTF
 iCcW4jRLQNi20VP0kyF4/eyD+xH4Q3Y25+M3E5QlM5RZr8ZkFkUtbzmNyfWSmze0RoKz1ynuN90
 NILMRqNrcYf8c5yEea5HWPf298RbtrvsmjAyRd47Llry29SIVtq12eUvEkl+OY=
X-Proofpoint-GUID: tnnvevIHsj-9OfYQhUf30NWQRCwX_EFZ
X-Proofpoint-ORIG-GUID: tnnvevIHsj-9OfYQhUf30NWQRCwX_EFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=842
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABv/G9bUoWe8Uzu0ra9ykAJedqPaWTdP6BJTUbjBGUKEwTRM9TzTfy7nwOrRJz6+shjsXwVQb7GsevLmYP7LIoCBcfr3pSFNSfVVjHFsk19G+IGDngv1Ct+ztqhdw7mWVxN0l/Cp53K4niEHtGsrR5uj/bdcwNDp/6ZR5WAQ/pOHGJi2ls765UCMBgH00vqD3c5GOS0pbEekIx1g5nNhHgWaR7DPpJmT0vBXJAX9Qg3F7rY5sxzYgXXonugkOuejn6J90CSqs47M11yzXWKSrE5WQEs+vlNi9b9QG17k9bTJwalbAQRvkb/DAgazsmgf9iGggi+EfreKU1CVc9t6uxH9XtxfdvOB/kIlkWWMyBYD/wnTZnkqDC5a1v7RP/y+Z/yE+sneuCccxCk1tN1R2AJckkH89tyFX/YseDZWYIX9jB3Vo0SEZ7Zi/e4GQadkr285w0vmSedH/IoSAGm+Rzo95y5jNIa5CwYB/Ev8AU/20kiQ6cXvWv6b1L3JOtDOgbU9sWwUiKWSAwhwXW8Un7ArgM3Ubz8yZFxWTfPWiMw0RXzQ/kcbzL5odoKNAbiVXbKQ4li2q1/1MMs3Xvx3+73DRRNcefZq0ls96V6q/JrZeTNG0wRzG0Ds9d3XrF85iP8gKQpmhe9fyJIvVvyAjWcZgtkTTJCCTDeH58s5GDKTkgC5p/R9dk77Xhla0OJoTifzcBa7ETk34+bRxynof23r2pjGbOfm0zq9gCbq4gX2vK9a09HrC/fbEz63kHZf4ecaecXGkEJQ==
Received-SPF: pass client-ip=57.103.72.187;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Currently, Apple doesn't support the nested virtualisation + SME combination.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 3 +++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fd5d248e20..1559b2eecd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1189,6 +1189,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     if (hvf_nested_virt_enabled()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+        /* SME is not implemented with nested virt on the Apple side */
+        SET_IDREG(&host_isar, ID_AA64PFR1,
+              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
     }
 
     ahcf->isar = host_isar;
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 6b1c3b9792..9cb58ad9ab 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
+#include "system/hvf.h"
 #include "target/arm/cpu-qom.h"
 
 /**
@@ -35,6 +36,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
         if (__builtin_available(macOS 15.2, *)) {
             size_t svl_bytes;
             hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            /* Nested virt not supported together with SME right now. */
+            if (hvf_nested_virt_enabled()) {
+                return false;
+            }
             if (result == HV_UNSUPPORTED) {
                 return false;
             }
-- 
2.50.1 (Apple Git-155)


