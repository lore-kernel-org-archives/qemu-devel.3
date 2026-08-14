Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A3C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuorB-0002aE-TZ; Fri, 14 Aug 2026 06:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuor6-0002ZO-B3
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuor2-0001iX-Dv
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786702175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjtLSYFnFZ7LjtaY6dnlUcg+NDfdXxsRAcuTbxUkWCA=;
 b=QVyip7HZvKKYyxFO7R1oiJfvzL4LpVIlpl+OCedxqVdMMxciXaSI7zPXQaWFg7hy1XlTTj
 1+IdxEiiXZAo9by3U5o0GSpoujESPboUdwfLxQcb1OVOfNDfiu7y39rvMA7LXpM5CAahf+
 O120k93AD5VMqVJkSp7Pr/QqilLLTbk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-rDjQeXcpPwS19SFsamrYkA-1; Fri,
 14 Aug 2026 06:09:31 -0400
X-MC-Unique: rDjQeXcpPwS19SFsamrYkA-1
X-Mimecast-MFC-AGG-ID: rDjQeXcpPwS19SFsamrYkA_1786702170
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95DED1800637; Fri, 14 Aug 2026 10:09:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A933422; Fri, 14 Aug 2026 10:09:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 5/6] hw/net/vmxnet3: Do not abort if guest provides bad
 interrupt numbers
Date: Fri, 14 Aug 2026 12:09:16 +0200
Message-ID: <20260814100917.163448-6-thuth@redhat.com>
In-Reply-To: <20260814100917.163448-1-thuth@redhat.com>
References: <20260814100917.163448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

vmxnet3_validate_interrupts() currently aborts via hw_error() if
the guest provided bad interrupt numbers. This should not happen,
QEMU should rather refuse to activate the device in this case instead.
Thus propagate the error to the callers to handle it more gracefully
there.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/539
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260731113352.189066-1-thuth@redhat.com>
---
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


