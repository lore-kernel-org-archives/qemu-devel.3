Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B909CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFP-0008EB-Te; Mon, 08 Jun 2026 03:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFG-0007x6-Kj
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFE-0000AQ-Ra
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBrMf6sgce6eqalfbiLawauqWyu0Pfl9VQff8GIECLs=;
 b=KoW/BWm6fVjAo/PUGbuF0cU9mahSeQz9fsvB251K9niVOdc1rEukMPTP6Ckt0EOLofOS45
 gv3K4Bwfru8ZJ4EZR5vcqMcjGTOOCV/xHfspu7ghRnoHlP4Ezv4ysVNfIfEUjnop7rvbVX
 n7LCHp4tAOad+eUvb13aiwjWSLXs0rs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-BaQi9QDFOweIuOLX9oahNg-1; Mon,
 08 Jun 2026 03:17:56 -0400
X-MC-Unique: BaQi9QDFOweIuOLX9oahNg-1
X-Mimecast-MFC-AGG-ID: BaQi9QDFOweIuOLX9oahNg_1780903075
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E3B71956080; Mon,  8 Jun 2026 07:17:55 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFE31763; Mon,  8 Jun 2026 07:17:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:32 +0400
Subject: [PATCH v2 14/33] ui: add display cleanup infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-14-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lwX43CcKsWPglzBRxIi4xAYVtk1qkhgPHDupwvecx6A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxKfAfkVgHjdsyjuz1K4jGFeJsowilYrU55u
 gu188DKdm6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSgAKCRDa6OEJdZac
 5f+GD/0RR/xQ5saQSq9xeQf4zP6nzdaLo8N5TH08SZ2uPIjl6VFr23FiniKyI1qrsXf1YlapiVk
 PjfgZrgpBqQFV4u+Sc/t495BO1DPNIn/wRH29CctRNuFF68vBNLlX9oSCLjqGSonXaMcYIQUd2o
 Z9xMWwQ3N85r25tEQr1VyxaiOLNjS5ZmWgtbxrWWRSFc7Lf1CSV2ufv94mNyVCknLXnxVfX7l1g
 ZT6N5kYw1L0KbyJKW3OQI9VDuFmVwawxCjjk412vSNqPG6sAGeRwwYvW30yFOgcIMehEVxiNh09
 PHpJTJu9X+PTUw1N/UJkVnQRGY9aBJMGms3P6S8xYHQ4i8ZaEIjCeEB5dNSi3woe0qI4w/1efnM
 D/JWG72uV3yC1GPj23+v66CryM7OiLeB4V/wxuLERwzgzbIZMw2mAydbjBlXBKanKQUVpfuJEMi
 iwzvi485EjLcoeV9ckAcg1hqm+E18IGjljCgjsT4/LJ09WVsFpbHm/ZFfZ5Kr6WKOm+/do3JDHf
 Eo3zCDK3SvXOAWDHBORxuk50ay/2VldueKeKvD/OpGocSwCOh0U7v9jLae4VyUKF9OIeE6OmzvF
 kaFFFlU1OPFu8fN5wh3GetLaFUMK5npbi1ixZASIROr4igtTSEFDbRK4lMc9Z5XNRbxPBIjKOnO
 7p5fTGlDGWDYU4Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  2 ++
 system/runstate.c    |  8 +-------
 ui/console.c         | 20 +++++++++++++++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a31c5a4995c..1c7f7e62c1a 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -430,6 +430,7 @@ struct QemuDisplay {
     DisplayType type;
     void (*early_init)(DisplayOptions *opts);
     void (*init)(DisplayState *ds, DisplayOptions *opts);
+    void (*cleanup)(void);
     const char *vc;
 };
 
@@ -438,6 +439,7 @@ bool qemu_display_find_default(DisplayOptions *opts);
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


