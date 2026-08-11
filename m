Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EC6C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNC-00089m-Iu; Tue, 11 Aug 2026 12:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMk-0007ja-7Q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMc-0000OX-Q1
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UnyU94Ae4xONNurkFUzKF7PKYfESPwdSglcOWgIfziE=;
 b=M0vy1T/T0Z7LM7nwXIFbKgF7DDGQ+eoKV9jalgOYJfviBeSVLgWLPFmH6ENLTQ9q2BnKio
 98Vd0LqFYYtiUoQPZqv0zVNWEm/FiHNwvlyyY968NruS+5uHhY2dlrys9a13sN8oBe0O2B
 56i5MHm7eryWfCIo1hclCyIiJ9429DQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-MDLgq7nWMYivdgmwHu6VuQ-1; Tue,
 11 Aug 2026 12:30:02 -0400
X-MC-Unique: MDLgq7nWMYivdgmwHu6VuQ-1
X-Mimecast-MFC-AGG-ID: MDLgq7nWMYivdgmwHu6VuQ_1786465801
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 291381956089; Tue, 11 Aug 2026 16:30:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70C9F195DF91; Tue, 11 Aug 2026 16:29:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/83] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Date: Tue, 11 Aug 2026 18:28:23 +0200
Message-ID: <20260811162938.1403216-9-clg@redhat.com>
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

EHCI supports 64-bit control data structure addressing when the
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,
the CTRLDSSEGMENT register provides the upper 32 bits that are
concatenated with 32-bit link pointer values to form full 64-bit
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).

iTD link pointers are stored as 32-bit values and must be expanded
to full 64-bit descriptor addresses when 64-bit mode is enabled.
Update the iTD traversal path to use ehci_get_desc_addr() when
following link pointers.

Appendix B also defines high dword fields for iTD buffer pointers.
Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct
full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields
when processing isochronous transfers. This allows buffers above
4GB to be handled correctly.

When 64-bit capability is disabled, descriptor and buffer addresses
remain 32-bit and existing behaviour is unchanged.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.h |  1 +
 hw/usb/hcd-ehci.c | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 7fed20690683..49176f3fd282 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -63,6 +63,7 @@ typedef struct EHCIitd {
 #define ITD_BUFPTR_MAXPKT_SH     0
 #define ITD_BUFPTR_MULT_MASK     0x00000003
 #define ITD_BUFPTR_MULT_SH       0
+    uint32_t bufptr_hi[7];
 } EHCIitd;
 
 /*
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 947af86ac420..1a286c32e690 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -105,6 +105,7 @@ typedef enum {
  */
 #define EHCI_QH_DWORDS_32   (offsetof(EHCIqh, bufptr_hi) / sizeof(uint32_t))
 #define EHCI_QTD_DWORDS_32  (offsetof(EHCIqtd, bufptr_hi) / sizeof(uint32_t))
+#define EHCI_ITD_DWORDS_32  (offsetof(EHCIitd, bufptr_hi) / sizeof(uint32_t))
 
 static const char *ehci_state_names[] = {
     [EST_INACTIVE]     = "INACTIVE",
@@ -184,6 +185,11 @@ static uint32_t ehci_qtd_dwords(const EHCIState *s)
     return s->caps_64bit_addr ? (sizeof(EHCIqtd) >> 2) : EHCI_QTD_DWORDS_32;
 }
 
+static uint32_t ehci_itd_dwords(const EHCIState *s)
+{
+    return s->caps_64bit_addr ? (sizeof(EHCIitd) >> 2) : EHCI_ITD_DWORDS_32;
+}
+
 static void ehci_trace_usbsts(uint32_t mask, int state)
 {
     /* interrupts */
@@ -1486,7 +1492,8 @@ static int ehci_process_itd(EHCIState *ehci,
                 return -1;
             }
 
-            ptr1 = (itd->bufptr[pg] & ITD_BUFPTR_MASK);
+            ptr1 = ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);
             if (off + len > 4096) {
                 /* transfer crosses page border */
@@ -1494,7 +1501,9 @@ static int ehci_process_itd(EHCIState *ehci,
                     qemu_sglist_destroy(&ehci->isgl);
                     return -1;  /* avoid page pg + 1 */
                 }
-                ptr2 = (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);
+                ptr2 = ehci_get_buf_addr(ehci, itd->bufptr_hi[pg + 1],
+                                         itd->bufptr[pg + 1],
+                                         ITD_BUFPTR_MASK);
                 uint32_t len2 = off + len - 4096;
                 uint32_t len1 = len - len2;
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);
@@ -1774,8 +1783,9 @@ static int ehci_state_fetchitd(EHCIState *ehci, int async)
     assert(!async);
     entry = ehci_get_fetch_addr(ehci, async);
 
+    memset(&itd, 0, sizeof(itd));
     if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,
-                   sizeof(EHCIitd) >> 2) < 0) {
+                   ehci_itd_dwords(ehci)) < 0) {
         return -1;
     }
     ehci_trace_itd(ehci, entry, &itd);
@@ -1785,8 +1795,8 @@ static int ehci_state_fetchitd(EHCIState *ehci, int async)
     }
 
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,
-               sizeof(EHCIitd) >> 2);
-    ehci_set_fetch_addr(ehci, async, itd.next);
+               ehci_itd_dwords(ehci));
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));
     ehci_set_state(ehci, async, EST_FETCHENTRY);
 
     return 1;
-- 
2.55.0


