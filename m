Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82EEE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVq5s-0005by-Or; Thu, 09 Jan 2025 05:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2ecee9f010fd6b9329bb+7809+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tVq5r-0005ac-3g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:48:51 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2ecee9f010fd6b9329bb+7809+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tVq5n-0007D7-6j
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=vkYWy2UhqqfIxeBbSu9rEpmWmg4bzXUsfNCiAI/hJbQ=; b=WMncyuM7tFCD8zw4gJ3uK8tykI
 AhNVf8Y/w4l1Hxf9lk/MB0ZUxpBc33OijIjoIxDzohMqj63AmW1tHRd8IVMEYRLVyO62UQGV7tdny
 FD6VswlZ2GMACFgbgUpJQPIkbIJZ6uiWijFLIeFGIunyFL4nDYIF63ZGNr5QYkPBILjokckAP+5Oz
 G+znzsUYUklJivlehGIBkGu2yb+PkkMk5UjoWUxA0ktxhDqiIBIiNKmcm9V+jzgB8gZNpKeEgDWTK
 Iji9Xgmjeqb2lqoXYN4iecBuZX9j5jAZKJP/0S0wLgFuQMfSMkPjSewrRFUw038fRPg+0Eq1Rkgsr
 2MNOCS1w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVq5f-00000009Y3w-3BhF; Thu, 09 Jan 2025 10:48:40 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tVq5e-0000000Acl3-07No; Thu, 09 Jan 2025 10:48:38 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 1/2] hw/i386/pc: Fix level interrupt sharing for Xen event
 channel GSI
Date: Thu,  9 Jan 2025 10:48:36 +0000
Message-ID: <20250109104837.2532259-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250109104837.2532259-1-dwmw2@infradead.org>
References: <20250109104837.2532259-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+2ecee9f010fd6b9329bb+7809+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

The system GSIs are not designed for sharing. One device might assert a
shared interrupt with qemu_set_irq() and another might deassert it, and
the level from the first device is lost.

This could be solved by refactoring the x86 GSI code to use an OrIrq
device, but that still wouldn't be ideal.

The best answer would be to have a 'resample' callback which is invoked
when the interrupt is acked at the interrupt controller, and causes the
devices to re-trigger the interrupt if it should still be pending. This
is the model that VFIO in Linux uses, with a 'resampler' eventfd that
actually unmasks the interrupt on the hardware device and thus triggers
a new interrupt from it if needed.

As things stand, QEMU currently doesn't use that VFIO interface
correctly, and just bashes on the resampler for every MMIO access to the
device "just in case". Which requires unmapping and trapping the MMIO
while an interrupt is pending!

For the Xen callback GSI, QEMU does something similar — a flag is set
which triggers a poll on *every* vmexst to see if the GSI should be
deasserted.

Proper resampler support would solve all of that, but is a task for
later which has already been on the TODO list for a while.

Since the Xen event channel GSI support *already* has hooks into the PC
gsi_handler() code for routing GSIs to PIRQs, we can use that for a
simpler bug fix.

So... remember the externally-driven state of the line (from e.g. PCI
INTx) and set the logical OR of that with the GSI. As a bonus, we now
only need to enable the polling of vcpu_info on vmexit if the Xen
callback GSI is the *only* reason the corresponding line is asserted.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2731
Fixes: ddf0fd9ae1fd ("hw/xen: Support HVM_PARAM_CALLBACK_TYPE_GSI callback")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/kvm/xen_evtchn.c | 60 +++++++++++++++++++++++++++++++---------
 hw/i386/kvm/xen_evtchn.h |  2 +-
 hw/i386/x86-common.c     | 32 +++++++++++++--------
 3 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index bd2a3cbee0..58484f308e 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -140,6 +140,8 @@ struct XenEvtchnState {
 
     uint64_t callback_param;
     bool evtchn_in_kernel;
+    bool setting_callback_gsi;
+    int extern_gsi_level;
     uint32_t callback_gsi;
 
     QEMUBH *gsi_bh;
@@ -431,9 +433,22 @@ void xen_evtchn_set_callback_level(int level)
     }
 
     if (s->callback_gsi && s->callback_gsi < s->nr_callback_gsis) {
-        qemu_set_irq(s->callback_gsis[s->callback_gsi], level);
-        if (level) {
-            /* Ensure the vCPU polls for deassertion */
+        /*
+         * Ugly, but since we hold the BQL we can set this flag so that
+         * xen_evtchn_set_gsi() can tell the difference between this code
+         * setting the GSI, and an external device (PCI INTx) doing so.
+         */
+        s->setting_callback_gsi = true;
+        /* Do not deassert the line if an external device is asserting it. */
+        qemu_set_irq(s->callback_gsis[s->callback_gsi],
+                     level || s->extern_gsi_level);
+        s->setting_callback_gsi = false;
+
+        /*
+         * If the callback GSI is the only one asserted, ensure the status
+         * is polled for deassertion in kvm_arch_post_run().
+         */
+        if (level && !s->extern_gsi_level) {
             kvm_xen_set_callback_asserted();
         }
     }
@@ -1596,7 +1611,7 @@ static int allocate_pirq(XenEvtchnState *s, int type, int gsi)
     return pirq;
 }
 
