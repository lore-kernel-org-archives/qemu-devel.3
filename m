Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9596E98E0A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSS-0000T9-OJ; Mon, 23 Feb 2026 03:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSB-0000GQ-PE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:10 -0500
Received: from p-east2-cluster3-host2-snip4-1.eps.apple.com ([57.103.77.222]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRS9-0002E1-3N
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:07 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 0A3981800204; Mon, 23 Feb 2026 08:38:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835884; x=1774427884;
 bh=NHOceMt/DdcT4zjUZf6YyjBJ5RV0Ja9t6DFzHeb/krs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Cx5XuUOh7NJ42+qMr12BlyGtQkx+er2EM3L91tUOMWzT5CIeJwREKhtuFZR1O0hDftx9AmJAWWs68is2bjqLjS6NRLE2PfEcePDalgkeVviZ6cKqp3E7Cz2UbFLwM019TooNadY5RPjaEw7CKTc81eE6/fakpL/exiKLX6zrORMsOvu9qJjX1og6LGww0vFkXYddP6C6l71yD6OagWijpzXi47kMo1hYn5LxmWUTy9/Was2I52iTuU2wDN2drSxPtpYwhOwk8MwJIGy9nQG2RxML7t4M/l0IZRxYpGgWEs+cuZqjYTY1UGAgW4OsKAXWdq6ki+F+0cn/dV4WFO7Y2Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 44569180021B; Mon, 23 Feb 2026 08:37:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 09/27] whpx: move whpx_get_reg/whpx_set_reg to generic code
Date: Mon, 23 Feb 2026 09:37:15 +0100
Message-ID: <20260223083734.48533-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Oa2VzxTY c=1 sm=1 tr=0 ts=699c11ea
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=pUA6uon7y9DqcPPp1uEA:9
X-Proofpoint-ORIG-GUID: P6oXzlYi1dCtmB-C49vu6IUjcnMc1ny4
X-Proofpoint-GUID: P6oXzlYi1dCtmB-C49vu6IUjcnMc1ny4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXy4GVrH/ON4yE
 JyZC2gzpT0dJihm9RvaHs40H841zsHdE+z45usLafqkjebHTgBliVDyEzuUSUlbeixIQYQGLI7U
 hmGwkHDI1FNxschQ/7WP2KC+ktCiyxjFZxX6AcVzqVj+tcF9eMi9IwtgoUWk9/FjuEols/AirwS
 bI4S3nS2EgAMHFwYwsjkgJFhIWnTr/4+tlWa8lWxrm0oioCKVij3VdO8OW12oFa5Pju//tB2ZL7
 K3GYRoM32FRnxGOYuz3ss7uBkcesnj8IBLIMn8jCLYPFEbr94+qKlbpWAqzXh1W+Z3l3Sj/5nKi
 8X/g2DxxG6SimZSH/r+6bKCaezNiVL/cxopNlD8A4MhrG7cJ7SYfO7pn69QD7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1030
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABMYL5k+d2pcisUfWYnHW8ilBr2shK88FfHoaUs6B+yHi40hRt9NiQr0N8sfYy9OmszGucPCQFyvOjNw6yqVgrEzqTj8Il3e9954qylljngJbuGn8pT3GClrfm4NJsttDMncMutqkG9q9OeCGgQmpCZk2IuXmfcf5Wf/oOBooP2p980xkDo5YEzVO5Hf7A/USUbWf7GjUcfWsrOeGrnqwZzuZ5ZSWKQCspVIkHkv/n9Ou55gD1aLKTq6lHl42+xFJhJXu5QIzp+qae9MJQCEUPNW+v8kxKJIILZ9CJM911gWLJIXU3kQD9Uepirdye8uYGz8mD2Sb+ghCcuGVPybDAbfCb1Kr8nn8iOcqnpKxMH4rOaNlwXfSCzCN5/ASxzvsiqz/fRnA4kL7+s/S8h/iSDHPh85UUj8qJbQ6kbRl7SFZmc5QQsfMp6woRmtBUUBAB9BJic9DgNPUAEATdZ3H2jgymjEczeAzGplDEldX5PPPlWa7yB07zlECSA46K0SiMefHG9klYS7z7Vc62Neu0c3+lnpoXPF736Pd+0bWbw7m5H/LO6Yk4mLAbr4gbSk9ya87aZwuQBuncyOHU5qItN8Fw1TxEOCT8epR2Xj2OSistNPwCWioFOUszVjVWpYrx2OQ733dgrkX9IU9kDPTElMVwsvTOqOmdHshQXcWr8Zfmy8JtgCTkyWQhQzFjyGCXHtpfJgfzJtZ4uZ/pNrX9XCbTCbiSxjsJ5fVBYgkNUjM++Z52XFvtUccmNQZlOXiLCzffcMsv/04UD/4xS1VHBjOEDmuUqj+2xdG7l5ieuSCHjJ8=
Received-SPF: pass client-ip=57.103.77.222;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


