Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA00E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGw-0004Zy-0R; Thu, 19 Dec 2024 11:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiU-00038w-TC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiR-0002Lf-8B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfUMyzBxkenPRXVObBB8fXXXKSaqPam0WqFh0G56Vy0=;
 b=RhPn7rXK6496eeGX5s9GBzjMNfnQpXyQ6RFHh1/dTwTkpRlqzCE7/WpUyfuEX+i6CMoVjg
 POxVhKx7UrsK/ijiqvM4wTlHG8V11BCSoo1/gy4yeYlYHWdh9U0vZrpsRSnx6NuFmD5xiL
 N8raYasI91MudL5bX95qFMC71R1IMwY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-E3e2hNHrPZeNPBrzQritSA-1; Thu, 19 Dec 2024 09:41:25 -0500
X-MC-Unique: E3e2hNHrPZeNPBrzQritSA-1
X-Mimecast-MFC-AGG-ID: E3e2hNHrPZeNPBrzQritSA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43624b08181so5260835e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619284; x=1735224084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfUMyzBxkenPRXVObBB8fXXXKSaqPam0WqFh0G56Vy0=;
 b=szNLgN61yO/MW/jmMBiDebKw6+yPRfyYapgr8Y3g8wLHTWPl3eCDHgaBKMf9v9qxVY
 oHbjJcGyhWbM+6QR37bL5j2L3X6mOlimrNaCo9wuEr5HLMA21kbPvX3ZXGtAU2Aa70mA
 bcvq+CsIoYVHWvyHbKS9DNLxDJQTJLHZCMJ8t5NXWCp5yYV1yIA7OZs1lO7KL9sRvqAs
 O9lD87Jf665ehplfmY8/NwauiXLn1IRQMwP8sv1WRobHkUfljEMeG8E/jtGh8iqvMNmO
 sPuMKzy8JNumogbrl3zaoHuoO9L+LHIDjzpwQ1qzUVUBgNOQAGsfbQnFTMkZL9BMSyA1
 CRIQ==
X-Gm-Message-State: AOJu0YyfCevDnHXYn9aBrL8/1R4gpTpc7WK5Wu6b175ZcR+gVwyDamA+
 l8Itdrs9HhCp4HPrLLkISZdKuxA8SxWp4ULGWc9zltWZXNBiyIk3QhUPvTgLHk99zZFUOgO+fz4
 cnqVrcPEJLjOUAtxZRhBlZGV5Us658llT6pu7cz9gTfBGeJmhkCDa8vceF6pZ/1qpKHqPju2h7Y
 YmqNC5wmpFPcpYIOggjwaCZkdB0v8UTFPzYoE=
X-Gm-Gg: ASbGncv7qrNd5obd2REtZHUrac0Zk3JFCWLHLK5TssNJ3Cv9GYw6tRhMNrjONQHYBrm
 JWJ2GoQYXMnb/BfM0MjHz6FfjxlCxDW3tPpoL9uMR9YhcJMpgSMw0BGqo/jqt/6nA2Y90OSfnFe
 Muhz5yK+gMRGv6I3PTHvUXNdxSBZ7tmKS7ssBKL98b/7NNh0BQaSidDSK4xCvC3Moks9lIYT4dW
 wUEm0KHwyg0VPsYxgV3dwXLF8sab2QsaHfmkaA2fWBc/IZ1EZC047uisslafFAQjYAcqIJHbUUB
 h1+gllDn/Lfjm/zyYCRp1Mho5lGAlBJy/TG4JlV1
X-Received: by 2002:a05:600c:3b98:b0:434:e69c:d338 with SMTP id
 5b1f17b1804b1-4365c775994mr29757395e9.5.1734619283909; 
 Thu, 19 Dec 2024 06:41:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwW+mEvolI/hBMEH/VMiivF08wHGLY3GmEDRdNEgw3Gd3twnsX+9fAxYHplsxuAe36Lw4IIw==
