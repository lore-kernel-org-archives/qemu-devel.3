Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6D1CF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJwL-0001it-4g; Thu, 03 Oct 2024 07:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwF-0001Jn-4p
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwB-0004zU-1y
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UU2orHXi/BSaeuFJ2dFG3p9R7+3Imog/8OR1UiqXm3s=;
 b=TI04sUkB9BMIhD7h0KbMtiLEj7GfcaCuNGTXo8E9k6t9X4ik3RlWlsPMmmmrhNHnspVsZY
 j7XgQhm+2Ov9hm1L/iRsqjXS5GGPGffPM1Ol9rqtTloZ2WiAxNBJTZoIvMLXUqgjq/HPDL
 LBJC9iBRsgO7vU1rz2pNcp/4AQSSTPU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-ii7wm8c-MYyFFceob_Q33g-1; Thu,
 03 Oct 2024 07:23:45 -0400
X-MC-Unique: ii7wm8c-MYyFFceob_Q33g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34E62195423C; Thu,  3 Oct 2024 11:23:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24F311956054; Thu,  3 Oct 2024 11:23:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 11/16] ui/dbus: add trace for can_share_map
Date: Thu,  3 Oct 2024 15:22:38 +0400
Message-ID: <20241003112244.3340697-12-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 1 +
 ui/trace-events    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 020c05198b..f55e197768 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -1083,6 +1083,7 @@ dbus_display_listener_new(const char *bus_name,
     ddl->console = console;
 
     dbus_display_listener_setup_shared_map(ddl);
+    trace_dbus_can_share_map(ddl->can_share_map);
     dbus_display_listener_setup_d3d11(ddl);
 
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
diff --git a/ui/trace-events b/ui/trace-events
index fb253c1666..3da0d5e280 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -166,6 +166,7 @@ dbus_clipboard_unregister(const char *bus_name) "peer %s"
 dbus_scanout_texture(uint32_t tex_id, bool backing_y_0_top, uint32_t backing_width, uint32_t backing_height, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "tex_id:%u y0top:%d back:%ux%u %u+%u-%ux%u"
 dbus_gl_gfx_switch(void *p) "surf: %p"
 dbus_filter(unsigned int serial, unsigned int filter) "serial=%u (<= %u)"
+dbus_can_share_map(bool share) "can_share_map: %d"
 
 # egl-helpers.c
 egl_init_d3d11_device(void *p) "d3d device: %p"
-- 
2.45.2.827.g557ae147e6


