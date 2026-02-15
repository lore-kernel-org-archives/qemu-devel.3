Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCBEEF5859
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUb3-0000ON-L0; Sun, 15 Feb 2026 00:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUb2-0000O5-A8
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:04 -0500
Received: from p-west2-cluster2-host8-snip4-10.eps.apple.com ([57.103.68.141]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUb0-0004tE-Jp
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:03 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 6C6AB18006A4; Sun, 15 Feb 2026 05:23:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132981; x=1773724981;
 bh=be0nJ130zvvK9XI/bsScdXF1W7wGDBAIgGEUgggxqUo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OdWebKcuaf1ljdxxl2eCgftGwsBkkj/pFVS2cS2aWfk7asUlvCX5X5YjLxmSDuhJdwMEhpMmkhyEhozLOqtZwNDLcHlu0KStMosA4DKIM02PgFMXyexMf3wHIPgJvCrOYOBSHrcl2xIbOp0aCmHBUnn7OwLR1+t/B36IwRa+h65HHLVWL2CVZGoSNaAoMy/8MIasZELCp5m9ZwkH0RcCYiftUo47UUWAcZngHKcI68V5gzeAXwgZWtYnN7v1UyWFacD+lAZl4T7d2efSLIxU8asbZJqmFQLXUuCqAVTO6EsgGkqsRmFCg/P+jtYPuLECUmav+wh8lw3RcAKbuWqwLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 007101800190; Sun, 15 Feb 2026 05:22:56 +0000 (UTC)
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
Subject: [PATCH v3 08/14] whpx: move whpx_get_reg/whpx_set_reg to generic code
Date: Sun, 15 Feb 2026 06:22:19 +0100
Message-ID: <20260215052225.22513-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -jpI853OAFlHDD6HhZZefQK7-bv1XYLv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfXyoKETvwC6HqV
 5TbEo29CY+/nTA21Ex5MkPFOktM5T1IlkQF7KNYxzMLdiQ2lxCVHxypF6b0v5AesrYPosGhVWRK
 0q8T0d531u+dgGvV9rUEUBnAo8HgdnU6o4vTzi02mRPw31mIp5MEQGRaGRhcW+eHnz6uunzswvv
 S8+FoaGUaZEap1rzS2+SYIII7DoFJLY3nXuGyMv2BuQU2qnZRpcHaCPrNe9BYC1d5FeB7kK8Sv0
 fSQf+nF2gByXfhp/7B3zTwvNb4xp+omRdzi1V7uzzUG/EDeIaHC8ab7ivtz6A+UKF8MyNF17Krx
 4YMe8tyyHcOAHOsD48RgeE8YVT9ZxLyb3QwiiIRsKZht1gAiQ5yAgu3fBBTO3Y=
X-Authority-Info-Out: v=2.4 cv=ZsPg6t7G c=1 sm=1 tr=0 ts=69915835
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zEEq2qrNK1eH_SHa7C4A:9
X-Proofpoint-GUID: -jpI853OAFlHDD6HhZZefQK7-bv1XYLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=988 bulkscore=0
 clxscore=1030 suspectscore=0 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAAB+neHZPbk77uzoEqAuHRKfpaF3BTsiLGKj5bi0DTrafYPVpWfUt5QW33PTbD1j2KziQy4IUMAzD9wKbinh/y9Rf/8ytUdRA7G/drxOiQbzoIC0CQzxVh71gqIQ0zU0DYHS530weTAuKEK816DCyoUH5yJsB8dJB34Y5neZDglaF04/vECa+3CizdrnAafUX2jX0hQIfJ+jynWxraHYOcd169RIHfhZmEpFCu/J0EereMKmgHyZ3jQBpkIcnGIzF9pbA8Jvlzl70TuxaWjPzaFLcJWDyJt78ZUiS/mmJ8tQYvo84XrjhmFd2ub8Ptbryb5KGcQg9COHXOFue3BpO5ZybaazZ4SGUJHrY6750UzTJt0Ld2fmI26sWUS9gA2ksNK1h1Lj4V5Kcz6Ox9YiMmgd3564veR0wK6C/bPmqZbUs2wfK72UXsNZAM7vpJkPqtroQRDRd6Gh5Nzrgji5yS0yxSwQnHn/VdY8uYay5wSFR9PG9e3+xNQP4Wamg26ILWma+AqKmpRtyYrTxHYNiCaS77sG53CmgToX2utUIYXgXWIiCGp9IgCczr+q25KInOqqEaTcTOAEoazYtfzgJQnigpwpammg3S2KLDVmg0oXQEbUWz5R9tLKOCiLgptEl1kEP+bwWBcK2/b+Nr9F+HlThpRxAMkIkDLXL43BzB5SRsok85Bt141M8R3oi52xJvHrEYCB4w3+H7lJSAiA6yiRBnfU+DK89Q6OrXTx4JTIv4OxpVZ/ViUPCmP2y8cp+UmiJ4oeZK9LKiHiJHZB1gaA5JeqgmDag==
Received-SPF: pass client-ip=57.103.68.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


