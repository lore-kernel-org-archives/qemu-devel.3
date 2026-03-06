Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F127FF0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQc7-0008VE-M6; Fri, 06 Mar 2026 03:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbQ-0007OC-0r
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:08 -0500
Received: from p-west2-cluster4-host11-snip4-2.eps.apple.com ([57.103.69.133]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbN-0002Ys-HR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:07 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 A403C18003F2; Fri,  6 Mar 2026 08:32:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785923; x=1775377923;
 bh=vM1Wlorf+XqQlJ5f9IMCqYNj/5ImA32mrulRYej01YM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZVzU+68lGPgZeBPbDKgYkdkSkBPiZbSExf/cf99MWQ+4xHYP+AItQlePZS9JwPoFm7CRRMQHnJcGcrQprJFB3+shZ4/ftqkWBBTpvlWmYAxl1glKJIVy/xwRFvavJLwKEGMBkk+2wgc50d/JbhOXwlYBumfv5dWT7vGutRPZ9FkJeRMSyBx+f8wm6JbIk+du7zmMhbWRRm+SMnEeRk3B6yvT4cuxjhtMty3VzDSLfATyqw5TOujLShcbWL+8z9y1jux4oIcLGkwnE481q6pJRmIjy0wh4HAN6LUnOixal5QI7z0JW9BSp1Fkcc75DMRAZHCxq3fNGy0GYFr68Ip16Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 371F618000B2; Fri,  6 Mar 2026 08:32:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 17/19] hvf: arm: SME2 availability fixes
Date: Fri,  6 Mar 2026 09:31:11 +0100
Message-ID: <20260306083113.74177-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: doH_i0faB3QtCxgUxB8e5HMKi0iOX9Lv
X-Authority-Info-Out: v=2.4 cv=RKu+3oi+ c=1 sm=1 tr=0 ts=69aa9103
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Iy1shTv_HyS0e-kpLPMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX0n9kjujcJPFb
 c+uM8Zi9zlrvEZXhNIivKKCe6gTxTmcVWm2iKpAiC0ndGEfT946E9/ucgDff85vPfiKQ24BS3IW
 mI0lhVom5vi8u3yBulDN3JlcDFQLIeNqVXz3TC+9vUDea1uVvZtngGxqUVkapFLwlrp4ZtXU0rA
 CSBt8pK7GPH9gfn6JTRCEn7LLM4penpmScJGP0eW+aR46qLJsDrXxLokixS7uTnwhB8uW5yKYit
 yaBhQF2xPCC+VMKQ5GhWkqKM57j6bZ5KHHw2+YQOUWs0U2wmAnw10mke34/36fRdGX9H2XN3urZ
 uu7Qyfu9BoPalOH9o6QJm2RlGn0TENsvsOh099S8JG2FoLexjyEzIE8AXGhHac=
X-Proofpoint-GUID: doH_i0faB3QtCxgUxB8e5HMKi0iOX9Lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=825 clxscore=1030 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAAB4mU0zgdvCl1scc7B7/CY7oOZ/FgiSzT1fIObG9i8J83RjEH+G3dlKdOIzubAt/OBOhdHOzETs6CnPEw+kccUf+ZKF/QrMsv2RLc6mhbSrjbvsb4ti7D4ZLtQvXXM3vvCapTeO9lAJ7W2is3pCREOZHJo47ZC6GcsZYlfNS8U4GD3HMoMjGwtK75TVZOZlw952c6ZNvnnZbR8IuobszC4ARQRhptbNNOc9IJNX50lNIgeRdZNYVdHq520qF/7Fw0g1iCVQFc3BL2SnFLr2VnIMB5kWy5PKhKJZCwANGg4hggL5QbBJLQ6nUn3FeIzJqnZgC2vgz71OdtvonuhZ7UdGQOE8R77NEv4CURYKjKp2uO9+Wv2y6L0LV8kOYMhPxCa2xgvc3bV9gENz/ySRF7GtOGdkLEGe/jLe+xuuE7imbyzb304AhJ+uR69gTqZfPTUC92IYXufoFs4RbDHkiW3HGmb6yTkr2VZOKEO+NpMqhojXvqM8Fit2/93a8ptjBvbyhdBDFYO0TJa9uqhksAxpjeCQHly8ist4JJmgWM/rzar8HEtJOqsuw2ZI5Q5Y9SEG78fVQUWMJG7xYB6BBM6/C/CX9l/Gy+LiWE17wM4R4G7NfWY93lJe/3yE0pbDpWqbK8YpsoWdrFx5xsptMdB4K84XRmBxTx/o5rZEkkGZxO9K8o25wiIQvpsa6zeOSoi8UgARt/vegwQ5sNp+GwweCyaXD6kvsWprvCtR8KUQ2RRVOMuSrgcRkFjlg0N
Received-SPF: pass client-ip=57.103.69.133;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Not sync the SME sysregs if SME2 is not available.
Disable SME when nested virt is on.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 29 +++++++++++++++++++----------
 target/arm/hvf_arm.h |  5 +++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8d1333cbb4..cb05db2358 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1163,6 +1163,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     if (hvf_nested_virt_enabled()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+        /* SME is not implemented with nested virt on the Apple side */
+        SET_IDREG(&host_isar, ID_AA64PFR1,
+              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
     }
 
     ahcf->isar = host_isar;
@@ -1370,16 +1373,22 @@ int hvf_arch_init_vcpu(CPUState *cpu)
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
-    if (__builtin_available(macOS 15.2, *)) {
-        for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
-            hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
-            uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-            uint32_t key = kvm_to_cpreg_id(kvm_id);
-            const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
-
-            if (ri) {
-                assert(!(ri->type & ARM_CP_NO_RAW));
-                arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
+    if (hvf_arm_sme2_supported()) {
+        /*
+         * Clang doesn't allow us to combine the two checks together.
+         * -Wunsupported-availability-guard
+         */
+        if (__builtin_available(macOS 15.2, *)) {
+            for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
+                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
+                uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
+                uint32_t key = kvm_to_cpreg_id(kvm_id);
+                const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+
+                if (ri) {
+                    assert(!(ri->type & ARM_CP_NO_RAW));
+                    arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
+                }
             }
         }
         /*
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


