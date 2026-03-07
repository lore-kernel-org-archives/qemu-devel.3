Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F329FFCB638
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdw-0001T1-EG; Sat, 07 Mar 2026 10:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdm-0001LR-BO
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:30 -0500
Received: from p-west2-cluster3-host4-snip4-10.eps.apple.com ([57.103.69.23]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdj-0000Ql-8l
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:30 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 EE91C180086F; Sat,  7 Mar 2026 15:32:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897538; x=1775489538;
 bh=gfksJpvAASccthB/ms7ldAjBWoy8cAlKd436IVgnRWI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AJAQyrqMPYJns5f/fatB5LNUKa7jn/G0KyaCX/hqMC+4K4Uw8f/AqCkIhb+yguuyrXVqnyNcluFrYE510HpsexWib55aW2aE/b298z5GkUr9UhHYAXD1YZNRM8HsJrlVSPZvJuc71MZqaVasVxBvuKE9yGZ+7q1ihwd+zRRZZBAlxPo3Q23yoQY4SN/XzT+sLVuiomkjJULuwZr9Ilhk8r5PQ8WQVol7y6L8BNny1I1UkMl16uzsyDItSkBJ1Xlfai8K7UWrA5Qdyb2cPZTbWe6tLXpBLkfpS/Qz4kdtBgsHgcHjzEeUczgm8Z7DKE60+xza84WnK1AtDR+isrgF3g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 71CEF18022C0; Sat,  7 Mar 2026 15:32:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 12/13] hvf: arm: disable SME when nested virt is active
Date: Sat,  7 Mar 2026 16:31:42 +0100
Message-ID: <20260307153143.76893-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RY4o8SFFGHNqtPvcBJPDfdNmy4CJ1i0k
X-Authority-Info-Out: v=2.4 cv=KaffcAYD c=1 sm=1 tr=0 ts=69ac4501
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h9724yil-ocX87RSi0QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfX4poVBfFDeNjE
 akLWK8VghB0U5JvNsznpioCjMLd+m6jZA0a/zT+AwbszXJGxUAeeni1HlzQImLwstYbePkJfyef
 +zW4eLe2QVxRglCK1WYVrS8rdx6QaHSDe7n2Q+765Y9p4OAxEK5dByby3IM4mSyglCQDnjD5OUw
 rVjb0iEtaERWALyPUfOyPCtRm2xi06EdLqE+Lb7oEsX9pKj0k9d9s+bkF46dJKO27sHT6F37FNd
 tSvnmQ8gFJdbt8b5l9mZV2CDlUNu9Lif8lZWvd5cQLwkBB3qOcollnWfGCmR+wVRhK7D96SizFq
 Pw2OtwgPynILnOFkB3Zkv65Z+9nEvqC9sjtS1ci02cvDlK1uw+hnY4iT6FvzBU=
X-Proofpoint-ORIG-GUID: RY4o8SFFGHNqtPvcBJPDfdNmy4CJ1i0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=756
 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1030 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABTXaYoTlrNPf7G/RcUJsS1Joa8UGoA0q19ni3xFFa+DCvjQB8y+b4GwTZmGHGblMbsMudVKXLzx0Q9moc3pMdHsFNI3/WsaogTj8lAegjViYvO0Tvw/M60Z1KMI4ciQq1C7GXPNDRNCrF+bD8zPyLPy4KZQtlA5kzvjzXBQ0B531DoluPDx83QfPSHrPuz9m1PIQRQv2y8Pe7D7THhGvzkXwt4Oasqa8uDjtqF2PhS6RbMXnTP4pwnczYU9D2HB0SxoBAhNdrjzKmKBsagLFZAfd8P2Ab4gxj9ykXoqrBr4qPlMyl1CHNdkQwUEvD2J1+IV6u8gKXHRgswch3DUjlJNx0kZowszjjhx6mShbKOSbRxAkBz2Fbmyv9/9diibsKrKlANrEJ5ZKM0suY/rW4kWp1s5lAQsC88URDAC4KMJGk512es7UOEm5halOvF3rj9cPQ7miWwnEBHzaZb8jQknSt+U3TLTvM55z/fREHilK+/LUljvx5TIifRo0Sj3c5p/A5h5tCzT5U4XV7n9ilOLzf7CO/ltFbFNpyxDhyNdy+TGK0gTRveGcLbK8klPjxZK8SCxLTgFVV02aUgL8c+9Vm2Sn1vFW7E/mQGNLoEZUgatTWMK05JqAl3i2hvgHbrY8/HUWYEhfcVsXqcf+Eg1ClFs12ChUlCDosUk3hyWmzhq/8FFDUmYzMhuZVLIIOw+s5TuNJQXANVb+POZ61NSr9PUVCXATo2eskMS0=
Received-SPF: pass client-ip=57.103.69.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
 target/arm/hvf/hvf.c | 2 ++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 03b174a8d4..8aa59a1f77 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1189,6 +1189,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     if (hvf_nested_virt_enabled()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+        /* SME is not implemented with nested virt on the Apple side */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
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


