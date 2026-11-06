Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC10606D809
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ST6vaeuV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPL6c-0000HD-Co; Fri, 06 Nov 2026 09:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xPL6T-0000DN-Ui
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:39:43 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xPL6R-0000hD-Tp
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:39:41 -0500
Received: from DESKTOP-TUU1E5L.fritz.box (p50892c72.dip0.t-ipconnect.de
 [80.137.44.114])
 by linux.microsoft.com (Postfix) with ESMTPSA id A3E9D20B7167;
 Fri,  6 Nov 2026 06:39:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3E9D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793975974;
 bh=oeQeQeXUQsNpZytmLKma9+O/3mVMklEdjRC9NGx0OYI=;
 h=From:To:Cc:Subject:Date:From;
 b=ST6vaeuVzxLJOGgpZcsuUTaNIB4PB2v4oB34cl9DgbBF27AfAnr4aXPCzBBWoM1Do
 5STi4bd+thCbrV/gG6X/wFNIC1Hn/NxyIKBs+l66NW2fezvFwMjWb6O6krD5bwi+Xd
 pxPKSHBtaZWdiXl4zTSMn2zcmHh5JDS6iPBYzBwQ=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Feng Liang <feng.liang@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>
Subject: [PATCH] accel/mshv: freeze time during TSC MSR write
Date: Fri,  6 Nov 2026 15:39:28 +0100
Message-Id: <20261106143928.443144-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A regression was introduced when the HV_X64_REGISTER_TSC MSR state is
being written to the hypervisor as part of the migration framework. If
the MSR is written without the time being frozen, the tsc_page (a
hyper-v enlightenment) is zeroed out and cannot be used by a guest,
which results in a performance regression, because the guest falls back
to costly reads of HV_X64_MSR_TIME_REF_COUNT.

An implementation of pre_resume_vm hook was added to handle the clock
lifecycle, relying on the dirty_vcpu state to avoid redundant state
writes.

Fixes: d540dcc5e28c (target/i386/mshv: migrate MSRs)

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c |  33 ++++++++++++-
 hw/i386/mshv/clock.c  | 111 +++++++++++++++++++++++++++++-------------
 include/system/mshv.h |   4 +-
 3 files changed, 113 insertions(+), 35 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d820a67b95..ae7577d407 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -34,6 +34,7 @@
 #include "accel/accel-cpu-ops.h"
 #include "exec/cpu-common.h"
 #include "system/cpus.h"
+#include "system/hw_accel.h"
 #include "system/runstate.h"
 #include "system/accel-blocker.h"
 #include "system/address-spaces.h"
@@ -578,7 +579,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
 
-    mshv_clock_init();
+    ret = mshv_clock_init(vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
 
     return 0;
 }
@@ -927,6 +931,32 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
     run_on_cpu(cpu, do_mshv_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
 }
 
+static void mshv_pre_resume_vm(AccelState *as, bool step_pending)
+{
+    MshvState *s = MSHV_STATE(as);
+    CPUState *cpu;
+    int ret, vm_fd = s->vm;
+
+    ret = mshv_clock_prepare_resume(vm_fd);
+    if (ret < 0) {
+        error_report("Failed to prepare clock for resume");
+        abort();
+    }
+
+    CPU_FOREACH(cpu) {
+        if (!cpu->vcpu_dirty) {
+            continue;
+        }
+        cpu_synchronize_post_init(cpu);
+    }
+
+    ret = mshv_clock_finish_resume(vm_fd);
+    if (ret < 0) {
+        error_report("Failed to finish clock for resume");
+        abort();
+    }
+}
+
 static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
@@ -962,6 +992,7 @@ static void mshv_accel_class_init(ObjectClass *oc, const void *data)
     ac->name = "MSHV";
     ac->init_machine = mshv_init;
     ac->allowed = &mshv_allowed;
+    ac->pre_resume_vm = mshv_pre_resume_vm;
 }
 
 static void mshv_accel_instance_init(Object *obj)
diff --git a/hw/i386/mshv/clock.c b/hw/i386/mshv/clock.c
index 02c586503a..2a03d3cef9 100644
--- a/hw/i386/mshv/clock.c
+++ b/hw/i386/mshv/clock.c
@@ -29,6 +29,7 @@
 typedef struct MshvClockState {
     uint64_t ref_time;
     bool ref_time_pending;
+    bool time_frozen;
 } MshvClockState;
 
 static MshvClockState mshv_clock;
@@ -110,52 +111,85 @@ static int mshv_set_time_freeze(int vm_fd, int freeze)
     return 0;
 }
 
