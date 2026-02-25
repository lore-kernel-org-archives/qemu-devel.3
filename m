Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E767F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5v1-0007L1-3T; Tue, 24 Feb 2026 22:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5uz-0007K6-OX
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5ux-00086r-V3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2JMNY57q+gMbuW6Ehyq7A57okqwWcUKTKfqA74PG5Y=;
 b=DeNUQMkjzIKyvCpEeJALSyRBc2oV0B4F1NEKTuS7nG/BzmEyap95lKe9nTQXEUoScbrw/D
 gjBhdcZ4f0E+Or8wzEOZPNKpIZuEFgeBU4kgFGMQXWdGfpXDJ1SleOZc023cn1F+mxuH1d
 mBQ/LOgQYqxESNchFyGBXZlWtpimTH0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407--1ZJNb3mMu69I2CypjJRIg-1; Tue, 24 Feb 2026 22:50:27 -0500
X-MC-Unique: -1ZJNb3mMu69I2CypjJRIg-1
X-Mimecast-MFC-AGG-ID: -1ZJNb3mMu69I2CypjJRIg_1771991426
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358f058973fso1012454a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991426; x=1772596226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2JMNY57q+gMbuW6Ehyq7A57okqwWcUKTKfqA74PG5Y=;
 b=tONMTjE1lbQAbkfU9K/aS5e2H/r74tasGN0WUnTDDdYcbUtKBoDoHVG/tluqYUJL0c
 bUBe+c8buUp/ZBGZj8vIMJMrSFRqTQ307o+6O6tNRAs8w1iIdRsh0hHL73eB81V1QMbp
 GrGEWBhDEXkEbrDIuyjxawYepyfSokHHN+fMh2lqES+clB/qykfv5lWgmL865HtFqFKR
 /JMi6k69PIdxhvpCUVoHVt5RJL8MNZfS1R9f6CVbHo8YokWbmWZLb2NGBiNB/LlxXVhk
 yLOnty7ttaRY6d3Q/KSEn8o5dUbcwQyR1++P0pexcjytpr3ELTjEH3IumIncE4VyUDoG
 8oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991426; x=1772596226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P2JMNY57q+gMbuW6Ehyq7A57okqwWcUKTKfqA74PG5Y=;
 b=H7lq6xXo2ofPmhCnmkS3HFZSqz5jfz2mxYkiHVVm8cT5NTkLjvAck7N+qbBh5eFn8Y
 W9wiqs6ci9H4sbB2Y+0D+VojumcY1rKb2d9SCW2/our0FdbfqbnIQO2qw2S1+VbvsHLJ
 IOFY1Zyl0vDtjSt+v8LzhXcBHM+0SD2t1YgweFn+BJDkWrn9lkBcso5KfYkd4A1moASk
 VYMqupXughNrgqods0Hqexc0uRFjL9OJ2AcqSrYIRFvnKOgNguvT4TzkXKtFg++OaB7+
 FeKygmkCEmFOOatACNGzZtQucn5dlW9P+He3Trdh19s54+v0lThqpca+gEYssYenKdGz
 Z/Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiquW4XJkeOKE+hGlXclOwYZnLTLz9ErRSA7aCaeyhTzS0ADvR1bEeqK3PSILNHVHLrV08eepnjtTG@nongnu.org
X-Gm-Message-State: AOJu0Yw4nEirRK1wmcnubYlJonoJ2TucofnXr5P8qvhAoXgY3c+tdaXY
 mQgcxkL15UYCoqXP+eANCL4bnj28Aa/nsay+cv47r8PQYnhBQv0Sie/gO8lRMugJEeUQ5bDVipW
 Tx69Zx8uYkoySlkiOqxX1iHn2s5obFRBmkO5PeayYECmahvGGfqkjdpOs
X-Gm-Gg: ATEYQzxd1nxeRrPaYgQ+qmbxgPI1crUi8/YCSX+Z4xHp+yJBuDMjXBdRJ+YfXmI5RCL
 zetGhm/crK9Hp8vNiJn5rrOEoc7zI06E8PjawelgWL7F7J5/BqiOk7P0zV+ToAUw0U2ujjQbV5Z
 i/+pXGV/WhQLjsaCsfXB7MxLUx9JEawa+dT7VdRmhYgPgUwXHBmDH7qHojEZUHkxniywriZHbk0
 xxRVnWBE0/H9cdxnjThXZlefXhjZbKr9c5rfMrdtM6zi9SnLrQzcj5dZJzGVnFYhgww2tnuyb44
 EBBE5MEMOenfhL/s5SqDJNllVx3C4MvO+5JIvJgHyRlzdWYVshZFN4BJocUxAZs33zsoXK3HFK4
 l5As+uMycmlwgQK0aEiDk8z9cD/m0ZhTbkNTnn7Jr+yzqEV2T1vBeK0M=
X-Received: by 2002:a17:90b:2b8b:b0:354:bfb7:db13 with SMTP id
 98e67ed59e1d1-358ae8d3af1mr10627436a91.35.1771991426195; 
 Tue, 24 Feb 2026 19:50:26 -0800 (PST)
X-Received: by 2002:a17:90b:2b8b:b0:354:bfb7:db13 with SMTP id
 98e67ed59e1d1-358ae8d3af1mr10627421a91.35.1771991425813; 
 Tue, 24 Feb 2026 19:50:25 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, ani@anisinha.ca, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v6 05/35] accel/kvm: add changes required to support KVM VM
 file descriptor change
