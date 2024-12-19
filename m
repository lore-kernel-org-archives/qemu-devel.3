Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D388E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBym-0006rp-BJ; Thu, 19 Dec 2024 03:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByi-0006Zz-6Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByd-0005Fc-Fe
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJDnjE/BAkbJeQX/EK6vVThXGUwkUNVfjMYxPU0nzCU=;
 b=IduSYHbNauy6dDG16Lspygm2AHqZrCQzXzsapRFd3KbGqbQ1ZPGoE4xgEQlqsHpE4aqD7q
 dGKIHG9140SElMY0JshTqWHymaRdZRxxWmZukWKzm3b4spPMQ7yILBdT+4fxH0sZpIZzjA
 Y8vkXKmMdZXJ3V6cY4XhSj8oB4u3TMk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-9_x_s7QuPyWE9KPKWPihsA-1; Thu, 19 Dec 2024 03:33:45 -0500
X-MC-Unique: 9_x_s7QuPyWE9KPKWPihsA-1
X-Mimecast-MFC-AGG-ID: 9_x_s7QuPyWE9KPKWPihsA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so2956695e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597223; x=1735202023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJDnjE/BAkbJeQX/EK6vVThXGUwkUNVfjMYxPU0nzCU=;
 b=YQoB2fYKUl1ZvIyBz7dO8syj2DdFJKz58DjTBXFUMehKRrvSqxBHwP2I3UuWhfiW3s
 dEtIQKwsXsy22vbjbj5LkGoF7PBkR8ctT9tFE0v92WNnuQBrNABqvVcPTnxtRLdcjZ6b
 aWTKUCFoCXDh1jqJXVuuah9aV2jCWG+17DFiShQ4wuHgab0Kc9XjJWLGoTSWgdhYqYAa
 UxlAJizyfN/F/7VjCNdntqpfVx5JwnsVKO58xbMnG3y1H5UQEtdWB3l1RHGcSZrtmg0w
 FT8DOYKn9xBaVvBYYOB8tkEyajj58rY99cMwLpBFk3oyNQFtfl0Aw9fH0fquKbGveWz1
 eL/w==
X-Gm-Message-State: AOJu0YzQDMmsSqnP1DjpTwxG/9QFlkguNjcQCG0l81TNse8vGsghnSkD
 0XcKydRZ+b3D/ZlzNYF3u2VQ59+LU/j+prLNdOo5MEjOn2qxB4K5QLxavC0013oVt2SsaIzCnWX
 ZGh5mbnnYNP3ebAxjpBdXr+MRZmvbkooSasyzny60Oc7QLU2O04LExHuCEnBXJeuy56yoHN8aVx
 BWApRDPJRfDdWErn0ey3SlTbiJAt9hAgBsZU4i
X-Gm-Gg: ASbGnctgZzStKWyD9fvz+8c4juV/LE7cl+JD0n2HiZOa7eHT5cYUNEpwXrikwqTG26K
 taP6PU5qSbsKYZjMkoNOvFAwMFBM6CZxKwVO6M508tAHJtF85uNRbL4y/POty6ODE3CoBxzm+cu
 5piIb2fo92FvZhssuKeED7gyYrFyMVN5O6n0VuNQi4jZEZv3v+a4n0bvB4fF03dmtG93kKm5ZT2
 O12HTR+d7emiOlejx5MBFJYLW/vXckuMyjUXQrEFfU0OxNHfZX2GWT6FrtA
X-Received: by 2002:a5d:6c63:0:b0:386:1c13:30d5 with SMTP id
 ffacd0b85a97d-388e4d4a602mr6275736f8f.7.1734597223389; 
 Thu, 19 Dec 2024 00:33:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8mfBgfoZsrrEsn4jt5aFybkYtKfHi1/1tkA+F7sZdfhtu/u96vEX9Umy6mVUC62rFH/zt1A==
