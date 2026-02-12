Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02186EDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9e-0007ni-Eb; Thu, 12 Feb 2026 01:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9d-0007ms-Kt
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9b-0005Fx-QP
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npi3eP36456mUDuK+ax2iLB1NMn8InaMo9diT4vHZh4=;
 b=el2udbjHwBtLw+s7RRymsfKtnzJZm7W2n5J6btcXliF0FFTOszj/yVkFamNtDjzr8PHb+S
 5/Q8uNxX7GkruSEUHe05jsOEwjxwfv9N+7cRObeZih+PTKwLJzyZMFFWYAtuBGKrA4FLcI
 VsMhbMgi1BWSNa6TIQCoim7bPP6GLXg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-gN9iWca4MP6kkyL5HZW6hA-1; Thu, 12 Feb 2026 01:26:17 -0500
X-MC-Unique: gN9iWca4MP6kkyL5HZW6hA-1
X-Mimecast-MFC-AGG-ID: gN9iWca4MP6kkyL5HZW6hA_1770877576
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c7febaefso5791843a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877576; x=1771482376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npi3eP36456mUDuK+ax2iLB1NMn8InaMo9diT4vHZh4=;
 b=NBTILwzf+ouWxbtQZtIcoT80Pw54q7cu76pBqOa73zrOCfrmIy7Mp2qKyHROo3LB40
 c0WHdSpmeVlhOWbp+FC8Grr8VFpTWbnvNq+VTbBwNypQwG7wHOivq6ESUbgQ+GATzMBM
 wccihGTfXjo7U0sRWH/C9p+ZIKBDzaYQbit2+JKH3lvwxt4xoiX5dWyx8wXBdDd+Ax5H
 Djeb3cu6l5UqwkQXDMYwoxSVQNHbXV5AzjtZ7U0+a3e12OxG71UA/XQGF17tzf393SPz
 vJjmdD5aeR9flBfhOxZRSP4+XOYY+VlUHjX+OUPuR2ronTQnr+eYyk2tFC/aybTgy1KN
 Pc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877576; x=1771482376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=npi3eP36456mUDuK+ax2iLB1NMn8InaMo9diT4vHZh4=;
 b=c5pkDf98FMmZwluxdiEpem0eHGpOB6CKapk551YIVVKGoQTVB95NV66AgElmXHIq9F
 JOvk0Q3la2K4j5iFdiKT8zycUlTefutdOXlFPeHchBkfzpuPxQK+ca20689TB5LoY/tu
 jMN7vqvkcsCA1EKktGlKjN3HSGaxdbYzLHGYmwaTnNAJaI4e4xxElIDwlqIA0bQ+cDAG
 NSSJxA7wjMvYr4JhjvSBQaIm7vyFuBk653Clkc5K1pXBo2iR4fU8ljTK613wKMt7kHfE
 pxtvhl9njF7NLJfsUU21x8DGox/N0RfolIXE9d4/2VOyFsc4fSojs8CqJ5e0eCSQFhAC
 ok6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHQPd+tiDKpfrc2GC7k4x53Ks4FLg0tD6bBt4Z0i36O+Hc8syf8pVGNG5UjXrslEDMgBH+PRN/M6BU@nongnu.org
X-Gm-Message-State: AOJu0Yz84FbipzOaMICe2ZT32xZD0Kd6ALja4wuUP2pjhpuiQlWCp+JK
 lcfekhqHAj8x7rm86rZcc5nAf1xAscNhG2p36uSPRAfirHS1TDIdefHAYbXeHyDS0Lh6+o2dpDY
 p54ZR7//LWZ9sTbpsPJo8QxVU+YLOI65ZgO1aX6j+7Q/X9xIfyvr06n95
