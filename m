Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A4AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 10:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BWI-0002yF-Ey; Wed, 15 May 2024 06:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7BWG-0002vq-7L
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7BWE-0001kJ-4w
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715767553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LlgPJlx0hNx/4u3ZBlyUxKUvU9bvckSVjUz4/zc6ZqM=;
 b=bAMnOABRbO34XUu6qWPY1lCEN3oOiYC3gRRCGiyCBxREZco8MgeGORqlwgMQ/sA0LwLofl
 WlYqPwjPBwfkqwAca8N2ZZozbeIE0KXQagJpEXfF5iEV3x4ojdgebflB4+D41VKv4hGvLv
 c4Kkbh96AoXgKsBZYlZof5wLk1F0gIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Oc47N2dyMDSTLsb3coDC0Q-1; Wed, 15 May 2024 06:05:24 -0400
X-MC-Unique: Oc47N2dyMDSTLsb3coDC0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C49E5800CB1;
 Wed, 15 May 2024 10:05:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DAEC51BF;
 Wed, 15 May 2024 10:05:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/console: Only declare variable fence_fd when CONFIG_GBM is
 defined
Date: Wed, 15 May 2024 12:05:20 +0200
Message-ID: <20240515100520.574383-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This to avoid a build breakage :

../ui/gtk-egl.c: In function ‘gd_egl_draw’:
../ui/gtk-egl.c:73:9: error: unused variable ‘fence_fd’ [-Werror=unused-variable]
   73 |     int fence_fd;
      |         ^~~~~~~~

Fixes: fa6426805b12 ("ui/console: Use qemu_dmabuf_set_..() helpers instead")
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 ui/gtk-egl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0473f689c915f8b2303cd9d11bc7d8336c2a85ba..9831c10e1bd58f76d8f803ad0a72d983adc3f490 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -68,9 +68,9 @@ void gd_egl_draw(VirtualConsole *vc)
     GdkWindow *window;
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+    int fence_fd;
 #endif
     int ww, wh, ws;
-    int fence_fd;
 
     if (!vc->gfx.gls) {
         return;
-- 
2.45.0


