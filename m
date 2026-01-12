Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5A6C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuX-0004PV-38; Mon, 12 Jan 2026 08:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtq-00032O-UH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtp-0003lS-2b
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huNj8LV84XiXUyf00M+KYfsVR7Qt8nLIumf0RvZ1e/M=;
 b=NW3Onxhn7PJJiiW/uJYpIKfIn8Nl34rTbq2Iyvqjcqeebo1daPRpUmvLHWSPRNI6SSOKmm
 +DfD9fZCPwRogIdRb3RsNFf9nQ+WeJ4gUsIOvYi+fOZOhKAspLhMj2z6lYoODTOdvgzGUP
 zNQF0R4er2r+F7y1H/3oK7rWkPZULHM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-SW1Rh0kPMIKK17T8Zm5npQ-1; Mon, 12 Jan 2026 08:23:59 -0500
X-MC-Unique: SW1Rh0kPMIKK17T8Zm5npQ-1
X-Mimecast-MFC-AGG-ID: SW1Rh0kPMIKK17T8Zm5npQ_1768224238
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso1467212a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224238; x=1768829038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huNj8LV84XiXUyf00M+KYfsVR7Qt8nLIumf0RvZ1e/M=;
 b=e/DHslr2MNi4icU6Et7jHguf9IlBB3OpObKcwAK3vE5A4P2Z2QbW8JvbrrBK0wakWC
 3XHLLbf4z6/ApYvCp4+iqjXNAUMPEJibZEqJZpnZWB0Rv+s6qD3jf1uVtIIEF2TqRnQi
 mftksxViGjekdFhVQP6M+hUWFLLMdYBzkdzvjEaOCzA9ubTR4WXwKJmBY95YU+xYa2ax
 pH7rsP27IEWUPBXyiIExON3/D92Zlt+Lv1wQD00wAxuWAOmLlZuxXadhMfpiJGiHz+dF
 fh45YCWGKkm6s4IZG3l5v00ZEDztvOucOk4fror/xc42hPIaGf4y7wphojTB8QRqwRo9
 9WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224238; x=1768829038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=huNj8LV84XiXUyf00M+KYfsVR7Qt8nLIumf0RvZ1e/M=;
 b=jYETe26HY8NJE9ex2gzz0xoHYzhwePM15dpLohqkVdWuIqpa+k/leTXhdO9nDHXeBt
 khWwIyQYHxSQA0DBozVu1wcJLoD+2eHvxGo1vDZpb5N9XDqx6bygWQW/gX7LSXjV7KBH
 ykD6zEwhU5FuuMq6LXh+Hb/RVdhPEIfJKOk6SroUDxde7QWdEWWfs32N24kw/E5o676V
 vDKbUxE8Yax+/CqkWzAMycZzwT5ttA+FVd4qdDEGcQkhiUf/qLvatnXo1VQjVXQ+iZnr
 6NHCSNKlkY8D9oDWjhRDrCfCbyCuzXTIBWfKpK7y2EMGXjd5LdsZc34lU2HKRyWTyC0e
 PTJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn5+5jTfSQ0VLqNk41Qv8oi0AdyZ/tS2VmWJI/0dBAUend9oJcocKRAfqXxmc7rB3y6SnOSsYMFRb0@nongnu.org
X-Gm-Message-State: AOJu0Yx/ZUm3PpLsbDxENGR/T0zynJnTSfFKefBIeNhe+iWmQnehFLpU
 /64JqSvJOhZp1FrBuUEDmOsgSETwZU2P1o0whGpern1kCQyYT0GOgWFnrxaWzKveTCI0z5C6oai
 fZe79fEgwfhptu2tlYC8gpiLnygOIaOnQYoglEj/JZLu8HKHIu1PVKYsV
X-Gm-Gg: AY/fxX6rccCUC/2vL6jfRKgFUnmsmUL3KBqNOaD2u/Gzyu4H+wQ5orblNxEoLd8t1hR
 9xwXZxDydgErFYqVbdjpEfWN63FHDjiAkF+M5MhURrOY7lvCQTgBzH4jLqHlvJUBMXcxqN5Si+2
 h4LHpMoPb9inV8Hz84Y/CW5dniKmnzvP+p8JcpziKASMJwXmvWiL2ox4pxb8xyzauqlah+nSAil
 pjuhAr79srK4gshUICGa7PCtTTwnS8lQ4JtWMXhfkQvsDtieIwJ92QyL3wnSL1FsGle+JyPQKJp
 +YzJSQyu5jWELSRFBtyQju/GMFycHpcDaAfMkoE2TRGZe0L5iUfa1iu+PvHi+di0eko1zCgLhUv
 HUwymvnyj/HQSTGzYihsH/dTm6iTk26gEOeO4RmzclOg=
X-Received: by 2002:a05:6a21:6da0:b0:364:1339:97c2 with SMTP id
 adf61e73a8af0-3898f8ccd38mr17616491637.14.1768224238062; 
 Mon, 12 Jan 2026 05:23:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKybBdHQbkuvgP5WuAflGvMiKUzNXddTr/0WDGSHVn7QeibNA2vw07SBmyCrL1qhYe3JMUog==
X-Received: by 2002:a05:6a21:6da0:b0:364:1339:97c2 with SMTP id
 adf61e73a8af0-3898f8ccd38mr17616470637.14.1768224237608; 
 Mon, 12 Jan 2026 05:23:57 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:57 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 12/32] accel/kvm: rebind current VCPUs to the new KVM VM
 file descriptor upon reset
Date: Mon, 12 Jan 2026 18:52:25 +0530
Message-ID: <20260112132259.76855-13-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 accel/kvm/kvm-all.c    | 202 ++++++++++++++++++++++++++++++++++-------
 accel/kvm/trace-events |   1 +
 2 files changed, 168 insertions(+), 35 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 367968427b..2bd4dcd43b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -130,6 +130,12 @@ static NotifierWithReturnList register_vmfd_changed_notifiers =
 static NotifierWithReturnList register_vmfd_pre_change_notifiers =
     NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_pre_change_notifiers);
 
+static int kvm_rebind_vcpus(Error **errp);
+
+static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
+static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
+static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
+
 struct KVMResampleFd {
     int gsi;
     EventNotifier *resample_event;
@@ -423,6 +429,83 @@ err:
     return ret;
 }
 
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
+        cpu->kvm_fd = kvm_fd;
+
+        cpu->vcpu_dirty = false;
+        cpu->dirty_pages = 0;
+        cpu->throttle_us_per_full = 0;
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
+
+        kvm_cpu_synchronize_post_init(cpu);
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
@@ -511,19 +594,11 @@ int kvm_create_and_park_vcpu(CPUState *cpu)
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
@@ -551,39 +626,47 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
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
@@ -608,14 +691,53 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
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
@@ -2726,6 +2848,16 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
     assert(!err);
 
+    /*
+     * rebind new vcpu fds with the new kvm fds
+     * These can only be called after kvm_arch_vmfd_change_ops()
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


