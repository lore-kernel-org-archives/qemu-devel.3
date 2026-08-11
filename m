Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC0AC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpN5-0007yJ-2Y; Tue, 11 Aug 2026 12:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMg-0007bB-Bs
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMc-0000MZ-37
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPxGtRNr3fYOBt7plEGuWt4NL/AQd7NEoF8zlsC6QbY=;
 b=KzZRQ643j1nssFxNvvofB58xE5RdYdInzfxm8Bh71DwZnIqifdg0er5X7KR2qoUO6RwN6a
 q6q7W/eByiZDzHY+YzRh4XljtfuNI+SHpZdXe/oN6PM0wOStk6yN2kjuSwL6i4Rd/X8IZE
 MPz9ICEp1xbHQ0NDrGiuVT0yCoPlvIc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-OfWE0DfwNJ2XEnjc7sSJeg-1; Tue,
 11 Aug 2026 12:30:00 -0400
X-MC-Unique: OfWE0DfwNJ2XEnjc7sSJeg-1
X-Mimecast-MFC-AGG-ID: OfWE0DfwNJ2XEnjc7sSJeg_1786465799
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 016191956045; Tue, 11 Aug 2026 16:29:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E21E0195DF91; Tue, 11 Aug 2026 16:29:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/83] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Date: Tue, 11 Aug 2026 18:28:22 +0200
Message-ID: <20260811162938.1403216-8-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

EHCI supports 64-bit addressing when the 64-bit Addressing Capability
bit in HCCPARAMS is set. In that mode, the CTRLDSSEGMENT register
provides the upper 32 bits that are concatenated with 32-bit link
pointer values to form 64-bit control data structure addresses
(EHCI 1.0, section 2.3.5 and Appendix B).

qTD link pointers (current_qtd/next_qtd/altnext_qtd and qTD.next)
are stored as 32-bit values in the data structures and must be
expanded to full 64-bit descriptor addresses when 64-bit mode is
enabled. Update the qTD traversal paths to use ehci_get_desc_addr()
when following link pointers.

Appendix B also defines high dword fields for qTD buffer pointers.
Add bufptr_hi[5] to EHCIqtd and extend qTD fetch and QH overlay
handling to load and propagate the high buffer pointer fields.

When 64-bit capability is disabled, descriptor and buffer addresses
remain 32-bit and existing behaviour is unchanged.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.h |  1 +
 hw/usb/hcd-ehci.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 8732264fdebb..7fed20690683 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -139,6 +139,7 @@ typedef struct EHCIqtd {
     uint32_t bufptr[5];               /* Standard buffer pointer */
 #define QTD_BUFPTR_MASK               0xfffff000
 #define QTD_BUFPTR_SH                 12
+    uint32_t bufptr_hi[5];
 } EHCIqtd;
 
 /* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index fd5be7430ef6..947af86ac420 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -104,6 +104,7 @@ typedef enum {
  * must not read or write past that boundary.
  */
 #define EHCI_QH_DWORDS_32   (offsetof(EHCIqh, bufptr_hi) / sizeof(uint32_t))
+#define EHCI_QTD_DWORDS_32  (offsetof(EHCIqtd, bufptr_hi) / sizeof(uint32_t))
 
 static const char *ehci_state_names[] = {
     [EST_INACTIVE]     = "INACTIVE",
@@ -178,6 +179,11 @@ static uint32_t ehci_qh_dwords(const EHCIState *s)
     return s->caps_64bit_addr ? (sizeof(EHCIqh) >> 2) : EHCI_QH_DWORDS_32;
 }
 
+static uint32_t ehci_qtd_dwords(const EHCIState *s)
+{
+    return s->caps_64bit_addr ? (sizeof(EHCIqtd) >> 2) : EHCI_QTD_DWORDS_32;
+}
+
 static void ehci_trace_usbsts(uint32_t mask, int state)
 {
     /* interrupts */
@@ -486,7 +492,8 @@ static bool ehci_verify_qtd(EHCIPacket *p, EHCIqtd *qtd)
             (p->qtd.next != qtd->next)) ||
         (!NLPTR_TBIT(p->qtd.altnext) && (p->qtd.altnext != qtd->altnext)) ||
         p->qtd.token != qtd->token ||
