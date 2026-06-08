Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9136DCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFc-0000Yk-VD; Mon, 08 Jun 2026 03:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFW-00007p-Gr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFU-0000FX-SS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0vBgMB+JfoVtADoFb3UEwzuxSvcYgxQQ4fbzcKMdy0=;
 b=ElrKC5V4EOmWKAV4d+b86tdj64n4PCbj6q+YNIK74Xjhi9pjg68u/eaAr4+mV+ASioiapA
 ZY9TpBYPJE7eUjArFpN3FhBjTFokrC/h3zVuhHXZqLsR320xuKC3kOPaOuiAYK3klwNYhE
 NbbTWxOe6XS+/8aDoFXRIDdyql7D5V0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-bQXBGl8QMp2r6zpK2OvMlg-1; Mon,
 08 Jun 2026 03:18:12 -0400
X-MC-Unique: bQXBGl8QMp2r6zpK2OvMlg-1
X-Mimecast-MFC-AGG-ID: bQXBGl8QMp2r6zpK2OvMlg_1780903091
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E259F1800370; Mon,  8 Jun 2026 07:18:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87EE8765; Mon,  8 Jun 2026 07:18:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:35 +0400
Subject: [PATCH v2 17/33] ui/spice-app: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-17-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cpTjZniLMqEA6rNMksDOJAEvoDe9Yx6APfWnAl9Mp3Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxKfYGxN1x0IGWez76xDdI/nkIc3Qza0+F2N
 2K6UkwH2rKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSgAKCRDa6OEJdZac
 5ZvmD/sEUzpXfZXkjOVkI2IHQDwQ6fyMwrXnbnPn3KfRqzvYt8ENAIJ3I6OskDmsCt2+wqh5HR8
 ifi5V6/ZaufThq7GmVdcwLQoC0Mh1YMOVbUOsi4lnHc0TmtKZk/XGP/KUav+lQq4UDUTPf3qQjA
 X5MRDlghGUFSPxo3ZXS0/B53O45ehQD6qSvr0i6Z8oXbj9jUR5tqu7AOlJo2HXGdvvwfPcgtBJl
 gb+NCyR9JmWBxSLdQSdSwZT0F96fCzw0ZCoDN9HSjhMbJ7ZmTzGutm/cJRVC8SLcgJbZltHeGYY
 gDUWD6so0xswA7FPLgGh8sD+Jg4TEtFVuylZZ6qtz7i087JKr2ONWIkdodAc8dnHs+RtkIWiM9H
 OxYV19vj7ep907OOhkVNbS/AYIdPqgTizvaragfk4t+NLNy1gWdgRTrRv7mek2QdEqIbwDJL5NJ
 XZ8ckOcAAhET+n3rqzX3pD6BtmbD4qCZvVIP9YYO+dUDpUz1ljMWYFTWsdC3xJI4SJmegNrDWPw
 008wHzU4XzJbLeMGlHQUKQDAvrymoXzNBODvXHwmdcovmNX8VIxiBifXZXyjyJCOerlGXDLXXVD
 gICMJu5z/i8+TRlzP7fVzoojT/zaLG8hLSucOPuNRtEPGDqxURsh52tKN4PwhqymtW1HkHngGPK
 UwJhp3M43uUXPHw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Replace the atexit() handler with the display cleanup callback,
reusing the existing spice_app_atexit() function.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-app.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 0df7325e679..fe3df62bfa5 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -119,16 +119,17 @@ static const TypeInfo char_vc_type_info = {
     .class_size = sizeof(VCChardevClass),
 };
 
-static void spice_app_atexit(void)
+static void spice_app_cleanup(void)
 {
     if (sock_path) {
         unlink(sock_path);
+        g_clear_pointer(&sock_path, g_free);
     }
     if (tmp_dir) {
         rmdir(tmp_dir);
+        tmp_dir = NULL;
     }
-    g_free(sock_path);
-    g_free(app_dir);
+    g_clear_pointer(&app_dir, g_free);
 }
 
 static void spice_app_display_early_init(DisplayOptions *opts)
@@ -146,8 +147,6 @@ static void spice_app_display_early_init(DisplayOptions *opts)
         exit(1);
     }
 
-    atexit(spice_app_atexit);
-
     if (qemu_name) {
         app_dir = g_build_filename(g_get_user_runtime_dir(),
                                    "qemu", qemu_name, NULL);
@@ -218,6 +217,7 @@ static QemuDisplay qemu_display_spice_app = {
     .type       = DISPLAY_TYPE_SPICE_APP,
     .early_init = spice_app_display_early_init,
     .init       = spice_app_display_init,
+    .cleanup    = spice_app_cleanup,
     .vc         = "vc",
 };
 

-- 
2.54.0


