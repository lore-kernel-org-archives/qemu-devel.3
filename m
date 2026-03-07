Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930FBF55105
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywF8-0005Ia-8x; Sat, 07 Mar 2026 13:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF6-0005Fu-2m
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:12 -0500
Received: from qs-2004l-snip4-5.eps.apple.com ([57.103.84.118]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF4-0005P9-2r
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:11 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 3FB271800115; Sat,  7 Mar 2026 18:19:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907549; x=1775499549;
 bh=XOOEaOtBZC6aiAXdM9D8RgIzSZ7nFzWhQdlk7srjCXI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=O9tyS6R4ZspW6vvvtOf8sAtWZegb5JXLkhBR57LhEypi7bGakqJRcS8KN36ULi9GQdQ2sBdra90bo4WNIUtzbUo7md2/ErDzujbRA6BhTJCCefnAqyQzK8/ui7jItem03btOWieymEiFdXNAU7bshqVjRV0Yw8Xx7VuHlpTUR+SDQ00jIcrnetNBtDMoyAJ4hWH2Og4ZKwgAWfG8xn0an/YKYpMtQRM76JDiQuXie+hXxKTiiTS+R6nbOuTyxrxhR41MDcQTjvV8Q83kM3NQedsPP2zk06DE8Kk5bIji3SluF+uWPkQsiwnNCRM7FVfllNnt2IjztCVXtJvMUv7GvA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 02323180013C; Sat,  7 Mar 2026 18:19:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 3/9] hvf: arm: unbreak the x86 build
Date: Sat,  7 Mar 2026 19:18:50 +0100
Message-ID: <20260307181856.2209-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NkWIX26e0DR0yA28MnmP5ckRbmLs94E0
X-Proofpoint-GUID: NkWIX26e0DR0yA28MnmP5ckRbmLs94E0
X-Authority-Info-Out: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=69ac6c1b
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_3_ydfWBwt0DpU-JqN4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfXy8gM+7DtM+gN
 Rvkk32X2+xhkPSGKcivW2q5/04nejti8ZfiYRsp8PO6dE0XxSc0h72jhzpi/5jD4MRnmeiXVFY7
 69mSS5r+7nMrSj4RhvZ6xqhGG/uEJe60YHhZrgf76LxQR5CUEY+utEk32aqXDiMjestyHBOnlQc
 x1f7/gBFaUAo0uyNzWMFReeTKRRH19AtLiMNZfNu0w5PFc5+0PC3Hshlylqda4v+HRpJgDPQ9W2
 VLoPG6dLJ5uAxrLkUPI22LFB/phu+jbwdnRLpKciRC9fmCiq2hlFf4vJ47UrcKx68kloOAmVot0
 DlCkkfL2n+mu/4SBaFOSGvDk+q+GJjHC5QvB0KsJDjV9LPFKTyxsnUa6HZB4x4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=631 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABsQLMYU8wn2LHNeyAagtTFGc6OO1EOZhx6JrVEzPEbBiztNjyR1AIUL2J3lmkrCom1wRWmcXQbfHlYRB7+qa0cGF2yka1UOpxrEsD7rOJ5KGFWC3vbJcJ3DeVTEYRB7Gamn5MWvtxt9KEqWhdnrzJaJCRhMQoTwxjzjFru7ACJuEAnPQkH0unwr0gO2FIQZduZijjd2C3T9nH+LWM1+cBMPJCqY+9wj1MKAHFhW8ZgUAtHTSoV4getb+ea+K/dARrCyGRvu9B4OR3Eq+TvXbmAcXVr4aOrWN3yq377vU24ifkvoAkfQJ8GsKpRUHghB1ZdluqPSN5ZDicuRbyP6KmRd5ilavtViGLJb4LvTKvnn5Ojr2rZf+XZMylW4oH8BLMHRpVXc0eAF8dQ9Xh50QptSEnmq7ae0sV8NFl87WikrhD4NTzwWZnRP3B7VJBSOxakeVudyHIWIK32QomSG1ei60i/0k5HOGmhZ+as1A6uS1OI49BkSN/QSjz9fpEjwVDZw1Ot32pQnXCgXq9jCjamW4yUA7cl0mWgYiQHeRBV9OxDusovuZHfC+dz5BdfMTkRsYiQLWJoZDIntqRNiHZv6VZfTIencFQLrSA8y5Jzq3yXxVJ812Ahagtv91VVKFmq1DDum90NT9cRFrp9XOmF7ZIiS60Lgk6D7ID/qYqvBJ34cnf+IM7/s/J9V5QbaUcPadsEf0C313Xow/imAi22F3D6Duuem1MTdHoAkktyNaxoJaoqEDoy3rRlJBY7xgYDkyh
Received-SPF: pass client-ip=57.103.84.118;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

We don't really have any great choices here, so use the __aarch64__ define to unbreak the x86 build.

Once the CI moves away from macOS 15.1 SDK to... 15.2 even we can get rid of these SME stubs horrible hacks.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr
---
 target/arm/hvf_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 6b1c3b9792..8029d48caf 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -27,7 +27,7 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
  * headers are not available until we raise our minimum macOS version.
  */
 #ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
-  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
+  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) && defined(__aarch64__)
     #include "system/hvf_int.h"
 
     static inline bool hvf_arm_sme2_supported(void)
-- 
2.50.1 (Apple Git-155)


