Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4DFF506CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fh-0000zR-9O; Mon, 16 Mar 2026 09:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fe-0000xj-T3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:46 -0400
Received: from p-west1-cluster5-host10-snip4-8.eps.apple.com ([57.103.66.209]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fd-0003ex-5z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:46 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 D7D6A1800356; Mon, 16 Mar 2026 13:07:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666463; x=1776258463;
 bh=Fo1o/cu6r3sIIJlTVFeCxPWsi9b9dqXO1uur361++0o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=LKRJZen0/evik70Pr5PnLOhKHBaPtTye3cmPj0UKbtTPwpelX/6twz92jTkMJVXeMRmltRg9HxEm7Sqao1dvmnoWqFtoMOjcRLXizVRYuKQb/EpyPnnmL5re/L853wBLfhE/7Pom7lB16h5V87A0QBexX5JuWQ0ZTx2brALQJ+4Dj81G5Eb8FX4fwF7Gg2KiSQqbf4/1ss4K4TTFZJtzvb2uHzqliT2sbe1QAGgggc/uhrJaysMJ3bj9FJC5r2jq2INj+bjaAYtKbO9Q5HF7HpucTMk1Ydxs54VPMXYUapB/O6730zqeJbXk7VNntK7siWo8ez3bzvtYzHkUtB3l3Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 106DD1803655; Mon, 16 Mar 2026 13:07:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v20 12/15] hvf: arm: disable SME when nested virt is active
Date: Mon, 16 Mar 2026 14:06:39 +0100
Message-ID: <20260316130642.13246-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d_uOSsh85yQ1Dv4wNvwjLXH5jidNl5Sx
X-Authority-Info-Out: v=2.4 cv=B620EetM c=1 sm=1 tr=0 ts=69b8009f
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=x7Faj_LQiP2RIwM6i0UA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfX9SnJUhrPrFpC
 69PSq+PwjKorRTa7CPn8FzzUWkeDQflrGdLl3hbWk9sE9v5u1UMA/7Ac/BHW5Thkia2qArxlT/d
 3YnzssRQo3/NOhoVqLT2Vz0lxNq1mI73fY50zP1p3Pyb5ykZ6DT33Zuw8AEwMgxG8GRFjc7YioT
 w4bIIbzSZT+3u0fL5vJQUp9ym9lBSeGuJNSRC20u21kdWUm92URR4tCWgCW9+LVtUHgvt9SpIvD
 5UzvVQaAT7qfmNILOI7uPrnQmcr53xNNj1bRcLMEGrsYLx2snJxiKfsr9bU+DNqsc4e22dn8I7t
 Q+/r3B8CQGBB01worfbwur0NzdnDZTQVmPxlVgsqoRmQpY2l329pbbNR/mcICo=
X-Proofpoint-ORIG-GUID: d_uOSsh85yQ1Dv4wNvwjLXH5jidNl5Sx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=907
 phishscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160097
Received-SPF: pass client-ip=57.103.66.209;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 5 +++++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index dc9d3a24ce..88d4732fbf 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1206,6 +1206,11 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
     }
 
+    if (hvf_nested_virt_enabled()) {
+        /* SME is not implemented with nested virt on the Apple side */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
+    }
+
     ahcf->isar = host_isar;
 
     /*
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 8029d48caf..59e19f6e84 100644
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