X-Received: by 2002:a5d:6c63:0:b0:386:1c13:30d5 with SMTP id
 ffacd0b85a97d-388e4d4a602mr6275686f8f.7.1734597222876; 
 Thu, 19 Dec 2024 00:33:42 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8ac974sm968353f8f.91.2024.12.19.00.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 34/41] target/i386: Reset TSCs of parked vCPUs too on VM reset
Date: Thu, 19 Dec 2024 09:32:21 +0100
Message-ID: <20241219083228.363430-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since commit 5286c3662294 ("target/i386: properly reset TSC on reset")
QEMU writes the special value of "1" to each online vCPU TSC on VM reset
to reset it.

However parked vCPUs don't get that handling and due to that their TSCs
get desynchronized when the VM gets reset.
This in turn causes KVM to turn off PVCLOCK_TSC_STABLE_BIT in its exported
PV clock.
Note that KVM has no understanding of vCPU being currently parked.

Without PVCLOCK_TSC_STABLE_BIT the sched clock is marked unstable in
the guest's kvm_sched_clock_init().
This causes a performance regressions to show in some tests.

Fix this issue by writing the special value of "1" also to TSCs of parked
vCPUs on VM reset.

Reproducing the issue:
1) Boot a VM with "-smp 2,maxcpus=3" or similar

2) device_add host-x86_64-cpu,id=vcpu,node-id=0,socket-id=0,core-id=2,thread-id=0

3) Wait a few seconds

4) device_del vcpu

5) Inside the VM run:
# echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
Observe the sched_clock_stable() value is 1.

6) Reboot the VM

7) Once the VM boots once again run inside it:
# echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
Observe the sched_clock_stable() value is now 0.

Fixes: 5286c3662294 ("target/i386: properly reset TSC on reset")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/5a605a88e9a231386dc803c60f5fed9b48108139.1734014926.git.maciej.szmigiero@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/i386-softmmu.mak   |  1 +
 configs/targets/x86_64-softmmu.mak |  1 +
 include/sysemu/kvm.h               |  8 ++++++++
 accel/kvm/kvm-all.c                | 11 +++++++++++
 target/i386/kvm/kvm.c              | 15 +++++++++++++++
 5 files changed, 36 insertions(+)

diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 2ac69d5ba37..2eb0e862500 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
+TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index e12ac3dc59b..920e9a42006 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
+TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c3a60b28909..ab17c09a551 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -377,6 +377,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
+#ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
+void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
+#else
+static inline void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
+{
+}
+#endif
+
 bool kvm_vcpu_id_is_valid(int vcpu_id);
 
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 77d811ca70c..4ab277cc84a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -437,6 +437,16 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_fd;
 }
 
+static void kvm_reset_parked_vcpus(void *param)
+{
+    KVMState *s = param;
+    struct KVMParkedVcpu *cpu;
+
+    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
+        kvm_arch_reset_parked_vcpu(cpu->vcpu_id, cpu->kvm_fd);
+    }
+}
+
 int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
@@ -2728,6 +2738,7 @@ static int kvm_init(MachineState *ms)
     }
 
     qemu_register_reset(kvm_unpoison_all, NULL);
+    qemu_register_reset(kvm_reset_parked_vcpus, s);
 
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e17942c3ba..2ff618fbf13 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2415,6 +2415,21 @@ void kvm_arch_after_reset_vcpu(X86CPU *cpu)
     }
 }
 
+void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
+{
+    g_autofree struct kvm_msrs *msrs = NULL;
+
+    msrs = g_malloc0(sizeof(*msrs) + sizeof(msrs->entries[0]));
+    msrs->entries[0].index = MSR_IA32_TSC;
+    msrs->entries[0].data = 1; /* match the value in x86_cpu_reset() */
+    msrs->nmsrs++;
+
+    if (ioctl(kvm_fd, KVM_SET_MSRS, msrs) != 1) {
+        warn_report("parked vCPU %lu TSC reset failed: %d",
+                    vcpu_id, errno);
+    }
+}
+
 void kvm_arch_do_init_vcpu(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
-- 
2.47.1


