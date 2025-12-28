Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E090CD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0eC-0000Wj-8T; Sun, 28 Dec 2025 18:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0e9-0000LP-W4
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:02 -0500
Received: from p-west1-cluster5-host9-snip4-10.eps.apple.com ([57.103.66.201]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0e8-0007Qc-3g
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:01 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 DBDB71800757; Sun, 28 Dec 2025 23:57:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+MsdZaXBCYAcv52ZMhpRqZhO9PBpFu3UYyQ8HifZlzo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=T9Fvb5cktWFNUFS8Fr3BldHvZI465JH51lT+sh4vYDnTsqeUK23eZ+nAZmPFqspkS0R5EDjPodEAnI4qFtkcEOd8QYfw15iiP8N4AdF/WkfOKp9p8oG7tmupaW4u2DoxYeR5N2N1E389DKrSwKxxT2w9rAnHi5qsX+zQiPiPzoP8/nsIGa72RF0tUQtN22fO5FYIvkJCc0w5AxW8jWQl6cA8kTX/bcpqz07jcVDG/CwvVG/Q/wF0CFEhh9oaD2mRUTvZc/TbsMD1p2ppm7mCPow7v1GTPWkblCL5xDaoxTGqCwReXG33noCd1WR9NTo+7AuISLjgT5A7hjmPDurvWg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 A3BEB1800765; Sun, 28 Dec 2025 23:57:51 +0000 (UTC)
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
Subject: [PATCH v12 22/28] target/arm: whpx: instantiate GIC early
Date: Mon, 29 Dec 2025 00:54:16 +0100
Message-ID: <20251228235422.30383-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HKsoy0_E1L_w4rlWSQeA12sp9QnQiGqf
X-Authority-Info: v=2.4 cv=NsHcssdJ c=1 sm=1 tr=0 ts=6951c406 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HKsoy0_E1L_w4rlWSQeA12sp9QnQiGqf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX/HotgSTIX7Ru
 i8DRkFAKi3XN5M1EEduHdrKFEMKcRjYJf0vWxU5aiDAIggRUB9BdYWg63CZ5Crg6D+UbKmxB+Dz
 JSmzLIla1oObFqjPaek75bkPfgXQ2GngBI3vObWVssgfusvMHm7fKT+T+LM6mg2e/9M0JgpdSLs
 ibOcNDm29bYSQwa9RtMri2nwo04aglxouMCj+88Ic8seZdGeHtvFeCv4uJO7Y9scDwuBSwU1Rqv
 7upKzFONp0oufeeTTiUj8YmWF+jBpw7mLeSBj2qcme16M1JNiCT/eYw7iBUe9S3uj7qnwhESqfL
 kW6bMc0QIOfVM4dCQWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=624 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABtMmqNAFHGWJuwGPLhn2JvhGjgU3fXrKeNypFfFijJdCuL6htbPIxo11kUOLEgk0tWNybILP5Uq1t5zL+VubjDWN57pIUTtKQeaB/LSuaAqNll6raqSDrJB0RuqAf/m5eghcyLLNrnHCtgxpZ8UC68uq4PfkFmPEnE3vACdJQ2bcC30HBj7mBQDmFzyBTCAXWCM2VoZcqhpofbhf7CZ57S8oSP0dUK+xkR9wxCc5KVby7bqkyO+QhVcUzUPsI3P/dZDdiZ7cPT/8uOvNJT0SI9nvR087H4ghKRmlhxyEzNpfvFL0rjdcipG/2KnQRxJsabKSz7bakz3GuDOgbYqSnPWZl1owaZ9+1O2szJobJNzO85iRVuOOsxL+sAKfodXU2ug7Ht7UkacGU2vlAEDSmPDNlw0TaRzAxN/by7SIGUa4Kg3e+49mtC//nXv4WuFqBBMML7lexw1wiu3XFa2EyZTV7AlEJki6yu+6TGUnhykhZNyKtWNpuImuzFqGExFAGb8Qn4OJc2OAgVoIHZ66JxLLAhz1t4x0hzoeNz27UnLtUkldSsHispe8BdAV1H+CoRYDEG0m0XXxlVxspxdi9mA2ncuPx4S7GY0BLPHcuARi79Gi2imOGrldd3qGjdNKK5toQ4rEVqALTKIHSWvx+g79bwRSTPwoFZhTGkI3QpGLYh8d9+zkuI7TUo+Wb8nYSBBygGQdcSdIhIOAXWyN0tX86BzP06HkAOQz3TQFekNA6Dh3Rqfo68SkXNzIJdhoN8epl3JUdKStfsatkI6ExjlCuWxusNgOB8LLbC3J8SGnrM1Kj7cmq6fIT9BU6sM357fJRhTaJcZ2gkbyA0b76X2oirK5YJyDRBrdC75qUyBsYnK/TSN47/u6jrFlAVIhohEgPsjHmZ8IC2cNX14Jj7FTj1sLAMnehBca9vGeXeJXyRAmi5Pqsr+/YK5/0b0RaTg==
Received-SPF: pass client-ip=57.103.66.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 07bb6fae5d..eea20f5e5e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -973,6 +973,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
 
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
+            sizeof(WHV_PARTITION_PROPERTY));
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


