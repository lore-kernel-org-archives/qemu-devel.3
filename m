Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D09C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9B9Z-0004u0-8L; Tue, 22 Sep 2026 20:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9B9Y-0004tq-Bj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9B9W-0007Pp-Is
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790124481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=soPfNLvyehGkK5sUU9EAbSiY6UKT8pRxngG6hsGjorM=;
 b=M7o0X2auKrGdS5Jm7m82LFGqCO57weEQUaN/Yfop7+Jr6KhWM9Fu1hXlOtx+ulig8iBhIN
 6SYmbCOYj8wEdF2Gk93VTQu6Scq045IXDr/+ijRuW+YV9jF4NmqjWEUI29WGRgWwCNEvwD
 xlit/HB/mFvFeAYUOb66W74cNujYjG0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-f-w0J0IeM9OL3lY_RaFXgA-1; Tue,
 22 Sep 2026 20:46:55 -0400
X-MC-Unique: f-w0J0IeM9OL3lY_RaFXgA-1
X-Mimecast-MFC-AGG-ID: f-w0J0IeM9OL3lY_RaFXgA_1790124414
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C56621830530; Wed, 23 Sep 2026 00:46:53 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 488161956041; Wed, 23 Sep 2026 00:46:51 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 "Vulnerability Report" <vr@darknavy.com>
Subject: [PATCH] accel/kvm: protect kvm_resample_fd_list with a mutex
Date: Tue, 22 Sep 2026 20:46:51 -0400
Message-ID: <20260923004651.101197-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 accel/kvm/kvm-all.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a847..da3afdc68d8d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -146,6 +146,7 @@ typedef struct KVMResampleFd KVMResampleFd;
 static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =
     QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
 
+static QemuMutex kvm_resample_fd_list_lock;
 static QemuMutex kml_slots_lock;
 
 #define kvm_slots_lock()    qemu_mutex_lock(&kml_slots_lock)
@@ -157,6 +158,8 @@ static inline void kvm_resample_fd_remove(int gsi)
 {
     KVMResampleFd *rfd;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
+
     QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
         if (rfd->gsi == gsi) {
             QLIST_REMOVE(rfd, node);
@@ -164,6 +167,8 @@ static inline void kvm_resample_fd_remove(int gsi)
             break;
         }
     }
+
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
@@ -173,20 +178,26 @@ static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
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
@@ -2910,6 +2921,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
+    qemu_mutex_init(&kvm_resample_fd_list_lock);
 
     /*
      * On systems where the kernel can support different base page
-- 
2.54.0


