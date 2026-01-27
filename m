Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C4FD2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrv-0001sT-Tn; Tue, 27 Jan 2026 13:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknp0-0002xy-Hu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:50 -0500
Received: from p-west2-cluster5-host7-snip4-5.eps.apple.com ([57.103.71.68]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknoy-0003qi-ON
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:50 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 D8F3A1800957; Tue, 27 Jan 2026 18:29:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538587; x=1772130587;
 bh=sbPjhD1HbjqmKWH8q+YsBZgWt0PU5qx63I+bE83pR2M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VaXldj8CzmVADB9t1VvdGbv5AmuzeiBew9enosF59GFEoTL8f4EYHRg7AlyqoGG8FXNZ11mQTq/chrdVA32JvqJkVTy2BHE7CWyha1sWWqaM1Hmyr9y4VKGkvCUn+aeJR6I87T6i42eYezP+jAHv3gvcj8nU4acfEBi7OrWtTMBe7cmz/8mGUBEeQQMtn7PMOQRKWgi/jPdPH9Cu88F2yNHoG9qygM7arvBdpZMajijXW5VBzgi/skRFIGD0+vMURKrsECvY+fY9bvz8F9koESQl+5iqCYJyUzqa5xb/e+EzaNCUF8C18A90v4GUSxakZuHtjbNyBhGhUXUJH4rGRQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 5AF521800274; Tue, 27 Jan 2026 18:29:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 20/22] target/arm: whpx: instantiate GIC early
Date: Tue, 27 Jan 2026 19:28:00 +0100
Message-ID: <20260127182805.73212-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Vucuwu2n c=1 sm=1 tr=0 ts=6979041a
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Q3zWLkADGGLB8svTqg_Ejmsr1o0ZHRuz
X-Proofpoint-GUID: Q3zWLkADGGLB8svTqg_Ejmsr1o0ZHRuz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfXztPhWY3BNgT/
 H0VM41E+l/MpDX5xZLS/SK2SH2CnHaYqdDzbDeMOD7rTTPm9bl80UuRz7lVAk4G9ZgTot4ESXZh
 NxrifaiaJWDyDm9KN9LEI55B/ffxod+iZ4kAWmFNK9swHLaT7UpbktkTwv6XQdplr1uJiN1bMvF
 FrGxU6rLm573AxmchqqptFWchiOroV0qYAuNWzrZq16W5cNyYqLvgiZlYrGVQVUEYEEZN7eDG8M
 9lyIFmZAB9peAP6bo/inaoqyzi43FFzV3FcthHD9vSlyxhS/QZA8zW6r/63sOeN3z6XNJCpdW/B
 MmvS0k8A3/ksMe92J4Gfj1LOgcfdeIZju8lHco7OCs3vN8+akgWxhPJBCdVujs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1030 mlxlogscore=834 phishscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABXwTSMTBgmk+NbTnTjXIk08uunlBORcDEkUQoElniIy+BQTNUFOQ6yZaFsYLMz0PYihHqMQSEuixfpOrJrSIx00unB0kaenp5kOUER/pg9TQHIwvWB75E9cxjNKo2e/g1I83DHIq84kqIMVghMaikEG+l12Rp3TbqR0/dNhn/BcznHZJabAnfW6Rv8Yr3ZdwMdi/Qa8IqD+VXBnzavfWQuMxJOuFxXdM0/FRttmhLzxpXrD9Fw2VH2a93w1Ot8c8lkPYUVC7iYfEeBq8bIBp6ehmYxsdw0P6/uRPNp4z2qcDHjD6H1HmZPL3chRggJYXdPLqGP8yGgfSZjqWLEwMK0+2XHHRdjH2kXJyTw1UgiSJbQFnAcp5rXHruqr6CKaaepBJjf79552aZYRWGILMPACePQuoHlqRnjeF91CZmu7U3c3OZiUVluVdS2L5IXyog3yBLOJwgqdNC5PqrA/pkqckuDxMGL8UhPRGtBfI7b5YEPKvCHE96MsLvoG5jYCvk2mxwKAoi7a8XC935NOeh2Pqa6C68gQAP6mmEUpr1i4+Bqu5/xTP7ykJkRAQqy3Z5mSAdEXFK2nM+/0DDhFLLayEVObMR1nbld5LvOuoQJW0vppbsg+fvmad2aZb8wM49sTqfepIWOJOuiw2fXKExYfzursdada3G1pbcfT1T7wZvh++PoxJdIMdLJLjoBkxh6NUWvt7l989HuDt1dbk8Zd9pDQJQIUAgpQtPlzd6vhwe4eddTcAcC7BnEkbOFDgH+buOmUBY48CD5iIJwZDjbm4oDiuAPRaiL2sapI/+cpqzQbEXTF40vGjPYaKCdUfOSINOje8+zuxJeXShUtW+CRMw+m4NXkctbvTbiulQ2dv0cjJGoCvMd7ajXx3oNjVPu6kMqp0KuTEWAaYjAUdz1tJ8l4P/GPzD14Sn
Received-SPF: pass client-ip=57.103.71.68;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index c88c67a9e2..55773555b7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -939,6 +939,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
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


