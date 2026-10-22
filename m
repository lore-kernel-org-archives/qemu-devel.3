Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B7606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=GSXikcv3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0TU-0000cr-6z; Thu, 22 Oct 2026 17:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T9-0000SQ-2G
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:04 -0400
Received: from st-2006h-snip6-7.eps.apple.com ([2a01:b747:3001:203::4e]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T5-0005q4-RZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:02 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 ED58E180036E; Thu, 22 Oct 2026 21:36:55 +0000 (UTC)
X-ICL-RepId: 01a1658b-b08e-7e2a-95a0-9136f92a28eb
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQghLBVkARQBBD04GQANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792705016; x=1824241016;
 bh=k0ZhAjLLtq2h69tF4lb8QU8IpaEiGLR+L2c0BInsXlA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GSXikcv3YZT/O8nz/Vq69QOTPUnBkX1n34/d8PzZwT3FQgpfyVuFd43OZs0M1X07YHaAnoRl0RuzzyQg/oUimTpChuBrMl9UzmXwEbALubvVP3DCXcl6sMBI64tXu0pK0RlhrgBMnM+cO27a9I8RxX5LqVfEnNt1PCIsKXY+vvwLlJK/tmFkUj94kAtCEydmdp1L+36L8JG01+oWOZ3vWKCm08VBzOo606cDcRx7CMxziiYqvfD4m6yX9jWUBxS9HWU1utH2UGXfiImW2laBMMJNr/gQ0H1KRQs4SwTF/ZzrF1MVGbmr0MutLchWovQrgN/87APi0xV9orEMSsB9RA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 6BA6718001D2; Thu, 22 Oct 2026 21:36:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 3/6] hvf: arm: save/restore SME state only when SME on
Date: Thu, 22 Oct 2026 23:36:44 +0200
Message-ID: <20261022213647.21665-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022213647.21665-1-mohamed@unpredictable.fr>
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8DTflgACzKXncYMTno6vgeIc-VnYxEEk
X-Proofpoint-GUID: 8DTflgACzKXncYMTno6vgeIc-VnYxEEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX0EOEnzZnSc/r
 GXTsMSpCxWRpIB630zDYIxpaqWd773ADqtxw/SUpTdQOr1tqZBGIR4iEhKoVFRSJLSL737wKtxW
 TIUJCru3nfAhfqa488w1nSsO/F4UCfs5IenNTugZOaZ8kvq4/jobNFQTORuu2/2ihG0sO828AiM
 fwpSGA9DIYpOeYV53/IWGIpLLIIxiXCpzeBaU/H6Vd2eFBHdpt+oJql63VTVTALxMw+mb+8XEOw
 vr2RaStUDEFa8EIVILwpg7hQbtHHvqS/2T+jIrSBZWiCCCGL9JLrastNAUc5pwnW4y5G29xZ8Nq
 pwJXQm6t1EGNOzWkQgGJXB5ALF2VM9BpreYpcq1MDYJ8cbSdM9dt4ehoS5Y7a8=
X-Authority-Info-Out: v=2.4 cv=JOc2csKb c=1 sm=1 tr=0 ts=6ada81f8
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-CzlRYDX7S5ZMYLRV08A:9
X-JNJ: AAAAAAAB8HgiWLmCu8qL4/IiY9HFv1kGXGN0i//Pk4VYqYRMNJ4uodBGYAWK/TTfM4VeVcYCOFlpQshqKnTiOFbPbtn8ISRJG/NFJ5NZakJn+fkt2TtYphZn5sAyu/hA+MLoOBvFw7mJbo+0EHXPTmktsd/Jd2AaVzX3wJZtMXJnSM/x2jHyVgbfJ+bbItjUtlctVuXBMx+xgBlnKYJDvfSDduT12v8hgnExqcT/7IZJbQC5DU6gDwry5hpEz7Kzy+XnB8X7CoOZ53Ggu+XBDFEc2PLNw+63YdRA+UXzsojZcjI8dUx3qbBW/qa2qkMYqWfAvZrMuh8ysEWbvSCvm3lAk02dF35WUNiUlMoNnoLubzFqsyaLsJbrQtNEUyASkcYF2rxUGkG0ijpNYSDOrXhVOw2hnOqCUnttyxKT/Vofe0WqTDEM+6dVo7tzG3l7yCFH3wIlJ8ENm8jfaC1zd/DCh0Vp3A0OnezKWp+zAD90bVszChOiHSrckMwKusojmF560JkOAiQuf0EQTUs10bcjvMD2FK9fpi7EbEYFJq4uDUHUvnYGqdgKU7JbxcPGoDMjInLfoQVcrjQeS7Ju1hVQLYBS2cJ3rOmsv50KNfhkDbm8VgVehOEE3HVKbw9PNEDZWwtACfWelLA+FTQnnYaizswYVe07ezNalkqPNWBLAs7LlWqVtWLg1WwxUp5+mVdbrZ7PKFo2GdKu3Y93A1pQU0A3AcBfr4PH165AW1JiJ+F/2boqf+QsTfasJBxFtahtFhJ/
Received-SPF: pass client-ip=2a01:b747:3001:203::4e;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

When SME is disabled as part of the CPU configuration, do not restore SME state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b00a7e1a84..df047b5dcc 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1394,7 +1394,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
+        if (hvf_arm_sme2_supported() && cpu_isar_feature(aa64_sme, arm_cpu)) {
             sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
         }
 
@@ -1444,7 +1444,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
     if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
+        if (hvf_arm_sme2_supported() && cpu_isar_feature(aa64_sme, arm_cpu)) {
             for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
                 hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
                 uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-- 
2.54.0 (Apple Git-157)


