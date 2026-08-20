Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA0C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2h3-0007O6-VW; Thu, 20 Aug 2026 09:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2gx-0007NA-SZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2gw-0002DT-17
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DmJY7P6FbVpRr5KGmsxn+4oNMJ8HWqXGhUgwqBWMjTc=;
 b=hlXlK1kx5B6wgZyVtY56MTD9Ppf1aKfiY52rXnqyToNN6Hsrb1xfTB2i23XGBtx1JaIAwE
 hK9jHEmMlzRTa+hcOdcn/RyBOyTbKi+kgehEywjD6xevhbWG+FyIoYuRagw24Swls1WkpO
 6TX0ucJpMdFS2EJleV5IUjWNGjVgGpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-xFAVw6g_NF6XyHRTNqBNAQ-1; Thu,
 20 Aug 2026 09:20:18 -0400
X-MC-Unique: xFAVw6g_NF6XyHRTNqBNAQ-1
X-Mimecast-MFC-AGG-ID: xFAVw6g_NF6XyHRTNqBNAQ_1787232017
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58DBF1956094; Thu, 20 Aug 2026 13:20:17 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BF521800577; Thu, 20 Aug 2026 13:20:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/egl: fix render node cleanup order
Date: Thu, 20 Aug 2026 17:20:14 +0400
Message-ID: <20260820132014.2729748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

ASAN detected some memory leaks when terminating. Release thread-bound
EGL state first, destroy the context and terminate the display while the
GBM device is still alive, then destroy GBM and close the render-node
fd.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/egl-helpers.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 4ebf364397c1..8e3729a54d15 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -736,19 +736,22 @@ bool egl_init(const char *rendernode, DisplayGLMode mode, Error **errp)
 
 void egl_cleanup(void)
 {
+    if (qemu_egl_display) {
+        eglReleaseThread();
+    }
+
     if (qemu_egl_rn_ctx) {
         eglDestroyContext(qemu_egl_display, qemu_egl_rn_ctx);
         qemu_egl_rn_ctx = NULL;
     }
 
+    if (qemu_egl_display) {
+        eglTerminate(qemu_egl_display);
+        qemu_egl_display = NULL;
+    }
+
 #ifdef CONFIG_GBM
     g_clear_pointer(&qemu_egl_rn_gbm_dev, gbm_device_destroy);
     g_clear_fd(&qemu_egl_rn_fd, NULL);
 #endif
-
-    if (qemu_egl_display) {
-        eglReleaseThread();
-        eglTerminate(qemu_egl_display);
-        qemu_egl_display = NULL;
-    }
 }
-- 
2.55.0.543.g5ebe2ebe4ea8


