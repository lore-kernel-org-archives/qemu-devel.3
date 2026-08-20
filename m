Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B08CC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yU-00040m-3c; Thu, 20 Aug 2026 12:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yS-00040K-D5
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yP-0005Rj-PF
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52s1E0TAzXaWqv4I1VNn/GeUoyMAJxYF6VAAT+4/X/8=;
 b=KvhgqyY9Zsv8caoHCCg6CLxiss4wdbvve59AFMZgPlTkzLoHU36h70O2Qv47RWMCyGTnZT
 xHlGvj9Ms2QLOc5XzwaWo3/ecolwIuUbkG6hd143THIRtIXaqyHVZgZEwVjHiu8q2lYEVw
 7xsgWHkuSAJp0djFBzJeACusKjHgnak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-geOGaj55P6OZiNd1zLJOSg-1; Thu, 20 Aug 2026 12:50:35 -0400
X-MC-Unique: geOGaj55P6OZiNd1zLJOSg-1
X-Mimecast-MFC-AGG-ID: geOGaj55P6OZiNd1zLJOSg_1787244634
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955e865174so135935e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244634; x=1787849434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=52s1E0TAzXaWqv4I1VNn/GeUoyMAJxYF6VAAT+4/X/8=;
 b=duCVqVrgMVZUetSiiG7hJMFOUxIwmb456jrAKxjOmkx4RZQPngsICr93D0gRRcy3GU
 m5u2dF16orb0LTfxFBvLK5zZpspxO3ehNRnhATi3IEn9iwNiOYIsdsQj1Ux5MTp7/ulr
 1AWe1+T6e1zvot5v17r74l+YnLQ8agmlsrefy48mIjeDIQFYOuvCKhuCJslPPbBeRwAo
 tyLLLgparWuKnFzscNvT7C+yLVqZA16x73cQbJy5xnREZ+sCw0lIJwBHmTYqlJCIO2XZ
 d14iHBrZgXikug7440VuKopzg0CYUA7KxQGtjU/9sBrw1ZD6zDKUL/guw87Z6iHEpZPj
 rt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244634; x=1787849434;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=52s1E0TAzXaWqv4I1VNn/GeUoyMAJxYF6VAAT+4/X/8=;
 b=bPngnYsnd+nQsLdcZbZeEyFHSySb/QgmT9Lf+8Axa8mwjTMmvhubHiDCR4sFXJ962x
 p/gCOKFLWlWBnNHSyDoZAeABFO8YWcyKkYWYYXBHtLp+OnYMGuiT5DSOuRXw9BC3q70q
 QFg+NNg2mWEgzwJR/FpjJBmU4AZiWdqLB0Vm+BDlTcmYRSvO+0+aGwdwT37T1hRxTr2C
 tU/r4OtbIZngnoq3kDZCS3g/a+9odxPbOcCwRsQ6xMM15fRTefMFxoBkNfpk6EK4l/Gx
 6Ti8ImMtQ1oQSSgxxyb5AxNN2S7oyHTtcSU/o/ZkonP3zDHf7ER211C5zx+p1IkQO8we
 IYIQ==
X-Gm-Message-State: AOJu0YygpeGaxWYz2N/WvTfSIsDq8gUvDszuDB5dJS9p6TrMh07DRLFP
 Wh4mWyvWzDvIG5EKc0LgUMn8ozYkJalzLvdP9D6g7nZ5r0TKNDWlEH3iI82kmML6BJ7JFKhBICT
 A6j9aao/nVsUW1GsN/XsuWvQfYNHIuves/qYZj7pWQ2x3RwyZsT3aUGYMgKHye90vf3i8fiHHVZ
 sSiq97nPCYdp7WUJIGkag8fd8rhfEZS8VMMfagj1g+
