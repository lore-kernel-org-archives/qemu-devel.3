Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6904C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 19:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb2gr-00080z-Hk; Thu, 23 Jan 2025 14:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gQ-0007yg-CO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gN-0003EG-N9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737659762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUzh2DOHWU3dRkxF9LEi+/CI5yJwg3mvs9zUxaVcn44=;
 b=GYZjZ2SO5JYoLkMwROgRJnvRfEC03ga+X6fCkUkzIPMbwI3BX04AKF933fuiOj2iziBJuc
 xmF7PNeEOym4PQuE3FuLHdl4IpC2bOD52XiYFX8YBe1hElFjVXt4tWUBvcTglaiUoSq3/V
 AbR01eEdqM+yC8ziG4IzegdSy5P/XUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-HA8aCHAwOUWswy7uC-_jsA-1; Thu,
 23 Jan 2025 14:15:59 -0500
X-MC-Unique: HA8aCHAwOUWswy7uC-_jsA-1
X-Mimecast-MFC-AGG-ID: HA8aCHAwOUWswy7uC-_jsA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8B591955E88
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 19:15:58 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35F4B30001BE; Thu, 23 Jan 2025 19:15:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 6/6] ui: add ability to dump the raw cursor bytes
Date: Thu, 23 Jan 2025 19:15:36 +0000
Message-ID: <20250123191536.142753-7-berrange@redhat.com>
In-Reply-To: <20250123191536.142753-1-berrange@redhat.com>
References: <20250123191536.142753-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/virtio-gpu.c |  1 +
 include/ui/console.h    |  1 +
 ui/cursor.c             | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9952658df2..84836f52c4 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -102,6 +102,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_gpu_update_cursor *cursor)
 
         if (cursor->resource_id > 0) {
             vgc->update_cursor_data(g, s, cursor->resource_id);
+            cursor_dump_hex(s->current_cursor, "", 24, 24);
             cursor_unmultiply_alpha(s->current_cursor);
             cursor_swap_rgb(s->current_cursor);
         }
diff --git a/include/ui/console.h b/include/ui/console.h
index e5eb903feb..95b57b0e45 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -169,6 +169,7 @@ void cursor_unref(QEMUCursor *c);
 QEMUCursor *cursor_builtin_hidden(void);
 QEMUCursor *cursor_builtin_left_ptr(void);
 void cursor_print_ascii_art(QEMUCursor *c, const char *prefix);
+void cursor_dump_hex(QEMUCursor *c, const char *prefix, int maxw, int maxh);
 int cursor_get_mono_bpl(QEMUCursor *c);
 void cursor_set_mono(QEMUCursor *c,
                      uint32_t foreground, uint32_t background, uint8_t *image,
diff --git a/ui/cursor.c b/ui/cursor.c
index 536e022548..bc96307f3f 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -80,6 +80,27 @@ void cursor_print_ascii_art(QEMUCursor *c, const char *prefix)
     }
 }
 
+void cursor_dump_hex(QEMUCursor *c, const char *prefix, int maxw, int maxh)
+{
+    uint8_t *data = (uint8_t *) c->data;
+    int x,y,v;
+
+    maxw = MIN(maxw, c->width);
+    maxh = MIN(maxh, c->height);
+
+    for (y = 0; y < maxh; y++) {
+        fprintf(stderr, "%s: %2d: |", prefix, y);
+        for (x = 0; x < maxw; x++) {
+            for (v = 0; v < 4 ; v++, data++) {
+                fprintf(stderr, "%02x", *data);
+            }
+            fprintf(stderr, " ");
+        }
+        data += (c->width - maxw) * 4;
+        fprintf(stderr, "|\n");
+    }
+}
+
 QEMUCursor *cursor_builtin_hidden(void)
 {
     return cursor_parse_xpm(cursor_hidden_xpm);
-- 
2.47.1


