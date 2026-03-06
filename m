Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EBAF01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQc9-0000F0-Da; Fri, 06 Mar 2026 03:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbR-0007Qh-C1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:12 -0500
Received: from p-west2-cluster4-host10-snip4-6.eps.apple.com ([57.103.69.187]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbP-0002a0-Sn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:09 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 835EF18000B2; Fri,  6 Mar 2026 08:32:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785926; x=1775377926;
 bh=LEFgZ1OOYuBdw8dPiYVuEpb1uHIu9H7rtzkrkhw9XrA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cR0kz12XsJ/PH1XzwdqPEy7L/rfxtWf3wkil0x7RK2b/DvQGE/VQjFiXsZlu62glW3+CaZV1T65jCFjEMnZ0axyHy7td2/vLojup47/yRdybHLdNTAh3AUCGPOkNTkeqeDWoOtl6DTMvZ35AyBP7AKJ8xmkm0dAcOaOwYEUO72y/1SMUpIVVgZhH9hizOBFcs5WLd/Oj73nrNRm0OKQau3OiNWzujwHioahnuXVFVngV2I2rgBBeV/NtLlLFlDRXWhJ+WfDKceSFGtjxGLPxdoWbCAiWaz3Kzeyyqm9o4NSUKqU9ExAU/ghHJ0IEO1Fq5BqSQ8zmAAgj9Sd425TYJA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 C230A18003F5; Fri,  6 Mar 2026 08:32:02 +0000 (UTC)
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
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 18/19] hvf: arm: fix SME capabilities reporting
Date: Fri,  6 Mar 2026 09:31:12 +0100
Message-ID: <20260306083113.74177-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: br2ztJOVL-PkhtyGlsjcuep1jjAXeSvl
X-Authority-Info-Out: v=2.4 cv=canfb3DM c=1 sm=1 tr=0 ts=69aa9106
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-YisE-5-8EYoV4yVs6QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-ORIG-GUID: br2ztJOVL-PkhtyGlsjcuep1jjAXeSvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX+qAkaZ1lZ6ss
 SrFzDVeQUe4ToLXB9tiXGyHyf/eWIHCR5WrqLu+b5r5k4f8weq1r/jcvP++CeaF7vOSkwBc7nVd
 uwto5OohnreuNTg+yTCW3XIMRBZGdBuficUu/iQ7C6at9xv92DBDwj43AxjGbiJ2ik+1LmYPmVt
 +bQkb83pEmpgv/kLZmPkNyt27nOucMFIvDRbF36WxqMEfDRZXykDoP53B90/QfYNhqGN1BKFvkK
 79eHYDLIEo6QDGzbGwAh/H5PThFCgbWr+1JxngTyX2LZDm3shsBmiQW8U6yqDXY/yFM3leOElAw
 BkATxOGWx1o5CEeFw+WiLV9Y+txFbNdxApjMQpgiBdyzy28waLxzXEHciEYPz4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=850
 clxscore=1030 mlxscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAAB3ALKvnxOGLH/+Xob+RiZ/gVhvfnaAvScu792CuT8+e/dSPuYQVNyTgdCXfCkPJZvGs3BUA68WYYHFkkY01aQamtG82W9Of6kRe7QGFBqD3Em8eoBQZKBqQSZpoD1Wq/u597lD3UfX9BMhodUfCnqkSuXPP/kGrbRt0OkACurjURj0cum/zZDQDj4khJTLRmMFFnbVDwBwu1wuKMYqqY9Ji49p1Y62OLDWhW5iJozI5oxNnlih3ZHKCPp4vgySX7E/y3os0nYggOFWsU1isEJsssbfKzdQ5KJbSBfWXD6fecyXqfIv15O4oeZ0rS/sEzMvK1DcQdRXGzIAt6mk6ezNQ/gsjFt+jVwxEMGudzgnrnvTGxyyWvBlllCL8jal8dPI6oYIBvq9TDaRYsMQ/AKwBiql0V4jlAr5uzOP49a11REBZAGONBVnEhpjrRHCL2Ria8r7dHSMMFmMW7bemboDdVDbd03/nz04D7bUMq+UvlRRF9pwRyD9Vcp8QLIQa+EFae+NM7b0SimYbSoFfSvCVuRqE/Hd21N9VDESfny0g9hgpi2xA95/QakyiUsBl2JjSw3deycaqPh8/YTN3zCjmoiZFczf79OH7R6pTkeVp3Md2C3x2HWFGLkNOIc61MyD89t73s1qnRsOtKHxdzgqi5rngtZpcJfhCdwQ38JPfUjDzEvJEqR3qeOZR+6NMbBfwvShHZXPse6PxRBon5CCq6moKlu8p/aiITlbiqnL9kXk+Y0urlIuAc=
Received-SPF: pass client-ip=57.103.69.187;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index cb05db2358..b7c5aea505 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1126,6 +1126,15 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_FEATURE_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
         /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
+
+    API_AVAILABLE(macos(15.2)) static const struct sme_isar_regs {
+        hv_feature_reg_t reg;
+        ARMIDRegisterIdx index;
+    } sme_regs[] = {
+        { HV_FEATURE_REG_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_IDX },
+    };
+
     hv_return_t r = HV_SUCCESS;
     hv_vcpu_config_t config = hv_vcpu_config_create();
     uint64_t t;
@@ -1146,6 +1155,16 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
     }
+
+    if (__builtin_available(macOS 15.2, *)) {
+        if (hvf_arm_sme2_supported()) {
+            for (i = 0; i < ARRAY_SIZE(sme_regs); i++) {
+                r |= hv_vcpu_config_get_feature_reg(config, sme_regs[i].reg,
+                                            &host_isar.idregs[sme_regs[i].index]);
+            }
+        }
+    }
+
     os_release(config);
 
     /*
-- 
2.50.1 (Apple Git-155)


