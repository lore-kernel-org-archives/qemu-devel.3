Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408F6C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEE4-00082z-9T; Fri, 25 Jul 2025 04:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEE0-0007uw-Ow
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:20 -0400
Received: from p-west3-cluster2-host4-snip4-7.eps.apple.com ([57.103.74.80]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDy-0001xn-Ho
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:20 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id
 51F1C1800215; Fri, 25 Jul 2025 08:56:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=o7HSavF17IoPSUVxM9m4KStfJoakR87pLkUftbbgFiA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=SPao8+kL4zdgApKkwJ9Gbb9kojM3Da773smQsSLMm4buU3457DWzJRFpfGdhwNWKGlmkSkKo9/YIJLOP9Pv5QEj9Usq4PqJSKb9fu3XwVeIEhEOhhPOwTd/EkvEoWnBWPXf6Xp7QyNjyHtmqLVUM0TV92lJ69kWxdD4BcSKB+R5o0qTQsqn7AZJCcYXHEdKpYBL5rX5hzffsJkEgqYhB+f7YhkSNftFqM78DQlve6p+Uqa3JtH9cASvWEDANGkaQdwQiDfR0NL/oL1GccJjjyyAo37jEsjYypIdf4R/Il2xBVme/hRRc7JB39RruNU7ZCCuG+KqOy1pMQF52P/MkUA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id
 75AA11800223; Fri, 25 Jul 2025 08:56:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 7/9] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Fri, 25 Jul 2025 10:55:43 +0200
Message-Id: <20250725085545.93619-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725085545.93619-1-mohamed@unpredictable.fr>
References: <20250725085545.93619-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: un0dC8_aLvOIuQJJwKDuoFe87U3-H9po
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NSBTYWx0ZWRfXyVLOUf4AYxDv
 AcYg00DemeqTQzVVNDtacI8fMxVP6J+6azhOlYTEHFYP2dQbzcjxnHYTYNJh0Syb4aZIUN+82Jr
 J7uda7B/zFzHimC1FXxHXFqOikk9ugNzLC0+fEbv52LjVUCUozE0kQEJyMD9RJ2MLYyU3UlDlAh
 zZKsIBsOStJ5NxtprQdDM+qtNrILTkAfbUccxk3TpRFElXVOh4yMRduUI7D/nY+y0kc2X+rrwSq
 rUz6C9+pUjRWIqpgINYn9ncbkqfQunSTdHo9kxU9yznp+Z/LtR2CMrNBjavVvGqMtbgfDGqQ8=
X-Proofpoint-ORIG-GUID: un0dC8_aLvOIuQJJwKDuoFe87U3-H9po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=770 phishscore=0 spamscore=0 malwarescore=0 clxscore=1030
 bulkscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250075
Received-SPF: pass client-ip=57.103.74.80;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

HVF traps accesses to CNTHCTL_EL2. For nested guests, HVF traps accesses to MDCCINT_EL1.
Pass through those accesses to the Hypervisor.framework library.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c32e6ab289..5344e23db1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -21,6 +21,7 @@
 #include "cpregs.h"
 #include "cpu-sysregs.h"
 
+#include <Hypervisor/hv_vcpu_types.h>
 #include <mach/mach_time.h>
 
 #include "system/address-spaces.h"
@@ -296,6 +297,10 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+/* EL2 registers */
+#define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
+#define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1388,6 +1393,12 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1704,6 +1715,12 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_LORC_EL1:
         /* Dummy register */
         return 0;
-- 
2.39.5 (Apple Git-154)


