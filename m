Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93816EDEBF6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWhJ-0006B9-WF; Tue, 03 Mar 2026 15:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWhF-00065O-89
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:25 -0500
Received: from p-east2-cluster6-host7-snip4-10.eps.apple.com ([57.103.76.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWhD-0000mW-9m
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:24 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 9B13A1800132; Tue,  3 Mar 2026 20:50:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571020; x=1775163020;
 bh=OW8S3KLD8zFsAuvhuwhxPEOWPDp1M7oc2dpZI+SomHI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UlInqj552cMV9+I1Cntf7FrJje6yMV2I7SXrihwqqG9hYv/q8z61wkgg3wu6QAcexMqAWf/QnG8PEb7FK1BQTGgrmw99V4hgU8HUBrFsAWjq8wLLKRW8MKT/0ry6H5OW1J83EVGDM6jNHQk+OXhGuM3U/FlSQ8D5N5emXYNSPG2fZcrMcKuhKvdKFjYR7krYhmFvue3T/Z7IHMh4reCwfktXyvyVre3IpTlQAo/S0Pt1rNAjY12vWVQK6Qk4spzNcFe+Hs6iEb2N1E2LqZxbbYMW+UbPaVO2++CcntsbFsBcVhWVIrrkZsHn6rHdnCd4qE6HvmKeLblPDGTmjd00ZA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 9EF0C18000A3; Tue,  3 Mar 2026 20:50:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 8/9] whpx: arm64: enable enlightenments if asked for
Date: Tue,  3 Mar 2026 21:49:58 +0100
Message-ID: <20260303204959.31156-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=LpyfC3dc c=1 sm=1 tr=0 ts=69a7498b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rOdoSoqhRWX9tc6y9DEA:9
X-Proofpoint-ORIG-GUID: cieeCDLk2BXp3JgSVVTO49-3ENaEEv58
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX0EZ+z+nFAOvv
 fgBihLF87vbHlTFKn+dqXbqvn6ZCXnaJztY7VDxPPCnuthTRsQcShMQIKrZW/DsIDueKO31QSC0
 XWPa6e2eGNfqHdnfEKRJ6p3SvSYVVEyCD36dT5eAop59/A+rP3Ws1w1HFPhELxkBRbZjPzaMCzd
 3F0YtKK4GtFs4Iq+T59pgIlGaf9ZyTUrttZiqzrgY784NrS/9cEjqIdSLXiW/UGCuPn9qEvG1v5
 KvaUOlr8/cHfX08nG/SwfZq1lclsy4L6zQ0LLDiyYi1lvYMHL4syVakfTPNiGDAsBgc/1dkT0x+
 fCD87uvWOdw5aEz7LT/mw0fuebhDXtIRt8rqp0Sws9yDyXPClZGcQexNi0J65E=
X-Proofpoint-GUID: cieeCDLk2BXp3JgSVVTO49-3ENaEEv58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=800 adultscore=0 clxscore=1030
 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABhd5Z7vrU0isfwRvm/DEy7uzWOYMo9zGcZiLatNyZZe2JmoJIfXGud0bPAaX3Tfr5goDMcs175r5Zs6o+3rqpsjt+jEXhZI5F9Cj9GZ3zYb5yNPfNfGbQPZ/X8REkvxlg+54pBsTOi3MYDRlptwBYTMpxbRRomqB1/HYCt7shXcHLpOmf0KTudbEeMrbjNvLFYljo2buSvA3LLBL1Hc7laqQ+SVawlOwmycU0lxGplDzekmDA+j/muE6CWumddwCu4bxGhgY5QKY0QTxFuAgdt972bYXcfYx9szeWJXz9KwHfTrqLC1SFDgNa4h+gjClckvN82p0Fk4D1Wubsn1mJHsXlkZROWYGG4WosxayljwWVm49xrRWsvwAjVEg5s0bQRHv3zXpPqhKS+frgps2m6DWDuT4Tvf82zQnh1PVj6AYfK1TpooXKDz+bUDDBL9/VxtyBoGQCHyrxSJ52mwNcqNBnYjbAZ+96QujoHUf/5oxnb963KJSTh3yrNBHa3vywyn8SWyXlBSlM5NumFNGKR0qayf4cFssmG+vPbbGFYleb0uo4C0U9+lzsnSEO6QGqmWeWE0ut4waxPO72q57AmvZiybUbcQfsBIqQ2a9B2VgF6IL+pyraWFBbow11GhEwsCEL3ASQ7H1e0wLWN95HQ16SK9A+qFF8ZbixaBxskRtez1W+IrVD8SQ39uNZHOzhdYyAFDdTwmMVNa1K0WN245ZTHCEenULGxYZPwfJ13+Un0FBPLTPgkZ07
Received-SPF: pass client-ip=57.103.76.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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
index bb94eac7bf..9983d59a38 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -947,6 +947,43 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


