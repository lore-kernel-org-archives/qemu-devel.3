Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E63D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvJ-0006WE-FT; Mon, 02 Mar 2026 03:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyut-0005TX-PG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyur-0001zd-Ge
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqrLIwIWG7O7AT3AslNieYmXs84EPYo0zTvBpgEa0sY=;
 b=igDDPWX/5txuT6zPevhd/uc/RrD51aRbiRKq4oX0JQyumanUEsjk0d0nPi1FV1DVRjW6Y+
 mv0ORr1IBX1naNj+vsYye7aT0bVsTT4KrmHk2fptRiCnTsp4j10Fh40aEUSXdiR5NzwAyX
 QmNMXNbWTsI0mlYlOmsKhn32U13Go1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-S25YKvJcM0WnffjXI6xthw-1; Mon, 02 Mar 2026 03:46:11 -0500
X-MC-Unique: S25YKvJcM0WnffjXI6xthw-1
X-Mimecast-MFC-AGG-ID: S25YKvJcM0WnffjXI6xthw_1772441171
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836b7fbf4fso28198465e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441170; x=1773045970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqrLIwIWG7O7AT3AslNieYmXs84EPYo0zTvBpgEa0sY=;
 b=VQeS+ZE8EPcbbGEDIDD+j2BiZJvh5r4etXPg5JvwdpU1vkJ62uefRSaXFVi8jhAGK4
 2SLt8YiY4DFYBcq49qCD+dGw3LQuvaPHGswcBVSsFi3dLh2szie1Rt7DZb1/3PMKOFZK
 2mvQOBkFmDCC97PajAL6kMjqNZhaSKuEZeP9UsdSPvRrPE050FVZRjErxczPOGm49M9g
 2XVytM7bJs1kKBoZYU6Ek1Ie136MwgZS6xmLMD2k59SPylhXBKMaODVUppoWJTFsgp0i
 M7qHrhMz3dN5e7pZ0icGZeGyysr94BPKqAl4g8D/CGXAfCAx9DmNgWY1JTL/WuS1lq8l
 SR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441170; x=1773045970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yqrLIwIWG7O7AT3AslNieYmXs84EPYo0zTvBpgEa0sY=;
 b=pB95/spNWevYqCHxfSoaBip5NWw6XQR8umXPhriG0KeVjCJFF/f7rx1wg7X94DRwRH
 H7jywW465lR4jyjPrhRSfFsvfmkDhHcR4Pgsl26G4oK0qSuHPZs7etM0xt10DrpPJdOz
 /WCmz/K77X3j9UDHntwMrPkB8akpyE24bpnsAZz5KoQVgPP/z+2Y8DzyxXgAKCoFBbmj
 Zf62v6B/HFqWRmi+3g+m3uwJzaGnk8rbgiLnCEZjeJhNLMw0QxC+9hLyOzS7Fka+oIGy
 qwwyl/c950T1GSG2lEbO79HSe7ovjBT+NAtBg1gsjv7Y6dPtsN+6KLbg7lT0dgEmnwe4
 3g5g==
X-Gm-Message-State: AOJu0YwXFNFt8mKEwssb51+Rsa7jmPRkZ8uDOsaXJcaE/B49TNRiWE1O
 b330MCsVu8zo3ipIDVMffrXRebHu4J0LT52lC2nytiNez9AHE+8pOU3ISDcrNxm+SjISMeM5xR1
 ARWD8d9tvXc5B91WPmOFJBr7vS40CbZCNwKJLDGaTh43CXBG24cJaNVMVkpx4Cm3M+RcJB7JIdJ
 vkuzx3/Dufn3lsUIYEnjepZ1sT70rfL+kbLY/5g8Mh
X-Gm-Gg: ATEYQzxRGsTP08i6twJfwiHXxnA9aMclZoYiCN1GxdXRi/1nu5sr/BD4SEqplUcy/fb
 nsnrG91eAdfU2/clGsoc1iC+4tHQGsKu+VCw+vxTk+njqESHOaCXKIpWJP8sMR4CNjPFMSin/xR
 mNVkK042akoxMQh/AlYDNBmqXh5/cYZFphVBukbBPLKjMHUZF9qWk4w1OAGm7pxDcHyoZPPMbY9
 Ht1zJNtbqTWZSXkVeQiuwi1SlkkBMq3jVe4IJj1+Z11bPwZZtT9Ml+JnOFMmYHVGEvxvkZMFsR3
 7EmwyixJMgwRB5zDlfJKtS/LN3OHID77dGoI/JAgf17krDWl2q7RHx7kk/MIA/eLzFP2DmQ9Y8B
 tUwBYAjP4yoiM4AB6UCHqBJvjSoQacM5eQnD0JAqQT9t1AaQZWeKDeDtTK+Jj2hpu+4SuN5vgk0
 7RsJ+tmdoieNvkly5xfSvK04vljug=
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211490655e9.2.1772441169654; 
 Mon, 02 Mar 2026 00:46:09 -0800 (PST)
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211490155e9.2.1772441169088; 
 Mon, 02 Mar 2026 00:46:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb77444sm122075565e9.4.2026.03.02.00.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 056/102] accel/kvm: rebind current VCPUs to the new KVM VM file
 descriptor upon reset
