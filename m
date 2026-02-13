Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88A8EF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8R-0008H4-Kr; Thu, 12 Feb 2026 22:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8Q-0008Gp-Ez
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:26 -0500
Received: from p-west1-cluster4-host5-snip4-5.eps.apple.com ([57.103.65.236]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8O-0005N3-Qm
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:26 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 08C0218002D0; Fri, 13 Feb 2026 03:46:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954383; x=1773546383;
 bh=be0nJ130zvvK9XI/bsScdXF1W7wGDBAIgGEUgggxqUo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FKnzeCtpexctX61PshjrHApKNvROlo7wBjBMGdEWUDtR8qPSCZCqON6Rw7MQhuZ3mk/6iitqyUmyXUoBytXO3/ClTcTcxYOU6tk+d+wNQvd77tYU9Gm3tw79mDBNFURlxX0xk6uj+6t2g+3Z7GkZlLjLflGtg1bqu8x8cQzmYgxU+5dijH8PiYzZ3X+RB29l4sMjROPsc9ouIy1WXQXKXZnoCJ1/YDE0h9uIL564QlIfmdaFH7plpf6FL38FABovJn7Ttid0a+SQorKvJHp/1+kTGFnvi7IT0QMGo8xPav/H8kvbngqRYjNtakMjm0fAH0bkT784uNJ3yp0U5clfbw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 8A20B180009E; Fri, 13 Feb 2026 03:46:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/10] whpx: move whpx_get_reg/whpx_set_reg to generic code
Date: Fri, 13 Feb 2026 04:45:48 +0100
Message-ID: <20260213034556.13471-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VBiiheajr493pI2umY_Ygn5mD8bRoSI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfXzvqWZorHAYls
 NMsD3d5Sj6EeGWkhhn29nQeidsMsKaYxmZJqbpmFmPEcBFjO9QA9CEBcK23ER+ynCEVrk6MQIAs
 wNaRKMGBZx+UleeKtkP1uHJAnkAWSAGcVeGF6Xxy3u3OmOIZh90vRu2dFkhgz/bEYVbMMGz9kvq
 ebI2ryN1Z0czpc+44O9YbjKrLncaF0cupEwyk8c5PcnL1dL4PvQ8z5nPwkvt+4+HgnYnDYYnyA3
 nboOf/h4Ts8g4Ygt921eaRGAqaU/F4FMBfYS1NTgaRnK9NH+ohpF8jJXhJXADwRtAWxoQ57d1/T
 B9ZvT7B4XiLImZNNLoo707smoffeFvG0acRjr7pyPzLwdkHnx+VX4T7GnEWRAE=
X-Authority-Info-Out: v=2.4 cv=Lv6fC3dc c=1 sm=1 tr=0 ts=698e9e8e
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zEEq2qrNK1eH_SHa7C4A:9
X-Proofpoint-GUID: VBiiheajr493pI2umY_Ygn5mD8bRoSI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1030 lowpriorityscore=0 malwarescore=0
 mlxlogscore=990 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAAB6Muo0EbYD4eVr/seCyC9w85rfUxv3DHLbJwmpJQ0x1DmmoFgfz+zXbuDYMCFNfB6tYCdWMrz+X2eeC5BVlSh2lgKEfBMD9b2PB411ZsXVHCVpuyVFH2OQrR/Wotbwdue1nNbu9jhomU0CUJ0K+pMANoZfVfZ9UK1TXy2QO01Sl92lwtir6To+R3DnElg67JbqEndfzo8V6+daNGdaKZoFeWR1hP0QR4gyeTehrQltwtJG6VouCRvqDA2NlKoajDA3GAb72Xc+MJ9qrUpU3dgpGCmhJV+pmFPP3AqXkviIHifYjV4/bzbPbhxTpo5rvkam0BwjcAgYjlgnB1VF4hRnqKydtujYPllFVxzdVRvYx4GedS4gwXrtGO399rM/egNrllza1vh10M3Gd0evqLuP0hNJXmi0OqPjcuQ/aCYwlzBmwIMgqGEZ8Si3R+UZ/1ApTHLIJnrt6mWkzVqlm/QXmIjasnJgAS5J8LYyu6duqRObLg44+r1p0pZw2gkHA9VCZtpc84Rpw/4ehMrrAU/OjDZUlZhWTVzfmF3fubNjraU1UXMv4JCqyGPIKB8HypNpAddTvAWzbFiJJGt8iEpZ84uSNVHWB/y4Q1tvSgQTQCKP3Cjl4HUVnvZ12A+KisaK/dR8YuJ5nPMLM/S179WIwvDKd+7MUFPrALUMmIxNsRPoIlN4NK8hAEZWMuUYswEkHYbAbRe1X3UGfYGP7X8R/GD+N4AjBu+ma6Q3wS7qu5KO6mPAazuIzF7yLOy35/zQ3wvH9OWAw==
Received-SPF: pass client-ip=57.103.65.236;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

These will be used in the next commit on the x86_64 backend too.
Also move flush_cpu_state as it's used by get_reg/set_reg and the arm64 code.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c     | 35 +++++++++++++++++++++++++++++++++++
 include/system/whpx-common.h |  3 +++
 target/arm/whpx/whpx-all.c   | 35 -----------------------------------
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c57a0d3f0f..c2263c2496 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -46,6 +46,41 @@ static HMODULE hWinHvEmulation;
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
 
+void flush_cpu_state(CPUState *cpu)
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
+    flush_cpu_state(cpu);
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
index b86fe9db6e..5bce33e336 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,6 +20,9 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+void flush_cpu_state(CPUState *cpu);
+void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val);
+void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val);
 
 /* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
 #define WHPX_INTERCEPT_DEBUG_TRAPS 1
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index d52580a082..c8d71a252e 100644
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
-- 
2.50.1 (Apple Git-155)


