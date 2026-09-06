Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A01EC79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOE-0003O7-5y; Sun, 06 Sep 2026 13:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOC-0003NO-3i
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOA-0008W3-Ak
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kv3mVVGeJ8hmjTURazJxRkFw3SoZ+wFkHNj633syFSo=;
 b=XHpmCTnUOgn96XJEZjX4PKKTf33Ix26killb7zxX3B0p0VE9lNiVDyRheiXpZcBJl532WE
 FisiEtGSehWaTd9DBvns0a9wtzCcxleu8yYkWGNeoYS1RLdPbQ5E+j9EpPZIVMHkx5tKYw
 MdObMqG05R3c5G4ARVmBtjZ2d+Krc04=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-l4EbvW08NKiUCn6LM1jLxg-1; Sun,
 06 Sep 2026 13:10:38 -0400
X-MC-Unique: l4EbvW08NKiUCn6LM1jLxg-1
X-Mimecast-MFC-AGG-ID: l4EbvW08NKiUCn6LM1jLxg_1788714637
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B0131954235; Sun,  6 Sep 2026 17:10:37 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3A181955F06; Sun,  6 Sep 2026 17:10:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/40] hw/usb/hcd-ehci: Make get_dwords() return bool
Date: Sun,  6 Sep 2026 19:09:45 +0200
Message-ID: <20260906171021.26568-5-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

get_dwords() returns the number of dwords it read, but every caller only
tests it for failure and none of them uses the count. Return a plain
bool instead, which matches how the function is actually used.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260817055318.3826428-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index ecf98c4e199f..5187ecc7e4f9 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -416,8 +416,8 @@ static inline bool ehci_periodic_enabled(EHCIState *s)
 }
 
 /* Get an array of dwords from main memory */
-static inline int get_dwords(EHCIState *ehci, uint64_t addr,
-                             uint32_t *buf, int num)
+static inline bool get_dwords(EHCIState *ehci, uint64_t addr,
+                              uint32_t *buf, int num)
 {
     int i;
 
@@ -427,12 +427,12 @@ static inline int get_dwords(EHCIState *ehci, uint64_t addr,
             ehci_raise_irq(ehci, USBSTS_HSE);
             ehci->usbcmd &= ~USBCMD_RUNSTOP;
             trace_usb_ehci_dma_error();
-            return -1;
+            return false;
         }
         *buf = le32_to_cpu(*buf);
     }
 
-    return num;
+    return true;
 }
 
 /* Put an array of dwords in to main memory */
@@ -1598,8 +1598,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
     /*  Find the head of the list (4.9.1.1) */
     memset(&qh, 0, sizeof(qh));
     for (i = 0; i < MAX_QH; i++) {
-        if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,
-                       ehci_qh_dwords(ehci)) < 0) {
+        if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,
+                        ehci_qh_dwords(ehci))) {
             return 0;
         }
         ehci_trace_qh(NULL, NLPTR_GET(entry), &qh);
@@ -1701,8 +1701,8 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
     }
 
     memset(&qh, 0, sizeof(qh));
-    if (get_dwords(ehci, NLPTR_GET(q->qhaddr),
-                   (uint32_t *) &qh, ehci_qh_dwords(ehci)) < 0) {
+    if (!get_dwords(ehci, NLPTR_GET(q->qhaddr),
+                    (uint32_t *) &qh, ehci_qh_dwords(ehci))) {
         q = NULL;
         goto out;
     }
@@ -1779,8 +1779,8 @@ static int ehci_state_fetchitd(EHCIState *ehci, int async)
     entry = ehci_get_fetch_addr(ehci, async);
 
     memset(&itd, 0, sizeof(itd));
-    if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,
-                   ehci_itd_dwords(ehci)) < 0) {
+    if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,
+                    ehci_itd_dwords(ehci))) {
         return -1;
     }
     ehci_trace_itd(ehci, entry, &itd);
@@ -1805,8 +1805,8 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int async)
     assert(!async);
     entry = ehci_get_fetch_addr(ehci, async);
 
-    if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *)&sitd,
-                   sizeof(EHCIsitd) >> 2) < 0) {
+    if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *)&sitd,
+                    sizeof(EHCIsitd) >> 2)) {
         return 0;
     }
     ehci_trace_sitd(ehci, entry, &sitd);
@@ -1866,18 +1866,18 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
     uint64_t addr;
 
     addr = NLPTR_GET(q->qtdaddr);
-    if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {
+    if (!get_dwords(q->ehci, addr +  8, &qtd.token,   1)) {
         return 0;
     }
     barrier();
     memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));
-    if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||
-        get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||
-        get_dwords(q->ehci, addr + 12, qtd.bufptr,
-                   ARRAY_SIZE(qtd.bufptr)) < 0 ||
+    if (!get_dwords(q->ehci, addr +  0, &qtd.next,    1) ||
+        !get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) ||
+        !get_dwords(q->ehci, addr + 12, qtd.bufptr,
+                    ARRAY_SIZE(qtd.bufptr)) ||
         (q->ehci->caps_64bit_addr &&
-         get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),
-                    qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)) < 0)) {
+         !get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),
+                     qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)))) {
         return 0;
     }
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);
@@ -1969,8 +1969,8 @@ static int ehci_fill_queue(EHCIPacket *p)
             }
         }
         memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));
-        if (get_dwords(q->ehci, NLPTR_GET(qtdaddr),
-                       (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0) {
+        if (!get_dwords(q->ehci, NLPTR_GET(qtdaddr),
+                        (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci))) {
             return -1;
         }
         ehci_trace_qtd(q, NLPTR_GET(qtdaddr), &qtd);
@@ -2290,7 +2290,7 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
         }
         list |= ((ehci->frindex & 0x1ff8) >> 1);
         list64 = ehci_get_desc_addr(ehci, list);
-        if (get_dwords(ehci, list64, &entry, 1) < 0) {
+        if (!get_dwords(ehci, list64, &entry, 1)) {
             break;
         }
         entry64 = ehci_get_desc_addr(ehci, entry);
-- 
2.55.0


