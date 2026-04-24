Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FB7FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMAp-0003mc-9y; Fri, 24 Apr 2026 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAn-0003k1-9s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAk-0001au-N1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ad135063so73911585e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058801; x=1777663601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cQYtgOJNWkfs+qrkiY+/t7fLxAFmWUWgMI/v4e5bmLY=;
 b=zxyX3UTJT9IGp7Yz5IKDD4pCL7gdFu53mjciwtC4evigrUN4fFQGb2lQDEwLgTv5U5
 EWkXXdAO9xyQi3ZyTDleet36LafEQBSlr0GNnX0dB+TlcP4wqfMECoLluoBbpurXfsnr
 P01v6nh/c2Bn/RhHF3bJqKJHlrqU5ALB4+BZIP9ImDm/HIsWxaabRRCHNPmSEMY/cPqr
 aRH78um+mInRJCMAINgtdFgJguKrLZ4VVVhUS5spDskFd/CFp2NjhH0n62Bw5fqAOTQc
 6LRPt8DgcnOH4zcCphazc32hGE4CEx29w9tPBEZ/DssiabLlISrioDJhJXZu0A2TJgw9
 zzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058801; x=1777663601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cQYtgOJNWkfs+qrkiY+/t7fLxAFmWUWgMI/v4e5bmLY=;
 b=RIbK3+PT+jti7U2FPaEs8mTCMwQ60LWIi9XuYK9zPorWyrQPW8L+rNB9otIzd3CALK
 z04lXzwFRaSa5T37HMmZkx7hR6o6lXBYl5AqmGZb9ZpURoZD5l0r0iHrV+v+oNTsXRcX
 7Ni7usVtTI1Weg/m5ojG0ImrfQ8ALq6rvetXmJ423P0RJflRECASJYPuIVLfd6R/SBtw
 MiTlJ9okHwnry0id6hGFbDC3l5xbIl8mme7ofcDcJN27ZfNyx58t2ipGEEzl01frjY5M
 Zq1+ayd1d8z+IXzMnR33nEFbi7QNUol8MKQfkQUENapG9yPktUjidXaCLQwTExOFHGqK
 /V3A==
X-Gm-Message-State: AOJu0Yz4Xqz6d/q4JbNJArCchfYviuo6sK6Gb3YPCbdMmpMkhs04Hcev
 MdiFxbhWDWCM2bQVqVr+WgkMOyBW7sHKGsbWMJaD7AsiqolAz8tMLt/YDtm9diF3PLRsKaquy6y
 pwvXlT3A=
X-Gm-Gg: AeBDiet8gB0vOXC4RM2RxfI50uY2UIPmYRTQMt4ntRbl/08OwJU0QUzP/OulTuojSOH
 0WBtzUBNZD6rJ5Kpv/zwIofnxgCIVr5sWK8rvLkfz0Uuz81ezurEam6XauJW+ptoXOySJOxSjHR
 GksgXBPeqG4DDuS4FfbsjghElJ99GOwDFZ/bghpS2L5ChUpeELiY7uSLSa37oxqKqmZq72o289u
 Z+BiiLNIj0NRez0cGfwZKzy9bUSg/IzEpwoSNQ7uotYq6qv0Fpo4dhRbDpGueL+p2kndh4T7Fy9
 h9bvIVpE/Q7B8Mmvvpwxy60W1YCBA0Xdep5FOSrg5H9G+v4TSlfiiR/hR/wXnWskjBOyLeJmNP8
 P6RJB/QcPu1MXe88YueDIT2r/oZiPi9q/LYvaHOyNHXQsF+lgdJC4+OMhi8YLLmdDEG2/Fna7iU
 aS2MHlhMMXb6I72eFWnuVouXyjeUHJgDaXjDXrT6cboeY3lUA+64/WLi5nZvJNK3L61sQjdSGoB
 TSuXrMoQBh2qHy0vDKr3g==
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488fb7923a9mr434667815e9.26.1777058800579; 
 Fri, 24 Apr 2026 12:26:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm1038552865e9.3.2026.04.24.12.26.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 52/62] hw/usb/hcd-ehci.c: Fix coding style issues reported
 by checkpatch
