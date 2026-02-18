Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0255DE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxz-0003LX-2X; Wed, 18 Feb 2026 06:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxv-0003KJ-F7
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxt-0007st-5L
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XVbEovrezKjrEojVg5R7mES5JyammScR5/FG80a+a8=;
 b=HyrQ7uKlnonMW2ogOjUxSWVld7Lv00ChtEEjAcBP0F9fp0l8xIn/uoNHwEAk3AVr2yi7vW
 U+X6IDYrRRI7JDPbvM5iAH3Juzj20YQJVFy7hylATmeB1nTzTTFDCrrf6YjhZ/mjoAFyGC
 qT3zHzB3SX1/nqqju9P1bt7BG2m1lI8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-kh7nKkT3PdC5EwyWQ_YQaw-1; Wed, 18 Feb 2026 06:43:31 -0500
X-MC-Unique: kh7nKkT3PdC5EwyWQ_YQaw-1
X-Mimecast-MFC-AGG-ID: kh7nKkT3PdC5EwyWQ_YQaw_1771415009
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaf2f3bef6so64011495ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415009; x=1772019809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XVbEovrezKjrEojVg5R7mES5JyammScR5/FG80a+a8=;
 b=sk/3JawQbAzRU3ft4NZ2fr0wsEcDu9DE314EvjYWcfsT1/sZd6+Z64V+grPrw7UQAJ
 GfFJYe9eRX2QUY1jvA1UvmrmIdGIxidvfr9ebrgKe0spaWJxEPNvQeiAiVwjBIOnnqeh
 op/vlOvXMYhECmp6o4kgfGB0LJZt1OMzHac5uX3QcyNekUoCn1pJwE1wrylUKr6sQEnU
 GUjVH8N4qDmBCKz7fiU5OkJfBv/2yxxbQ3D0CsLPGo+EA7t6/aq89Oc0hisNPqTalfjg
 1QzGpZdUHrNen8RoeWON40HrOwKO/JCx6XYsKN9eZyNFLlN89u8OFJg/amh71iJ2gz00
 r6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415009; x=1772019809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2XVbEovrezKjrEojVg5R7mES5JyammScR5/FG80a+a8=;
 b=iRdH6dnK3rJ+X479sVbFtDMek0sMDMm/pjPQDplUdrmrnvWW7pgP3FsBJf6bifoU/r
 WDDNf/gP9dsfUvKpY+6OUbiFvjgAr6TlFJQtVSfxwuL8bkJLUQiJ5npxAyn+L09LzvrE
 PjF+4Ho9c6WkEjiN+2ZQGPgJzFayngkubILhf1y1HiynCMowjGPv9vlwO2wjRlQOlidL
 C+VjCw0e5MKdY/vrOGaYuZABO8h0TgEHfaU7RDHLWaVgXDAlVV1TSkaYfx2lldUc41e5
 LA1Qc5I5/6uHLZguH53wSigahBInqAtG2zqExVZsWYzHi8br+mL0QddUy2wy6GVq1Hw/
 TNnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO98MNXsFXNZAo0ndef9LdD3KNTpFtXOKbfz2NnrBiGeXQrS8ool+BXCoBIK1f/W5Vqg+0tKNNOPNT@nongnu.org
X-Gm-Message-State: AOJu0YxR5SzNiAdzzc2ttW4F8fFZzqRCkfKFKtIZTbzBu75EwvrA9wxF
 4mjXguZplV/joKe2wsSKr6JX77UhxpJM//qNqkuSvmH3HvHp0x+gdnjVPTpb2wNHeDdp63qokh3
 ZCYnNjQQlCMJRQPMY8iVw17B7xJ/taxbRS8h/8Ius2MGeZdoOSnDwrFYx
X-Gm-Gg: AZuq6aLk9uWxV3fl3dCeDs1g2jr7C3ocSQICB7LaX96G528z2JIRFtLyQ88fiS8P+Fb
 0dfNkA80GuM9jKZ2HOvj1YT7KDA97jhR1mLqpvhg44VV0msq8Tjd43fVorObOLDfKyQkCSjEWSW
 MqS3hmL0OIkBmnnNytUDMlpwffEsM/5uWkeaoUEXN9risOAZAvCYChOwusldNDRA6RIduPnUB1u
 S5CrW731tSAYTn/HoJ9yACK+2bDdSYzgZNyIMFug5XV4ZY1hxQKZoDDpmb0UP5rWvej0yjqt+oZ
 jwg+mp+PiICQp0v2D4zlYL1E76ekaOe0ZueT0m83TvpdbICrsLp6S6yBx7rc7i2U/tKjsuhRR8j
 cCBL12m0+HNtlZ+9gq4jiz1tftgbZMEQFEa1r4rLME7U5bN8Ze9GH
X-Received: by 2002:a17:903:f90:b0:2aa:e3c7:6048 with SMTP id
 d9443c01a7336-2ad1746c179mr142629065ad.23.1771415009305; 
 Wed, 18 Feb 2026 03:43:29 -0800 (PST)
X-Received: by 2002:a17:903:f90:b0:2aa:e3c7:6048 with SMTP id
 d9443c01a7336-2ad1746c179mr142628965ad.23.1771415008927; 
 Wed, 18 Feb 2026 03:43:28 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:28 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 14/34] accel/kvm: rebind current VCPUs to the new KVM VM
 file descriptor upon reset
Date: Wed, 18 Feb 2026 17:12:07 +0530
Message-ID: <20260218114233.266178-15-anisinha@redhat.com>
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
index 47589f92e2..7be39111bb 100644
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


