Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13556F01808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4d-0007Qa-W6; Fri, 06 Mar 2026 02:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4c-0007Q7-TH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:14 -0500
Received: from p-west2-cluster1-host2-snip4-3.eps.apple.com ([57.103.68.16]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4a-00064h-Vr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:14 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 B4E58180024C; Fri,  6 Mar 2026 07:58:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783892; x=1775375892;
 bh=uXYQoqD+b6enx0yN1GfreUu+eHC54GkioqxlyRGkbEw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Zz9nXDRjxegFuv/no1KBjm4JVJCtVXdwP1F/2J22Wt8hzrcAhIvvtq/B/S/UGS901mRBXW+oD7sFEbXp+wUTpzAwtKrrl9BwTYLT4ueX8jatWx9UdRrU1KVyCh0K5aft3ixKafTrSaCSdtYQ1NOAUxmQkfHa1k2Id/PXYTSNyUejNH38wt7o/Qbrc0h337kHoMs58xtrbMgqVjBXVAKQ8L0kASuXBDh3p5lSkAeW83dK3uAFyqXqfuR9cLkKGVvzw+hXxwa838kYMyeJ2Zt1RkDA2Bd3mUj53ayKoBhR263l0xoUSCw+B3pR54/ZdlPJbyX2l26xuSUNePAez/Y+qA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 BDE971800116; Fri,  6 Mar 2026 07:58:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v13 03/17] hvf/arm: expose FEAT_SME2 to guest if available
Date: Fri,  6 Mar 2026 08:57:42 +0100
Message-ID: <20260306075756.88922-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=aua/yCZV c=1 sm=1 tr=0 ts=69aa8913
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=oZ2wCSY6f7DP8ugrgSYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vzcpVkRlDdkNOYvx3gQjHH2FADRhWchc
X-Proofpoint-ORIG-GUID: vzcpVkRlDdkNOYvx3gQjHH2FADRhWchc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX+TDEWjF1HIYp
 ObhnHoA72IxnyzIewKbnJseCH8Pr5+muYBm+hGwJ8WJq1CW9hU+TxM042hDU3gqlYTD18zJxDKE
 GQb7plMumSt98qqCLcH5kwavDpf1J6z+3vWfveICE3dVLiKill7JBVgMIkW/G3BkPprQ+IezQ1U
 FWNmhLMQdcGzIvSGUe9yFGfa9hD3Nwa39uIEmPDqni36qDeeZPln1C7WvugIHZxb57LIaWhQ3x7
 xYW6e33MN/xlhzADrhjz+qJElZCZWECzOn2LClk6Ool/J86mNvT/Ne8JvkvBPByAzgrTdv0N/JA
 AuiLb+QkQqfiJVYtu7bhV4uKf4bAVnVpmYaHKtnIbNVDz8KirgBZV2taHgQrr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1030 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603060075
X-JNJ: AAAAAAABD/n7aIeT5yqk+BmH918izJ8daNoOLVnlDEaO0C1dIP2BuqJl2eEaPI/ZRxK5/BNa78CvYU1ksIyXTuyjJ40yNA4Qd0+Xl/0R+wBLQZGAPjCWxPTwFRfFzCqfWfc2N3hqRJuOagAJZMOPq99NANbEOhnLfTvLmbtpmR88GKmxB/39L5sIbP0UkFS4NiROLKYhF5H6UWSG5dWZ053tzMDkw3vIWawt7JkjRFW7DkADbh9LYesZG3kucoBv3KnS3Nr4vg4PtffOZ74GrfORvkRq3R++GfwgxLiTO9/W/EsGfb0cQHe5XJuKFzNgZVjTTKVTkSzQQT21elzd7xu6LYuoS5rdfQ38alOcpc12Wk6M23e78GzycNM6Y8cHTa9Wu+VpYpb9x6A5QHfsBVPSqqRQIkmDSSP7sE0SE2Nm5qZeRMS9Q1mFbx+wKOG6TURFmKb03xGrip6HY8Ruen6jAaB4wJi3Kr1EsGHJ6ATRkVcJZiE+8IkwTy0apW05HbeE043+XP1f8q+1JRkccbK5fTfRBTQ2yi1v7c2l0RrOtWQp+7FlH2V5D7DN7px06jM/+NckFUWgtef9aOTGBuwpe5blR3ssiNfo3J3k5i361ytqYBWhsx1endaCw75HJTG6fAw6IZu7QnrVPojw2+RBSYeuF8I+BD7X6ri2q4K4u67YkyGEwOLWPg8oDzdRTFoKwxXFhqy5Bs+qPiQiB8aWlkNx9+3HsKd5Vmz2dKywKuOXNdJjxb/VT7Q/DvJjWZstvyyekACdna1BRVlXvIhP69sMzF/l+9gsXRF1yQ==
Received-SPF: pass client-ip=57.103.68.16;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260303-sme2-hvf-v6-2-b473702d8287@linaro.org>
---
 target/arm/hvf/hvf.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3d194680cc..c9787b3ea1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -315,6 +315,7 @@ typedef struct ARMHostCPUFeatures {
     uint64_t features;
     uint64_t midr;
     uint32_t reset_sctlr;
+    uint32_t sme_vq_supported;
     const char *dtb_compatible;
 } ARMHostCPUFeatures;
 
@@ -1121,19 +1122,6 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
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
@@ -1148,6 +1136,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     ahcf->reset_sctlr |= 0x00800000;
 
+    ahcf->sme_vq_supported = hvf_arm_sme2_supported() ? hvf_arm_sme2_get_svl() : 0;
+
     /* Make sure we don't advertise AArch32 support for EL0/EL1 */
     if ((GET_IDREG(&host_isar, ID_AA64PFR0) & 0xff) != 0x11) {
         return false;
@@ -1199,6 +1189,7 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->env.features = arm_host_cpu_features.features;
     cpu->midr = arm_host_cpu_features.midr;
     cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
+    cpu->sme_vq.supported = arm_host_cpu_features.sme_vq_supported;
 }
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
@@ -1339,6 +1330,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
 
-- 
2.50.1 (Apple Git-155)


