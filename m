Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19742EC1EB2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzAO-0007vc-0k; Thu, 05 Feb 2026 08:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAM-0007tl-0u
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:02 -0500
Received: from p-west2-cluster1-host6-snip4-2.eps.apple.com ([57.103.68.55]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAJ-0001bM-6x
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:01 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 994471800267; Thu,  5 Feb 2026 13:12:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297178; x=1772889178;
 bh=wotQD53wahvTZVPsQ/x7wxW0ufPSWLoHS0P9jsj7IYo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TF8wscpELNLAgjFbKvyCtKGyQAkz4GoqJhC6ujVXZmWp4B667dCI+QI9ySyRtxsNiyyVoE/t/cEnGeaDcJD/3tFwMlNJRNraeCdoX86vsBInEVmhCm1E8KgiViO6mRdhked3V/632B0U6BKHqGOPQm0LEGiyZWhFaJe77LT2Z7+3yKO0stzg1sTBJyA+iNQ0f+4YRu2Jw1OrM5NoMCc0ZR/vXd4C9EkKPVqLuuKbKAEoU7ukqv7rhpxGeaqGQMTYC6+ZwkYCOnAeZH4x7hijRXa3Vt6mdV0M+m5eS1vBj5qUQVuhb9OIIN8eABUySfkOvYtTIsi3PreedVAGyvOeSw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 4E58F1800167; Thu,  5 Feb 2026 13:12:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 12/22] hw, target,
 accel: whpx: change apic_in_platform to kernel_irqchip
Date: Thu,  5 Feb 2026 14:11:41 +0100
Message-ID: <20260205131155.22780-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=R9gO2NRX c=1 sm=1 tr=0 ts=69849759
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=ogbMO5OAvhA2mBZm2BUA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfXxg+rHycJhozi
 IN6x7K1SzRqdxUooGhWqswSvqMAn4oPAMIyNbGA2B+nKZErsymPiAdjotMkkXtCWkHGa0TzcfUZ
 9cFsNTLg5QTPevVHUNB7CMd66PJ8bhcOzLTjo+bKEC+EwGPwf5WNccXbUlT5FH4vNvqOk9NAAEo
 mo4oJNVA0MTCkysE72Lb3x6r+xiMnrC5Q5axGrFxVLUfsTt4I6Ogbsspa9KyfnXSFvqVxbfe7+s
 lOUB+cZZA+DHgOkutTdwA5VeJmoWEPQpjgMH2wAhwWAJPA/Hb9nMY1cRixUDgk/xYvZHtGjQbbc
 D71vFLp9m7L6xA5q7C4IGPeTAQmIrAxDPYwGpWUWsKugzWnEC5Ub0Wq12z8kTQ=
X-Proofpoint-ORIG-GUID: IF8Lz-GovDnB8Ozc-TLP4CX5hXwWoBVs
X-Proofpoint-GUID: IF8Lz-GovDnB8Ozc-TLP4CX5hXwWoBVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAAB0AUIy+L7bIOtEhlN5sqUEWzuLY2UswHsI3HCuTLyNJ9pmLhM6Gx5eAcL7dcgVjfZmYRD4gt4W/oPf2mTwdYqqqgxM1dfUBMXN2O1cjVT/ggUWg3gze138wwUBc8Ue2hF+M81yLLHDhHzACIzvoDGX28A1f2ebMheZNjkdfj6/Szpr69NvE7A1v0I5erHThuOoP8amui5hONsWXGEy3xRosJ7WCjXbLFdPa4wJGT0ed4kgDbwfVqXetycCqNFu5CLenAs45C3Q4325fy6bDOM6ud2OtS95FfApQjgPqxh3pqp+LQ5OELbq1+LxPxBdAy46SjrpkT/Q071LDM/VG0VVz9093hb0tL+hYZlueAkZTACdyIspCe+GWkg2wPvssxiVUv0HU6kCGvuuOhmgRrP+OfWxyKNFFj6dSMPGA/ZNpucfbYBcEHuJHUx/nipSRP/VWohWRKfBokQBSw/mPFzv1QayqllsnbBQ33wC6yPTtbvwlH5hwK9kn/6uqivQAiBijzMXfAfb2axkX6mjxowb00azuoYP86QV5+JZytjAzS7sPxKrtrhLMoRqVSj/jpDZ5nNE+7ydpTEvn9w1HX1M7VId8MtYFqYRWYGdbnS+wFTbGVZaJktrKcXxrETGT7SH8KfHLs0kCFgQ3jVbOARP81QZ3nJY21aGfMLKPQv27OPAGgKQO56BbGBdjlb8F3oVusCl8elIllHDq0usNIlfAVD5ctsJnzxf3jyPmJtiNjCtu1QglyPAqXmqlZZJz7klQrqxUvdXJOoQ6NI0kaeB53klFpPJiIXCRDT8OfvQKuMUUcvWoMp+ZGs9ak9WkgIhA7NoNW76bdLnx9DB46U/8x47TOCds3nIobh5vYRcv+OMg34cjCocg0P9WaA2N4TQFD/eHJL5APdxb4fFzP0LzfnTSM3JdiJoMO1VMOG2sUxrquUgCfYrMsPzv61r/wLxhDSbqcP
Received-SPF: pass client-ip=57.103.68.55;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Change terminology to match the KVM one, as APIC is x86-specific.

