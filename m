Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCAEFCB638
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytn4-00016o-MQ; Sat, 07 Mar 2026 10:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmc-0000qw-80
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:45 -0500
Received: from qs-2002a-snip4-11.eps.apple.com ([57.103.87.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmU-0001zu-OG
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:32 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 C03231800AA7; Sat,  7 Mar 2026 15:41:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898087; x=1775490087;
 bh=rK6/RxrpYBwJeZsqHscQwDSrvNy3tiDTtCWW5H3KBO4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KRMiGTIJdgJ2coAavhvgxRjqcmzCRAHETbR3qfz7Cbv9YyGiXkcnDR1VswsotideXO0B2RWCQs932t3RBcYB6DH8TgLZqS8ArnoHD7/HaZHCJP7Cfmg9wojRonrPFE/ck5sv1A18qtYkOWz6tQWdhvOcaGNr3pwEo1dF+UK2AWixef8TNc71k8Kag69FbWhEtHYNBH9z+fuNvdnebuLGo92tz6CEYpN7W0iAXJ6tSVEn/rnTg8DhU0HjDInWSp/iz71kdzNVFJmVJLFxeUHOCnwnMzxyffldGmvGZ9PafUDKsoh+NqmBMI/14kZGfU3n+toXywRV9foBDSSLXTUxZQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 3FF681800AB9; Sat,  7 Mar 2026 15:41:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 8/9] whpx: arm64: enable enlightenments if asked for
Date: Sat,  7 Mar 2026 16:41:03 +0100
Message-ID: <20260307154104.84567-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KjKWIqQd49_yxwqcJvSsYhKs07y26Bv-
X-Proofpoint-ORIG-GUID: KjKWIqQd49_yxwqcJvSsYhKs07y26Bv-
X-Authority-Info-Out: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=69ac4725
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rOdoSoqhRWX9tc6y9DEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfX30GYeKfIiC1J
 b8h1jc+FwgjnUUgF74GYnPL30bw5g4alHNAEmxEGqDAKtrLFiCZBNUzzO1xHOfVZoa6MQsPEXJa
 EaIaY/oKvgkh9ktDWl9rWzNJD9MwGi7gvyGy2sb2O9mm5zi54WmY1Nxg3w1vLgvmPxDF8i2/HtK
 trYHo2vQuATRocJbGfeZ9LtaesliWaq7Iqo/czvFvTAmAt6MaRKousqnhKtJnOGC+xDhhlYWDCv
 nfW3+VRqZJkfbxRufSKU7dDNR7P2lQHFkmP+lKK/SKPg76clD5/I+2uNl2jPDjAZpYQ7tOH4EAP
 Huc7UhO7xthFK3j11AQLshkkLzYOK2deDNEt8Rzhf4Zwizi+ZeF2R7kNjy58OE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=796 phishscore=0 clxscore=1030
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAABB66HnjRYpnNyoMpTKdsP/Yb1EXIo38OOp68locp6BEeZ79/ViUXj9RUDCcH2vkKi53QF/blWxtf/e3CpxCP0roLIvdWymWjXe3fBZ18ab/Xb0ff0w312YDwFfRypLuIpiZbSwYxtID/H/bkYudcOfbbzLEwBXAnF4/8FtUShWPqbDpOpM3N3uTd8DqsEXtq938CCErpm9h+rNnX0dviF38039b9BHZsfU+vcPy/idnkRAW8acmA5On5vn6Rct4Yw5XCFzws1J2UkNGGny9m2bezxGLMLfRCXuY5IywdLl6vD5ixIrfEiv69/osIEXz6s9hlAj4RdheSlllaiFx4+WOst3MLqbgH/otPLQY2uOLB65VJLgaZSnvKE5B+gDHUEM1QH0225NevCjujrWUD1bPGFkgpcUi4ECdDNqQ6rGtfPrA++2/FqpnwTVPHTCfg0XcURh8AOBLPeIShlOB7+GjNAtxo7PwkMHY1q7yrYKIk3dX2xg2skcYIszyS7SbkcLNytgsQ1pAyEV68LwbqljfqRRofNQMBLiGPI0giUfQEMCNNRjDRzgI1f/aRQ0KEsDnJVEx3tJDT+nKXDR+EPlGdGaKrAIE1CLuZUxR6TAskgdmiiwYeEuyuftc+BgJKdOsFBKPOFoBNNCYDc8afu8yF3rH21R3uSGclXIEikZkwhqrmM75kfagBotZ1Lnzg8d0HV4+MwEmTtwqgxe5b/U6f9NDTD5+ZJRi8Y5fRWXuS6nv0+TrUybSOkw91rOmDpZO70CeCd9tl7FHtgMN5vHzmgkpLPvHpKGjh2Knw=
Received-SPF: pass client-ip=57.103.87.141;
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


