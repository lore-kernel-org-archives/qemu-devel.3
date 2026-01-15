Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6431FD3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB3S-0003UH-Vm; Wed, 14 Jan 2026 19:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3O-000339-9H
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:35 -0500
Received: from p-west3-cluster5-host7-snip4-4.eps.apple.com ([57.103.72.7]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3M-0002E7-Qk
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:34 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 4848F18000EA; Thu, 15 Jan 2026 00:17:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ECjpVySg6XZ/QHOAAJ+X/A1Hu2Jhdy4KwMcQqAyYNsk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UemdLdlnW3pw756109SGHhqjByNQoXkKy8QR53VjtLsW4QmTIiiZQ200Xy4OId6+BeqNUQyRAX/B1uxpRmIA0mNfLtHATtYarZslj2FOuuJ5KEGaXi1TFj0UbL4s+fcVN4X/LjOrNDqdnWMPHzO+jHoxQsRKEj3rI4Ry3dnUw42cQ/IzjXz0BDOdHskI10kE1NY5tqvAq1A3/jUCiLNou5tqudCb4w6spfTyKdt18NyF29HSNcVJMHFfQqKk+sRj2x7x1p5QVRRndTi4J77EdWDH7ogeG325s7iz3+JavmReVNiNU8daXT3UMEdJ5EvKHzRgFn4rfQouSIxa3TIKtA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 23E181800464; Thu, 15 Jan 2026 00:17:20 +0000 (UTC)
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
Subject: [PATCH v15 21/26] target/arm: whpx: instantiate GIC early
Date: Thu, 15 Jan 2026 01:15:00 +0100
Message-ID: <20260115001505.57237-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=NcvrFmD4 c=1 sm=1 tr=0 ts=6968321a
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -A4VqT8Yb9eqdo194hmSRYXls96GieF_
X-Proofpoint-GUID: -A4VqT8Yb9eqdo194hmSRYXls96GieF_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX134Ykxz/O9dZ
 qdUr0a7n9t/nBu39RWn+MvRLDdC0uWWn2m8xeLfR5xbCAMxH1EtvqfzHhew7+z2TBbRKE7FtUmb
 yHXWXnpHBkOn50tcYxxzvRpp3xPnnVozTDY460wSemaqJCOx1bFsm9FIkxbdPgdT1xYjbFnjML3
 luSb5wEUwmOYlEPki564bjAmjgbA+3LyvPd3NqBHdFtuO3WQgPp2RPQUMJMR4yt1VKJwUYhjX1c
 Xoq2NL1laGaEGsbCIpa/vwmbjd2FgUIfQKXVuBgvTIJfoMU88/FoyFRKdcG4NdQQ2QNk4hQCB6t
 tKRHXll/M+jh9TerOcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=729 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAAB/g9miUHotC68RiIo/rG/KyaoUrevrCalQcvf3K7BMUg696QP243Wy8hynCqU2v0hes0HxxQSriSW59wxu1ZqSyLMqL5XDwL2o9/GYTkVWoskctwOdfck28UZcU4yODbMWUNrxTLKOTzx4aS7Ezb94e66NxYBSQULsPK23yGupbnL2k+o7sbnmUQnLIuXp9HeJ5BmYs39Y2ggnPMdbPrdN5HFESNhMSWYwkxioCpfE93vK+IBxE1ZaE8V0Ts5Ojsibu29/czvTUBKBMUopnm0jmMZMiYxcbxkI/kEgAIPmhUMQFP8Na7FhqU6sJxLOCmo7lyk8tZjyp8nC0DK22INasjsXFUOCykshvBVwrQeIJFI8LZrJPhwdCS07imq/GJ9p1tuB4lZof26jjkJtjhmV+tybae+wBZnwM+qXaN4q3NqQYRIuFCGrTG5zP+FeCeGntRx4jhyz7s1kVQxFgTQzV+U2rCLIgNNZY9XPZilqOddXhBXXDX3uzQ+okJgH4Z4obvo1XgK/pIza5RMF0OFEXBwpTAHmmXa2WXdJpbHzSdPnHthEeYkVkgBt4lnOaaCU1xI5YEQpgZBfJx/bXISx3NheJsRgTdiGnjYUhEpVKaYAeUe2OvsBUHYTRwlNX7eG2CWB2Ecmn/WBAqnesf8d0W8OwKprHVoHETcc3tLB521gImGpIAVWfkD5JBze43rs4vdHQNS1CbghqRgmftY/970AphdV/8fioo6s0bHFDta/Sa0AvaoMDIntc60tcueS5Lc1AWr+sCwdUedy+yMSls6U20cQ+NS7w7WGWwrAyULZz418gl5yW1/Pb7/zUuB8AM8TJVCVDiTTrIjyg6HucpTNduyveMpenRhpATEywh0mJUn8LWPtIrHlvl9zQ7BbmXIwovL9eFPfIZH5RC7CjkRFBRb0hVLI+dQrI8jxDACA5J0iI0TFw==
Received-SPF: pass client-ip=57.103.72.7;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 3b79b8b376..ab31371aea 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -945,6 +945,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
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


