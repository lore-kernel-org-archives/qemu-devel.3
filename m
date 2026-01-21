Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D8CC4452E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjq-0000Nc-1R; Wed, 21 Jan 2026 08:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjJ-0008U0-E0
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:41 -0500
Received: from p-west3-cluster6-host8-snip4-5.eps.apple.com ([57.103.75.58]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjI-0007Iu-1F
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:41 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 552B21801079; Wed, 21 Jan 2026 13:58:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003919; x=1771595919;
 bh=PcjPOdVBa/CP6TAvf5jcUZpcejVO2yq94+CRQMtYY5M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FSuJpjl6lDKtwOcUScrp+XlGxIlKb2keo7JafuyNEkM9dI8b9tCxmCtHlyr2SbCzuu2pqC2Yti/+lVVe6p7IrBYpvRDnNrCu2l7VKnCiaDuNqj9TIA4z4OYPgEB8lAbIYhkARyEJRJ3Wsh43TNAbLds7jH3B98nYbzQ0TA1KiY2Hv/5qhgu2LKStyE0KpOOkktTmrjpXfSnw2dhxLkO4+uGU5N+raEgj+WxIZGGPQRAwm+St2ZlfV4kb/3niwT4tkfNfKqPyAEti9lpf/qW3+b4XrV74/jXsc1bu3y7oybv0gkbdN/eAQ265e33mdd8hR06ywpHIGSaORiBOk9D3dQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 F1B631801051; Wed, 21 Jan 2026 13:58:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v8 07/11] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Wed, 21 Jan 2026 14:58:12 +0100
Message-ID: <20260121135816.21258-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fbKgCkQF c=1 sm=1 tr=0 ts=6970db8d
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pMrQYBbJY-ED6Z46rXwA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-ORIG-GUID: OirI9zHAc5q6tNaVaQYvW17grtwXRo60
X-Proofpoint-GUID: OirI9zHAc5q6tNaVaQYvW17grtwXRo60
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfXyMoPRPvtXUAC
 iLPCFaMR6EJVi4L9S/Sf6WY/7vYV6d0jHHfbuQS7XsNLTtSs4/sO4lXBx1GBUAEAFTK/GY+zvms
 IHyfw5MO2nhtgzXcucmFyMbjGHvNjckU5YMZQga8FvVMDXDp9v6UgOFkRLOdflwSqmmfK3FwqbS
 UOJXvbqhJp5nAHc40I8p+PD5AiiKJus0tukJnysWFDk1eMV2TZWY6wIowTuWwuyTx1UTjmKmtMm
 qqhwdpJ4T8kf+ReOUgWINbDYKdxM6RmM1LCpDtvyNkYQtC2kzaxZrt03HsIJKaIqEctAob+r6UK
 iFiE0e+23H1P/7xIgOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1030 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=639 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210118
X-JNJ: AAAAAAAB4ShUjoLlgKNeKLbROh2XurRWYLebh2nlPZu5hX5a8pPfTwt7mtIZV+0/8+o/XoPSCqzAha5o59S53bovsTrLnXisJbDYqf7vT4P0zZJAeXMoVndhpB4HrzPkWwMCpTPSAtRZje2YALPj8XfBuYaZivmD+hRvGEEkFLeJSagFSVth4crQks0to5VU4X1lCvW5kdTbSc37qoCCmrOw72AVYX52sqVLAGR7tnyy5iLXwPeMj3tIlSEZZv1tq1W2ykvu1Y8+E71OIvalnOVdJTg1cArmWq3ZbzUm+cSrreqvGZF3zuOAPxpSyaXCCc88Fzgw8+AWnJ9002pp7n7ZgiB2SRjQ8qSN7GJ8k2bPPbnqSUvqobK2o/1+uait0QlOP/HcGlSjnWrREuibiWfpMi8FRGfsZzChuyP+OB+rkvWUsCtXYANBYhvsQld93AxKC9veNb1cdqje7mOtl/WUYwP05dB3TRFiKsF///CF1GYzcKSzAbHr+vWTn0sr0w84Vd+iWfWHg863mbC9WWfLNbCSY2IYsphiQt4g0sksBwtaBbER1clWGlirfkYNl6RcDz1bH/3Pl9Y2yQCb8HHiXyy7FnrIflsivJLz1fkcPe+FV++3Zr4BjDdZOLHJnsg4o91DUGMpPJ32Zb2SYvcw17l3Iiby16IvlHTP+mslQu1miLm3B/NyUrwX6S0M3Usw731JnZAOsnu53l8v2/4=
Received-SPF: pass client-ip=57.103.75.58;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 13836d6510..0d46073fd2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -809,6 +809,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     SET_IDREG(&host_isar, ID_AA64PFR1,
               GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


