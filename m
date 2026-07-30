Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DC0C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRva-0007Ph-RO; Thu, 30 Jul 2026 10:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpRvS-0007Mt-07
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpRvQ-0007x1-1q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785422394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WU7696LrQetw1gphi8sovpLXs74SqnB+0kWy0HhzST0=;
 b=LkEE8Id1MaS6i1tl3zNqZUYrsf56LUzVVkDHlB8xwc/y5jzi4qxIlMZmEtXcP0JjZprm7L
 1mjM+bjNMyRrkRx0OiyNk0Nnn9ygEyA8HyfLAUmwCtdUrU+NWRd2/tKd3b/h3el/Uujahw
 D3+jvbxyTgXuE4LP0hXHiEKiSEyfUvs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-EJjkGOXbOgGF_UUN9IHc0A-1; Thu,
 30 Jul 2026 10:39:49 -0400
X-MC-Unique: EJjkGOXbOgGF_UUN9IHc0A-1
X-Mimecast-MFC-AGG-ID: EJjkGOXbOgGF_UUN9IHc0A_1785422388
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0E2519560B0; Thu, 30 Jul 2026 14:39:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87F1E1956044; Thu, 30 Jul 2026 14:39:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/net/vmxnet3: Do not abort if guest provides bad interrupt
 numbers
Date: Thu, 30 Jul 2026 16:39:43 +0200
Message-ID: <20260730143943.1117129-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

vmxnet3_validate_interrupts() currently aborts via hw_error() if
the guest provided bad interrupt numbers. This should not happen,
QEMU should rather refuse to activate the device in this case instead.
Thus propagate the error to the callers to handle it more gracefully
there.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/539
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/vmxnet3.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 8569484b2f2..1c5d1d740cc 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1336,32 +1336,46 @@ static bool vmxnet3_verify_intx(VMXNET3State *s, int intx)
         || intx == pci_get_byte(s->parent_obj.config + PCI_INTERRUPT_PIN) - 1;
 }
 
-static void vmxnet3_validate_interrupt_idx(bool is_msix, int idx)
+static bool vmxnet3_validate_irq_idx(const char *type, bool is_msix, int idx)
 {
     int max_ints = is_msix ? VMXNET3_MAX_INTRS : VMXNET3_MAX_NMSIX_INTRS;
+
     if (idx >= max_ints) {
-        hw_error("Bad interrupt index: %d\n", idx);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "vmxnet3: Bad %s queue interrupt index: %d\n",
+                      type, idx);
+        return false;
     }
+
+    return true;
 }
 
-static void vmxnet3_validate_interrupts(VMXNET3State *s)
+static bool vmxnet3_validate_interrupts(VMXNET3State *s)
 {
     int i;
 
     VMW_CFPRN("Verifying event interrupt index (%d)", s->event_int_idx);
-    vmxnet3_validate_interrupt_idx(s->msix_used, s->event_int_idx);
+    if (!vmxnet3_validate_irq_idx("event", s->msix_used, s->event_int_idx)) {
+        return false;
+    }
 
     for (i = 0; i < s->txq_num; i++) {
         int idx = s->txq_descr[i].intr_idx;
         VMW_CFPRN("Verifying TX queue %d interrupt index (%d)", i, idx);
-        vmxnet3_validate_interrupt_idx(s->msix_used, idx);
+        if (!vmxnet3_validate_irq_idx("TX", s->msix_used, idx)) {
+            return false;
+        }
     }
 
     for (i = 0; i < s->rxq_num; i++) {
         int idx = s->rxq_descr[i].intr_idx;
         VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
-        vmxnet3_validate_interrupt_idx(s->msix_used, idx);
+        if (!vmxnet3_validate_irq_idx("RX", s->msix_used, idx)) {
+            return false;
+        }
     }
+
+    return true;
 }
 
 static bool vmxnet3_validate_queues(VMXNET3State *s)
@@ -1554,7 +1568,10 @@ static void vmxnet3_activate_device(VMXNET3State *s)
                sizeof(s->rxq_descr[i].rxq_stats));
     }
 
-    vmxnet3_validate_interrupts(s);
+    if (!vmxnet3_validate_interrupts(s)) {
+        vmxnet3_reset(s);
+        return;
+    }
 
     /* Make sure everything is in place before device activation */
     smp_wmb();
@@ -2392,7 +2409,9 @@ static int vmxnet3_post_load(void *opaque, int version_id)
     if (!vmxnet3_validate_queues(s)) {
         return -1;
     }
-    vmxnet3_validate_interrupts(s);
+    if (!vmxnet3_validate_interrupts(s)) {
+        return -1;
+    }
 
     return 0;
 }
-- 
2.55.0


