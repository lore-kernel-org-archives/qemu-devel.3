Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934DDF3381D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QC9-0001SK-72; Tue, 17 Mar 2026 04:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAm-0007HO-Q5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAk-0003Bc-1J
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdRppLzXKV0kIBE71z9E6Q4mBRLBwBrL/zR1buSZoNM=;
 b=a5r6vKXWefvfAS5A8gflEBnJRyVTn+bspGZNTDLCli3A/w+Y6U4QPT/wvL21wLwC8vpzMD
 od1jTEXOjk6px1naj1wcD3s15zxva3xh5NplBMIYcA6kKi1/0prFoKN8gmGUsxHNQ8e9HA
 zP/UmZe0ZUkRlKpTrEvwxMLlmurO5rs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-dXb2IO_AOtO2RTEUZhzmhw-1; Tue,
 17 Mar 2026 04:53:03 -0400
X-MC-Unique: dXb2IO_AOtO2RTEUZhzmhw-1
X-Mimecast-MFC-AGG-ID: dXb2IO_AOtO2RTEUZhzmhw_1773737583
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F139B18002D7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E445D1955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:39 +0400
Subject: [PATCH 25/60] ui/console-vc: move vc_put_lf() to VT100 layer as
 vt100_put_lf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-25-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4710;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pRlgbfn1PFr4rWekZjwkVZ7xjuyL5zukyCJBzUrOO0E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXb6PQidHGdSHdfO2vzTJt89u3w4qX6Ua2R2
 Aiozul6Bx2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5bGND/sE5PUZ+Ww8TGEkgUtu0SyEyp23iGJBpxZ1PdvYz1Git934LMKMqhHh+xA44hCzs8JwHTe
 QRLrw7Q9B0qD05BN3rS53IjqtNm5Pejq9C2xWN29P6+pd43HTOUcSiRjOdJ9mdcODb0nkRQEQOE
 3oycHXS05COm6pRdehSbcvBMFuxP1TB88USySylNaTodxYyIQE/XZ/Bw1AWGQ7+yi9+T8JAOYZ4
 uAcF4eRgy9OcjJmLoBaf66r51Dohc+p3xsxAsxu8Hw7x7hUEf4/Oyx6YlKyWIQpCUINNRhpdxRG
 HFxydhrAcCv//lblk4xUWZYB8/mcwRBI7kX4niWCQKj0ueYeaxJoAWSQ9KToLvAvW8pw7rFA53p
 zN4QuLMjnCv5HtUGVG/ob0GQ8NTdTjgBU4TyOma71WVKh0xOiHz/4gSs63FqPSSf4eOY4RPVHc3
 zVOvBOmlk66oCRmkH0NB1ozqj/NtLWbt7vLDqPI8NEQDGALksMiYLCtMx5qDj8HWKAuGz7x2lup
 MbFBiC0MgryHLDU7q3ek8zsWE5RZZKwlcxqNhicTkIY2jNDDCy81I556YobhPrJdKcxbJJ3Xo4r
 iQYLjisJ/ggR/2eYsP8sPnJ40YtuBO4MtqhN2/EcviaSTkGVPHZ5wNcVPM2WiiH10RjQZymJWEg
 C69Qb3mi7zBWO8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Decouple the line-feed handling from VCChardev by operating on
QemuVT100 directly. The function no longer needs the chardev or
console pointers — callers pass &s->vt instead. This continues the
effort to make the VT100 terminal emulation self-contained.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 65 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index efb10c2f8f7..4ea9f88f55a 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -433,47 +433,46 @@ static void vt100_set_image(QemuVT100 *vt, pixman_image_t *image)
     vt->cells = cells;
 }
 
