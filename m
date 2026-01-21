Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7AFC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYTo-0005UE-Oy; Wed, 21 Jan 2026 08:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYT5-0004uV-7C
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:56 -0500
Received: from qs-2003c-snip4-2.eps.apple.com ([57.103.86.25]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYT2-0001FZ-HV
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:54 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 B444E18000AA; Wed, 21 Jan 2026 13:41:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002911; x=1771594911;
 bh=JwG09taZNQZEUrnety/DLmIDMJ9+cgWSAONaI1A1Ms0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ug1uuUBUV3oW6AIy7w7+0o498OxnSY3vN4JFMWkAzPuH9jYwHWolhyD1ykrNOg2tgxf9z427Q7vLbHygc3HMT9g17ZWsDwleXf/onTEPKZLzU4lGHM9Re0RGh9BD6u/Jt9Q+MBo9DDB6CG5nxBPy2/+5xIVJzqGrbRC/rE9IpgYnq7xLPvpbwXPEBw+UYryrHUHajwviehIdrFn0Z+Fz9k4H25PUtJ2a3l93gUnj/YyQOYUrhwBIzBVLyuOxJlAS91fEyejL5/Iy2kpSq2c9yc5oAEJcL8Y7wPYLcDiqQ3LlscLi12JMJMxpo60O0el1dorpnE7BXiEhLNVQDVSUrw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 99E1D180014D; Wed, 21 Jan 2026 13:41:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 10/21] hw, target,
 accel: whpx: change apic_in_platform to kernel_irqchip
Date: Wed, 21 Jan 2026 14:41:01 +0100
Message-ID: <20260121134114.9781-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Vd36/Vp9 c=1 sm=1 tr=0 ts=6970d79d
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=ogbMO5OAvhA2mBZm2BUA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nH_g8CeHfyCDCNgr_Mi0rFtK-iPksSLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX/CVcqbmVa9wo
 PgSpZwqjzg+5MBiawm1ECuNqiRWdAw5mOeKc9dJ3vq2i77MoM1pm0m5k5FqA7TU2mTWqav3EJvv
 iWl98o63DzhrkbTF4492wqeHQjfYHV4Or0ZQWUsuyQ25DciBDZUO+2jSjRvaVG5JqSCC1Fh5kD0
 GoWSQHTfpgpcy8do1f7OAta8bEiL7TD/qqitzXTWe8GTMGMtBmvoDv4hm0d2DecqBoGIP7r/U1c
 HbxzPKc8vPpMBJhk7PG4MQ8ID7o0SeI09XfaYZKsolqx0C4So46OkGwyQBILANYAhubcB+R+EMG
 zq2fY8wK5hz+7QL5gfA
X-Proofpoint-GUID: nH_g8CeHfyCDCNgr_Mi0rFtK-iPksSLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0
 clxscore=1030 phishscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABlO1x05l0PiCZxEqNpTPyEu+hi8Uym6/djc9JX4COxcTg3EXVYwhwoUtbr02iQSFFAbfhCSOYJ7wEI/4y4Aa0d6TPXdjr4ZSsBonmmJ/BnVSQ27v8GKn92SVRiAgb+FnP536a8/GQbQ4xXLP6u4zyuns3e94Chf+x9WM9WHvGPYTLJINyam15uU+18JBLdQPBIw2hzM4MQJCKoDEcCIHKYzehIna1QkQFAb4hDkDz+K6kyCXwECriYt4ZxAlTgq2QzoJpf7tACcryx8WkRw6knC8GzkYD3B1PDkNWdRn3qV0NSZswOzTDlO7CA/VM9G6slWiWFE6k7OdzdzETrTLQpx17Z1jV+aFLUR04lmda1HzPrRUuONNy2rJJH8ueugtLuu3Xno5oZ53WWlR0rkQnvWk+S4U3SduUo+hFxs4yQEbgxzojh1dVmX+fiAhRsp/tuih1uEaEyex1LYKG7SEX3FJtPuZxizxb7aoXDTcAnZ//5fG95G4QkHPRBHL6J8s4aPcC8wNQ+Sl0rJt5re6Oa+awPJwlUEQ6Edc/h/d2JPzIZWEfPyH+UCOikapsghIRX+10PZ8KC+uMOZnGp3kN+RqhBWjvx8Qr2EymJER1i9xsK6yuZX5SFbru6srZnmhfDIoCrCE1JqWmEtSuCyKHno9tu/GBpLVrCD26gP4EIe/zc9aSNmWaxcl5Coez32xHqh8kxPjFzZb1x5jztqY2wD+TWTDx0lwuX7A0ck4DcQInYEsQKTHYKAiPv/qbZLRcsm/s9jburQJmEfRLvUlPRJARM4gmCISuFKmkNVe3RKJ3R/Wac/Oi2wuEYdXp5hL3R9BOi0AcM3Qy5kehVjoQZBu2/v0J9x1CUsu8C+yqTmwN91eWYeB3T76ZgkFGPOzqwc+XVuQ=
Received-SPF: pass client-ip=57.103.86.25;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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


