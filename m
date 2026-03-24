Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47183F54ACC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Tb-0006JE-7k; Tue, 24 Mar 2026 11:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sl-0005sJ-O0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:37 -0400
Received: from p-east2-cluster6-host9-snip4-3.eps.apple.com ([57.103.76.194]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sf-0005rb-T5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:33 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 A904B1835330; Tue, 24 Mar 2026 15:14:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365263; x=1776957263;
 bh=2GvRGzc1MRHwmLUZVIfY+An7ZJn+U4NKEHF+iW/SlLc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YXdze5cCcS7gLIWuMGjJXSvn1be0/VizQDTZ8ogAUP916zQ1f/RXhhCyhtZSZuxpczLVISs7M6oST86GiJG0QwDWoNc9PtAFoLtK4dG5CaquhIvmfsLu2p/1IUZRVQk81CPySdKsncwguQDa/eCIqSGP9yulaYvcN9BULyQ146Ty+SF50X8tSJqx5NUQSwvCvrsc4LIwGXEjtIiFeOghpaGm10l1KxdNpkP6wRRf+GS1UjADRhKpi+z6Bq37XYGvdOCoGPQdn7rogRZuEo4iE0PRwU8cRrnem1UFfvX7sNy0Dcawa+0caUCJh/0/Of5zAqdTz/50jaYuO6qFtbLKvw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 76F531816469; Tue, 24 Mar 2026 15:13:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 01/12] whpx: i386: workaround for Windows 10 support
Date: Tue, 24 Mar 2026 16:13:12 +0100
Message-ID: <20260324151323.74473-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n_6K2D1LUnbfKCfE9J_EBOEkGIDtfc12
X-Authority-Info-Out: v=2.4 cv=YdqwJgRf c=1 sm=1 tr=0 ts=69c2aa4d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0RUPog5Yt9CtxV4tMQEA:9
X-Proofpoint-ORIG-GUID: n_6K2D1LUnbfKCfE9J_EBOEkGIDtfc12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX5wkxYLIoM5KY
 Vore0Pep8XvXXKQ4a8MJiOiytnKTw20sA0n2OCcJqxNBn9UHV6xZ/pSv9P3LbO+RCKOAhv5sWRE
 w0SEeSEUMLibA40cIFd6o59/0aV3T5iMGzKT+tGqQOD6TiMotjOHjExIWLoydAMdZMntKbWwKMY
 l0ZCXutoQ/6l/fe9mD8J+7YvmrRGe1pPCgYNnN/2R7bXYCDp3ARNFcGkw8k9iTMt39YzAl9lGKo
 EZmUJVGzgO1YTNS/9ZYfcHFeZjx/vStYl/rxqkOL/UJr2C+8kbYz+SY+rCkWXI843XEOEv4nbh7
 pqk3QPyBU5E5a+S1wgEJiH1VchHTMPpoqZCJlSSm9k9p/3gtXxwAmlIPFDZ1Vg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1030 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.76.194;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

Windows Server 2022 and later support
WHvCapabilityCodeProcessorPerfmonFeatures and
WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks.

Windows 10 supports neither of those.

As the QEMU executable doesn't have a manifest, OS version
queries do not return the actual Windows version but 6.2.9200
which corresponds to Windows 8. Windows Server 2022 and Windows
11 still use the 10.0 number, with distinction being the build
number.

As such, use the absence of perf monitoring feature query as
a cutoff to detect if a legacy OS is present.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 43 ++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4d5d3dbd24..015c0f1dc9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1948,6 +1948,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
+    bool is_legacy_os = false;
 
     whpx = &whpx_global;
 
@@ -2096,21 +2097,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvGetCapability(
         WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
         sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    /*
+     * Relying on this is a crutch to maintain Windows 10 support.
+     *
+     * WHvCapabilityCodeProcessorPerfmonFeatures and
+     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
+     * are implemented starting from Windows Server 2022 (build 20348).
+     */
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to get performance monitoring features, hr=%08lx", hr);
-        ret = -ENOSPC;
-        goto error;
-    }
-
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeProcessorPerfmonFeatures,
-            &perfmon_features,
-            sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set performance monitoring features, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+        warn_report("WHPX: Failed to get performance "
+                    "monitoring features, hr=%08lx", hr);
+        is_legacy_os = true;
+    } else {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeProcessorPerfmonFeatures,
+                &perfmon_features,
+                sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set performance "
+                         "monitoring features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
     }
 
     /* Enable synthetic processor features */
@@ -2138,7 +2147,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    if (whpx->hyperv_enlightenments_allowed) {
+    if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2149,6 +2158,10 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             ret = -EINVAL;
             goto error;
         }
+    } else if (is_legacy_os && whpx->hyperv_enlightenments_required) {
+        error_report("Hyper-V enlightenments not available on legacy Windows");
+        ret = -EINVAL;
+        goto error;
     }
 
     /* Register for MSR and CPUID exits */
-- 
2.50.1 (Apple Git-155)


