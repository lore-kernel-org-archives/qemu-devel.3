Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AC7C636A1
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnh-0000PU-92; Sun, 22 Feb 2026 13:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnf-0000Od-Ow
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:23 -0500
Received: from qs-2001l-snip4-1.eps.apple.com ([57.103.87.114]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnd-0000YH-KC
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:23 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 E644018004F7; Sun, 22 Feb 2026 18:03:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783401; x=1774375401;
 bh=WRWOr4bOqspFilOnrREUflTllQ5A/6LuLnTDO613usU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TBhkLLnmYWyaZWvgaSy3k4+59IgqHaAY/R89mtZ7A9hwvSZ0T/ihD6xftXxHqO8KnWLk+mCm4jTlIW0xhHU35+q6bvk1g2rg9xPqeT2Ws7oJgGxL6Pwj5MkVvUT5lnDX7l9coG7TuYXlqNsbf8YEcPMSR2a/Zbdv6dSdCsVkPNHMS2QW1vRdqeWL+rsDSwT54+Ift2rNtgMVze/uZtmWOSddg+8kErPwUytF8ThGbewWBoED6xqp9P4mRI4+t6Pbk+h3R8DYmxP5QH6ZNugDMc9smVRXQu1OLBedtoNO2WXlTpPRUbieSOq3IjocZoIPNeGevPZ+Gz+B02VMlsaktA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 877F418004F1; Sun, 22 Feb 2026 18:03:15 +0000 (UTC)
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
Subject: [PATCH v4 16/16] whpx: i386: saving/restoring less state for
 WHPX_LEVEL_FAST_RUNTIME_STATE
Date: Sun, 22 Feb 2026 19:02:40 +0100
Message-ID: <20260222180241.14621-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Lx4OhccN68fi4qgb88mEItFSnLjDtNBK
X-Proofpoint-ORIG-GUID: Lx4OhccN68fi4qgb88mEItFSnLjDtNBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXz8FhXB6CfsXy
 NHmTKFDcot2i5nFe+alMlUwTmmUdccSEdBZ3vtH3NoqGxV2PRMRulO2x3R68xfCOa7Ec0ehG4kW
 rJp5eBtivkqBPJAhZAZeSfMyJaIzIG3ZcsU9xkmKeIy3se4b2nJnjO12y3zmv4Oxdm3EOKDTNM7
 1K2Z+Q87EMaakvxVvKS6zAc88F2w8kd1/73W50Yp8uQFKWLGzY/x4VT6wK3zsw1Il1AFx9Gdxwu
 P5c+F3Oe3Vd+c2ZhVIYwryK1p5xUNjQ90EDm3cJA9qkTKpC5gK0lRzWg31sVNrG4jUZcH6mjmIp
 6+M+Rx67sijAthl303r+mHARXLU6xCb9J2dAWmkVGgR84ysWRZopGWw3O+DHqw=
X-Authority-Info-Out: v=2.4 cv=DIyCIiNb c=1 sm=1 tr=0 ts=699b44e7
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=d1mOUhxfU30B8FCplPMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 clxscore=1030 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABTgDZVfqg7Uwxz3wyqaE+eFwRnCP+rPjg0asNoMhK4ECUiLEeT1hdG74DPvKumy0+CS7opZ6AFqMbo5n0J/rhnsjOV3KRnn7udtoxCJxCz8xEfX63UnRFAfIxO8iHxbYLgNK1z7X+qDm+6/Kpb+VPS6qdJBncXwQRdBQCrPe20YqUI0RoJKjFYiai+sAnQDY+ulLPHPHM8a/Vyc6V+Ev0nppNFuOf4s15Fs6hgJbOuWFcSNMa86dAOX1YyTP0CxpeuXGPIZxbosdXad/NyZ284O3M0Na+bcrjyZhPJ86yCZDlPZRHerIxCprRAblRjmZnr6y8fLy99pcnJuZGMwq+VXP2rWE7MYp4U5TSkbK4dDoxZ1I/LKKbTVcrjDxTlpz5hIHIe2yC6DqWh0Q95e1rgdRVvyz0ZmNCUIwntooroGcOlegrrgEQu1RkTRMdrMY+CumpTpaUVNkSMJqwsy4XndEP5mpohDpjLBC90DmKj5t+fbI+Up0JLbjaRkXN/Y7dz5DcZvBVe3SqH2lw/NIY3UmxiqyB9xZKihy7GXl6ovaYzIwUIo2iCWvu9t+DR/5nHP3zlpawKN7WjVD0Z7s/Ko8JvI5mWlC1nsenrP3PVSfseeVzIQn04+DN4XQpTznlIKu0k97jn4JNud+gYCJBlq3HZklNs7I9LhYT6ENZeN3mHl3hR9ZsA1ca3Ev67zyllC/3SZy2EQYWRn0Df0RTS2aFDFPyswiPMGyJBiNrPavkDFKkNiBQqjoQriwFAk6e6+gcRlKDVP0esi6H2PyVEnpWrGHWVwpLrRjx9XKF56nsEUKEubUmDjZU/V6J+xJTDQ==
Received-SPF: pass client-ip=57.103.87.114;
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


