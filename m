Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F384CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpx-0005eC-Co; Tue, 23 Jun 2026 03:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpv-0005GB-D7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpt-0008Fa-TM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0vBgMB+JfoVtADoFb3UEwzuxSvcYgxQQ4fbzcKMdy0=;
 b=bYPj+OhvtYtoIDK/v0gPtkUvLYpZAYR0L2SZ+GnkxeFRu/SzqMyEgVyYSAODZn78or80Y1
 XucVFpe+e7CeODkcjLnmipwCqOv5fBUDtS2HtAHBZDk1gf64CgifkGbz7HfsWTjGWgNQ5W
 oe7o3Bw37F5KmH8iWYDNYeQLrjlzXY4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-8RY-Nv8gOUO-n5jeuo2n_Q-1; Tue,
 23 Jun 2026 03:46:17 -0400
X-MC-Unique: 8RY-Nv8gOUO-n5jeuo2n_Q-1
X-Mimecast-MFC-AGG-ID: 8RY-Nv8gOUO-n5jeuo2n_Q_1782200775
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA9D1195606C; Tue, 23 Jun 2026 07:46:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62D82195608C; Tue, 23 Jun 2026 07:46:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:33 +0400
Subject: [PATCH v4 18/34] ui/spice-app: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-18-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjleFjwaE2XfYpKISdmRZdwteXH3VchhFFMJ4
 3PbiSrtFeeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5fpNEAChawlUPR6B1TS7R27ux+yT38IeVUPV9lDDC1UwiQBxnYtKVpTaZjap0fXc3bwOAeXYdCM
 iULd4tKmA4rW6IOZuqVQj84DxSJMFGCDdDiwaUdEmqeh8YaeL+QUAhjPxtlqr8pqXUuI5gkQSER
 QMdFw1nsT2C/OW4WUg619Xb2KJjgp3BMCrwfoiq0XMnKRZEypxRSSoMx86xUMnMocHpFwhzjs3x
 OJzsPfbT2JsHl21+uq5A0QqL/5TcgVWV6ML5dbE5atKDPwSKD2gFLRMZy6szWpzRBS1FoJEAg15
 7vhE+/dYL2x65Ee06hwrxuIGqwzfIyhcQjGiDmWwjsXOuKGxxeqJbqgIjRLFxiuA3sG4g9h++10
 bIiWbZeFDBqMWvP/jSwmEdCKfrOeJaLfCZNO0LAYONs9st6OnC7FLhCH5iW5p27czgGRvi3BNZI
 ze3lq92NgoqnURaxi73eU/D50h5THEKaqOtKNVl0ymgLPv3G9LJLQZmvgSmDTbsiFVcvbSYNwgn
 7Fp3dRsFQwfdrFVgv1eWyq6dpICBO5/jJ/UZmgAJoxBFTDyCet8NyRuAKvnXq+ahsp2Vdmv2I7O
 YRmEN4ihSqIdclML3qhbdIyYzIjrmzPR60qpv8Ud4Kl3sR9wNxJntrMUeVcAbDt/uB/J72O/ACf
 wN6CF8UzTCsiTEA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


