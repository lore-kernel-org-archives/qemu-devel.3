Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7431FCFA76A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO29-0007LR-Pb; Fri, 21 Nov 2025 05:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMO02-0004zm-C9
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:18 -0500
Received: from p-east3-cluster4-host8-snip4-10.eps.apple.com ([57.103.84.83]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzl-000803-8M
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 05ABB18006E0; Fri, 21 Nov 2025 10:03:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=x8a0KyKqMZqPAjtF/NyOtU9ZDebRbQF6KUUO9/a159w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=hDM1BDkNYtMkbaKER58+zGsmyxuJCQONtmW0WNhLZ/mJF5ZkonjIqERv3nTIAljx9QH9XGXAz4WOrQL7dMszoCUVWLG+v2ArfokYLl9+oKsRMPl0oaN1Rw1FRRJQ1vNHV1uutsn88NTD0gwlb6ox3Bi1K3m6qGT2VHaIyl/fHh2A8OImgmXZovq5qgS2qXZ9a19t7yns8ltAKRkZgfUKCzItstOpo5E150oxGd/hivM+sNWsXb0oLiIACU8zTvnyH5O23UNcv1ZWBLWnOKFNtaT1f3+zz76fydWXHECdXXik9sXOQGUA/MCWxxbBE4Vn9FwG0+l44kG45TJzBZqRAA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 7E4E31801103; Fri, 21 Nov 2025 10:03:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 27/28] whpx: arm64: check for physical address width after
 WHPX availability
Date: Fri, 21 Nov 2025 11:02:39 +0100
Message-ID: <20251121100240.89117-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xcXKJf9B6KPX2WSIuYXuBxGS7bMSizNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX/zoJ+ZEO3eLf
 UELgrfxvyGxZWDTXiZDvo88UsJizs4KSVboQKQ3hzHk3bNVHF67YmoITMzsoLECDuzPI0rz7EEJ
 J7/5itpYcw7ZGVPbhQ5eHQIkTT7LOBZxazyKeQGER+7BFoQenFPtIWpLf0e3ro3OZGsce4st0z1
 mWejK7Z7q0y3fZjwKbOfQJN3S5ekAcNyvlSkGZ0MFWssA4fl8sUmOVo5iIj5kq6jyp4Qxq4EdpP
 vfTiwn7EmB92tavNEMS4+6YqqoG3aYvrnmZvi4uMzfwMznfeoaei/fnkQ8NXsr188ZPe+7udNAA
 4+06fQ7xT3NqnycDXwL
X-Authority-Info: v=2.4 cv=b4+/I9Gx c=1 sm=1 tr=0 ts=692038f5 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=GePjjIfFpqe_pMnJkREA:9
X-Proofpoint-GUID: xcXKJf9B6KPX2WSIuYXuBxGS7bMSizNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=985 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1030 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAAB0WhimdujOsfQ+Y5kJhItOewwUL6sgZGyt9FP+ijleww0FM3hiihRTaRqZ21eocKnHoBiE/BuTcUNQgn0/MvxFt7uPwtudTIwsQ/k9DB1jz32Sj+zo7uJ2axG3nEC4sF4AJWR+wYC33gfgt10JvDA3yUF0eOvlRecPSBg9KhClRp4t9bxil+oBSe/Q7UZyg/sP2cYgteEFCdS8KgGhv/1H6e9yQ09bmQGBz/lEneEwwoDuEwKli9T1JaXlMeadAOlEgNLbZWPiz3JYZRMmcaxxrSxH2Z14UfZiIl3sEEzUooW8aPma1jJwDCxJPDpyDmhKqEaAj5o9UE+BeLxAR0plagx3vH0SY/JwSboGLeA4IGRJPy+BMjq2ONIO21MetFVLIusx5tAjJnzgpTxi7BWhRYMKtogeaHPOBR3cykdbajDgHfzl59PtPHSmETRwzh/qXU7fcu/fccfGABld8Qbm0ZesvqAvlG/kPVz0XTwdgkl6ClTSHmD2QDQPvFaI7HBkwVdtq8Anha27N8+8BNBWAnXw9CvrSSTMZ6OqyV++gQtd4/+5kSb1zZPOy+Sum5hNryfIJhRfub5NDf81EEvNFTUhcSvbGYP234KQZ9EYFBUDFyloIe2PgZNSj0gwyisz+4vPEAOtne5yZK05uwh18bYjx/zFPW4Fjl6FXI8ePUD+XydxaYWt3nsQlPySQcrcS+p4KxamQZQVrDvcLS3K5f8juanF268P3otYsMPfKQKVn4YSs4KzqxBl/oK6qtZk6hikRcy
Received-SPF: pass client-ip=57.103.84.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 5be1abcfc5..4c8db22e8a 100644
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


