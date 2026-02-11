Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0274CEB5961
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3B3-0005V0-2m; Wed, 11 Feb 2026 00:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B2-0005U6-5C
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:16 -0500
Received: from p-west3-cluster1-host9-snip4-7.eps.apple.com ([57.103.73.218]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3Aw-0002oW-3P
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:14 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 05C8F18000AB; Wed, 11 Feb 2026 05:54:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789245; x=1773381245;
 bh=mOYNtTveKjr+KZigxP71eIiTh5kyqDuwACrDmj+VmsE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ADwTeUrkNeT+z3W95Fi1NV2pk3P+WsbkwPV/VvkiAW0z3QKBoWHzTQs9EYY4tNo+RsChfBAxhtff0icFcjEJ3YiWqoBsHgtBx10fZoqDJ1yrsBxQxvotlK6h8/asvXaWZIJZeeF3u9fV72tLaXE1eOvmtjLC3H0yGaMIULgjO6XQpQNJI0Vud+RY/ySTZtfdsy+91eWfDno0Y5xF1ERkNthrg3Np/OMo+z/NW5YUvmCztpEx/ktX/LbTDcEIYtwFgxU0des34RirWVOoFov2cTqHH5pPItG2ieRTn/3sLHMLyPvZXAPnGomct8GyuOC0qOZbDAcgY0qVsrlk5SAH3Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 235EB18000A7; Wed, 11 Feb 2026 05:54:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/7] whpx: re-enable guest debug support on x86
Date: Wed, 11 Feb 2026 06:53:46 +0100
Message-ID: <20260211055356.44664-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfX25KRu0dOpu0T
 DR6GRiADzq9nI2HZbBD1nERmG3seUZiiZFFrP2+1dBzGv8c2ZqJlYaEfpOg4dgRKWmpzrLYwZQo
 3oefRo587ODTdgC/KExjGIyd5J1fb7qVWXr4HSpHDtii5GrastOAtwBZEJrKKorVgdSmV5TpsO4
 PcV7u21vgVSicP87c1IyVWcC9yqEGeBhaQR4ufkdCUAWbNI02X1e21aKzVaI6zWLZV/maB7eYaj
 HSKaM7Tcx4KNk/pZL0rxkPmVcf5rCXfxtCcawVyJglNz9/4DcEeC8p8/WIb1bnrNkndCIy0Q450
 yEa9sxvIAQPrfrSCvK6LvIXU+E7UvPNFy0CnPy1XwWgmFszj21y7MaRduwaZW0=
X-Proofpoint-ORIG-GUID: tbNPRdUbKfG2RTYrQNqGBiJVT58RJZIM
X-Authority-Info-Out: v=2.4 cv=J62nLQnS c=1 sm=1 tr=0 ts=698c197d
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=TBIg4pHv79D69QLdSdkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tbNPRdUbKfG2RTYrQNqGBiJVT58RJZIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1030 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110046
X-JNJ: AAAAAAABM+/IpeD3w4cDLlkFxkD+Pois0n8fMl4RN1YV/hZsl216g+Mt9eMUxvzMh2LFQWU3ciTfdnEhPXvSzt+Q3Td1JY7Hvtw9KcexF9JKtVEmNkEcEMqGHSPayeJE4Yk2Vir8psz+mKNAq5R+HeXb3ZfOmPEgZtpm3jwQv+0LyX55ftxwwOmizRKshnb3+bhFi17+ItYZVWdParf7AvGMm6cbKK1xaQARORkTxy5r3LpZ2ubr2vTO91zUUkRM8sPGyiyNwd6H2DIUCxY0augZ3pdODHKw6JUEYHUtlcYCgtA8qA2p46nqy5k5vVt73+iArQVFsa33CnoOdQT9PElvV1CKe4lMMWcBgB3UKWmu9Q2D8tHqgndmAQ5a6I6NVWwRaNKd1f6GoxAQe5IFVNteHLrC8A9ooAuM+B4yiiigTYigohbh9oLCizsFpE29SKajjoU8atkX+KfnVuC6PFglpLQcHdtSiCeJc2qZ+6MMv64ybEeZugk+3Tk/+cYP7RKcORCiNrdwnY54bcI3TVA4SuFqutf+FD5QWS+aYNKfh9OGTSiMNkNDzLgvpY/9xIPX6caRwJbYBcqvAFUMw9r7/kFrIg79Dyh1v1Q4btrPD/qdNzm/i1DsTyZ4UWwYuHoM22N3f75+F14wjvsUKi5GImgVaStpbx42YwcYFPikFg20fqLfEqzUWw/RolXGhWdxuQ2KxmggX8TTCSWVPvFS9s2a7EA0WT7YeDnjtRCdZBpy4z5ESQKVqRG+2QMo5F+TS8iTHZ85C2z7bywqNiIfXQGk3NPsjbcrCKU18sOq
Received-SPF: pass client-ip=57.103.73.218;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

Fix what got broken several years ago by adding ops->supports_guest_debug
support as an architecture-specific function.

arm64 WHP doesn't currently provide support needed for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-accel-ops.c | 8 ++++++++
 include/system/whpx-all.h   | 4 ++++
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index 50fadea0fd..b8f41544cb 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -17,6 +17,7 @@
 
 #include "system/whpx.h"
 #include "system/whpx-internal.h"
+#include "system/whpx-all.h"
 #include "system/whpx-accel-ops.h"
 
 static void *whpx_cpu_thread_fn(void *arg)
@@ -81,6 +82,12 @@ static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
     return !whpx_irqchip_in_kernel();
 }
 
+static bool whpx_supports_guest_debug(void)
+{
+    return whpx_arch_supports_guest_debug();
+}
+
+
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -89,6 +96,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
     ops->handle_interrupt = generic_handle_interrupt;
+    ops->supports_guest_debug = whpx_supports_guest_debug;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index f13cdf7f66..3db074c38c 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -17,4 +17,8 @@ void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count);
+
+/* called by whpx-accel-ops */
+bool whpx_arch_supports_guest_debug(void);
+
 #endif
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 36c5e30a03..8d0ca794af 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -304,6 +304,11 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
+bool whpx_arch_supports_guest_debug(void) 
+{
+    return false;
+}
+
 static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
 {
     struct whpx_state *whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8210250dc3..e1f0fa5e77 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1272,6 +1272,11 @@ void whpx_apply_breakpoints(
     }
 }
 
+bool whpx_arch_supports_guest_debug(void) 
+{
+    return true;
+}
+
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-- 
2.50.1 (Apple Git-155)


