Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739A0F46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fsH-0003mx-8b; Mon, 23 Mar 2026 10:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fpS-0000ws-Ly
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:29 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fpR-0007JF-1i
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:26 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 25AB420B6F1B;
 Mon, 23 Mar 2026 07:00:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25AB420B6F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274414;
 bh=9BS8GXf6VR6ZaAFlkE7y0tvwO0EDUtmobElH9h7DNf8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OIoGS9GKpf2Umk6z462NM92lu9gamDiTmGQtjQ/nKrxFTDphm8IElsq/7FcPNUMK9
 L6SxxFIeWcR/ozR2uJ+v6ksidX1l1NfVLw88XDwip7QLRk7dV+MWttY2oVu83Cw/5M
 Y38sZ0w+b+uYSLl5FreenHD/iE8rXgbGOLN3Rix4=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 31/32] target/i386/mshv: migrate MP_STATE
Date: Mon, 23 Mar 2026 14:58:11 +0100
Message-Id: <20260323135812.383509-32-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

MSHV's "internal activity state" roughly maps to QEMU's env->mp_state
and cpu->halted states that describe state of APs in a guest.

We don't invoke set_mp_state as part of store_vcpu_state() b/c we would
put all BSP + APs in a RUNNABLE (0) state immediately, breaking SMP boot

Instead we store the mp state as part of the load_cleanup() routine
after a migration.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       | 10 +++++
 include/system/mshv_int.h   |  1 +
 target/i386/mshv/mshv-cpu.c | 80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 3927a82925..45fe1ef468 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -205,6 +205,7 @@ static int mshv_load_setup(QEMUFile *f, void *opaque, Error **errp)
 static int mshv_load_cleanup(void *opaque)
 {
     MshvState *s = opaque;
+    CPUState *cpu;
     int ret;
 
     ret = mshv_arch_set_partition_msrs(first_cpu);
@@ -213,6 +214,15 @@ static int mshv_load_cleanup(void *opaque)
         return -1;
     }
 
+    CPU_FOREACH(cpu) {
+        ret = mshv_arch_set_mp_state(cpu);
+        if (ret < 0) {
+            error_report("Failed to set mp state for vCPU %d: %s",
+                         cpu->cpu_index, strerror(-ret));
+            return -1;
+        }
+    }
+
     resume_vm(s->vm);
 
     return 0;
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index bc16b794b2..c24efc8675 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -98,6 +98,7 @@ int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 int mshv_arch_set_partition_msrs(const CPUState *cpu);
+int mshv_arch_set_mp_state(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 80e5dd5a4b..c2c217372a 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -33,6 +33,11 @@
 
 #include <sys/ioctl.h>
 
+#define MSHV_MP_STATE_RUNNABLE       0
+#define MSHV_MP_STATE_UNINITIALIZED  1
+#define MSHV_MP_STATE_INIT_RECEIVED  2
+#define MSHV_MP_STATE_HALTED         3
+
 #define MAX_REGISTER_COUNT (MAX_CONST(ARRAY_SIZE(STANDARD_REGISTER_NAMES), \
                             MAX_CONST(ARRAY_SIZE(SPECIAL_REGISTER_NAMES), \
                                       ARRAY_SIZE(FPU_REGISTER_NAMES))))
@@ -814,6 +819,76 @@ static int set_vcpu_events(const CPUState *cpu)
     return 0;
 }
 
+static int get_mp_state(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assoc = {
+        .name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+    };
+    union hv_internal_activity_register activity;
+    int ret;
+
+    ret = mshv_get_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to get internal activity state");
+        return -1;
+    }
+
+    activity.as_uint64 = assoc.value.reg64;
+
+    /*
+     * map MSHV activity state to KVM mp_state values, which are used as the
+     * shared representation in env->mp_state and serialized by vmstate_x86_cpu.
+     */
+
+    if (activity.startup_suspend) {
+        env->mp_state = MSHV_MP_STATE_UNINITIALIZED;
+    } else if (activity.halt_suspend) {
+        env->mp_state = MSHV_MP_STATE_HALTED;
+    } else {
+        env->mp_state = MSHV_MP_STATE_RUNNABLE;
+    }
+
+    cpu->halted = (env->mp_state == MSHV_MP_STATE_HALTED);
+
+    return 0;
+}
+
+int mshv_arch_set_mp_state(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    union hv_internal_activity_register activity = { 0 };
+    struct hv_register_assoc assoc = {
+        .name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+    };
+    int ret;
+
+    switch (env->mp_state) {
+    case MSHV_MP_STATE_HALTED:
+        activity.halt_suspend = 1;
+        break;
+    case MSHV_MP_STATE_UNINITIALIZED:
+    case MSHV_MP_STATE_INIT_RECEIVED:
+        activity.startup_suspend = 1;
+        break;
+    case MSHV_MP_STATE_RUNNABLE:
+    default:
+        break;
+    }
+
+    assoc.value.reg64 = activity.as_uint64;
+
+    ret = mshv_set_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to set internal activity state");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int update_hflags(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -876,6 +951,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_mp_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.34.1


