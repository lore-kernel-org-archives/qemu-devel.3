Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878D5C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllOo-0003mv-8E; Mon, 20 Jul 2026 06:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOm-0003mP-4Y
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOk-0008IJ-LV
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784543938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+FPfCzpRA13rUQiz7x4b9yGDzYKNxGYMOHyt30DAOI=;
 b=i2qu6vEjl2MWiqHMwrtVIJjJmsVMefdpL6Q1dA//rj6BVwxktj2xdeKCh3RcYuiOzkDZX9
 3jMhKeHHm7ECW75tBO0HPHWbZvJm4iDPmDIftA/ZQc6q/JGmwXGzdqnSlm4mfC+iVr7GNL
 Ylo2XPTqo5SZd2Bp5mrh0eA51nAbrdw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-QwL3aHqjOvOSYRr307xMfw-1; Mon,
 20 Jul 2026 06:38:53 -0400
X-MC-Unique: QwL3aHqjOvOSYRr307xMfw-1
X-Mimecast-MFC-AGG-ID: QwL3aHqjOvOSYRr307xMfw_1784543932
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 951301802575; Mon, 20 Jul 2026 10:38:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7F6C1588; Mon, 20 Jul 2026 10:38:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Tristan Madani <tristan@talencesecurity.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/7] hw/usb/hcd-xhci-sysbus: Fix OOB heap access in
 xhci_sysbus_intr_raise()
Date: Mon, 20 Jul 2026 12:38:33 +0200
Message-ID: <20260720103833.364506-8-thuth@redhat.com>
In-Reply-To: <20260720103833.364506-1-thuth@redhat.com>
References: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Some machines like the microvm machine instantiate a "sysbus-xhci"
device with just 1 interrupt (by setting the "intrs" property to 1).
xhci_sysbus_realize() then only allocates the s->irq array with one
entry.

When the guest writes to the ERDP register of a corresponding XHCI
"interrupter", the generic XHCI code calls the xhci_sysbus_intr_raise()
function with n > 1, and this function then calls qemu_set_irq() with
s->irq[n] pointing to a bad heap address. The qemu_set_irq() then tries
to call an IRQ handler via a function pointer in that heap space. This
either causes QEMU to die with a segmentation fault (if it's a bad
address), or even worse runs some unexpected code if the destination
of the pointer is executable code.

Looking at the xHCI spec, it is up to the implementation of the host
controller how many interrupters are available. So if we only support
one or some few interrupters, the registers of the other interrupters
should not do anything, i.e. reads should result in zeros and writes
should be completely ignored. (big thanks to Peter Maydell for helping
with the analyzation of the correct way to fix this here)

This way, the xhci_sysbus_intr_raise() function cannot be called with
an invalid interrupt number anymore. But for good measure, also add an
assert() statement to the xhci_sysbus_intr_raise() function to prevent
that similar problems with calling arbitrary function pointers on the
heap could occur again.

Fixes: CVE-2026-16043
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4001
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260719061528.15587-1-thuth@redhat.com>
---
 hw/usb/hcd-xhci-sysbus.c |  1 +
 hw/usb/hcd-xhci.c        | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 19664c5985e..bbdd5fd64ab 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -20,6 +20,7 @@ static bool xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
 {
     XHCISysbusState *s = container_of(xhci, XHCISysbusState, xhci);
 
+    assert(n < xhci->numintrs);
     qemu_set_irq(s->irq[n], level);
 
     return false;
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b94249993a1..569386b8cf1 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3044,6 +3044,12 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
         }
     } else {
         int v = (reg - 0x20) / 0x20;
+
+        if (v >= xhci->numintrs) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "xhci: read from nonexistent interrupter %i\n", v);
+            goto out_trace;
+        }
         XHCIInterrupter *intr = &xhci->intr[v];
         switch (reg & 0x1f) {
         case 0x00: /* IMAN */
@@ -3070,6 +3076,7 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
         }
     }
 
+out_trace:
     trace_usb_xhci_runtime_read(reg, ret);
     return ret;
 }
@@ -3087,7 +3094,13 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
         trace_usb_xhci_unimplemented("runtime write", reg);
         return;
     }
+
     v = (reg - 0x20) / 0x20;
+    if (v >= xhci->numintrs) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "xhci: write to nonexistent interrupter %i\n", v);
+        return;
+    }
     intr = &xhci->intr[v];
 
     switch (reg & 0x1f) {
-- 
2.55.0


