Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B73EF8FA7B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBlk-0002hw-Oz; Tue, 21 Apr 2026 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFBlj-0002hU-5A
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:08:03 -0400
Received: from p-west3-cluster4-host7-snip4-10.eps.apple.com ([57.103.74.141]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFBlh-0002eN-B5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:08:02 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPS id
 CB2BD180012B; Tue, 21 Apr 2026 14:07:55 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRAEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwBBCEwDWgJbHEIMSQRVGlofHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776780476; x=1779372476;
 bh=vnSSeCmJZe/BZsQhSbYkbvZgWtTe4iR3ULS++b3UMl4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WiAKoWylnL2Dgjqah6DRZwl7lqeSXuiE2rbvdEwTTjwfAiC6ZXg9vihurdBFp4BzPL8sRLE329R8XrQr8wCQkhH2cJPCinjL8iezxBlqYXeHvvI3IDpvNE3GwgOyCx4iqZU877nIF/BtFQ8WpMG19BDp3L8QRSZOpL/ZnMwkGloybYM8+Mq4KpvJwABa4axro/F4X9i3EOsl7zNE7kCekE90tf2eufln1w0MAg6r8y6/PcV3T9zjK5fCfNLEsI8Vbq5WyqARfxFMYyJmSnP5h1RbR4zAt9NRaEROHGzS1yEMJAEA8CcOaAxZ18y2Wjk6jxmjjYK/dQ/hv1PME1iiyg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPSA id
 62E201800122; Tue, 21 Apr 2026 14:07:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] whpx: i386, arm: do partition reset on boot CPU reset
Date: Tue, 21 Apr 2026 16:07:50 +0200
Message-ID: <20260421140750.25178-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=daqNHHXe c=1 sm=1 tr=0 ts=69e784bc
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KtJ61neEzk59qg8Kb1kA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0MSBTYWx0ZWRfX8PNcvIySkHU1
 I/p7uAOdl+l7UnFDd/hLmw7eTyi2mWM2CtZ8+/8UfUeILVd9RBJtV4pp5Y9p/A35zOPX99FZBDK
 NFHbJJ2KvF67sriupDUHeh/l7+dIdlSw392tYhtWQlnyJS2M3VX/LD2QRGcDnIBTXgPoTtxoJ5G
 YB7gueJi5GgED79s/+durT1/NzaMCmSGfa3p365tWLJAHDb8CjAWVLrOPEJ98b0tzj5yU0s57/I
 yW0zimeZ2uPGAKmt2Z8VjM6zOqzh4oJwBunMygIkgHesI2OYZKdbQW4BvOKcE6/DpcDYl4Dlzlo
 DKg+Z+VL+IGSVqGzVhOSt4jy4/KdduuX2E9I3qYr12IxDVZGT7Lbd/nENnUDuY=
X-Proofpoint-ORIG-GUID: QtaHeZRS7HrZh7wfn4_5BdcaatSAOgxD
X-Proofpoint-GUID: QtaHeZRS7HrZh7wfn4_5BdcaatSAOgxD
Received-SPF: pass client-ip=57.103.74.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

WHvResetPartition resets partition state, and is not supported on Windows 10.

On Arm, it's supposed to be used for reboots.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-accel-ops.c     |  1 +
 accel/whpx/whpx-common.c        | 12 ++++++++++++
 include/accel/accel-cpu-ops.h   |  7 +++++++
 include/system/cpus.h           |  3 +++
 include/system/whpx-accel-ops.h |  2 ++
 system/cpus.c                   |  7 +++++++
 system/runstate.c               |  3 +++
 target/arm/whpx/whpx-all.c      |  2 --
 8 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index b8f41544cb..ddeef79e53 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -98,6 +98,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->handle_interrupt = generic_handle_interrupt;
     ops->supports_guest_debug = whpx_supports_guest_debug;
 
+    ops->vm_reset = whpx_partition_reset;
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 6fe44d5910..daf59207c6 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -205,6 +205,18 @@ static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
     cpu->vcpu_dirty = true;
 }
 
+/*
+ * Partition support
+ */
+
+void whpx_partition_reset(void)
+{
+    struct whpx_state *whpx = &whpx_global;
+    if (whp_dispatch.WHvResetPartition) {
+        whp_dispatch.WHvResetPartition(whpx->partition);
+    }
+}
+
 /*
  * CPU support.
  */
diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 9c07a903ea..32348d3470 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -42,6 +42,13 @@ struct AccelOpsClass {
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
+    /**
+     * vm_reset
+     *
+     * Request to reset the VM to the hardware accelerator.
+     */
+    void (*vm_reset)(void);
+
     /**
      * synchronize_post_reset:
      * synchronize_post_init:
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 508444ccf1..5dcd7fff07 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -40,4 +40,7 @@ void cpu_synchronize_all_post_reset(void);
 void cpu_synchronize_all_post_init(void);
 void cpu_synchronize_all_pre_loadvm(void);
 
+/* VM wide reset */
+void accel_vm_reset(void);
+
 #endif
diff --git a/include/system/whpx-accel-ops.h b/include/system/whpx-accel-ops.h
index 4b2a732654..c809250485 100644
--- a/include/system/whpx-accel-ops.h
+++ b/include/system/whpx-accel-ops.h
@@ -12,6 +12,8 @@
 
 #include "system/cpus.h"
 
+void whpx_partition_reset(void);
+
 int whpx_init_vcpu(CPUState *cpu);
 int whpx_vcpu_exec(CPUState *cpu);
 void whpx_destroy_vcpu(CPUState *cpu);
diff --git a/system/cpus.c b/system/cpus.c
index bded87feb1..6a321873f5 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -203,6 +203,13 @@ bool cpus_are_resettable(void)
     return true;
 }
 
+void accel_vm_reset(void)
+{
+    if (cpus_accel->vm_reset) {
+        cpus_accel->vm_reset();
+    }
+}
+
 void cpu_exec_reset_hold(CPUState *cpu)
 {
     if (cpus_accel->cpu_reset_hold) {
diff --git a/system/runstate.c b/system/runstate.c
index 2d4e95a216..135e2decba 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -564,6 +564,9 @@ void qemu_system_reset(ShutdownCause reason)
         qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
     }
 
+    /* Tell the accelerator that the VM is being reset. */
+    accel_vm_reset();
+
     /*
      * Some boards use the machine reset callback to point CPUs to the firmware
      * entry point.  Assume that this is not the case for boards that support
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 4019a513aa..f345fea4fe 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -472,8 +472,6 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
-            /* Partition-wide reset, to reset state for reboots to succeed. */
-            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
-- 
2.50.1 (Apple Git-155)


