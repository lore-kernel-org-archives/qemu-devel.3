Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD7C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 06:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN3wq-0004Nn-94; Thu, 05 Jun 2025 02:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1uN3wm-0004MC-Qf
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:19:28 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1uN3wj-0008Ba-OG
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:19:28 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5556J758084126
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 14:19:07 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 5 Jun 2025
 14:19:07 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>, Ethan Chen
 <ethan84@andestech.com>
Subject: [PATCH] accel/tcg: Make round-robin kick period configurable
Date: Thu, 5 Jun 2025 14:18:52 +0800
Message-ID: <20250605061852.2081342-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5556J758084126
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, PDS_RDNS_DYNAMIC_FP=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This change introduces a configurable round-robin kick period, giving users the
flexibility to balance SMP simulation accuracy and performance according to
their specific needs.

The round-robin kick period is the time one vCPU can run before scheduler
switches to another vCPU when using a single thread TCG. The default value of
0.1 seconds may allow one vCPU to run for too long before the scheduler
switches to another. This behavior may not be suitable for workloads with
strict timing requirements.

Reducing the period can improve the fidelity of SMP simulation by allowing
more frequent vCPU switching, though it may negatively impact overall
simulation performance.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 accel/tcg/tcg-accel-ops-rr.h |  2 +-
 accel/tcg/tcg-all.c          | 35 +++++++++++++++++++++++++++++++++++
 qemu-options.hx              |  9 ++++++++-
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee..65d8ed87a7 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -64,7 +64,7 @@ static CPUState *rr_current_cpu;
 
 static inline int64_t rr_next_kick_time(void)
 {
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + rr_kick_period;
 }
 
 /* Kick the currently round-robin scheduled vCPU to next */
diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/tcg-accel-ops-rr.h
index 2a76a29612..324bb772cb 100644
--- a/accel/tcg/tcg-accel-ops-rr.h
+++ b/accel/tcg/tcg-accel-ops-rr.h
@@ -10,7 +10,7 @@
 #ifndef TCG_ACCEL_OPS_RR_H
 #define TCG_ACCEL_OPS_RR_H
 
-#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
+extern uint64_t rr_kick_period;
 
 /* Kick all RR vCPUs. */
 void rr_kick_vcpu_thread(CPUState *unused);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 6e5dc333d5..69390020aa 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -36,6 +36,7 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
 #include "qemu/target-info.h"
+#include "qemu/timer.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
@@ -50,6 +51,7 @@ struct TCGState {
     bool one_insn_per_tb;
     int splitwx_enabled;
     unsigned long tb_size;
+    uint64_t rr_kick_period;
 };
 typedef struct TCGState TCGState;
 
@@ -76,9 +78,11 @@ static void tcg_accel_instance_init(Object *obj)
 #else
     s->splitwx_enabled = 0;
 #endif
+    s->rr_kick_period = NANOSECONDS_PER_SECOND / 10;
 }
 
 bool one_insn_per_tb;
+uint64_t rr_kick_period;
 
 static int tcg_init_machine(MachineState *ms)
 {
@@ -125,6 +129,7 @@ static int tcg_init_machine(MachineState *ms)
 #endif
 
     tcg_allowed = true;
+    rr_kick_period = s->rr_kick_period;
 
     page_init();
     tb_htable_init();
@@ -234,6 +239,30 @@ static int tcg_gdbstub_supported_sstep_flags(void)
     }
 }
 
+static void tcg_get_rr_kick_period(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+    uint64_t value = s->rr_kick_period;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void tcg_set_rr_kick_period(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    s->rr_kick_period = value;
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -264,6 +293,12 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
                                    tcg_set_one_insn_per_tb);
     object_class_property_set_description(oc, "one-insn-per-tb",
         "Only put one guest insn in each translation block");
+
+    object_class_property_add(oc, "rr-kick-period", "uint64",
+        tcg_get_rr_kick_period, tcg_set_rr_kick_period,
+        NULL, NULL);
+    object_class_property_set_description(oc, "rr-kick-period",
+        "TCG round robin kick period in nanoseconds");
 }
 
 static const TypeInfo tcg_accel_type = {
diff --git a/qemu-options.hx b/qemu-options.hx
index 7eb8e02b4b..ec8ba79e37 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -232,7 +232,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
     "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n"
-    "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
+    "                device=path (KVM device path, default /dev/kvm)\n"
+    "                rr-kick-period=time (TCG round-robin kick period in nanoseconds)\n", QEMU_ARCH_ALL)
 SRST
 ``-accel name[,prop=value[,...]]``
     This is used to enable an accelerator. Depending on the target
@@ -318,6 +319,12 @@ SRST
         option can be used to pass the KVM device to use via a file descriptor
         by setting the value to ``/dev/fdset/NN``.
 
+    ``rr-kick-period=time``
+        Controls the TCG round-robin kick period in nanoseconds. This option is
+        only effective when using single-threaded TCG. Reducing the period
+        can improve the fidelity of SMP simulation by allowing more frequent
+        vCPU switching, though it may negatively impact overall simulation
+        performance.
 ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-- 
2.34.1


