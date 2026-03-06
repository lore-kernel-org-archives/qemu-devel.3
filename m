Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8825AF01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQc4-00086Z-Mw; Fri, 06 Mar 2026 03:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQb0-00078I-Cg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:47 -0500
Received: from p-west2-cluster1-host4-snip4-1.eps.apple.com ([57.103.68.74]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQaw-0002Sr-HK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:42 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 65EB918003F6; Fri,  6 Mar 2026 08:31:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785894; x=1775377894;
 bh=uXYQoqD+b6enx0yN1GfreUu+eHC54GkioqxlyRGkbEw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IPPEL6PhszxUJbajfFsxtvbNz6iKrnhDEsDNQJ8pSrdJATQN6/MSWx0ZbeUDrHuDHgEOoASZ9Ldd1a8PAMaXH/90VkAvZrm0ml1tcPxFN2cuNoPQsWTzq+PSe8qdlc98EPT8G9nLRr8EN6Ux5+3Xcmkzg935f6dcHeIDFPG31VxRW6+vaxg8bwYcSw8U7xMF15D1Z/DaQjwzhMNH/MD0LoDWLFlkEo35lIY2Y83u0iIHuE16T5K/veglvb7TPmqXNpwEc0sYTsiEIS/sZXQ3/UKVpkMHOd/ztOl582VkrR3SvJW1nHwMB6UoJCVEVX8wakSG+b7UrrQ/3XE71aED7A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 8313618003E1; Fri,  6 Mar 2026 08:31:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v14 05/19] hvf/arm: expose FEAT_SME2 to guest if available
Date: Fri,  6 Mar 2026 09:30:59 +0100
Message-ID: <20260306083113.74177-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pdJXMTVLp08-Zi9dUIOTYrlZ3AoZMjvj
X-Authority-Info-Out: v=2.4 cv=PZzyRyhd c=1 sm=1 tr=0 ts=69aa90e5
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=oZ2wCSY6f7DP8ugrgSYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pdJXMTVLp08-Zi9dUIOTYrlZ3AoZMjvj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX1RD9+0nN8iAb
 VfB7TOOccRA20LI2zLZBN4C4Ibvq6ePIjCAh5CzBj+jOXntgCHC9IaO5wH3KdkwdpVqMbtpriCm
 P/pbHsW5MSFdUOzBLuc9uxnZZ3yHbjjwPHl2J7ddOZ7Kkmb4eTnBRNGM2pkaaRq+pAW0pq05bLu
 ZF9LJANOJZ1gByI7eD/5j6keviLOFFp5DmrBVu5P3tX9WpOL6ibC3mnP/wtRonMwAYPcG2Jz0mN
 2HOMz3Ll6pvLYI3MwrvvuWdRtuAwhxK+uNsYg2aog0Nx22CuOMAhrBjZi8aKw5pP/gfpaX9e6tk
 5n6aW6wkW9/tRXJKm8/O7oNsZPL5f4pMyuJ/77PcStqzx6OHjLu9kf3yoiVS+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1030 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAAB6qCScBLrvCih4BYYZs2NnEEdlIAwUYbJ2sceFZgr4StX7995RBLwywE83IKFHMsLdKWabdtAX/zEbFjYJJ6ggjNAb1CYGVr9Ky7pl0Ua1m90xf/Xd1UTgPwU96IxTbN4YaLMcmW23Od+hWq4ONb/EQLYcEkxk0ywHdBDx/8FkLmleEEGUgGV4xCphHkg7HTQMlJ8uf7uJdssw26TmqT+qhODfKGZKg8pYJmr/BEQkR+Vifbnp2ccPAZ7hVUckEA3TluYeE/TQhu2HRd9wRMdfMGxJ4fEKI6sge0Oc9vsDj9enY6Muwebw49Wcn18odrUJyii9FlT68efb7HyuCDEUpoCQ3KViPUZhIInHBIw0Jf5D2YK/7JKNUyUlEEFn0LeZ1Kh/KlfVceC/H4O3BOIo7pdvDD1cx78ydjd/43y1MhZNAX16M1UyL0vppNVAJLQKNdkGNFC/poeqEPAHTstdJU0XnkbmFnruMgChUuH3YW77LbE/xH3XPZaNoPGzxA/KicCR4TCsIgZFm7q1mRAPNy4QLpCskYxEk8OSoQ0XfDZQ7Qho/uXW3nXSb1ZtZHxxJRvn/rW2g17/aW7ojWCYQ9llP9fIrTj7Qok2ujUCkxuO7AeGquAkt6Cs4TUKlG2zD4SMXUn2Wzv+1GrRyh0pprlNVBqa8nMq2j2HXpAK/tLKjf9fU5ooE/ZIdpaxUm/XcKJgpmR7oWbcS6yo0XIULV54Q5IfHzQ/ErtwePLTanX/kJE/sWb/pcglQPVVTySPBZrqGk4vFwOy6o6tTGH9P8=
Received-SPF: pass client-ip=57.103.68.74;
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


