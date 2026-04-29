Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F1FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC4n-0004BM-T3; Wed, 29 Apr 2026 17:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4m-00049c-G0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4k-0003KQ-Rs
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0K2K5fhhdNzX4OBI1xp73vrW9s2JcoHKgf5KZfeWgY=;
 b=dsJztRWWaKvjxv/kDNlIqU6Oudd8KIX6Eji2vM7QTkVq3tDEME0aTQ+DpEGjMMbX4bF9hU
 +PaSfOao/1h4hd7Us2T+5/CtMiHp+40Y7cGy3KUZCDF6NWjE9X/e0QaAtzqNl+oS2k91Ru
 EPMUz/m6rSslu2k+Ue4tn7QH55KWYqY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-OxV8MbYPPzik98JKQOR5rA-1; Wed,
 29 Apr 2026 17:04:01 -0400
X-MC-Unique: OxV8MbYPPzik98JKQOR5rA-1
X-Mimecast-MFC-AGG-ID: OxV8MbYPPzik98JKQOR5rA_1777496640
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7D8F18004AD; Wed, 29 Apr 2026 21:04:00 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4ED7819560AB; Wed, 29 Apr 2026 21:03:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:41 +0400
Subject: [PATCH v3 08/26] ui/console-vc: extract vt100_input() from
 vc_chr_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-8-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2581;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OxentmOB0aHkFj9sS8PNhIY0KX1fP6rvOvIzMKx8ABo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILU9hCjHev+l7W8XAvJ9UnIAE86/cpdvkFx
 Aj2B/J7oTaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5bZ8D/9KPisxL+Ciodgx5lPxI3hvDl1zBZlCxwyWffEfmb38Do7B1hyT3U3WNN6ruDeubGMSTEV
 PZ/2548mfI2DL/SqXXlYRys0aEGGFt/Zn7BbzEABoqCa/pYbLTYJ5GuF+NuH5erpo+dgfqBALvP
 PyXHFj1BHmz5Ic50fjhcLktr+PN2q22BymRO73fGwrsu+anSzwtiOKYr/R3UHElm9W2G+xxkUNZ
 zVKwKnZDbzN0/WgLnPgNTyTEWS5MpUy2cTNpwB6Sb4diWGA1Vr2cbXqjRtJNkO9Ovl3tibs4Xwz
 UJwbX2yonbWsKI8tQDgkN5uCrYKU7VBw73A/Vu4ba4uImrl+d7H22JqZtpLbV9b4nh2lofwrlZv
 LgNhDVXiLsMNhydp0qob+IdiHym0N9yMC03Az9gaHXzUa8QpMBEs+tTsnpoPA5WTXrZD6mYtR+z
 2jHBxnqEcxxLmIEb803dKQaBSdl/Ziz0q5liZ/DXeNnxlole6JkMg0RsqVKf/OLOp1HLa2en97a
 /yyOakFlpGO9hZKAZ0JCCQf2S7VIxBo+ImZrE+uQiTR8gXGg1t2z6+pWmyjRYmeVNIxCL5RbeCB
 hbffB0KEOgXSi42WosbbbKc0s9bukztv9nIqNOJ4UnlV8GzW/veIAThculxta26GW0TtirBtLew
 U3CT/fFrttN3gWg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