Date: Mon,  2 Mar 2026 09:42:51 +0100
Message-ID: <20260302084338.473368-57-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

Confidential guests needs to generate a new KVM file descriptor upon virtual
machine reset. Existing VCPUs needs to be reattached to this new
KVM VM file descriptor. As a part of this, new VCPU file descriptors against
this new KVM VM file descriptor needs to be created and re-initialized.
Resources allocated against the old VCPU fds needs to be released. This change
makes this happen.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-16-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 215 +++++++++++++++++++++++++++++++++--------
 accel/kvm/trace-events |   1 +
 2 files changed, 174 insertions(+), 42 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d244156f6f4..a347a71a2ee 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,10 @@ static NotifierList kvm_irqchip_change_notifiers =
 static NotifierWithReturnList register_vmfd_changed_notifiers =
     NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_changed_notifiers);
 
+static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
+static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
+static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
+
 struct KVMResampleFd {
     int gsi;
     EventNotifier *resample_event;
@@ -420,6 +424,90 @@ err:
     return ret;
 }
 
+static void kvm_create_vcpu_internal(CPUState *cpu, KVMState *s, int kvm_fd)
+{
+    cpu->kvm_fd = kvm_fd;
+    cpu->kvm_state = s;
+    if (!s->guest_state_protected) {
+        cpu->vcpu_dirty = true;
+    }
+    cpu->dirty_pages = 0;
+    cpu->throttle_us_per_full = 0;
+
+    return;
+}
+
+static int kvm_rebind_vcpus(Error **errp)
+{
+    CPUState *cpu;
+    unsigned long vcpu_id;
+    KVMState *s = kvm_state;
+    int kvm_fd, ret = 0;
+
+    CPU_FOREACH(cpu) {
+        vcpu_id = kvm_arch_vcpu_id(cpu);
+
+        if (cpu->kvm_fd) {
+            close(cpu->kvm_fd);
+        }
+
+        ret = kvm_arch_destroy_vcpu(cpu);
+        if (ret < 0) {
+            goto err;
+        }
+
+        if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
+            s->coalesced_mmio_ring = NULL;
+        }
+
+        ret = vcpu_unmap_regions(s, cpu);
+        if (ret < 0) {
+            goto err;
+        }
+
+        ret = kvm_arch_pre_create_vcpu(cpu, errp);
+        if (ret < 0) {
+            goto err;
+        }
+
+        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
+        if (kvm_fd < 0) {
+            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu (%s)",
+                         vcpu_id, strerror(kvm_fd));
+            return kvm_fd;
+        }
+
+        kvm_create_vcpu_internal(cpu, s, kvm_fd);
+
+        ret = map_kvm_run(s, cpu, errp);
+        if (ret < 0) {
+            goto err;
+        }
+
+        if (s->kvm_dirty_ring_size) {
+            ret = map_kvm_dirty_gfns(s, cpu, errp);
+            if (ret < 0) {
+                goto err;
+            }
+        }
+
+        ret = kvm_arch_init_vcpu(cpu);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
+                             vcpu_id);
+        }
+
+        close(cpu->kvm_vcpu_stats_fd);
+        cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
+        kvm_init_cpu_signals(cpu);
+    }
+    trace_kvm_rebind_vcpus();
+
+ err:
+    return ret;
+}
+
 static void kvm_park_vcpu(CPUState *cpu)
 {
     struct KVMParkedVcpu *vcpu;
@@ -483,13 +571,7 @@ static int kvm_create_vcpu(CPUState *cpu)
         }
     }
 
-    cpu->kvm_fd = kvm_fd;
-    cpu->kvm_state = s;
-    if (!s->guest_state_protected) {
-        cpu->vcpu_dirty = true;
-    }
-    cpu->dirty_pages = 0;
-    cpu->throttle_us_per_full = 0;
+    kvm_create_vcpu_internal(cpu, s, kvm_fd);
 
     trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
 
