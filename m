Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F073DC4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWT9-00076X-Ah; Wed, 22 Jul 2026 08:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRr-0003EH-2b; Wed, 22 Jul 2026 08:53:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRp-0002YH-8A; Wed, 22 Jul 2026 08:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=usUnMZy6/N52jdP0ZzQWYGkXY2RgIlVjKNFksapuOkg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vw+K065jqIw3QIKBb7RNhL79rZTu8v+Puad5YcIxqkQlRnYmfi+L36PlbwA3nxPAH
 5vcitDxh1DXwtYD/1zPcQJnw9YTsmP+kHQ21dR2jP3dScgxWPHm8pXV6QDxacRD+8g
 pS+cY1f2QvGzNVC2P0d9GvRUeI1tQQUb6+0iLOZ+QeyNU1UjpSrUAkaTZdTTQuZzgV
 cnxtgRpY2mqq7beFOeVV2Ej4c2JBckRWhMkzmWa4BOAWOBxaUp7Ot3CEWGxJlS2/iN
 V46yoZUSMCZT7fabxc1YeOiEHKdVavVF73E5wuSPF7tDMUBqIJbq3k3Gva/tqnQYZi
 RLBKqZEYXXBZg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E39081C3B42;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3832F3F3792;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C166E17F59; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 101/127] hw/usb/hcd-ohci: Make sure that
 ohci_service_ed_list() cannot loop forever
Date: Wed, 22 Jul 2026 15:48:26 +0300
Message-ID: <20260722124859.32371-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
index 37a11f0c941..f98a1c353ea 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb/usb.h"
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