And move out whpx_irqchip_in_kernel() to make it usable from common
code even when not compiling with WHPX support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/stubs/whpx-stub.c        |  1 +
 accel/whpx/whpx-accel-ops.c    |  2 +-
 accel/whpx/whpx-common.c       | 10 +---------
 hw/i386/x86-cpu.c              |  4 ++--
 include/system/whpx-internal.h |  1 -
 include/system/whpx.h          |  5 +++--
 target/i386/cpu-apic.c         |  2 +-
 target/i386/whpx/whpx-all.c    | 14 +++++++-------
 8 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
index c564c89fd0..4529dc4f78 100644
--- a/accel/stubs/whpx-stub.c
+++ b/accel/stubs/whpx-stub.c
@@ -10,3 +10,4 @@
 #include "system/whpx.h"
 
 bool whpx_allowed;
+bool whpx_irqchip_in_kernel;
diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index c84a25c273..50fadea0fd 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -78,7 +78,7 @@ static void whpx_kick_vcpu_thread(CPUState *cpu)
 
 static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
 {
-    return !whpx_apic_in_platform();
+    return !whpx_irqchip_in_kernel();
 }
 
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c0610815d9..05f9e520b7 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -35,6 +35,7 @@
 #include <winhvplatformdefs.h>
 
 bool whpx_allowed;
+bool whpx_irqchip_in_kernel;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
 #ifdef HOST_X86_64
@@ -488,15 +489,6 @@ static const TypeInfo whpx_cpu_accel_type = {
     .abstract = true,
 };
 
-/*
- * Partition support
- */
-
-bool whpx_apic_in_platform(void)
-{
-    return whpx_global.apic_in_platform;
-}
-
 static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 276f2b0cdf..95e08e3c2a 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -45,7 +45,7 @@ static void pic_irq_request(void *opaque, int irq, int level)
 
     trace_x86_pic_interrupt(irq, level);
     if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
-        !whpx_apic_in_platform()) {
+        !whpx_irqchip_in_kernel()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
             if (apic_accept_pic_intr(cpu->apic_state)) {
@@ -71,7 +71,7 @@ int cpu_get_pic_interrupt(CPUX86State *env)
     X86CPU *cpu = env_archcpu(env);
     int intno;
 
-    if (!kvm_irqchip_in_kernel() && !whpx_apic_in_platform()) {
+    if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
         intno = apic_get_interrupt(cpu->apic_state);
         if (intno >= 0) {
             return intno;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 609d0e1c08..8ded54a39b 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -45,7 +45,6 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-    bool apic_in_platform;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/include/system/whpx.h b/include/system/whpx.h
index 00f6a3e523..4217a27e91 100644
--- a/include/system/whpx.h
+++ b/include/system/whpx.h
@@ -25,11 +25,12 @@
 
 #ifdef CONFIG_WHPX_IS_POSSIBLE
 extern bool whpx_allowed;
+extern bool whpx_irqchip_in_kernel;
 #define whpx_enabled() (whpx_allowed)
-bool whpx_apic_in_platform(void);
+#define whpx_irqchip_in_kernel() (whpx_irqchip_in_kernel)
 #else /* !CONFIG_WHPX_IS_POSSIBLE */
 #define whpx_enabled() 0
-#define whpx_apic_in_platform() (0)
+#define whpx_irqchip_in_kernel() (0)
 #endif /* !CONFIG_WHPX_IS_POSSIBLE */
 
 #endif /* QEMU_WHPX_H */
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index f7ad7b5139..eaa10ad2a3 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -33,7 +33,7 @@ APICCommonClass *apic_get_class(Error **errp)
         apic_type = "kvm-apic";
     } else if (xen_enabled()) {
         apic_type = "xen-apic";
-    } else if (whpx_apic_in_platform()) {
+    } else if (whpx_irqchip_in_kernel()) {
         apic_type = "whpx-apic";
     }
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 052cda42bf..8210250dc3 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -607,7 +607,7 @@ void whpx_get_registers(CPUState *cpu)
                      hr);
     }
 
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -749,7 +749,7 @@ void whpx_get_registers(CPUState *cpu)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
@@ -1379,7 +1379,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Get pending hard interruption or replay one that was overwritten */
-    if (!whpx_apic_in_platform()) {
+    if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
             vcpu->interruptable && (env->eflags & IF_MASK)) {
             assert(!new_int.InterruptionPending);
@@ -1553,7 +1553,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
     if (exclusive_step_mode == WHPX_STEP_NONE) {
         whpx_vcpu_process_async_events(cpu);
-        if (cpu->halted && !whpx_apic_in_platform()) {
+        if (cpu->halted && !whpx_irqchip_in_kernel()) {
             cpu->exception_index = EXCP_HLT;
             qatomic_set(&cpu->exit_request, false);
             return 0;
@@ -1642,7 +1642,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
 
         case WHvRunVpExitReasonX64ApicEoi:
-            assert(whpx_apic_in_platform());
+            assert(whpx_irqchip_in_kernel());
             ioapic_eoi_broadcast(vcpu->exit_ctx.ApicEoi.InterruptVector);
             break;
 
@@ -2187,7 +2187,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
                 goto error;
             }
         } else {
-            whpx->apic_in_platform = true;
+            whpx_irqchip_in_kernel = true;
         }
     }
 
@@ -2196,7 +2196,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.X64CpuidExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
     }
 
-- 
2.50.1 (Apple Git-155)