X-Gm-Gg: AZuq6aIjxwWMXQ2MJG1DruWWIjbQecMR/HY3XPNHHFZdaVqr/jfw67iQQnwOLF3ceam
 KmirIgVAeaSJT4o1OeeiBMIp2ui28GTPbCaFTBIFNKvkF7KG2EnG6DEU3Ihme8U1TaoLB9+SV+j
 qU1nJW7G3jcLaKIUkle+75EtHtoN0VqKvka5pXZWhicjDB+AMOsLrggUhvCo5XzYvNfmAS3HRlN
 7cI1XzR3joioMDzsqX223IqobpDBFWHysbiMecG6NNXRnphGjusVoBOxhzvqyxcgyTu26WP01Np
 frdo10+PcfWw3yd3dmrbIBSRRJiQUcvlJsGX2PUf6+iPIg8Hvv0RmEleDCFyY5EOP7f8kvB1vNm
 RSs1WvFvIX6s/Z5RCe1Kcl4hivduo9vuifGonJO6b7aNOFNHGeTUTNNI=
X-Received: by 2002:a17:90b:5403:b0:340:c179:3657 with SMTP id
 98e67ed59e1d1-35693dd1630mr1151669a91.33.1770877576486; 
 Wed, 11 Feb 2026 22:26:16 -0800 (PST)
X-Received: by 2002:a17:90b:5403:b0:340:c179:3657 with SMTP id
 98e67ed59e1d1-35693dd1630mr1151648a91.33.1770877576087; 
 Wed, 11 Feb 2026 22:26:16 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 13/31] accel/kvm: rebind current VCPUs to the new KVM VM
 file descriptor upon reset
Date: Thu, 12 Feb 2026 11:54:57 +0530
Message-ID: <20260212062522.99565-14-anisinha@redhat.com>
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

Confidential guests needs to generate a new KVM file descriptor upon virtual
machine reset. Existing VCPUs needs to be reattached to this new
KVM VM file descriptor. As a part of this, new VCPU file descriptors against
this new KVM VM file descriptor needs to be created and re-initialized.
Resources allocated against the old VCPU fds needs to be released. This change
makes this happen.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c    | 215 +++++++++++++++++++++++++++++++++--------
 accel/kvm/trace-events |   1 +
 2 files changed, 174 insertions(+), 42 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a6ff16a037..5e81bf8ad2 100644
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
@@ -548,39 +622,47 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         cpu->kvm_dirty_gfns = NULL;
     }
 
-    kvm_park_vcpu(cpu);
-err:
+ err:
     return ret;
 }
 
-void kvm_destroy_vcpu(CPUState *cpu)
-{
-    if (do_kvm_destroy_vcpu(cpu) < 0) {
-        error_report("kvm_destroy_vcpu failed");
-        exit(EXIT_FAILURE);
-    }
-}
-
-int kvm_init_vcpu(CPUState *cpu, Error **errp)
+static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
-    int mmap_size;
-    int ret;
+    int ret = 0;
 
-    trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
+    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
-    ret = kvm_arch_pre_create_vcpu(cpu, errp);
+    ret = kvm_arch_destroy_vcpu(cpu);
     if (ret < 0) {
         goto err;
     }
 
-    ret = kvm_create_vcpu(cpu);
+    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
+    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
+        s->coalesced_mmio_ring = NULL;
+    }
+
+    ret = vcpu_unmap_regions(s, cpu);
     if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
-                         kvm_arch_vcpu_id(cpu));
         goto err;
     }
+    kvm_park_vcpu(cpu);
+err:
+    return ret;
+}
+
+void kvm_destroy_vcpu(CPUState *cpu)
+{
+    if (do_kvm_destroy_vcpu(cpu) < 0) {
+        error_report("kvm_destroy_vcpu failed");
+        exit(EXIT_FAILURE);
+    }
+}
+
+static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp)
+{
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
@@ -2707,6 +2828,16 @@ static int kvm_reset_vmfd(MachineState *ms)
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
index e4beda0148..4a8921c632 100644
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
2.42.0