Date: Fri, 24 Apr 2026 21:25:40 +0200
Message-ID: <20260424192543.22614-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260424080508.53992-5-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.c | 129 +++++++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 58 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 23167bf96f3..7e0b767eb9e 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -41,21 +41,23 @@
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
 #define UFRAME_TIMER_NS  (FRAME_TIMER_NS / 8)
 
-#define NB_MAXINTRATE    8        // Max rate at which controller issues ints
-#define BUFF_SIZE        5*4096   // Max bytes to transfer per transaction
-#define MAX_QH           100      // Max allowable queue heads in a chain
+#define NB_MAXINTRATE    8      /* Max rate at which controller issues ints */
+#define BUFF_SIZE        (5 * 4096) /* Max bytes to transfer per transaction */
+#define MAX_QH           100      /* Max allowable queue heads in a chain */
 #define MIN_UFR_PER_TICK 24       /* Min frames to process when catching up */
 #define PERIODIC_ACTIVE  512      /* Micro-frames */
 
-/*  Internal periodic / asynchronous schedule state machine states
+/*
+ * Internal periodic / asynchronous schedule state machine states
  */
 typedef enum {
     EST_INACTIVE = 1000,
     EST_ACTIVE,
     EST_EXECUTING,
     EST_SLEEPING,
-    /*  The following states are internal to the state machine function
-    */
+    /*
+     * The following states are internal to the state machine function
+     */
     EST_WAITLISTHEAD,
     EST_FETCHENTRY,
     EST_FETCHQH,
@@ -71,13 +73,13 @@ typedef enum {
 /* macros for accessing fields within next link pointer entry */
 #define NLPTR_GET(x)             ((x) & 0xffffffe0)
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)
-#define NLPTR_TBIT(x)            ((x) & 1)  // 1=invalid, 0=valid
+#define NLPTR_TBIT(x)            ((x) & 1)  /* 1=invalid, 0=valid */
 
 /* link pointer types */
-#define NLPTR_TYPE_ITD           0     // isoc xfer descriptor
-#define NLPTR_TYPE_QH            1     // queue head
-#define NLPTR_TYPE_STITD         2     // split xaction, isoc xfer descriptor
-#define NLPTR_TYPE_FSTN          3     // frame span traversal node
+#define NLPTR_TYPE_ITD           0     /* isoc xfer descriptor */
+#define NLPTR_TYPE_QH            1     /* queue head */
+#define NLPTR_TYPE_STITD         2     /* split xaction, isoc xfer descriptor */
+#define NLPTR_TYPE_FSTN          3     /* frame span traversal node */
 
 #define SET_LAST_RUN_CLOCK(s) \
     (s)->last_run_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -88,10 +90,10 @@ typedef enum {
 
 #define set_field(data, newval, field) do { \
     uint32_t val = *data; \
-    val &= ~ field##_MASK; \
+    val &= ~field##_MASK; \
     val |= ((newval) << field##_SH) & field##_MASK; \
     *data = val; \
-    } while(0)
+    } while (0)
 
 static const char *ehci_state_names[] = {
     [EST_INACTIVE]     = "INACTIVE",
@@ -472,8 +474,10 @@ static bool ehci_verify_pid(EHCIQueue *q, EHCIqtd *qtd)
     }
 }
 
