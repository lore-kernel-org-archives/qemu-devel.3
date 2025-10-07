Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C51CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ELv-0001GS-8s; Tue, 07 Oct 2025 16:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6ELu-0001Fb-AP
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:32:06 -0400
Received: from npq-east2-cluster1-host1-snip4-6.eps.apple.com ([57.103.77.29]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6ELs-0001AK-Ge
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:32:06 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 B60E41801719; Tue,  7 Oct 2025 20:32:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Q1aapM9XKCFqIJhUWzmEK/f+r6L1U4rtPRfzS3K3DFY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gQMN60VFPduiMAbPtn2OH3vakIvtV9EQXVx1C4ScZXL9v0vXvz85dB6Va1AxGfoUQ8jA7fv19OmS3Enh3rILffGFAYTNHzsZzxu5NsDXahb1HsvcY+CNokxa2D9rGXDwZpB8c+bdKLptv0d5+ROcrbbfsdV0JGUukowMmIgL6VBnBuCVp778U67uRyLJofd/LUGYINsbWkBCrd5UCm7joIy2pG2FyGIiOiQ67qtp38XHCHEcf/ozmnOyosTjWc1B8AStdhX6VlOZG9vg1VEEo1YlMhZtLErHjaXPkcvRUroKhWVxRHXG13VNOcbJjcXZqCKA+BP3lmI+tKvPoKtHQg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 77FD918001F1; Tue,  7 Oct 2025 20:31:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v2 2/4] hvf: arm64: add workaround for Apple M4 to run older
 macOS versions
Date: Tue,  7 Oct 2025 22:31:51 +0200
Message-ID: <20251007203153.30136-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007203153.30136-1-mohamed@unpredictable.fr>
References: <20251007203153.30136-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ct5suKJ5wIHbZtE4U-JSPPcZ5WEQGL15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfX22/QAwmFPhPy
 ZPukIq4dI98RkGnZ3UGVTnyzGbNh3IcZ/gbUt2f2gitGwh8LoxgGRs0mAvgBgm1p/QxQmb/66T3
 JQoEOHn+d9lUtxXCIKBFvuGodejOjSXEHMFmWHSYiROnOikgQb7fs7Keo3pziAhZTsXYHcqQ3tj
 a5SLRFq7CejSUh6XO54pCnRihAiW01/2boaLrIIiumY4RLvVIAr3AFZ6oYViau1m2CZv0o5byr5
 Zv+cKqwO3VucBNs5mG9e9YihxA6vY8lFdKOuV6tS3h5aaDycSJG+yuxF9iQFQK8zq41+IFqS8=
X-Proofpoint-GUID: Ct5suKJ5wIHbZtE4U-JSPPcZ5WEQGL15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.77.29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Apple M4 removes FEAT_SSBS. However, older macOS releases
do misbehave in such a configuration and do not boot.

Use private API to trap SCTLR_EL1 accesses through FGT.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-accel-ops.c |  4 +--
 include/system/hvf_int.h  |  4 +++
 target/arm/hvf/hvf.c      | 68 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 8b794c2d41..64d7afc3bf 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -152,8 +152,8 @@ static int hvf_init_vcpu(CPUState *cpu)
     sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
 
 #ifdef __aarch64__
-    r = hv_vcpu_create(&cpu->accel->fd,
-                       (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
+    r = hvf_vcpu_create(&cpu->accel->fd,
+                       (hv_vcpu_exit_t **)&cpu->accel->exit);
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a3b06a3e75..baee11d478 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -111,4 +111,8 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+#ifdef __aarch64__
+hv_return_t hvf_vcpu_create(hv_vcpu_t* vcpu_ptr, hv_vcpu_exit_t ** exit);
+#endif
+
 #endif
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0658a99a2d..f503e1d1b8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -22,6 +22,7 @@
 #include "cpu-sysregs.h"
 
 #include <mach/mach_time.h>
+#include <sys/sysctl.h>
 
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -292,6 +293,8 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+#define SYSREG_SCTLR_EL1      SYSREG(3, 0, 1, 0, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1320,6 +1323,9 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_DBGWCR15_EL1:
         *val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
         return 0;
+    case SYSREG_SCTLR_EL1:
+        *val =  env->cp15.sctlr_el[1] | SCTLR_DSSBS_64;
+        return 0;
     default:
         if (is_id_sysreg(reg)) {
             /* ID system registers read as RES0 */
@@ -1643,6 +1649,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGWCR15_EL1:
         env->cp15.dbgwcr[SYSREG_CRM(reg)] = val;
         return 0;
+    case SYSREG_SCTLR_EL1:
+        env->cp15.sctlr_el[1] = val;
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_SCTLR_EL1, val & ~SCTLR_DSSBS_64));
+        return 0;
     }
 
     cpu_synchronize_state(cpu);
@@ -2244,3 +2254,61 @@ bool hvf_arch_supports_guest_debug(void)
 {
     return true;
 }
+
+/*
+ * Apple M4 removes FEAT_SSBS. However, older macOS releases
+ * do misbehave in such a configuration and do not boot.
+ *
+ * Using private API to trap SCTLR_EL1 accesses through FGT.
+ */
+
+void _hv_vcpu_config_set_fgt_enabled(hv_vcpu_config_t cfg, bool enabled);
+#define HV_CONTROL_FIELD_HFGRTR 0xb
+#define HV_CONTROL_FIELD_HFGWTR 0xc
+hv_return_t _hv_vcpu_get_control_field(hv_vcpu_t vcpu, int field, uint64_t* value);
+hv_return_t _hv_vcpu_set_control_field(hv_vcpu_t vcpu, int field, uint64_t value);
+
+static bool hvf_is_ssbs_implemented(void) {
+    int has_ssbs = -1;
+    size_t has_ssbs_sz = sizeof(has_ssbs);
+    if (sysctlbyname("hw.optional.arm.FEAT_SSBS", &has_ssbs, &has_ssbs_sz, NULL, 0) == -1) {
+        has_ssbs = 0;
+    }
+    return has_ssbs;
+}
+
+hv_return_t hvf_vcpu_create(hv_vcpu_t* vcpu_ptr, hv_vcpu_exit_t ** exit)
+{
+    hv_return_t r;
+    hv_vcpu_t vcpu;
+    uint64_t hfgwtr_el1, hfgrtr_el1;
+
+    hv_vcpu_config_t config;
+    config = hv_vcpu_config_create();
+    if (!hvf_is_ssbs_implemented()) {
+        _hv_vcpu_config_set_fgt_enabled(config, true);
+    }
+
+    r = hv_vcpu_create(&vcpu, (hv_vcpu_exit_t **)exit, config);
+
+    if (hvf_is_ssbs_implemented()) {
+        return r;
+    }
+
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGWTR,&hfgwtr_el1));
+    assert_hvf_ok(_hv_vcpu_set_control_field(vcpu, HV_CONTROL_FIELD_HFGWTR,
+        hfgwtr_el1 | R_HFGWTR_EL2_SCTLR_EL1_MASK));
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGWTR,
+        &hfgwtr_el1));
+
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGRTR,
+        &hfgrtr_el1));
+    assert_hvf_ok(_hv_vcpu_set_control_field(vcpu, HV_CONTROL_FIELD_HFGRTR,
+        hfgrtr_el1 | R_HFGRTR_EL2_SCTLR_EL1_MASK));
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGRTR,
+        &hfgrtr_el1));
+
+    *vcpu_ptr = vcpu;
+
+    return r;
+}
-- 
2.50.1 (Apple Git-155)


