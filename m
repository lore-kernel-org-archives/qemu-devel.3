Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF657EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9V-0007gg-TQ; Thu, 12 Feb 2026 01:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9J-0007aY-8S
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9F-0005DD-7S
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/oOoBR4IfX+ZbFVC/5tNcGKvnGUc2oW6vwtrqPYGD4=;
 b=aSQOsx9wt6cOIK541dAeJRAgFKGV/aF6/n78eWoMINO/a0BvomdPROPQqrRJGhd0u7zGEO
 CewAQIMuzx2AE4/TCSMtILHL2HABD/pgZbCRfqzL6cP70JIZRutA4QGoSNcGqFKCACWEND
 80hacBMzkutP+eygyW+sfqz0PeQuJRQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-twGXeIc2Mo-Hl4Geysdz2g-1; Thu, 12 Feb 2026 01:25:52 -0500
X-MC-Unique: twGXeIc2Mo-Hl4Geysdz2g-1
X-Mimecast-MFC-AGG-ID: twGXeIc2Mo-Hl4Geysdz2g_1770877551
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a7a98ba326so20676635ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877551; x=1771482351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/oOoBR4IfX+ZbFVC/5tNcGKvnGUc2oW6vwtrqPYGD4=;
 b=rIYTjIULCeV1HHa2LaFbdoLj6mOBujt1jYi+VoilwmuEIjt73CFjMAZy0xLdlqHvvc
 iVq06JZnikwngbl/NgzP66xr9K/1Sqkv1RIfXK3W6k+KDj2rygK4b+J7pPXg1/cuxqWb
 D3x1WHb3Tix6fPn6FxMcaxgyz1gHhLS9RFK9CnUD4O3JZ/yn/lY1dQwlKVSHHfUXpVB7
 oOYSX2YbsnWATDmfSEVXVcIS85WIBfY+SNH28IBX00KVbTrSCN9ahZTJ37dgkrfIrVB0
 u6SP2fJ6gKJDXK/405gGSVXy/qJCgB1BrS4uojyy7f9AJUa8AtaThDxCmQXaSahwu/64
 1Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877551; x=1771482351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J/oOoBR4IfX+ZbFVC/5tNcGKvnGUc2oW6vwtrqPYGD4=;
 b=iTipV1zNmiyV4wKivAirpn0n0zzLG7BvIsaJ3nbd9BxZuxTPPQ4UKvvJeKg4jxCxMa
 +2RxjeuDd5HlvF21uH3b3dk014EaAXqs/7TEQkQpvBwIOVhe8AmLnZ0ONY/bdFfkrhB4
 ttzKmXanK/WLfjkXayYgytQF8Oh1s4gf1EmrTevfuebYTypYYUYRvrdmev22HzccoyiO
 3Da4wmTjZnOYJx7Pc+o+ZtVozJ3S57GAz181wN/lJ5v7ARO2FgSaj06XMk//gnsqJ252
 uXrbibO1WJkfgd57wcYxlYrNuzf58wLLv5Jqy24SQl5fAWyH2ECzRnj5QBi1+f8cRvdU
 X5Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfyXYWyU9eVh3w9DygwTPMMrVq+KXvlvgcwBDIcPKQJ7X4dp2qKRuzQekrGndFQAZQgaJeuuWpBaJu@nongnu.org
X-Gm-Message-State: AOJu0Yw3g6KoddST+ee2sJ+8Ye8LwgcEQIb1gc175FdqRzLUM3ytSWP4
 rCAY2jOlXF2nKcDgaiK0w41x2hatdp85sJyS+6objGdkAi/g6WTLBjYs3KtS5Yt6ndn5LLt8g2e
 jR5WLYb6IcweKc9cna0tbx66EOjQXW0d1DHi6SgKbHEZTkTWHqAokzf60
X-Gm-Gg: AZuq6aLqnWktyCDcntnB/8BPiQi6O2OoEEHCJ7S3n8uV6WUS3NKDzVJb2q01rsGTAdY
 4cH9j3OSLfx/qhMahAyxu3tV+Q3dfeFIPt/SauG1f/O06m/OuRKtOe3R9WHAFZSyVSUPt+rKR5S
 5PRrD8FNpvgD8TggnbHKI8lA89tJOJ+g5C6eAzHlZc4aQBiYw6dJlk3ZLH6PxuGaCpDhuSCE/nW
 /49/oNtkOrE1rak1DrxuVsiR0ze6OkIchkclY6R9XRfXU5VufoLcLh7PCbPa6RgnMD+bD133QJp
 FebU9Nbio4/6QGsCyQensQksJHZzx6S14J7m4Zuf61ilnhoytlD4h0cQWgXrtwo93jYgBbnF0cT
 Coe7eCvfT+Uwiy4RRWbYt1dCrdNahLAWrBYr71zeC2M/Jh23dpttbt7I=
X-Received: by 2002:a17:902:e948:b0:2aa:f5b4:9a2e with SMTP id
 d9443c01a7336-2ab3a667bacmr14492455ad.11.1770877551315; 
 Wed, 11 Feb 2026 22:25:51 -0800 (PST)
X-Received: by 2002:a17:902:e948:b0:2aa:f5b4:9a2e with SMTP id
 d9443c01a7336-2ab3a667bacmr14492235ad.11.1770877550902; 
 Wed, 11 Feb 2026 22:25:50 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:50 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 05/31] accel/kvm: add changes required to support KVM VM
 file descriptor change
Date: Thu, 12 Feb 2026 11:54:49 +0530
Message-ID: <20260212062522.99565-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This change adds common kvm specific support to handle KVM VM file descriptor
change. KVM VM file descriptor can change as a part of confidential guest reset
mechanism. A new function api kvm_arch_on_vmfd_change() per
architecture platform is added in order to implement architecture specific
changes required to support it. A subsequent patch will add x86 specific
implementation for kvm_arch_on_vmfd_change() as currently only x86 supports
confidential guest reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS            |  6 ++++
 accel/kvm/kvm-all.c    | 80 ++++++++++++++++++++++++++++++++++++++++--
 accel/kvm/trace-events |  1 +
 include/system/kvm.h   |  3 ++
 stubs/kvm.c            | 22 ++++++++++++
 stubs/meson.build      |  1 +
 target/i386/kvm/kvm.c  | 10 ++++++
 7 files changed, 120 insertions(+), 3 deletions(-)
 create mode 100644 stubs/kvm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 65ac60b86b..a88901a7d7 100644
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
index 8301a512e7..46243cfcf2 100644
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
 
+static void kvm_irqchip_create(KVMState *s)
+{
+    assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
+
+    do_kvm_irqchip_create(s);
     kvm_kernel_irqchip = true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)
@@ -2607,6 +2611,75 @@ static int kvm_setup_dirty_ring(KVMState *s)
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
+    trace_kvm_reset_vmfd();
+    return ret;
+}
+
 static int kvm_init(AccelState *as, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -4014,6 +4087,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "KVM";
     ac->init_machine = kvm_init;
+    ac->reset_vmfd = kvm_reset_vmfd;
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
index da1ed3b62a..83c15f098e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3252,6 +3252,16 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
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


