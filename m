Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C73E92725
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0eW-0002Iw-2R; Sun, 28 Dec 2025 18:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0eT-00027z-Sn
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:21 -0500
Received: from p-west1-cluster3-host11-snip4-1.eps.apple.com ([57.103.66.24]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0eS-0007TI-56
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:21 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 003BC1800755; Sun, 28 Dec 2025 23:58:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=SIxSFA0VmEGoMlWfyikaE4kpHd7S/1I8D1yFZzd3Z5s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=eKqhoxotfXAO3nZzopBIkf9KhYF46ZtdlAdLucLly6TEBahnqAZUBxpyXxvUtYi5lOayv9gS9KKReP7FjUDeqlKUfrpORrQ65shfQkP2UfvSMxdEFvD/CGkMXXQQx2JvEk3JU11J/f1fwwWT/LQrAZ/rsC2Novjw9tQmiD+zpLy5Iwj2sn6jsORXrmiq269UJ+a7oqOZo0LJ/dawAr+MpD4T0gignjPf0EmNnpr5KOynAVKyc9QYm9BpBrjJIGfPhZFz+oXskzmGFqHq9Y09gIFWYYbEZBkiX9CyyG5tPBE0kwxuma59offKlaM0Hv6uBU1QvCF1X93oQ4SGrzy7ZQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 08541180075D; Sun, 28 Dec 2025 23:58:12 +0000 (UTC)
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
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 26/28] whpx: arm64: check for physical address width after
 WHPX availability
Date: Mon, 29 Dec 2025 00:54:20 +0100
Message-ID: <20251228235422.30383-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R22yr3iHXzbLNSOLcCo-r4Muc--TW-k5
X-Proofpoint-GUID: R22yr3iHXzbLNSOLcCo-r4Muc--TW-k5
X-Authority-Info: v=2.4 cv=FrsIPmrq c=1 sm=1 tr=0 ts=6951c41a cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=GePjjIfFpqe_pMnJkREA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfXyia9Ph/XIE5b
 gX7U8FhaMOWQgb7T0GrUdK6u91rA1ige7YFnNw8p++CVtnlKyteqjJAXoENWyMWKkFviPqQjImU
 /gQeBvLoirvEx66BRoFeM2HHM8jCu8vOoFamQetyJEzkN48O7WFkjFFUaxnnHO+962Irw4AI4dz
 L2rscAevsw69KOpDJ9EeVNJCwnZiT/VktU0uM/7heetB+BWScjBe2r5edwk+yjTpCGTD0IZu0eY
 QjfEOm+149qPyaRT3jPM/q/MSTp/juIMPVedjnySBw9ywW+oaLNiGd/TNnk4W7KzpdaEzI70FWF
 rCHoW7YuhDKgO8EoNcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABbaj3v0A0TchpYF6qqu17QHycPjpvNl4Vv4ZKOOb1vxROCTqOgETSoB0V79Nq2CbW+AhFlKX4uK9ksr+JSmmFuRkM4uXB4cf2AJXvtNYXCXChW4AX1+jPOyWPxnpcpzUYq3jfHeGjiz1xfI++RjkjNoLqMd2qt/J+4+HicVKEQkzg3iiAY6kFwYmjetphmRprl7DYd1G5cOaGwlP8zZpYfEE75KEn60s8bSi62fFMrNDPUbYB6zvrVXPWMrRdDHGIV3b/+08LExWIM4UcaXDTdIVCI53GVh0FPOcHvy/zOtpFuEhXAEunYnCkKjofQdHXwSrQ6+ZJ9wQQc/cC1QdvjUQilFdgNBtn1a15EsabALlV1gL/eneBQwPq1ANiUMy4HwlDa0L+3dciRCqLIz1CZlM2OQV7pPrjtbGUUeD2IqL7UiEryUNbu8bTYtVsyZSnkJ6Ac7hfhBg9qD7kYqUQMvKnoITDKlCZyCIOQAp+TcPmtyhBnQaFgLIye4nMFNU9F7KPaEoegX8os8qGr4qRWALY3O/EPKGGCH6hHRbkQjcsJxN1rYppBaciH2Os1+k3daUPccpAp3q/E2UEQ20+xOUtzsj/ZtR9V6iekg5ryULGOVarCjkXWVTDKQO6mFyHOOUbJSbLc/YX4Wg/whOhqqvG2LCKpjSyS7xwQLUZ0BbZ4/K9uzY7VYH7WuaX5Y2pRfAlCKyqHLw7cnVt/zhPM4tr5RW2jLCWHlfDjRBVk0TmCACV11dqfg3LNVqbgJ12l8NMLgfr6g2ouehvWkcfMO9605UdcgJI74dLLDtjLrpYFrRhxPQ9DAKMdAY+t4CZDE7bT7ZKHEw4R3UqkiRz3ivhDD4+tnz49s5NxEcgKVIxAQx42RFB4Hg7lilpSBG3kZmDQ2xNnwslgq73k/iQ5eQWsQmk+i1at61U3HleaNOxSqU2lOl7mN77iS86r2p+og0YUSjkg1++skTDLnLVyJZ
 6
Received-SPF: pass client-ip=57.103.66.24;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index eea20f5e5e..2e5ece45ea 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -678,7 +678,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
         WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
         sizeof(whpx_cap), &whpx_cap_size);
     if (FAILED(hr)) {
-        error_report("WHPX: failed to get supported"
+        error_report("WHPX: failed to get supported "
              "physical address width, hr=%08lx", hr);
     }
 
@@ -909,14 +909,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->get_physical_address_range) {
-        pa_range = mc->get_physical_address_range(ms,
-            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
-        if (pa_range < 0) {
-            return -EINVAL;
-        }
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -943,6 +935,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


