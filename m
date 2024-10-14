Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0797D16266
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LJS-0001Cn-JI; Mon, 14 Oct 2024 09:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LJQ-00018R-5B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LJO-00040I-QJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728913237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWsI9SwHhIzKFlX7OZDBlAv2wQLqzoCkRBUZVwdj6QI=;
 b=WgHwaCz/wVhP7vHa43cJB8yxWCtHIGjYKFXWaypBv+0xJZ2C9BJrdIxa0pdM5TLC1nv/Yu
 FdqCCSuRx6hx9uitXkyo5UG6IvkGQhHgI0k8Tj1fvnlQkbWhbqsrvIQaIWuBrLWAWUe1Vh
 l8vsL8earMlQdfRWizQ+/XlmvrrBX6w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-sawv3cajPh-0IUScfWH2oA-1; Mon,
 14 Oct 2024 09:40:35 -0400
X-MC-Unique: sawv3cajPh-0IUScfWH2oA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9F7519560BE; Mon, 14 Oct 2024 13:40:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59578300019B; Mon, 14 Oct 2024 13:40:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/20] ui/dbus: add trace for can_share_map
Date: Mon, 14 Oct 2024 17:39:26 +0400
Message-ID: <20241014133935.470709-12-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-1-marcandre.lureau@redhat.com>
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-12-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 1 +
 ui/trace-events    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index eca6890ce6..7142afcddb 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -1089,6 +1089,7 @@ dbus_display_listener_new(const char *bus_name,
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
2.47.0


