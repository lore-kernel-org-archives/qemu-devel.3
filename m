Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB7FC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnW-0008Vb-Fy; Sun, 22 Feb 2026 13:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnL-0008Qd-Ru
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:05 -0500
Received: from qs-2007a-snip4-11.eps.apple.com ([57.103.84.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnI-0000P8-Ub
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:02 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 F3AA11800502; Sun, 22 Feb 2026 18:02:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783380; x=1774375380;
 bh=g4l1jVkhlHtyjTxoP0r17Oazu+fhT089N6+xSJMvRqw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=bnYoHXIJC+LMLbKZwAhF/IIxJvRxHH3SOeg0SyUZBDqx6Y3whA03jT8DgS+O9utRliwD/XmLCy6h3FRQAJ/dO4gOP5+VMHWAJo3s2fVp3GnLw355BAofi5xmS6fmYAd9B/c3io+Jf8YX1AXVIzdev81gLryJ4LeZfPMCucqAwRbI804a0oLslBziODqNejeOowJZFfaH+UmA6Gcgf0kG0mDk+H3rFvrnNJtyzfpY8fo6D6u4SLvTkdW0taIA5j0uOG2yzcbJ7J8bEdjNlnvZUOi9PeF70Tul10rOwNo7QiBVS0nc43ppvBkuqR5WjV4gZlxKLYlWdkIo4K6dzlk0Lw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 860621800506; Sun, 22 Feb 2026 18:02:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 06/16] whpx: i386: re-enable guest debug support
Date: Sun, 22 Feb 2026 19:02:30 +0100
Message-ID: <20260222180241.14621-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX25HsD4LfEA3S
 tdAik7oXkMWR/BBx7IwrMnFZ3LIx2wfr7rOCZ1JrY5lHn71Xx/hUcKWYVb3dOOIJE8aZ0a8LwoS
 OPZWLmB/vjgLVd4FKeDdOtQOpul3gD5JP0cHkl39AK/YIbCr4Z3PRMzJJjzngtWRptMVhrHPifw
 r8EB8tGikEipIGjIqS2gMId3HWjj7zu+2rv1xu2E9eZqqrq7QprMf8sRI0wM5CRgeXRR6IexMZ1
 IBHd7oBejImoUeaW9fKMaF2mYPXFoAzny9ujJMn2U2i+GbQiX75t3c7AgOgi836MQG5jpm+zL4x
 RUjS+ls2LGPaVFwGhpFjFpJFRwCxjHs1yRSz+kpr1Sv/k2T5sDzCVxrcmC8tzY=
X-Authority-Info-Out: v=2.4 cv=Lq2fC3dc c=1 sm=1 tr=0 ts=699b44d3
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=VEyhEb3DslDlV8q9E0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GCyG7K4qpQUvVKCeG8kDUwV3CEEAzYIb
X-Proofpoint-GUID: GCyG7K4qpQUvVKCeG8kDUwV3CEEAzYIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0
 clxscore=1030 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABds4579iq/3OJ9e5etkiwSsmM4FgoV5YpIJMWmVdFNaf8m//0N4+qu6FA8qhpDYCrFxw1e0rWtl8JY8H3i6ObHjbU/aYO+zsm2aHEhUZof+BZB8B4+4P+UZ0GL+YyhHzcCXDPkKcMQk8U2RLzdfyH6fJv4VnuO1yOgZ8+Sj2EJSpKOGIlEZtDm/Jxgz95/MaDc1QU33kZvVSV1MLUHnEQzXbtN669cMArpX+TAdVcccGVlMsV/35n0B16PtIeZt81XgzYST9wM9Kuev68eQ1HEEJH1+WCjmrGk+bK7MQeXIQd/IH5JrrzPLBQlsLWx9hCMoTXVHw25zs/NSeVhubeg0GzGZoIS6rSHRPj13pdatyxDNMytPBUcbbBCEpVU+/3Hr3IAh28catdDUQpnaMAgXHhO11xFcBMlNtER3/fnKUfZGR1rVuO3fbrwr5PyquRO5+WTsy26jvlx8y4dwzi2UR5fiwpUX480+ZD1Mnfbv33OVGapgPOta/MnBOKsSTFoYukoUROpH2s4TCWD1HwJOrmxSzm8q+RtHIDmyn416p7t58L6nZbskv6VmjOpvsL86xdEtM8jXnMoI1ogXyatbQotHID4NXViEkAfyDPe1ktJY8Rb/YS0LynTpeAhG07R21696//Ga29K8I3nSZp+xTfiyC6Oyav/s187fvXiv8wr6PV5Gujzo2bA11a4/DRHOtHy7d7bTZBlsEQFsP45OXWJzOLoI2srhCBuuLBbHhp5bAfsm5Cy94TgOrKwFoAdwja6MNYhRr+NrbYXB+3FT75d3G7iEbPNMJpZ4U9LdpBU1Hxi75HD5wUEA==
Received-SPF: pass client-ip=57.103.84.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


