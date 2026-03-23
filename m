Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E4EF4613E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrJ-0005ww-3Y; Mon, 23 Mar 2026 18:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrG-0005vg-L0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:50 -0400
Received: from qs-2006k-snip4-11.eps.apple.com ([57.103.85.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrE-0002v1-8M
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:50 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 B9B881800259; Mon, 23 Mar 2026 22:34:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305286; x=1776897286;
 bh=2GvRGzc1MRHwmLUZVIfY+An7ZJn+U4NKEHF+iW/SlLc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=I1uFsDsLYN3FdtvX16nsT1uLVpmY/f02o+5igC9AnwT5cvrNCAGYAbu56+H8S8VZaZlVegXElnOznpL0wgggDK7fLou1nlNzdM2Mh4QuvhxB/tDl7vxT3p3saO/LtrXpbUPbNL8g6fuyKmAnM40tswZ5/Br1LqYxvaMG4Lqm4aem5yc74rJ8AIFzinN7hAATuE9QZ+tDGRsr5Jcee4P+Dk+Ixy+ExaJLq7J4XHx+YLjAqE6NkaJPPDJKJQ7RHSuaNMx+bAENy5sM0uoQNRwQKgeECzArUgCsxytY3CiYHMoUluNdDWbbHW44oaZvBtWKiA4DOmwYj5G4S5FbEYcZ1w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 9090C180015C; Mon, 23 Mar 2026 22:34:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 01/13] whpx: i386: workaround for Windows 10 support
Date: Mon, 23 Mar 2026 23:34:22 +0100
Message-ID: <20260323223434.81780-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=QO1lhwLL c=1 sm=1 tr=0 ts=69c1c005
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0RUPog5Yt9CtxV4tMQEA:9
X-Proofpoint-ORIG-GUID: 0qiWd3RCQAO12ewKMcd9FCSzVBTj5Snc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NiBTYWx0ZWRfX7KXOIe6RsOoj
 hwhgIqjn8OIPJRg5Mp2XO9z+gDOxMB96R+hh8YJOwMSaexEPAMHDfh3ZKItjmMDjAssdBT+EJzq
 t8vjVh8Jl7i1w5SItmvd/jfRGFiRtyRCxUPMGg2VMFvUiPhMoETHK9AX5Lz9PqFVQnelHrZCM7z
 /HxoDvLuAuFtPx+ZmLldd4DFGd6jmDkSTCPrKgcN6HtsiGsDoZXjl0OBNWFkdj6m1lWiQlj3S7Q
 n40EaSvlAwawCC3D5cyCF8dY2OFJhh9Rjcflu/Gj1vKbJ08KflYa8igPoVuUpi9nivZpkCEF8TQ
 KB4V2Uocx2UyFqg/qqpdhSLdR4CXwojBt831L0IFf0m8JwbtLfwm4UEbXipnjE=
X-Proofpoint-GUID: 0qiWd3RCQAO12ewKMcd9FCSzVBTj5Snc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1030
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230166
Received-SPF: pass client-ip=57.103.85.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


