Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578C1EF586A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUbP-0000UT-Es; Sun, 15 Feb 2026 00:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbJ-0000Sb-Ud
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:23 -0500
Received: from p-west2-cluster1-host7-snip4-1.eps.apple.com ([57.103.68.84]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbI-0004ve-11
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:21 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 96EC818006A5; Sun, 15 Feb 2026 05:23:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132998; x=1773724998;
 bh=cUFDI02m9bVvoDC8Iny/nXz8SIocy9TmvsXqyyUJ85w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SonolE8pWHQpLNqtgeuRlJTkGI/x4xC4cBADh/FzLYBUrWDTvEzCOTBquqY5iwIQslhgIWD0lQqIY5ZUaOv+kroU+W4q8Crbz5hEC0kqvAmfKCJPIBzlDQh95acZedgTk4I+N5aJLnM1iEroU3erv91tfz4pOxgakRwkz8o3YftrFc0ePoQAbM/wofi8hUT0AGccHD7pz8uI3qx/ouW5xY8CBo3zpQjPV4SrCdmf3faidcqV5uMsJ/oca0LhiNnH+/r2Hg98l2AsKXb+zOnf7vMq6oambp46aLXBKL1yULsuAcpwgnG0K8EZI1Nkcj6fj3RYHEwyr1v9eJ3jQis7Ug==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 221ED180010F; Sun, 15 Feb 2026 05:23:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 13/14] whpx: common, i386, arm: rework state levels
Date: Sun, 15 Feb 2026 06:22:24 +0100
Message-ID: <20260215052225.22513-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=KqVAGGWN c=1 sm=1 tr=0 ts=69915846
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=N0RsYbKkH9eAvmUnK9wA:9
X-Proofpoint-GUID: HJ6jGs436TB3iWWzMxL9K6UYzLtNa1M1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX/mLhCpM5/v3C
 0Vutt/lqqjssPschftdM344Nhvr/Sq56AjaKGnCQ0ag+vAfGFXRgC44ZNna9E4OzfInIUXGn+lI
 i09fMSZm7DhunqvUZ46DFVQHXpvv4XF1Qe0kXVW2ntHhZGJivdL8ksZ6yLQVn7m4gQ+B6NSldqw
 +JidweIxAnpKklVssZBczZn42HCgOmIeecKa8UjwsRlJFLM2EpE5oDaFiK4ghZL5l4AxgxfU2W6
 oQaMHOCzC6tvYO+lcqu7LYRHU9ZbH4S/gDZwc26ubCRxhWNv90X35NL+Fez0Owq9Kejg7VxjSzt
 etzgdQIKfxXb2X3se1i17ALgTaYjxuTJb6H2AaGoDgUU5EL8NwEPxl29jPYIp8=
X-Proofpoint-ORIG-GUID: HJ6jGs436TB3iWWzMxL9K6UYzLtNa1M1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1030 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABiZVb8qEQG92w2xHK6WAaRZyr+KsPz1JcB//68CAyxD1FjljBIO6JiWW/ASoF91oQXMT1h60uW/1BZtrI4Cxtk0DMHB7MoTr8CFQFktnp+SKlk49HbDsginIVSUPKO5i1m1eYSTkwHyBsWBT2gu8+un/UWRa9drGvvAw6uTsSIfrKo4j7+DAgfjvQ3uDaeYkt/G118r2nsTdgpIz9cIDvc0SSXBp/qYIyWyzDtQXb8OQKVxIcCehhD9j/1SqSWBmt3cFk1gTEMFIpVJ99F1HvRTYL03D3VawtXosaX/ZHX8itHj4OELy8D+twYxymmpgpxlw2MKwNUWyepT2ouzxgJDdjj/d1E4MQhxGilZXwacJftQLd11GgRoaJZsyE548XhNyU+tngw/lRcBCa7Yu7ab5/+jI0ezeMD1NbZ47vkwaDrJDNzb4bl8nBGhFEiNnLYocraVL1Pw3sTO6tXL1cu8nPKfOVWz2beBqiX7tbo7CY2n/yroCfOVsrVEPlS0Ezi0+KQLU9OkvIMDUct9qtvQ31JYw6L/iSXS14hLQbhMpoCd436zQhy4QZ80sjwtWjtRjVCgS9HAUWlxVc4kRMOTywwirFZWoN+4uK8qU5W/tZYhxZZnbrvkiL4zNKtNWH6WJtEh+/WlhCDNoGvIWg9X9z/acAko5UHm/Le9SZ5kDYUyQ/A6THm3FUcnlt0AGoZ6G6u+F20ChAp8hpcBhBl3ZalizNb4i4nNumlIbctyoKHzPV6gR5qGRF1079KdTbMamQLqTBYYnF8K3djt8PH1lC7ULtcYjn4PH+shc=
Received-SPF: pass client-ip=57.103.68.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 accel/whpx/whpx-common.c        |  8 ++++----
 include/system/whpx-accel-ops.h | 16 ++++++++++------
 include/system/whpx-all.h       |  6 ++++--
 target/arm/whpx/whpx-all.c      |  8 ++++----
 target/i386/whpx/whpx-all.c     | 16 ++++++++--------
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 245e64a12f..06038dd7f1 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -46,7 +46,7 @@ struct WHPDispatch whp_dispatch;
 void flush_cpu_state(CPUState *cpu)
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
index c8d71a252e..a1be82b878 100644
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
index 0e8fb0e72e..7bbe63e794 100644
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
 
@@ -582,7 +582,7 @@ static void whpx_get_xcrs(CPUState *cpu)
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
 }
 
-void whpx_get_registers(CPUState *cpu)
+void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
@@ -768,10 +768,10 @@ static int emulate_instruction(CPUState *cpu, const uint8_t *insn_bytes, size_t
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
@@ -1587,7 +1587,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
     do {
         if (cpu->vcpu_dirty) {
-            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+            whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
             cpu->vcpu_dirty = false;
         }
 
@@ -1794,7 +1794,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
         }
         case WHvRunVpExitReasonException:
-            whpx_get_registers(cpu);
+            whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
 
             if ((vcpu->exit_ctx.VpException.ExceptionType ==
                  WHvX64ExceptionTypeDebugTrapOrFault) &&
@@ -1826,7 +1826,7 @@ int whpx_vcpu_run(CPUState *cpu)
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


