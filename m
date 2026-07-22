Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103AEC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPM-0006ih-Bv; Wed, 22 Jul 2026 08:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNJ-0003W0-Ab; Wed, 22 Jul 2026 08:48:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNE-0001px-SH; Wed, 22 Jul 2026 08:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=cWAbnpqrfyi4fwp9/QRd1jcY+tktlSUUT2Lw4k87/54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y+MRp23reOtbjJng4Kezwyoy0LvBweTGbF3YG/q7/OiaJ0IfHfX8nfH7jFDFFJujp
 tCdJcDx5f41hwexVzC7sP4K/IoEJme/dJB1TLqm42NBtIRWiL+vYw8eQJX7Gzlc/BU
 6szRffbpgvhRFnGRaWxcYciKRUF7QsTbV5cEq1ZdHxbnyJfPWhcSataGHpsPjUp7gQ
 erFGmc384TLpmGrUyIyTvf2D+SIHcRdA3GZEWczK+tACfwPE+PnIQHZYrWw7fdub8i
 bykeNn+1LauZWw/RbOBGPdnI3dKWZ30C3DSAVyYyuJjq61DLKsBioCW9YWdvCSlRb2
 urPgYTA8BUj1Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A00B11C3B0A;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E84563F3764;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6A3E717EFD; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 097/122] hw/usb/hcd-ohci: Make sure that
 ohci_service_ed_list() cannot loop forever
Date: Wed, 22 Jul 2026 15:45:46 +0300
Message-ID: <20260722124622.31034-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The inner while loop in ohci_service_ed_list() could theoretically
loop forever if a malicious guest prepares a set of bad descriptors.
Add a check to the loop to avoid this situation.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3781
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260713160458.343323-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 98e5a8eb4fb9145e9dc336b297ec14390ce88ff9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index b7296ae0363..2974819a2da 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
@@ -1130,6 +1131,8 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
         return 0;
     }
     for (cur = head; cur && link_cnt++ < ED_LINK_LIMIT; cur = next_ed) {
+        unsigned int ed_cnt = 0;
+
         if (ohci_read_ed(ohci, cur, &ed)) {
             trace_usb_ohci_ed_read_error(cur);
             ohci_die(ohci);
@@ -1173,6 +1176,13 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
                     break;
                 }
             }
+
+            if (ed_cnt++ > ED_LINK_LIMIT) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "ohci: Too many endpoint descriptors in loop\n");
+                ohci_die(ohci);
+                return 0;
+            }
         }
 
         if (ohci_put_ed(ohci, cur, &ed)) {
-- 
2.47.3


