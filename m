Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EA0CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcTb-0001FS-GB; Tue, 13 Oct 2026 09:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTZ-0001F2-Nv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTX-0004dU-L3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8OxsOCPd2u9GzRP9mLF8s/FyzLYtpDnFiV0xR3zOfY=;
 b=NRXj2Cn32ae0Oi+EO/nc27ciOSpPCWFNj/jniTskW2txiNY4DMo8vXSQTAaChs3yJrnOSu
 h942YJj2bZXeE2g5JAF2WjJYzgdXhN5Lo3QXIFCDbjRFoTN+m++6m1OlhX3Az07L5292Xm
 gthgb/dZgD9d229VgWkykhEdAwfLyoE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-Gqq0dMZ_PImSyfRoOpl-wQ-1; Tue,
 13 Oct 2026 13:23:25 +0000
X-MC-Unique: Gqq0dMZ_PImSyfRoOpl-wQ-1
X-Mimecast-MFC-AGG-ID: Gqq0dMZ_PImSyfRoOpl-wQ_1791897804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5498E1828AB4; Tue, 13 Oct 2026 13:23:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 206FB180057E; Tue, 13 Oct 2026 13:23:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:22:58 +0400
Subject: [GIT PULL 01/40] ui/spice-app: honor gl=off option, reject core/es
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-1-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cYHDkSlvRgd2UDY8DWMvrvKDuOHytDafK9rcJSXI/4k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDBEiByRDd7cMz+o/sjQVlNfQs4O8GC3fEi6
 ynPLk9N86WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwQAKCRDa6OEJdZac
 5efwEACdya65BJ8wjog4/ICEUrUs6yPChY4PlQaY8uV+AZck66TCiywLsQxV8kNOpjoPRwemOuC
 b0kg7EFat+Kx3Go5hBZNReUT+wDlAzcbviSg+twk+mxDGY6ZjtvGF18CEUsJ8BNqIJ8f1qCmiiJ
 1/1JfNk/QR9EaxWSJqKFkp16efwX2unzx+R81t9mCRmXpyN3AW8tgd6KGbc69U/aqTVb7HW3DWE
 BbVkH9+uXk0nCc0X3sARQ4Gb8Wac8gACUX7cGnuEcyzxwVC7XhzMqwxcG9Jw6MAIVn/3nJwznqH
 jsBRhy0w2SFmc+N4lepcS95AD/ZjO1N5FbvExm3wdLnMUSTzo0X34AFiqctM3+++Ds94WCpL7A5
 Xf/xXoLps43VRFOPcYIG55GeQ8M917oyzYOKXX2pYR8iYrhex1JXFscN7LxGhGJtLIw7grJyZj3
 f18WSPkM7R3sAJp6GxF3NimgTR/E8FksS+MYLe75CFu13dHQJuG0cKDRMGXQlTSuTgNadnq8j3z
 Y5vHt7ZS7+MCMMmrlSqcgWEaAYweEX7OvdABze86u2xZMMIXHtEzy/FD7/mwJ7a6H9mfNTBgOtO
 fSvC6OHqjDOAL0Hjq84YlGO5Q9Zfc2QbcemB0tUIHOUadc6OFqKGVABG8/jERTRpJLOaUubzgJU
 noWKuNp1jI6VJpw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With -display spice-app, the value of the gl option is ignored: gl=off
enables OpenGL exactly like gl=on. Only omitting the option keeps OpenGL
disabled.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4639
Fixes: d8aec9d9f129 ("display: add -display spice-app launching a Spice client")
Reported-by: @jeremie.b
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.56.0.116.g6de20f6092dc


