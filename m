Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F260A5BFD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Nipv305V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLftw-0003i4-Nm; Tue, 27 Oct 2026 08:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsH-0003GJ-Rb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:02:01 -0400
Received: from ci-2007k-snip6-10.eps.apple.com ([2a01:b747:3005:207::70]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsF-0007z1-2i
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:53 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 2C83F1808306; Tue, 27 Oct 2026 12:01:47 +0000 (UTC)
X-ICL-RepId: 01a17d3c-ec40-753b-acfe-178dd1b6d972
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQtIAl4CRQdDCUwLQAFGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793102509; x=1824638509;
 bh=t3yktbDRS+iN/ZMXeJYzBu/9fm637dEA1vTo59DjGGQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Nipv305V+2F6WJQSCf3HT3qOohqjrQu+NOqnfAKw2XND4jbVIwyqUw/K0SzZEtl7YkUWmNqOILeRvqWug+aKEZB2aKDumv7G0vro9jYfnxdQehdg4D0XaQFh9N1vu0aot5djq56mgZMyykrmUvEccEz6UYMpY95nEPmVb97KIWEoEJQoHpwxaPlDHGytIsFQvSFh7Q5nSaagk08cKzJy56vQ5P97hx72iyJACImPQdya9DbV4zmFXZv/mHSE40neBdHmBSH5MtztnRSl5pPIFN6DGx1l776sLV68ihGDSQMtvIj8LZMH9H4U4txTIDEHBCcVKOfzlM3PVI69gwNQQQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 9F69D180012D; Tue, 27 Oct 2026 12:01:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 5/6] hvf: gic: sync the CPU interface during a vCPU reset
Date: Tue, 27 Oct 2026 13:01:34 +0100
Message-ID: <20261027120135.53048-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027120135.53048-1-mohamed@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX1xh6WJN4JFvG
 bCIHtqhgyNciRHp8QuC6ZD8HnAr/8RpPR2rT/VMUfyQjMxlGIqITB9aUILo2h9GrTKRTeVG2SRB
 NVbc2sAXmckQyF+ipS0MT17iV0J4qL9w7oIv9J4FAaDqVAqvkUS39jiGkc5F0+sE/a4eaRNMS2g
 goJwlUwAArTeOknSo0z7ZuwyWwUUBLiB6cBvs70+Neqx2VIMoT5sKsGkXX7bt7l5DkHOHUg2Mi+
 1NSTqydTM28Nd6GWzZ3Ocp16dlKcs5YYwnrOizzAANh28ssbCnZkY6w6JpApGiS6dFrcRbl1o6+
 UhWX5c07IfxRetpAZAoncXMXYSPNbINNja7GewNM9ZKqI1GhuckV9+00j2pVWA=
X-Authority-Info-Out: v=2.4 cv=OrZCCi/t c=1 sm=1 tr=0 ts=6ae092ab
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NKy5R9nvzRqnHfWbwMwA:9
X-Proofpoint-ORIG-GUID: MtVWDRdxyAnf1H00o7qnLwBqDwFGTQ4e
X-Proofpoint-GUID: MtVWDRdxyAnf1H00o7qnLwBqDwFGTQ4e
X-JNJ: AAAAAAABRnGLVM1j2mUTsYV1n2CIUbBaJHq7mUyTpeSfy9a5nYHm1Ia2ij4zCKoMQQocFUPxF4B1A0ywRU9b+Iz5MKs28DzVv1Q/rayWcYrJYhWcESkMrm+8yjbpAogVdjgBnpl0JZshhVcvUc96x2yH2MNx5LvdSxkXVLdcfg6Lj2qqp4SjYnQ/9+z62ShO4z3+7pq3KdRst139vfC/8ipVirle5g5uIRQ4Sxl3jKRrBY1BAHNVtJiCsPfgiY/EZn1ZF3RNHRGyVugl/97OUvbBdny8m7ihAV/qy1jRPn1ta3j9A3Qh4/8tNImZRUZFdBgfjwsFG8To7PfokRc02oa3/1YltbqI/ccigdgS0v+ys96alyQg4EFTIKPtTFb2OdLIhe2NMek4IYdZFdvWHfO4Io0zGO9c7IrnpNF3bBF8KAN1aI20D2vQaRcPI6V7/SLm7oPm1t6Hy0vMvsJh1Izub9MZHQuNDFjuyFdJFEC/BYVU9quYxCPF0BaWTF+UBUTmSI9buoYZl9PL79NneMAYLqhPy+aFMlFX1R4urrlU5MGpUeHW6PcQIxIJozZ+68gahlkgnv39iuwtvD3BNgKh0nYElQARtnxnDKmZZg9goBTmgcSgjeMl2pVZcnlLtcyS12C4xkNj8s9KMt4OASAnramo+y51ioE42TuLMezrPMo+b7Vl7ij2bjDrIW3/zDsj26OO78qx9drd9aWJZVh4ra++vOzc/LExNzITj9CrdVtE0hysGAvD9Ps8WGAP5a0xAfsjKCxsm4tOYQ==
Received-SPF: pass client-ip=2a01:b747:3005:207::70;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a vCPU reset happens, we should also
reset the state of the GIC CPU interface.

