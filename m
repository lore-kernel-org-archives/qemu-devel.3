Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43E0EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXS-0006vv-Rt; Mon, 23 Feb 2026 18:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXR-0006v2-Re
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:29 -0500
Received: from qs-2002g-snip4-1.eps.apple.com ([57.103.87.192]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXP-0004Qe-VX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:29 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 6E0D31800171; Mon, 23 Feb 2026 23:40:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890027; x=1774482027;
 bh=WRWOr4bOqspFilOnrREUflTllQ5A/6LuLnTDO613usU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Y3ehnzSx1n+yIFm2Mb1zI8Yn+nTfsbZ/d013ORYbk3lUPzANjJBZ6aDy05H6v8XgQxH5g7jLHXYwOBjCG1J9QxRc7DkdvHfwINhAQfDhqVI4Y7k6A/lvTmbk2of+sZFjAWKI1U4MIwgx4YHcL/5jRTeOGEJyWTgSE85pHmIebGWj1h59HsAuuTM7e47y+FK38NmP72EMBw+9tzqkfL5fm6t2ihemN06loaNdBFC/mRzRj5yR6hCVUbk4Y56wxNEqRze1bLDIxJICKU8G8ERwDbahN3deikwjQPQclR5efPMusDr1jxpw+xINPtnuzf0kWpZjnHgEjdpGb9xuEi8Kew==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 7A27F18000A3; Mon, 23 Feb 2026 23:40:24 +0000 (UTC)
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
Subject: [PATCH v6 16/28] whpx: i386: saving/restoring less state for
 WHPX_LEVEL_FAST_RUNTIME_STATE
Date: Tue, 24 Feb 2026 00:39:38 +0100
Message-ID: <20260223233950.96076-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1KP1NO_08rpMJh_V8-JgpBK8Y5FWRT1k
X-Authority-Info-Out: v=2.4 cv=D79K6/Rj c=1 sm=1 tr=0 ts=699ce56a
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=d1mOUhxfU30B8FCplPMA:9
X-Proofpoint-GUID: 1KP1NO_08rpMJh_V8-JgpBK8Y5FWRT1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX+GDr5mkouw8P
 ISFWUSVOQJWykwJuphs6eushay9suUfr/4GrlBgT/+CwBJA5nw4/zc0HYkCvWyF4GcVrQoPJz+w
 KBrB4ZdNFuctgCUS/kQOQtpqckAv5I3U04B2xDKfIIctT/AZ810DI7PMwEOCu974ojVOuX2FwX0
 H1uHEkT8hBgxQPw+JMTtCbIcI7V71OBKfnE2NC2YaJO9WLKSQeMcXSEkGzN4iDZXGnEdQV3jsUC
 MkNPwOsAbsq4jPBo8lq8Wbus2/9X0H9zL6TlMq27bdsLY41QM3ovq2AzGCoZNFj2FzTV6itK3Zm
 R2PyXs7JN2xjHU8oqZ8mzwXSiKKdRQwj0GK90WcYr9l1F5l0LIrDMi4XakiueQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 clxscore=1030 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABa6zGQpv6eGcHvZlmGTvAwtBETZ3uFmX1d2Fx7Ie1ivNVQykpalJKK5CB29u5tJRLGdOZBU8iNW7Etac/WgP4DV4CJgE7CfgbQFeoj0M6YlADgL66xSdDxrY3C9TzOACApwTptGK69ENaucdrYQZ1h3PiwK4gf4ush3TaBE35X6BYRxjrsrGeYvsn+kfdjetxfg+l3T+nTWoSwSTbA5Z1sDNtn5uswSoucRkLEFKzhaL782RG7A8e1Wq5KPZtTO9lK3Zukxv/K+im6YSL/FIp+ZXv7xNv651gFgf70MHXTbBKilFGv4g6PNHrAIB/YIUEF8JEibkong0ylIs7agxGrv0NNzn2bMZ17NuRVxQDSPUkQpJURi3l6Cs4uWzqyPEpt38wYFu6jY9xsr2wE/M7hJzwXgPnBUgx0yFgeBp6xirdkvAjPD+rj5q12hZKDZvExFiY0r7VisHyB8GyQUJeNxCbKQ0fiVPzWHpO+ACAwQdX4GJ8NE3btS/2oBts1Ey4LvMNfJA1I1pKUqpOGq8ElZPTsktnYMofcdYJNVCcFYNqYMBNQ5Dulkd3QOdKCDnl8UUDREPV8lLA/jtLLMmYUg14PAbYULKAC1/iW/G9pL7a79XA67q+vut13bb+1icGusfWYthqTHRZuyyz6A8+ypanUVWDXmj/YyHo7ymx0wCRdf28tSj9wc7aFfDLlJLG3Zptz8hqZT5DzvG+KlNgkL8Ept6/4Nul0qLAD7xsZgk4m3zGcS1lMjtDF3LEWbkA7V+3X/qKP/QM0umEWajNaOGMfoduN0Iw0UHO+IReZ3bMTaiP8sfJ
Received-SPF: pass client-ip=57.103.87.192;
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

Optimise vmexits by save/restoring less state in those cases instead of the full state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 target/i386/whpx/whpx-all.c | 202 +++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 98 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c09d9affef..ab583e922d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -422,118 +422,124 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     }
 
     assert(idx == WHvX64RegisterLdtr);
