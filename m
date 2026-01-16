Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAE0C79FBE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHb-0005bO-Pu; Fri, 16 Jan 2026 08:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGm-0003gO-Sm
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:48 -0500
Received: from ci-2004g-snip4-6.eps.apple.com ([57.103.89.69]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGl-0002LS-3y
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:44 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 C90C318007C5; Fri, 16 Jan 2026 13:53:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=kWlYH2zxPGMFUp9zi5zlCqc8M33cVVw5F5YOcb3QJnY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MRaiBl296iIWzdAAMSZiVfVNutwmghfbIp1ZSVfz/Etc0dxrTo1cKOpJkStmkxm6EVrOn+dov5CGJbDMTdkD2SxIoWtx5l5AwKjUMI8KZXlNqDW9Yuwrd/MCMZh16nDRsIzab/nEpTl3n0upVB/7sz0DPE1q87lNtoH76F9x+396yxgblZ0qfD1Z+aHPcQXuyYSnYpuLrj/wW6rlROP4ZwDFeAYYDhbrijhv7jsxFVJzFZcdLWiHySmuOPIEpdoIeLiAIMDKfFAoQ59ANpzJkI516jiHkmblyYtwNCcDsRbL7NYjn0Ko5QNQcasf+3PRlglgbUw+GxWBK76L3qgmog==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 4E380180F92C; Fri, 16 Jan 2026 13:53:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 24/26] whpx: arm64: check for physical address width after
 WHPX availability
Date: Fri, 16 Jan 2026 14:52:33 +0100
Message-ID: <20260116135235.38092-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfXyr03FM4AHRME
 V+mjXmIP+AgqoS6qGZ/vywgshRlQiFmu4krxr5Nb581FyZ++zVa4owlz2xGJ4KatDoOx3+o3TMw
 eNzQyjsB72RqgTHbdp5bTa3enFLUftd9+iQMHXXG0LWSiTS6vY8tDDqIRG8En13m1p6PrlRDpwr
 eqsukemPoGIfUB9kSBuMGsvu3Wd/fzElo4mOGodPd76wQ6PmZOEbuPM2xcTWWc4goalm3loNckx
 KdLXAWTsVjugRZPFgQnY2s/I5rt+TH8A5jYriskoEILwPSAwCx+MIq+MQmPmPMYTrdGBmNFgOTt
 o57QX2XuXFs7g4RSbTB
X-Proofpoint-ORIG-GUID: 736C79dmu9fb4ACLLMZBvvW3V5QrUWLe
X-Authority-Info: v=2.4 cv=ZOTaWH7b c=1 sm=1 tr=0 ts=696a42e4
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=GePjjIfFpqe_pMnJkREA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 736C79dmu9fb4ACLLMZBvvW3V5QrUWLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=995 clxscore=1030 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABxyTEDjisQRaQvm339nVTKUMbgt9mlZXl0QlsteAmOzJNjXWrNe4T4NvdKP/0RKojFUD2fakAN0e4bDFi8CFYvkjKQ+c5SfrPGvY010ZMkJa+CUUC+exRmNkNKWe4AFQs5Bt7K4WH8hfsEbLiQeP+/sVz7zO0OTCemytk2x7/GskIaDIbxTwyU+gmP8Ogk+yFdx3juIEIcugmFwxusx7wJEcsSmpWLCMi4/neE0jahGwcqFlNOfTFLAA/ZhgyyO2fa9CypkqIEL8f3rl9j+TjvY/AOZh308OPN4sdmH4BDqd0xFOEpT0zk0TCWm63F8A3HVxehNyJVl+Gm2ADuNkBHMhKRS0uGfbW8pGQfc2ZdFBynGp+0cVISLxRgN1i72X0hjmFdxMnx/rtj/pX4BWicCpc5tN6slKa4Fj95vri/Llg6pRBJxAk7Jhy92eghJpCk45+3mnk2697zZizW3H/6+d3Wpq95ad+/JTBFy77rHJW+SF0DtrB671cJ3Q8AXbnJm1RLGIMQnmqe9NoMP4mWITIOUBknn/9uJqLrXcyPAmY3CTA4AXywWvxcK5BpZr53AwRaV/XkjC50SGcEo71EYqlh3xmopwefXqgZi3kf5a4VZUVbird2fPNwEvTcbE90ZN7qONOTNZqgsN2BFq1rhDjtHfjoItb9ZCWMSbUy91b5AFLMgVaryWbHx5yX7QbwbemDU5uxrz9tLpzqcFSwpDq0z0OWMYA2PMTZd7y0jpsFIM1f9sf5HnEA87KGb0dJfl2B2nLT/uu0pBgFyPi+c/ZfcTsWrduGYMz+CnAz6etX6M2cSElVn//edBWiLyAR5YImA==
Received-SPF: pass client-ip=57.103.89.69;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3329deeb57..79e9065d3a 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -654,7 +654,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
         WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
         sizeof(whpx_cap), &whpx_cap_size);
     if (FAILED(hr)) {
-        error_report("WHPX: failed to get supported"
+        error_report("WHPX: failed to get supported "
              "physical address width, hr=%08lx", hr);
     }
 
@@ -874,15 +874,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->get_physical_address_range) {
-        pa_range = mc->get_physical_address_range(ms,
-            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
-        if (pa_range < 0) {
-            ret = -EINVAL;
-            goto error;
-        }
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -910,6 +901,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
     hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


