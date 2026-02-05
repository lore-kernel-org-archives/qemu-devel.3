Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF30EC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzB2-0000zv-9G; Thu, 05 Feb 2026 08:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzB0-0000mB-3i
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:42 -0500
Received: from p-west2-cluster3-host5-snip4-10.eps.apple.com ([57.103.69.93]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAu-0001k7-Lv
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:39 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 58FDE18013BC; Thu,  5 Feb 2026 13:13:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297215; x=1772889215;
 bh=dXlBjrYQLV1qCj1RHDhCy7H3jFtP7Evi4SFhHqHKNZU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JeWRtP4YfiCvuyBd5n5UM+KJYM/J8ugUfBULeWDoRTB0CFrcD/dnxDysNiyXBJmwkA87GWw35g37eADFIrhd7kjb99TRTORClkfMFzxm6lTRXlaFkmM8qgidcSDWHIyloWW4LDMAVr6NI73ulgvAF4S7Ph99P/5wXUz29n9Eoat7PQI/eKlMizTXmCaY/ZTd8GRN6n4ZSDqcETb+UO7xyUZWG1BgDsZz92GeYuD/F3jRPFWT4bAu/p3HXdrgVSnICcIQAIZbTas99Zi5RPqS8R7wxrd+50aKivqHXpAn1xRbMKM6sih1LPuavPGCL8erJpzgqr7cHk2hGN8eNdkm6Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 D983918013AD; Thu,  5 Feb 2026 13:13:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 20/22] target/arm: whpx: instantiate GIC early
Date: Thu,  5 Feb 2026 14:11:49 +0100
Message-ID: <20260205131155.22780-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=6984977f
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kzb3O3P6X8-GeIISz3weWsSzonM6C9Ny
X-Proofpoint-GUID: kzb3O3P6X8-GeIISz3weWsSzonM6C9Ny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX3dvba7s3Xmhk
 Vn4MTY4wjv49cLmU2o4P5yVP8y35wHLL3ws3mXh8GlT2EVcPeMDdcLAo3nS9TumkmjUndMa6Tuk
 BaoJd1PPkmlERzdrAo9KmaJjJpYNm5544zO0yIj2cNS1HTxHJJ8UrgVp+dhMD9ct59bdUhkZ01/
 8FnYo64iOh+FmxpqwCRWY2tLOTUfDfLPJYmnjGQU1n/+Po6N2BmwwjfgnLR7AJsezJ1qUoA+nxC
 LC19dueK+zBjlWv1fo6cBQwoh9gyF8BuXz6qmzzyIESKml3qFOcGaqmwHJChhF/Z1WG5IbclMxd
 vGJCn3aZM0ZbdS4P/seNWeVTWrhezaOBQX2ZE1Akcv5HRbsA6oA+gVGddrL8DQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=994 bulkscore=0 adultscore=0
 clxscore=1030 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAAB8k5TJGMgXs5ErlxVMXwc06YWmLHs2Zbd7c0GRu6QtM3PJYPXXg7bUdC3YjWah+Ob/lAvA8FILYf8naDJidNgn5ILMLP37pflBkd91OE+y7qj6GZigkjD+t8JKUfNx8awTXAu5EKa6I16lW0S/BC4rSwrj+FCgbfhoBYkuyZgKwJHHd97t5vxXpGXVmpnMABFfKZTTy/qAac+6KbUUgz6bBCponJPqmKVVKnVcD2/SJKNRb1/y6GP8LNZb/nzf3HevLNf7wBYFV68zayX3o0CA03f5JBs7VzFZrGawWcBmmtObXNGcQquAbtcisQ1DFW93K6ozh/vl/FJiQD3p5waY2DIa5/tmW0+iUR6ejnFKoRNxPMCxde8ne6ow7B+D1btBzv72R0I2isNlbsT7JCaQb+JtebsqdUDgSRX9fS5UKc9pBj0Pn7+mGLMsup+hrHVi4V1UpaXBrYf538jXJsDY7GbmKn3WTaWcGlXDUJrC0vPv2hXlIrlr2JBpXSJc459Rvjr91TLIc3lslp1oFZ5mlQg4DHZ0t0iZSLWZV6bR7vMaHxqATmaeDH++hnbuBCsatNFEHDVT8Tm9uuuriBxm8ssipqRaGtCXcZFk6ReDB9SzJu3K6UjQX1OvN5CIE/gwrbNBVRbIXthV4xJJm76880/3nhr0GEnOIMl52jgOojcGpbTheyxg8UAKkx1mvP4Cv6wn4KXbzXyPQZHYt2dzGncBGVIDikgIW4/IRvMEvvjRAhboRryW7vh9VmHeIzCc4k2puW0HddmmlO1vRVbu8p1r+7+3ZhJW2Awd5FCMjaIR+DPi2Bu7SdQ3leF0uUOJhB0Q3MBJwVT2aUFez1dmeWkVc5FBm/LDBmlxQamhxrAGYZehx/hW4RvHMGyKP8QAbePMSIABHcMbamPsRtUE/XekqO70fn+icSMP4cfwv4gBK4ER4o=
Received-SPF: pass client-ip=57.103.69.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/whpx/whpx-all.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index c88c67a9e2..44ef42307b 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -939,6 +939,38 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(prop));
 
+    /*
+     * The only currently supported configuration for the interrupt
+     * controller is kernel-irqchip=on,gic-version=3, with the `virt`
+     * machine.
+     *
+     * Initialising the vGIC here because it needs to be done prior to
+     * WHvSetupPartition.
+     */
+
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


