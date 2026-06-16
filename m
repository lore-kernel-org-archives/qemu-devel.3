Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2A6CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW9o-0002Of-VB; Tue, 16 Jun 2026 11:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9f-0002Jy-6M
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9U-0003pF-CX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781625395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuqZ60xVWcRIwM3ffZ1a2664p6ZIoKfbkaE0NcmmH0c=;
 b=av7YTWUGYQWuqdZke3fON0qfIrm/CliuHso8Xg/fj5ANBiSS/LrQdUA2uydQoU4LguHnBL
 rwwQp0ndKVJ0ytgpkI6o8ecZ4iArAR2h8EGSuezb+3VryrCwEcFHwxLeYCSWDGplhaTuhU
 6Ru5JSUPS3Ong/y7sawsGvnIFFgOsjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-iK5ov1o0P8O7Jt7VBWf2rQ-1; Tue,
 16 Jun 2026 11:56:34 -0400
X-MC-Unique: iK5ov1o0P8O7Jt7VBWf2rQ-1
X-Mimecast-MFC-AGG-ID: iK5ov1o0P8O7Jt7VBWf2rQ_1781625392
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D7B3180025B; Tue, 16 Jun 2026 15:56:32 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EB2D195419F; Tue, 16 Jun 2026 15:56:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 5/7] system: add qemu_irq_new / qemu_irq_new_child /
 qemu_irq_new_array
Date: Tue, 16 Jun 2026 16:55:52 +0100
Message-ID: <20260616155554.264412-6-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-1-berrange@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare for the move to dynamically allocated IRQ objects by
introducing qemu_irq_new / qemu_irq_new_child / qemu_irq_new_array
functions which call through to object_new instead of object_initialize.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/irq.c         | 35 ++++++++++++++++++++
 include/hw/core/irq.h | 75 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index 106805e241..e943c87b81 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -49,6 +49,13 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
     init_irq_fields(irq, handler, opaque, n);
 }
 
+IRQState *qemu_irq_new(qemu_irq_handler handler, void *opaque, int n)
+{
+    IRQState *irq = IRQ(object_new(TYPE_IRQ));
+    init_irq_fields(irq, handler, opaque, n);
+    return irq;
+}
+
 void qemu_init_irq_child(Object *parent, const char *propname,
                          IRQState *irq, qemu_irq_handler handler,
                          void *opaque, int n)
@@ -57,14 +64,42 @@ void qemu_init_irq_child(Object *parent, const char *propname,
     init_irq_fields(irq, handler, opaque, n);
 }
 
+IRQState *qemu_irq_new_child(Object *parent, const char *propname,
+                             qemu_irq_handler handler,
+                             void *opaque, int n,
+                             Error **errp)
+{
+    IRQState *irq = IRQ(object_new_with_props(TYPE_IRQ, parent, propname,
+                                              errp, NULL));
+    if (!irq) {
+        return NULL;
+    }
+    init_irq_fields(irq, handler, opaque, n);
+    return irq;
+}
+
+
 void qemu_init_irqs(IRQState irq[], size_t count,
                     qemu_irq_handler handler, void *opaque)
 {
     for (size_t i = 0; i < count; i++) {
+        QEMU_DEPRECATIONS_OFF;
         qemu_init_irq(&irq[i], handler, opaque, i);
+        QEMU_DEPRECATIONS_ON;
     }
 }
 
+IRQState **qemu_irq_new_array(size_t count,
+                              qemu_irq_handler handler, void *opaque)
+{
+    IRQState **irqs = g_new0(IRQState *, count);
+    for (size_t i = 0; i < count; i++) {
+        irqs[i] = qemu_irq_new(handler, opaque, i);
+    }
+    return irqs;
+}
+
+
 qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
                            void *opaque, int n)
 {
diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
index 291fdd67df..af9bf6fb12 100644
--- a/include/hw/core/irq.h
+++ b/include/hw/core/irq.h
@@ -34,7 +34,12 @@ static inline void qemu_irq_pulse(qemu_irq irq)
     qemu_set_irq(irq, 0);
 }
 
