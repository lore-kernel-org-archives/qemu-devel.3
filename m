Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C69EDA69C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSnR-0002mn-7O; Tue, 03 Mar 2026 11:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vxSnP-0002mb-5x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vxSnD-0005ob-V8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772556014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t8u602C9Q/wNZVt3luVyi3m3X/+imtMU6KMp7n4fBEI=;
 b=NvAba8GpKFe0xIjpbvcOvGroK+NZt0DxUkVkOxcrzkzrmFYrovqzAKJKWa9pndjk6aRqru
 GowUgJBDHWbi26GIjVjz12IiJoYBiynnBFBOvr/2rLO99j6x/01jR2nvh9lhc3HnIsjmej
 Td/lTw2R2Y3ZvTNwV9gYkRCYF5KiMWQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-uCchg5QlORmB9JN8hshNCg-1; Tue,
 03 Mar 2026 11:40:12 -0500
X-MC-Unique: uCchg5QlORmB9JN8hshNCg-1
X-Mimecast-MFC-AGG-ID: uCchg5QlORmB9JN8hshNCg_1772556012
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52B1B1955DB6
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2026 16:39:46 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A00F71800590; Tue,  3 Mar 2026 16:39:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/dbus-listener: Fix FBO leak in dbus_cursor_dmabuf
Date: Tue,  3 Mar 2026 17:39:43 +0100
Message-ID: <20260303163943.153613-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

cursor_fb is a local egl_fb that gets an FBO allocated via
egl_fb_setup_for_tex but is never destroyed, leaking the
framebuffer object on every cursor update.

Add egl_fb_destroy() after the cursor data has been read.

Fixes: commit 142ca628a7 ("ui: add a D-Bus display backend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 3e2b4adf41f..fff7cf83274 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -660,6 +660,7 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
     egl_fb_setup_for_tex(&cursor_fb, width, height, texture, false);
     ds = qemu_create_displaysurface(width, height);
     egl_fb_read(ds, &cursor_fb);
+    egl_fb_destroy(&cursor_fb);
 
     v_data = g_variant_new_from_data(
         G_VARIANT_TYPE("ay"),
-- 
2.53.0


