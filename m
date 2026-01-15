Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31D8D3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB3m-0005KQ-B4; Wed, 14 Jan 2026 19:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3j-000595-VB
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:55 -0500
Received: from p-west3-cluster4-host6-snip4-2.eps.apple.com ([57.103.74.203]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3i-0002Ir-HD
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:55 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 766611800412; Thu, 15 Jan 2026 00:17:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=j3gxaGgJ/UOlr7E7Wf1HhS3Y6+PzTtQg7lYYYapxm5A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WUPKWO3G+qTUjzeVfm3tOxfIIkQVN0eECH5wH2/qmIW60WWGmYtkWvAu91watGYvWfEo4ejWnFCd2nvJDvGQMV7HGKVKeWBdusNPLbFh+PGS+sxcoV9ySFP4o2TdRdI5pgl00mA6heV3rlH78aq4kOmJheIYPD6iuhpksAUvPjSf7zMMcwzEjUMOird3Hv5v4zErxqlWshNxIaf0xz4WtMcNER9F8AIViFAqMy4cJdBMQkjrJrrYh5B9fWH3Z1blWAU+8QhePa0FFaigzsVJw2+5n1syAwuiHHMXta6QyPC0hBpXCS2oYw+5DXbFIvKJpjIdC3IrnT2p9xyHnJJe2g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 DCE571800440; Thu, 15 Jan 2026 00:17:42 +0000 (UTC)
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
Subject: [PATCH v15 24/26] whpx: arm64: check for physical address width after
 WHPX availability
Date: Thu, 15 Jan 2026 01:15:03 +0100
Message-ID: <20260115001505.57237-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=a7c9NESF c=1 sm=1 tr=0 ts=69683230
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lhTSZ31de6YUvqMuns4A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BuuWRK_Lf1o0Y0N85gXC5QsfmjBvE1cH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX7HAmcsrnwADA
 Mfh4zNbG2bZJp6womv0C97Yfnoa9kr16AfsymB+GG6xzWoJ7KhE/Xf1u6vijddYm09tSaNBoBmM
 ihYFx4MncKEBLXPDEwqOJ27+2rU8mtcna9pKB2Mv4i0H75T2mzVE6tw8ChlwEQkFxGt3O8jea49
 t+ariZjcCHOePPDHt57uORPArb4FlcrtamLipQtdjq/XeEAIR9FmpcyRxhJZrgOEgULbX2Bpsi1
 5DqJbIarIxbQdMg6tEP6nBYvXxmLBsDRll0e/OMTzofSpKNql4DqAivSTQr4+T1puxNj34X6026
 QMRmMzIZPjnAiaHubD8
X-Proofpoint-ORIG-GUID: BuuWRK_Lf1o0Y0N85gXC5QsfmjBvE1cH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1030
 adultscore=0 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABRHA02LwuS8bMOV//VuGbwwN7qP1XWZWUe9FCH8SMcFY8uI578w7jFeKiJKviayplt5Aq4+z/heNzIT+b/Eoq9KVNXzJqmF/V9CkMTNvJN2Gj7umedawJh6osIlTVw2FGk9CiuBhjFGs+4IW81zbBdnNTuO6L069xizv/uJxj49QsTro3N7Pyap7Yr/WZjyJKsGEiVikAWGT3AZnuvUPQONjNheTy/2PXNjxaxJFK0GFDTbbHyqB7PYEm1l1ON9uWJd/Z8oIZqAh/UzOyD+DCgH77QNJ2Twrv61qviTUYAhK7xftTAeld+CBXS5Upzt8lQ5rPWrze8Mzl9Yb/0cpvzN4kQVTjQL5CDW4BpaKsEkilBjEkD3Vbc6osMnojJGV/L5zZyAFzTf0SeUVw4VLgZQ9Ll9SB4n12yIVrc5bWJ1VLIgdw74QvgHYTjog/fZuh7xtM+j1r08+hBUh+iQGoq1H33gL3ZTRlF3g2glkpEkqvvt2QQ57ZKS12aYluJt5YlhTs0/Gou6lc852qy1KN9vY7gATo1zrdYYgarL6fBgmTMb6XMMI3UjIJX0xb97xjIixcDJBM4Fb6vXnl/HVqSi2FnO+07B8N7KPsaIetGz2nRvsl5+k+1rVH7pkBmIjfmlVsDGW6eQf/X1IdhBxDclsTrUxUyB1rZBDcSFqb5spyGcHObFax+HGDVQq+EamBXShnQxOjOXZyNQYd2LmXjbdtHB/BxVuZUQwCgWWZ7kpJ1ZpEQ8tX1JBdXkO5Q5gQDQigBopDyzGHIlrU+uTmlrJjLVOg9Y/+egYBut4QK249wLRfH6csbmdgdU0Lraw+N27Uge/GwKuwgrQtGbevXKfBxeOR7KmDVRXL0I8z50vFdq9SrSVFCfs1Vj9wTQAntxpTezhT3Z8KlHYt/eXVenKbxrtYo6kgIV49L8OSDNQ9iZAMeGKvJ7gl05qcZZyO3ul2FdRpYTGeavVt
Received-SPF: pass client-ip=57.103.74.203;
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index ab31371aea..def85988e7 100644
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
 
@@ -879,15 +879,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
@@ -915,6 +906,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


