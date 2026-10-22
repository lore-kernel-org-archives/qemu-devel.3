Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38E606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Gqtlprl5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0TV-0000ev-VE; Thu, 22 Oct 2026 17:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T9-0000SP-1W
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:04 -0400
Received: from st-2006f-snip6-11.eps.apple.com ([2a01:b747:3001:203::3d]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T5-0005pz-RV
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:02 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 AC5D118003CD; Thu, 22 Oct 2026 21:36:53 +0000 (UTC)
X-ICL-RepId: 01a1658b-a773-782a-a2f6-d11e4e44b549
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQghLBVkARQBBD04GQAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792705016; x=1824241016;
 bh=pc71rTD2QdTsuTOZH5SJFpIAJ1wtEDsQs5AhSwJqqx8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Gqtlprl5nfSbYCkISNUC6hhZ7NIL4Xc9D05STGAsZyLsIAxJlHdAqHyKmKMBTyPEqkk+309kGoOLipVuykJ0aYh/3rdz82Sg7QcIwOyAHu9judeN2gfEvJ1l70MdkZEuhSE9R1dqSL2JF4XTosZ37kvNEYBbXK8/g90BPTgZxjvTIohRwsCfY74yEM55Myl2Z3esM6oYRuFLKDbCHvRacUTTUGlrBqt0NGV5ImLNRmr8H719y+KWnVO0PumVlD/k/kevnAT8B+wOM3z4QFR2YTJ/uHNCplcL81DRf7QwWQcTYeNDRqC17k3Eo9arvKggPyRYlzFEFJtRiBGxCGZ65A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 49C00180035B; Thu, 22 Oct 2026 21:36:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/6] hvf: gicv3: manually set GICD_ISPENDR on edge triggered
 interrupts
Date: Thu, 22 Oct 2026 23:36:42 +0200
Message-ID: <20261022213647.21665-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022213647.21665-1-mohamed@unpredictable.fr>
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=H8zWAuYi c=1 sm=1 tr=0 ts=6ada81f6
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AaqiHi1e0PgY8TsNvtMA:9
X-Proofpoint-ORIG-GUID: NGD6zmjfMBGsE0V27YIHswbcATNzYt9p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX0TqO+wxFl8SG
 zCBFcTDi8dpXT+oetPSQmZG6SYxL23pLhGewnX5NweaWAD+CbTdSigeenYJgf0+kqfWXd+iBOZJ
 nfivDRDSXESErURLvom3JLk8pBmmVAMGmRF5hkvCUdQGRTk/pZeXKJl46E/JOswmPACyK14dcml
 eQxKjriOjoi1W7N1y70tW3VCv4MKquiM/vaG5F/YZtqm1EVn9O3FQ6zPWIqej9RjvFBj2tOc87W
 D7lbeHcg2mM0fx6f9GLlE1FFcuEasgX4NF39c7hWrNdHeyYpVu9g0bo3795P43s+eTnOXCrojAM
 7X6f4Ml2WfLkUMn36+Kp0i7dFm4KYThsDqO4PA7vhFeqmVkmWzog6aKojuD6I0=
X-Proofpoint-GUID: NGD6zmjfMBGsE0V27YIHswbcATNzYt9p
X-JNJ: AAAAAAABoHoV1NvgLY5sijPYIs6lMnN6lJKZ4U55oSyIPe8NZ/ZkeZSqKi1gkpud/2IZbOyyAEXAfcLuHe+b3Kc3jX9SW3d+bYRCfgsBXt9QIAJ7rinf9jRlG8G9Te591oM+rGDADlq2ALusrXv1AtYPl3ubwFnmpjv9QlvqMoWyetmowyoOpemvhRX1S/CgIU9R/TwNZPDtzaZHZ0/qJ6gIGG/SXn8bGgECI/Vbb80noCMgejoPf5C9iN5IMRmVNjG1ZymbKbzM2t/bJZch7c7WxuNLDiY20gnhIGBMOIoFX4PmltdDfj6eym1n+VQ+Sw9CjLtfdHuzz+fTfV269DwZzJR1d3n+AO/leOxpoBUpiOGKKwALKHvjc4eKMnhLEuQhauPG2EJaxA8qwT5GTYGabcgzswFmSh3Lr1fKGhjhOIt/ttkVjYJ3bC/mv7xeX31yQZBoom5bqXiL1qgmEbwA+paNYlR8HKC6HmjHwMRA4n7UG66rFCReAPRTRqqs8s6i7Gov1B5UrpK1bdLPITaYZ3Bln++/109+Mkz1nwdi+j3pkBJcSIN1j00Xogge2A84O29/6Xplq1MKewsyzGYIX7EwVCce5OfVX9rRM6vl2pAjPV4ZMUjLDV6CXCUu5kQNzpuBUk5OA0quv5TSzXjQzsv9JRVWAJ+90QhVmLtgr6OQo9aoFaCgizlpbyy1PTrzDb53jxLjD00rgcapRkhN19GhmpkX0mWxnE85KvA3Z6KfEpOA4E/6bDx4jdL/I0uo5K0w+VRGc4EBzpp7F2twg7XYtk8eoZI=
Received-SPF: pass client-ip=2a01:b747:3001:203::3d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This addresses stability issues with Windows as a guest.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
index ae881092ea..4876446189 100644
--- a/hw/intc/arm_gicv3_hvf.c
+++ b/hw/intc/arm_gicv3_hvf.c
@@ -603,7 +603,27 @@ static void hvf_gicv3_set_irq(void *opaque, int irq, int level)
     if (irq > s->num_irq) {
         return;
     }
+
     hv_gic_set_spi(GIC_INTERNAL + irq, !!level);
+
+    if (level) {
+        /* Fetching state from the vGIC */
+        hvf_dist_get_edge_trigger(s, HV_GIC_DISTRIBUTOR_REG_GICD_ICFGR0,
+            s->edge_trigger);
+
+        /*
+         * 0->1 edges latch the pending bit for edge-triggered interrupts.
+         *
+         * Hypervisor.framework does not seem to do this for us as expected.
+         */
+        if (gicv3_gicd_edge_trigger_test(s, GIC_INTERNAL + irq)) {
+            hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0,
+                s->pending);
+            gicv3_gicd_pending_set(s, GIC_INTERNAL + irq);
+            hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0,
+                HV_GIC_DISTRIBUTOR_REG_GICD_ICPENDR0, s->pending);
+        }
+    }
 }
 
 static void hvf_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
-- 
2.54.0 (Apple Git-157)


