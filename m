Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4581AC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgmI-0007BV-Se; Fri, 17 Jul 2026 07:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkglp-00076S-7C
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkgll-0000Xj-RH
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784287816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oDqxtqtQmLTe1nOXQhdjELhe62ddcFuq10Pf1MSlvFQ=;
 b=gJZuVnH6UrBU0lp+tbo+zoFHmvLSxvOPJWaW07EM0s5AZVEGEXRwYG+fYxxfK80oUsKAd6
 x2xLsdMbt+aCyZ+rR7LrhJ/sarqa/DBx/3F95X1BQLO/fSPd4W2ZKt/WDsJJLs3pT1AnaQ
 07SBOpwkTrUWsE3611G8BU4W6R7m/2o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-0fLqfB_vP-SkcV9pqM1qyA-1; Fri,
 17 Jul 2026 07:30:13 -0400
X-MC-Unique: 0fLqfB_vP-SkcV9pqM1qyA-1
X-Mimecast-MFC-AGG-ID: 0fLqfB_vP-SkcV9pqM1qyA_1784287811
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74F9E1955F7A; Fri, 17 Jul 2026 11:30:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98A901955D9F; Fri, 17 Jul 2026 11:30:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: [PATCH] hw/usb/hcd-xhci-sysbus: Fix OOB heap access in
 xhci_sysbus_intr_raise()
Date: Fri, 17 Jul 2026 13:30:06 +0200
Message-ID: <20260717113006.172612-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Now the generic XHCI code has at least one code path that could call
the xhci_sysbus_intr_raise() function with n > 1, so this function
calls qemu_set_irq() with s->irq[n] pointing to a bad heap address.
The qemu_set_irq() then tries to call an IRQ handler via a function
pointer in that heap space - which either causes QEMU to die with
a segmentation fault (if it's a bad address), or even worse runs
some unexpected code if the destination of the pointer is executable
code.

Fix the problem by checking for valid interrupt numbers before
calling qemu_set_irq().

Fixes: CVE-2026-16043
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4001
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci-sysbus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 19664c5985e..7ab2f8527bd 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -8,6 +8,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
@@ -20,7 +21,12 @@ static bool xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
 {
     XHCISysbusState *s = container_of(xhci, XHCISysbusState, xhci);
 
-    qemu_set_irq(s->irq[n], level);
+    if (n < xhci->numintrs) {
+        qemu_set_irq(s->irq[n], level);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unexpected IRQ #%i raised on xhci\n", n);
+    }
 
     return false;
 }
-- 
2.55.0


