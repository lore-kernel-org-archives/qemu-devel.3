Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3EAF0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUpB-0002Jb-J7; Fri, 06 Mar 2026 08:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoq-0001We-6y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:16 -0500
Received: from p-west2-cluster2-host7-snip4-10.eps.apple.com ([57.103.68.253]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoo-0007CO-Pc
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:15 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 F18501800878; Fri,  6 Mar 2026 13:02:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802133; x=1775394133;
 bh=lvcw32Iphm/c9mMbxulwfRQktBduM18I6AQjOjKKiAo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=E4vIkfhEUJdLlAOJvCSAphZkegVn8dB8hAX+vXIL6vHUT1IugVbExHzUsC/p8RruT1u2C/8dCQIBO6iTvG8rgQQkI9tqDjqismnA21hOUKXhnzCzH7f3iWlO1yYbCRLvkgNgp+aRf5epLwzGCYPVU68XhZroYKT7Ma3iFX+xxowne8h/wAo1/Qx3FTVdXsPkRhWO85sMUzvAF3a1hAM/Lhrw37G5Elwlq9nZ1bobB4ur3Jz9q8QCC0aI+QuE5vPftJrhl+dJ53bqupmwi3OGw+/0Wn9RhHRAywK4m4MpD8IBBrLPOkezgN2zeKhvTliwDHeSiBEoW2HV0lHYcbX84g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 2F7311802E4B; Fri,  6 Mar 2026 13:01:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 16/17] hvf: arm: disable SME when nested virt is active
Date: Fri,  6 Mar 2026 14:01:06 +0100
Message-ID: <20260306130107.35359-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I-L5dSakyfnBoTBO6H_TLoiImEfyRUGn
X-Authority-Info-Out: v=2.4 cv=GpRPO01C c=1 sm=1 tr=0 ts=69aad053
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h9724yil-ocX87RSi0QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfXzM7QwJjkcujt
 U/zJtDsKAW46RE9LbTQNN7KKsjYyz3yew21gRdAKvj62+cFY5vF1bgZX8/D0hyQIQVmyPhxNEU0
 i9uI2zqqF29v0+ZxaNctPbzrOhXxKdQBmsRkUlzx0qmQQoWhs0Ktaodd2drT3ahiG7vGe7fjR94
 gx7ccqGQLUn+uLdTO0t+UDEM0UjGa4Tg8zFS7FyiXGjyst77ch5do6nRi1lVm6Y5sgtekAB14X/
 o33KdCZAFIrKUaL2kaqazGCd+deREt2Yixho8a1fzyunW8QY0oa8+1zjop8/KaEdXojdvGvgV1s
 PJzY6aRmqdySLIq4FU94fDRStUWprG0BoftxWiMLhZg4j/XFXgzAO8sYOh9R8s=
X-Proofpoint-ORIG-GUID: I-L5dSakyfnBoTBO6H_TLoiImEfyRUGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=842 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAAB9tiRxbYj1V7TUYehFZAZNpxizKpHZm0JOQtNsdsosGj3E7ERK5u3qdoFT8+tfzZfwiVZsM7wVJPjVQa4mi+USSO/nlH1bBHAGOHl+Ju8FFpuGUs+DTCjAgYq11BKErytrKD8B/BTJINs8DbwAgwULUDKV91YWsJ1StBuOmCrfg1/x6fkyJgU2/IWwRscO6zAcAlJPXNaX0iRA8SSRQgiUPiiPJaCEWcdL25wKHvhd37N/mMjVhCRl0CumlOGeAjoep+ASRB9Ql0Uj82tpTLhIadJKXKjJyXYnLEm0+nqUCVzvkOSYgXJvdJQAuAkdJQRlSK4DTI7qxp3D9z3Vdo0pSW5cMnU5/oixb4BKTzuONLhMcsb1/a8PEflwVr4hTU7UvYC1xi34RVElIfjmS810KFDOSe5ykp3GHdF+G7qky5GOIN6E0EiVYnyC0aM5CmsZ+FB+kJFGI7rxALL+CVqOjRRuSftgZXfXvZtO3GJzq4qilCXKV3petryG4LU5lCBSbFy6JeINHnmkYPvaQpHUOCZwjgunlSe2Qs/M5hjoFrwlmrJwo1dCjC0+u1jy37JqM4OfXjVVZHyLlCo3jkoGQCp15zuQC/D3Vzi/hZbnN6ZAmga7Op7r5vjfjk6/u90ukr9ckt5b5C+Ebdq8IRWKGu2xLCM6yUz6tPMAWjP2i+mLCEB6tXaeMhgP+wj23LtIxtBVg/JNgAHZTeRFrAB05Rk3Y6Qo3Q0wC5EvzE4Sdo1r+S/umNhhPPwNQwGkFDI5kE=
Received-SPF: pass client-ip=57.103.68.253;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 0183dd8a60..61ba5acce4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1181,6 +1181,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
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


