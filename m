Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1A4E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSX-0000nN-U8; Mon, 23 Feb 2026 03:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSS-0000UL-Pw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:24 -0500
Received: from p-east2-cluster3-host9-snip4-7.eps.apple.com ([57.103.77.138]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSP-0002Gl-4p
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:23 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 B93071800168; Mon, 23 Feb 2026 08:38:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835900; x=1774427900;
 bh=WRWOr4bOqspFilOnrREUflTllQ5A/6LuLnTDO613usU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AAv/ga93I0C5T51RkaV36r1XV7GyXhlhBv8An6EUnNXDWYUJ6m320z6lCvuOxbl2zCxEvF5n65rrHhYxATvEpcRj5ZzljCclDetk6wmA82SBOjW8QdKkr5RaJtgPJBLx5DVJSnw0xnRZm6D5h41F1muJ9Q03FzU4D7sb3DlSboJ3YHSKiw1Mam7eyoI0ZP282EAZFy5F299uGO5CHk3v4zgP54fPo7D4Gu3v8ABPS4sfynpNzSoV+sw2C0OGklyS/UMMQ6Xazr+zj4SIi1fTn4rpk2tDGu4AsnTXJjXhq7klvHOGqvxdDOqpkvtnK/nZ5IuI0Vi34i8d4etcNzghcg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 2B49B1800215; Mon, 23 Feb 2026 08:38:15 +0000 (UTC)
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
Subject: [PATCH v5 16/27] whpx: i386: saving/restoring less state for
 WHPX_LEVEL_FAST_RUNTIME_STATE
Date: Mon, 23 Feb 2026 09:37:22 +0100
Message-ID: <20260223083734.48533-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Oa2VzxTY c=1 sm=1 tr=0 ts=699c11fa
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=d1mOUhxfU30B8FCplPMA:9
X-Proofpoint-ORIG-GUID: J3OhY3FvfJi5ajNKNVWstzkshGJGi9BT
X-Proofpoint-GUID: J3OhY3FvfJi5ajNKNVWstzkshGJGi9BT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXxIXopqGLFimb
 qWzSqpEvUHxiyK8BtumhhIG8prDZGzthNejmeijL29FZhGs0GuaiodHhr3vYdh1TDaVUJNpH5eR
 UBddkXwJVcbbuFjFDroxa67XAfD02l6diJnio5dWSdl3nCu4W2j3dDd99wozm0uM7RWQRmaKZQj
 sJ71JpvIy2vHDO3RFhSJ+a+MaKkD6eqXROZQ6G7LwJDjmPdlGbtyL272jxLcqAJBCxuEbDgMwk+
 cLm5UaPi11BRCcfWDFQD3E274wLp0e2MvyhopdB4osRNDdgYe1620CQf+ScEmnHu+Jcbs25iv8f
 WPHlWTCYX0WCe6cuK4pesiRZ1Jyz1HKG0gKDzfncUMLFWkA0c3L6mWMVWhkTJM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1030
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABm83HsolHTZ31+Naq+YtYzpQmXwxHjdBzOjMR0ZWOTXFsFtPVuo6jk03lVFnJwx9mlCT296BYzQZeuXtVgV9KHUwqoISy3KVSRV+E+vBry5XFxDu/mK6w7xI0RU6E3574Vooyj0B3OeB4VhAqaLy9OcxOrA5GgsO2mDV8t3AAHH+bMFbBib6dT8+i4uOrggzcITH6Xdd3b9rSu1CC4YtvPo+OzHgfgkTR/QRbNMKqplIkrvWSww2EQ1q+VGLFDUkpsob09tBjgXgi1ORq8Rd6fAi66mSv7J8qJOJJxi4/3vnHHSMPnx2x46GJf9E36Fp3cMW+3irupuX02kf2FugSMio37QhR52xqM9Ow0aQ91KP9hGWD5988K8gk+CpAcwJYhRz0GUf/7yHEhDn5rGse7OUgoSKD/bnutWsXnusSs8CDD0hJmLmuszvJ50HCLtAVkZZemNlSKzNHDjsZ+vJFqHY+QKSFuwbLJlfUtOHxLJy6D90uZ7sI90S/aGa+K4WPd5dC8Yv8cGl2/1bmuhasj7HHx+3AaGmsbcwG+Gjtn9pDJbQji3ZpitP1HQ/nJNOeD3SwvCI3V5DxDUZtl67KkdmwT5FFyCq4g5adfz5xdsM3t+oHDJer5xhukXfcP0zYLIOeRHGXEM++yaGCdMZXH55pvElELFaBA7oVu7wO9k47WspB9Yd4CHBErN2XaQCzahWW7CAxHRq9FdmBLrPs5da36/ufzqoLdkekRHP9BjJ9B1vrWAaqJvsk1oZw5gNVUZLH5/bHRRVD16qZFSuHJCzRp6YznE96NxuJmVdOJRnyyg6JuOQ+tKQ/3ohQQHt0qLZNahVF
Received-SPF: pass client-ip=57.103.77.138;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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


