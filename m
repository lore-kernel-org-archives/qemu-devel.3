Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4E1C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb2gE-0007xN-Sc; Thu, 23 Jan 2025 14:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gC-0007wY-1S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2g9-000364-HF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737659746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLqQjC8lqdo0tOZ9lOt2v8qVNDxXWx9F20tIURmXr/M=;
 b=dhWfnMdLhTifp5WpEFiEOKPzTtRG60K06jq8WNF532ApbOhDU0isZFMD1VoDKJOo5ii4rv
 61kJ7m/qrVYLluDLcIjHvvTwgwc3GRY39OgaLYQ4tXQOLmIo6/q3yhfqT3qkvELI2s8rAI
 2k5zEyspNZEkXwXxZr1bqxczsaaibas=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-IdTTRylQP-uGq2J7AsEAIQ-1; Thu,
 23 Jan 2025 14:15:44 -0500
X-MC-Unique: IdTTRylQP-uGq2J7AsEAIQ-1
X-Mimecast-MFC-AGG-ID: IdTTRylQP-uGq2J7AsEAIQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EC2E1953942
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 19:15:43 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71EB03003E7F; Thu, 23 Jan 2025 19:15:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 1/6] ui: add more cursor helper methods
Date: Thu, 23 Jan 2025 19:15:31 +0000
Message-ID: <20250123191536.142753-2-berrange@redhat.com>
In-Reply-To: <20250123191536.142753-1-berrange@redhat.com>
References: <20250123191536.142753-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds helper methods to the QEMUCursor APIs for multiplying /
unmultiplying the alpha channel into the RGB components; for swapping
the RGB component order; for copying cursor objects; auto-freeing
cursor objects.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/console.h |  6 ++++++
 ui/cursor.c          | 49 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 46b3128185..e5eb903feb 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -175,6 +175,12 @@ void cursor_set_mono(QEMUCursor *c,
                      int transparent, uint8_t *mask);
 void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask);
 
+void cursor_multiply_alpha(QEMUCursor *c);
+void cursor_unmultiply_alpha(QEMUCursor *c);
+void cursor_swap_rgb(QEMUCursor *c);
+QEMUCursor *cursor_copy(QEMUCursor *c);
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QEMUCursor, cursor_unref);
+
 typedef void *QEMUGLContext;
 typedef struct QEMUGLParams QEMUGLParams;
 
diff --git a/ui/cursor.c b/ui/cursor.c
index 6e23244fbe..536e022548 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -225,3 +225,52 @@ void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
         mask += bpl;
     }
 }
+
+void cursor_multiply_alpha(QEMUCursor *c)
+{
+    int i;
+
+    for (i = 0 ; i < (c->width * c->height); i++) {
+        guint8 *pixels = (guint8 *)c->data + (i * 4);
+        pixels[0] = (unsigned)pixels[0] * pixels[3] / 255;
+        pixels[1] = (unsigned)pixels[1] * pixels[3] / 255;
+        pixels[2] = (unsigned)pixels[2] * pixels[3] / 255;
+    }
+}
+
+void cursor_unmultiply_alpha(QEMUCursor *c)
+{
+    int i;
+
+    for (i = 0 ; i < (c->width * c->height); i++) {
+        guint8 *pixels = (guint8 *)c->data + (i * 4);
+        guint8 alpha = pixels[3] ? pixels[3] : 1;
+        pixels[0] = (unsigned)pixels[0] * 255 / alpha;
+        pixels[1] = (unsigned)pixels[1] * 255 / alpha;
+        pixels[2] = (unsigned)pixels[2] * 255 / alpha;
+    }
+}
+
+void cursor_swap_rgb(QEMUCursor *c)
+{
+    int i;
+
+    for (i = 0 ; i < (c->width * c->height); i++) {
+        guint8 *pixels = (guint8 *)c->data + (i * 4);
+        pixels[0] ^= pixels[2];
+        pixels[2] ^= pixels[0];
+        pixels[0] ^= pixels[2];
+    }
+}
+
+QEMUCursor *cursor_copy(QEMUCursor *c)
+{
+    QEMUCursor *ret = cursor_alloc(c->width, c->height);
+
+    ret->hot_x = c->hot_x;
+    ret->hot_y = c->hot_y;
+
+    memcpy(ret->data, c->data, c->width * c->height * 4);
+
+    return ret;
+}
-- 
2.47.1


