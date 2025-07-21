Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C66C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udo2t-0005nK-7h; Mon, 21 Jul 2025 06:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udo1l-0005Hb-JO
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udo1i-0001eI-07
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753094745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hu9w8EsdRBO2gt4Ezk2s6ko0SLRX1TYBOJLgk2TPqjA=;
 b=YOJ1L5g8R6fy03jzcy1viLQjRXHm9ZMfFS5L233OVEFNPLy9Bx2yHoG4xb2LKfNB1vmlIa
 X1QoF5MnO+GVnHg17pIibPoH+D2QTzW56SL3OiL390Pm2rJaaYhGOVLj3fr44WAY7lRD79
 UsqEyHEpn12XZaw0bYYd8VXPl7+eg4c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-upRs7-HbO3yz3it3Mz5sOg-1; Mon,
 21 Jul 2025 06:45:43 -0400
X-MC-Unique: upRs7-HbO3yz3it3Mz5sOg-1
X-Mimecast-MFC-AGG-ID: upRs7-HbO3yz3it3Mz5sOg_1753094742
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 940031944D01; Mon, 21 Jul 2025 10:45:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 537E519560A1; Mon, 21 Jul 2025 10:45:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 2/4] ui: add trace events for all client messages
Date: Mon, 21 Jul 2025 11:45:34 +0100
Message-ID: <20250721104536.2856423-3-berrange@redhat.com>
In-Reply-To: <20250721104536.2856423-1-berrange@redhat.com>
References: <20250721104536.2856423-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This lets us see the full flow of RFB messages received from the
client.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/trace-events | 14 +++++++++++++
 ui/vnc.c        | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/ui/trace-events b/ui/trace-events
index 3da0d5e280..3eba9ca3a8 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -48,13 +48,27 @@ vnc_msg_server_ext_desktop_resize(void *state, void *ioc, int width, int height,
 vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg audio enable state=%p ioc=%p"
 vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg audio disable state=%p ioc=%p"
 vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int channels, int freq) "VNC client msg audio format state=%p ioc=%p fmt=%d channels=%d freq=%d"
+vnc_msg_client_cut_text(void *state, void *ioc, int len) "VNC client msg cut text state=%p ioc=%p len=%u"
+vnc_msg_client_cut_text_ext(void *state, void *ioc, int len, int flags) "VNC client msg cut text state=%p ioc=%p len=%u flags=%u"
+vnc_msg_client_ext_key_event(void *state, void *ioc, int down, int sym, int keycode) "VNC client msg ext key event state=%p ioc=%p down=%u sym=%u keycode=%u"
+vnc_msg_client_framebuffer_update_request(void *state, void *ioc, int incremental, int x, int y, int w, int h) "VNC client msg framebuffer update request state=%p ioc=%p incremental=%u x=%u y=%u w=%u h=%u"
+vnc_msg_client_key_event(void *state, void *ioc, int down, int sym) "VNC client msg key event state=%p ioc=%p down=%u sym=%u"
+vnc_msg_client_pointer_event(void *state, void *ioc, int button_mask, int x, int y) "VNC client msg pointer event state=%p ioc=%p button_mask=%u x=%u y=%u"
 vnc_msg_client_set_desktop_size(void *state, void *ioc, int width, int height, int screens) "VNC client msg set desktop size  state=%p ioc=%p size=%dx%d screens=%d"
+vnc_msg_client_set_encodings(void *state, void *ioc, int limit) "VNC client msg set encodings state=%p ioc=%p limit=%u"
+vnc_msg_client_set_pixel_format(void *state, void *ioc, int bpp, int big_endian, int true_color) "VNC client msg set pixel format state=%p ioc=%p bpp=%u big_endian=%u true_color=%u"
+vnc_msg_client_set_pixel_format_rgb(void *state, void *ioc, int red_max, int green_max, int blue_max, int red_shift, int green_shift, int blue_shift) "VNC client msg set pixel format RGB state=%p ioc=%p red_max=%u green_max=%u blue_max=%u red_shift=%u green_shift=%u blue_shift=%u"
+vnc_msg_client_xvp(void *state, void *ioc, int version, int action) "VNC client msg XVP state=%p ioc=%p version=%u action=%u"
 vnc_client_eof(void *state, void *ioc) "VNC client EOF state=%p ioc=%p"
 vnc_client_io_error(void *state, void *ioc, const char *msg) "VNC client I/O error state=%p ioc=%p errmsg=%s"
 vnc_client_connect(void *state, void *ioc) "VNC client connect state=%p ioc=%p"
 vnc_client_disconnect_start(void *state, void *ioc) "VNC client disconnect start state=%p ioc=%p"
 vnc_client_disconnect_finish(void *state, void *ioc) "VNC client disconnect finish state=%p ioc=%p"
 vnc_client_io_wrap(void *state, void *ioc, const char *type) "VNC client I/O wrap state=%p ioc=%p type=%s"
+vnc_client_pixel_format(void *state, void *ioc, int bpp, int depth, int endian) "VNC client pixel format state=%p ioc=%p bpp=%u depth=%u endian=%u"
+vnc_client_pixel_format_red(void *state, void *ioc, int max, int bits, int shift, int mask) "VNC client pixel format red state=%p ioc=%p max=%u bits=%u shift=%u mask=%u"
+vnc_client_pixel_format_green(void *state, void *ioc, int max, int bits, int shift, int mask) "VNC client pixel format green state=%p ioc=%p max=%u bits=%u shift=%u mask=%u"
+vnc_client_pixel_format_blue(void *state, void *ioc, int max, int bits, int shift, int mask) "VNC client pixel format blue state=%p ioc=%p max=%u bits=%u shift=%u mask=%u"
 vnc_client_throttle_threshold(void *state, void *ioc, size_t oldoffset, size_t offset, int client_width, int client_height, int bytes_per_pixel, void *audio_cap) "VNC client throttle threshold state=%p ioc=%p oldoffset=%zu newoffset=%zu width=%d height=%d bpp=%d audio=%p"
 vnc_client_throttle_incremental(void *state, void *ioc, int job_update, size_t offset) "VNC client throttle incremental state=%p ioc=%p job-update=%d offset=%zu"
 vnc_client_throttle_forced(void *state, void *ioc, int job_update, size_t offset) "VNC client throttle forced state=%p ioc=%p job-update=%d offset=%zu"