-        p->qtd.bufptr[0] != qtd->bufptr[0]) {
+        p->qtd.bufptr[0] != qtd->bufptr[0] ||
+        p->qtd.bufptr_hi[0] != qtd->bufptr_hi[0]) {
         return false;
     } else {
         return true;
@@ -519,10 +526,11 @@ static void ehci_writeback_async_complete_packet(EHCIPacket *p)
 
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchqtd */
     memset(&qh, 0, sizeof(qh));
+    memset(&qtd, 0, sizeof(qtd));
     get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
                (uint32_t *) &qh, ehci_qh_dwords(q->ehci));
     get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
-               (uint32_t *) &qtd, sizeof(EHCIqtd) >> 2);
+               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));
     if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
         p->async = EHCI_ASYNC_INITIALIZED;
         ehci_free_packet(p);
@@ -1215,6 +1223,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)
 
     for (i = 0; i < 5; i++) {
         q->qh.bufptr[i] = p->qtd.bufptr[i];
+        q->qh.bufptr_hi[i] = p->qtd.bufptr_hi[i];
     }
 
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {
@@ -1248,7 +1257,8 @@ static int ehci_init_transfer(EHCIPacket *p)
             return -1;
         }
 
-        page  = p->qtd.bufptr[cpage] & QTD_BUFPTR_MASK;
+        page = ehci_get_buf_addr(p->queue->ehci, p->qtd.bufptr_hi[cpage],
+                                 p->qtd.bufptr[cpage], QTD_BUFPTR_MASK);
         page += offset;
         plen  = bytes;
         if (plen > 4096 - offset) {
@@ -1744,7 +1754,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&
                (NLPTR_TBIT(q->qh.current_qtd) == 0) &&
                (q->qh.current_qtd != 0)) {
-        q->qtdaddr = q->qh.current_qtd;
+        q->qtdaddr = ehci_get_desc_addr(ehci, q->qh.current_qtd);
         ehci_set_state(ehci, async, EST_FETCHQTD);
 
     } else {
@@ -1822,14 +1832,14 @@ static int ehci_state_advqueue(EHCIQueue *q)
      */
     if (((q->qh.token & QTD_TOKEN_TBYTES_MASK) != 0) &&
         (NLPTR_TBIT(q->qh.altnext_qtd) == 0)) {
-        q->qtdaddr = q->qh.altnext_qtd;
+        q->qtdaddr = ehci_get_desc_addr(q->ehci, q->qh.altnext_qtd);
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);
 
     /*
      *  next qTD is valid
      */
     } else if (NLPTR_TBIT(q->qh.next_qtd) == 0) {
-        q->qtdaddr = q->qh.next_qtd;
+        q->qtdaddr = ehci_get_desc_addr(q->ehci, q->qh.next_qtd);
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);
 
     /*
@@ -1855,10 +1865,14 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
         return 0;
     }
     barrier();
+    memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));
     if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||
         get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||
         get_dwords(q->ehci, addr + 12, qtd.bufptr,
-                   ARRAY_SIZE(qtd.bufptr)) < 0) {
+                   ARRAY_SIZE(qtd.bufptr)) < 0 ||
+        (q->ehci->caps_64bit_addr &&
+         get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),
+                    qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)) < 0)) {
         return 0;
     }
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);
@@ -1939,7 +1953,7 @@ static int ehci_fill_queue(EHCIPacket *p)
         if (NLPTR_TBIT(qtd.next) != 0) {
             break;
         }
-        qtdaddr = qtd.next;
+        qtdaddr = ehci_get_desc_addr(q->ehci, qtd.next);
         /*
          * Detect circular td lists, Windows creates these, counting on the
          * active bit going low after execution to make the queue stop.
@@ -1949,8 +1963,9 @@ static int ehci_fill_queue(EHCIPacket *p)
                 goto leave;
             }
         }
+        memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));
         if (get_dwords(q->ehci, NLPTR_GET(qtdaddr),
-                       (uint32_t *) &qtd, sizeof(EHCIqtd) >> 2) < 0) {
+                       (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0) {
             return -1;
         }
         ehci_trace_qtd(q, NLPTR_GET(qtdaddr), &qtd);
-- 
2.55.0


