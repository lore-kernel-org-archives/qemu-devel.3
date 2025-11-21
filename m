Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A440CFA76C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO1n-0006hp-K7; Fri, 21 Nov 2025 05:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzt-0004uj-Gf
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:09 -0500
Received: from p-east3-cluster4-host10-snip4-7.eps.apple.com ([57.103.84.100]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzg-0007yV-I3
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:06 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 E8DA41800115; Fri, 21 Nov 2025 10:03:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=NISfv35M9InW+WYqdgS1TefB8mG3dHrbDfxOShpOZkM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZEVEEChHhUa1oRvvXfqh/oImiQ19Leyl6MFF++CMqWaYLv+dnnt6HjEGi4WSwZgbiv70fTnSXdxUOiFzMTRDrDJNMxSTbUm3SX6EgM31zotQGIFZlMC85uF81jzyN/cr+DvH0qlI81xTmnRv8kZZvAGdiMoF1n6M3eqedxgtBGlVacpJdvb3XhJraTW2ulM1hlfOhkPyPb90fgtep2ehnBHPve6reN5HLu+IbKc7w44GtICG94AatRNJuL8KW5azwDwnh/NggD5e99Y9QJqO6VOLN/0mW58pZLSG9GbiKdtEpZ4qPg6rkemXqU+17ffkl/ruTHu007Z1uIGkHqsS+g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 84C48180110B; Fri, 21 Nov 2025 10:03:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 23/28] target/arm: whpx: instantiate GIC early
Date: Fri, 21 Nov 2025 11:02:35 +0100
Message-ID: <20251121100240.89117-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX3xvwN7kcz535
 21uIHm7+M0uxGrpmFM0jdKtkT/P5N4tHkwD50+tPnplWeUvNwCzCtOweX2M9DMkakQNe7dOl6RV
 lrUsYXSjKjc7dWgHqRNDMNv8kiweimq28TQ/KG4chA2I1/uznLeZekylzFjaVMHFI5l8CIe3ro8
 dIVjKBhxxwShkit9Mg6ohYEuxWyYZwGB+5UIRWdR5d5Or1EjRV7tmddA2CwpNPT+7Lgz0SFnjxt
 ljUI2EsBCQTzX4haar+rfD5o+nWMObZwr1xrvC3NNo4wE1NS8zh+8IbDi8R8O1OtQOKBJGh9DcE
 CSbh6QHxQ/pwQsc7Oqe
X-Authority-Info: v=2.4 cv=Wr4m8Nfv c=1 sm=1 tr=0 ts=692038ee cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 32r5HhJO4S2EoCxIfCzorBLQ1lNpfQS4
X-Proofpoint-ORIG-GUID: 32r5HhJO4S2EoCxIfCzorBLQ1lNpfQS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1030 mlxlogscore=637 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABGHInSqTj8Huo91Lq2b1Ruyqg+d+3X4Dj/oErPOURTSvrB3H1O8Y5QRzlKR+SdpjwvaP1G9h99sC18mWJB1guFUYEgeF2yIGr5K4LoobrVQc23T0T11JV+Ctv/Kd2MaGxBs1Vx+kKx8PLtAQJ4gxzJh6lDVvizkWZY/8fJULYqdvP/Zn7CEAcf3808rd8+Se8yTOsl+7qb5ZkfLc9DLHlyYFi3dF7Sf/PsVxXXSVyT1WfDePzdRO0DElaII7jPonSvN1/TdSXDrNhF/OlpraVEbHi/7vhh3Pn8m8TKr2wGVTe2G3Kzo8tQg5DrvylZPtnd0vnz7AUI/j+R9L7/bB0Q3c1nVNn/hCcbIcjoNQ1sSKqh+hNPwOfIvOgkdwg3tmMm3GrQdcc/dWD6rCYhWQLh34FRUKMRJlWN/iAi6iQQZuwVMDY3lfP7TKcnXU0iFbAtDtcqFmrA6fS2bElDJji0Ian6VK/RA7un9wX0bBFSiATcnbhDndG6uyO6U5mzFxX8Jd9gdYyKunYcnK01gAwLwJux+6DFRn1XkAi51QZx6K6EXv13rgg91lF+rniy8ZPXimtZnlxu7FXA19tG5bIwKl28VS89gO9H/oEviC1tazzBBsvKLeHzOlXMVqVqn0BPoP2eztqKXnS1FTgcxCenJI+BPMuDivHFxloKCl0uUQWcO8N6W67A3XBnlin24imnqQ9IRha6VG0lq0+AsldaX+jg+e4JvUS3cXJL+35I7dBDekF6BRlEZI=
Received-SPF: pass client-ip=57.103.84.100;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
index f8a8c06d2f..5be1abcfc5 100644
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


