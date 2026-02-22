Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C666BC636B6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnd-0000LY-Fo; Sun, 22 Feb 2026 13:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnc-0000Hh-9s
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:20 -0500
Received: from qs-2007c-snip4-4.eps.apple.com ([57.103.84.155]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDna-0000Wo-Gq
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:20 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 E801218004FB; Sun, 22 Feb 2026 18:03:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783397; x=1774375397;
 bh=tErMiEuDLXt0dMED3y+T60xeOyEgc7UicdCqP1DD7/0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Op3K2jEKPjFho1dQ7anuF1levuYMOqETfmGLNF7w3jyWim31ACmWsgK3sy4pACnHkEsWBWe0t8yarxtNP3dGqjP0XiUY45dE/33vdfHGJutV+nfjYYvQyrNNwSlEyNAktqVlOinc97L2bA1styoQnTQ9IIZiw6Nqdf6c1qyx1P8jrxhBarowGoUXxpsnsmld6iL/3I/fYJYbj9NUVIcgkHxS2evjehOgO+6iGILF4Fes1EbXnBVshYhoRyUaXpsYG2fU+Db1J2vkZTv7zM2fdLgyaz6aTIANldDgewcKKgHNKYlvA6tBg0NNHHDkPesyRVOUMx5MyibTCE2I+62E5A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 85B411800123; Sun, 22 Feb 2026 18:03:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 15/16] whpx: common, i386, arm: rework state levels
Date: Sun, 22 Feb 2026 19:02:39 +0100
Message-ID: <20260222180241.14621-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: I9P_eX_a5BMnri4qMHkJga_E33NOfwG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX1ISfOjkXk6jf
 vw861KeaAiTq+kKRsbGBznhYj8Me9YHR8rmzlW1OQnqfnaAQt/+CGbPQZGsHvbj9liaj6fq4lWB
 28wVpmKT7RckQAFbVtuekR2RQxYjqkto6izutJDtN6amBRSKVOEy0QfKng7mW4oqQow5KTSU1A0
 7YcOpv0+HoKeI6oBJ9H5AP7tCq4PoZRBGKAUJP0uGaixSR118qb5NE5zm3Z4wEvRdh6HNpETxm7
 TrxoJFJlLjkc+0TTZUZAUlXVt+tr7P6O60l9v2G4tNJwfo24fWbu/DNr3BuhugxBknvZh5j9Xqj
 TsxXKBlqO5qwio5LC7sh1xT+2/A0imhBI4ci+etz+9IT+cxwJcPUpPQmCMSE9Y=
X-Authority-Info-Out: v=2.4 cv=AN8t5o3d c=1 sm=1 tr=0 ts=699b44e5
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=N0RsYbKkH9eAvmUnK9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: I9P_eX_a5BMnri4qMHkJga_E33NOfwG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABUztvXO0nq/M6+hP+bVmwCiMAQ0v+LuH4lOkWqvpvTgjoTE+CYnD6V2OT9JWRtIyfyW+UmPocROTmhJpG8CBw/wmhV/cAQCwQB+DovIKu5MBjqG1LkZnXzdZsV26VT0+vdXWKBSwOOiwcYiLkexrd44dTPihTCoOHQV4O5j2W3+SySS74Vi5gX0Y8C8PSO3Dv05QMZZSlkTzkkwSi5jj4lSFiH6VMEFGnFCYHfM0XZ4dahif17lThLZOG51UR18AamGRKQ0PhjplgSndo/Vfj+w/dEZXuWZpw8yumEaX+mtjC4BCWhZUwU/GaaVf7D06hR/m/UJKfOJxwTnfEJueKYtpMDJqG7d9kvAKJN9RsQJzwAjFYtZcght/yw+U57EA4kBlsGrt0x4XqvXlDwcDNbsbi6A/XnBBEBfAENxwzUsvFbcgVULusj9JEnfiraMyO3OXrvZ/t4yxA0Lm7JWTfdPEmJRsGpev7pJJwnGmwdc/qTZXv8i9SOnVma6oGzj8BCiAFMvXE2SMz5JKToINDwGDeRpvVHwtQeJ7ZaNEk2yakjbIsEpysyzVW4xxLgwtkMQuJhJL90wH99gSul4kOYhhDKmWi4qSISrqTBbiQY9e1JZURPx+gqLUc5x0S8CyTZJpuucApfPdi7hnL+6QZjK86Q37saR3ve13G+1nIdqD59vQqtGzKDrBlmIxmz0OkCkUTXSiWI/OnJs+8BAOm6lh8xs6lIjsCd3Czes011PPOYRe2RgQMnYL0XcmNWtuAA9n3uv8AxG/8qIiXBWBVkqC9FbQv
Received-SPF: pass client-ip=57.103.84.155;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

Change state levels from a set of ifdefs to an enum.
Make register state loads use state levels too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/whpx/whpx-common.c        |  8 ++++----
 include/system/whpx-accel-ops.h | 16 ++++++++++------
 include/system/whpx-all.h       |  6 ++++--
 target/arm/whpx/whpx-all.c      |  8 ++++----
 target/i386/whpx/whpx-all.c     | 16 ++++++++--------
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 88eef55799..4863fc8663 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -46,7 +46,7 @@ struct WHPDispatch whp_dispatch;
 void whpx_flush_cpu_state(CPUState *cpu)
 {
     if (cpu->vcpu_dirty) {
-        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+        whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
         cpu->vcpu_dirty = false;
     }
 }
@@ -180,7 +180,7 @@ int whpx_last_vcpu_stopping(CPUState *cpu)
 static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-        whpx_get_registers(cpu);
+        whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
         cpu->vcpu_dirty = true;
     }
 }
