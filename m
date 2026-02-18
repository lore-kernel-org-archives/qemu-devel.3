Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE66E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxu-0003KG-P0; Wed, 18 Feb 2026 06:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxb-000396-N8
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxU-0007oQ-O4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfhdy46mQEUlcerqq6xzArv8NlC5Gx5+51xsaBuia6g=;
 b=Cnnm872SjsAj2hQt+Y6DX3UU9I5432aGIuUVygOXFkR+Zlbm1aitZAxnzjBiyEZOMHSxyd
 t808AFo2C8vWrF7N3tFs0+PUb6H3xqlFnmKXwDaq9bAfsVWdCoEN/brbxNIKKCIwTxPAFX
 EUgqy7ueFkiFAYFDgP0N0DX3ZwLxbok=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-fkYppRocNDKHUs0nEAn8iA-1; Wed, 18 Feb 2026 06:43:03 -0500
X-MC-Unique: fkYppRocNDKHUs0nEAn8iA-1
X-Mimecast-MFC-AGG-ID: fkYppRocNDKHUs0nEAn8iA_1771414982
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aae146bab0so63746785ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414982; x=1772019782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfhdy46mQEUlcerqq6xzArv8NlC5Gx5+51xsaBuia6g=;
 b=O/CK4/ZBETncYiP66mXMjSLcpUQYULPT5Kil8ArwWVNDCHVokyV1ABK8CyIuRt2YEm
 mJDUXIslKhqblpQ8WWAJzosBhMDc7s0s5ITuDDyof+1LHoSHeVvtWWPp3dartRsIV+3d
 J0uaOKVfC6rmzTvW9PHpNscp+HfUu0cGbUI20kK8iD77tR+Wq/pyYcjgF59ps5B0d3DN
 jC3/iX2jO7xRERnS0vmLhPy+BBG8Ov1VN8MWDbykbJXGuf8lM+2MOCFbY5lOzqGtMcuW
 EItjr7kISfQZRTs2K47sFLN6skUoKCZ/pUpQbreYPwLvToo92KlBz77hhihZ9Br6NRs6
 RWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414982; x=1772019782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vfhdy46mQEUlcerqq6xzArv8NlC5Gx5+51xsaBuia6g=;
 b=a+JWxVsq7iuYTG9zOx9AmD503qkFghjAMQZXp/60HSpRtzvhbJL1cwcKgMFFVNa4Uq
 VT+0q2ExdeMDaCzAq8GXqa097dzUvy3Tgak7o61oThavUjs83gPl+ndQq4R4wc+H9IXS
 mfEt+3mW8Kv/ZGcqas8Jy46SyWZlLrGF3sdbP3XPXreGvNMTpSZFNAu3jXXlQpsKd5VL
 NBBx9SMuyb8y27l5JUKH2EAVryvwRRu+eyNMLpBj0XQWH/ip/CBnAJe7G0/NmnzyIeQ2
 jj2JycnUvX7nLGN8k3Jv6yy+Wdybie8WdmhqUL3FRmtZT2bxOJmcVnITj35ehBgnzdeh
 i5jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjUlvEYN6p8bf+4rlERQ/RlIvVkFqrY7cua1WABR3ZpnrdAgvW8ihwFajMeSxnp/BEEHtlmvPS9Fi1@nongnu.org
X-Gm-Message-State: AOJu0Yx4dMs3NckEgbn9AKOO7BZqbBDKnOBrpf3tEnpaZE5KstnmUBMl
 jIG4K9ubzMZrqkGFEmUVheRvzIk6xJXZ08PSWrwztaa5aNm8HSG/RpQWbCathMrHGawqDKq7k1U
 NLLX9RmYMYcPxORWKJEV1h8WYZU2KCq5qi+WziPbALkF17VXEdKus5rbcRdVbibJd
X-Gm-Gg: AZuq6aLMBVxEO1bY0WdNUgsauS+szXnXmYH94VLV1MBrWkBbEcrLwY7URo2C8GJFbw4
 VSqajwS7FhRu1N6gbbhwStqa2D9kUU+TTCMbgkxg7iSbponyLrKs3MqNudRENsuWGVnoNjHFKL9
 VuLf8lb8VR+LX/tjXdycfep2Jg/UaOqAhWPcixgvC0anFIiNUfTmrHntNuSGk9sNUHF4Zg7NU3b
 sDBK+LQHyX0BDGjCHaoL33/stQwlUIHaadKZ0ZN6Qs2qE2+dRKTWF9YLPcPxA3jxC4PL9q2IsUl
 qOsERFyAFwkYVr4YvE85GRwtbY2qJvXkxhDXCezmzzGzcT7ESIQG0vOuS9pFuWZgOfQg9yrjU8s
 sdnxQNaJHl8q9io+iRtdkFsjO2+nfdG5q+x5GbKz/fb15nXuqSHFo
X-Received: by 2002:a17:902:d509:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2ab505c056emr182651445ad.35.1771414981952; 
 Wed, 18 Feb 2026 03:43:01 -0800 (PST)
X-Received: by 2002:a17:902:d509:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2ab505c056emr182651275ad.35.1771414981518; 
 Wed, 18 Feb 2026 03:43:01 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:01 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v5 05/34] accel/kvm: add changes required to support KVM VM
 file descriptor change
Date: Wed, 18 Feb 2026 17:11:58 +0530
Message-ID: <20260218114233.266178-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d3aa6d6732..b0eb77c08f 100644
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
index 0d8b0c4347..14729666a0 100644
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
@@ -4015,6 +4088,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
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