Date: Wed, 25 Feb 2026 09:19:10 +0530
Message-ID: <20260225035000.385950-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

This change adds common kvm specific support to handle KVM VM file descriptor
change. KVM VM file descriptor can change as a part of confidential guest reset
mechanism. A new function api kvm_arch_on_vmfd_change() per
architecture platform is added in order to implement architecture specific
changes required to support it. A subsequent patch will add x86 specific
implementation for kvm_arch_on_vmfd_change() as currently only x86 supports
confidential guest reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS            |  6 +++
 accel/kvm/kvm-all.c    | 88 ++++++++++++++++++++++++++++++++++++++++--
 accel/kvm/trace-events |  1 +
 include/system/kvm.h   |  3 ++
 stubs/kvm.c            | 22 +++++++++++
 stubs/meson.build      |  1 +
 target/i386/kvm/kvm.c  | 10 +++++
 7 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 stubs/kvm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71..6377ff5898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -152,6 +152,12 @@ F: tools/i386/
 F: tests/functional/i386/
 F: tests/functional/x86_64/
 
+X86 VM file descriptor change on reset test
+M: Ani Sinha <anisinha@redhat.com>
+M: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: stubs/kvm.c
+
 Guest CPU cores (TCG)
 ---------------------
 Overall TCG CPUs
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0d8b0c4347..cc5c42ce4d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2415,11 +2415,9 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void kvm_irqchip_create(KVMState *s)
+static void do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
-
-    assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
         ;
     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
@@ -2452,7 +2450,13 @@ static void kvm_irqchip_create(KVMState *s)
         fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
         exit(1);
     }
+}
+
+static void kvm_irqchip_create(KVMState *s)
+{
+    assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
+    do_kvm_irqchip_create(s);
     kvm_kernel_irqchip = true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)
@@ -2607,6 +2611,83 @@ static int kvm_setup_dirty_ring(KVMState *s)
     return 0;
 }
 
+static int kvm_reset_vmfd(MachineState *ms)
+{
+    KVMState *s;
+    KVMMemoryListener *kml;
+    int ret = 0, type;
+    Error *err = NULL;
+
+    /*
+     * bail if the current architecture does not support VM file
+     * descriptor change.
+     */
+    if (!kvm_arch_supports_vmfd_change()) {
+        error_report("This target architecture does not support KVM VM "
+                     "file descriptor change.");
+        return -EOPNOTSUPP;
+    }
+
+    s = KVM_STATE(ms->accelerator);
+    kml = &s->memory_listener;
+
+    memory_listener_unregister(&kml->listener);
+    memory_listener_unregister(&kvm_io_listener);
+
+    if (s->vmfd >= 0) {
+        close(s->vmfd);
+    }
+
+    type = find_kvm_machine_type(ms);
+    if (type < 0) {
+        return -EINVAL;
+    }
+
+    ret = do_kvm_create_vm(s, type);
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->vmfd = ret;
+
+    kvm_setup_dirty_ring(s);
+
+    /* rebind memory to new vm fd */
+    ret = ram_block_rebind(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
+    ret = kvm_arch_on_vmfd_change(ms, s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (s->kernel_irqchip_allowed) {
+        do_kvm_irqchip_create(s);
+    }
+
+    /* these can be only called after ram_block_rebind() */
+    memory_listener_register(&kml->listener, &address_space_memory);
+    memory_listener_register(&kvm_io_listener, &address_space_io);
+
+    /*
+     * kvm fd has changed. Commit the irq routes to KVM once more.
+     */
+    kvm_irqchip_commit_routes(s);
+    /*
+     * for confidential guest, this is the last possible place where we
+     * can call synchronize_all_post_init() to sync all vcpu states to
+     * kvm.
+     */
+    if (ms->cgs) {
+        cpu_synchronize_all_post_init();
+    }
+    trace_kvm_reset_vmfd();
+    return ret;
+}
+
 static int kvm_init(AccelState *as, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -4015,6 +4096,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "KVM";
     ac->init_machine = kvm_init;
+    ac->rebuild_guest = kvm_reset_vmfd;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e43d18a869..e4beda0148 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -14,6 +14,7 @@ kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
 kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
 kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu %s"
 kvm_irqchip_commit_routes(void) ""
+kvm_reset_vmfd(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8f9eecf044..5fc7251fd9 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -456,6 +456,9 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
 
 #endif /* COMPILING_PER_TARGET */
 
+bool kvm_arch_supports_vmfd_change(void);
+int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
+
 void kvm_cpu_synchronize_state(CPUState *cpu);
 
 void kvm_init_cpu_signals(CPUState *cpu);
diff --git a/stubs/kvm.c b/stubs/kvm.c
new file mode 100644
index 0000000000..2db61d89a7
--- /dev/null
+++ b/stubs/kvm.c
@@ -0,0 +1,22 @@
+/*
+ * kvm target arch specific stubs
+ *
+ * Copyright (c) 2026 Red Hat, Inc.
+ *
+ * Author:
+ *   Ani Sinha <anisinha@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "system/kvm.h"
+
+int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 8a07059500..6ae478bacc 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -74,6 +74,7 @@ if have_system
   if igvm.found()
     stub_ss.add(files('igvm.c'))
   endif
+  stub_ss.add(files('kvm.c'))
   stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6d823a7991..a4e18734b1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3389,6 +3389,16 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
+{
+    abort();
+}
+
+bool kvm_arch_supports_vmfd_change(void)
+{
+    return false;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
-- 
2.42.0


