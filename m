Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F0DC2A07F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHJ-0004h7-Id; Fri, 16 Jan 2026 08:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGl-0003d7-1U
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:43 -0500
Received: from ci-2004j-snip4-1.eps.apple.com ([57.103.89.94]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGd-0002K2-IO
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:39 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 BD79918000A4; Fri, 16 Jan 2026 13:53:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4VCTN0/YnZF1hrPtx7tmA3Evz6xoJllzV/zRgIOe0mw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CmQBvKXf9ycDHxoSnfg7AnGfUAdsEI4lk/KiaG+8W7dIp6qqmDWKn9qIf/Aa9kjeKXsWD3dyhKBBDDtS7p96beJubbSAVcrI6zJ5opCxHQyU+8ya20k9fvF9zy7ojm3no0nEAndc4K+40A2q+amO/TYi50wYgYqQ5T0JkYzRPmRFQWaqvXBdZqx24vn5PaS7ZpilRG9K2gZJrkZqPV8MSrL8XzU7/AI3JA29/quF3d1+DGwQUH1dO5zpd9kFTbz3rNd5hJDgigqY0MnWjjXrhlGW/vl8HUzvZY4+pLWU6aALo9/QIKxm9CpGBWvOv4Ktd+SEuTnCzy66k9qmLpa3Eg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 ECAB8180F909; Fri, 16 Jan 2026 13:53:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 21/26] target/arm: whpx: instantiate GIC early
Date: Fri, 16 Jan 2026 14:52:30 +0100
Message-ID: <20260116135235.38092-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfXxJF5FRx/yw03
 TmRd1LniPWZUekvv6BCfdEZOA8FACbCw6GHcS6OG5DJCHImneBfg0ssyrTP7v7autWy1Omc2FUS
 FwK939g/2lqkfa9P1nu42RKdRpQGDCJZ85bYdF8Pem0ykTgdMWZdPWpw2wBbzyUVy0bI8z7VR5H
 Rzfycjb8Wp18jFgxbLjNmq6UOAVRqOeLmCr78IXaEcDQwdOXoFu4eOEuMI6RBkhiFSOhkdvY8d7
 kfeZ0Kyd5SfJI8b8UiI+ePG4EwEaHEUcKWBKxEvbU/u1tXvF7n+7yTk4iPAyx8k9yza/sST6Y9h
 1I3t/rR7amJxN1CQFOo
X-Proofpoint-ORIG-GUID: CJYHErZ9CJaEkwJcOwPzVZMYfy9455Wc
X-Authority-Info: v=2.4 cv=ZOTaWH7b c=1 sm=1 tr=0 ts=696a42dd
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CJYHErZ9CJaEkwJcOwPzVZMYfy9455Wc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=640 clxscore=1030 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABoeu5OZ4N5/JXv44v/IzlNcrhhG9edLXkaLHio0eN6qz8nyXCeRwNMGX43LmxAzjpeMxAbv7Qele3zGUETw8z96C0Zr6qyAVVNGD5A2jMvZzW2B3ZkAu/IGdNlAst8NVEGpv6z3VmgdHUx3Lgvb+Tsx7xmeiKviB+hC1yaUeMwphjsScUqAe6ierThUCvV1UVXZP15RImhiXhx5xrYgmZwwakqd0pLEP1CYHIdF2NJlWv8M94e/I+vXrFSwCi2fqcbQyBc1CqgfKZdyq8CgoFpJz9l2eLJx68NuHE3gD+eAZYlosqPUFGpSzZxxscT3bYbIpm/kzRN/9eE4Hpyk05ulAMcwrmbfdVkrN2qbQ4F+6W5Ow8jTe0Gv7iRK+vlaqdnp3Skyc/K0Oq8oL74kJBeb7TYGboxyM2Op13tPrpxTSh7GGhYX/AUBQ7j00LtUXw5RCmzmKbwxk4ZRRKJgtn0B0pi8pLbne+Uoob2xQzmF6TUL6PyNdv3C3PUrIUyfuU0MSHUhAr/fZydUOS/FziAuXurVrS6UYPQ+6ZvEnGWEjEEwTQsTH3qofObedICR0cUSXae8etg5NltPt9p8T0t0DT5xdtAGBHDypzg/HFxya1mPWWYfJD7X6VScsaSO+2yOnzOMS4HGjIY7SNruC2zewCj1RpfM75upycAtKRiIEBtAkQOEDBlNAOo/np6pblUdV0dYIQ5tWJFGQBHUUx5MnjY+4hFbUD+UxmtP7f1MiolgphVlEGWqhTwo6oT1Z6O6Y09RVouK7bN6vfa1Mt1nrHERtlc+O2KPc=
Received-SPF: pass client-ip=57.103.89.94;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 78ec109589..3329deeb57 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -940,6 +940,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(prop));
 
+    WHV_ARM64_IC_PARAMETERS ic_params = {
+        .EmulationMode = WHvArm64IcEmulationModeGicV3,
+        .GicV3Parameters = {
+            .GicdBaseAddress = 0x08000000,
+            .GitsTranslaterBaseAddress = 0x08080000,
+            .GicLpiIntIdBits = 0,
+            .GicPpiPerformanceMonitorsInterrupt = VIRTUAL_PMU_IRQ,
+            .GicPpiOverflowInterruptFromCntv = ARCH_TIMER_VIRT_IRQ
+        }
+    };
+    prop.Arm64IcParameters = ic_params;
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeArm64IcParameters,
+            &prop,
+            sizeof(prop));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable GICv3 interrupt controller, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


