Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A56C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 19:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb2gp-0007z7-C2; Thu, 23 Jan 2025 14:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gK-0007xv-C7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gI-0003D4-Rh
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737659757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSMHnQ0UwvJD5TIVkw1wFllAM/T0myUxbmcejTHwe3Y=;
 b=YhYCCiCvNpunBnXfPKhwcm6Qwj/BMj8DULHCADkklCM3mFx/nAsGtEKvPeWR6Jah4xY+a8
 liNijzr12EnQl3O7F7mXxecYppcL2Czga21DyvSRUoUWBP1x0Z/Hm6i/KH9KcH7H8uyL36
 RZT600J64LXaSVHlht2Hl2eKY+8HwLs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-K1ky4SWjOLKkztVSPMrQpw-1; Thu,
 23 Jan 2025 14:15:56 -0500
X-MC-Unique: K1ky4SWjOLKkztVSPMrQpw-1
X-Mimecast-MFC-AGG-ID: K1ky4SWjOLKkztVSPMrQpw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B27031955DDE
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 19:15:55 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86BC03003E7F; Thu, 23 Jan 2025 19:15:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 5/6] ui/sdl: load cursor in RGBA8888 format not BGRA8888
Date: Thu, 23 Jan 2025 19:15:35 +0000
Message-ID: <20250123191536.142753-6-berrange@redhat.com>
In-Reply-To: <20250123191536.142753-1-berrange@redhat.com>
References: <20250123191536.142753-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The SDL code was loading cursor data in BGRA8888 format which masked the
problem with virtio-gpu not supplying data in RGBA8888 format. Now that
virtio-gpu is fixed, the SDL code needs to be fixed to match.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/sdl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 445eb1dd9f..2d56b4d174 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -772,7 +772,7 @@ static void sdl_mouse_define(DisplayChangeListener *dcl,
 
     guest_sprite_surface =
         SDL_CreateRGBSurfaceFrom(c->data, c->width, c->height, 32, c->width * 4,
-                                 0xff0000, 0x00ff00, 0xff, 0xff000000);
+                                 0xff, 0x00ff00, 0xff0000, 0xff000000);
 
     if (!guest_sprite_surface) {
         fprintf(stderr, "Failed to make rgb surface from %p\n", c);
-- 
2.47.1