@@ -188,14 +188,14 @@ static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
+    whpx_set_registers(cpu, WHPX_LEVEL_RESET_STATE);
     cpu->vcpu_dirty = false;
 }
 
 static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
+    whpx_set_registers(cpu, WHPX_LEVEL_FULL_STATE);
     cpu->vcpu_dirty = false;
 }
 
diff --git a/include/system/whpx-accel-ops.h b/include/system/whpx-accel-ops.h
index ed9d4c49f4..4b2a732654 100644
--- a/include/system/whpx-accel-ops.h
+++ b/include/system/whpx-accel-ops.h
@@ -22,11 +22,15 @@ void whpx_cpu_synchronize_post_reset(CPUState *cpu);
 void whpx_cpu_synchronize_post_init(CPUState *cpu);
 void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
 
-/* state subset only touched by the VCPU itself during runtime */
-#define WHPX_SET_RUNTIME_STATE   1
-/* state subset modified during VCPU reset */
-#define WHPX_SET_RESET_STATE     2
-/* full state set, modified during initialization or on vmload */
-#define WHPX_SET_FULL_STATE      3
+typedef enum WHPXStateLevel {
+    /* subset of runtime state for faster returns from vmexit */
+    WHPX_LEVEL_FAST_RUNTIME_STATE,
+    /* state subset only touched by the VCPU itself during runtime */
+    WHPX_LEVEL_RUNTIME_STATE,
+    /* state subset modified during VCPU reset */
+    WHPX_LEVEL_RESET_STATE,
+    /* full state set, modified during initialization or on vmload */
+    WHPX_LEVEL_FULL_STATE
+} WHPXStateLevel;
 
 #endif /* TARGET_I386_WHPX_ACCEL_OPS_H */
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index b831c463b0..2cbea71b14 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -2,10 +2,12 @@
 #ifndef SYSTEM_WHPX_ALL_H
 #define SYSTEM_WHPX_ALL_H
 
+#include "system/whpx-accel-ops.h"
+
 /* Called by whpx-common */
 int whpx_vcpu_run(CPUState *cpu);
-void whpx_get_registers(CPUState *cpu);
-void whpx_set_registers(CPUState *cpu, int level);
+void whpx_get_registers(CPUState *cpu, WHPXStateLevel level);
+void whpx_set_registers(CPUState *cpu, WHPXStateLevel level);
 int whpx_accel_init(AccelState *as, MachineState *ms);
 void whpx_cpu_instance_init(CPUState *cs);
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions);
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 9a9a19c196..a4d54b027f 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -418,7 +418,7 @@ int whpx_vcpu_run(CPUState *cpu)
     do {
         bool advance_pc = false;
         if (cpu->vcpu_dirty) {
-            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+            whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
             cpu->vcpu_dirty = false;
         }
 
@@ -483,7 +483,7 @@ int whpx_vcpu_run(CPUState *cpu)
         default:
             error_report("WHPX: Unexpected VP exit code 0x%08x",
                          vcpu->exit_ctx.ExitReason);
-            whpx_get_registers(cpu);
+            whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
             qemu_system_guest_panicked(cpu_get_crash_info(cpu));
             bql_unlock();
@@ -517,7 +517,7 @@ static void clean_whv_register_value(WHV_REGISTER_VALUE *val)
     memset(val, 0, sizeof(WHV_REGISTER_VALUE));
 }
 
-void whpx_get_registers(CPUState *cpu)
+void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -564,7 +564,7 @@ void whpx_get_registers(CPUState *cpu)
     aarch64_restore_sp(env, arm_current_el(env));
 }
 
-void whpx_set_registers(CPUState *cpu, int level)
+void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index baa3169c55..c09d9affef 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -367,7 +367,7 @@ static uint64_t whpx_cr8_to_apic_tpr(uint64_t cr8)
     return cr8 << 4;
 }
 
-void whpx_set_registers(CPUState *cpu, int level)
+void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
@@ -386,7 +386,7 @@ void whpx_set_registers(CPUState *cpu, int level)
      * Following MSRs have side effects on the guest or are too heavy for
      * runtime. Limit them to full state update.
      */
-    if (level >= WHPX_SET_RESET_STATE) {
+    if (level >= WHPX_LEVEL_RESET_STATE) {
         whpx_set_tsc(cpu);
     }
 
@@ -583,7 +583,7 @@ static void whpx_get_xcrs(CPUState *cpu)
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
 }
 
-void whpx_get_registers(CPUState *cpu)
+void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
@@ -770,10 +770,10 @@ static int emulate_instruction(CPUState *cpu, const uint8_t *insn_bytes, size_t
     struct x86_decode decode = { 0 };
     x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-    whpx_get_registers(cpu);
+    whpx_get_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
-    whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+    whpx_set_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
 
     return 0;
 }
@@ -1589,7 +1589,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
     do {
         if (cpu->vcpu_dirty) {
-            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+            whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
             cpu->vcpu_dirty = false;
         }
 
@@ -1796,7 +1796,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
         }
         case WHvRunVpExitReasonException:
-            whpx_get_registers(cpu);
+            whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
 
             if ((vcpu->exit_ctx.VpException.ExceptionType ==
                  WHvX64ExceptionTypeDebugTrapOrFault) &&
@@ -1828,7 +1828,7 @@ int whpx_vcpu_run(CPUState *cpu)
         default:
             error_report("WHPX: Unexpected VP exit code %d",
                          vcpu->exit_ctx.ExitReason);
-            whpx_get_registers(cpu);
+            whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
             qemu_system_guest_panicked(cpu_get_crash_info(cpu));
             bql_unlock();
-- 
2.50.1 (Apple Git-155)


