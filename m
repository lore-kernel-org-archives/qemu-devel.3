Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87407C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiqS-00060E-S4; Mon, 06 Jul 2026 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgiqG-0005wj-O0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgiqF-000879-4Q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783342470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjErVZm9Wr2QI+kVTSz8W7d34vni0oT36iz299wkMnA=;
 b=XzTcpK9Z7lIXLRlbTj4qcWUrsI90MyXyJ8H0s5v1cftKn+DczhnDei+qkirx5QG9/qJS4S
 NdMHNw0OkqnE5IUCvvjpQNheil9pQ91aWA9EUEuqpCq67xoiFB4AnNTY6LHrjeT39+gnIc
 sLn5+qswJDsI5DzIHvPFFfG7P0bK0mg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-0UuMTXsuMQK_B2gMTSjV4g-1; Mon,
 06 Jul 2026 08:54:27 -0400
X-MC-Unique: 0UuMTXsuMQK_B2gMTSjV4g-1
X-Mimecast-MFC-AGG-ID: 0UuMTXsuMQK_B2gMTSjV4g_1783342466
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C50A18009C3; Mon,  6 Jul 2026 12:54:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C5203000715; Mon,  6 Jul 2026 12:54:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:51 +0400
Subject: [PATCH 4/5] ui/vnc: use RFB wire types for client message handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-4-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4266;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ev9TNnw8x9m9l5HmAYMhEjTZybjblq9VWu37R67PYjM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6VnNG2P1La5hNCD/TfhGcAh2IepUbEYvhYZX
 W+yjpr22eyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5YPNEAC0DhcSsO7EYZTArxnP8kXhDTGXHR5k+gBDzLeJFpskrTu2jfvqov+vAXCRAkU17RyJKVb
 XYkpGosSnio4Ss9hJu25QlBi1WMkalbTLl39sI6WpoBDEGBPkLfk2wRcs9KrIYZz3awV0f8/SSG
 nLug9vPpABRCLvZ4aFlvQQrUhNjwb5zQf5saD27a+wUVGntGWTRcZLP7yFdN1qTnWWXhwWq9jiJ
 kK0vhmUcpk+K3q0I8gNTeyzOsxFfb7lDR3XFwagTA+1Qu7UW0k9km8cL6D0X6IwxnAh3jlMG95y
 mmBDI4Zdu+ggp7SScIOKLo/+Q0+1D1JtIP1rgstZniqvxWZG8MHrp/u5eSMMCuD4Vdo3EUoyn7U
 fXzM78WIv1wPH7+Qd9IfCpjF/RlOj6fukng2fvw2zpMuDw8ot9UmRasaOST3ud4+srEoOGdRdG6
 KFF6Hk+04/at7gIy2hLP6YKTt7x8aTnpRKhnDvooPJDZZRL67W9mDN27nyBSYgAfFhspQkaRinz
 hRp7Mh4gemRtNN3Cq/UJJGkJLCe/XmS78fFO9Adyk1Hh+4TbaZ9/5IYF8fj8Wcd4WUyKMzhQG2w
 032mF8gFEjdDPfS/2uZtIkGBpSR3pxAzoWu420x6hvroCCAkYett3kivI5DzU7fw0MZgbNJq2Wi
 XuQ/Am748sAzM2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Use exact-width unsigned types for the static functions that process
RFB client messages, matching the types returned by read_u8(),
read_u16(), and read_u32():

 - set_pixel_format: uint8_t/uint16_t for pixel format fields
 - pointer_event: uint8_t button_mask, uint16_t x/y
 - key_event/ext_key_event: bool down, uint32_t sym/keycode
 - do_key_event: uint32_t sym
 - framebuffer_update_request: uint8_t incremental, uint16_t x/y/w/h

Drop needless declarations.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 94a38242c56..14ce2816907 100644
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

-- 
2.55.0


