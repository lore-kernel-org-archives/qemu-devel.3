Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BCCF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPk-000613-F5; Fri, 10 Apr 2026 15:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPE-00051f-37
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPB-0001Aq-Jt
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Zn7scE4lRCbc2GAfCsAVHlUaaYW/OSWPb6ggmWUO1c=;
 b=ay3qL9Ko4/HQkmFF6coWUtig9OO7aGnGhW+MoS/tFHUlHe3WqSZXKKzA9abhRFoimKgxn+
 gUM2ZztM+uJGRa6Ujx3C5a2Jq8Ec8wtKZIq76v+pXkAnG+D1ntFU7VU/vUhsKmCvyujq9j
 72z4KDzg6nifSy+efXLlyPg+RAkG0/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-0Y_XP9TWOxqWfo6igi5P8Q-1; Fri,
 10 Apr 2026 15:20:33 -0400
X-MC-Unique: 0Y_XP9TWOxqWfo6igi5P8Q-1
X-Mimecast-MFC-AGG-ID: 0Y_XP9TWOxqWfo6igi5P8Q_1775848832
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 252BE180057A; Fri, 10 Apr 2026 19:20:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0053A180049F; Fri, 10 Apr 2026 19:20:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:38 +0400
Subject: [PATCH v2 16/67] ui/console-vc: make invalidate_xy() take vt100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-16-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jvcgWFNlKqlrN3nVcfOXq9ZC2/xDMncef+UtF1pVUuQ=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0U4AM+QDPfGOpu9rVejfoMBydoLI85vdCIg
 fuurh5dRjGJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5eReD/jh99E1jBIhmZFu6EH1u+gN9rCYVbQAt93K5FTBe7UKKtuE2lJOx7Zx3yBTCn6uBLDy3hu
 qLNmKbr2mzrS2vRRhH4INv0EV3fKYfwn7ilJwbo1DJQkBZH1ouJi66Jiyd39xQc8c+XPvaJA9S4
 EZmoKoRzGULXNcPxuZ6ORdbSdgqraPZ0f1Bk9vp2VvZo6JvIgl2QyCInPrlZ3JxUplY6UB3CbPS
 XE2L4+p7SFkLDelLMSi1NUBdhF8I+yoYghSvbw7Dz0bo2OpqK4tOBPEFHj1pK1ZnDEpFaE55H1m
 xxeACkHmh54H2zPVB4VmNT+P/LIiQctndp8uCwEo9FJxWzb3FFcRizddWWb/CXiQFGPDs+yrPMZ
 fU1wet6DRPEErB6lsBxepWHOIhE+c//oIkfyOIuIV47GG3KVpCov0GQCN/s0OoAJ/fYVOcbG9tP
 IRAVdQwTnOSoPB/EAkTIqTtiMtGEb5UmR2p1cIk7RjmETaccdAHJeRGwp5pLTLqfaDsQ5ypoumw
 hjui2QJUBPNFfmcksDAAZRE1N7KT4w3MBK3I2iP+rIg8ZhbUWKNl+7DrE3m+t4BvjfjaTOfEjwL
 mMnwWkWQzj6f1j1YZxj6E1tYIJTFPMIlb/kRx0bPdtF77VPgA9PHY1xH/cb/Jj0foZa0IjdYEby
 5dRdKfZWbP3x4
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This decouples glyph rendering from the console object, continuing the
QemuVT100 abstraction introduced in the previous commits.

Style fixes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index cf087c64fb2..9566ce592f2 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -179,21 +179,20 @@ static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
                              &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
 }
 
-static void invalidate_xy(QemuTextConsole *s, int x, int y)
+static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
 {
-    QemuVT100 *vt = &s->vt;
-
-    if (!qemu_console_is_visible(QEMU_CONSOLE(s))) {
-        return;
-    }
-    if (vt->update_x0 > x * FONT_WIDTH)
+    if (vt->update_x0 > x * FONT_WIDTH) {
         vt->update_x0 = x * FONT_WIDTH;
-    if (vt->update_y0 > y * FONT_HEIGHT)
+    }
+    if (vt->update_y0 > y * FONT_HEIGHT) {
         vt->update_y0 = y * FONT_HEIGHT;
-    if (vt->update_x1 < (x + 1) * FONT_WIDTH)
+    }
+    if (vt->update_x1 < (x + 1) * FONT_WIDTH) {
         vt->update_x1 = (x + 1) * FONT_WIDTH;
-    if (vt->update_y1 < (y + 1) * FONT_HEIGHT)
+    }
+    if (vt->update_y1 < (y + 1) * FONT_HEIGHT) {
         vt->update_y1 = (y + 1) * FONT_HEIGHT;
+    }
 }
 
 static void console_show_cursor(QemuTextConsole *s, int show)
@@ -222,7 +221,7 @@ static void console_show_cursor(QemuTextConsole *s, int show)
         } else {
             vt100_putcharxy(&s->vt, x, y, c->ch, &(c->t_attrib));
         }
-        invalidate_xy(s, x, y);
+        vt100_invalidate_xy(&s->vt, x, y);
     }
 }
 
@@ -594,7 +593,7 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
         c = &vt->cells[y1 * vt->width + x];
         vt100_putcharxy(vt, x, y2, c->ch,
                       &(c->t_attrib));
-        invalidate_xy(s, x, y2);
+        vt100_invalidate_xy(&s->vt, x, y2);
     }
 }
 

-- 
2.53.0


