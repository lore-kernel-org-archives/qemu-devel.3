Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6037EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXV-0006wp-Bo; Mon, 23 Feb 2026 18:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXT-0006w8-CD
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:31 -0500
Received: from qs-2002i-snip4-6.eps.apple.com ([57.103.87.217]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXR-0004Qu-Id
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:31 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 53345180010D; Mon, 23 Feb 2026 23:40:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890029; x=1774482029;
 bh=tErMiEuDLXt0dMED3y+T60xeOyEgc7UicdCqP1DD7/0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=CMiKQauZA1x+SK1kdmxSrE4+qqWQhXGztOd/cpOCq9KjvG9TcJ7QS5d/+Coy72Ct+3/LQxPMPLzeCXC8ws0TxeF26BBrz0UdodbzNSmNyWtQUaqJdhk7NP9CBvc/1llebz6jFTGQ8wylUOg+Tg7UasuCXii0UdpRWhyCnOrG/4REFRfauoil+FVSAwNSuvoUJujs5ZK8VywkXD9RZ6WOhHVpJnDQcnJv2JmV6L9FYaJ/U25ReDoAUR7trZ0clTUQKQEaXg3iPPBNmUFkz08/Y/+wpirHoDRG+8V/qUctSbhlmL1Owm+pBBsdXZZd2/B2xD14e/+T5QylcJUuxFT2/g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 7B12318003AE; Mon, 23 Feb 2026 23:40:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 15/28] whpx: common, i386, arm: rework state levels
Date: Tue, 24 Feb 2026 00:39:37 +0100
Message-ID: <20260223233950.96076-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX0BmSDO/avJMf
 akjPdNOBEsijPSZ6iunMEqTzA+RYMJ9L8vnW41BKwx2Oe88YLz9MLBDb5ql6OFA9xEP8tmUCej2
 73mcBC3SzZhScalDvzDfIw1Pb/MQAXQV25aQZyAKyaED68Wu+3t8cQP4rJxnzEMpdPF1T+rPk56
 23tAfNYJ3syUXUF4D/6D5sBQ6TtW2OJEuv2qNfWvpU61N99aaFwTvONh8iXphUhaTuTF3aACvz1
 J7xgAgCecoqWGbRdBMKm90STctuDp/NzKENSYcx9Wj5kv796c4WH7rOhtI5KWYCwsLF+rx6P+Y9
 1VhXxe0eqW9n3TYLqUT+CE0J57qBMTra8oib5ULFk7MgNyypm5CobQV5ej7MUI=
X-Proofpoint-GUID: cEpz0EnJBBILq8oG7Ubcnr2G9BqKszF8
X-Authority-Info-Out: v=2.4 cv=C/PkCAP+ c=1 sm=1 tr=0 ts=699ce56b
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=N0RsYbKkH9eAvmUnK9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cEpz0EnJBBILq8oG7Ubcnr2G9BqKszF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABSTk8mWwGNw6v4okc3k9lmwJ5aeYVyiRH/Ll3IH39ZQYpndN9n7HnZfnl9Q0q4Us55y+KezKVxpQFg9hRFYjqRKYFMzI1ZURCrl6sCk0OIw879neyIsaUIuXQRbFDIDWa6tKn8ACW3gFpKlIIMtts9Z6f1t4UIydEwze/3kOvL+MT5AFuTHvzSx4qwma1WFFGuTs90rf6ke7snk6voMJHvTziIfaBnGf2zmykXUjuXU52NBEYIW5VvvIF5mDzaSlaTbMBLwOBs6y6vunjSJsUq23i2a7kYP5XZa2SOQZHPv00EI/6TOxzi8PJAt8cIQuOj+6iCvhHS5iF7Ca8Et+I7escKczIvR8fq289tU5d7/v0aruEhj90qocetozPBapIIHBaq7DnRMesS9+auT/hpiGVWxud1tHQJKwaFR3UFhGkJkP9W7iWrViVXbyFfN1Sp3k/fmBHDKd5YnWoY1oreCUQfCiKGhEvQOEmzWkC9CD/nepvF84pnKcsfECP+rwBZsVsLHdz0usIYvrI0cbXyz8zDUc5+6CbtQZ+7q8vT3VfmoTrEDV+KejOb40T+/q4KqReXDQDoqexdxQAdv0BUbHBjC7Tzw65BC5UtFLU3+A3Vv/IRztCpvO57JP0RIRT9rgFmw+Ca4j/cfd5JwgcrbOrJ7lSYJh4KUW2gywC6nrbX3j/PD5qiEf5/wXiViE279by4qeMOHGnViodFTBxjxQ0D0IV5d3PvyJ0aIedWNk1atjVAESWc7wg9YIPLi6lVYTMMxbYIs8RaWH/jYv5
Received-SPF: pass client-ip=57.103.87.217;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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