X-Gm-Gg: AR+sD12UtvJeE5oNLoKmWIuNPtk0MJqYE9mHtFhTf8DXErTvRlYm8UgHF2CBpo48Fuq
 lvTKfbyZJZ+t1nTWThEm10bTEVpYiAuSK+3Ed0U0aJk7Vu1666kXfpKcHtRZ0abNs5tB5hLF3KQ
 GhKGOO2Z6kMnZBeAbk+UYJxV57cBHtZRBKYuCy+UVt6vu9AWTGrNIRqNgLm87A5ycG1eMCCgGE8
 oZj890aF5rqd94yWDKwUr7oJhj5aQvO208j4RO9AIqx74mDmyyW5TRonnWNM7sKcYuae9MPL45A
 E/2+9qBs+Bz6HL+xnNsYIJhF8gw+qRCgo0obYkRQWXL/XNN2mfWBcXBUvuaYpJ413tPYmqnqkYP
 MqNuYy3FOCVyNUVeTToAYdCcKiNC+7zlvWYuScMzmCyJWCcd3inP8ZIqp9b/Z665s1zrgSJ5M3V
 Uvq5k=
X-Received: by 2002:a05:600c:4f09:b0:499:ad2e:f7bc with SMTP id
 5b1f17b1804b1-499b8455734mr3195175e9.10.1787244634253; 
 Thu, 20 Aug 2026 09:50:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4f09:b0:499:ad2e:f7bc with SMTP id
 5b1f17b1804b1-499b8455734mr3193965e9.10.1787244633776; 
 Thu, 20 Aug 2026 09:50:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aaef1665sm161257475e9.5.2026.08.20.09.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 11/53] hw/i386/mshv: migrate REFERENCE_TIME
Date: Thu, 20 Aug 2026 18:49:14 +0200
Message-ID: <20260820164957.1895963-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This is a partition-wide state for which we use a dedicated hw clock
facility, similar to KVM. We have to freeze the time for a partition
before we are allowed to set it. We register a state change handler for
the clock device and a post-load handler for migration state. In the
post-load handler we toggle a flag that will set the reference time
state on next state to "running" on the partition.

We can move the time freeze and reference-time ioctls/hvcalls to the
clock module.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-4-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS              |   1 +
 include/system/mshv.h    |   3 +
 accel/mshv/mshv-all.c    |  67 ++------------
 hw/i386/mshv/clock.c     | 189 +++++++++++++++++++++++++++++++++++++++
 accel/mshv/trace-events  |   1 +
 hw/i386/meson.build      |   1 +
 hw/i386/mshv/meson.build |   4 +
 7 files changed, 208 insertions(+), 58 deletions(-)
 create mode 100644 hw/i386/mshv/clock.c
 create mode 100644 hw/i386/mshv/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index f249be744e9..937c47f4919 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -620,6 +620,7 @@ R: Wei Liu <wei.liu@kernel.org>
 R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
 S: Supported
 F: target/i386/mshv/
+F: hw/i386/mshv/
 
 X86 Instruction Emulator
 M: Roman Bolshakov <rbolshakov@ddn.com>
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 46fe3fcebc2..a6f815b822a 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -55,6 +55,9 @@ DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
 
 extern MshvState *mshv_state;
 
+/* clock (partition reference time) */
+void mshv_clock_init(void);
+
 /* interrupt */
 int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
                            uint32_t vp_index, bool logical_destination_mode,
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index b34fb34d053..7b3c13cf1ed 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -60,54 +60,6 @@ static int init_mshv(int *mshv_fd)
     return 0;
 }
 
