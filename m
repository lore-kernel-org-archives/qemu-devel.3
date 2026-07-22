Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392C9C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWWb-0007WJ-Lq; Wed, 22 Jul 2026 08:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWTd-0000RD-4U; Wed, 22 Jul 2026 08:55:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWTa-0003Hv-Nv; Wed, 22 Jul 2026 08:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=ciUVdr1UHOMmCW4OVi0Afi/9AsRQTVSYD4k5011q3So=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oIt9M32Z+fA0ALu5OTM9/1hSMOHDpMpZh/JtA5Q25DMIOsIMmvE5IhFfPLN4iGT5w
 hkFyi3GyfUbKZpxD/MAWOAxlI9RPyma0mgBNzNgUw5WIwKlZ5Pf6Ns2nH5386tB/XZ
 sRt9uRS/fzudk1e3rdIPa0HfnmgM8uTgO59OtwU2I6Ey1jwpuYqyIRO78l7RqGRUM7
 lXdMAT5vDEZzWg47Hfot8n26tMYYy/8xQzzmshr5A6ai0ErlH0mKRlEM/7+NlTwrg/
 3/Ji1ZwmzwJ4f04fbYFUBsQClIdgrDazcL3jO9erk31r6wH38o/ip0DtGlSjC5FEny
 lyg8S1MjSKFgQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5517C1C3B55;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9DF1A3F37A5;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EE69C17F7F; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 120/127] hw/usb/hcd-xhci-sysbus: Fix OOB heap
 access in xhci_sysbus_intr_raise()
Date: Wed, 22 Jul 2026 15:48:45 +0300
Message-ID: <20260722124859.32371-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
(cherry picked from commit cc479aa89743655a725ce29328bcd0585a65983a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
index 4cac4c76a4a..5131d05c6ee 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3047,6 +3047,12 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
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
@@ -3073,6 +3079,7 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
         }
     }
 
+out_trace:
     trace_usb_xhci_runtime_read(reg, ret);
     return ret;
 }
@@ -3090,7 +3097,13 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
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
2.47.3