X-Received: by 2002:a05:600c:3b98:b0:434:e69c:d338 with SMTP id
 5b1f17b1804b1-4365c775994mr29756945e9.5.1734619283231; 
 Thu, 19 Dec 2024 06:41:23 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-436611ea3e0sm20239125e9.7.2024.12.19.06.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:22 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/14] s390x/s390-virtio-hcall: remove hypercall
 registration mechanism
Date: Thu, 19 Dec 2024 15:41:03 +0100
Message-ID: <20241219144115.2820241-3-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
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

Nowadays, we only have a single machine type in QEMU, everything is based
on virtio-ccw and the traditional virtio machine does no longer exist. No
need to dynamically register diag500 handlers. Move the two existing
handlers into s390-virtio-hcall.c.

Message-ID: <20241008105455.2302628-3-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/meson.build           |  6 ++--
 hw/s390x/s390-virtio-ccw.c     | 58 ------------------------------
 hw/s390x/s390-virtio-hcall.c   | 65 +++++++++++++++++++++++++---------
 hw/s390x/s390-virtio-hcall.h   |  2 --
 target/s390x/kvm/kvm.c         |  5 ++-
 target/s390x/tcg/misc_helper.c |  3 ++
 6 files changed, 60 insertions(+), 79 deletions(-)

diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 482fd13420..d6c8c33915 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -12,7 +12,6 @@ s390x_ss.add(files(
   's390-pci-inst.c',
   's390-skeys.c',
   's390-stattrib.c',
-  's390-virtio-hcall.c',
   'sclp.c',
   'sclpcpu.c',
   'sclpquiesce.c',
@@ -28,7 +27,10 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'tod-tcg.c',
 ))
-s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
+s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
+  's390-virtio-ccw.c',
+  's390-virtio-hcall.c',
+))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
 s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f2a17ecace..b0edaa0872 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -16,11 +16,8 @@
 #include "exec/ram_addr.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/boards.h"
-#include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
-#include "hw/s390x/ioinst.h"
-#include "hw/s390x/css.h"
 #include "virtio-ccw.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
@@ -124,58 +121,6 @@ static void subsystem_reset(void)
     }
 }
 
-static int virtio_ccw_hcall_notify(const uint64_t *args)
-{
-    uint64_t subch_id = args[0];
-    uint64_t data = args[1];
-    SubchDev *sch;
-    VirtIODevice *vdev;
-    int cssid, ssid, schid, m;
-    uint16_t vq_idx = data;
-
-    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
-        return -EINVAL;
-    }
-    sch = css_find_subch(m, cssid, ssid, schid);
-    if (!sch || !css_subch_visible(sch)) {
-        return -EINVAL;
-    }
-
-    vdev = virtio_ccw_get_vdev(sch);
-    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {
-        return -EINVAL;
-    }
-
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
-        virtio_queue_set_shadow_avail_idx(virtio_get_queue(vdev, vq_idx),
-                                          (data >> 16) & 0xFFFF);
-    }
-
-    virtio_queue_notify(vdev, vq_idx);
-    return 0;
-}
-
-static int virtio_ccw_hcall_early_printk(const uint64_t *args)
-{
-    uint64_t mem = args[0];
-    MachineState *ms = MACHINE(qdev_get_machine());
-
-    if (mem < ms->ram_size) {
-        /* Early printk */
-        return 0;
-    }
-    return -EINVAL;
-}
-
-static void virtio_ccw_register_hcalls(void)
-{
-    s390_register_virtio_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY,
-                                   virtio_ccw_hcall_notify);
-    /* Tolerate early printk. */
-    s390_register_virtio_hypercall(KVM_S390_VIRTIO_NOTIFY,
-                                   virtio_ccw_hcall_early_printk);
-}
-
 static void s390_memory_init(MemoryRegion *ram)
 {
     MemoryRegion *sysmem = get_system_memory();
@@ -296,9 +241,6 @@ static void ccw_init(MachineState *machine)
                               OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    /* register hypercalls */
-    virtio_ccw_register_hcalls();
-
     s390_enable_css_support(s390_cpu_addr2state(0));
 
     ret = css_create_css_image(VIRTUAL_CSSID, true);
diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index ec7cf8beb3..ca49e3cd22 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -11,31 +11,64 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "hw/boards.h"
 #include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/ioinst.h"
+#include "hw/s390x/css.h"
+#include "virtio-ccw.h"
 
-#define MAX_DIAG_SUBCODES 255
+static int handle_virtio_notify(uint64_t mem)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
 
-static s390_virtio_fn s390_diag500_table[MAX_DIAG_SUBCODES];
+    if (mem < ms->ram_size) {
+        /* Early printk */
+        return 0;
+    }
+    return -EINVAL;
+}
 