-bool xen_evtchn_set_gsi(int gsi, int level)
+bool xen_evtchn_set_gsi(int gsi, int *level)
 {
     XenEvtchnState *s = xen_evtchn_singleton;
     int pirq;
@@ -1608,16 +1623,35 @@ bool xen_evtchn_set_gsi(int gsi, int level)
     }
 
     /*
-     * Check that that it *isn't* the event channel GSI, and thus
-     * that we are not recursing and it's safe to take s->port_lock.
-     *
-     * Locking aside, it's perfectly sane to bail out early for that
-     * special case, as it would make no sense for the event channel
-     * GSI to be routed back to event channels, when the delivery
-     * method is to raise the GSI... that recursion wouldn't *just*
-     * be a locking issue.
+     * For the callback_gsi we need to implement a logical OR of the event
+     * channel GSI and the external input (e.g. from PCI INTx), because
+     * QEMU itself doesn't support shared level interrupts via demux or
+     * resamplers.
      */
     if (gsi && gsi == s->callback_gsi) {
+        /* Remember the external state of the GSI pin (e.g. from PCI INTx) */
+        if (!s->setting_callback_gsi) {
+            s->extern_gsi_level = *level;
+
+            /*
+             * Don't allow the external device to deassert the line if the
+             * eveht channel GSI should still be asserted.
+             */
+            if (!s->extern_gsi_level) {
+                struct vcpu_info *vi = kvm_xen_get_vcpu_info_hva(0);
+                if (vi && vi->evtchn_upcall_pending) {
+                    /* Need to poll for deassertion */
+                    kvm_xen_set_callback_asserted();
+                    *level = 1;
+                }
+            }
+        }
+
+        /*
+         * The event channel GSI cannot be routed to PIRQ, as that would make
+         * no sense. It could also deadlock on s->port_lock, if we proceed.
+         * So bail out now.
+         */
         return false;
     }
 
@@ -1628,7 +1662,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
         return false;
     }
 
-    if (level) {
+    if (*level) {
         int port = s->pirq[pirq].port;
 
         s->pirq_gsi_set |= (1U << gsi);
diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
index b740acfc0d..0521ebc092 100644
--- a/hw/i386/kvm/xen_evtchn.h
+++ b/hw/i386/kvm/xen_evtchn.h
@@ -23,7 +23,7 @@ void xen_evtchn_set_callback_level(int level);
 
 int xen_evtchn_set_port(uint16_t port);
 
-bool xen_evtchn_set_gsi(int gsi, int level);
+bool xen_evtchn_set_gsi(int gsi, int *level);
 void xen_evtchn_snoop_msi(PCIDevice *dev, bool is_msix, unsigned int vector,
                           uint64_t addr, uint32_t data, bool is_masked);
 void xen_evtchn_remove_pci_device(PCIDevice *dev);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index a7d46c3105..97b4f7d4a0 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -450,8 +450,27 @@ static long get_file_size(FILE *f)
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s = opaque;
+    bool bypass_ioapic = false;
 
     trace_x86_gsi_interrupt(n, level);
+
+#ifdef CONFIG_XEN_EMU
+    /*
+     * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
+     * routing actually works properly under Xen). And then to
+     * *either* the PIRQ handling or the I/OAPIC depending on whether
+     * the former wants it.
+     *
+     * Additionally, this hook allows the Xen event channel GSI to
+     * work around QEMU's lack of support for shared level interrupts,
+     * by keeping track of the externally driven state of the pin and
+     * implementing a logical OR with the state of the evtchn GSI.
+     */
+    if (xen_mode == XEN_EMULATE) {
+        bypass_ioapic = xen_evtchn_set_gsi(n, &level);
+    }
+#endif
+
     switch (n) {
     case 0 ... ISA_NUM_IRQS - 1:
         if (s->i8259_irq[n]) {
@@ -460,18 +479,9 @@ void gsi_handler(void *opaque, int n, int level)
         }
         /* fall through */
     case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
-#ifdef CONFIG_XEN_EMU
-        /*
-         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
-         * routing actually works properly under Xen). And then to
-         * *either* the PIRQ handling or the I/OAPIC depending on
-         * whether the former wants it.
-         */
-        if (xen_mode == XEN_EMULATE && xen_evtchn_set_gsi(n, level)) {
-            break;
+        if (!bypass_ioapic) {
+            qemu_set_irq(s->ioapic_irq[n], level);
         }
-#endif
-        qemu_set_irq(s->ioapic_irq[n], level);
         break;
     case IO_APIC_SECONDARY_IRQBASE
         ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:
-- 
2.47.0


