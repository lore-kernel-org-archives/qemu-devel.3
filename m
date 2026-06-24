Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700FBCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0U-0000ek-0E; Wed, 24 Jun 2026 07:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0R-0000RP-CG
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0P-0007tF-NH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VibF4DmB6a6Uyf/7xkd4O1Y9CakUPfyDVFz6fwYFSs=;
 b=exZbjasyQaCp47/vmZDa7fUS1PJJeg2AULSxXXluZkK4egTN+I9sa5IErvm0NzsdVGkKcv
 HwhY9aB9AZA2aC43Q5ouRRU+2G9SF+0fEfcmkVah8iaV/TuHFoKK6HIIusvDV9Vf55RFXX
 NbPPYrK6e5fid7FZISm24dXpqLuimxM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-JP0FjHReP9uizHgEr53r5A-1; Wed,
 24 Jun 2026 07:42:55 -0400
X-MC-Unique: JP0FjHReP9uizHgEr53r5A-1
X-Mimecast-MFC-AGG-ID: JP0FjHReP9uizHgEr53r5A_1782301374
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B46231955F7D
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E7BB180058F; Wed, 24 Jun 2026 11:42:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:37 +0400
Subject: [GIT PULL 15/35] ui: add display cleanup infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-15-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3413;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WDzykKKwrOZpaWrlBWb2f++u8+iW4l0VtaHrZraNq3Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JnfiiLQScfgE5JGWrcpgZgL0aYTNBHPySzR
 JZlRkII1Z2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5R2bEACQGfaEee6I2rze4+G0j4e0LSiCzsypNIpWphDNpgJ98/DYDRvL480ovZKo2gS79YZeaqd
 jYfIIi8zVgHqYmjBHIu/TKAgNVufty2eQhFmgLlUUoBv7YroaVIJtclSnrsdWDl8SyOxur5H+Go
 WWWtp9aTUBS80lpjlfslAYHb6Bko57dThADhj6dj0nxr8704OaJ7KCGXFYDooqhICok8GtTaUit
 kR3S5ANt+SpF9+4a+f8+B6qxdtacVCNZeCE2WibMkdxGmsUTAm+jSK+/FRCJndeUNevkX7IOK4O
 +Gns7q39l9sJslHYYWNIVYmIYZlRo3ZSHk52TclkNfNAlcaWgWrm5jRTN8w5I3Byv6JLPNceeol
 r8fd/U7r3J9IYZbX6RXaWB7X5o3yBQFhO8Pq6SQ4oMt2zrVfTguOdaEbi2Xz/6OehdaFMfy1tX2
 QS3MVbstsG0SNEeRPr/grlqmoViHDov55exk8GY0CrsVHZphjQf3qXRpceFv0phtDOE+IFvoiDO
 bZMQABL6pCtXFR+ZqwpTtro0o2ekVxkgLJB2InczIxEJc0SmHCyQ6KSJDfYFVpPo9GOJEC2K9YD
 RFDDfADPcX3A8hyOdVczK5t0FKdBWi0pMr4GjWE3DUBGzSwxeDqltifgTFUGKnMKqhmx6SSFPKz
 670l7Cm+h1fLxDw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add a cleanup callback to QemuDisplay and a qemu_display_cleanup()
function that iterates all registered display types and calls their
cleanup handler. Wire it into qemu_cleanup() in runstate.c, replacing
the ad-hoc vnc_cleanup() call.

This provides a structured alternative to atexit() handlers, giving
deterministic teardown ordering and making resource leaks visible to
sanitizers.

The cleanup should happen before user_creatable_cleanup(), since some
display have weak user-creatable references to cleanup before.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-15-4656aec3398d@redhat.com>
---
 include/ui/console.h |  2 ++
 system/runstate.c    |  8 +-------
 ui/console.c         | 20 +++++++++++++++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index b7bfecb6ee9..5322c56009d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -403,6 +403,7 @@ struct QemuDisplay {
     DisplayType type;
     void (*early_init)(DisplayOptions *opts);
     void (*init)(DisplayState *ds, DisplayOptions *opts);
+    void (*cleanup)(void);
     const char *vc;
 };
 
@@ -411,6 +412,7 @@ bool qemu_display_find_default(DisplayOptions *opts);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
 const char *qemu_display_get_vc(DisplayOptions *opts);
+void qemu_display_cleanup(void);
 void qemu_display_help(void);
 
 /* vnc.c */
diff --git a/system/runstate.c b/system/runstate.c
index d35fa270bd6..18e585be47f 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -62,7 +62,6 @@
 #include "system/system.h"
 #include "system/tpm.h"
 #include "ui/console.h"
-#include "ui/qemu-spice-module.h"
 
 #include "trace.h"
 
@@ -1046,12 +1045,7 @@ void qemu_cleanup(int status)
     audio_cleanup();
     monitor_cleanup();
     qemu_chr_cleanup();
+    qemu_display_cleanup();
     user_creatable_cleanup();
-#ifdef CONFIG_VNC
-    vnc_cleanup();
-#endif
-#ifdef CONFIG_SPICE
-    qemu_spice.cleanup();
-#endif
     /* TODO: unref root container, check all devices are ok */
 }
diff --git a/ui/console.c b/ui/console.c
index 58f29e82c85..1fe3e3a3a6c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -42,6 +42,7 @@
 #include "qemu/memfd.h"
 #include "ui/vt100.h"
 #include "vgafont.h"
+#include "ui/qemu-spice.h"
 
 #include "console-priv.h"
 
@@ -575,7 +576,7 @@ void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *gl)
 {
     /* display has opengl support */
     assert(con);
-    if (con->gl) {
+    if (gl && con->gl) {
         error_report("The console already has an OpenGL context.");
         exit(1);
     }
@@ -1414,6 +1415,23 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
     dpys[opts->type]->init(ds, opts);
 }
 
+void qemu_display_cleanup(void)
+{
+    int i;
+
+    for (i = 0; i < DISPLAY_TYPE__MAX; i++) {
+        if (dpys[i] && dpys[i]->cleanup) {
+            dpys[i]->cleanup();
+        }
+    }
+#ifdef CONFIG_VNC
+    vnc_cleanup();
+#endif
+#ifdef CONFIG_SPICE
+    qemu_spice.cleanup();
+#endif
+}
+
 const char *qemu_display_get_vc(DisplayOptions *opts)
 {
 #ifdef CONFIG_PIXMAN

-- 
2.54.0