-/*
+/**
+ * qemu_init_irq: Initialize IRQ
+ * @handler: handler function for incoming interrupts
+ * @opaque: opaque data to pass to @handler
+ * @n: interrupt number to pass to @handler
+ *
  * Init a single IRQ. The irq is assigned with a handler, an opaque data
  * and the interrupt number. The caller must free this with qemu_free_irq().
  * If you are using this inside a device's init or realize method, then
@@ -42,7 +47,21 @@ static inline void qemu_irq_pulse(qemu_irq irq)
  * to manually clean up the IRQ.
  */
 void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
-                   int n);
+                   int n)
+    QEMU_DEPRECATED;
+/**
+ * qemu_new_irq: Allocate IRQ
+ * @handler: handler function for incoming interrupts
+ * @opaque: opaque data to pass to @handler
+ * @n: interrupt number to pass to @handler
+ *
+ * The returned IRQ will have a single reference, which is held by the
+ * caller and must be released to free the returned IRQ object when
+ * no longer required.
+ *
+ * Returns: the newly allocated IRQ
+ */
+IRQState *qemu_irq_new(qemu_irq_handler handler, void *opaque, int n);
 
 /**
  * qemu_init_irq_child: Initialize IRQ and make it a QOM child
@@ -56,10 +75,38 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
  * Init a single IRQ and make the IRQ object a child of @parent with
  * the child-property name @propname. The IRQ object will thus be
  * automatically freed when @parent is destroyed.
+ *
+ * Use of this function is now deprecated. All IRQs must be
+ * allocated using the qemu_irq_new() family of functions and not
+ * statically embedded in a larger struct.
  */
 void qemu_init_irq_child(Object *parent, const char *propname,
                          IRQState *irq, qemu_irq_handler handler,
-                         void *opaque, int n);
+                         void *opaque, int n)
+    QEMU_DEPRECATED;
+
+/**
+ * qemu_init_irq_child: Allocate IRQ and make it a QOM child
+ * @parent: QOM object which owns this IRQ
+ * @propname: child property name
+ * @handler: handler function for incoming interrupts
+ * @opaque: opaque data to pass to @handler
+ * @n: interrupt number to pass to @handler
+ *
+ * Allocate a single IRQ and make the IRQ object a child of @parent with
+ * the child-property name @propname.
+ *
+ * The returned IRQ will have a single reference, which is held by the
+ * @owner object in the QOM composition tree. Thus in the absence of
+ * any further references being acquired, the IRQ will be freed when
+ * @owner is freed
+ *
+ * Returns: the newly allocated IRQ
+ */
+IRQState *qemu_irq_new_child(Object *parent, const char *propname,
+                             qemu_irq_handler handler,
+                             void *opaque, int n,
+                             Error **errp);
 
 
 /**
@@ -69,9 +116,29 @@ void qemu_init_irq_child(Object *parent, const char *propname,
  * @count: number of IRQs to initialize
  * @handler: handler to assign to each IRQ
  * @opaque: opaque data to pass to @handler
+ *
+ * Use of this function is now deprecated. All IRQs must be
+ * allocated using the qemu_irq_new() family of functions and not
+ * statically embedded in a larger struct.
  */
 void qemu_init_irqs(IRQState irq[], size_t count,
-                    qemu_irq_handler handler, void *opaque);
+                    qemu_irq_handler handler, void *opaque)
+    QEMU_DEPRECATED;
+/**
+ * qemu_irq_new_array: Allocate an array of IRQs.
+ * @count: number of IRQs to initialize
+ * @handler: handler to assign to each IRQ
+ * @opaque: opaque data to pass to @handler
+ *
+ * The returned IRQs will have a single reference, which is held by the
+ * caller and must be released to free the returned IRQs object when
+ * no longer required. The return array memory must also be freed by
+ * the caller.
+ *
+ * Returns: an array of IRQ objects
+ */
+IRQState **qemu_irq_new_array(size_t count,
+                              qemu_irq_handler handler, void *opaque);
 
 /* Returns an array of N IRQs. Each IRQ is assigned the argument handler and
  * opaque data.
-- 
2.54.0