Otherwise, reboots might not work as expected
during some circumstances.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_hvf.c | 93 ++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
index 4876446189..ad6e09b4c9 100644
--- a/hw/intc/arm_gicv3_hvf.c
+++ b/hw/intc/arm_gicv3_hvf.c
@@ -257,50 +257,14 @@ static void hvf_gicv3_put_cpu_el2(CPUState *cpu_state, run_on_cpu_data arg)
     }
 }
 
-static void hvf_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
+static void hvf_gicv3_put_cpuif(CPUState *cpu_state, run_on_cpu_data arg)
 {
-    uint32_t reg;
     uint64_t reg64;
-    int i, num_pri_bits;
-
+    int num_pri_bits;
     /* Redistributor state */
     GICv3CPUState *c = arg.host_ptr;
     hv_vcpu_t vcpu = c->cpu->accel->fd;
 
-    reg = c->gicr_waker;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
-
-    reg = c->gicr_igroupr0;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
-
-    reg = ~0;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICENABLER0, reg);
-    reg = c->gicr_ienabler0;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISENABLER0, reg);
-
-    /* Restore config before pending so we treat level/edge correctly */
-    reg = half_shuffle32(c->edge_trigger >> 16) << 1;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICFGR1, reg);
-
-    reg = ~0;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICPENDR0, reg);
-    reg = c->gicr_ipendr0;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISPENDR0, reg);
-
-    reg = ~0;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICACTIVER0, reg);
-    reg = c->gicr_iactiver0;
-    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISACTIVER0, reg);
-
-    for (i = 0; i < GIC_INTERNAL; i += 4) {
-        reg = c->gicr_ipriorityr[i] |
-            (c->gicr_ipriorityr[i + 1] << 8) |
-            (c->gicr_ipriorityr[i + 2] << 16) |
-            (c->gicr_ipriorityr[i + 3] << 24);
-        hv_gic_set_redistributor_reg(vcpu,
-            HV_GIC_REDISTRIBUTOR_REG_GICR_IPRIORITYR0 + i, reg);
-    }
-
     /* CPU interface state */
     hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_SRE_EL1, c->icc_sre_el1);
 
@@ -320,7 +284,7 @@ static void hvf_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
 
     switch (num_pri_bits) {
     case 7:
-           reg64 = c->icc_apr[GICV3_G0][3];
+        reg64 = c->icc_apr[GICV3_G0][3];
         hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 3, reg64);
         reg64 = c->icc_apr[GICV3_G0][2];
         hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 2, reg64);
@@ -349,6 +313,53 @@ static void hvf_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
         reg64 = c->icc_apr[GICV3_G1NS][0];
         hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1, reg64);
     }
+}
+
+static void hvf_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
+{
+    uint32_t reg;
+    int i;
+
+    /* Redistributor state */
+    GICv3CPUState *c = arg.host_ptr;
+    hv_vcpu_t vcpu = c->cpu->accel->fd;
+
+    reg = c->gicr_waker;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
+
+    reg = c->gicr_igroupr0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
+
+    reg = ~0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICENABLER0, reg);
+    reg = c->gicr_ienabler0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISENABLER0, reg);
+
+    /* Restore config before pending so we treat level/edge correctly */
+    reg = half_shuffle32(c->edge_trigger >> 16) << 1;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICFGR1, reg);
+
+    reg = ~0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICPENDR0, reg);
+    reg = c->gicr_ipendr0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISPENDR0, reg);
+
+    reg = ~0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICACTIVER0, reg);
+    reg = c->gicr_iactiver0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISACTIVER0, reg);
+
+    for (i = 0; i < GIC_INTERNAL; i += 4) {
+        reg = c->gicr_ipriorityr[i] |
+            (c->gicr_ipriorityr[i + 1] << 8) |
+            (c->gicr_ipriorityr[i + 2] << 16) |
+            (c->gicr_ipriorityr[i + 3] << 24);
+        hv_gic_set_redistributor_reg(vcpu,
+            HV_GIC_REDISTRIBUTOR_REG_GICR_IPRIORITYR0 + i, reg);
+    }
+
+    /* CPU interface state */
+    hvf_gicv3_put_cpuif(cpu_state, arg);
 
     /* Registers beyond this point are with nested virt only */
     if (c->gic->maint_irq) {
@@ -629,6 +640,7 @@ static void hvf_gicv3_set_irq(void *opaque, int irq, int level)
 static void hvf_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *c;
+    run_on_cpu_data data;
 
     c = env->gicv3state;
     c->icc_pmr_el1 = 0;
@@ -649,6 +661,9 @@ static void hvf_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     c->icc_sre_el1 = 0x7;
     memset(c->icc_apr, 0, sizeof(c->icc_apr));
     memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
+
+    data.host_ptr = env->gicv3state;
+    run_on_cpu(env_cpu(env), hvf_gicv3_put_cpu, data);
 }
 
 static void hvf_gicv3_reset_hold(Object *obj, ResetType type)
-- 
2.54.0 (Apple Git-157)


