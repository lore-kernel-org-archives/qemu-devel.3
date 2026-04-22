Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0580CFA1FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfMK-0000Hc-Ec; Wed, 22 Apr 2026 17:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfM4-00007O-W9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:36 -0400
Received: from p-east2-cluster5-host4-snip4-8.eps.apple.com ([57.103.79.61]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfM2-0007bV-HC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 62B5B1800227; Wed, 22 Apr 2026 21:43:29 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlgBXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894209; x=1779486209;
 bh=FA6Y8ttrbFxZ+orHRdeG19yDqOaDqIU7TL3dmM72EL0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VhV2A0rG1CM2s0JhDgK2wxbZqssXqlmfrBl27+Z9or6UH5SBQc7mJXo1zmHBUfWxleB8y5np5Niw8aGGmCaUmchJRMZh1iHbFcc4CAKHHz874qPY6CK2KAJOiQom83ese29L8o5GVnlauUxCp5IoQYXCMQI5+Yj+td8tRR57EDbwZJa/YnwLmNWAXwB75jLwWNZRzvbGukx/zV2QuYz/Rvo5U5EEuODE3RNZlSm7W+ih59qwexHsg5pMgIS+COGSxXar3bPgdats8pmLANNEdiaTZ4upY48uqIJspWP+cds/KHjyNsQrwWKERYPl9dzxsvemEnCn8r5KjTVdefSZDg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 B312418000CF; Wed, 22 Apr 2026 21:43:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 32/37] whpx: i386: don't increment eip on MSR access
 raising GPF
Date: Wed, 22 Apr 2026 23:42:20 +0200
Message-ID: <20260422214225.2242-33-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FvcmyQmGWGUcg_VrlZabGRj3Nldl6dce
X-Authority-Info-Out: v=2.4 cv=JuP8bc4C c=1 sm=1 tr=0 ts=69e94101
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=N0YEvnU7VqbRQIRMxcMA:9
X-Proofpoint-ORIG-GUID: FvcmyQmGWGUcg_VrlZabGRj3Nldl6dce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX8Dtrj6UB1Vro
 /rNnVb9R/2fdrxz4VkJmB3XWNNobH93bdXeHo3AbOPo9+tCqNJcxteqZGP1BhO234shC5nrQXa/
 oXQQ9oyai7ZUrcva1u8WeIB+HP1zUjGR04AsbRBQ/jyB+2I6hwOQwig0JOxqpvlxDlzyWpKp5QP
 xBNuACrHT72Vq3k/uj5U8FgazUnI7OKdfZ9zKmV9X0V2AFGD4gfxDYBumIz6+zh4avg6sITopS3
 35DBHGsZwjIp/ispSKQHFBnHgTiQhS9Y7HeBym08Wpw2Cl20CW6jU5fji/QiR/0bD3pievCz1Yf
 nvGr1eCHXTeHmo3/FCcODbgay2x1Ma5AwTpoOowzmQiv0BsiU/n/YpjLAVbSU0=
Received-SPF: pass client-ip=57.103.79.61;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6845f96ea6..830d8acd2b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2240,6 +2240,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
             bool is_known_msr = 0; 
+            bool raises_gpf = false;
             uint64_t val;
 
             if (vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
@@ -2272,6 +2273,7 @@ int whpx_vcpu_run(CPUState *cpu)
                 is_known_msr = 1;
                 if (val & MSR_IA32_APICBASE_RESERVED) {
                     x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    raises_gpf = true;
                 }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
@@ -2281,6 +2283,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     } else {
                         whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
@@ -2300,6 +2303,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     reg_values[1].Reg64 = val;
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 } else {
                     bql_lock();
@@ -2307,6 +2311,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     bql_unlock();
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 }
             }
@@ -2356,6 +2361,13 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (!is_known_msr && !whpx->ignore_unknown_msr) {
                 x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                raises_gpf = true;
+            }
+
+            /* When a GPF is raised, do not change Rip. */
+            if (raises_gpf) {
+                reg_values[0].Reg64 =
+                    vcpu->exit_ctx.VpContext.Rip;
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-- 
2.50.1 (Apple Git-155)