-/* freeze 1 to pause, 0 to resume */
-static int set_time_freeze(int vm_fd, int freeze)
-{
-    int ret;
-    struct hv_input_set_partition_property in = {0};
-    in.property_code = HV_PARTITION_PROPERTY_TIME_FREEZE;
-    in.property_value = freeze;
-
-    struct mshv_root_hvcall args = {0};
-    args.code = HVCALL_SET_PARTITION_PROPERTY;
-    args.in_sz = sizeof(in);
-    args.in_ptr = (uint64_t)&in;
-
-    ret = mshv_hvcall(vm_fd, &args);
-    if (ret < 0) {
-        error_report("Failed to set time freeze");
-        return -1;
-    }
-
-    return 0;
-}
-
-static int pause_vm(int vm_fd)
-{
-    int ret;
-
-    ret = set_time_freeze(vm_fd, 1);
-    if (ret < 0) {
-        error_report("Failed to pause partition: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int resume_vm(int vm_fd)
-{
-    int ret;
-
-    ret = set_time_freeze(vm_fd, 0);
-    if (ret < 0) {
-        error_report("Failed to resume partition: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
 static int get_host_partition_property(int mshv_fd, uint32_t property_code,
                                        uint64_t *value)
 {
@@ -330,9 +282,6 @@ static int create_vm(int mshv_fd, int *vm_fd)
         return -1;
     }
 
-    /* Always create a frozen partition */
-    pause_vm(*vm_fd);
-
     return 0;
 }
 
@@ -578,13 +527,6 @@ static int mshv_init(AccelState *as, MachineState *ms)
         return -1;
     }
 
-    ret = resume_vm(vm_fd);
-    if (ret < 0) {
-        close(mshv_fd);
-        close(vm_fd);
-        return -1;
-    }
-
     s->vm = vm_fd;
     s->fd = mshv_fd;
 
@@ -606,6 +548,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
 
+    mshv_clock_init();
+
     return 0;
 }
 
@@ -643,6 +587,13 @@ static int mshv_cpu_exec(CPUState *cpu)
             cpu->vcpu_dirty = false;
         }
 
+        /* Corresponding store-release is in cpu_exit. */
+        if (qatomic_load_acquire(&cpu->exit_request)) {
+            trace_mshv_interrupt_exit_request(cpu->cpu_index);
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+
         ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
         if (ret < 0) {
             error_report("Failed to run on vcpu %d", cpu->cpu_index);
diff --git a/hw/i386/mshv/clock.c b/hw/i386/mshv/clock.c
new file mode 100644
index 00000000000..02c586503a6
--- /dev/null
+++ b/hw/i386/mshv/clock.c
@@ -0,0 +1,189 @@
+/*
+ * MSHV partition reference clock
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Magnus Kulke <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "migration/vmstate.h"
+#include "system/runstate.h"
+#include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "linux/mshv.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+/*
+ * Partition reference clock (HV_PARTITION_PROPERTY_REFERENCE_TIME), captured
+ * when the VM is stopped and re-applied when it resumes.
+ *
+ * Mirrors hw/i386/kvm/clock.c.
+ */
+typedef struct MshvClockState {
+    uint64_t ref_time;
+    bool ref_time_pending;
+} MshvClockState;
+
+static MshvClockState mshv_clock;
+
+static int mshv_get_reference_time(int vm_fd, uint64_t *ref_time)
+{
+    struct hv_input_get_partition_property in = { 0 };
+    struct hv_output_get_partition_property out = { 0 };
+    struct mshv_root_hvcall args = { 0 };
+    int ret;
+
+    in.property_code = HV_PARTITION_PROPERTY_REFERENCE_TIME;
+
+    args.code        = HVCALL_GET_PARTITION_PROPERTY;
+    args.in_sz       = sizeof(in);
+    args.in_ptr      = (uint64_t)&in;
+    args.out_sz      = sizeof(out);
+    args.out_ptr     = (uint64_t)&out;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to get reference time");
+        return -1;
+    }
+
+    *ref_time = out.property_value;
+    return 0;
+}
+
+static int mshv_set_reference_time(int vm_fd, uint64_t ref_time)
+{
+    struct hv_input_set_partition_property in = { 0 };
+    struct mshv_root_hvcall args = { 0 };
+    int ret;
+
+    in.property_code  = HV_PARTITION_PROPERTY_REFERENCE_TIME;
+    in.property_value = ref_time;
+
+    args.code         = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz        = sizeof(in);
+    args.in_ptr       = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set reference time");
+        return -1;
+    }
+
+    return 0;
+}
+
+/*
+ * Freeze (freeze=1) or unfreeze (freeze=0) time for a partition. This will not
+ * pause/eject vCPU execution. It is assumed that the caller already has stopped
+ * the partition's vCPUs.
+ *
+ * NB: a partition's reference clock can only be written while the time is
+ * frozen.
+ */
+static int mshv_set_time_freeze(int vm_fd, int freeze)
+{
+    struct hv_input_set_partition_property in = { 0 };
+    struct mshv_root_hvcall args = { 0 };
+    int ret;
+
+    in.property_code  = HV_PARTITION_PROPERTY_TIME_FREEZE;
+    in.property_value = freeze;
+
+    args.code         = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz        = sizeof(in);
+    args.in_ptr       = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set time freeze");
+        return -1;
+    }
+
+    return 0;
+}
+
+static void mshv_clock_vm_state_change(void *opaque, bool running,
+                                       RunState state)
+{
+    MshvClockState *s = opaque;
+    int vm_fd = mshv_state->vm;
+    int ret;
+
+    if (running) {
+        /* Skip if we have nothing to restore, e.g. on initial boot. */
+        if (!s->ref_time_pending) {
+            return;
+        }
+
+        ret = mshv_set_time_freeze(vm_fd, 1);
+        if (ret < 0) {
+            error_report("Failed to freeze partition time on resume");
+            abort();
+        }
+
+        /* INVARIANT: reference time can only be written if time is frozen. */
+        ret = mshv_set_reference_time(vm_fd, s->ref_time);
+        if (ret < 0) {
+            error_report("Failed to restore reference time on resume");
+            abort();
+        }
+
+        if (mshv_set_time_freeze(vm_fd, 0) < 0) {
+            error_report("Failed to unfreeze partition time on resume");
+            abort();
+        }
+
+        s->ref_time_pending = false;
+    } else {
+        /* Skip if we already have a to-be-set ref time */
+        if (s->ref_time_pending) {
+            return;
+        }
+
+        ret = mshv_get_reference_time(vm_fd, &s->ref_time);
+        if (ret < 0) {
+            error_report("Failed to capture reference time on stop");
+            abort();
+        }
+
+        s->ref_time_pending = true;
+    }
+}
+
+/*
+ * The incoming reference time should be applied on the next resume before
+ * vCPUs start executing.
+ */
+static int mshv_clock_post_load(void *opaque, int version_id)
+{
+    MshvClockState *s = opaque;
+
+    s->ref_time_pending = true;
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_mshv_clock = {
+    .name = "mshv-clock",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = mshv_clock_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(ref_time, MshvClockState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+void mshv_clock_init(void)
+{
+    vmstate_register(NULL, 0, &vmstate_mshv_clock, &mshv_clock);
+    qemu_add_vm_change_state_handler(mshv_clock_vm_state_change, &mshv_clock);
+}
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index a4dffeb24a3..859e8bfb0f3 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -4,6 +4,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 mshv_start_vcpu_thread(const char* thread, uint32_t cpu) "thread=%s cpu_index=%d"
+mshv_interrupt_exit_request(uint32_t cpu) "cpu_index=%d"
 
 mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "add=%d gpa=0x%" PRIx64 " size=0x%" PRIx64 " user=0x%" PRIx64 " readonly=%d result=%d"
 mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" PRIx64 " size=%d data=0x%x"
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index b611fbb5a7f..f4d31228633 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -39,6 +39,7 @@ i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c', 'tdvf-hob.c'))
 
 subdir('kvm')
 subdir('xen')
+subdir('mshv')
 
 i386_ss.add_all(xenpv_ss)
 
diff --git a/hw/i386/mshv/meson.build b/hw/i386/mshv/meson.build
new file mode 100644
index 00000000000..0e556851b67
--- /dev/null
+++ b/hw/i386/mshv/meson.build
@@ -0,0 +1,4 @@
+i386_mshv_ss = ss.source_set()
+i386_mshv_ss.add(files('clock.c'))
+
+i386_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
-- 
2.55.0


