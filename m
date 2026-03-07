Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9744FCB63F
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytmO-0000kD-5m; Sat, 07 Mar 2026 10:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmK-0000iC-EI
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:21 -0500
Received: from qs-2004k-snip4-8.eps.apple.com ([57.103.84.111]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmJ-0001vR-4K
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:20 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 B42661800AB3; Sat,  7 Mar 2026 15:41:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898078; x=1775490078;
 bh=+9+Podwr/FWSiiIbKvGiXUj/qrM2SprCY9pTVBwpz7I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SKOHPw5H+k5b4DgQS8sGimbYkuqpSrMreKCtqCQTuO4Sc8aWuZ92Q86Y+pSnYndrEsugUxwU/Cqzf/Wmv5n/frj1C3OzLfFPkqVAXNLrk7FjtIoF7AwH7lXNQcspD+hQ5r5uxpnAU1UzlPGH6BgYOEwJzZZeoiNprAPbBOjuZjmjgSDyBU9KRqCoOnzKLwjJWQ/g0C8I5yJvlVWnH3yqFy9pWEonq1DirZPuHxl0juH7xhAyGn2NQ3L3uwzcqJyI0wjBq94/QQWqS3nkjLcss0CWpOe3ABCZkLOyVHwFB6/xh16RSrj3yO2Rl8vJiQvsIqtBJ7nJBromWxg3m/MEJQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 1E72D180009E; Sat,  7 Mar 2026 15:41:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 3/9] hvf: arm: unbreak the x86 build
Date: Sat,  7 Mar 2026 16:40:58 +0100
Message-ID: <20260307154104.84567-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Uo5u9uwB c=1 sm=1 tr=0 ts=69ac471c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_3_ydfWBwt0DpU-JqN4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfXxQSDpJ5+8kf2
 MLvCjNKgrhOcDMpfA0s1/Lk4ngCy2vF3xnBTUzeuHHONfI/rQNVRCu2yE4pUyByKIKM0gKrMI59
 /QirWCbRTYPpX/n63AXx/59t/d5BJ7hiToUUZc49uDGF57e9HZU8wDdtZW31CHgEnDyvUy3NG/4
 VHr8QgvuV3WINIzWTY3GnBHrM9A7NEhaqo3avoy3RYvXgL7BY5GqRM+0+F9wX3g7BkXwqqKmHOu
 Zypne2ks9XUv4+VXrlKmPqqYqdFdKfptvGxnFCCm7BHKui7e15rEzNAuPGgwsF4C0X+CGFEwn7G
 8rV1fN2cm05oTi15B657FppZh/mjRKZZdFgB6f5oN0VjKRD55HIKuFQ5a6EyOU=
X-Proofpoint-ORIG-GUID: QNfkN1QVikT6pR_5VQZil5qC6Zd8DSIy
X-Proofpoint-GUID: QNfkN1QVikT6pR_5VQZil5qC6Zd8DSIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 clxscore=1030 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxlogscore=667 bulkscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAABnrdGpNEAOmemQem9bvMpqj1/CtFAYYVGX3UGbCWKun4inZdjzWMK2glQNQrjrneM5E+aTppK4QQYgqJCi5Xkaf+SbHM2PL5TnvEaagn8SGjO1gbH+4fl/+4tQOwDRuKevjadR9D4ix6mEk6vWQxkJfaBb89+nazfB73Xbtl1YVXn83sJKfVZzdkZAFJlcyRPCuRnKQ+ngUKldCY0wLJmlQX+I+kkWjg/nIVjmqRxWc0t8Vzm2/vyo+C+RvZY6+IdlhrXwZaeiJ+1JDA6o3NZDVP5p1ODeemj0D5Gxhy8MI/XZ2XwemDf/cRQKawUZzvqgItmG07g3lMwirWXaoAQvodoKdOeEQs41aOmN/InObZdubN4IUgnQ66qkqOLzw6Fue3TwMRTQ0V3q1KToUYZE7O/HtM1/30WAt4TPb3/6V320D+WbVujDCBviblsfgaFowSVSK7gnt4SfE4/rk769O9qWP+tduX/4SB+HDpX18JhyRP+DGNT5U0IDT4eNFFS65S4uhzMcvP5/VhSMphd5/iXa0LX8rMgvz0ynUHUeGRhK6QLrlA7l3mXUjYkGDZnv/usMB+J53pYG8a50tW38wSUR2wDZ5qT6kmjq7mMSfSn5Ey74yHvLWAh2o2ajgD+0WCPJqMnOkrAFdK1leyRzrGM5xMFCkHsoOu5FIRfFBSRtXcVX8ofhPDYw6lpLEQgpln8tWgRzYAlsxk4q0eocQCSVJme69vvFL1Lce6gh3coq9bdvTj7i0BoLK99vq8vI6hw50lVkw1JoYG0YIh9Etg=
Received-SPF: pass client-ip=57.103.84.111;
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
index 6b1c3b9792..797da56c52 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -27,7 +27,7 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
  * headers are not available until we raise our minimum macOS version.
  */
 #ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
-  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
+  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) && __aarch64__
     #include "system/hvf_int.h"
 
     static inline bool hvf_arm_sme2_supported(void)
-- 
2.50.1 (Apple Git-155)


