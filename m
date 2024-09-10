Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9477EEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so58d-0005fk-6j; Tue, 10 Sep 2024 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58S-0004zL-TE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58O-0006OA-Mn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5R09U0K+B6OvKndHb6tTh1WVlqgBDrmUY+WamsZLu4=;
 b=N/GgTNb2i9/Pfp+Nk2UnwII7znfux0sJtTXKpzKApvb6kBDCdoxcJXgVmzuBmJ/+7R5xiA
 sSaOWMIFnSXBXPnzc+3JScG3Mtf78lbl6Mnr/BGzjP8YIOEDv2/tFoqegzMfcE7vo62djT
 sB8IZuy93Ywne7E+HmpUGLlHH62WU0M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-6Ylr_Q1_OamtqObnmwMlHg-1; Tue,
 10 Sep 2024 13:58:29 -0400
X-MC-Unique: 6Ylr_Q1_OamtqObnmwMlHg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C428119560B5; Tue, 10 Sep 2024 17:58:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24EB519560AD; Tue, 10 Sep 2024 17:58:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 02/14] s390x/s390-virtio-hcall: remove hypercall
 registration mechanism
Date: Tue, 10 Sep 2024 19:57:57 +0200
Message-ID: <20240910175809.2135596-3-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c   | 58 --------------------------------
 hw/s390x/s390-virtio-hcall.c | 65 +++++++++++++++++++++++++++---------
 hw/s390x/s390-virtio-hcall.h |  2 --
 3 files changed, 49 insertions(+), 76 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e30cf0a2a1..57c95786f6 100644
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
@@ -302,9 +247,6 @@ static void ccw_init(MachineState *machine)
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
-- 
2.46.0


