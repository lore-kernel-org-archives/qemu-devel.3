Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9355EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXD-0006FA-Du; Mon, 23 Feb 2026 18:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXB-0006Af-Uh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:13 -0500
Received: from qs-2002k-snip4-4.eps.apple.com ([57.103.87.235]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXA-0004Nb-Bp
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:13 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 87BC91800168; Mon, 23 Feb 2026 23:40:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890011; x=1774482011;
 bh=g4l1jVkhlHtyjTxoP0r17Oazu+fhT089N6+xSJMvRqw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=UXyAnMSgO0WncxN9uJwdkbzTa72HGlsdEk8tS0nplpxJ1PuHk2qnPyL9ONq2uIFsaA33iIsLnnqSvIzlJ4JK94gv00Q4N76r36aGvgKc58CFPx0OIDAO5TytgFz/7MSRbM/sAtP5LxDt+lHutXEQ/842+fkKjNnMx8Ea7t431+HWwpqWScaBGa0RRTKypB2+JR3Ajyu6SaU3eQHxGvW5COJwuXnMSa5HyNsMZ/t6Ircssv7KslBNhhyljY4amNy34aiPSFi8Kds8isQmv/KgA52D81pxHOVkk4C2qcUaiPxcy8eQ3liD+uv1PEi2tWDxTYmsRS24GN/R6aGC2pSm9g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 DCBEE18003B6; Mon, 23 Feb 2026 23:40:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 06/28] whpx: i386: re-enable guest debug support
Date: Tue, 24 Feb 2026 00:39:28 +0100
Message-ID: <20260223233950.96076-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zFPHqHGPhSF_ODeYkxSi0ZiVo3yvN0Nk
X-Authority-Info-Out: v=2.4 cv=I7Bohdgg c=1 sm=1 tr=0 ts=699ce559
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=VEyhEb3DslDlV8q9E0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zFPHqHGPhSF_ODeYkxSi0ZiVo3yvN0Nk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfXzIiRzJqmctvQ
 EMzpTgHzUVcspjbMJpwFdB8S4MajscxnOHptUUf5biVzRjzIEOumE2MjR00GfGk+xXUsXlx3+Dc
 5D1p4sK4Kg0K6CLE5W/aJ6Hv+Y585QKnhwkO6xMXIxmlsuOkkvgZjeH5q1NDVFVLwEaTzj2ecY3
 f13OkIuQ2dJkNDoiA00KxiqGrVSR31AyCNMIjHUIL7NTsJKllXuYlbvDdS2AH3MjCNVnMw2EHGb
 Egl6epf++Emhpn956GKJU3PoTsJl62+ZvgIneVJCCXQOIxTXwRV+j3ytilVLXANBD8V8ui+nfqL
 pW8KJGe0CKYjQvvHcNzlPktRqSQt5/Y/joOOZ/dSNFa763gL7hzhqcygV7qRoI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABZX9onRockw8olJIAuMn//UEXGJEOux1q7TbV9nBaaPXv14Hq3Nvskv0itXieoqsF1Ovb34lyjC441PFqzZ7aFT8Pf9FGmRWtWW6UA5Yq2Zw/dF1/bJaquliZKvLilkcbm9BgkEf7QYRZ1s3uhzQXc+zmkTeMDyXnNfFIzmFVYhllNRRdGtUDf4/U3M2VYqMWuXvsF4OCCUwNqGpHkWfiPvRXk5ity4Lzdx22gQ4FFx12g2/MIzmx0uugB5iyztpCjfQLRDEsqXbWWqO0PJKzh8MUl1N2nsKPPSfvs64icWHK2yEfZ/xDIQECDh8eih0r8fTMmAS/W4wnmXWMzKc/miyFo0Pv37hGLYQcUEycjz8gFpsbUa836AAf5oPF+k2MofugyYE6drxEsuGvofuieuHRh39qhKScx7dhg2nfm9dzDz7QwJGXuUHjv9eWAPH7z+sEVLEu/fl0r5PBFZOFTAxLF3Lc+ZqXHFfiGt2i6EzTt46adZhwpdOadCVxCVrbkJBnaVNTOjVEyJ11kj5dss2wyxp1LcJsZ4xWgWDGX8wgxRNQ22wo6cmxONK5J2Y0TbivTvktiv4QFekmCGDNoFE2L8aElQ6XOng4441fl4ROxDg9g0liPw2pKbZvohFUURYrioFX1gWWltbFt9sSk2QNqKIDoT9WEwK/KGRvYjUsVqE1o1xWzvrLgAanhvtTjRpt9eeU6s+HNWVIv7mg2rVa6IUaBIUTzS2xrXtmirVEr0jMNPVs61c3eaco8GxroF156/waRqmS8Z+xFVo+B9Xq2VTeUpdR9r0GIbIf
Received-SPF: pass client-ip=57.103.87.235;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

Fix what got broken several years ago by adding ops->supports_guest_debug
support as an architecture-specific function.

arm64 WHP doesn't currently provide support needed for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


