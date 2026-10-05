Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF26BCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDen2-0006P4-B5; Mon, 05 Oct 2026 05:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDemr-0006Kf-4k
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDemp-0003jk-AZ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791191706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cU+3+3lASwMsrLCLtAptIsTn+Br4e014q2H1agJhfE0=;
 b=ESITAGSP5U9t+/XplUmsQPEtVF5DeNJdHWpkhstTHYx7jrgnOARskDhAhIS+ReNrPKShaU
 WrtxgZfMVpZc5FmnY0gIaT+iTl+vryaOUILknqA2khdPZENOIgvPeBR2zD5iBqArk5OQ51
 LRgId+SI7x9/XO2zUo/RQMymlG5oFEU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-i7xtj-h2MK2vDv-Y1mt47w-1; Mon,
 05 Oct 2026 05:15:04 -0400
X-MC-Unique: i7xtj-h2MK2vDv-Y1mt47w-1
X-Mimecast-MFC-AGG-ID: i7xtj-h2MK2vDv-Y1mt47w_1791191703
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0BDC180A21B
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 09:15:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE7681800345; Mon,  5 Oct 2026 09:15:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/spice-app: honor gl=off option, reject core/es
Date: Mon,  5 Oct 2026 13:15:00 +0400
Message-ID: <20261005091459.737182-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With -display spice-app, the value of the gl option is ignored: gl=off
enables OpenGL exactly like gl=on. Only omitting the option keeps OpenGL
disabled.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4639
Fixes: d8aec9d9f129 ("display: add -display spice-app launching a Spice client")
Reported-by: @jeremie.b
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-app.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index fe3df62bfa5d..90e8de0bc87d 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -180,8 +180,14 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     qemu_opt_set(qopts, "image-compression", "off", &error_abort);
     qemu_opt_set(qopts, "streaming-video", "off", &error_abort);
 #ifdef HAVE_SPICE_GL
-    qemu_opt_set(qopts, "gl", opts->has_gl ? "on" : "off", &error_abort);
-    display_opengl = opts->has_gl;
+    if (opts->has_gl &&
+        opts->gl != DISPLAY_GL_MODE_ON &&
+        opts->gl != DISPLAY_GL_MODE_OFF) {
+        error_report("spice-app only supports gl=on/off");
+        exit(1);
+    }
+    display_opengl = opts->has_gl && opts->gl != DISPLAY_GL_MODE_OFF;
+    qemu_opt_set(qopts, "gl", display_opengl ? "on" : "off", &error_abort);
 #endif
 }
 
-- 
2.56.0.rc0.29.g47ce80527c56


