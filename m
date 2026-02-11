Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C0DEB5961
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3B7-0005X8-Hr; Wed, 11 Feb 2026 00:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B5-0005Vl-O8
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:19 -0500
Received: from p-west3-cluster1-host5-snip4-3.eps.apple.com ([57.103.73.174]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B4-0002rD-3A
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:19 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 5956F18000BC; Wed, 11 Feb 2026 05:54:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789256; x=1773381256;
 bh=be0nJ130zvvK9XI/bsScdXF1W7wGDBAIgGEUgggxqUo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SbgabOniZt9YrOP4AeYKVtoZ2WdG/VJi5bowBWnGoC9Enqi/UHHnoWe7eoa6T78m25lvy8vmAgdSjo3pI52fX5mG0UlGuDww6bJ/7oAmKK2mCQgNJqhHurUtj3+opVtqg1ISEXzA9cf4DW1vh4JE7UM7oOMWE+qveO6VH9jiLZucYM1iX44eyUPqjctje87XTMbAiiTwDNLyTI6jSOumUuBWGLmnAUN2U2etORbV4ZKAnAL+PRSqCuYt+G6NKEEW2NC4VhN5N8QZltA3m30UGSy1BE9uljg4NvHdjm70CNHlNK3SHRW6M52syPOIHUkCVUziL7q1k7HFJj/heDxHqA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 243D318000A6; Wed, 11 Feb 2026 05:54:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/7] whpx: move whpx_get_reg/whpx_set_reg to generic code
Date: Wed, 11 Feb 2026 06:53:49 +0100
Message-ID: <20260211055356.44664-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: z9F7oq1wNg3pPcNdbaDLYi1EFGzph4QM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfX+Nb9XF5cAiHe
 Lnb9x7Y46kQ/amUNVrpJp4tACtojAW+yhtV1MxMC7lOBHTwR1NDAI8j2No3ISBwQh8iP7ni38Ue
 kxNrnqWhky65LtnPgeTHqCVfcD62iwcepb54aAIc5sGaqn0XUcUAEGum0a8/Yh5DGS11IBFtUwd
 UEc4XLiVQolUH+jDJPnz48Tie6/UL28BXWC/en4Xbfr/HIZtqVKJ8CU+U4F1m/MfLTucSMWttpe
 BWRrV3c/6/ROq0O+LrspTOo1sxG2K6zkhTcVvWPsXEF/l6fj/NaAw+Uijr1tVZ1trpp6H3ggfw3
 5mQGLK7zOwdC+Tjp/gS9RVh8AJ/stqHeKrzmqFkOYYPlYNnp6D4XFGr3jcWKGA=
X-Authority-Info-Out: v=2.4 cv=LP5rgZW9 c=1 sm=1 tr=0 ts=698c1987
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=zEEq2qrNK1eH_SHa7C4A:9
X-Proofpoint-ORIG-GUID: z9F7oq1wNg3pPcNdbaDLYi1EFGzph4QM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=973 phishscore=0 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 clxscore=1030 bulkscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602110046
X-JNJ: AAAAAAABzOXngGvd9ClzZR1X8rVoM5uUFIiPbRwuzT1ZOxK000VjQCLCR0drJOzfSFCk0FXTcr+OnW2XRLMgO176YssbmNU4jVJjSyZ5Dr91BcXTTVb6gH3sXBvog5zQ18lvmgAdxBlDWUn8jrbK9QKj4wZVw2JBniFZ/wo6cx/6lWF0jRdIzBB/42OBBNrCcVq8a/cY1SxZE3fcswMt6AAP60TBbGsyyKpnmUk5XRm9HyGX5YHeORFW9gmh8SmNYU0Mq1/yYamGRDchHHwO8wOM9pHHFN5zM0TttrDcWhs9/OMnJ6nFRQo4MycOkFoo103MrWwF+eXw2hnsYEE89eVUMeMUiGmzC4C41+kzPrnqfgnvjRGZDfF6SENDig9hqclE0CF+N+ls8INNet1Tdp/5Dk5LAfzQYzf7SbayRc0xtQUIc2ul43VuS+BkxpyWTAlDLIMLYYSQmz4FEly4FQcKgSQhJF/tYlR1OEk8u9mV6shbdJYQFSBNEaXj81E6RYAnKyJKAEtoOa4PYRjSRh/R9Pb/1uV66rWaIEr3O0i1dzqFfofb9KbGVh0zOg/Fw8DZuCHGAjh5Hwju9Xbgsu9xAxTf5rI6sDquRcred04DsvZel97DfbMkESRsPy525/weqItgOc3Z0QtTIdwSgMAPw9vjcL8rr+nqvBPj5AvbmSDVzc/b06hzkuSnMCcMdGrt8eR1Q1su+wLXu0zzOyDf5COVCCyDiUPDd8r+LTc3htAizcQ8JEg+hv1P2RzV07tnVM9D4Uo=
Received-SPF: pass client-ip=57.103.73.174;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


