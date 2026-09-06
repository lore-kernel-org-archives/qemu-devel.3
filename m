Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA95C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP1-0003ow-5P; Sun, 06 Sep 2026 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOt-0003iX-R6
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOs-0000DW-8K
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycMZwlp+2/s/v+yTRC1sc7we8FnPTGlF6sKzv9Myl2Y=;
 b=fmQiFyWj0KdlWJzlCFjggDmnzMh0Kravr9BbdiXB4QF896SY8Q8tn4G6StLUidfkDs86oJ
 p7OXjoP1hiL8chsZJOONQGv/GkZb0PAgM7C7QAyIbeJ85fkYYetR96e3pICacS+ehEOt4Y
 p5VCP6S8s9XSEDkLlKhgpxsGrCSJc7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-JbNeUkR0NcG3hfBNpKSQ1w-1; Sun,
 06 Sep 2026 13:11:22 -0400
X-MC-Unique: JbNeUkR0NcG3hfBNpKSQ1w-1
X-Mimecast-MFC-AGG-ID: JbNeUkR0NcG3hfBNpKSQ1w_1788714681
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AA7A18011F7; Sun,  6 Sep 2026 17:11:21 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A847B1955F06; Sun,  6 Sep 2026 17:11:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/40] hw/sensor: tmp105: make device state private to the
 implementation
Date: Sun,  6 Sep 2026 19:10:06 +0200
Message-ID: <20260906171021.26568-26-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

The TMP105State struct, its cast macro and typedef are used only within
tmp105.c. Move them out of the public header into the source file and
drop the now-unused includes; the header is reduced to the TYPE_TMP105
name, with its guard renamed to the path-derived form per current QEMU
convention.

While here, normalize the source file include order to match the other
hw/sensor devices.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-1-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/sensor/tmp105.h | 40 ++-------------------------------
 hw/sensor/tmp105.c         | 45 +++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
index 244e2989febd..daece592e9bc 100644
--- a/include/hw/sensor/tmp105.h
+++ b/include/hw/sensor/tmp105.h
@@ -11,45 +11,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or
  * later. See the COPYING file in the top-level directory.
  */
-#ifndef QEMU_TMP105_H
-#define QEMU_TMP105_H
-
-#include "hw/i2c/i2c.h"
-#include "hw/sensor/tmp105_regs.h"
-#include "qom/object.h"
+#ifndef HW_SENSOR_TMP105_H
+#define HW_SENSOR_TMP105_H
 
 #define TYPE_TMP105 "tmp105"
-OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
-
-/**
- * TMP105State:
- * @config: Bits 5 and 6 (value 32 and 64) determine the precision of the
- * temperature. See Table 8 in the data sheet.
- *
- * @see_also: http://www.ti.com/lit/gpn/tmp105
- */
-struct TMP105State {
-    /*< private >*/
-    I2CSlave i2c;
-    /*< public >*/
-
-    uint8_t len;
-    uint8_t buf[2];
-    qemu_irq pin;
-
-    uint8_t pointer;
-    uint8_t config;
-    int16_t temperature;
-    int16_t limit[2];
-    int faults;
-    uint8_t alarm;
-    /*
-     * The TMP105 initially looks for a temperature rising above T_high;
-     * once this is detected, the condition it looks for next is the
-     * temperature falling below T_low. This flag is false when initially
-     * looking for T_high, true when looking for T_low.
-     */
-    bool detect_falling;
-};
 
 #endif
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index c5089d74f4bf..6069c0905d91 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -19,16 +19,51 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i2c/i2c.h"
-#include "hw/core/irq.h"
-#include "migration/vmstate.h"
-#include "hw/sensor/tmp105.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qemu/module.h"
+#include "qom/object.h"
+#include "hw/sensor/tmp105.h"
+#include "hw/sensor/tmp105_regs.h"
+#include "hw/core/irq.h"
 #include "hw/core/registerfields.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
+OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
+
+/**
+ * TMP105State:
+ * @config: Bits 5 and 6 (value 32 and 64) determine the precision of the
+ * temperature. See Table 8 in the data sheet.
+ *
+ * @see_also: http://www.ti.com/lit/gpn/tmp105
+ */
+struct TMP105State {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+
+    uint8_t len;
+    uint8_t buf[2];
+    qemu_irq pin;
+
+    uint8_t pointer;
+    uint8_t config;
+    int16_t temperature;
+    int16_t limit[2];
+    int faults;
+    uint8_t alarm;
+    /*
+     * The TMP105 initially looks for a temperature rising above T_high;
+     * once this is detected, the condition it looks for next is the
+     * temperature falling below T_low. This flag is false when initially
+     * looking for T_high, true when looking for T_low.
+     */
+    bool detect_falling;
+};
+
 FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
 FIELD(CONFIG, THERMOSTAT_MODE,      1, 1)
 FIELD(CONFIG, POLARITY,             2, 1)
-- 
2.55.0


