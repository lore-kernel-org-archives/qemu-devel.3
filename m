Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD4F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQI-0000Xt-D3; Fri, 10 Apr 2026 15:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQ9-0008Lq-IJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQ7-0001dN-Tw
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nlf2o8mRqacvDJSwzpHGOMMjfkTarzsBxasECZnZ52w=;
 b=SI2xdqCST6qvYRJ06ADo3p61qOaJFnVsGFAuAL9OKj4Tmo3oETNupjlIkm1vkIv9NoYT+K
 at1tc0q4mmKeeahZI0Rdlmwu7MqZ/DQ5WWxlT2QWmMKjV8HEpL/0OA2eA7/YLhHh1Nbt2e
 PIAJDQbYca7vzPtvYYwaba9C0ZVwJ2k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-iGkVYhm7Mp27tI82cdbnXw-1; Fri,
 10 Apr 2026 15:21:31 -0400
X-MC-Unique: iGkVYhm7Mp27tI82cdbnXw-1
X-Mimecast-MFC-AGG-ID: iGkVYhm7Mp27tI82cdbnXw_1775848891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0573B195609D; Fri, 10 Apr 2026 19:21:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB5E11800357; Fri, 10 Apr 2026 19:21:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:48 +0400
Subject: [PATCH v2 26/67] ui/console-vc: extract vt100_input() from
 vc_chr_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-26-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2581;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TYkIOGSAidOPC1GAUAmf1ai1B20Ef3cKVdaaYTLqsSc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UC+ZcTORFPunFNKAFArqyjf73drBZpEU6O
 PZgTCUA3QqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5d76EACknccvmeujT9lmEtJYNq5TH/2P28Av+Tfxl13hAFDh5fKsr1Zc8VthN9h4y/E7CqM92Hh
 PJYFcbtZrRYIhltxj/dKCstiB+kll0R40PG2jyNsTNDE886PXgX0LbC2dJZykKrYX++FVqW6RBX
 6jPYMT5DLohLmRYSF+5SoyS6uVo+Uz98HvKFWNoYtiOtKpcS+5zFAGzCyKeFKbUXZIRN0sxCrMc
 MHqRy8MqaLSBtluQ+M1xwajPoimVHbEsRMqHTRImGDUTinEY0LA2VQg8dcaCcTDrrUqqowT3V/j
 +pKxCXCRmm311+O4jNIu5UwMAl7BTBmSctGO6MrvcvhiZnccsVDOGypIsfddB4NUOqRKQahM7F8
 WZ0Ze/xCV2ozfpur9cZ+2iXYAr1STvBaXDQ3F/kvBFqRpHzaxPVyAeqdMK0YetZqa9QtJbcBW0G
 2Tpe8FOS7v9z423UCOnBDHNLkG66BdmlX7FZVlx06ilqiyLB9fYo1nV51e6hZiYQN7Ce9cItaoV
 I9naMIlfdsftN1gBt6z/JBhtRng270pBeMQZ4GgSwibU8l7Xms5nx+hkG4qaCnmhIsUSbLE6dRj
 a18bwhiD0PvkAGsVc2OaX0F15EK9XGD9fz81CorQX8FWWCWCPy/CVF6sZdTmRKIq6ZuSG/kdt1z
 uT10k5nel20LK6Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 5cfb3dfcf72..15600128380 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1057,29 +1057,35 @@ static void vt100_putchar(QemuVT100 *vt, int ch)
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
2.53.0


