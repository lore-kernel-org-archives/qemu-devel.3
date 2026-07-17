Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99ABC44521
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8F-0003nN-04; Fri, 17 Jul 2026 07:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8D-0003ms-LW
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8C-0003Pb-4P
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=frFHV5VMh2gEjRHqpI6AwiiG7GghoSraVhgp1HhS+bQ=;
 b=AMY35lrjoA+nhE3thudiKp298OiKDQ4u8hZYDBFKpEldJBP0TfaovcrMnbGNPuU2w0X/87
 tS6TSDVbfXXtqsY+MMANbe3JRBRBM4WbAyu1LcBvHBeu0AEbUqDtPy5+8KOdt2CaObD7tf
 EaBX3goE+80MFR9wYMsIYZm/E77OvFg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-ZPDYTL5pOvavuM34fq_Vsw-1; Fri,
 17 Jul 2026 07:53:26 -0400
X-MC-Unique: ZPDYTL5pOvavuM34fq_Vsw-1
X-Mimecast-MFC-AGG-ID: ZPDYTL5pOvavuM34fq_Vsw_1784289205
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69BFB1955EA2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44897D73
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:43 +0400
Subject: [GIT PULL 04/15] ui/vnc: use RFB wire types for client message
 handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-4-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5375;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6LsiLUnImPepfr0mO2WpkW/ljNDW3QtTc4An2CVWOSw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheZX/KorIc5JZJzUwY5k5IW7FTCDG3SWZDzK
 gyCc6Ey+FaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmQAKCRDa6OEJdZac
 5UN5D/4yPGLMYPH/1ZMD1Cq2qihAm7b/+zoUzaT4C0RyvsYW/9PKKFxnxsvr87gxJPDfLXlDWQ5
 TLi7gsUOsqO2YAcBfPOnJWFMyrhGmfAkXZZVllNF+ndSp7twVU7Zq0USVdMsaCGLy6CTi0XbdgM
 qTjOsU/m9S8IfIcDr21blxiv+aIJ+wehGNxuJ1I+fz1qm1uTovHUyiYqmRFbc66nF+Cz9x4JuoI
 Qm5mAahH9pwFxK2t5mESkA+dPdDrPW6Ki5qEMVuHYgTnKJ23JAFci5lq44RtZXqkreCSsptJeMR
 xjReY4EQeaVYkOs/gq0bOkkjMAw/EPOuG0nXxF39VMly9HMVIo5f6DybhhRIM6rswo6CA14xwnR
 xK1sOhpuQaHsHqT1l2qmzEMVlFOooF7J8jZ3NtSTzWChTBdF8bK6DwvvRG3UyKikfTrbJQx31Vx
 NKlRTeHwlyIb09Awd/2pHrN4ZTSn8PojKpdPcJaWaugAMtN8Z+ukBVpfs7a6aOXM8DMCWdeHDP2
 qCT+tL8It36JqbH6s9e1v8WBn14Enf6y6jR6yCrIR5mwRgCG9MxbPYY+S3g30aF8+XRXtVBzgca
 NumRVU6Y2PyfgfhbxsJGsp/XSINlZQlNpHVqnkW8gZBGmZEOts6iNcfyWHDtrPMT/lL2yA1EECl
 tvH+Jf0AHN+P3NA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Use exact-width unsigned types for the static functions that process
RFB client messages, matching the types returned by read_u8(),
read_u16(), and read_u32():

 - set_pixel_format: uint8_t/uint16_t for pixel format fields
 - pointer_event: uint8_t button_mask, uint16_t x/y
 - key_event/ext_key_event: bool down, uint32_t sym/keycode
 - do_key_event: uint32_t sym
 - framebuffer_update_request: uint8_t incremental, uint16_t x/y/w/h

Drop needless declarations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9219f593d95..8d91cee4d9f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -608,15 +608,7 @@ bool vnc_display_reload_certs(const char *id, Error **errp)
    3) resolutions > 1024
 */
 
-static int vnc_update_client(VncState *vs, int has_dirty);
-static void vnc_disconnect_start(VncState *vs);
-
 static void vnc_colordepth(VncState *vs);
