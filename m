Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F760A261D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=tvA9GMB8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLftw-0003i3-NN; Tue, 27 Oct 2026 08:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsG-0003G7-EM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:02:01 -0400
Received: from ci-2007c-snip6-4.eps.apple.com ([2a01:b747:3005:207::1b]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsD-0007yU-F4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:52 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 CE7D3180016E; Tue, 27 Oct 2026 12:01:45 +0000 (UTC)
X-ICL-RepId: 01a17d3c-e735-75b3-a6e2-569d407bd9fe
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQtIAl4CRQdDCUwLQAJGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793102507; x=1824638507;
 bh=tuuHc1kBYMhJYkws8hk/vhb8b0ZMHB5EuNmHuj+gr40=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=tvA9GMB8pfVuX5Zyl4BLcD252bEuTNHxuEb2hXLygfnuBPMzD6RC/iCzVUKJIoCsJ7mE1UOmqETMQ/fxl8FZ0Hbip1wYwQ3qFlcoExB3Srbfe9kx9yHT4NoEy3zZqzUmygXoCQ3R6/Orv06QbpclRtFH5Lk4csw9yAM7xUKnpd/00blwuRmg2xFuD7VAV1ZXauBrcAxsMb2Zjjjpcjo7cuveiomvDcBD0lMT7C1IEjkyqb0q49mcTV+o9EmJrqYaRNE6R0nCiIqpgNCqa3KIO5qTQBfCkPlbgrv/DggUTaFqBICixMxe4/5kX3P5v7tya7E3nr0P14yL9hdvPT3zAw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 572761808310; Tue, 27 Oct 2026 12:01:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 4/6] hvf: arm: fetch more features
Date: Tue, 27 Oct 2026 13:01:33 +0100
Message-ID: <20261027120135.53048-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027120135.53048-1-mohamed@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfXw2qaVkMa1QgM
 iSpAOJnDiKkWqlA8MJCHb6oxewUTQRqrDU9uRFIB0aMicsaFx1rdEaKSQG2cAEi5OMY95XWXsuQ
 jOpgMiJiKx6yB7UxHpYgbdm9NwL3YjRc6HRROGzGUNqkN7HM4hO1L3LYSTXPefOAYRFsI4JDBIJ
 4qJ1+t0lRe7FL/A6q1uR+tSgiuXDv+8McLlC8AiEVYfgX3xhdtTPBXmoqxV+4PL/+oFFjRVGgSB
 ddB92NGi+3K3r/ff41xNkLUVW3dmoa6a90CrIlMLgDqvOF+odf4aUuPaC8FM1bI2BKd4tnx4Lr5
 l6Sbo0ZdbWu18QLB/+aDzZZMzhSZ2v3JGqeRlVWDQkV/64hgnPI6eVA+JbWRd0=
X-Authority-Info-Out: v=2.4 cv=Cvays34D c=1 sm=1 tr=0 ts=6ae092aa
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=D0USAPrXtTfMeYzhH2gA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CosYj5yRslijG2W92jHmBaqPukUNcWCF
X-Proofpoint-ORIG-GUID: CosYj5yRslijG2W92jHmBaqPukUNcWCF
X-JNJ: AAAAAAABjojy0bp02GgKv3asEuOJbaWvKaOPbnw+QbYEi34hP9lBfVXdc5L9fpOmCfif9NruhfqHXSvApSTGljTeaNY/gu3zlXU0K2S+U6bJOiL7qVKlQTgaKOO6In+/v0lYHI4dZ8nZORn+RhdtTRFFsg7KAO/KeAL1vqIz1bDAnHfv6nGCM793XjqTq9k3PhIxR9faFSlxDqH/6F9ruJz2R5S5MCX/VF1tJRyxhBIoXyLDkBtrWLmEdc5Xgzqn1aCrvsEM8VbOKNrIIDGtzm71D/EKL2mW4aH8j0sF95KY7xu8Cb5p4ZIw1sFok2muqs4PNbvVZ7NEPph/i6wPfWLJjzOr0EsmtedAnBeXcTiTQ4achjs5q6X3GKRwt76rKe0ficBPljEiPudHpVQf2KX4brcsS5IliVoV5GhcwqQYdhmJNVjOxPo9jQzV6+/GQHypWyLAZBK1Sx5SuVSZx1dgLLHuVbQgf1ygjkJfzE70uZo03YQK0Jwly3vM2RqFNoh5YGQCm4aj+9Z9BG905gIQ/9Y6IsUEbC8gj4OlLbKRoYiJ4LuLOY7WGWBJq8yN9d0NCkL6BqDHJ8uPlN2tZxGr07SMJP37NjQMg7+15yFJuSkz1tCegmegM/VX/0YTHp63dQvjsEx5QZ6qLsSko0vS3WWiTSkm2LoDmRc+9U7FbIVbujQpNtb5+TY702dtGDsxqKuc1zPQ704iToTpD9yEqcVVg7BXL0ciwM3+toS3GgEgu4a7mEBYOc51VxypSPG1
Received-SPF: pass client-ip=2a01:b747:3005:207::1b;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

macOS 27.0 has some more feature registers available. Fetch them (but not using the values yet).

Also fetch DCZID_EL0 at the same time.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index acbc257091..e1ddfe14c7 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1142,16 +1142,14 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     } regs[] = {
         { HV_FEATURE_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_IDX },
-        /* Add ID_AA64PFR2_EL1 here when HVF supports it */
         { HV_FEATURE_REG_ID_AA64DFR0_EL1, ID_AA64DFR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64DFR1_EL1, ID_AA64DFR1_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
-        /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
         { HV_FEATURE_REG_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
-        /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
+        { HV_FEATURE_REG_DCZID_EL0, DCZID_EL0_IDX},
     };
     hv_return_t r = HV_SUCCESS;
     hv_vcpu_config_t config = hv_vcpu_config_create();
@@ -1191,6 +1189,22 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         }
     }
 
+    if (__builtin_available(macOS 27.0, *)) {
+        static const struct isar_regs {
+            hv_feature_reg_t reg;
+            ARMIDRegisterIdx index;
+        } new_regs[] = {
+        { HV_FEATURE_REG_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64MMFR3_EL1, ID_AA64MMFR3_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_IDX },
+        };
+        for (i = 0; i < ARRAY_SIZE(new_regs); i++) {
+            r |= hv_vcpu_config_get_feature_reg(config, new_regs[i].reg,
+                                            &host_isar.idregs[new_regs[i].index]);
+        }
+    }
+
     os_release(config);
 
     /*
-- 
2.54.0 (Apple Git-157)


