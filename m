Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F74C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wplV8-00051m-JB; Fri, 31 Jul 2026 07:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wplV7-0004vk-2K
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wplV5-0006Hw-9i
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785497642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gXno4CS/Z2dWiaqV+3BXRB8Eg/LH+nYa+5Inv2DzgM4=;
 b=Ij/Us9w+3SlRw5BjNJbr3/JpSmn2IHx4FY1a4Rp7A1OP3YzIPnSGOK5GvOTL3fhgfAo/6Q
 FXGxlruUHLxpmGCTBBnoSOGABR2bxpQz8wZziXuG0IMyvBDN4LRZ0giMbyyvhgSy92t/IS
 yOoiKCKfnkwDw+WOSRFpwyeF1wZUh+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-PfChcI9rOnWXMAsZL5ikHw-1; Fri,
 31 Jul 2026 07:33:58 -0400
X-MC-Unique: PfChcI9rOnWXMAsZL5ikHw-1
X-Mimecast-MFC-AGG-ID: PfChcI9rOnWXMAsZL5ikHw_1785497637
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 706991800473; Fri, 31 Jul 2026 11:33:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.110])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B73CB19560AB; Fri, 31 Jul 2026 11:33:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2] hw/net/vmxnet3: Do not abort if guest provides bad
 interrupt numbers
Date: Fri, 31 Jul 2026 13:33:52 +0200
Message-ID: <20260731113352.189066-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

vmxnet3_validate_interrupts() currently aborts via hw_error() if
the guest provided bad interrupt numbers. This should not happen,
QEMU should rather refuse to activate the device in this case instead.
Thus propagate the error to the callers to handle it more gracefully
there.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/539
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Drop the unnecessary vmxnet3_reset()

 hw/net/vmxnet3.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 8569484b2f2..24c551a0547 100644
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
@@ -1554,7 +1568,9 @@ static void vmxnet3_activate_device(VMXNET3State *s)
                sizeof(s->rxq_descr[i].rxq_stats));
     }
 
-    vmxnet3_validate_interrupts(s);
+    if (!vmxnet3_validate_interrupts(s)) {
+        return;
+    }
 
     /* Make sure everything is in place before device activation */
     smp_wmb();
@@ -2392,7 +2408,9 @@ static int vmxnet3_post_load(void *opaque, int version_id)
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