-/* Finish executing and writeback a packet outside of the regular
-   fetchqh -> fetchqtd -> execute -> writeback cycle */
+/*
+ * Finish executing and writeback a packet outside of the regular
+ * fetchqh -> fetchqtd -> execute -> writeback cycle
+ */
 static void ehci_writeback_async_complete_packet(EHCIPacket *p)
 {
     EHCIQueue *q = p->queue;
@@ -733,7 +737,7 @@ static void ehci_detach(USBPort *port)
     ehci_queues_rip_device(s, port->dev, 0);
     ehci_queues_rip_device(s, port->dev, 1);
 
-    *portsc &= ~(PORTSC_CONNECT|PORTSC_PED|PORTSC_SUSPEND);
+    *portsc &= ~(PORTSC_CONNECT | PORTSC_PED | PORTSC_SUSPEND);
     *portsc |= PORTSC_CSC;
 
     ehci_raise_irq(s, USBSTS_PCD);
@@ -858,7 +862,7 @@ void ehci_reset(void *opaque)
      * Do the detach before touching portsc, so that it correctly gets send to
      * us or to our companion based on PORTSC_POWNER before the reset.
      */
-    for(i = 0; i < EHCI_PORTS; i++) {
+    for (i = 0; i < EHCI_PORTS; i++) {
         devs[i] = s->ports[i].dev;
         if (devs[i] && devs[i]->attached) {
             usb_detach(&s->ports[i]);
@@ -877,7 +881,7 @@ void ehci_reset(void *opaque)
     s->astate = EST_INACTIVE;
     s->pstate = EST_INACTIVE;
 
-    for(i = 0; i < EHCI_PORTS; i++) {
+    for (i = 0; i < EHCI_PORTS; i++) {
         if (s->companion_ports[i]) {
             s->portsc[i] = PORTSC_POWNER | PORTSC_PPOWER;
         } else {
@@ -942,8 +946,9 @@ static void handle_port_owner_write(EHCIState *s, int port, uint32_t owner)
     uint32_t *portsc = &s->portsc[port];
     uint32_t orig;
 
-    if (s->companion_ports[port] == NULL)
+    if (s->companion_ports[port] == NULL) {
         return;
+    }
 
     owner = owner & PORTSC_POWNER;
     orig  = *portsc & PORTSC_POWNER;
@@ -988,7 +993,7 @@ static void ehci_port_write(void *ptr, hwaddr addr,
         trace_usb_ehci_port_reset(port, 1);
     }
 
-    if (!(val & PORTSC_PRESET) &&(*portsc & PORTSC_PRESET)) {
+    if (!(val & PORTSC_PRESET) && (*portsc & PORTSC_PRESET)) {
         trace_usb_ehci_port_reset(port, 0);
         if (dev && dev->attached) {
             usb_port_reset(&s->ports[port]);
@@ -1065,8 +1070,10 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
         break;
 
     case USBSTS:
-        val &= USBSTS_RO_MASK;              // bits 6 through 31 are RO
-        ehci_clear_usbsts(s, val);          // bits 0 through 5 are R/WC
+        /* bits 6 through 31 are RO */
+        val &= USBSTS_RO_MASK;
+        /* bits 0 through 5 are R/WC */
+        ehci_clear_usbsts(s, val);
         val = s->usbsts;
         ehci_update_irq(s);
         break;
@@ -1131,8 +1138,7 @@ static void ehci_flush_qh(EHCIQueue *q)
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);
 }
 
-// 4.10.2
-
+/* 4.10.2 */
 static int ehci_qh_do_overlay(EHCIQueue *q)
 {
     EHCIPacket *p = QTAILQ_FIRST(&q->packets);
@@ -1145,8 +1151,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)
     assert(p != NULL);
     assert(p->qtdaddr == q->qtdaddr);
 
-    // remember values in fields to preserve in qh after overlay
-
+    /*  remember values in fields to preserve in qh after overlay */
     dtoggle = q->qh.token & QTD_TOKEN_DTOGGLE;
     ping    = q->qh.token & QTD_TOKEN_PING;
 
@@ -1170,7 +1175,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)
     }
 
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {
-        // preserve QH DT bit
+        /* preserve QH DT bit */
         q->qh.token &= ~QTD_TOKEN_DTOGGLE;
         q->qh.token |= dtoggle;
     }
@@ -1397,9 +1402,7 @@ static int ehci_execute(EHCIPacket *p, const char *action)
     return 1;
 }
 
-/*  4.7.2
- */
-
+/* 4.7.2 */
 static int ehci_process_itd(EHCIState *ehci,
                             EHCIitd *itd,
                             uint32_t addr)
@@ -1411,13 +1414,13 @@ static int ehci_process_itd(EHCIState *ehci,
 
     ehci->periodic_sched_active = PERIODIC_ACTIVE;
 
-    dir =(itd->bufptr[1] & ITD_BUFPTR_DIRECTION);
+    dir = (itd->bufptr[1] & ITD_BUFPTR_DIRECTION);
     devaddr = get_field(itd->bufptr[0], ITD_BUFPTR_DEVADDR);
     endp = get_field(itd->bufptr[0], ITD_BUFPTR_EP);
     max = get_field(itd->bufptr[1], ITD_BUFPTR_MAXPKT);
     mult = get_field(itd->bufptr[2], ITD_BUFPTR_MULT);
 
-    for(i = 0; i < 8; i++) {
+    for (i = 0; i < 8; i++) {
         if (itd->transact[i] & ITD_XACT_ACTIVE) {
             pg   = get_field(itd->transact[i], ITD_XACT_PGSEL);
             off  = itd->transact[i] & ITD_XACT_OFFSET_MASK;
@@ -1513,8 +1516,9 @@ static int ehci_process_itd(EHCIState *ehci,
 }
 
 
-/*  This state is the entry point for asynchronous schedule
- *  processing.  Entry here constitutes a EHCI start event state (4.8.5)
+/*
+ * This state is the entry point for asynchronous schedule
+ * processing.  Entry here constitutes a EHCI start event state (4.8.5)
  */
 static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
 {
@@ -1531,7 +1535,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
     ehci_queues_rip_unused(ehci, async);
 
     /*  Find the head of the list (4.9.1.1) */
-    for(i = 0; i < MAX_QH; i++) {
+    for (i = 0; i < MAX_QH; i++) {
         if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,
                        sizeof(EHCIqh) >> 2) < 0) {
             return 0;
@@ -1564,8 +1568,9 @@ out:
 }
 
 
-/*  This state is the entry point for periodic schedule processing as
- *  well as being a continuation state for async processing.
+/*
+ * This state is the entry point for periodic schedule processing as
+ * well as being a continuation state for async processing.
  */
 static int ehci_state_fetchentry(EHCIState *ehci, int async)
 {
@@ -1674,7 +1679,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
 
 #if EHCI_DEBUG
     if (q->qhaddr != q->qh.next) {
-    DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",
+        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",
                q->qhaddr,
                q->qh.epchar & QH_EPCHAR_H,
                q->qh.token & QTD_TOKEN_HALT,
@@ -1756,7 +1761,8 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int async)
 /* Section 4.10.2 - paragraph 3 */
 static int ehci_state_advqueue(EHCIQueue *q)
 {
-    /* TO-DO: 4.10.2 - paragraph 2
+    /*
+     * TO-DO: 4.10.2 - paragraph 2
      * if I-bit is set to 1 and QH is not active
      * go to horizontal QH
      */
@@ -1929,8 +1935,10 @@ static int ehci_state_execute(EHCIQueue *q)
         return -1;
     }
 
-    // TODO verify enough time remains in the uframe as in 4.4.1.1
-    // TODO write back ptr to async list when done or out of time
+    /*
+     * TODO verify enough time remains in the uframe as in 4.4.1.1
+     * TODO write back ptr to async list when done or out of time
+     */
 
     /* 4.10.3, bottom of page 82, go horizontal on transaction counter == 0 */
     if (!q->async && q->transact_ctr == 0) {
@@ -2041,7 +2049,7 @@ static void ehci_advance_state(EHCIState *ehci, int async)
     int again;
 
     do {
-        switch(ehci_get_state(ehci, async)) {
+        switch (ehci_get_state(ehci, async)) {
         case EST_WAITLISTHEAD:
             again = ehci_state_waitlisthead(ehci, async);
             break;
@@ -2120,21 +2128,20 @@ static void ehci_advance_state(EHCIState *ehci, int async)
             ehci_reset(ehci);
             again = 0;
         }
-    }
-    while (again);
+    } while (again);
 }
 
 static void ehci_advance_async_state(EHCIState *ehci)
 {
     const int async = 1;
 
-    switch(ehci_get_state(ehci, async)) {
+    switch (ehci_get_state(ehci, async)) {
     case EST_INACTIVE:
         if (!ehci_async_enabled(ehci)) {
             break;
         }
         ehci_set_state(ehci, async, EST_ACTIVE);
-        // No break, fall through to ACTIVE
+        /* No break, fall through to ACTIVE */
 
     case EST_ACTIVE:
         if (!ehci_async_enabled(ehci)) {
@@ -2158,7 +2165,8 @@ static void ehci_advance_async_state(EHCIState *ehci)
         ehci_set_state(ehci, async, EST_WAITLISTHEAD);
         ehci_advance_state(ehci, async);
 
-        /* If the doorbell is set, the guest wants to make a change to the
+        /*
+         * If the doorbell is set, the guest wants to make a change to the
          * schedule. The host controller needs to release cached data.
          * (section 4.8.2)
          */
@@ -2185,13 +2193,13 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
     uint32_t list;
     const int async = 0;
 
-    // 4.6
+    /* 4.6 */
 
-    switch(ehci_get_state(ehci, async)) {
+    switch (ehci_get_state(ehci, async)) {
     case EST_INACTIVE:
         if (!(ehci->frindex & 7) && ehci_periodic_enabled(ehci)) {
             ehci_set_state(ehci, async, EST_ACTIVE);
-            // No break, fall through to ACTIVE
+            /* No break, fall through to ACTIVE */
         } else
             break;
 
@@ -2215,7 +2223,7 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
 
         DPRINTF("PERIODIC state adv fr=%d.  [%08X] -> %08X\n",
                 ehci->frindex / 8, list, entry);
-        ehci_set_fetch_addr(ehci, async,entry);
+        ehci_set_fetch_addr(ehci, async, entry);
         ehci_set_state(ehci, async, EST_FETCHENTRY);
         ehci_advance_state(ehci, async);
         ehci_queues_rip_unused(ehci, async);
@@ -2240,7 +2248,8 @@ static void ehci_update_frindex(EHCIState *ehci, int uframes)
         ehci_raise_irq(ehci, USBSTS_FLR);
     }
 
-    /* How many times will frindex roll over 0x4000 with this frame count?
+    /*
+     * How many times will frindex roll over 0x4000 with this frame count?
      * usbsts_frindex is decremented by 0x4000 on rollover until it reaches 0
      */
     int rollovers = (ehci->frindex + uframes) / 0x4000;
@@ -2320,8 +2329,9 @@ static void ehci_work_bh(void *opaque)
         ehci->async_stepdown++;
     }
 
-    /*  Async is not inside loop since it executes everything it can once
-     *  called
+    /*
+     * Async is not inside loop since it executes everything it can once
+     * called
      */
     if (ehci_async_enabled(ehci) || ehci->astate != EST_INACTIVE) {
         need_timer++;
@@ -2339,15 +2349,18 @@ static void ehci_work_bh(void *opaque)
     }
 
     if (need_timer) {
-        /* If we've raised int, we speed up the timer, so that we quickly
-         * notice any new packets queued up in response */
+        /*
+         * If we've raised int, we speed up the timer, so that we quickly
+         * notice any new packets queued up in response
+         */
         if (ehci->int_req_by_async && (ehci->usbsts & USBSTS_INT)) {
             expire_time = t_now +
                 NANOSECONDS_PER_SECOND / (FRAME_TIMER_FREQ * 4);
             ehci->int_req_by_async = false;
         } else {
-            expire_time = t_now + (NANOSECONDS_PER_SECOND
-                               * (ehci->async_stepdown+1) / FRAME_TIMER_FREQ);
+            expire_time = t_now
+                + (NANOSECONDS_PER_SECOND * (ehci->async_stepdown + 1) /
+                   FRAME_TIMER_FREQ);
         }
         timer_mod(ehci->frame_timer, expire_time);
     }
-- 
2.53.0


