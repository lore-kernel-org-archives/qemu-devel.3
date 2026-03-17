Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3D8F33820
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QCK-0001a1-9n; Tue, 17 Mar 2026 04:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QB3-0007kz-Cj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QB1-0003Df-Io
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6iBwh7SNoVfaJ2LXhz1UHz1mkTyYheJKXjvVaHYuPQ=;
 b=OOwbs4w/PwNcwDcVBI1S2YQ6IiVwCxI09Djs+Ma42Rw0dQfqI4tTH3WLKT24ol6yCD+MhM
 Zgd5zn98PlwCqHDVNSjt4zJIoweZuGwl0FuYeonm1oLYZVtUHRp7/DoISo28BQkix8Fx1X
 ro4ISvsPuMSMTvc/gik/f5+iOqJJ1+g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-LJgHamrxNBGmIJwg8ci3bg-1; Tue,
 17 Mar 2026 04:53:21 -0400
X-MC-Unique: LJgHamrxNBGmIJwg8ci3bg-1
X-Mimecast-MFC-AGG-ID: LJgHamrxNBGmIJwg8ci3bg_1773737600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 884F3180061A
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81AB41955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:42 +0400
Subject: [PATCH 28/60] ui/console-vc: extract vt100_input() from vc_chr_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-28-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tpF3wLAlBoCVCTJK4D6eHSvDy4HtuaSf8JKMiatOB5Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbmNfHiI7WTrjHnTVoPGU+Ox2NYNmpjC+Nf
 XFA2oXNdJqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5S7JD/0W/q0t9F1EgcclWfXtFpVO+lr+k+Qq2A3wTZhBwoG3b8idWzfugZcpGnFJStDxKCUJQ5T
 E6GaU4veMVzHAw3kboZbzoaa3P61l8ftZjsw8J9uZElcEXdgUQnzlBFfvVnmSdnXbXIlCo9l3n2
 TOl/XlKItho7rYOaX2Eh/DH1+UR5Ksph3swN9Fitz8xXbfiWLS2uM0NNBqczHvJlRrdt1qDBFNq
 4GPndBmT6doVv9md+IdfwkiyCsXXdp4nQ1ZUQyBb/KGNL39Ztss/RlDkx3qFtASo3h2j5G4P7bQ
 VZTD13NtW+2ATRSYmei7s9Ig4T67qBONxu2QR4QXzWVVl7OVKukbwYG2JTilyBeZRKJJ9dU24f+
 pSWqrSjfBFaa9siUh0xYuh+B3pXXYibzLjiXjl9FrCRnC3Lz0aVGR8H5nhMB5WKT3s1arut0ea4
 x0sIz9BZ1ufDCfcxNAslj6fFPBbEFeOHpVMDihpXVRMzas8qfA7XBsOrK7DqqqDui0Xi034WykK
 Ohm5g7SsHyxAeSStmJpNwxyDYnvQb88t2hMge+V7hgFbwiKgp6B+XkvmSv7kQKwWl7yUXaCkJkS
 Ba7l7a3Tgpp3SKf/k44e+unldSRfad8tyikzKbgDAPjiZxb2NQGm1FfJH9O0BPEvI/lPFX5rAH6
 MX2MPuZfCgYfHfQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move the VT100 input processing logic out of vc_chr_write() into a new
vt100_input() function that operates on QemuVT100 directly, rather than
going through the Chardev/VCChardev layers. This continues the effort
to decouple the VT100 emulation from the chardev backend, making the
VT100 layer self-contained and reusable.

vc_chr_write() becomes a thin wrapper that extracts the QemuVT100 from
the chardev and delegates to vt100_input().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 87881c072ee..3ef492c2d4c 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1058,29 +1058,35 @@ static void vt100_putchar(QemuVT100 *vt, int ch)
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
                          TYPE_CHARDEV_VC)
 
-static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len)
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


