Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D849606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=w1dkow2X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0TZ-0000iR-ED; Thu, 22 Oct 2026 17:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0TB-0000W7-JY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:07 -0400
Received: from st-2006d-snip6-11.eps.apple.com ([2a01:b747:3001:203::29]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T8-0005rP-TX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:05 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 87F9B18001F1; Thu, 22 Oct 2026 21:36:59 +0000 (UTC)
X-ICL-RepId: 01a1658b-be64-7d69-9122-0ea8eb21baa5
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQghLBVkARQBBD04GQABGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792705020; x=1824241020;
 bh=V29I0c+XXf1zx5QsoB+igvFcvq0BB4P8AFV1KqzYE4g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=w1dkow2Xf09cyE9N06/us8K/Jcl0Vvlw90tt3loX4/nGjp1dPhgO10xnSnhtPEjU2pYgcM89Ecj3jEuSA+PCMPo6gwyrTZZA2qus3dofQYMVkCsgsu65sDdmtVfGS82Xo0B87E/ZcIzsihFO3h8c3ooHg9OyvWT03OrwWCQWjexCDp4QPzRjRSmHKBFW+UTYUqI+duQVMqEbAB03upA84gSiaPGTSjzS9rZ5Lv4w8orZHW/Xt96RwpE3rG+Rh5R6pax+3jTtBvXtrwJ1rsl1pQ5fYOc6drKuUvEH8fxOpOsk+dQ1wO3+KVhBEv2AqqUeXYbVsgLGGUqVmM1FN3OBDQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 3CC4018001DA; Thu, 22 Oct 2026 21:36:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 6/6] hvf: arm: fetch more features
Date: Thu, 22 Oct 2026 23:36:47 +0200
Message-ID: <20261022213647.21665-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022213647.21665-1-mohamed@unpredictable.fr>
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YQoHkwfRIU6boPBO7LIWvV3o1MHz9_ud
X-Proofpoint-GUID: YQoHkwfRIU6boPBO7LIWvV3o1MHz9_ud
X-Authority-Info-Out: v=2.4 cv=B5u0EetM c=1 sm=1 tr=0 ts=6ada81fb
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WQzVR_6p4jj9dTWwEhYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX6IyqX8XuZPP6
 KFFPLGIcznZJUwiCs7Ihf49W7l+kJk/8rsMimxUu5n0Etx/dt7iweLyyAjyEXDgPpomcKFMAkYR
 jjsIMnTd75S4TU1zmPG9jJQk1L7ZLNq1zyVEqkv+4Uq8s/rN+XX3rKyBLZQ2SZoTkNX8A1lQjnq
 ISFt3ubKkL55huAIxhW5Gkd/r+scd3T9S+ylRX9yJ8fr3Kx8wl7Mm1USr//HeN6IYcDxRnoKh9H
 NqOCporSqVnsdT+/GJ8ZQUe+q48WAnbwJO54XO/3TbqPTLQy5o4Ir5kTQhjSP5RYuGU8ZsZhoJ0
 CwIMziyThDUr6jbE9j+tfo0fFcE130omh4IxEDbnZ6YALOETeiDwM9thCzXZfg=
X-JNJ: AAAAAAABEqWo+Vp406H/CZ0PQ2N3ujUGPPwAuuLg3hdALtpvSBqMoDbSLJRqwh8thhaVH1yJwj22AVTCf9QoNpXxp0ah80e+Jlx/E1X/6y1SRb7niOWGFR1sfB+ARmFRanSMc4UfTbejK3V0/b1anPD0jsWtsspNx9HQh3BneYF5kEmUQIvTrGeJg4UTM5nJVBUBboi7bcZCsHjuUo2FsIzMk1jomFvKGJqov67B+8kIxrsRXxq/EN/BmnxKra+E7Rt3vh3Q/KpXP70d/AJNHIS3n0cEF5ANNIHaqY7SElJNoX0/kcTKqQayn7xeKkIf90znAVQ2uFxSEWbS/8X7qLkcl5igh9e6SAxj14k+J9b9LUAyrcXqX2+kbFoOnY12mw9BlZIDkeKdIbXrbUoyQwtlXuJ+ntPmI4gnLXZwPAXQ81RBY16bsjIkEzXFF6PGYSf5SSaTsdoyGgPBuIgFMzswvQ15oexzDZV+MU0n1ubJo2cjvZVPWTRm66tqeL8vMT2BmoFyFyElBOyjTHZX3YLLz/YdEY9d0rTc9nWqStVeOYn/DdD++FrJvwy6o2oDfIeKJmx8ufB/AB+hFhy0jXB2sQYeVW3M3Jvkyom2ZytIvIV/LrxVCtFrjG9dLmVzwimgxgPC2cWy7+WUDpXnPdXbXixHASjBvCMFs9hvmR4Gk7WTgi/yqB1Ue55WqgHVA2186HI+U0ZWTntw//ZXcxu7t557buTFy2zh4QyxMKADbHHvWdAptS9waqhL1lfPdw==
Received-SPF: pass client-ip=2a01:b747:3001:203::29;
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

macOS 27.0 has some more feature registers available. Fetch them (but not using the values yet).

Also fetch DCZID_EL0 at the same time.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e813f14ed4..3426fcdb86 100644
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
+        {HV_FEATURE_REG_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_IDX},
+        {HV_FEATURE_REG_ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_IDX},
+        {HV_FEATURE_REG_ID_AA64MMFR3_EL1, ID_AA64MMFR3_EL1_IDX},
+        {HV_FEATURE_REG_ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_IDX},
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