diff --git a/ui/vnc.c b/ui/vnc.c
index a16be468b9..c309882ddb 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2314,6 +2314,25 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
     vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
     vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;
     vs->client_endian = big_endian_flag ? G_BIG_ENDIAN : G_LITTLE_ENDIAN;
+    trace_vnc_client_pixel_format(vs, vs->ioc,
+                                  vs->client_pf.bits_per_pixel,
+                                  vs->client_pf.depth,
+                                  vs->client_endian);
+    trace_vnc_client_pixel_format_red(vs, vs->ioc,
+                                      vs->client_pf.rmax,
+                                      vs->client_pf.rbits,
+                                      vs->client_pf.rshift,
+                                      vs->client_pf.rmask);
+    trace_vnc_client_pixel_format_green(vs, vs->ioc,
+                                        vs->client_pf.gmax,
+                                        vs->client_pf.gbits,
+                                        vs->client_pf.gshift,
+                                        vs->client_pf.gmask);
+    trace_vnc_client_pixel_format_blue(vs, vs->ioc,
+                                       vs->client_pf.bmax,
+                                       vs->client_pf.bbits,
+                                       vs->client_pf.bshift,
+                                       vs->client_pf.bmask);
 
     if (!true_color_flag) {
         send_color_map(vs);
@@ -2388,6 +2407,17 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         if (len == 1)
             return 20;
 
+        trace_vnc_msg_client_set_pixel_format(vs, vs->ioc,
+                                              read_u8(data, 4),
+                                              read_u8(data, 6),
+                                              read_u8(data, 7));
+        trace_vnc_msg_client_set_pixel_format_rgb(vs, vs->ioc,
+                                                  read_u16(data, 8),
+                                                  read_u16(data, 10),
+                                                  read_u16(data, 12),
+                                                  read_u8(data, 14),
+                                                  read_u8(data, 15),
+                                                  read_u8(data, 16));
         set_pixel_format(vs, read_u8(data, 4),
                          read_u8(data, 6), read_u8(data, 7),
                          read_u16(data, 8), read_u16(data, 10),
@@ -2410,12 +2440,19 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
             memcpy(data + 4 + (i * 4), &val, sizeof(val));
         }
 
+        trace_vnc_msg_client_set_encodings(vs, vs->ioc, limit);
         set_encodings(vs, (int32_t *)(data + 4), limit);
         break;
     case VNC_MSG_CLIENT_FRAMEBUFFER_UPDATE_REQUEST:
         if (len == 1)
             return 10;
 
+        trace_vnc_msg_client_framebuffer_update_request(vs, vs->ioc,
+                                                        read_u8(data, 1),
+                                                        read_u16(data, 2),
+                                                        read_u16(data, 4),
+                                                        read_u16(data, 6),
+                                                        read_u16(data, 8));
         framebuffer_update_request(vs,
                                    read_u8(data, 1), read_u16(data, 2), read_u16(data, 4),
                                    read_u16(data, 6), read_u16(data, 8));
@@ -2424,12 +2461,19 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         if (len == 1)
             return 8;
 
+        trace_vnc_msg_client_key_event(vs, vs->ioc,
+                                       read_u8(data, 1),
+                                       read_u32(data, 4));
         key_event(vs, read_u8(data, 1), read_u32(data, 4));
         break;
     case VNC_MSG_CLIENT_POINTER_EVENT:
         if (len == 1)
             return 6;
 
+        trace_vnc_msg_client_pointer_event(vs, vs->ioc,
+                                           read_u8(data, 1),
+                                           read_u16(data, 2),
+                                           read_u16(data, 4));
         pointer_event(vs, read_u8(data, 1), read_u16(data, 2), read_u16(data, 4));
         break;
     case VNC_MSG_CLIENT_CUT_TEXT:
@@ -2461,9 +2505,12 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                 vnc_client_error(vs);
                 break;
             }
+            trace_vnc_msg_client_cut_text_ext(vs, vs->ioc,
+                                              dlen, read_u32(data, 8));
             vnc_client_cut_text_ext(vs, dlen, read_u32(data, 8), data + 12);
             break;
         }
+        trace_vnc_msg_client_cut_text(vs, vs->ioc, read_u32(data, 4));
         vnc_client_cut_text(vs, read_u32(data, 4), data + 8);
         break;
     case VNC_MSG_CLIENT_XVP:
@@ -2478,6 +2525,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         if (len == 4) {
             uint8_t version = read_u8(data, 2);
             uint8_t action = read_u8(data, 3);
+            trace_vnc_msg_client_xvp(vs, vs->ioc, version, action);
 
             if (version != 1) {
                 error_report("vnc: xvp client message version %d != 1",
@@ -2511,6 +2559,10 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
             if (len == 2)
                 return 12;
 
+            trace_vnc_msg_client_ext_key_event(vs, vs->ioc,
+                                               read_u16(data, 2),
+                                               read_u32(data, 4),
+                                               read_u32(data, 8));
             ext_key_event(vs, read_u16(data, 2),
                           read_u32(data, 4), read_u32(data, 8));
             break;
-- 
2.50.1


