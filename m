Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9F5C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvh-0008Bz-Ap; Mon, 02 Mar 2026 03:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyup-0005Nf-I0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyug-0001vw-JC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bt+nbRcBAMd2MNgkvRjGu4iiwsMcXjA5Z4aoYzLKs8I=;
 b=LwdunB89hARXVO9wB790fpk3whgBuCGBDGLZ5zpfr+cookdsFOW/6acw2QLiI+iwap9UZt
 iKhcjB3nVkjxtbmP98/bEyXO83WBNwzs9c3U6K3YoE4ATkLflLTrlczqzW5RVPQ46VVSgx
 UlGPI7vXmtH8hfm42x6E1crF4LAIwSg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-34-Wx1IPMoOt0Da8TLAl7Q-1; Mon, 02 Mar 2026 03:45:46 -0500
X-MC-Unique: 34-Wx1IPMoOt0Da8TLAl7Q-1
X-Mimecast-MFC-AGG-ID: 34-Wx1IPMoOt0Da8TLAl7Q_1772441145
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so46277105e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441144; x=1773045944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt+nbRcBAMd2MNgkvRjGu4iiwsMcXjA5Z4aoYzLKs8I=;
 b=Q1CQR46R4gLM8a5CSuFhpQqcbvk02v9GDiFFMZa1L4dDR5DYIpVZ0tZfXqlbTN8iQI
 FBT68y4nASpR0uv3f7/iR1OVuPMAXtQZqftPCLCur+xorBkVxFVvaqKCsH0MCn9THyOt
 8LzOrRSibAISjXTKnep5Z4dFkhYcC8C3SKYCrq6p0K+uPdCbvQZcgewSAE0OunH6JEBJ
 nf8QJ/Hcox6aOvaJareFkXMm2uEXXmIWqmM1zwaB0bANgTwp5yxiyHoMS+FbdXuEmFZ7
 unorggX+hWPXBl69ae2GTVENU2LZMFCQzi6OdqTn9rrWPEyrrNlDaOrFSjtaF+rvM0uI
 3bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441144; x=1773045944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt+nbRcBAMd2MNgkvRjGu4iiwsMcXjA5Z4aoYzLKs8I=;
 b=BeDBMGuIdWDTg7cNayiBNtqZCELGAEN41O8OJP1UXDZcudy81MQMrOOhET5Fdr8FhO
 53qeECIabidsgpXIBfnq4jMmv31JLFZO2YFlO1oCpke2g68FHa7882CyA8V6V9jyaoPt
 MCIed03iOuS8eVcpQ4MQfqX+QX5x8PKGozSh7FOwRBepkxeMS+/kXHQlaMHjQV8Uw2S7
 ozja21BTn0qzC8tfDIQ9ymC7UkSuzjiV1zIsa4i+EY9/43zOJ3cAtspMpBxQqg/Bbrbl
 Cct5vX+15r8iW0Re0PYC58IwaDM6D59tXl3bW+Kz5erxysTAEIWX/MwttRdmW9sxwZpg
 M7WQ==
X-Gm-Message-State: AOJu0YzsajQC3vUSHvGjVaQCvcUcnVWnf1+pa0MTiVwWtVrFYQra34Lt
 NB4Jg8Bx1zolNtkJWzKziTqK8bu61NszDScHezdqhqFdNV3dagaePwW9+f7D4fGzjBRA36VFqnf
 B/NYfqt6bCisnveZRmknoTFwe53gwgrS4Tu0AWQ5a/RkrK/ydDOQzx+A8QM+6VfI3cnu4qH6EGJ
 Sy26u7iqhJ+CzWStpOkdSrrFEGblijYnTwFw2GZCla
X-Gm-Gg: ATEYQzwPaU/0pJcPvIfdKplxEl1jv0tNuW52bHQPMUTEeGf2yTbVQJDqPnubm2E+35l
 OfvZxPWPZZi5P+lbbgig8NHWWf0TqwwisExLWZta7tSBFDuBpUsJd8+mMwDl8HWNUulbLtYfRA8
 ttcTHSxmvxDsDq8EvTWFU+yzVAJy4gTKnE0Usnehr2U2bYeCgVil2PuZYrGggRMLZHOzSzMfUi1
 yOuyPugn1YNXzA4NEO0wFfmgyZ/C4Y5bIPPIBqvKezmCOIWYr4w/+FndFHJ7gnyDszHIR+rCAQt
 bD2C5AxVxe0v12NTBMVgklYsPwZe0fY1+xRn5p5isecvmnrCvUf9uVJ0Grh++PbyZLyZ1Pi4Oh1
 pqHEYvP/WKU638EszrBtTEBwFYnlb+8n4DdOW9YZvWfmMPATbTQqpOFX5RotTFHplY9kB61hRKb
 F7Oau/nuE/8dHHzPiCQPyxlTm9/qg=
X-Received: by 2002:a05:600c:3108:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-483c9c1d177mr199954985e9.29.1772441144161; 
 Mon, 02 Mar 2026 00:45:44 -0800 (PST)
X-Received: by 2002:a05:600c:3108:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-483c9c1d177mr199954465e9.29.1772441143587; 
 Mon, 02 Mar 2026 00:45:43 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf673sm155205805e9.19.2026.03.02.00.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 046/102] accel/kvm: add changes required to support KVM VM file
 descriptor change
Date: Mon,  2 Mar 2026 09:42:41 +0100
Message-ID: <20260302084338.473368-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

This change adds common kvm specific support to handle KVM VM file descriptor
change. KVM VM file descriptor can change as a part of confidential guest reset
mechanism. A new function api kvm_arch_on_vmfd_change() per
architecture platform is added in order to implement architecture specific
changes required to support it. A subsequent patch will add x86 specific
implementation for kvm_arch_on_vmfd_change() as currently only x86 supports
confidential guest reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-6-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS            |  6 +++
 include/system/kvm.h   |  3 ++
 accel/kvm/kvm-all.c    | 88 ++++++++++++++++++++++++++++++++++++++++--
 stubs/kvm.c            | 22 +++++++++++
 target/i386/kvm/kvm.c  | 10 +++++
 accel/kvm/trace-events |  1 +
 stubs/meson.build      |  1 +
 7 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 stubs/kvm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 72153288c53..a8e1546de1e 100644
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
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8f9eecf044c..5fc7251fd94 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -456,6 +456,9 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
 
 #endif /* COMPILING_PER_TARGET */
 
+bool kvm_arch_supports_vmfd_change(void);
+int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
+
 void kvm_cpu_synchronize_state(CPUState *cpu);
 
 void kvm_init_cpu_signals(CPUState *cpu);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0d8b0c43470..cc5c42ce4de 100644
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
diff --git a/stubs/kvm.c b/stubs/kvm.c
new file mode 100644
index 00000000000..2db61d89a73
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
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index c0be2e932da..524b5276a68 100644
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
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e43d18a8692..e4beda01488 100644
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
diff --git a/stubs/meson.build b/stubs/meson.build
index 8a07059500d..6ae478bacc1 100644
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
-- 
2.53.0


