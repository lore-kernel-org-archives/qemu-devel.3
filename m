Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89644C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2gU-0006v5-Am; Thu, 20 Aug 2026 09:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2gT-0006uv-6j
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2gR-0001wy-Gi
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787231990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4TccqqUXknIcLrqxhOkuScQWmomsQrljevArxnRazKU=;
 b=fm182IB5B9XBEsL9FgEjZ0F7JyRq+7KWsmLazwNKJvvCsD4skz3XM0x2qFbSdeU+Waxs0h
 r8haPudnY2iXDvk69BFcUKL3AC9Vr2vZyRMRd6Fd9RNUvDm14Ro3VV9sKgdDPlxNblya4i
 lJivV5d0zwsiw86rJ80KD5NWoY8Daa4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-8Y4EuOeBMZqGEsdLQ89rTg-1; Thu,
 20 Aug 2026 09:19:40 -0400
X-MC-Unique: 8Y4EuOeBMZqGEsdLQ89rTg-1
X-Mimecast-MFC-AGG-ID: 8Y4EuOeBMZqGEsdLQ89rTg_1787231979
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7870D195604B; Thu, 20 Aug 2026 13:19:39 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 836AB180034C; Thu, 20 Aug 2026 13:19:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/egl: fix qemu_egl_display type
Date: Thu, 20 Aug 2026 17:19:33 +0400
Message-ID: <20260820131933.2729240-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

EGLDisplay is already a pointer type (void *), so declaring
qemu_egl_display as EGLDisplay * makes it void **, which
doesn't match any of its usages.

Fixes: 7ced9e9f6da2 ("ui: add egl-helpers")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/egl-helpers.h | 2 +-
 ui/egl-helpers.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 405ddd912591..679c79eacd54 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -9,7 +9,7 @@
 #include "ui/console.h"
 #include "ui/shader.h"
 
-extern EGLDisplay *qemu_egl_display;
+extern EGLDisplay qemu_egl_display;
 extern EGLConfig qemu_egl_config;
 extern DisplayGLMode qemu_egl_mode;
 extern bool qemu_egl_angle_d3d;
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index d689f187c4e5..4ebf364397c1 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -25,7 +25,7 @@
 #include "trace.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
-EGLDisplay *qemu_egl_display;
+EGLDisplay qemu_egl_display;
 EGLConfig qemu_egl_config;
 DisplayGLMode qemu_egl_mode;
 bool qemu_egl_angle_d3d;
-- 
2.55.0.543.g5ebe2ebe4ea8