-    vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
-
-    assert(idx == WHvX64RegisterTr);
-    vcxt.values[idx++].Segment = whpx_seg_q2h(&env->tr, 0, 0);
-
-    assert(idx == WHvX64RegisterIdtr);
-    vcxt.values[idx].Table.Base = env->idt.base;
-    vcxt.values[idx].Table.Limit = env->idt.limit;
-    idx += 1;
-
-    assert(idx == WHvX64RegisterGdtr);
-    vcxt.values[idx].Table.Base = env->gdt.base;
-    vcxt.values[idx].Table.Limit = env->gdt.limit;
-    idx += 1;
-
-    /* CR0, 2, 3, 4, 8 */
-    assert(whpx_register_names[idx] == WHvX64RegisterCr0);
-    vcxt.values[idx++].Reg64 = env->cr[0];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr2);
-    vcxt.values[idx++].Reg64 = env->cr[2];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr3);
-    vcxt.values[idx++].Reg64 = env->cr[3];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr4);
-    vcxt.values[idx++].Reg64 = env->cr[4];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-    vcxt.values[idx++].Reg64 = vcpu->tpr;
-
-    /* 8 Debug Registers - Skipped */
-
     /*
-     * Extended control registers needs to be handled separately depending
-     * on whether xsave is supported/enabled or not.
+     * Skip those registers for synchronisation after MMIO accesses
+     * as they're not going to be modified in that case.
      */
-    whpx_set_xcrs(cpu);
-
-    /* 16 XMM registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    idx_next = idx + 16;
-    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
-        vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
-        vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
-    }
-    idx = idx_next;
-
-    /* 8 FP registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
-    for (i = 0; i < 8; i += 1, idx += 1) {
-        vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
-        /* vcxt.values[idx].Fp.AsUINT128.High64 =
-               env->fpregs[i].mmx.MMX_Q(1);
-        */
-    }
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
+
+        assert(idx == WHvX64RegisterTr);
+        vcxt.values[idx++].Segment = whpx_seg_q2h(&env->tr, 0, 0);
+
+        assert(idx == WHvX64RegisterIdtr);
+        vcxt.values[idx].Table.Base = env->idt.base;
+        vcxt.values[idx].Table.Limit = env->idt.limit;
+        idx += 1;
+
+        assert(idx == WHvX64RegisterGdtr);
+        vcxt.values[idx].Table.Base = env->gdt.base;
+        vcxt.values[idx].Table.Limit = env->gdt.limit;
+        idx += 1;
+
+        /* CR0, 2, 3, 4, 8 */
+        assert(whpx_register_names[idx] == WHvX64RegisterCr0);
+        vcxt.values[idx++].Reg64 = env->cr[0];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr2);
+        vcxt.values[idx++].Reg64 = env->cr[2];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr3);
+        vcxt.values[idx++].Reg64 = env->cr[3];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr4);
+        vcxt.values[idx++].Reg64 = env->cr[4];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr8);
+        vcxt.values[idx++].Reg64 = vcpu->tpr;
+
+        /* 8 Debug Registers - Skipped */
 
-    /* FP control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
-    vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
-    vcxt.values[idx].FpControlStatus.FpStatus =
-        (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
-    vcxt.values[idx].FpControlStatus.FpTag = 0;
-    for (i = 0; i < 8; ++i) {
-        vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
-    }
-    vcxt.values[idx].FpControlStatus.Reserved = 0;
-    vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
-    vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
-    idx += 1;
-
-    /* XMM control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
-    vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
-    vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
-    vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
-    idx += 1;
+        /*
+         * Extended control registers needs to be handled separately depending
+         * on whether xsave is supported/enabled or not.
+         */
+        whpx_set_xcrs(cpu);
+
+        /* 16 XMM registers */
+        assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
+        idx_next = idx + 16;
+        for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
+            vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
+            vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
+        }
+        idx = idx_next;
+
+        /* 8 FP registers */
+        assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
+        for (i = 0; i < 8; i += 1, idx += 1) {
+            vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
+            /* vcxt.values[idx].Fp.AsUINT128.High64 =
+                       env->fpregs[i].mmx.MMX_Q(1);
+            */
+        }
 