-static void framebuffer_update_request(VncState *vs, int incremental,
-                                       int x_position, int y_position,
-                                       int w, int h);
-static void vnc_refresh(DisplayChangeListener *dcl);
-static int vnc_refresh_server_surface(VncDisplay *vd);
 
 static int vnc_width(VncDisplay *vd)
 {
@@ -1763,7 +1755,8 @@ static void check_pointer_type_change(Notifier *notifier, void *data)
     vs->absolute = absolute;
 }
 
-static void pointer_event(VncState *vs, int button_mask, int x, int y)
+static void pointer_event(VncState *vs, uint8_t button_mask,
+                          uint16_t x, uint16_t y)
 {
     static uint32_t bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]       = 0x01,
@@ -1841,7 +1834,7 @@ static void kbd_leds(Notifier *notifier, void *data)
     }
 }
 
-static void do_key_event(VncState *vs, int down, int keycode, int sym)
+static void do_key_event(VncState *vs, int down, int keycode, uint32_t sym)
 {
     unsigned int lnx = qemu_input_key_number_to_linux(keycode);
 
@@ -2019,7 +2012,7 @@ static const char *code2name(int keycode)
     return QKeyCode_str(qemu_input_key_number_to_qcode(keycode));
 }
 
-static void key_event(VncState *vs, int down, uint32_t sym)
+static void key_event(VncState *vs, bool down, uint32_t sym)
 {
     int keycode;
     int lsym = sym;
@@ -2034,8 +2027,8 @@ static void key_event(VncState *vs, int down, uint32_t sym)
     do_key_event(vs, down, keycode, sym);
 }
 
-static void ext_key_event(VncState *vs, int down,
-                          uint32_t sym, uint16_t keycode)
+static void ext_key_event(VncState *vs, bool down,
+                          uint32_t sym, uint32_t keycode)
 {
     /* if the user specifies a keyboard layout, always use it */
     if (keyboard_layout) {
@@ -2046,8 +2039,9 @@ static void ext_key_event(VncState *vs, int down,
     }
 }
 
-static void framebuffer_update_request(VncState *vs, int incremental,
-                                       int x, int y, int w, int h)
+static void framebuffer_update_request(VncState *vs, uint8_t incremental,
+                                       uint16_t x, uint16_t y,
+                                       uint16_t w, uint16_t h)
 {
     if (incremental) {
         if (vs->update != VNC_STATE_UPDATE_FORCE) {
@@ -2250,10 +2244,11 @@ static void send_color_map(VncState *vs)
     vnc_unlock_output(vs);
 }
 
-static void set_pixel_format(VncState *vs, int bits_per_pixel,
-                             int big_endian_flag, int true_color_flag,
-                             int red_max, int green_max, int blue_max,
-                             int red_shift, int green_shift, int blue_shift)
+static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
+                             uint8_t big_endian_flag, uint8_t true_color_flag,
+                             uint16_t red_max, uint16_t green_max,
+                             uint16_t blue_max, uint8_t red_shift,
+                             uint8_t green_shift, uint8_t blue_shift)
 {
     if (!true_color_flag) {
         /* Expose a reasonable default 256 color map */
@@ -2286,15 +2281,15 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
     vs->client_pf.rmax = red_max ? red_max : 0xFF;
     vs->client_pf.rbits = ctpopl(red_max);
     vs->client_pf.rshift = red_shift;
-    vs->client_pf.rmask = red_max << red_shift;
+    vs->client_pf.rmask = (uint32_t)red_max << red_shift;
     vs->client_pf.gmax = green_max ? green_max : 0xFF;
     vs->client_pf.gbits = ctpopl(green_max);
     vs->client_pf.gshift = green_shift;
-    vs->client_pf.gmask = green_max << green_shift;
+    vs->client_pf.gmask = (uint32_t)green_max << green_shift;
     vs->client_pf.bmax = blue_max ? blue_max : 0xFF;
     vs->client_pf.bbits = ctpopl(blue_max);
     vs->client_pf.bshift = blue_shift;
-    vs->client_pf.bmask = blue_max << blue_shift;
+    vs->client_pf.bmask = (uint32_t)blue_max << blue_shift;
     vs->client_pf.bits_per_pixel = bits_per_pixel;
     vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
     vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;

-- 
2.55.0


