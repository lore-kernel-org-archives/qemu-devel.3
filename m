Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7B1FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXpw-000470-LK; Fri, 06 Mar 2026 11:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpm-00042e-Ao
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:26 -0500
Received: from p-west3-cluster1-host2-snip4-10.eps.apple.com ([57.103.73.151]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpk-00074i-HZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:26 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 7E3BA180012D; Fri,  6 Mar 2026 16:15:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813723; x=1775405723;
 bh=Bv7t7Vy+N3Dr+xwTtt4qH/q/trULmWUOvcHWfy7me0o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=evMBneXS+U/8Bo2oT14by89mAYbOa18h2XTnOQ8gz8QnhAJ7/or4GOa8gqC+XpUcIks/HscuZ+/T0Uh7/wVHQrY7Jf7pX7sBhUdeVdAHdHpQ93nSr1N8o23cq4RmXBLCx5uHoAASXPnvPnj4iw1dJuA6eShJ9XrKlmaLm5T9TExUUMy/z/HEjUtQeVsxNN9brvzTi6hxG6r0m+VgZ0sI0tds5avrzdlaSq3kGJoeAD+3JDAQZfpo+UrxEl0NqMTh5ZclPX5z8bGIROlJxaFKRJH/OLvBDS8EaYuvq/aGP9RNeTMkTkkU6XJfSSi9TGZKXhnB0CnS5dLWA3ISpIkmzw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 B2EBA1800119; Fri,  6 Mar 2026 16:15:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 02/17] hvf/arm: expose FEAT_SME2 to guest if available
Date: Fri,  6 Mar 2026 17:14:54 +0100
Message-ID: <20260306161509.79712-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69aafd99
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=cKmG3w1NXntEKhAjIXMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: d6att8EZ9eEiAk-o1aFH7PpNYL0bjNK3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX/g5O176wo8pi
 7ustFW2EG8Q8IO92Hc149w6oBt4p2RUk1MexVL7BaeZVKxzCm13FCi9M47mycMhU5luHr3SriRf
 a9DX7gS63kKw0oAcUHn4wxXFb2W4Ewv41SvbPzDwHvyd4Z5XjXxqK1aCJrqp5Avjkm85uaFqxJr
 Ur/BW+tevSAcVvCFlwumr27AtQoi0+0tbKtK/V//5atTyi9f7j40Tz4xzQUm4eZalk+171KN3b7
 Fi4j9hwGlSWcmlLT8ddshLD+uNJmbyQm12oiRJrDCYl3Ug7/44WA93CtWeg37YRUax/wML/2rXa
 AdJO7UPv4deijmYIVJ1fNHWngc4SqXBK9X9z083bCcZqp2Z731BKisPYy2s/4s=
X-Proofpoint-ORIG-GUID: d6att8EZ9eEiAk-o1aFH7PpNYL0bjNK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABm6Bnuo0lWMJeDS7w9AWTxhKczQtA2NPtPTvtZdsZSW0h1rm37c7+uH17PQFuk2Jb7MmGjCCSsmq43ENKM/u1bHFURGgPOkx8bfjpy3Hk2PDKi8x0Oq9jtHX01V3i0U8qbPvSEhQTzxtVUt5E25IxX0rRKDLclJ4lO+rffpmh5ywCsfQC13CwEKbfTSemfeGF3iA4Zav2iMl6dvJU8kkAqot2WrQbinTUq+Gfo2uZWUVuEy7vx4VWKxJykOqwzxfbfnioTnz0nO5VFqxOldLm7JW0bSQjr/R5cmNtihOu/uoLXPTN3iG94Obor3J2reP0cbWpEFCQfyMwsi7b5tn26V4MHPMen9a5+yiA/3hXcw27e9LoPm4EFf3iZdpQJYZlM/ZclXEPGFWNI8cNpgEXBuWyYKe/0zHCsi06LryBu1TkWYzuXx/ULGxDqWhjfWbda7/JnnWzF1SBMg9bNPMYP/ZIB8oxS5QwI/A75onRVlpNsaUIOPinzV1VKQ4CxOwoE129rLAWkcWpSlylOBSlLPp+9enr5OmpNmcjZV+HhTtkGo576FNXBqx1yeXHi4NbfTGGNHkFqOwZgqEhNlkOHoxFd2AvbM9FUFTUKIDw5GwzahM1cYALUm+vTr9b21+2/dNKl2nOBP0kGNqEm+EJwDHaOFtXHIWiF99dCk4y3wOcmpI2vuO3u6PGMk6P0DgJwZW9r6kXGys8UmlFjv/z6nqjyBLzHzmzRqVetakoz7PpEzEyT5sV416FznwRU4vsI/SVSWNMCdI=
Received-SPF: pass client-ip=57.103.73.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_SME2.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20260306-sme2-hvf-v7-2-e72eeda41ed3@linaro.org>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 21b16dfe42..5fc8f6bbbd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -315,6 +315,7 @@ typedef struct ARMHostCPUFeatures {
     uint64_t features;
     uint64_t midr;
     uint32_t reset_sctlr;
+    uint32_t sme_vq_supported;
     const char *dtb_compatible;
 } ARMHostCPUFeatures;
 
@@ -1106,6 +1107,24 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
     }
+
+    if (__builtin_available(macOS 15.2, *)) {
+        static const struct sme_isar_regs {
+            hv_feature_reg_t reg;
+            ARMIDRegisterIdx index;
+        } sme_regs[] = {
+            { HV_FEATURE_REG_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_IDX },
+            { HV_FEATURE_REG_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_IDX },
+        };
+
+        if (hvf_arm_sme2_supported()) {
+            for (i = 0; i < ARRAY_SIZE(sme_regs); i++) {
+                r |= hv_vcpu_config_get_feature_reg(config, sme_regs[i].reg,
+                                                    &host_isar.idregs[sme_regs[i].index]);
+            }
+        }
+    }
+
     os_release(config);
 
     /*
@@ -1121,19 +1140,6 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
-    /*
-     * Disable SME, which is not properly handled by QEMU hvf yet.
-     * To allow this through we would need to:
-     * - make sure that the SME state is correctly handled in the
-     *   get_registers/put_registers functions
-     * - get the SME-specific CPU properties to work with accelerators
-     *   other than TCG
-     * - fix any assumptions we made that SME implies SVE (since
-     *   on the M4 there is SME but not SVE)
-     */
-    SET_IDREG(&host_isar, ID_AA64PFR1,
-              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
-
     ahcf->isar = host_isar;
 
     /*
@@ -1148,6 +1154,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     ahcf->reset_sctlr |= 0x00800000;
 
+    ahcf->sme_vq_supported = hvf_arm_sme2_supported() ? hvf_arm_sme2_get_svl() : 0;
+
     /* Make sure we don't advertise AArch32 support for EL0/EL1 */
     if ((GET_IDREG(&host_isar, ID_AA64PFR0) & 0xff) != 0x11) {
         return false;
@@ -1199,6 +1207,7 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->env.features = arm_host_cpu_features.features;
     cpu->midr = arm_host_cpu_features.midr;
     cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
+    cpu->sme_vq.supported = arm_host_cpu_features.sme_vq_supported;
 }
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
@@ -1343,6 +1352,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
 
-- 
2.50.1 (Apple Git-155)


