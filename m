Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6E6FD0045
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9l-0004DQ-Gp; Sat, 28 Feb 2026 16:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9e-0004Ap-Pf
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:18 -0500
Received: from qs-2005d-snip4-1.eps.apple.com ([57.103.86.162]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9d-0002UJ-EC
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:18 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 871C8180011B; Sat, 28 Feb 2026 21:47:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315236; x=1774907236;
 bh=7mj6sUmmdtk9A69SUbrqs2ReO/lE9GHeOdIojBoDuMA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TCSRs5Ohs4n1ZZhpUIXzRJKtc9CmJy5a9QQFjx9rCmZsb5UKe2zChytT5HilMeNAyIRWT/94pNXJTWraOts++SVZCkW196PolK/LAfJWsins0jGhb4olZ5OARL0XP/++GZUdvv78RdMj/+Guk2fCHq+DrKW8IexI0D0Oom2x9ipGHHj6gOnmrLB2Ig1aRIp4deuk/8NSQZ0RHI4fi5ZqqbTqUkQFUvJM5Om7HmWJ4ejuP/zEypk5EhsCyhbmpJwucGAnu0rEGoZYYUseHlS3glCUlaFgsQRTqcbBnMzoZilsqtpnpV4C7U4OPEnZ02YFj4/I5NMstRgv+Qv6TJvD1w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 F1BC71800121; Sat, 28 Feb 2026 21:47:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 6/8] whpx: i386: enable PMU
Date: Sat, 28 Feb 2026 22:47:02 +0100
Message-ID: <20260228214704.19048-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BnZgRhkZHy3HtQj7YKSXaPd6lMGyfhtv
X-Authority-Info-Out: v=2.4 cv=YsgChoYX c=1 sm=1 tr=0 ts=69a36264
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=ymEGMFXK17_Bx2syn8UA:9
X-Proofpoint-ORIG-GUID: BnZgRhkZHy3HtQj7YKSXaPd6lMGyfhtv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfXxtRF1A9jVH0m
 00yG+tj87bWPvYnQ68xHal96lFoxY4mCYyCqpyVABixd0rthCyc3IOFIpPusAgigq5Z2QEDYxTu
 4Tum0cXDfZ04EIgyskr+iwTq1nDNoD0u6wI47zxL8eVXEefVh7Mvu5tGu+/ZSkVUNzZ8/W5QgJz
 1ZHT3G30oCHcy+eezjxs4LOH7MHlAtGiAAjeYBoAbOqDYpCEtGjxHsYlv2uV/MYxdIn2OmRoI6S
 YZdiN/UPGt/mkoOhSarNyOvEQrqpWw2KXevJKb8nsUpHWLEL1OAfx7ECtXbXawXBMEdnTmO8xn7
 I6oCgrwKAmaXYH/asLYaLoKmRy21q/pehEJo3Ax72hln23SROaS975aCdXNflI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 clxscore=1030 spamscore=0 phishscore=0 mlxlogscore=841
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABHN7jq7GdX8uZ3ue7i6uLkRPRh/Ec6iUlZ1426+ZG0SUERdFVn93sxa8rPPGqbaP44reztq4aFGtxQ4+HT99L0nM6WFUcBKIvTUAu6HKTZrcyBsnkH3RGq40X+N8cf6MbW0fvlm+w31VsnW8TIDuou6iHIkay+VFo1pXFgMz8jtW8X9I+c/s2/RwdYEU1wkhvgCZk4a0RlF4BMYRMEPfurQXouzePCEx3jm2SlqczpCZRa6bb8mNaBtDVv0xLNKs2z1giEKpGIEUWlCZ5WZE1kcOwe6J5UgOJfB3sT+XQCq4KbU/g5Auiv86kRlxoqQwDCAcUzSz6g5/a7oUa81sc2JvsEFaD1k1XsI2FP6Ypo31xYQgxYUZQIe2ePuChAkAdJ5ss6jAFXbM7vxQ/7MVrh/mN8oMGQmm0FmjJZP+g805L4YQMmh3oVzhzNdAOHSsUWNlb9ZuUNqa3nj5a3zwXrAlkAQqLyUCL4kPMdYYwloqRUzONilX/XTmB09tt6HyOq86BtoYpx8ufFGOmIrVKddn46CQ530f6dLQICtxS4ITr015qhW1VKhWPprNz874fcdFauAbUFbg4LZ6husplh8bZ2B9Wop8lM1GD3KOce2h+WlF5nwEoznFRNWrlMJerGq1MkR6hfFvQaFRi02guvm3c+g==
Received-SPF: pass client-ip=57.103.86.162;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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

Also a partition property instead of a CPU one...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 5aa8baa4a2..da2ba36060 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2011,6 +2011,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
+    WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
 
     whpx = &whpx_global;
 
@@ -2155,6 +2156,27 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable supported performance monitoring capabilities */
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
+        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get performance monitoring features, hr=%08lx", hr);
+        ret = -ENOSPC;
+        goto error;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeProcessorPerfmonFeatures,
+            &perfmon_features,
+            sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set performance monitoring features, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Enable synthetic processor features */
     WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
-- 
2.50.1 (Apple Git-155)


