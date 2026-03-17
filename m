Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71378F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QBQ-00007J-7V; Tue, 17 Mar 2026 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAM-0006ml-Ng
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAI-00038j-KD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icavOFnsmAC1wS6wmw3ja7szZzT5oFLYJ+Vr5KEo2/o=;
 b=iHeaZtPfE10PIRbVNjEQNFZlkDTU22N63c6WY2brM8shI9TI+nKgz4QHR0pn21JoLpvtwj
 5lHPlekww8407EYiMXcGm1fWp5gqbc7eVpyz+POKV3g1nZCZPPlASjW3L7/MAj03WttQhT
 9PDSkctZU5pq6c0mInWvlIy7OUGh/VQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-A5NN-3EcOcGAobn7FNQlgQ-1; Tue,
 17 Mar 2026 04:52:36 -0400
X-MC-Unique: A5NN-3EcOcGAobn7FNQlgQ-1
X-Mimecast-MFC-AGG-ID: A5NN-3EcOcGAobn7FNQlgQ_1773737555
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D1519560AF
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:35 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8735619560B1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:34 +0400
Subject: [PATCH 20/60] ui/console-vc: decouple VT100 display updates via
 function pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-20-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sHcJ5/rnJHucB0PSSk12z+Rxraq4pYFLDXw8PVc5SzA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXai0p2aqEA0q0cKMoGNQf1cVq2kYTT+91LJ
 rO6Q64oE8mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5VKFD/9zpnYIKxm9GTDlYuQ3zy+4/iMOfCRGvLAjUPXTMM0pUUYI5KotAsxs2glVpsUwdsqL7E0
 /BfPli+rcUhGTqrDRa1OHNbAkCoCDVmZRgPQr9+uJ+sQGssWZIiG93CweWeHNK+3yP1drahA8i1
 ZPxbeApjQEDBmIrSo/DZuWm1CmEX7OoUryLnfmX48k4qC7J387D5JFwGj7i2CHQKoON2cFWylWF
 HrcvWh8x0n22HX9Wl9eNh3Pdg8kDwp59+uveLuQ817nRpiF1Chg2Tg1cLuIOEPMZ8qH9XzlKZe6
 fcrjdZROcwqmv6y0C+qJDmxDw8UuWfGcy13bEbhs+lQpq8TWlEaDYyZeA00yn4Ujeq6DTIxcS4A
 N0bN4AAcIfdYfMN9vlEBTTMmAL2Nk+QdETDGBZL4xpPMszsGlYklkqDjbnGW08N2fxxmj2WdAmh
 6EY41u8oA8yJGIxHJlg9dIbDIw7L6T7rI5o70hNYMD+uSFDQlWAT9T8hCaTsulHRLh8ZpwRWwYF
 O72AAzoMpRYSaeRYPoM2oylyX8AuMKzgMGr5KbHVMvTTGRFXXXFIlGPWPzEJFOjhazi7veKhJji
 uQLNF8NEjWRxxbRnsWOfz3faejZcNOOgQjcEse8lvVJNsokRkGGCzErOCd7k5n2wCiSxF7rcwfU
 LA1jPLUFb4BjJXw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace direct dpy_gfx_update() calls from the VT100 emulation code
with an indirect call through a new image_update function pointer in
QemuVT100. This decouples the VT100 terminal emulation from the
QEMU display layer, allowing different backends to provide their own
image update implementation.

The QemuVT100 typedef is changed to a forward-declared struct so the
function pointer signature can reference QemuVT100 itself.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 56e2527c7a2..8a18659036f 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -48,8 +48,11 @@ enum TTYState {
     TTY_STATE_OSC,
 };
 
-typedef struct QemuVT100 {
+typedef struct QemuVT100 QemuVT100;
+
+struct QemuVT100 {
     pixman_image_t *image;
+    void (*image_update)(QemuVT100 *vt, int x, int y, int width, int height);
 
     int width;
     int height;
@@ -66,7 +69,7 @@ typedef struct QemuVT100 {
     int update_y0;
     int update_x1;
     int update_y1;
-} QemuVT100;
+};
 
 typedef struct QemuTextConsole {
     QemuConsole parent;
@@ -224,6 +227,11 @@ static void vt100_show_cursor(QemuVT100 *vt, int show)
     }
 }
 
+static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int height)
+{
+    vt->image_update(vt, x, y, width, height);
+}
+
 static void console_refresh(QemuTextConsole *s)
 {
     TextCell *c;
@@ -252,7 +260,7 @@ static void console_refresh(QemuTextConsole *s)
         }
     }
     vt100_show_cursor(&s->vt, 1);
-    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
+    vt100_image_update(&s->vt, 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -1075,9 +1083,9 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     }
     vt100_show_cursor(&s->vt, 1);
     if (s->vt.update_x0 < s->vt.update_x1) {
-        dpy_gfx_update(QEMU_CONSOLE(s), s->vt.update_x0, s->vt.update_y0,
-                       s->vt.update_x1 - s->vt.update_x0,
-                       s->vt.update_y1 - s->vt.update_y0);
+        vt100_image_update(&s->vt, s->vt.update_x0, s->vt.update_y0,
+                           s->vt.update_x1 - s->vt.update_x0,
+                           s->vt.update_y1 - s->vt.update_y0);
     }
     return len;
 }
@@ -1175,6 +1183,13 @@ void qemu_text_console_update_size(QemuTextConsole *c)
     dpy_text_resize(QEMU_CONSOLE(c), c->vt.width, c->vt.height);
 }
 
+static void text_console_image_update(QemuVT100 *vt, int x, int y, int width, int height)
+{
+    QemuTextConsole *console = container_of(vt, QemuTextConsole, vt);
+
+    dpy_gfx_update(QEMU_CONSOLE(console), x, y, width, height);
+}
+
 static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
@@ -1205,6 +1220,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     }
 
     dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
+    s->vt.image_update = text_console_image_update;
 
     s->chr = chr;
     drv->console = s;

-- 
2.53.0