-    /* MSRs */
-    assert(whpx_register_names[idx] == WHvX64RegisterEfer);
-    vcxt.values[idx++].Reg64 = env->efer;
+        /* FP control status register */
+        assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
+        vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
+        vcxt.values[idx].FpControlStatus.FpStatus =
+            (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
+        vcxt.values[idx].FpControlStatus.FpTag = 0;
+        for (i = 0; i < 8; ++i) {
+            vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
+        }
+        vcxt.values[idx].FpControlStatus.Reserved = 0;
+        vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
+        vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
+        idx += 1;
+
+        /* XMM control status register */
+        assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
+        vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
+        vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
+        vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
+        idx += 1;
+
+        /* MSRs */
+        assert(whpx_register_names[idx] == WHvX64RegisterEfer);
+        vcxt.values[idx++].Reg64 = env->efer;
 #ifdef TARGET_X86_64
-    assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
-    vcxt.values[idx++].Reg64 = env->kernelgsbase;
+        assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
+        vcxt.values[idx++].Reg64 = env->kernelgsbase;
 #endif
 
-    assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
-    vcxt.values[idx++].Reg64 = vcpu->apic_base;
+        assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
+        vcxt.values[idx++].Reg64 = vcpu->apic_base;
 
-    /* WHvX64RegisterPat - Skipped */
+        /* WHvX64RegisterPat - Skipped */
 
-    assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
-    vcxt.values[idx++].Reg64 = env->sysenter_cs;
-    assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
-    vcxt.values[idx++].Reg64 = env->sysenter_eip;
-    assert(whpx_register_names[idx] == WHvX64RegisterSysenterEsp);
-    vcxt.values[idx++].Reg64 = env->sysenter_esp;
-    assert(whpx_register_names[idx] == WHvX64RegisterStar);
-    vcxt.values[idx++].Reg64 = env->star;
+        assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
+        vcxt.values[idx++].Reg64 = env->sysenter_cs;
+        assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
+        vcxt.values[idx++].Reg64 = env->sysenter_eip;
+        assert(whpx_register_names[idx] == WHvX64RegisterSysenterEsp);
+        vcxt.values[idx++].Reg64 = env->sysenter_esp;
+        assert(whpx_register_names[idx] == WHvX64RegisterStar);
+        vcxt.values[idx++].Reg64 = env->star;
 #ifdef TARGET_X86_64
-    assert(whpx_register_names[idx] == WHvX64RegisterLstar);
-    vcxt.values[idx++].Reg64 = env->lstar;
-    assert(whpx_register_names[idx] == WHvX64RegisterCstar);
-    vcxt.values[idx++].Reg64 = env->cstar;
-    assert(whpx_register_names[idx] == WHvX64RegisterSfmask);
-    vcxt.values[idx++].Reg64 = env->fmask;
+        assert(whpx_register_names[idx] == WHvX64RegisterLstar);
+        vcxt.values[idx++].Reg64 = env->lstar;
+        assert(whpx_register_names[idx] == WHvX64RegisterCstar);
+        vcxt.values[idx++].Reg64 = env->cstar;
+        assert(whpx_register_names[idx] == WHvX64RegisterSfmask);
+        vcxt.values[idx++].Reg64 = env->fmask;
 #endif
 
-    /* Interrupt / Event Registers - Skipped */
+        /* Interrupt / Event Registers - Skipped */
 
-    assert(idx == RTL_NUMBER_OF(whpx_register_names));
+        assert(idx == RTL_NUMBER_OF(whpx_register_names));
+    }
 
     hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index,
         whpx_register_names,
-        RTL_NUMBER_OF(whpx_register_names),
+        idx,
         &vcxt.values[0]);
 
     if (FAILED(hr)) {
@@ -613,7 +619,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (whpx_irqchip_in_kernel()) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -670,7 +676,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[4] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr8);
     tpr = vcxt.values[idx++].Reg64;
-    if (tpr != vcpu->tpr) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
     }
@@ -756,7 +762,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (whpx_irqchip_in_kernel()) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
-- 
2.50.1 (Apple Git-155)


