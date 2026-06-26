Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0C9CDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eM-00086Z-RL; Fri, 26 Jun 2026 06:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dz-0007Ov-KM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dt-0005CU-Ch
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+gLFg/KCZl9YS09p+/cGqgOKgC1kYOxDJsSPMp/QV8=;
 b=H9cDAxREEIAAe3omPFBqtCXbze/zMR773boslNAAsQP+odWfZzTBDzyxNyhpq+1Cg2XWiE
 fvpsp63yjn/5h7yC6LMR7YnIrBShG+cUYbIidghr4vt+O6LgTSUSncbxIZHUnFTNks7P/t
 tWfZlNqT2Dv+YXYo7if5kbfIa5JmHtk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-mzbtAGYsOxGJWMPbTVfMCw-1; Fri, 26 Jun 2026 06:18:35 -0400
X-MC-Unique: mzbtAGYsOxGJWMPbTVfMCw-1
X-Mimecast-MFC-AGG-ID: mzbtAGYsOxGJWMPbTVfMCw_1782469114
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46f5d62dd1cso79426f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469114; x=1783073914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+gLFg/KCZl9YS09p+/cGqgOKgC1kYOxDJsSPMp/QV8=;
 b=K+P80yZ2CkwBUJ6eCxuUNW+NTAkMSVxnY220b35ah0RL9K9Vfz+9VVzxvtnS1Fw7Gp
 zyFE9kFqOV1IidpRsYrMQMg0bXdW7vMWs+5afD+N70spjX6SbieKWVNZRax/Ndt12mqT
 sclXFWD+6svl1GZL2FMgkwgcwrRu08kLPihWhKjynj31MklYQQBVrq+tQXv7RAQiMN+F
 GuUIyYYRQfX3pTWDS+2zKKOwiWiUBHj5rslW7p0q+q797lZIO3xxbVIvbeWksihw+w0i
 7AgpmefqnFv8ME+ZHuqlBuV7qo8/2/EBFQguasko/sTJ5Z3pTV/7CijaJ3x13tF5NZnK
 W7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469114; x=1783073914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p+gLFg/KCZl9YS09p+/cGqgOKgC1kYOxDJsSPMp/QV8=;
 b=M/c+KSfBPt40QqnXGXbVIS85FaTN+LwOn1L1DFXchfL6MUrwBw+5Su2JHMOw2G9ntc
 dy9nvsXohaWfCs35lF8WjjvLRncAYB2wi0h4ZOhUW7NPUB7vevvJJzmgQeVmBfUi8C6t
 So0p/uKIJoBsuyY4jJZGRCP8McLvTSU2VHMVJn0Rsy7VmfilPPHnc7/GpvkGlPoWErP/
 VhnldLF3OWV+Magkew9Q0e7lqbq+NzF9q17aOymyhSvggNXxEBWXxnojng3U2cV7uiIK
 jkeCuL/UIf/9PeQJoSUqIyxMEd1WCJEIH1PfTbN0aqMtC83GW7/EMQItqRWVxJ8AWT6H
 e03g==
X-Gm-Message-State: AOJu0YxKNsmq1xMqW6Ko90sB/UIqgIHLhfftlg3xlFC+dO6r2q5KgCWj
 gY7B3cjzjsriuMfdJY0ISqqSPMN+crja/3kCNmLdNg5JLWUD1Ul5egAeZTgPh3I5CM7Lo2VDtB0
 LXq+xQ9q+sTVsvKHXE+nzHw+QkF5aZFXThQIi2IHn3C5eS8Uwy1M3aAKKCiCFgn77Le59Lz/qyq
 2dSYYA4Xfn3GRlt0cqFmoY6UNiZy16Ls/RRR7xbAor