-void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn)
+static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
 {
-    assert(code < MAX_DIAG_SUBCODES);
-    assert(!s390_diag500_table[code]);
+    SubchDev *sch;
+    VirtIODevice *vdev;
+    int cssid, ssid, schid, m;
+    uint16_t vq_idx = data;
+
+    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
+        return -EINVAL;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (!sch || !css_subch_visible(sch)) {
+        return -EINVAL;
+    }
 
-    s390_diag500_table[code] = fn;
+    vdev = virtio_ccw_get_vdev(sch);
+    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {
+        return -EINVAL;
+    }
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+        virtio_queue_set_shadow_avail_idx(virtio_get_queue(vdev, vq_idx),
+                                          (data >> 16) & 0xFFFF);
+    }
+
+    virtio_queue_notify(vdev, vq_idx);
+    return 0;
 }
 
 int s390_virtio_hypercall(CPUS390XState *env)
 {
-    s390_virtio_fn fn;
-
-    if (env->regs[1] < MAX_DIAG_SUBCODES) {
-        fn = s390_diag500_table[env->regs[1]];
-        if (fn) {
-            env->regs[2] = fn(&env->regs[2]);
-            return 0;
-        }
-    }
+    const uint64_t subcode = env->regs[1];
 
-    return -EINVAL;
+    switch (subcode) {
+    case KVM_S390_VIRTIO_NOTIFY:
+        env->regs[2] = handle_virtio_notify(env->regs[2]);
+        return 0;
+    case KVM_S390_VIRTIO_CCW_NOTIFY:
+        env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
+        return 0;
+    default:
+        return -EINVAL;
+    }
 }
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 3ae6d6ae3a..3d9fe147d2 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -18,8 +18,6 @@
 /* The only thing that we need from the old kvm_virtio.h file */
 #define KVM_S390_VIRTIO_NOTIFY 0
 
-typedef int (*s390_virtio_fn)(const uint64_t *args);
-void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
 int s390_virtio_hypercall(CPUS390XState *env);
 
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index dd0322c43a..32cf70bb19 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -51,6 +51,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "target/s390x/kvm/pv.h"
+#include CONFIG_DEVICES
 
 #define kvm_vm_check_mem_attr(s, attr) \
     kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
@@ -1494,9 +1495,11 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
 static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
 {
     CPUS390XState *env = &cpu->env;
-    int ret;
+    int ret = -EINVAL;
 
+#ifdef CONFIG_S390_CCW_VIRTIO
     ret = s390_virtio_hypercall(env);
+#endif /* CONFIG_S390_CCW_VIRTIO */
     if (ret == -EINVAL) {
         kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
         return 0;
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 303f86d363..f44136a568 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -43,6 +43,7 @@
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/boards.h"
 #include "hw/s390x/tod.h"
+#include CONFIG_DEVICES
 #endif
 
 /* #define DEBUG_HELPER */
@@ -116,12 +117,14 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     uint64_t r;
 
     switch (num) {
+#ifdef CONFIG_S390_CCW_VIRTIO
     case 0x500:
         /* KVM hypercall */
         bql_lock();
         r = s390_virtio_hypercall(env);
         bql_unlock();
         break;
+#endif /* CONFIG_S390_CCW_VIRTIO */
     case 0x44:
         /* yield */
         r = 0;
-- 
2.47.1


