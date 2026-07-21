Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB71DC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFaH-0007HO-Aq; Tue, 21 Jul 2026 14:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmFZI-0005NM-R5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmFZG-0007Kt-FF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784659909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pUR43T2x5P+UVkp+i2OhMt0havAGDMm9JyifCg+h1k8=;
 b=cydvM+aSXf3oYh7GcFL1F1fPnfk/qcmustKeVgAFT4yiS+doiCuMnD63pzeHqQxaTYKK0+
 7LMgIhv6lwmVtLXG/HHrydXuQ6efvTBDiMSBVcbuhAmWP2UqKzJJ76LR3BMjRCeRVAm7b7
 A3QfxS+luv+g7TYY8CunssRiSTl7Ph4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-M58ycJVtOw-dRcDo84l6ig-1; Tue,
 21 Jul 2026 14:51:46 -0400
X-MC-Unique: M58ycJVtOw-dRcDo84l6ig-1
X-Mimecast-MFC-AGG-ID: M58ycJVtOw-dRcDo84l6ig_1784659905
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5032195FCD6; Tue, 21 Jul 2026 18:51:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.11])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 929F21598; Tue, 21 Jul 2026 18:51:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yunhe Wang <yunhewwww@163.com>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/usb/core: Avoid possible assert() in do_parameter() -->
 usb_packet_copy()
Date: Tue, 21 Jul 2026 20:51:40 +0200
Message-ID: <20260721185140.247775-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

usb_packet_copy() uses assert(p->actual_length + bytes <= iov->size)
to make sure that there is enough space in the the iov. This assert()
can be triggered from do_parameter() if the guest programs the XHCI
in a weird way. Avoid the hard error by checking for the condition
in do_parameter() first and signalling a USB_RET_STALL to the guest,
just like it is done for another error condition here already some
lines earlier.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3746
Reported-by: Yunhe Wang <yunhewwww@163.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 9572a870cc0..11f484b9ad0 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/usb/usb.h"
 #include "qemu/iov.h"
+#include "qemu/log.h"
 #include "trace.h"
 
 void usb_pick_speed(USBPort *port)
@@ -288,6 +289,15 @@ static void do_parameter(USBDevice *s, USBPacket *p)
         p->status = USB_RET_STALL;
         return;
     }
+    if ((p->pid == USB_TOKEN_OUT || p->pid == USB_TOKEN_IN) &&
+        setup_len > p->iov.size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "xhci: setup state param length %u > iov size %zu\n",
+                      setup_len, p->iov.size);
+        p->status = USB_RET_STALL;
+        return;
+    }
+
     s->setup_len = setup_len;
 
     if (p->pid == USB_TOKEN_OUT) {
-- 
2.55.0