-static void mshv_clock_vm_state_change(void *opaque, bool running,
-                                       RunState state)
-{
-    MshvClockState *s = opaque;
-    int vm_fd = mshv_state->vm;
+static int ensure_time_frozen(int vm_fd) {
     int ret;
 
-    if (running) {
-        /* Skip if we have nothing to restore, e.g. on initial boot. */
-        if (!s->ref_time_pending) {
-            return;
-        }
+    /* Ensure time is frozen */
+    if (mshv_clock.time_frozen) {
+        return 0;
+    }
 
-        ret = mshv_set_time_freeze(vm_fd, 1);
-        if (ret < 0) {
-            error_report("Failed to freeze partition time on resume");
-            abort();
-        }
+    ret = mshv_set_time_freeze(vm_fd, 1);
+    if (ret < 0) {
+        error_report("Failed to freeze partition");
+        return -1;
+    }
+    mshv_clock.time_frozen = true;
 
+    return 0;
+}
+
+int mshv_clock_prepare_resume(int vm_fd) {
+    return ensure_time_frozen(vm_fd);
+}
+
+int mshv_clock_finish_resume(int vm_fd) {
+    int ret;
+    MshvClockState *s = &mshv_clock;
+
+    assert(mshv_clock.time_frozen);
+
+    /* Skip if we have nothing to restore, e.g. on initial boot. */
+    if (s->ref_time_pending) {
         /* INVARIANT: reference time can only be written if time is frozen. */
         ret = mshv_set_reference_time(vm_fd, s->ref_time);
         if (ret < 0) {
             error_report("Failed to restore reference time on resume");
-            abort();
+            return -1;
         }
+        s->ref_time_pending = false;
+    }
 
-        if (mshv_set_time_freeze(vm_fd, 0) < 0) {
-            error_report("Failed to unfreeze partition time on resume");
-            abort();
-        }
+    ret = mshv_set_time_freeze(vm_fd, 0);
+    if (ret < 0) {
+        error_report("Failed to thaw partition");
+        return -1;
+    }
+    mshv_clock.time_frozen = false;
 
-        s->ref_time_pending = false;
-    } else {
-        /* Skip if we already have a to-be-set ref time */
-        if (s->ref_time_pending) {
-            return;
-        }
+    return 0;
+}
 
-        ret = mshv_get_reference_time(vm_fd, &s->ref_time);
-        if (ret < 0) {
-            error_report("Failed to capture reference time on stop");
-            abort();
-        }
+static void mshv_clock_vm_state_change(void *opaque, bool running,
+                                       RunState state)
+{
+    MshvClockState *s = opaque;
+    int vm_fd = mshv_state->vm;
+    int ret;
 
-        s->ref_time_pending = true;
+    if (running) {
+        return;
     }
+
+    /* Ensure the time if frozen before we capture the reference time. */
+    ret = ensure_time_frozen(vm_fd);
+    if (ret < 0) {
+        error_report("Failed to freeze partition time on stop");
+        abort();
+    }
+
+    /* Skip if we already have a to-be-set ref time */
+    if (s->ref_time_pending) {
+        return;
+    }
+
+    ret = mshv_get_reference_time(vm_fd, &s->ref_time);
+    if (ret < 0) {
+        error_report("Failed to capture reference time on stop");
+        abort();
+    }
+
+    s->ref_time_pending = true;
 }
 
 /*
@@ -182,8 +216,19 @@ static const VMStateDescription vmstate_mshv_clock = {
     },
 };
 
-void mshv_clock_init(void)
+int mshv_clock_init(int vm_fd)
 {
+    int ret;
+
+    ret = mshv_set_time_freeze(vm_fd, 1);
+    if (ret < 0) {
+        error_report("Failed to freeze partition time on init");
+        return -1;
+    }
+    mshv_clock.time_frozen = true;
+
     vmstate_register(NULL, 0, &vmstate_mshv_clock, &mshv_clock);
     qemu_add_vm_change_state_handler(mshv_clock_vm_state_change, &mshv_clock);
+
+    return 0;
 }
diff --git a/include/system/mshv.h b/include/system/mshv.h
index f98ddff9b5..864f2aa34d 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -58,7 +58,9 @@ DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
 extern MshvState *mshv_state;
 
 /* clock (partition reference time) */
-void mshv_clock_init(void);
+int mshv_clock_init(int vm_fd);
+int mshv_clock_prepare_resume(int vm_fd);
+int mshv_clock_finish_resume(int vm_fd);
 
 /* interrupt */
 int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
-- 
2.34.1