@@ -508,19 +590,11 @@ int kvm_create_and_park_vcpu(CPUState *cpu)
     return ret;
 }
 
-static int do_kvm_destroy_vcpu(CPUState *cpu)
+static int vcpu_unmap_regions(KVMState *s, CPUState *cpu)
 {
-    KVMState *s = kvm_state;
     int mmap_size;
     int ret = 0;
 
-    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
-
-    ret = kvm_arch_destroy_vcpu(cpu);
-    if (ret < 0) {
-        goto err;
-    }
-
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
@@ -548,6 +622,31 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         cpu->kvm_dirty_gfns = NULL;
     }
 
+ err:
+    return ret;
+}
+
+static int do_kvm_destroy_vcpu(CPUState *cpu)
+{
+    KVMState *s = kvm_state;
+    int ret = 0;
+
+    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
+
+    ret = kvm_arch_destroy_vcpu(cpu);
+    if (ret < 0) {
+        goto err;
+    }
+
+    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
+    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
+        s->coalesced_mmio_ring = NULL;
+    }
+
+    ret = vcpu_unmap_regions(s, cpu);
+    if (ret < 0) {
+        goto err;
+    }
     kvm_park_vcpu(cpu);
 err:
     return ret;
@@ -561,26 +660,9 @@ void kvm_destroy_vcpu(CPUState *cpu)
     }
 }
 
-int kvm_init_vcpu(CPUState *cpu, Error **errp)
+static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp)
 {
-    KVMState *s = kvm_state;
-    int mmap_size;
-    int ret;
-
-    trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
-
-    ret = kvm_arch_pre_create_vcpu(cpu, errp);
-    if (ret < 0) {
-        goto err;
-    }
-
-    ret = kvm_create_vcpu(cpu);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
-                         kvm_arch_vcpu_id(cpu));
-        goto err;
-    }
+    int mmap_size, ret = 0;
 
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
@@ -605,14 +687,53 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
             (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
     }
 
+ err:
+    return ret;
+}
+
+static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp)
+{
+    int ret = 0;
+    /* Use MAP_SHARED to share pages with the kernel */
+    cpu->kvm_dirty_gfns = mmap(NULL, s->kvm_dirty_ring_bytes,
+                               PROT_READ | PROT_WRITE, MAP_SHARED,
+                               cpu->kvm_fd,
+                               PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET);
+    if (cpu->kvm_dirty_gfns == MAP_FAILED) {
+        ret = -errno;
+    }
+
+    return ret;
+}
+
+int kvm_init_vcpu(CPUState *cpu, Error **errp)
+{
+    KVMState *s = kvm_state;
+    int ret;
+
+    trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
+
+    ret = kvm_arch_pre_create_vcpu(cpu, errp);
+    if (ret < 0) {
+        goto err;
+    }
+
+    ret = kvm_create_vcpu(cpu);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
+                         kvm_arch_vcpu_id(cpu));
+        goto err;
+    }
+
+    ret = map_kvm_run(s, cpu, errp);
+    if (ret < 0) {
+        goto err;
+    }
+
     if (s->kvm_dirty_ring_size) {
-        /* Use MAP_SHARED to share pages with the kernel */
-        cpu->kvm_dirty_gfns = mmap(NULL, s->kvm_dirty_ring_bytes,
-                                   PROT_READ | PROT_WRITE, MAP_SHARED,
-                                   cpu->kvm_fd,
-                                   PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET);
-        if (cpu->kvm_dirty_gfns == MAP_FAILED) {
-            ret = -errno;
+        ret = map_kvm_dirty_gfns(s, cpu, errp);
+        if (ret < 0) {
             goto err;
         }
     }
@@ -2710,6 +2831,16 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
     assert(!err);
 
+    /*
+     * rebind new vcpu fds with the new kvm fds
+     * These can only be called after kvm_arch_on_vmfd_change()
+     */
+    ret = kvm_rebind_vcpus(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
     /* these can be only called after ram_block_rebind() */
     memory_listener_register(&kml->listener, &address_space_memory);
     memory_listener_register(&kvm_io_listener, &address_space_io);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e4beda01488..4a8921c632b 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -15,6 +15,7 @@ kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
 kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu %s"
 kvm_irqchip_commit_routes(void) ""
 kvm_reset_vmfd(void) ""
+kvm_rebind_vcpus(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
-- 
2.53.0