X-Gm-Gg: AfdE7cmd2X0KHfjRBuc7G58ZSsJjAioGYJbzzEm0xa1Tl0UWB48wTwf96IbB3Kbb8ga
 w99P7/iB3NfNPB0bIJrjAHruufge1K0ZEfEYm1KX1+PyLii7lTLUQ1CahYZAP0Ve4674jBipLUm
 A6UauiCeiVuCbmTU28XCvbeSAhwQprGIs+S6tHRBTDG8hoeYyO7OmX0rSvhE3L6ppHNCDDdgB2C
 n8IWUQaGGZjkGiYoNyK8TzUu6JVqP79g50mLyj8PtPtCNA8N2IBtTEl4MC7/3Ux4Z8zOhkK9OSp
 tD0On/I6ajxF61PkFJws9PTrqaSTlFH9vVBgJwlTwzA7frWp1k2rucpZo8lKMh5yV4lu2/vfGDW
 XoK9LPZ19s6qnkYhXMYqBx/6xwTsBMUHb8KfIB2MyWP26WmfG2XFbx4PW5RSy4cAHSJs3sPksYl
 7A75XFQKB2DB3BmzNT
X-Received: by 2002:a05:6000:46d8:b0:46e:7f72:b6fe with SMTP id
 ffacd0b85a97d-46e7f72b845mr3905819f8f.19.1782469114212; 
 Fri, 26 Jun 2026 03:18:34 -0700 (PDT)
X-Received: by 2002:a05:6000:46d8:b0:46e:7f72:b6fe with SMTP id
 ffacd0b85a97d-46e7f72b845mr3905760f8f.19.1782469113615; 
 Fri, 26 Jun 2026 03:18:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f978dc0a9sm936421f8f.15.2026.06.26.03.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 15/45] accel/accel-irq: add generic commit_route_changes
Date: Fri, 26 Jun 2026 12:17:18 +0200
Message-ID: <20260626101748.1728079-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

A generic accel_irqchip_commit_route_changes() fn has been introduced for
usage in the MSHV accelerator. The respective kvm_ fn can be removed
since we handle the commit op in a generic way.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-7-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h  |  8 --------
 accel/accel-irq.c     | 10 +++-------
 hw/misc/ivshmem-pci.c |  2 +-
 hw/vfio/pci.c         |  4 ++--
 target/i386/kvm/kvm.c |  2 +-
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index fec24d2135a..cdd1856ac5f 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -476,14 +476,6 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
                                  PCIDevice *dev);
 void kvm_irqchip_commit_routes(KVMState *s);
 
-static inline void kvm_irqchip_commit_route_changes(AccelRouteChange *c)
-{
-    if (c->changes) {
-        kvm_irqchip_commit_routes(KVM_STATE(c->accel));
-        c->changes = 0;
-    }
-}
-
 int kvm_irqchip_get_virq(KVMState *s);
 void kvm_irqchip_release_virq(KVMState *s, int virq);
 
diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 3815f6727c6..7e71b525557 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -45,13 +45,9 @@ int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
 
 void accel_irqchip_commit_route_changes(AccelRouteChange *c)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
-    if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_commit_routes();
-    }
-#endif
-    if (kvm_enabled()) {
-        kvm_irqchip_commit_route_changes(c);
+    if (c->changes) {
+        accel_irqchip_commit_routes();
+        c->changes = 0;
     }
 }
 
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index fa23562886b..536475e9de8 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -436,7 +436,7 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
         error_setg(errp, "kvm_irqchip_add_msi_route failed");
         return;
     }
-    kvm_irqchip_commit_route_changes(&c);
+    accel_irqchip_commit_route_changes(&c);
 
     s->msi_vectors[vector].virq = ret;
     s->msi_vectors[vector].pdev = pdev;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3a6e17c9d77..d2aba8aaf50 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -691,7 +691,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             } else {
                 vfio_route_change = accel_irqchip_begin_route_changes();
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
-                kvm_irqchip_commit_route_changes(&vfio_route_change);
+                accel_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
             }
         }
@@ -800,7 +800,7 @@ void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
     assert(vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = false;
 
-    kvm_irqchip_commit_route_changes(&vfio_route_change);
+    accel_irqchip_commit_route_changes(&vfio_route_change);
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 03312922d50..64cc421abe6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6690,7 +6690,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
                 exit(1);
             }
         }
-        kvm_irqchip_commit_route_changes(&c);
+        accel_irqchip_commit_route_changes(&c);
     }
 }
 
-- 
2.54.0


