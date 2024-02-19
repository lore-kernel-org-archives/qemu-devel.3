Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4781C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1DZ-00047Q-N2; Mon, 19 Feb 2024 05:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DM-0003vZ-ET
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DL-00019Q-0F
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708339774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUcpp7ud7qWgwM0HegwhwVq7hiSy12MfogOqKhGEj/Q=;
 b=ElJGzbblqUkh+0tWpvyC+mWlS0CBhLc2RvZnxtX9q/y+6gEuACRJQ6AROL7WbAeyT9hrHD
 cQdgCNDGGoguN+YNex22j76JyrmBibwVLCEiIgEvUUaUYn4ILpr26IuZV0voLCYFsQDv/b
 3a1TSxKMpEeR7UPQxeS5PYoDx+yIq0o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-6agA2LLRNH--e3ulVDQ0vA-1; Mon,
 19 Feb 2024 05:49:30 -0500
X-MC-Unique: 6agA2LLRNH--e3ulVDQ0vA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FA961C41A04;
 Mon, 19 Feb 2024 10:49:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBDE61C060B3;
 Mon, 19 Feb 2024 10:49:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH 7/7] hw/ide: Stop exposing internal.h to non-IDE files
Date: Mon, 19 Feb 2024 11:49:12 +0100
Message-ID: <20240219104912.378211-8-thuth@redhat.com>
In-Reply-To: <20240219104912.378211-1-thuth@redhat.com>
References: <20240219104912.378211-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

include/hw/ide/internal.h is currently included by include/hw/ide/pci.h
and thus exposed to a lot of files that are not part of the IDE subsystem.
Stop including internal.h there and use the appropriate new headers
ide-bus.h and ide-dma.h instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ide/pci.h | 3 ++-
 hw/i386/pc.c         | 2 +-
 hw/ide/cmd646.c      | 1 +
 hw/ide/pci.c         | 1 +
 hw/ide/piix.c        | 1 +
 hw/ide/sii3112.c     | 1 +
 hw/ide/via.c         | 1 +
 7 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index a814a0a7c3..e1e012c387 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -1,7 +1,8 @@
 #ifndef HW_IDE_PCI_H
 #define HW_IDE_PCI_H
 
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
+#include "hw/ide/ide-dma.h"
 #include "hw/pci/pci_device.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 196827531a..22d0c29575 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -31,7 +31,7 @@
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/vmport.h"
 #include "sysemu/cpus.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/timer/hpet.h"
 #include "hw/loader.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index c0bcfa4414..23d213ff01 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -33,6 +33,7 @@
 #include "sysemu/reset.h"
 
 #include "hw/ide/pci.h"
+#include "hw/ide/internal.h"
 #include "trace.h"
 
 /* CMD646 specific */
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index ca85d8474c..73efeec7f4 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -30,6 +30,7 @@
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "trace.h"
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 4e5e12935f..1773a068c3 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
+#include "hw/ide/internal.h"
 #include "hw/ide/piix.h"
 #include "hw/ide/pci.h"
 #include "trace.h"
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 63dc4a0494..321b9e46a1 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 3f3c484253..cf151e70ec 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/ide/internal.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.43.2


