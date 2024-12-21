Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A25E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53V-0002NQ-JZ; Sat, 21 Dec 2024 14:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53T-0002N0-Qw
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53S-00008y-1L
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eu+UQDI4XBqUuyYo1urovuvbpp7PhrM/aJHLpvbVFXQ=;
 b=d0+nKMvfR1r4jjijxd4VeH2Dgjhp7ylUuHJ0Y0p6uTN5RMMf/W6Cg2W1/yvHWZkbi7bD/g
 81ltGJRXXXwH/qVV4NxzzDK97pFmmSo1xzYFj4ezZohMRqBvmQ0eIZPPWCpLHxpe4s7TYu
 emkr2FQSgZNda/det0Pb2jlVSBv37f4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-_Pxkc9qxMguGw--aasI3ow-1; Sat, 21 Dec 2024 14:22:23 -0500
X-MC-Unique: _Pxkc9qxMguGw--aasI3ow-1
X-Mimecast-MFC-AGG-ID: _Pxkc9qxMguGw--aasI3ow
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so1409508f8f.3
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808942; x=1735413742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eu+UQDI4XBqUuyYo1urovuvbpp7PhrM/aJHLpvbVFXQ=;
 b=oYwZptHT0dRZWlJAlep929DPV6ksyHTnyp+a76zAyPksFbTwlet8cmD6ry8Aaukns0
 AiA4Qbe+3dRTTZ95dtVgpySmBJ5qx6s9eT9smQN86NZ+RAwvILX5FpV5m7+OLpdLb+7Z
 pwbBs6u+w0Kz6iGZr2bJEinTwyM1354QI2VpJu23a8El1VTLK4eD2HQHuTBaIhxVGLe7
 /0cLsLRbNQoT/r+yZuwPIRQ9Zub0jmFPdYIC/LH46clZ8Av+IqH8ioQGE1ziBV/p6PQt
 m6iTckeMn4nVXLQw3jA048ucjhfDnpCzAnx9RT3YgKqO5jVBaUFqJsdZKw4rbbPjngs4
 PxoA==
X-Gm-Message-State: AOJu0Ywr3TrlwlBXY8qaVpvAl3Mh9LLSipdZY/W/U7nATWU+SsTIVe1I
 LdFR4QdY/1+aH6utmP4+sLuMu2nxgYKdNgv5JcKpMRLKl8J+olzlnDuQyyIkq50FnjJBGp0WZBr
 zqIao3qdLY93kgSB+qvz+QKqUXmnx6mrbtrPZ1oS/o99f+c9OogvyFycdNdx/uowerwP5+r6oFw
 RN6tfrkvK17YZTRKeD28G3QLUoW06cScIB
X-Gm-Gg: ASbGncuM0YJDT6lfdI9evPnmZ2eq1+YfMQchnsfyklCmRgwl35t4eF3b38dCj+ouBhf
 wByuuumcyOS6x2zQht6DDTb2bgaR/pkOq8rZigNbfL5hfIhJg3+c6yiDzhmruj+L4zKezREGZu0
 Qfp++nlz3jzPaq4K4Wi7lNxfVse2mOwCcArSuKaxiNqlFwipBcipfINqQgERj8dvbbwODEDstzA
 8tXg1hvq/2zSCv5/P5ghOATEJCjoCXFzWk1bM3NTSf387KRF/lA/kjNUz6dduEM9o4PBvtnZUhe
 uyelLMJqR5zJfiXuHjhlxPXz4KG3W1qhf7lu2yA=
X-Received: by 2002:a05:6000:4012:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38a221fa22cmr7202750f8f.21.1734808942166; 
 Sat, 21 Dec 2024 11:22:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqebWA7jESFeSiNnHg724Vz6EPlvaC/ie8FGqhmyY/SboMdQ6hWe8lQGRuLkaMI07CfNtKLw==
X-Received: by 2002:a05:6000:4012:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38a221fa22cmr7202731f8f.21.1734808941745; 
 Sat, 21 Dec 2024 11:22:21 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43661289e0fsm84041905e9.39.2024.12.21.11.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:20 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 03/15] s390x/s390-virtio-hcall: remove hypercall
 registration mechanism
Date: Sat, 21 Dec 2024 20:21:57 +0100
Message-ID: <20241221192209.3979595-4-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

Message-ID: <20241219144115.2820241-3-david@redhat.com>
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


