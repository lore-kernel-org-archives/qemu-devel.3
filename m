Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA10F45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPl-0006CA-F5; Fri, 10 Apr 2026 15:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPJ-00059V-8H
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPH-0001Dw-6k
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzw0Q7jMhFS0CoqoqexwKXYGuuONVk8KgOpTU6X44uM=;
 b=ghtcvanhfLeFMsADe2qeAp6wOQMFQVXeZDYlQO0BILXAqrFiSNkZgq76toWSwXfIYOf8+y
 gNILu+9QlSrKTMjNh8Omm5lqS6tC5InMjAxvIOACqQHwhHRoOy0pQAViAv7KwybdnRLYkU
 o+eLwC/uV0g8yT03ohoak82bNHVzFjs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-Ub6Cv9fSM9-U5Yzm9hE_iw-1; Fri,
 10 Apr 2026 15:20:38 -0400
X-MC-Unique: Ub6Cv9fSM9-U5Yzm9hE_iw-1
X-Mimecast-MFC-AGG-ID: Ub6Cv9fSM9-U5Yzm9hE_iw_1775848838
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF328180034C; Fri, 10 Apr 2026 19:20:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D049D195608E; Fri, 10 Apr 2026 19:20:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:39 +0400
Subject: [PATCH v2 17/67] ui/console-vc: make show_cursor() take vt100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-17-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+MJMtm41zBshumDQWeZwFchRZmla0eMFHyqBboYlYwo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UGQCSmj+OldGGyA9i77jQ878tmP6Pc3ITH
 pLbwbHSHAKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5SqgD/97+RkVyBjeuglfl75mfumZ/yZm/7dbuf5OqVEMor3dKFyhAXcIQslj/EgOWtvVnAd0JX8
 EyvjnrzZJUiXvzYtWxxBoLbghl+8AWH+sFYiYKJrJscypzZWaE2BwLliSUC8JQEKheko2VmEu14
 AuvZjYaXhQz36Bu+qT3CJ2/RB/5px4CmZq6ICx9WhEkeuBYRS4TbK0zGfCXO2WrxZ7QychQ9B9+
 d1t8lpcgFMJYkuJpLII79Nqf4TTlInjAPUY5C9Y2BmWtu/0kvhdk8nV/8pr9L/Y7rDR+ZWLyu0/
 uCNNQ3G0L8jxe1RTlp0+eIvw0RJQ6lAMbCKgW7k2Y5k8RA30lX7DMrnBj04CSSgB/ztFRvr1VXh
 lKlmdlt23UJUzQCo+fX1AangdmUh84Dj7va9Jc3DGiu07M9/azFeRT2eto9wC0NigM7OXwSo/VQ
 qMD140wKNGBh5SdMInIXKcE3lTjsKqyO3WLNYRca90L+xspW5w2AKqtdf0/vWx+cLzwKwVZwgcu
 u69+GQwFpcaUruWEetts7SYrS1XPP9kQBc8NWdYu7XZJDhAGm4NNyqDGELnQl5SnV+MIFLRjLy1
 lcWT0GUJjtHWrHvHjPiXGrzYuCDojFL1Ca909yx+ZA7De1AxgOOcG4hiciF/Xmsi9cYQY7c/o60
 ZKnmYjATFXsRcqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Decouples glyph rendering from the console object,
continuing the QemuVT100 abstraction introduced in the previous commits.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 9566ce592f2..61d72a0cc27 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -195,9 +195,8 @@ static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
     }
 }
 
-static void console_show_cursor(QemuTextConsole *s, int show)
+static void vt100_show_cursor(QemuVT100 *vt, int show)
 {
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int y, y1;
     int x = vt->x;
@@ -217,11 +216,11 @@ static void console_show_cursor(QemuTextConsole *s, int show)
         if (show && cursor_visible_phase) {
             TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
-            vt100_putcharxy(&s->vt, x, y, c->ch, &t_attrib);
+            vt100_putcharxy(vt, x, y, c->ch, &t_attrib);
         } else {
-            vt100_putcharxy(&s->vt, x, y, c->ch, &(c->t_attrib));
+            vt100_putcharxy(vt, x, y, c->ch, &(c->t_attrib));
         }
-        vt100_invalidate_xy(&s->vt, x, y);
+        vt100_invalidate_xy(vt, x, y);
     }
 }
 
@@ -253,7 +252,7 @@ static void console_refresh(QemuTextConsole *s)
             y1 = 0;
         }
     }
-    console_show_cursor(s, 1);
+    vt100_show_cursor(&s->vt, 1);
     dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
 }
 
@@ -1084,11 +1083,11 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     vt->update_y0 = vt->height * FONT_HEIGHT;
     vt->update_x1 = 0;
     vt->update_y1 = 0;
-    console_show_cursor(s, 0);
+    vt100_show_cursor(vt, 0);
     for(i = 0; i < len; i++) {
         vc_putchar(drv, buf[i]);
     }
-    console_show_cursor(s, 1);
+    vt100_show_cursor(vt, 1);
     if (vt->update_x0 < vt->update_x1) {
         dpy_gfx_update(QEMU_CONSOLE(s), vt->update_x0, vt->update_y0,
                        vt->update_x1 - vt->update_x0,

-- 
2.53.0


