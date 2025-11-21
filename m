Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC41CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcrH-00060Q-Lk; Fri, 21 Nov 2025 20:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbke-00008L-4Z; Fri, 21 Nov 2025 19:45:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbib-0007Il-CD; Fri, 21 Nov 2025 19:45:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C89916CA88;
 Fri, 21 Nov 2025 21:44:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F04B2321CC4;
 Fri, 21 Nov 2025 21:44:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 77/81] hw/southbridge/lasi: Correct LasiState parent
Date: Fri, 21 Nov 2025 21:44:16 +0300
Message-ID: <20251121184424.1137669-77-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

TYPE_LASI_CHIP inherits from TYPE_SYS_BUS_DEVICE, not
TYPE_PCI_HOST_BRIDGE, so its parent structure is of
SysBusDevice type.

Cc: qemu-stable@nongnu.org
Fixes: 376b851909d ("hppa: Add support for LASI chip with i82596 NIC")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20251117091804.56529-1-philmd@linaro.org>
(cherry picked from commit 9c3b76a0d40671cbdf1f97c662311ec8bb517c76)
(Mjt: context fixup)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index f01c0f680a..4a8e6df3ab 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -13,8 +13,8 @@
 #define LASI_H
 
 #include "exec/address-spaces.h"
-#include "hw/pci/pci_host.h"
 #include "hw/boards.h"
+#include "hw/sysbus.h"
 
 #define TYPE_LASI_CHIP "lasi-chip"
 OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
@@ -61,7 +61,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
 #define LASI_IRQ_PS2MOU_HPA 26
 
 struct LasiState {
-    PCIHostState parent_obj;
+    SysBusDevice parent_obj;
 
     uint32_t irr;
     uint32_t imr;
-- 
2.47.3


