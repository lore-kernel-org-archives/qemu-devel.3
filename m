Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E4CF9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4C-0000Yc-I8; Wed, 22 Apr 2026 06:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3O-0008Qw-3Z
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3L-000382-S6
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJKCg7641BPQde71EDRdv/xyHviBbVx3TiROaLgKfLU=;
 b=BezoI9hV5FvkaM9sc8DAr6W71uhoCswZVSB1SwlYQEQ0elMEYZ5rkmJcAdLB18Ql9aVLQB
 pQOXRa9jYZQs1UlH/hvdaYy5J9Wexg8Ki7MXAZfuT0CM0tPDpO0qV7MBSJSj8qZseAf9Dy
 pz0shIm/e3miaGm0IxaC6mTGC/JY/Qg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-BuwdL1QkNEuMRmbEYRNx2Q-1; Wed,
 22 Apr 2026 06:43:29 -0400
X-MC-Unique: BuwdL1QkNEuMRmbEYRNx2Q-1
X-Mimecast-MFC-AGG-ID: BuwdL1QkNEuMRmbEYRNx2Q_1776854608
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6135195608D; Wed, 22 Apr 2026 10:43:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C46E3000C15; Wed, 22 Apr 2026 10:43:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 26/40] ui/console-vc: move vc_put_lf() to VT100 layer as
 vt100_put_lf()
Date: Wed, 22 Apr 2026 14:40:27 +0400
Message-ID: <20260422104042.3936506-27-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Decouple the line-feed handling from VCChardev by operating on
QemuVT100 directly. The function no longer needs the chardev or
console pointers — callers pass &s->vt instead. This continues the
effort to make the VT100 terminal emulation self-contained.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 00de9291d3d..2de096db3ac 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -432,10 +432,8 @@ static void vt100_set_image(QemuVT100 *vt, pixman_image_t *image)
     vt->cells = cells;
 }
 
-static void vc_put_lf(VCChardev *vc)
+static void vt100_put_lf(QemuVT100 *vt)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int x, y1;
 
@@ -626,7 +624,7 @@ static void vc_put_one(VCChardev *vc, int ch)
     if (vt->x >= vt->width) {
         /* line wrap */
         vt->x = 0;
-        vc_put_lf(vc);
+        vt100_put_lf(vt);
     }
     y1 = (vt->y_base + vt->y) % vt->total_height;
     c = &vt->cells[y1 * vt->width + vt->x];
@@ -792,7 +790,7 @@ static void vc_putchar(VCChardev *vc, int ch)
             vt->x = 0;
             break;
         case '\n':  /* newline */
-            vc_put_lf(vc);
+            vt100_put_lf(&s->vt);
             break;
         case '\b':  /* backspace */
             if (vt->x > 0)
@@ -801,7 +799,7 @@ static void vc_putchar(VCChardev *vc, int ch)
         case '\t':  /* tabspace */
             if (vt->x + (8 - (vt->x % 8)) > vt->width) {
                 vt->x = 0;
-                vc_put_lf(vc);
+                vt100_put_lf(vt);
             } else {
                 vt->x = vt->x + (8 - (vt->x % 8));
             }
-- 
2.53.0


