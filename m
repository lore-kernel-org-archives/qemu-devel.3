Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E252ECD37B2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcGK-0006is-L4; Sat, 09 May 2026 03:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcG6-0006Zl-NZ
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcG5-00079l-AN
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iwc3OYHOoHTjXjkRX9blRiADAqmjvRfyL5oI3mbLZM=;
 b=TsU1dT/6GPQzhQmxph2/bGgEqW5d/FI4e2/kYITOeSngOZm3OMKGDO1WiOLRAG7rMa7yvY
 ZMv3tTm9pmOaqrnX2i5X1+7TNm8o0SUXDGwcPzzfIfegban4B2er4gJV10mddxBqRBkRyJ
 1ueD0rU6T8+l8fWMEPFAldAamQpwUoE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-WTOX5yq1OiKa4xLCQ6aJTA-1; Sat,
 09 May 2026 03:37:51 -0400
X-MC-Unique: WTOX5yq1OiKa4xLCQ6aJTA-1
X-Mimecast-MFC-AGG-ID: WTOX5yq1OiKa4xLCQ6aJTA_1778312270
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBA36180034C; Sat,  9 May 2026 07:37:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 809B319560A7; Sat,  9 May 2026 07:37:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 15/32] ui/console-vc: extract vt100_input() from vc_chr_write()
Date: Sat,  9 May 2026 11:36:01 +0400
Message-ID: <20260509073621.1011778-16-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move the VT100 input processing logic out of vc_chr_write() into a new
vt100_input() function that operates on QemuVT100 directly, rather than
going through the Chardev/VCChardev layers. This continues the effort
to decouple the VT100 emulation from the chardev backend, making the
VT100 layer self-contained and reusable.

vc_chr_write() becomes a thin wrapper that extracts the QemuVT100 from
the chardev and delegates to vt100_input().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index cf1adfc3c71..024ab277e0b 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1059,29 +1059,35 @@ static void vt100_putchar(QemuVT100 *vt, int ch)
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
                          TYPE_CHARDEV_VC)
 
-static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t vt100_input(QemuVT100 *vt, const uint8_t *buf, size_t len)
 {
-    VCChardev *drv = VC_CHARDEV(chr);
-    QemuTextConsole *s = drv->console;
     int i;
 
-    s->vt.update_x0 = s->vt.width * FONT_WIDTH;
-    s->vt.update_y0 = s->vt.height * FONT_HEIGHT;
-    s->vt.update_x1 = 0;
-    s->vt.update_y1 = 0;
-    vt100_show_cursor(&s->vt, 0);
+    vt->update_x0 = vt->width * FONT_WIDTH;
+    vt->update_y0 = vt->height * FONT_HEIGHT;
+    vt->update_x1 = 0;
+    vt->update_y1 = 0;
+    vt100_show_cursor(vt, 0);
     for(i = 0; i < len; i++) {
-        vt100_putchar(&s->vt, buf[i]);
+        vt100_putchar(vt, buf[i]);
     }
-    vt100_show_cursor(&s->vt, 1);
-    if (s->vt.update_x0 < s->vt.update_x1) {
-        vt100_image_update(&s->vt, s->vt.update_x0, s->vt.update_y0,
-                           s->vt.update_x1 - s->vt.update_x0,
-                           s->vt.update_y1 - s->vt.update_y0);
+    vt100_show_cursor(vt, 1);
+    if (vt->update_x0 < vt->update_x1) {
+        vt100_image_update(vt, vt->update_x0, vt->update_y0,
+                           vt->update_x1 - vt->update_x0,
+                           vt->update_y1 - vt->update_y0);
     }
     return len;
 }
 
+static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    VCChardev *drv = VC_CHARDEV(chr);
+    QemuTextConsole *s = drv->console;
+
+    return vt100_input(&s->vt, buf, len);
+}
+
 void vt100_update_cursor(void)
 {
     QemuVT100 *vt;
-- 
2.54.0


