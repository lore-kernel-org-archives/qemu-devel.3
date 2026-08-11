Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAF3C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNh-0001Je-Dq; Tue, 11 Aug 2026 12:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNb-0000ml-LL
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNX-0000jF-Kt
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0rfqHYkg9gpevvDZkO/JoxV/QyKM6R5lV11DiT5Z24=;
 b=d9QVPgGUL/lalF4CIm3rkGEcwjKYrHeAcNa+8DyvMNUuvIHcgkPHQBabvPnW81Bl4wOlZK
 Q74FsI+LLXRZD1BDq33xyjJVi1fOAWHWaoVMjiXiyeyGNynfEIlxCA3UmmmiSlgP8e4zGA
 NN4so/ZbTF8xUEtLhXSc3wgG1zbw/n0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-2fvQZadTOuKSPblxuCmfzg-1; Tue,
 11 Aug 2026 12:30:59 -0400
X-MC-Unique: 2fvQZadTOuKSPblxuCmfzg-1
X-Mimecast-MFC-AGG-ID: 2fvQZadTOuKSPblxuCmfzg_1786465858
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AD111800115; Tue, 11 Aug 2026 16:30:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B40D1195DF91; Tue, 11 Aug 2026 16:30:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/83] hw/gpio: pca9552: move PCA955xState definition out of
 the header
Date: Tue, 11 Aug 2026 18:28:50 +0200
Message-ID: <20260811162938.1403216-36-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Nothing outside pca9552.c uses the PCA955xState structure, its instance
checker, or the PCA955X_NR_REGS/PCA955X_PIN_COUNT_MAX defines: the board
files and qtests only rely on the TYPE_* name macros (and the register
macros in pca9552_regs.h).

Move the state structure and the size defines into pca9552.c, leaving
pca9552.h with just the type-name macros. While at it, replace the
separate DECLARE_INSTANCE_CHECKER and DECLARE_CLASS_CHECKERS declarations
with a single OBJECT_DECLARE_TYPE().

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-2-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/gpio/pca9552.h | 30 ++++--------------------------
 hw/gpio/pca9552.c         | 29 ++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
index 43b175235d2f..71479ea0006e 100644
--- a/include/hw/gpio/pca9552.h
+++ b/include/hw/gpio/pca9552.h
@@ -1,39 +1,17 @@
 /*
- * PCA9552 I2C LED blinker
+ * PCA955X I2C LED blinker and I/O expanders
  *
  * Copyright (c) 2017-2018, IBM Corporation.
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or
  * later. See the COPYING file in the top-level directory.
  */
-#ifndef PCA9552_H
-#define PCA9552_H
 
-#include "hw/i2c/i2c.h"
-#include "qom/object.h"
+#ifndef HW_GPIO_PCA9552_H
+#define HW_GPIO_PCA9552_H
 
-#define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA955X "pca955x"
+#define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA9535 "pca9535"
-typedef struct PCA955xState PCA955xState;
-DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
-                         TYPE_PCA955X)
-
-#define PCA955X_NR_REGS 10
-#define PCA955X_PIN_COUNT_MAX 16
-
-struct PCA955xState {
-    /*< private >*/
-    I2CSlave i2c;
-    /*< public >*/
-
-    uint8_t len;
-    uint8_t pointer;
-
-    uint8_t regs[PCA955X_NR_REGS];
-    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
-    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
-    char *description; /* For debugging purpose only */
-};
 
 #endif
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 50e868a6e9a7..36bc4f86edb1 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -1,7 +1,10 @@
 /*
- * PCA9552 I2C LED blinker
+ * PCA955X I2C LED blinker and I/O expanders
  *
  *     https://www.nxp.com/docs/en/application-note/AN264.pdf
+ *     https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
+ *     https://www.nxp.com/docs/en/data-sheet/PCA9555.pdf
+ *     https://www.nxp.com/docs/en/data-sheet/PCA9535_PCA9535C.pdf
  *
  * Copyright (c) 2017-2018, IBM Corporation.
  * Copyright (c) 2020 Philippe Mathieu-Daudé
@@ -12,9 +15,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/i2c/i2c.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9552_regs.h"
 #include "hw/core/irq.h"
@@ -24,6 +27,25 @@
 #include "trace.h"
 #include "qom/object.h"
 
+#define PCA955X_NR_REGS 10
+#define PCA955X_PIN_COUNT_MAX 16
+
+OBJECT_DECLARE_TYPE(PCA955xState, PCA955xClass, PCA955X)
+
+struct PCA955xState {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+
+    uint8_t len;
+    uint8_t pointer;
+
+    uint8_t regs[PCA955X_NR_REGS];
+    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
+    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
+    char *description; /* For debugging purpose only */
+};
+
 struct PCA955xClass {
     /*< private >*/
     I2CSlaveClass parent_class;
@@ -33,10 +55,7 @@ struct PCA955xClass {
     uint8_t max_reg;
     bool has_led_support;
 };
-typedef struct PCA955xClass PCA955xClass;
 
-DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
-                       TYPE_PCA955X)
 /*
  * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
  *        chips are the reverse of the PCA953X family of chips.
-- 
2.55.0


