Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF55AE8B39F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0Jz-0001Tv-Fp; Thu, 05 Feb 2026 09:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jn-0001BD-Nx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:52 -0500
Received: from qs-2004c-snip4-11.eps.apple.com ([57.103.84.33]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jm-00084P-6s
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:51 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 881BA1800D95; Thu,  5 Feb 2026 14:26:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301609; x=1772893609;
 bh=dXlBjrYQLV1qCj1RHDhCy7H3jFtP7Evi4SFhHqHKNZU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XkIVNnNz82CWM+qYWwiz3YEsCx/4rOy2n1VHBJQXZgdoDroDh8V3LY4vCG5uDrFeXemRvfmCOb6A43GSpc7dUsoV0OBk90r4YOIHzTrwMgHV2eUfhT6RX+fwNMLaZqoODnZg9ps5A8CHuhyDgytT5R3TKw+Va5NZgPZb9gp3JFtYzyAdDJfK+LOCnXjZNQIgY82s1RcDwQulm6eDycDR00A9y1FYSBUGZSfwQYM5ewk9yDRH2AIZByxc2IKSVvAkQteY80l2p2ip7CRQkqgnN6PPTMOEuUV2deYBdjQWlP4h3VrPVjof76SIVoSdvwk98yrOni3xaiIj0uEDlEMHMA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 45FE5180014F; Thu,  5 Feb 2026 14:26:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 20/22] target/arm: whpx: instantiate GIC early
Date: Thu,  5 Feb 2026 15:25:38 +0100
Message-ID: <20260205142543.64818-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1KP28ueGUCRvnZaT4BNeKohuSDxEUWHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOSBTYWx0ZWRfX2+Bp5Jmem0Uk
 Y+1Zr4XaD9gJwe9a3ipdHPGPi5oKWctV7Pim0PZ243QgvExdnq4B0sbWckiEsvNY1BXvw4XqU/A
 lNWxLWAaMex9SUWh5I/7letT6OQ11KpXAx0lwCOmMidynd+cIKTWpG/2BNLzNcxLr1Nu6NEHqN5
 nqJogb2X3KZd+fVMfL9r+K0XXapNoze5+EM5w4OtfMun+OViP1p/BluvOPHZ5wZsMmMoZB2BVNc
 Au9CDO8deSpbJVUsRW/kKIq9O/TmsDpBS1jkLC/pWj1T29j4Lkljhd4ws9G7a/bjLR906rRObhP
 QYjdDl1ROVJXvlnthYjn+OJC3FXwgF9M9WWaPqWm/vFcug9HFU9ttHwgeT6wG0=
X-Authority-Info-Out: v=2.4 cv=WtAm8Nfv c=1 sm=1 tr=0 ts=6984a8a8
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1KP28ueGUCRvnZaT4BNeKohuSDxEUWHQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0
 malwarescore=0 mlxlogscore=994 clxscore=1030 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050109
X-JNJ: AAAAAAABn2pqz4ROYjwf2N6P3LvJPTSYadLkCDM4Hbdw7hcK4dQB0hdFANDM8MVAc8Nt0GaVLEBrDpuZYP4DplIUGiEmB89rOE3pIYNv36gauICHvVm/fflxYR6R4UI66RcnWroqWY/gToCgkoJBZKscwg5gE5U5cCxfzNopdMO8OV2GvtJI2prtFDgZyBcxwFZfRQYUGZtFsP0EifmRCgtRWsbhBax3Lh5B3NBrE1DGpUr+kNDAw2hSSwPUuqOmPCzbMwxW4N+Uq1Od9CO5n6ERkAjbJVgddzVcgv79B0bFq8Y79Ts18gLV5okfVWBdgs5L2p62+Aoqg5Amf3vEZLVgHDcod8gTBdqTUgd2/8OFnnIP44CCL8999eikdrCLMh3LH+HBvd5CRhumHu2Tp6YH/R24hftErs3x+NTSQshAvx94rjRB+kzkF8Bp5Y3EpX6v8Z1HdDtkmJ885d3qL6tq/yYiPuRvaLQcg3gF+7/J6wx7bEOpGGgvWEcmBxoYdU2qQV6fQ5TLpco9ME9rH3QG9hSYbW4xWstmmG2JHmAuwSnkl0tOY6AahjqGmQYwfYJHzrRHnoDoMalPTT2OgM8aGhJvdcXuoWs1koZEe3IG5/pJbmXkWXwWuLLRyNNc5RheK1WdsaVlCtNy8r/piG9lh6FKKPXq3Qi4HyKzML59yGCJePXhkqPSnv5wJuI4U0oKXvHKiNYA3gWB6PyCBF69/4gqoY0Gy0RLngz5B+iYya754OgbgggUKDRuGBLoANf7Xc5jUVMMTm1FToGacavPXu6IBOwvyBZu7H2PqJcD2VTZ4lO6S2kDrPNrgyQT3gxpJYBnpJYj7jgc3ezxzEgclEfMirKNz55nWsC4ycddxVy3+Tu7SU2I8gxqpAamGAit1ekwm4sqJTuQx6OeOaOURES7/3SLbI29fwZd9xOp2NiakJiA81y6B6Hplw==
Received-SPF: pass client-ip=57.103.84.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


