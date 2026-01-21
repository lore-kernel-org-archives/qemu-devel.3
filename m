Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D52C4452E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYTv-00066B-80; Wed, 21 Jan 2026 08:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTc-0005Eg-6m
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:30 -0500
Received: from qs-2001f-snip4-11.eps.apple.com ([57.103.87.63]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTX-0001PI-V3
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:26 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 13154180010D; Wed, 21 Jan 2026 13:42:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002941; x=1771594941;
 bh=Ki1yWlT4xhz1Duca55DyBS8HlXuKABmBDzqTcLTcEsg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OEPETOx3UTGrfozl3q07imHvjrDOeBBOiQ+mHGy62V7RA3T+E/xTYcVBYX8QtWAs4Pakwyq6hr/IqW765wuFQbdvF66tz7wGyLUSeOBZG3usF39JWbhuDxxDmdSYG4EUge92HBULhuiv2NgVl0uxmYbdY50qG5iJt3xmtVgCh+8RB3fWTd17dQ5sQEm9BIlGWbCC/zNyD8gwBSKZeyEVfVVqiMK6CUGVtdvMZVyBUd4hNovyPibeJkeihtxcoromGW9lSTuZQDAgYFurjq1Oh1B5xejdV+yGOvdklW/6NAJgndBzCr/TFhZdBlLB5e4u9NAHQitmJyWJU8z0OjElqg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 E7D5D18001B2; Wed, 21 Jan 2026 13:42:14 +0000 (UTC)
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
Subject: [PATCH v17 21/21] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Wed, 21 Jan 2026 14:41:12 +0100
Message-ID: <20260121134114.9781-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfXzrdnB4HOMoVj
 vWVR6TNOKWU+H5dWNb1LC39nynyufq8y+vURWANM0+mmI3pmJKR+5lC2U1p93urhCTVdEOOGV5A
 4wr3MMqURYWmjN8MaOgFLwQpEbqXi13oMK5FnbfyyDcEYWjLPOZZVdeKbN1fxdta4ZYgLk5cAyj
 uy+lvNUbXTQzNXoNsrsqSwO1UOpWEgu9az6gwdTpQdvcyxFxwmnaodmOcyGKIRlwKJIxeYoIo+C
 ilCCRwpVs7Xquav03WRe5391277HS0i7cTj+1B3jBPrYhnmw52gs/bn/mBGtP7wQUKXzl9ZOddl
 8A8HUG5z8wm5l5/Bzzp
X-Authority-Info-Out: v=2.4 cv=JNw2csKb c=1 sm=1 tr=0 ts=6970d7bb
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NutVi0-pop-C2vGoq0vXws2u2rhOf_aV
X-Proofpoint-GUID: NutVi0-pop-C2vGoq0vXws2u2rhOf_aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1030 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABPxSeWxZIDdtaYWx0ssDvnJZH/HaHO0Vag56Evq8SO2flHejya9/bW0I88su8BWU4neO205YNCUPHnPrKeWUj3x1pNpzXxG+3z1DEpZu0/U53IXwmkk1s0CCjNqQ7bHU/AJo6UzdnMO1D5MG2e73oNXG2QIR6AbIbxRZ9j3FS/u2kwtyXjxuAhFswa19ibjP1/gruk00OgDpnoakTntivOuRzEDjdoguSS7uPaFLqf7GE/pIhXtAzBWf3nLbEkgqnRXwMCFKkBUSPgzqNe8ysR4auz/aZPm2lrK4Q5Xuhh/F2tfvbPyhdkYi8FZtoaMLwSvn+f1IDb/EyMg9FWodZqstPN43/2r5NjrCq2B2sW18lTwFIr/9gEgjmO2mn52+PCIOm6ArKOkpoVKnA1Cqnn2BdXh3ulzP5jizNHxK0EonQeKfeZMmM7tVpF1JwVQVgmtAxiuupJtxIkddiXvRjiMca/XezF3puUgqwsqIxDYoT2hDU5OojiOjUVCfKaX4byaxqNbpdx7mowj3T3+2srnw/kZAqHKJiYmZ+bTMhfeR8Udy/ra+8xRlW5pKb0l8h99Yps1Cmromy0Zy0jtgsJFM0bG5ciYn01lhvNmBV4mQfxsQnOzStFEfAqidIYLTz0PZKdR/iNeatjsk9kcSQTOx8Qd/4xJ4ty8rkztjDaj0Uqng7Upl5pz9SBOwja7MZ50mh+Dl+mFvgTtDPfeBeYWr9ncnfVVt6/2eCf9rOcv2s8PAQcyfge+zYCzOST7+HB0xjVkRViglzummL1UStB5g/SB21+qfGoKGJIf8N8F2qSMCUMJgaxaooCEEsxTSly33CotmUlrFAuFdV9t20Y239EeeMrFvCPDFKgTKBzRP5YC4lw7baCus9zwPnjAc=
Received-SPF: pass client-ip=57.103.87.63;
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

This resets non-architectural state to allow for reboots to succeed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8ded54a39b..ad6ade223e 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,8 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 55773555b7..444f8c3d42 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -497,6 +497,8 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
+            /* Partition-wide reset, to reset state for reboots to succeed. */
+            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
-- 
2.50.1 (Apple Git-155)


