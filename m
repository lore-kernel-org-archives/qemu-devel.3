Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242C606A33A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A/QKDwrO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHke-0004zi-9M; Fri, 06 Nov 2026 06:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkb-0004wf-G0
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkX-0007ir-E2
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793963088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klM6SFBCR1bGGvY+WraPUbRgVPj3OhNmBUSAfjM7gTE=;
 b=A/QKDwrO2jCb/pHqvxGQslZj2AiMxVj6OfiV6vrxG0vXslJnmxVH6+/qSlcLens/or1Ipv
 ArSJx90EaRJx9HNd1wxTGMZ0klT17uDGLVt8tmIf+qhp+Ko60761TYApnMyRyNiukG02y6
 0QkEI1e1nyBlTCNO8G2xKP/0tGnA51E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-njaFQKjaPgeUmkStPNC_pA-1; Fri,
 06 Nov 2026 06:04:44 -0500
X-MC-Unique: njaFQKjaPgeUmkStPNC_pA-1
X-Mimecast-MFC-AGG-ID: njaFQKjaPgeUmkStPNC_pA_1793963083
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9D471956052; Fri,  6 Nov 2026 11:04:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BEE0195608A; Fri,  6 Nov 2026 11:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B768A21E6880; Fri, 06 Nov 2026 12:04:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, mark.caveayland@nutanix.com
Subject: [PATCH 2/8] hw/gpio/pca9554: Move most code from .h to .c
Date: Fri,  6 Nov 2026 12:04:34 +0100
Message-ID: <20261106110440.3552588-3-armbru@redhat.com>
In-Reply-To: <20261106110440.3552588-1-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/gpio/pca9554.h | 25 -------------------------
 hw/gpio/pca9554.c         | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
index ac835371aa..1b33a8a752 100644
--- a/include/hw/gpio/pca9554.h
+++ b/include/hw/gpio/pca9554.h
@@ -8,32 +8,7 @@
 #ifndef PCA9554_H
 #define PCA9554_H
 
-#include "hw/i2c/i2c.h"
-#include "qom/object.h"
-
 #define TYPE_PCA9554 "pca9554"
 #define TYPE_PCA9536 "pca9536"
-typedef struct PCA9554State PCA9554State;
-DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
-                         TYPE_PCA9554)
-
-#define PCA9554_NR_REGS 4
-#define PCA9554_PIN_COUNT 8
-#define PCA9536_PIN_COUNT 4
-
-struct PCA9554State {
-    /*< private >*/
-    I2CSlave i2c;
-    /*< public >*/
-
-    uint8_t len;
-    uint8_t pointer;
-
-    uint8_t regs[PCA9554_NR_REGS];
-    qemu_irq gpio_out[PCA9554_PIN_COUNT];
-    uint8_t ext_state[PCA9554_PIN_COUNT];
-    char *description; /* For debugging purpose only */
-    bool hw_dir; /* Honor pin direction */
-};
 
 #endif
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 07bb00babf..e5a1932c89 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -13,6 +13,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/gpio/pca9554.h"
 #include "hw/gpio/pca9554_regs.h"
+#include "hw/i2c/i2c.h"
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
@@ -21,6 +22,29 @@
 #include "trace.h"
 #include "qom/object.h"
 
+typedef struct PCA9554State PCA9554State;
+DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
+                         TYPE_PCA9554)
+
+#define PCA9554_NR_REGS 4
+#define PCA9554_PIN_COUNT 8
+#define PCA9536_PIN_COUNT 4
+
+struct PCA9554State {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+
+    uint8_t len;
+    uint8_t pointer;
+
+    uint8_t regs[PCA9554_NR_REGS];
+    qemu_irq gpio_out[PCA9554_PIN_COUNT];
+    uint8_t ext_state[PCA9554_PIN_COUNT];
+    char *description; /* For debugging purpose only */
+    bool hw_dir; /* Honor pin direction */
+};
+
 struct PCA9554Class {
     /*< private >*/
     I2CSlaveClass parent_class;
-- 
2.55.0


