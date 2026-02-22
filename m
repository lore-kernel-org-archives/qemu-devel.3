Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC54C624DB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnY-0000AE-RN; Sun, 22 Feb 2026 13:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnT-0008To-Az
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:11 -0500
Received: from qs-2007a-snip4-6.eps.apple.com ([57.103.84.137]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnR-0000Sd-Oc
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:11 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 4BE8F18000EF; Sun, 22 Feb 2026 18:03:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783388; x=1774375388;
 bh=NHOceMt/DdcT4zjUZf6YyjBJ5RV0Ja9t6DFzHeb/krs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PmYIoiFQMjThgxabZ9jMqbm4jDk4LtSl9olo2Y1PxgbJVeZNA/R/SQNBtt3twfMScE/bWUVL/3csrUr+RYH1LRYf+ZvelgVQR94iY1OC/3WXZ1sQ+BALzuwS+jqnqMCjUbRNQVn76+g6esvTvlMWcD7f1XIgCVe6lCMswfUvx1zpPR2HjcMFuU0ssQP/DTYnPmZMMENaamTDRJRedze8nQah4A9OdAz4jyCJFO1/R2UwpVchNE+uMUtpbyhJi3MW20XzROjIAXgoXArXJxVTSL6NJDTIiinZroN2QIxetgQG5wyka2AIzh2S9Gbm8D+Nel7k/HcM32Qn9O9kWpU1Yg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 81F5F1800131; Sun, 22 Feb 2026 18:03:01 +0000 (UTC)
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
Subject: [PATCH v4 09/16] whpx: move whpx_get_reg/whpx_set_reg to generic code
Date: Sun, 22 Feb 2026 19:02:33 +0100
Message-ID: <20260222180241.14621-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX1v3zOBfbZOdG
 0a/Gt2ZkIVV3F8n6+BAdu8VcfgIgbZzP9dzPqHUtb0tNyJdrVgYxMn+aH4710jIBHwIMErNIYJy
 XqUodmkdDeds1b6Sn0xeehSJkeiqeGt5FFISS4iqT0460OIg8FWtQeqpUsebIEj9HpE3ntj937v
 Kszq7zBjj9SLvzju6uPnjy6EB9jTIxNAKClyUVQFOcb3/8mq6JFJ3pVJ7vBhWtF8Yb/ZwluwIkr
 VItB4qr0JSToASq5y9qNX/e4Us+evbdv81+9Ad3Uqajkk7ScT41zvzwzkoKaQOcsmCkbw+zsFFY
 9ZgD1GwQra5k0rIPNI+Joc9XKvO9oblJDlhyz4Z2isDlCNyb5PHNqeZ5vAZu8o=
X-Proofpoint-ORIG-GUID: _0_hxt9a8YJKHmGb_n21E5A5WW1frgSS
X-Authority-Info-Out: v=2.4 cv=asC/yCZV c=1 sm=1 tr=0 ts=699b44da
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=pUA6uon7y9DqcPPp1uEA:9
X-Proofpoint-GUID: _0_hxt9a8YJKHmGb_n21E5A5WW1frgSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABWNT51oHBonwAMalVNDWEMHPPFbLueTvpSdMC9STNUpxFqIVLTxhMjjRWd8VbIbhDbnHIW1XmBrnve/qBSBKBy3V1e5HEq8mtTeyOG/Nbqel8DC0OPH1FktXOlRtkdD6TDTcST7yqjS5lX6atrfYEhumMXHknSnBggEUr1BMq0IrpwiaNLxwXwkkUT22LI7W65enSLe6fN7IeCCYQRk4gHbTpWBaES9ST+o4Vc2lXUALJpmspYhk5xVPCYgGVlwWagQIkiFiO2YyxZ7O+xQt888l06gBhA6duUDuSVmf78jBpIdH8oJz9qdrcwUZvZLsEC9/laZ46YO9C5sIMwBmcyqmerDEraTXMV93/aGJ8sqbVaUDGy1xJiB5R8XKAzqXfMYnVra/a1rKsZngwZ3QPles+g+YMKDUYQHys4Og/jg0fmuE7FD/LSTEaw2UQbY5v+2kiAOF9/CbVJziX0D+40ucRN2pE9+bBlGnNYVzNOsedTvQ84XWqorbbJ34tKQZUgyvqDmcHn9bswPz981hupU1r/UZwbNQMDmXk3Gk3aZiVglJYXiYlfNr/TYS/gxHjuMuPFdq/PLfYAcupICV/1Qsw2j8maEaJoD7GL6ymgaHeueyJdpqVI/2CEQ6bOaFmLmZn9PoWRmzqB0dt0p8pyK/qMp+ip6dPDX1e2dizdWrdXahS0abFgC+0zf7VAYB35Jps3uLT/gpIFMRoozJ3sBJX8vqVa6n8AHzPu8KgMF1XlwMjtttIRhd4Iw+OW6JVDiEma1N8HAoObhmgc6iY
Received-SPF: pass client-ip=57.103.84.137;
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


