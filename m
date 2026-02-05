Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED229ECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1FQ-0006El-Lp; Thu, 05 Feb 2026 10:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1FN-00066g-7V
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:26:21 -0500
Received: from p-west2-cluster1-host12-snip4-4.eps.apple.com ([57.103.68.37]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1FL-0002C6-L0
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:26:20 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 9D2A0180009C; Thu,  5 Feb 2026 15:26:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305178; x=1772897178;
 bh=dXlBjrYQLV1qCj1RHDhCy7H3jFtP7Evi4SFhHqHKNZU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ENBADnzkoNDl5OBZPdbWIqtUwiBkYSgkgO70PHhezgR8d/cQ8bHIYWmWjGbP4WVYNEcuYOD6e09fH6tHI66lRHkRe1kdQLrThbx93c+NNs9rkZK641i6Kn416D5GVO/YkMEhcOe8SUU0K3mD+olHECSOYSs+jTtoDBzFVe5ByKvDwoKMSui7/dhLNTg5+ArQnVDx9mqrPQc2oOJGSSdbyq1MClyA+GfUPYYA+rWP2Y09JDV5IR3xNKH5aV3Bcva0P07KX23nL/lqfRy5q284gFIUDPItY88TnjyRos07janXMfRtZJvEWcuYySUcDewr739o+kCIdiHaUV56PdkpnA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 CC9471800601; Thu,  5 Feb 2026 15:26:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 20/22] target/arm: whpx: instantiate GIC early
Date: Thu,  5 Feb 2026 16:24:23 +0100
Message-ID: <20260205152432.78208-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=6984b69a
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNyBTYWx0ZWRfXxGVmfT+fCapt
 6kHNW5EPw5GhhlhhAc36BRHUimvb0ASpdEW0z1T1vuBCDk1uzNH4BOBte9lQP/X+xa185pgsUm0
 FXXfvXXd4yUVEcdJo9pyQwdUYW7RqcC/wAKPsXBjS8Xlr/o6mDOPIBWoWXzQUfh/9RTu2E1CHBC
 de2pihe+Uuyxl80D3qdK6cMFmp3LdTYuLRHRFKsKfNrcAlCClh9GgPOIX3VZrvbCe8ebKbkf6kk
 mtdzjwiUx97AtFIsjL+WZqR1jWiESa8f52ApkucMiVwjtSojd3qWOpC2IFBGUq4Lj5N8CzOHrqB
 SM+jRyatb4naBQCvcGrKjUL2aNHFxGDTkxIx8tdYvjLi73uEpDqO7Fvq5x5smQ=
X-Proofpoint-GUID: ZeEMTcdl4gyh1Zjy2ajy4efgwof7T6ug
X-Proofpoint-ORIG-GUID: ZeEMTcdl4gyh1Zjy2ajy4efgwof7T6ug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 clxscore=1030 lowpriorityscore=0 mlxlogscore=994 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050117
X-JNJ: AAAAAAABAh8VMZMQ93+hupIk3nnqhKBuFJuvBpfeowqn9hzHvBpRdoR80AG3mzl6QaPOReC5m7b4UMoyyeBZ2Fi3DOCKQmuaBTJwI03FV92LuoW5B8Cf/x3uRz1sXCmkYNLEDXtO0ptrLFQmw3CwMVeMOKLyrs1Tx4S7/s+OBK0nSUmQ27eW8Bserf8Kgt1xMF/W7hdSk0kypB4IO2D4lP/+Xl7toK7/oqOzvguE57/VxD0HpxgKl5/US3cr1QH6dp69+abqWYPTuYVeASAKPTibym/TfzJQUlFqodVt9kghy8aK9/3jvQ5y3X2Q+uvuM4Y5JaSjlwS/f5mNI9lMqNgyQrbXGfg0Auwaq6TKfL2Wcwj0eHpbDbtYDJ/mVuCcTY35bjLvLTP3RUHEaw2WbusAoWSZ1pQNy/8dDv1cWvcFRal+igdzAX/mWEDh2fFRlJTgwFELKgLWAK2NEZgZuque2SrV8BO84+ZOoWC/vXYHTtAPAfhOYzUTyvIDewa0m8YXCHSPnYqKScAupkNeJYCI/qeENOodqlNUar9Gx8vNnBeGG/jMgMhtJUTNIEx54WcMgfAR17CU1DUavSxtc5rtC2O07+0ICY4sG2N6Vyn7F2eC8eN53YZ1zWjskus3ELUowGWmYQpp/06Ll3aaxoJ9Msjo/Xbai1eNr56NpIXLCdCwaMQOEtdB0/+uVi6+KIcjTC5YVwFnTj/Jh7tmL6ug34xh7Kz4mbdxEa3R+AgycXalvHDxCFfdeZuguZL+MmOSw/ZZX/9u7rVvb4G5jkI1NxraPdrPRm1Q15q8t4JpUiQWMya+0cgifhIMl/5psNWBaRQQLvM4ClRD/jllEptTUozhliAHL1KqfXo2Bx09t+p1L4Q7RPTnetRYjgnlWegvFGgp7aOK9YzNycyZbBv/sFZeJZ2YGpEbs+dSxNr4921SmPCwys/puUwrqLo=
Received-SPF: pass client-ip=57.103.68.37;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


