Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8B5C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKpA-0000GI-Va; Mon, 27 Jul 2026 08:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKom-0008Q5-0j
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKoj-0004ZH-TK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785156744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZdmUTHxasH+LPRv9GhPgWahT/W5LSLV13AgcmkFDs0=;
 b=MPjBGwy1r0PPZxdkQs+eNJxGtotH38Y+jpHG9fwmHb+2OS6Gp5QZT6IJqbwi4kOYD3x9Ah
 fz17PZ1WENMTNnEHOzhadnLprNHUQWT69wPDMEj3xBV1Jqy8otVp5bXy/QHB21SAH7Fa2j
 1V1a3StbG3dSU/O7V2fKY9mkm+U9Oy0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-nGOr_njnPaS-Mfd27L7QJA-1; Mon,
 27 Jul 2026 08:52:21 -0400
X-MC-Unique: nGOr_njnPaS-Mfd27L7QJA-1
X-Mimecast-MFC-AGG-ID: nGOr_njnPaS-Mfd27L7QJA_1785156740
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24FCE1802658; Mon, 27 Jul 2026 12:52:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.178])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B79981955F17; Mon, 27 Jul 2026 12:52:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Yunhe Wang <yunhewwww@163.com>
Subject: [PULL 4/5] hw/usb/core: Avoid possible assert() in do_parameter() -->
 usb_packet_copy()
Date: Mon, 27 Jul 2026 14:52:06 +0200
Message-ID: <20260727125207.646148-5-thuth@redhat.com>
In-Reply-To: <20260727125207.646148-1-thuth@redhat.com>
References: <20260727125207.646148-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
Message-ID: <20260721185140.247775-1-thuth@redhat.com>
---
 hw/usb/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index d71204c5c80..43653c26cae 100644
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


