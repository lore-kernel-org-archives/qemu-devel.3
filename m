Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADFAD3CC8C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB1U-0005yq-Ni; Wed, 14 Jan 2026 19:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1S-0005y9-Uk
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:34 -0500
Received: from p-west3-cluster4-host8-snip4-3.eps.apple.com ([57.103.74.144]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1R-0001pN-Ig
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:34 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 2CD681800452; Thu, 15 Jan 2026 00:15:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ksqwamjc+5RKV9piY5vkALtcG0RUP+bOT4m8O729l+Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=gTMP1R6bC6EeMD/YW0hlgTez9KCB4vhilrRfPgr6DPjfDdCuFwSu39hmlcZqLfrA28KEMVkk928vGQyjzlgMfGN0f2qNiC4e23fUPJgpL8Zh58qJ68Guu0seNt9sXG4TpHpfhgS9qf+o9KYaF1eeDCfAFkvF4o4MtZfcqcQXaAON+f7Z+Ajbqo/6jvaO4Kx63nZjVrNmPt+Cf0pFiM5+E5NYxKY/1UKBfvBAW/kddEK5ZAdLxsjrmlww59HOphyW9xg3j+wkGC467L+ViVv5msV5O1pPRx2tIRYzGbdqECrZHECSvCDX9ybTB08NGDizZ1Gtp3ExUHKAAYO6uF+JFA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 C9ADC1800430; Thu, 15 Jan 2026 00:15:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 02/26] accel/system: Introduce hwaccel_enabled() helper
Date: Thu, 15 Jan 2026 01:14:41 +0100
Message-ID: <20260115001505.57237-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX305nvJjifuEG
 jJ1RLxyT0Qbswawbypa4CL0Pq6idzL3MRxqmOyO9a1thPUQx+Nmfjpmp7mAj375CbkAsO3YymLC
 PhXGTAdJk1+fU5sbdCBaVyFec49lsx6hXOVUXMyfV8+2gY7aRtznXyocffI1ivUUZtBaK+MvmDi
 vBi8dSi0UwJKczjQTO/q8oe+jOXYo/alenu8glb51gRRS9GYHF2kwLkybsSLTr1W+0DAaT5QhzR
 Bj4jZ0scDXN7pmvUVZR7gjK4vcmRr5xu0cFkRbjDoWO2zcebPgKerytcbmOmWfWULU35FMkgwka
 DV9ZmTe60rGonYt2tUV
X-Authority-Info: v=2.4 cv=f4lFxeyM c=1 sm=1 tr=0 ts=696831a3
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=zYwLhoXY7WJC0OmO1EgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: emQ7N1tHdKfoVbvSo-3wZgKw4Z5LY6tC
X-Proofpoint-ORIG-GUID: emQ7N1tHdKfoVbvSo-3wZgKw4Z5LY6tC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABvJT1B6xahH4fjaGiOQgugX5HwZt56FsFT2QkbKcig+15KJukNWRK+32AJ7E8to2S4wRfShcuMUdS1GpKfir+LEOGzB/tDxP3GVLME7y7Q2nWZJ8yxctHJis+76Mm/rCAg8iY7hcRh+I2Ixq1UKYZBaY5RoO78wlER5wy5iTGAytmtN/x1aYfkOAfgXNLmGwChpC5LLre8TQBXPj8mZyYMPNHW0y5y0241PULlBTa2C3aF1clcJXmaXDCfBzz65cnKtj5gTYeKgzQwgqOFBRXP75Ts8Ng6sM2uK+bdk3BxMoacBG1VkFM3LMFkIS8oJ0guVf+ZKiU7z1EufM/reCHwltWgJlKeOX3Ggwr2mm1lqhmcnXR6gMjnwzlKwiWvoKKf9p08WRvR141DhZBSYOEzZqFwfypg+qzT+pWKVfuljwEutNU9qOmmIHp6ABRMU12UmVG4yA+UfK9m2e41KLI/gEruJbiSRzUiMPsmiHimEwyLIsBT9sMNqA7NbJYbbiJeZVVnWR6yWzQca1mGEhU7QzFLiEkZZynTX+z93c+gueoftC2A4ahGzPMtZiR4IwP+BSQztyd2uTGdo/yMD1poj34pwk/5VFTISA0S0ochwKvzPOXpZxfnwX3ekjloELNAJWAQOtg9LGxbjeHS7M+ORhx13xyG6YTQD3zCyHNoVUOWHWNMKuO2/vLB26cTpSj8pSpd1pfQET5J54kRfWi+wOF1g7Rtg1K2dQ6CgG267YNgi9sdGyvB4N1x7bT4H2DciGj/PdJ9nFv9r6OoKBxQz63NOypD04hB/FZzuF2/1pKTFsYBmi2aPxtELihiYUs+ZuS2uf2pUs+lk+A+r8EV9NaTiwBSevKZJ2yuYhwnTIE8IFjSV6XPhTpk/rj5Xh8QVgiA6xb0TVTV/WWol+NUPtxC6d3qZ24f1c2Y77xAow+6jMlCqP7Vls27JwldwFefi3aAwMwcaTEkn4=
Received-SPF: pass client-ip=57.103.74.144;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 55497edc29..628a50e066 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -40,4 +40,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.50.1 (Apple Git-155)


