Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E28D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0dm-0006oM-H3; Sun, 28 Dec 2025 18:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0dU-0006SD-8F
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:57:20 -0500
Received: from p-west1-cluster4-host4-snip4-7.eps.apple.com ([57.103.65.208]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0dN-0007Ht-OJ
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:57:16 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 99430180075A; Sun, 28 Dec 2025 23:57:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=yDQcYBWNAHEd8A2N/0TNNze2fwELw9HaH6hZOhtcFNw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NpeJNU6NPDOETpJwf5bC4uvU5vkHojUA2HigOMra+3h6CjrvMehEHTKnMzKujwnOCx+eBH5rCc+TMGxGJf7KBuNpW+q73XBUWxCH5Dajjqve9ZdMlZfdld3QT/YQDii9wQE1uDa56uLQPrpERmQqKQTHS1Yh3poJAtx0NXZbtezrjuFYewj0pZEggqgbQLv9HN6jkQDk8+0vpsfbm57sLgZZH77TZeXj5NzMmFBQC35pOn6Ttg0PU63tgTRfBxGC9DKtDMp05DkcJKY9OO9qJNBUnm4b9tTNr0Sm0FV6QBNQyqNohAEMll5fLFHfuESwPUX0HqMqWGdXdXsFkMFuKQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 2E0AB1800756; Sun, 28 Dec 2025 23:57:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 14/28] hw, target,
 accel: whpx: change apic_in_platform to kernel_irqchip
Date: Mon, 29 Dec 2025 00:54:08 +0100
Message-ID: <20251228235422.30383-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX1mEnoKbgkaTG
 cWjGpKyLDiYsx0ocR+MIjsQ22QH/WQurVi93vN4xvSK1TDUJI/6nCmP+FIGwT2pgynKFJJJHeGN
 Zl6Tfwj5SN8b3C6y1//E2HhlT9v7FgN6Tfm0Q0cnVwNiv8yBBr6ZHPOmWeJukh34lDJ+NMf/O2O
 K135ujNpysZ46P+L/nt/p68jaebkm8WIVGnCDhuxVvGJLAxNkXMr/UeyMoHFJL56znBHBbvDX26
 lQ4rKTf8vz3OWOnM+S2j1f5lWWBJU0wiz6rnNkg1jQLvmR8yfBSEdBaDXhfG2s/PBBO/vbnncXh
 OXZZq0yOaVxr6KWlHzN
X-Authority-Info: v=2.4 cv=U/yfzOru c=1 sm=1 tr=0 ts=6951c3d6 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ogbMO5OAvhA2mBZm2BUA:9
X-Proofpoint-GUID: 3pwQd8Es_DSk9n7Xs8kmV-udVGTilVuu
X-Proofpoint-ORIG-GUID: 3pwQd8Es_DSk9n7Xs8kmV-udVGTilVuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABbCl10hjhW+ZdxqcVX2xaEvlQET//Duyc1qP79m9wLIaVg23mgGJAfLTujixTS74N2T4cjnuNoD1f1bkqE4Z+PIoHykNRW09dhaCV846TBxbjiHCx0PeF8NsoxH8oBA0Qdzp0/tP4IuFh2JrGczSDICEVSga8T49BHBae/uYfWwaa2MTc9PF7ZRXNNx+7V/kWxgF9hy8Iy+lq+UDi5p1t2Rr302eAWkeU8t2fSjrIHM/fhHNykAG76yLkqkfPv5t2TZYLs2xn4LJj4aMUpquCi4vuRb6+cwGBgLCrZOh1JEDbw4ewzk0LBQIt5N7E+gw5KQG0I1zotbweZm9ywRd3z6M9jYWEsO6a9YK+TtBMVsEONZDsHyn88W4pWqTrkqzaCx5yarD69sKeRFFmYQAagWyamXm99qM+ZV11jI2WzUlbK1tb/hNgBoy88vKcIlr6NJKZbB/9W9ItcfcLGDyoV7zHFPAxe7deEEgAu/wKedhfGQwSpfqbLrPygStgnZlpfnyfHxNVoQzscGBJTWwdw4yd3GAdEMI9reo9xqHiSj+FkAS3+RtpZDY1hEym3QOs5rOSWXtEJxjZI7vM3Ja10w5mUX6MuMSNjTgyAE1jp4h4XObELGcuW0S6txh+870eiazxS9LVl+MNQWQ1gynZSX60Nuv/KTrR9cD0x6bP4ySPlnn98Je3E4wX5g87dJ2fPpbWTbToyDa5dRKqTri2pctBzvh7xJsfPzjHkuN5QkvCC2ry29yqrT6SfqbW36Orn6BpbdS9Dcc5+bKsocvHGyV7FqK95eA2CGisBrqxSwG93nAcl7JgEnLi2YVmRyOiAHxTmcqJRYPQr2NP3ZfwvXz/LHgIv4jRWJCTZSKcIIB4YBCxsvWeAJE+eFx8e2nbqYlZUpFIVqXsK+hmlXvW/tYPlzCQMHyT2/jXEoBrY9nRYEprypvaSa3ouPlM45bF
Received-SPF: pass client-ip=57.103.65.208;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
List-Id: <qemu-devel.nongnu.org>
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
index c3e8200c0f..8fe9f3b170 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -39,6 +39,7 @@
 #include <winhvplatformdefs.h>
 
 bool whpx_allowed;
+bool whpx_irqchip_in_kernel;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
 #ifdef HOST_X86_64
@@ -492,15 +493,6 @@ static const TypeInfo whpx_cpu_accel_type = {
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
index eeee62b52a..50a2b8ae86 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -32,7 +32,7 @@ APICCommonClass *apic_get_class(Error **errp)
         apic_type = "kvm-apic";
     } else if (xen_enabled()) {
         apic_type = "xen-apic";
-    } else if (whpx_apic_in_platform()) {
+    } else if (whpx_irqchip_in_kernel()) {
         apic_type = "whpx-apic";
     }
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 052cda42bf..4e829810e5 100644
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
+            whpx->kernel_irqchip = true;
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


