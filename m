Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89458C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma6C-0004Rt-5X; Tue, 19 Mar 2024 10:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma67-0004PX-Rz
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma66-0008NX-3h
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710857145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWgDqLVUGMnlNILpKAU83zv3AF1R8UCIRu3dt5BeHGA=;
 b=XFOnEuyglgPzWgmZ4j3fyZ5UP027iRr9xHFpWONU31kI0qeiCdmG25HP/dqYhlDft8AAq0
 rhjjYDgX7m33heI5aazlsmssfKaCPqYPnSIn/ettjGs3KHIrT1VHNotJ/tiw6dsZwU6QNy
 qJcSlRMyRnNn422PARaWGhwrVXuoh9w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-re5I9qv7ObOfGrP4fyGRmQ-1; Tue,
 19 Mar 2024 10:05:44 -0400
X-MC-Unique: re5I9qv7ObOfGrP4fyGRmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C776D1C05AF8
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:05:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1C673C54;
 Tue, 19 Mar 2024 14:05:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/3] aspeed/smc: Only wire flash devices at reset
Date: Tue, 19 Mar 2024 15:05:16 +0100
Message-ID: <20240319140516.392542-4-clg@redhat.com>
In-Reply-To: <20240319140516.392542-1-clg@redhat.com>
References: <20240319140516.392542-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Aspeed machines have many Static Memory Controllers (SMC), up to
8, which can only drive flash memory devices. Commit 27a2c66c92ec
("aspeed/smc: Wire CS lines at reset") tried to ease the definitions
of these devices by allowing flash devices from the command line to be
attached to a SSI bus. For that, the wiring of the CS lines of the
Aspeed SMC controller was moved at reset. Two assumptions are made
though, first that the device has a SSI_GPIO_CS GPIO line, which is
not always the case, and second that it is a flash device.

Correct this problem by ensuring that the devices attached to the bus
are of the correct flash type. This fixes a QEMU abort when devices
without a CS line, such as the max111x, are passed on the command
line.

While at it, export TYPE_M25P80 used in the Xilinx Versal Virtual
machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2228
Fixes: 27a2c66c92ec ("aspeed/smc: Wire CS lines at reset")
Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
[ clg: minor fixes in the commit log ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/block/flash.h  | 2 ++
 hw/arm/xlnx-versal-virt.c | 3 ++-
 hw/block/m25p80.c         | 1 -
 hw/ssi/aspeed_smc.c       | 9 +++++++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index de93756cbe8f261edf0ff4b4cf2fa811a9c0463d..2b5ccd92f46393b81e373bdd537a08d66bfd3b8a 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -78,6 +78,8 @@ extern const VMStateDescription vmstate_ecc_state;
 
 /* m25p80.c */
 
+#define TYPE_M25P80 "m25p80-generic"
+
 BlockBackend *m25p80_get_blk(DeviceState *dev);
 
 #endif
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index bfaed1aebfc6f1b60a85520bba44e5276d549cd8..962f98fee2ea9b8643d120100e694cfb00348200 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "sysemu/device_tree.h"
+#include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/arm/fdt.h"
@@ -759,7 +760,7 @@ static void versal_virt_init(MachineState *machine)
             flash_klass = object_class_by_name(s->ospi_model);
             if (!flash_klass ||
                 object_class_is_abstract(flash_klass) ||
-                !object_class_dynamic_cast(flash_klass, "m25p80-generic")) {
+                !object_class_dynamic_cast(flash_klass, TYPE_M25P80)) {
                 error_setg(&error_fatal, "'%s' is either abstract or"
                        " not a subtype of m25p80", s->ospi_model);
                 return;
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 08a00a6d9b89b2883ccab70e665dcf6539caf752..8dec134832a14b03d065080db49a029d0450acdd 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -515,7 +515,6 @@ struct M25P80Class {
     FlashPartInfo *pi;
 };
 
-#define TYPE_M25P80 "m25p80-generic"
 OBJECT_DECLARE_TYPE(Flash, M25P80Class, M25P80)
 
 static inline Manufacturer get_man(Flash *s)
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 3c93936fd1ff98d20b6d6a940768f488d433d879..6e1a84c197130118d022d1b9fb607e74e844f4e2 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/block/flash.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
@@ -695,6 +696,14 @@ static void aspeed_smc_reset(DeviceState *d)
     for (i = 0; i < asc->cs_num_max; i++) {
         DeviceState *dev = ssi_get_cs(s->spi, i);
         if (dev) {
+            Object *o = OBJECT(dev);
+
+            if (!object_dynamic_cast(o, TYPE_M25P80)) {
+                warn_report("Aspeed SMC %s.%d : Invalid %s device type",
+                            BUS(s->spi)->name, i, object_get_typename(o));
+                continue;
+            }
+
             qemu_irq cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
             qdev_connect_gpio_out_named(DEVICE(s), "cs", i, cs_line);
         }
-- 
2.44.0


