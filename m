Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CB1F01835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUoD-00017Y-Fe; Fri, 06 Mar 2026 08:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoB-00015s-Hl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:35 -0500
Received: from p-west2-cluster5-host12-snip4-9.eps.apple.com ([57.103.71.22]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUo8-0006xG-Rq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:35 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 3BC271800851; Fri,  6 Mar 2026 13:01:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802091; x=1775394091;
 bh=Bv7t7Vy+N3Dr+xwTtt4qH/q/trULmWUOvcHWfy7me0o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dket8xFRr0HFi8b85ckyhr0EL6wQeQ3RnNQGxxebYcJwewZwai10DvfHJuivNBo+ypf97dnueTRFFleNPAWy7TCemJqoSmaGCyiFaL23oP4O5dTkLeIj376N9QkykkEga33VBuaZAZ3TStuo1ugcGw5lHwRhNkJjniuIs8KJw8QZRQ39sBrRlAzkog79R/dq4l7yJ89fBUSjHqZChzV3kt8yJ/ON66w+H2Sq1EM26MuhXvIpYnPylBDdZeLPs/B92DCCJGgWjgQiNVdTMd7An/GjW7vobumCGd0X436isL9WB1eFZwhT5DOjP+2OivaRz46FUHm4FyYvVApZBHRQKA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 9A3C81800848; Fri,  6 Mar 2026 13:01:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 02/17] hvf/arm: expose FEAT_SME2 to guest if available
Date: Fri,  6 Mar 2026 14:00:52 +0100
Message-ID: <20260306130107.35359-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69aad02a
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=cKmG3w1NXntEKhAjIXMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: T_Fp-KxxtKj2FNGP6tlKWD_dhyegb7cq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX7Rkrz/PTgnHI
 kTLEr1UYNOY55nreRw9cK4q3/4bNROtVamXBw6Rdcc22vCcjEBPoB6NbEFRk03DREUPht3bFV7C
 9w1cJ00U2nllhjgHaRWxRzF1jUIyqPOk0vzY+wM6sLBlsXclHbCnlS3BslP13ueq9Md/I7lasZx
 UDVRTRiqKQfqL4JD9f/lLTgo94gbRJyOYoTylE6MkVIkEZQcb8qRP0iYPcadtbvQMdhRoDiDGkN
 tjJKVGorZP+FF6/zbZXEIYS9WKo3LAZpMXz6ZzILHXSV3KiVNB4wkfRxL6wqR+8cHRo5xiz/I92
 sVpoKzma3KUsYvtSeFMTLDlrO29JMsjSQ/09PFan2ESo1FCOViAudV1wflOgdo=
X-Proofpoint-ORIG-GUID: T_Fp-KxxtKj2FNGP6tlKWD_dhyegb7cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABx+BYhwr9JS9HDF4/GPDfT3lXyGAQYSpOJPBQ1ExftiG7rkQyKIJB8M3dGCOCZ3jHGH0gCpZsTe7NkkwLdefL6g4nyM1niPefp/C7rW4oJh6b+IvLce6Y/MY0ecVb+WBSjIQ5aBpwujLnXFr7JAWlwStfXN8AKWMnLwLkBOweccFsSZDaOhqZMTQprLz8Cr58oShj90gZ4WZbaqreKPxPy5P+Tualnt01DmAIeE8jRpgpPgKk8Zm6um4e/r5w0Z9Z7SrWRVlrW90r5lUFjJgCfS6Mywzxo/6+TtSQnngt5mO2RnLd6e3jtv+fubYF2Y6uqSl/QItXI3zVVQFI8aJxzwMX6JVmwkFdNec5mPObhQ32raciI7lAJ8KcIl3NYFRCFeqtQIpvVOdiJuGtkHDSG1PWJzfcqSbBX+zzCpdd/12ZxxhGLDbGOIZZ8Xwj5AuBLV24VmXWZoEnsPLid+3OtZq3UbWpzle7Dw/qsVfcDd7P6dQf8FMFdM8ZP2hKvkO6X7/Avq3XdM8C+Jpuv/YeI99eJl44q+xq9mV9wGJM0nPF78CxnLliqTiXs0S1dim5QC/Z6j/LHfhf+3LXz54vU0+6BX/JZTerFMLvrBM3tLe7eSjYjxNdzB/P9BjjHOnAyj7bm5UgShIgjf0RQ5h5gGo1GJdgAfaY1xj4rGQGWoc09dtJacyXEgYCYvtxJeO/8RFGpfhErr/UUNgO8qOBQ8oUo4SNhZgonN7+2tD3VkT+Et7e389imbaeu6lfN6hWCU4sXSk=
Received-SPF: pass client-ip=57.103.71.22;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


