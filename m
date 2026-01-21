Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C1AC4453B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYTs-0005ox-KV; Wed, 21 Jan 2026 08:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTQ-00055O-HH
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:18 -0500
Received: from qs-2001g-snip4-11.eps.apple.com ([57.103.87.73]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTN-0001Ne-ON
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 D01301800135; Wed, 21 Jan 2026 13:42:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002932; x=1771594932;
 bh=sbPjhD1HbjqmKWH8q+YsBZgWt0PU5qx63I+bE83pR2M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Bu6nH3JEsOl+6Ss0HjMCYttDwoZeuAL5UusRoXjx3uWALj7bUydi1UZcZhyv3/wyB/mXHK5CbYXBLMpWNTzikspFj/i/Ij1f2G8hDzefHM3KvGkVpGOeXtbcmFT3JXNNasBHMSV94gPEgj1v3fyNI9kEoPwaa0szktC8tQ1D7LcHbkOUwZ7uesG8IJDNYpkEwTtltE4zRLqm9LtsbUP6Tc6HbuOTkfkx0tHY5lc60jrEuU+VbXZr0uVblkP427LRy9PRBGLOgFRm4gfJDkkBzNgpGmvGeKA1xSgSrUnpbr96H+SF/Gf+MF5o0zF5NFw+0cfYLcAA3iQ+koUXXe3VwA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 9848A18003C2; Wed, 21 Jan 2026 13:42:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 18/21] target/arm: whpx: instantiate GIC early
Date: Wed, 21 Jan 2026 14:41:09 +0100
Message-ID: <20260121134114.9781-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX9s8IGHtUFhOg
 sztlcPFL/npoCWbGdVWgRnIogtzMYYySmflCnge/N8h3r2Vf+kv/vBR4HeYH+8bS+NrqYGf2lfl
 dOhchQLj63yOKe94pjxhZs0wfXQ7MIKgknTK8Q9PRPdQMQHd7mtyJW5U59HO8aFpaLJWzFBQ8eZ
 VOLHDYS5TOU0VyMiH7q51Iy3fdImv4BIgwOfb+xeAb1bh9jF/VlHwxuIrnTGVIu1k53VMq+MBEY
 XidBHuzCOa0XONAbCNcc8UiDGgAjSr+mKsCunLXoNDSC8bZm346UZMvFcIsRNiPKFnl0WcbUplQ
 jFpq+LYXrroWpQ7dyk1
X-Proofpoint-ORIG-GUID: 4F32_9lhCjIRz_K1q-JDD3hVOcz5gfUn
X-Authority-Info-Out: v=2.4 cv=ZOzaWH7b c=1 sm=1 tr=0 ts=6970d7b3
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4F32_9lhCjIRz_K1q-JDD3hVOcz5gfUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxlogscore=804 bulkscore=0
 malwarescore=0 clxscore=1030
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABF+KLQgMruWkHV4oOtrqXgMR+D9FbyM1UehlGUs2gnDcL393i2WBaF9BD4p6CZrZcgMiWENTDwxMQXjAckdn+e8GXY3hVzDMbOUA2hK4DVNnimqv6q0KNsoXVGgGaErZT+VivcGUZDDq+/2hTDX9bphJl/dR0u0gOgDkxGok66vtsXVOGa2uEpBIk5KgS3YLyirm+41Sw6EdCI3t/SnWWwuDoK4lFXl+IOLtk5H8qwDJr9/1ZtC90I+ag/47b9yY6P956v/Z8s/e+TFgw41jYCgqTaj+Ue1O0f5Z32pbc6JTouwCxribfPQuMlsstneWvnXWd1KbsSsPCoNBCPRcNxKy3mfoWb/wpl57FqMwrO/glAIhsZxfkJ+9nvWHtV3/aEWbdWSoJ+PxxAusk16E1UTbU5s0cXi8dEQ4wpXh+EcgX/LaglnBjJVcK5LZDSAaC58RDFnSuyccazE8DAanUTxkgCHP3U0SAXE8NdGQMaJwRC5ESKlaBWgESNdVQwO3+mgfatvdyriQwr1CiDN9L2iJVBgEdJQyNSgJaVSEw+B57SAikH6KPyypN2IriTSt5j0eMkWeaJiQTejdhkGdgaNxtu7Rgp8JttGdvpJWrpVzE7/aduXBrFZHaVC/H7PPWKbiRIiUfWfjGH5G86QNyyQhCIVfH5Qm6C/2/yPDQ6KfQLv3+U1l859gLshiJ9Pm9kimgkjSofwFIQNMSvvIEwRoZlpswYoOfHPdghISYn33NLZ1+GGLZd/0FcEfFQVX5UOMEarQ4GAJbVKSn8MX5z1t82oA0PDgg31UibU9QnjngO2IK8rUQwKAcyxZrEcSm2HIGb5E8SafrpUIIRHflvCD6n6go/Kdi9Y9E6NvPyB5nb/YSGX6CAg==
Received-SPF: pass client-ip=57.103.87.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


