Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFEDF55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywFj-0005Px-HL; Sat, 07 Mar 2026 13:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFR-0005N7-J7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:34 -0500
Received: from qs-2004l-snip4-11.eps.apple.com ([57.103.84.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFI-0005Qd-E5
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:27 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 4A23118000AE; Sat,  7 Mar 2026 18:19:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907558; x=1775499558;
 bh=rK6/RxrpYBwJeZsqHscQwDSrvNy3tiDTtCWW5H3KBO4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KXiTUoHfGnWyKb8f5fbYkeR7Ktw3irlhveCIRZ0BJQ0JjukpqjVjL7Pb40uQk+uEE5RAq19GcJ9RIk+nYishMFn31r/0F/lFC73YWkjlN3BLPBzkfxPjVDxg+VuokZjKzslI7vB/ByCprJRjyW+Tea/22ASB6k+6hjBHcZAKqrNI9WfVt15vH/ye41rkQrL+IK9LLbkmu/Zf6HNx/dgnJQHMPQMGwrgW0QAVUDSg1jGVKjlMRAZMg40dMqUuTYyqoh9fpJUXH6YIWVDKDbQB/l33qV5pAnQMCEROaOZOe6zBa/GMcca1T1ek1U1Aw9c2BYlNYg0/RIub29lTDJz96Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 09B181800096; Sat,  7 Mar 2026 18:19:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 8/9] whpx: arm64: enable enlightenments if asked for
Date: Sat,  7 Mar 2026 19:18:55 +0100
Message-ID: <20260307181856.2209-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfX3OOkRlVOXY4s
 Qe3l1nTbfAQnmkVB/mFlsPcEpqMKrBB/011kDAtZqPR26N5ygpKfFuwUY7pK3r4NyS7wBWl7A6z
 m7OkoNVGTQqf5uHzGhRj5YyhlkEv7KnQ2BvjNySqOPF+MP3BAZ9iJF4HKx1+xpqLuVRSySdL/g/
 fFjj1OvxFxE2tq0/e9WI/E8axyyaSLUrp3G5PcdHW4WvJJgxmEg54qi09hpigi0KCEHNf4DxLLP
 N4/MXsg0/Xr7o2EdYjbmnqcuy+0I/uRYDAq3JVl4FrnUtdo3BqlqhVLrme23M96QpmRav07+PMN
 7sAQiGuK89/V2Sb8aaBk90FE+cKNeo7Wk88r/g8/aY1/zNws5u6BTa63MI56Pw=
X-Proofpoint-GUID: kb4JzcWPMPmiO_iUXIvfjpV78X49HfB2
X-Authority-Info-Out: v=2.4 cv=EJcLElZC c=1 sm=1 tr=0 ts=69ac6c24
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rOdoSoqhRWX9tc6y9DEA:9
X-Proofpoint-ORIG-GUID: kb4JzcWPMPmiO_iUXIvfjpV78X49HfB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 clxscore=1030 mlxlogscore=796 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABHbi0kqZzPXPjghaZST9kY3NuY719gz5SE5Z3xTNA0RImqQgiq264A/KTDb7AevafLvQcyM4Cd25Riqt7sMayPw+ihgHUfCdulGq5OMcR6wgHl1auDWcwKtgJM3lca4EqHKB+0z+ESlmSJMAF5I8gN44OngZXhW3luTXPXYIjSGU8NpuOqRdJXlPwPAJ0L7/cqqc2nFUAkTfj/TJwUQzD/WCrnRdcHjLLFCBbFJcN/bKi1tCr7wRQJQZHEdtqvIl5FefNvjKmTRviVwIhNvZhAHxZOwXUiAULp9+V2iZLaaYjswo6IxM2RYmqvKxhLenS90Zy21H9L9/QOsar5xN10kKFmCpF26LMam1GNzFvHbvsOF8e5xAfUCENtdzwnOuYcfeW4Wlb8hI/Uqbg9k4TIAGfNHzTwcAzEjIGuSWLdrqi8QTDeTul/ARswvf5fxjw4KVmCHX0cuGpm0bgd003HffR8qSWT4/d6dxVd+Y4ulQl92hgNifGqPkJdBULVjcfU3AAUdIqKoDVca+U9kKBAiAI8kSUQhU8eKOd0W0c4CqgPOM/JZ0KPbwr40HEBU4rgmSYV79BJBoCRz5rC9/M4IV0h0bF7SeUl60nVBXYFTycdE2rcJPbX1fPkV9Zx7367A8up04WxmO/o8ciz0mHtMOXIhRNrTglu3lMhw6XIZgA0zUzoUomnyBopR2fuoe24HCrVurv5oH0djLent8owE5CBySvPZFioicMvafvyZAPjhaGS+55Bt0EOQqVKn/SGMnjmgXPo3KHuZQ25cms4FsXEZg=
Received-SPF: pass client-ip=57.103.84.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index c5b108166a..513551bec1 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -940,6 +940,43 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable synthetic processor features */
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
+    memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+    synthetic_features.BanksCount = 1;
+
+    synthetic_features.Bank0.HypervisorPresent = 1;
+    synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.AccessVpIndex = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.TbFlushHypercalls = 1;
+    synthetic_features.Bank0.AccessSynicRegs = 1;
+    synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
+    synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
+    synthetic_features.Bank0.SyntheticClusterIpi = 1;
+    synthetic_features.Bank0.DirectSyntheticTimers = 1;
+
+    /*
+     * On ARM64, have enlightenments off by default
+     * as they're not needed for performance.
+     */
+    if (whpx->hyperv_enlightenments_required) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+                &synthetic_features,
+                sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