-static void vc_put_lf(VCChardev *vc)
+static void vt100_put_lf(QemuVT100 *vt)
 {
-    QemuTextConsole *s = vc->console;
     TextCell *c;
     int x, y1;
 
-    s->vt.y++;
-    if (s->vt.y >= s->vt.height) {
-        s->vt.y = s->vt.height - 1;
+    vt->y++;
+    if (vt->y >= vt->height) {
+        vt->y = vt->height - 1;
 
-        if (s->vt.y_displayed == s->vt.y_base) {
-            if (++s->vt.y_displayed == s->vt.total_height)
-                s->vt.y_displayed = 0;
+        if (vt->y_displayed == vt->y_base) {
+            if (++vt->y_displayed == vt->total_height)
+                vt->y_displayed = 0;
         }
-        if (++s->vt.y_base == s->vt.total_height)
-            s->vt.y_base = 0;
-        if (s->vt.backscroll_height < s->vt.total_height)
-            s->vt.backscroll_height++;
-        y1 = (s->vt.y_base + s->vt.height - 1) % s->vt.total_height;
-        c = &s->vt.cells[y1 * s->vt.width];
-        for(x = 0; x < s->vt.width; x++) {
+        if (++vt->y_base == vt->total_height)
+            vt->y_base = 0;
+        if (vt->backscroll_height < vt->total_height)
+            vt->backscroll_height++;
+        y1 = (vt->y_base + vt->height - 1) % vt->total_height;
+        c = &vt->cells[y1 * vt->width];
+        for(x = 0; x < vt->width; x++) {
             c->ch = ' ';
             c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
-        if (s->vt.y_displayed == s->vt.y_base) {
-            s->vt.text_x[0] = 0;
-            s->vt.text_y[0] = 0;
-            s->vt.text_x[1] = s->vt.width - 1;
-            s->vt.text_y[1] = s->vt.height - 1;
-
-            image_bitblt(s->vt.image, 0, FONT_HEIGHT, 0, 0,
-                         s->vt.width * FONT_WIDTH,
-                         (s->vt.height - 1) * FONT_HEIGHT);
-            image_fill_rect(s->vt.image, 0, (s->vt.height - 1) * FONT_HEIGHT,
-                            s->vt.width * FONT_WIDTH, FONT_HEIGHT,
+        if (vt->y_displayed == vt->y_base) {
+            vt->text_x[0] = 0;
+            vt->text_y[0] = 0;
+            vt->text_x[1] = vt->width - 1;
+            vt->text_y[1] = vt->height - 1;
+
+            image_bitblt(vt->image, 0, FONT_HEIGHT, 0, 0,
+                         vt->width * FONT_WIDTH,
+                         (vt->height - 1) * FONT_HEIGHT);
+            image_fill_rect(vt->image, 0, (vt->height - 1) * FONT_HEIGHT,
+                            vt->width * FONT_WIDTH, FONT_HEIGHT,
                             color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
-            s->vt.update_x0 = 0;
-            s->vt.update_y0 = 0;
-            s->vt.update_x1 = s->vt.width * FONT_WIDTH;
-            s->vt.update_y1 = s->vt.height * FONT_HEIGHT;
+            vt->update_x0 = 0;
+            vt->update_y0 = 0;
+            vt->update_x1 = vt->width * FONT_WIDTH;
+            vt->update_y1 = vt->height * FONT_HEIGHT;
         }
     }
 }
@@ -664,7 +663,7 @@ static void vc_put_one(VCChardev *vc, int ch)
     if (s->vt.x >= s->vt.width) {
         /* line wrap */
         s->vt.x = 0;
-        vc_put_lf(vc);
+        vt100_put_lf(&s->vt);
     }
     y1 = (s->vt.y_base + s->vt.y) % s->vt.total_height;
     c = &s->vt.cells[y1 * s->vt.width + s->vt.x];
@@ -842,7 +841,7 @@ static void vc_putchar(VCChardev *vc, int ch)
             s->vt.x = 0;
             break;
         case '\n':  /* newline */
-            vc_put_lf(vc);
+            vt100_put_lf(&s->vt);
             break;
         case '\b':  /* backspace */
             if (s->vt.x > 0)
@@ -851,7 +850,7 @@ static void vc_putchar(VCChardev *vc, int ch)
         case '\t':  /* tabspace */
             if (s->vt.x + (8 - (s->vt.x % 8)) > s->vt.width) {
                 s->vt.x = 0;
-                vc_put_lf(vc);
+                vt100_put_lf(&s->vt);
             } else {
                 s->vt.x = s->vt.x + (8 - (s->vt.x % 8));
             }

-- 
2.53.0


