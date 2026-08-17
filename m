Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FA6C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxWl-0006F9-2y; Mon, 17 Aug 2026 09:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWa-0005sj-9z; Mon, 17 Aug 2026 09:37:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWY-0007W3-Cg; Mon, 17 Aug 2026 09:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=KMUgJ4sxsfcbYiy/tXF8P4uKaKSoFRZAMvYxhW1rKa8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D0vBGTDnePRMGDiCcrnK5JKEcXRGCcSYE9G98jAl5rDWu1UAqSlKFiqeXM00KzFTS
 mJLrpF8txcJ9G5+Ad+wckTsXUbQ2KgP3NZ2N9RLbAvO4qmDJOFv0S5kkqNF6tOW+8X
 D/KVsgRiAD8hDovN7SJWXPqVY/JZd14MzJcGHkG0B9mFQkEmUMcro2tWRYfT0kSOe4
 Eir4RZZNLu4G5thncE/redOvMAQiIIRm/Ef+0Pq4xHyBoAaVrS05muH4l59IuSeq62
 9qn7wleSQwD9rZ+tO2yo+/8LO/7I6TvuW3CFca5C96C9JVhI6RweYroWWh5h79i7yS
 K2+LkVgaadl0g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 630B61CBCCA;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D19640D427;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C4A3930F9E; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 123/135] hw/net/vmxnet3: Do not abort if guest
 provides bad interrupt numbers
Date: Mon, 17 Aug 2026 16:34:33 +0300
Message-ID: <20260817133451.2384630-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

vmxnet3_validate_interrupts() currently aborts via hw_error() if
the guest provided bad interrupt numbers. This should not happen,
QEMU should rather refuse to activate the device in this case instead.
Thus propagate the error to the callers to handle it more gracefully
there.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/539
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260731113352.189066-1-thuth@redhat.com>
(cherry picked from commit 46099d99005588b25eb07957cd9cdd688c4fc476)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index c15e179fb44..30a178d34e9 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1352,32 +1352,46 @@ static bool vmxnet3_verify_intx(VMXNET3State *s, int intx)
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
@@ -1570,7 +1584,9 @@ static void vmxnet3_activate_device(VMXNET3State *s)
                sizeof(s->rxq_descr[i].rxq_stats));
     }
 
-    vmxnet3_validate_interrupts(s);
+    if (!vmxnet3_validate_interrupts(s)) {
+        return;
+    }
 
     /* Make sure everything is in place before device activation */
     smp_wmb();
@@ -2407,7 +2423,9 @@ static int vmxnet3_post_load(void *opaque, int version_id)
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
2.47.3


