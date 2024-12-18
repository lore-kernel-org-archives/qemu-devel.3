Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13431E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNriF-0001OF-BF; Wed, 18 Dec 2024 05:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrht-0000nh-3T
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrho-0006zD-63
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxxchDNQC4SAcVGoK+vji+3LCeK2icJzmCxE+kApb18=;
 b=NCp82HLom1mMUSgCSKc1JP0dzYBAwBU1wgrQSF6Ms4HCotDvhY5HMKx03QwxuzEonv+1v3
 WUxf/sbDCbZASvJMEO48r7/hO8MNVKHNuFTFGfNJbdo5JF3AhA8zHmcZPG3BTp+6Igxwjo
 TDPd0Z8Z+iidgFz8W5hqGQdU5vE5u4o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-dAxi-L4OPB6Xxtjqy8Tq1g-1; Wed, 18 Dec 2024 05:53:15 -0500
X-MC-Unique: dAxi-L4OPB6Xxtjqy8Tq1g-1
X-Mimecast-MFC-AGG-ID: dAxi-L4OPB6Xxtjqy8Tq1g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so4224999f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519194; x=1735123994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxxchDNQC4SAcVGoK+vji+3LCeK2icJzmCxE+kApb18=;
 b=tkX62usuIdb6HydA3pPGdDfwc7MehzgsTn8G+Uu6BYlxK8DvclnKB5c2GX3G+YjrQy
 IpquWpWiQXnmKz8FgDs+ODpUC4nC4Aer7oPozSf46GqQcWrtMxIyfC63vQma6+j4c0M2
 DmRJyEpQo/tekY62kO+EetKLDUaRFXLGc/YsUMHsnyVB8ErpUji+gjjqYOMGkQE/wKiK
 CHXazOoZzOiIlUD0EH5vgB5x4f/I6frFD7eOwRgyl7uWZqIoNXYeNoi3bESh66kWRb8q
 crqIWVmv+yIGwYNAoibtqPC+bfkgqFZbxsn/Zgq/rjIdVH3HxYG0uG+6TIoIc99cHZBF
 Qdew==
X-Gm-Message-State: AOJu0YwXv0e1C0VWc1sjtMuwYSHNCNcQ74YpK+aTTJQcrbAlBDKlnAxy
 3JlmDms9aFflADUfPuAJThKZTNhIUApZKrob7Gb4tQwTPeHdCbchDaGRuZYMw93p2A2iB4fRWUw
 mPdQJs986oYrlOdLWI7nohoO1ZmC18ykEnB/9dJH2KwLzGTcAoVbv8qkEAqbVJNUZRN+3vzOdOp
 m9irB9XR9pCuHtK4B8Of+7AQc/6H0HLEbzYUs=
X-Gm-Gg: ASbGncvtC3FFOlX6fZG+SYQ0+Cr+5jKP7Ytfm6mw1DzoJ2yuyhfFyv9SjfufAqJwOLd
 DK2PvTd1kmRNZyqersJDnkrFdXW8W5xoRg8U1Ylo2ML/3ndWQqkAh+Blsi5H7oshqo7+V2gMSzQ
 che/2mkYyxLZjkFvMxB+Fegg17BojFMcWWQOhCJE0bUIWt1ITU8ritjm5SJtG6Z7oHAwfQW1Nw9
 Xr/yCEAIp2Njg0zdgfGeQUDLtTR02UO8fSjlOsfisRLN5gVdGX1iRrCJH8ZMcG5IKfKt5JGcr4l
 irAUgH7f5M7IMk60ZLx24iINYB/25SBpoOunThn+Sg==
X-Received: by 2002:a05:6000:1f89:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-388e4d3125amr2397197f8f.7.1734519193926; 
 Wed, 18 Dec 2024 02:53:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfibFWX5cTe42xxKTjQo5HD8qlI7NE464blGE5LJrNukJzxxjJvaOKpyjbJ8dTZKbgPpGqEA==
X-Received: by 2002:a05:6000:1f89:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-388e4d3125amr2397156f8f.7.1734519193465; 
 Wed, 18 Dec 2024 02:53:13 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4364b0532a6sm47177535e9.1.2024.12.18.02.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:12 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 03/15] s390x/s390-virtio-hcall: remove hypercall registration
 mechanism
Date: Wed, 18 Dec 2024 11:52:51 +0100
Message-ID: <20241218105303.1966303-4-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
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
 hw/s390x/s390-virtio-ccw.c   | 58 --------------------------------
 hw/s390x/s390-virtio-hcall.c | 65 +++++++++++++++++++++++++++---------
 hw/s390x/s390-virtio-hcall.h |  2 --
 3 files changed, 49 insertions(+), 76 deletions(-)

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
-- 
2.47.1


