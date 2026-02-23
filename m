Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DD9EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXK-0006XO-Pc; Mon, 23 Feb 2026 18:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXH-0006Qt-J6
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:19 -0500
Received: from qs-2002d-snip4-4.eps.apple.com ([57.103.87.165]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXF-0004Ob-VQ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:19 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 781BB18000BD; Mon, 23 Feb 2026 23:40:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890017; x=1774482017;
 bh=NHOceMt/DdcT4zjUZf6YyjBJ5RV0Ja9t6DFzHeb/krs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=V9T5NbA4TKZFHkj1l4rtnJAfOGH+eG7C7yA6X+cRUS+8BlulKURZ5gEez/R5OWGoCla+9jW8T7+8F8YfFyUyIqT61U+ZGT4BQKOc74HAFiXLlFgYz0nn6D4GOehw0xVBvwQZTP+seKmmViZn8YbBT8e6UU2RF+ZYw4HKskwJ4ZEy38qPIrNgf/sKxamS1eb2R6K7Pw61vQBeso34UMRmzOu2+DG9FYZOzZR8Wyo4BvqH4ys/KcbPhOg1XbNkGK61esvlWjz0NAT7d6oKPnUGt2QveaqsSeWbRh5n7KtlGZqA4tdcPCusY99TD6lgegVosRw0xgKqxrvBhfu1PeWIzg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 BEB291800169; Mon, 23 Feb 2026 23:40:10 +0000 (UTC)
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
Subject: [PATCH v6 09/28] whpx: move whpx_get_reg/whpx_set_reg to generic code
Date: Tue, 24 Feb 2026 00:39:31 +0100
Message-ID: <20260223233950.96076-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ZuXg6t7G c=1 sm=1 tr=0 ts=699ce55f
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=pUA6uon7y9DqcPPp1uEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfXzML3UFTyvrAt
 7SscKNyQaTC3nUdETYKJq9d7+cOsUgKkE5idN13ZnJTSDXSpQrl17amwKJB3oS6QoZorBblACV7
 EpuQorm4O9OFzmtwQq5gG4BQusv3XS9ltL+xTEWg3+t+OgMWG+uPjQObUrFFl2GXR9D/6XCIZkh
 Z2XG6nQ3Sz8GSTcMan0hcsyovU9SM9EkZykKVLdG5bIvoWEMG4OsFz0S+bHJMUTCJzkWg0oRVVM
 VzQTXjhxYB3Rq8isFbdRC54TWbOo46TwM2hYauvKgIRRHB7Vqe2B1D16/wcR+Awi0btHHO0czwb
 K3w367azG+3NbNAgjIWWRys4iA96AxlSLi7/fpE4dwcw4l+bpUqJlAiB2WHNqg=
X-Proofpoint-ORIG-GUID: G7xY7Ic_TaXAJl2gnA0MwqFQnc_cPfZL
X-Proofpoint-GUID: G7xY7Ic_TaXAJl2gnA0MwqFQnc_cPfZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 clxscore=1030 bulkscore=0 adultscore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABzCXQY2SfsB+mtUfE+o0LWURuKdSELlU71lBhrla9sntYc27aF3nu2BABdSnH+20o1m6PRC3loxRyAuukfXJpkI8UPpLhfoweniCnkcCdPhLQPQCRrxr/PuaG0c1q1UHVLdx4x4t5oSbU4TKekndhmqFKOxoKKJwCa8taCvQR0Z6Dkp+//Tk3pt2mFlyF4rMRgI3Bv2/ceTRTxXeNjVHedwvUM2Xur0QX7BRgLV2DwjWQeokLq0mSddcQAhU4XWO1RBxISgxO4QmvmVjnxKpL2gAFjXh4/q2EerxqexxJYOF5vWPaZRXtFpgl1hIU3gRUeJ7aoSL/2XST5KVJMUqVSvbJ5A4iGV1j01o1K7MLdCPwohb7k5I26WkLMOwXLheLGNjvtqACBsqlPpu2GQu6I5Y8znb0X1Ly4qBvO0C+vtvNsBQ99wXTuM7KQ4MHTpUGSEmu1/Iesj8LcP+XiVFkiPI8vod+iEWLkZhs0pz4kvWlHKKX6qpRdM5Q9QgFrfJxRUzihf5yOCQ8AoM5KSyzqvdl4BQ+KevPYMCtDm+LRo0CALJDi0ZSHcxuNA6MH1D86unb0TW4Koh0yy7IRJ1wPZl/mHqMZR+dPprD66/ksRvA6oXLSV1enqYyRAGLVXLKPq6JX7PCTlVKiSkiqVLw7UAe10uX5np6tcr23kpoamXrpa1bmBNje6OOwBc4/eSd8x6ooRMgQGEK8X6dM/vZw/6suQWRcVuTkFIO0OCqf0sqnC19nfnritFDFXtEVx4sv0mj5dAGSI+k
Received-SPF: pass client-ip=57.103.87.165;
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

These will be used in the next commit on the x86_64 backend too.
Also move flush_cpu_state as it's used by get_reg/set_reg and the arm64 code.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 accel/whpx/whpx-common.c     | 35 ++++++++++++++++++++++++++++++++++
 include/system/whpx-common.h |  3 +++
 target/arm/whpx/whpx-all.c   | 37 +-----------------------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c57a0d3f0f..21e9f1a178 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -46,6 +46,41 @@ static HMODULE hWinHvEmulation;
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
 
+void whpx_flush_cpu_state(CPUState *cpu)
+{
+    if (cpu->vcpu_dirty) {
+        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+        cpu->vcpu_dirty = false;
+    }
+}
+
+void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+
+    whpx_flush_cpu_state(cpu);
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
+         &reg, 1, val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
+    }
+}
+
+void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
+         &reg, 1, &val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
+    }
+}
+
 /* Tries to find a breakpoint at the specified address. */
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address)
 {
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index b86fe9db6e..a4e16e1309 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,6 +20,9 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+void whpx_flush_cpu_state(CPUState *cpu);
+void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val);
+void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val);
 
 /* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
 #define WHPX_INTERCEPT_DEBUG_TRAPS 1
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index d52580a082..9a9a19c196 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -274,14 +274,6 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
     { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
 };
 
-static void flush_cpu_state(CPUState *cpu)
-{
-    if (cpu->vcpu_dirty) {
-        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
-        cpu->vcpu_dirty = false;
-    }
-}
-
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
 {
     if (exceptions != 0) {
@@ -314,33 +306,6 @@ void whpx_arch_destroy_vcpu(CPUState *cpu)
     /* currently empty on Arm */
 }
 
-static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
-{
-    struct whpx_state *whpx = &whpx_global;
-    HRESULT hr;
-
-    flush_cpu_state(cpu);
-
-    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-         &reg, 1, val);
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
-    }
-}
-
-static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
-{
-    struct whpx_state *whpx = &whpx_global;
-    HRESULT hr;
-    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-         &reg, 1, &val);
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
-    }
-}
-
 static void whpx_get_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE *val)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -527,7 +492,7 @@ int whpx_vcpu_run(CPUState *cpu)
         if (advance_pc) {
             WHV_REGISTER_VALUE pc;
 
-            flush_cpu_state(cpu);
+            whpx_flush_cpu_state(cpu);
             pc.Reg64 = vcpu->exit_ctx.MemoryAccess.Header.Pc + 4;
             whpx_set_reg(cpu, WHvArm64RegisterPc, pc);
         }
-- 
2.50.1 (Apple Git-155)


