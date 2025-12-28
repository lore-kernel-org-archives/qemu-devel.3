Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E88E9272B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0de-0006bE-PC; Sun, 28 Dec 2025 18:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0dQ-0006CK-82
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:57:19 -0500
Received: from p-west1-cluster4-host3-snip4-10.eps.apple.com ([57.103.65.201]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0dL-0007Hh-HO
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:57:14 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 E4C2B1800762; Sun, 28 Dec 2025 23:57:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=end3vQ5HTg5+AzpY8GST0stqcJ3jw0HSal6FDpQd1X0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fCaFkTAcmAR7bY5UjYGhfxwRzKXb2rUYtoUPsZ3bFsh0knpKp55j1fsmG17w5N3XL+MbF0NHN0N1XmLDoA9eihyWrodLCos9riXzrsKv8ZQgqJ7t6b8Y7uVEx8bj98EmVCzveTO6GfMt6A7h+8aO2rzX6ceGLOcbGqinBlLtN3Pfqy3lUugI6cZwk1JzwhkZh3JSTEnsUMrfv4qSnEO9qUw28UcjNLezO69XKvzqyhTaWQDBuRpBzeMLyPySWI4rzBFKgKZ2ZL/8+qDw5bzTs6zW4V9hiiSF11EAD4uIKQRs69LwyWZm99h9e/BL45yzzQjc0vwBIJG2JcLZrnOicw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 201D6180016B; Sun, 28 Dec 2025 23:56:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v12 13/28] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Mon, 29 Dec 2025 00:54:07 +0100
Message-ID: <20251228235422.30383-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E2w8f0VWQvxnhwCPvvsEAMxA98TWUbqX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfXzcO8vA0V97RN
 YrG52mD+yBDw2T++nNEYr2m75efeDMr2UCWEGmu5eVSuqjz3TbrprYzIjeqgEN7dQ2ehzU+fKvS
 Maywgxde43OiXVwQRAdTvRuNarwnTGBLJhW2sr71MG0F9Y4GbrGm/X0SvSpqjr15fsDmD4O2/OY
 m/T0afSQlS5LV/t8d+o+yX4LTT/XJOwK3CoLjGhS6UCXVpWmnGv+FBJOJs8uX2KK17oMtIgFmoy
 Ef+O6kOrmwuUDLMTa6Uoz1CgnJRLYFHxdEKbIe0t36Aso2cVprEwwC90GH6AQrr88CUlcFPAWaU
 ebqrmPSHah23RBIUySw
X-Authority-Info: v=2.4 cv=X/9f6WTe c=1 sm=1 tr=0 ts=6951c3d3 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: E2w8f0VWQvxnhwCPvvsEAMxA98TWUbqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=974 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABhPhKioGqDEQaBe5+ImY3Dcl0TT1xS1aOq8PLIebodLzUvNZkcYH/4kaaS9tfLLwMGqmlBKI7mNFoHZ5etj59iTamdoB46YA+908TcWBX5xP9jkfhpF2N0XhNZlm+hmCXLVu9TG0gjxaXYUcWFayqoVzxbiFO4yzkm1iqgi4Kj9iLpYFQ/foIDXKVEU70X2UeApEpJj8dka9F3rYkW5V1QvZbVM8BRa7yRHnXD/GJmWaOL50A+8w/bsL3Mg40TqJygrn5y6/ZBPrnPJCqttv4ow7ugpRtVpsClp1GguJ7mlHMsYbT3I7EevT4CIkceX6fExId4lfQyUw7R5ntaURBDjkqZMhSbrc5sMhJhXeSdUsiNH6AA2fZJRFn9ITXJQCpZbb20H14FvpGUbEBE7Lt7fIY2+GOwNTmvuZ0xosKPMynn09WyKRxnEdNVGbT5Of05e3quUkW3/EpztL0GxiQyVcvj+ESBusI0DrSQrGWP5EIcj/TVVd9fMvNjtWnaW/uU1jG3CkW+C9JdeHbGcXP3FPeQq3DLaN3cdYF9Kq/qS7i5hG539nYoXgQBeSgdK1pdLtYEOQ/9ovl7orI9nDZys7hRLsk42QY8/y1H1zIoO6e8qWsm2Y8VHPlNeByASCAsXCjvBzBkSMRUSqHDT39w6ih0i8Ic0b9yzbINErHfUzBZla3LTds9DJnrCplTL42ffJDLvhfB4pKrizhp5obF2JarbLr4wy7DyHg5hrfkzAfEA4ypQjAR9LuK3g2bt5JgRH+LT+NnHhkbAgTHvNoO9qfZUe/HyAQeI3F4AsAIuSTVvBL61rPOiClzKqCt7U0hhnQW7B+MqpK0Npz6gow1mGz8f4V+xpZCspPSSiMIYf9oaMfEQOie38xkf5/Rb/wxeVYDIyZp4RUB1661Cpmvo4zyUFlZ2qnMeXIYq9Jmm1nE6HGq9zJy707w8gvc+OnCoYCeNkueg8pR1UZ1govwf5
 TrXfc2OmQovpv08oOAyo+nBe0HDC2kwPSxWVCdFE=
Received-SPF: pass client-ip=57.103.65.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 5152f80804..c3e8200c0f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -123,7 +123,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


