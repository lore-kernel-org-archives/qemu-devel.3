Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075FFF513FB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMdY-0005f9-MC; Thu, 05 Mar 2026 23:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdW-0005eL-VS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:02 -0500
Received: from p-west2-cluster1-host5-snip4-5.eps.apple.com ([57.103.68.48]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdV-0002RJ-AE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:02 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 33F121800110; Fri,  6 Mar 2026 04:17:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770679; x=1775362679;
 bh=uXYQoqD+b6enx0yN1GfreUu+eHC54GkioqxlyRGkbEw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SiT1xRZto2vZUzpWartqU65QpFfJxT5BGIPKaAWs9jsmE1u4wEk5BCisR5LeQJHO5yBqyk5C9trV52KqqbbqgycfAVXBktCD1DKuqC2GWIxgJ9fjF0d8pkM6t4B747ERWhWKBczB3+6HWnO+1o9DUSHCNR1WZM2X+iFfEfeomHV5v2sdrW/b3L8YFtG76wNptyq0TNMr2JRVUp5WH5aKSqmfvSUNAm3DL+tQ+uyPSbuzkfwdtDy6wqyjth9iupdBBJID5R1q8StbHKjJr0L0SJx8Gdxqhfj+AaN747lAJZvTGCfpdmJQqL6i656ZA8VVxhy+Dik2qx5irh1UJzJNvA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 6A845180011D; Fri,  6 Mar 2026 04:17:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 02/15] hvf/arm: expose FEAT_SME2 to guest if available
Date: Fri,  6 Mar 2026 05:17:33 +0100
Message-ID: <20260306041747.54554-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ddGNHHXe c=1 sm=1 tr=0 ts=69aa5577
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=oZ2wCSY6f7DP8ugrgSYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GAzMWzeGWqvkW9JDSWtg-tuBkkezmc_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfXzNhKCuBUGid7
 GfPF9lMo0IqRpjCDfI0IeZxi/1frdU3HEP1MTH1JVEgGkZ55IeEL+xRg/Yfb6gd174FLlPGoG1a
 DA+Ny5Npxg462fndsP8uy/OnBbVhI9iKI0oiOpEEP5prCNGGObofM+fjPjV4IoyWjPOw5vgJvbI
 K3+ejR3JaE6AEY6tkZAGadYXeQ7WMXqQf2XExgGOFH0PacOk8FRG4OFQMz6ZJPeX2Z26QQ377Pu
 1ntVeUcJfaCeP1wOS93YpbE7W4IXpfbJNSYTFMGakn/N6j9iBXkW3Xys+A8iVdo+lp++AVrqVUJ
 7nMwMSOhETc7KYdRPgD0/bLfOVRWlnfNGAExT2Cf5a+dOM6g3CiRgjT7dbK9Wc=
X-Proofpoint-ORIG-GUID: GAzMWzeGWqvkW9JDSWtg-tuBkkezmc_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAABuAMaIt2nMQp6a4qzWaOyWVqC0OvpoLua3nErH4VUQuIzHu03OrAceKfkoke9NfiKStZymOQqpliTV1VjPBNndTJzt/qjIMzh05mPYCSXgZDAgjqXNrajmx5Y6zl8I5unSjXCYo4Gr4hIFpyZ1vZ5432Hno5RrGiIATD51MIfT1K77PcxyjeEc9TsA+bxedZroCncpTK1rIRv9k4+FJXK0k+jC4hCxCaQNmMlsElKMhH4f/ePct03Gj6Zlm7Z/F6mCDSIg5DDI2p7yvpz0iFjKoSKiTeaCWFBYzDgoLvD0CFVHEKRRZKqG2lIKzwGPAjFLHELvX1hAHj9xl9wPGF0k/iXPRsIw8sQWqaBG4yobw9roKE82f56XwiY5tTIbV/otlIUluE0CDplFJWH1tKJD9kIdnVQKzPvrLOdX0EyD3mwR5XrB5cXsV8JYKYZWKqSCPfjhYudO/aE+lGfSS1UCx5/putiTGCYY19XrjTzi6AgPDZsy1BK3oZSpCo9jSR1E2Xvx/Bg9fesSHnYoTMARIfQLrCgc5aPOO0CIZtEUl2xQ98KYlgIgb0tpz1LZNRXUyq7WH6+iIKsgbVWUEgIapccxgJz2tir+8SUknwCGMbYb8j5AP6RjGk42cVQvaXzQkQ2LSViODLUeFyK8bk0/45itrJcUz9/TDeNNLgVZxMXVVof0Hw5UR/t23krBE10eKjWnc31vtj9nHJGDNAJXeyJlc1sCDlflLlkffQX6cLtHSRryXqkwOiVpfFDyyvPruMOPhV5Q1D3i/W4
Received-SPF: pass client-ip=57.103.68.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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


