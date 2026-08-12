Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA301C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4KB-0007YK-LG; Wed, 12 Aug 2026 04:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4KA-0007YC-Qg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:34 -0400
Received: from pv-2003d-snip6-11.eps.apple.com ([2a01:b747:3003:205::29]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K9-00053K-CQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:34 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 04EBB1800950; Wed, 12 Aug 2026 08:28:28 +0000 (UTC)
X-ICL-RepId: 019ff516-5346-7986-915c-66053f687e6b
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdD1oAQAFKC1wDRQBHC0kEQABGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1786523312; x=1789115312;
 bh=+Yof9uipr19UVMj3HWwA5Hlq6kbuQWRKasISjme4jhc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=pmWrcjxiKWWaK1GWrGjr8Nzn3Rq8Ogk5THjOxusjBCnfZvWsHR9IO9kk6YG1PnU5YeDX+/CBSozUIG6Nl8i65m3fXkFP0Lb9rlJtjqAPBcE9Xl6j60xTVuw2lrnPoQjkUp00sS6eHyNa09TQRAK/6T4DKUt81+ynydgeFSDf2U6hEosBiTp7PkX8uUDU7cV+I2+y7xxfSO8HQifmx69eUFEu7bkYzBXO/YviOhVud8xE6LCrgxQL4ii9KUaaZymmWLq6BGRU2gFVuZZ1rMboyID2hMoermFiKMC4Y/Ka97Gz2q6Sde/Yw2oGDarpOG3p0ZiWchbR2KDXL32NLrNcIQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 AB499180096D; Wed, 12 Aug 2026 08:28:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 6/6] whpx: i386: inject back db
Date: Wed, 12 Aug 2026 10:28:14 +0200
Message-ID: <20260812082814.27217-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812082814.27217-1-mohamed@unpredictable.fr>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=a8Q9NESF c=1 sm=1 tr=0 ts=6a7c2eae
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LC-SUz40srEpHiD94tQA:9
X-Proofpoint-ORIG-GUID: ByMYVFCK12OT1xNDMt6v-LMvuCe0biSW
X-Proofpoint-GUID: ByMYVFCK12OT1xNDMt6v-LMvuCe0biSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXy0c+4CU+uOFQ
 ZtIF7rvyo0CGq/VSjijk0n632iHtQmj7hAp0R4Ayu2yddG+UGexhzJsYnGCSQiUb+4yi8UBT6XG
 FT7Dj9mEPsr8cZZ/bCUjq18MAArw1UpgVs5hz6gUMQml9z3RFkWh/90NgimNy4ZSt5q0MA7bvmg
 ImNw8OEAEQsJtLD0U7AlyRDldzVUy39zyeMphLssRkIllKGwUQ7+m6z4l54+Dk2NGtrSuwaJMZ4
 on/tuEV/WthOgl1jdrrtFqnkJHZbnOgYRxdbQtNSbiUmUOLQh/SDCUiLFoKDrjJecjMcb5STKqI
 7uFEpVBXogh3P5g8e1SxuEeLb5FYyBzQu10Cw0Km1pHwv39XKAkvxgGT53cz3I=
X-JNJ: AAAAAAABDtpE4qwwZKCe3aD3T+J/cWjgpqgNL+69RaC16lHEb5IrHveB+Rkp+y0+VojDPYleZ1Gt0n7KltrSxeXS3NBvEDkQR+O6hATSyrK792FgvhF96hwGReuShXDcqW4CucBLXGZquEGfkTFXcNbATxVdY2/W8t+krjVfsL5rq9JqwoFBTeKWU/hvxahvL0sk7LcTWzKoWwYQ9VLzeI/P37N5pfGMa5Z/EltJ/yO7O1cWyJwVL+6Iw1rDf6bU6dRb2l+Qp378y/7AIPq0OD9O4FRisaPAL43JiC3RDlxrgaQ0oVka9Wvr3/BshuEqbPRb76iup3AkJwL0aHvREIWXvu/2uNMNzQAyp31V4s7WR+mJUpDJ21Z0Bc3WioFZPRM0eq9Ew89HWxWwiEo9qrvJCSY1EX8CJ1V30RECFnsHFZBf5RlYklZZL1hXu5iffEE+vkYSqZ+4nnhvAQ5JfVCSICYSVTzt9EwNoDr5AYYtEbL8Q9uY2ED2QGj++rc1rlbyigx1BocENZKPRIkbl+qmZw9O67V21GgAjFHf7flM4FyHZND8iP2F7SVHpoQSU3QpqYVemLDsN4RkyuiqMeHuZC8Nrl45Ny7se+WAU/YPyBSM1nwtL5atws6r/a8qZWPeGvvPj2WgDhi8OqSJOtYlGnaCqtJUrdPflzKptQ6Kemss78HXnMq0PzsGBzDCFYBvx/ClCN2YBSD9Ga1Igyu0
Received-SPF: pass client-ip=2a01:b747:3003:205::29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When we get a debug exception other than int1,
inject it back to the guest.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 56a8b16749..113f79afb9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1079,6 +1079,31 @@ static void whpx_inject_back_gpf(CPUState *cpu)
     whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
 }
 
+static void whpx_inject_back_db(CPUState *cpu)
+{
+    WHV_VP_EXCEPTION_CONTEXT *ctx = &cpu->accel->exit_ctx.VpException;
+    WHV_REGISTER_VALUE reg = {};
+
+    if (ctx->ExceptionInfo.SoftwareException) {
+        /* TODO */
+        warn_report("Was asked to inject software exception.");
+        return;
+    }
+
+    if (ctx->ExceptionType != EXCP01_DB) {
+        warn_report("Was asked to inject exception other than debug.");
+        return;
+    }
+
+    reg.ExceptionEvent.EventPending = 1;
+    reg.ExceptionEvent.EventType = WHvX64PendingEventException;
+    reg.ExceptionEvent.DeliverErrorCode = ctx->ExceptionInfo.ErrorCodeValid;
+    reg.ExceptionEvent.Vector = ctx->ExceptionType;
+    reg.ExceptionEvent.ErrorCode = ctx->ErrorCode;
+    reg.ExceptionEvent.ExceptionParameter = ctx->ExceptionParameter;
+    whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
+}
+
 static void handle_io(CPUState *env, uint16_t port, void *buffer,
                   int direction, int size, int count)
 {
@@ -2646,11 +2671,7 @@ int whpx_vcpu_run(CPUState *cpu)
             } else if ((vcpu->exit_ctx.VpException.ExceptionType ==
                         WHvX64ExceptionTypeDebugTrapOrFault) &&
                        !cpu_single_stepping(cpu)) {
-                /*
-                 * Just finished stepping over a breakpoint, but the
-                 * gdb does not expect us to do single-stepping.
-                 * Don't do anything special.
-                 */
+                whpx_inject_back_db(cpu);
                 cpu->exception_index = EXCP_INTERRUPT;
             } else {
                 /* Another exception or debug event. Report it to GDB. */
-- 
2.54.0 (Apple Git-156)


