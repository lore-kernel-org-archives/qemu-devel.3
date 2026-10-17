Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5DACCF2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9cI-0003wT-Ez; Sat, 17 Oct 2026 14:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9c3-0003TV-Nb; Sat, 17 Oct 2026 14:58:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9c1-0003qQ-OB; Sat, 17 Oct 2026 14:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263395; bh=LK7pOWEmvXVNe1OtftuZdvx7LDJF7xQ5LtMBve5pgQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wKquG11kXRmO7y8B2KZRKx2IO7ZKMURsahTpweH4/p078FNDg4tYbnZ9NpTiiOR7T
 P2dbltF3N1daFg9xQydh/WOgfC3cC3PaajMUxHLWFgHQOq5Z9vCZqdwE9v4PeZLery
 ssHonqQ18+ItddjVBap/mVBqTMjVZv+amTwTvBmgnwu2i0raTibxTrSlYp5z+T93In
 vgbXmw6TDy0qhWmfG4Ui2srDytzUsygYwNwXjw7tUoo+VHcNHLAmRDa+gSoA65gmQN
 WIyk0LWNY2AS7LzRePSPtOxvAnm7f5/kLsGka9d7ipFBFAXNW8Q4ubNHs6w84gXOLn
 91O4RNA6zu7UA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6402E1DE6BF;
 Sat, 17 Oct 2026 21:56:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1292144338A;
 Sat, 17 Oct 2026 21:56:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 "Vulnerability Report" <vr@darknavy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 31/63] accel/kvm: protect kvm_resample_fd_list with a
 mutex
Date: Sat, 17 Oct 2026 21:54:47 +0300
Message-ID: <20261017185528.722197-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Maxim Levitsky <mlevitsk@redhat.com>

Legacy PCI INTx interrupts are level triggered and can, in theory, be shared.

Upon receiving such an interrupt, VFIO kernel driver masks it in a generic way,
using INTX_DISABLE bit in the PCI config space.

It then waits for the guest to signal completion (EOI) of the interrupt,
upon which VFIO re-enables the interrupt.

The completion is signaled with another eventfd.

For split irqchip mode, KVM doesn't have a notion of EOI on IOAPIC level.
Instead it signals EOI with a userspace VM exit, KVM_EXIT_IOAPIC_EOI.

Upon receiving this VM exit, Qemu manually signals the above-mentioned eventfd.

The problem that this patch resolves is that QEMU keeps these eventfds in
a linked list without any locking to prevent the list from being corrupted by
concurrent access.

Such use is possible and guest triggerable if the guest rapidly toggles
INTX mode of a VFIO device and at the same time signals EOI with an arbitrary
vector.

Fix this by protecting this list (kvm_resample_fd_list) with a mutex.

This patch was only compile tested.

Reported-by: "Vulnerability Report" <vr@darknavy.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3942
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004651.101197-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0f98b46846eb04791f5f4c992d3441c8a8b48872)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 57727b3fea..66783fcf11 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,7 @@ typedef struct KVMResampleFd KVMResampleFd;
 static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =
     QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
 
+static QemuMutex kvm_resample_fd_list_lock;
 static QemuMutex kml_slots_lock;
 
 #define kvm_slots_lock()    qemu_mutex_lock(&kml_slots_lock)
@@ -138,6 +139,8 @@ static inline void kvm_resample_fd_remove(int gsi)
 {
     KVMResampleFd *rfd;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
+
     QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
         if (rfd->gsi == gsi) {
             QLIST_REMOVE(rfd, node);
@@ -145,6 +148,8 @@ static inline void kvm_resample_fd_remove(int gsi)
             break;
         }
     }
+
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
@@ -154,20 +159,26 @@ static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
     rfd->gsi = gsi;
     rfd->resample_event = event;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
     QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 void kvm_resample_fd_notify(int gsi)
 {
     KVMResampleFd *rfd;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
+
     QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
         if (rfd->gsi == gsi) {
             event_notifier_set(rfd->resample_event);
             trace_kvm_resample_fd_notify(gsi);
-            return;
+            break;
         }
     }
+
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 /**
@@ -2572,6 +2583,7 @@ static int kvm_init(MachineState *ms)
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
+    qemu_mutex_init(&kvm_resample_fd_list_lock);
 
     s = KVM_STATE(ms->accelerator);
 
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 8cd1d85e06..d29a579156 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -241,7 +241,6 @@ void ioapic_eoi_broadcast(int vector)
                 continue;
             }
 
-#ifdef CONFIG_KVM
             /*
              * When IOAPIC is in the userspace while APIC is still in
              * the kernel (i.e., split irqchip), we have a trick to
@@ -257,8 +256,9 @@ void ioapic_eoi_broadcast(int vector)
              * operations below because we don't know whether there're
              * emulated devices that are using/sharing the same IRQ.
              */
-            kvm_resample_fd_notify(n);
-#endif
+            if (kvm_enabled()) {
+                kvm_resample_fd_notify(n);
+            }
 
             if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
                 continue;
-- 
2.47.3


