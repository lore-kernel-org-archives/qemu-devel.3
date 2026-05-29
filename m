Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3DECD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvEZ-0004bx-6F; Fri, 29 May 2026 07:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvER-0004Sk-9O
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvEP-0008PT-Km
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0vBgMB+JfoVtADoFb3UEwzuxSvcYgxQQ4fbzcKMdy0=;
 b=J8yuaONezn5tjaWNZ2itKjEqoVgCPJm7+sQ1WxOwjzOmogIYEv6E7B35p4nwFEQ5vbXMhA
 OP5gaGjLifa7rkWsJdA5hKKSpzIwzV5i1iJdU48BYV0kr6oGj+VAqPvKgqiRZEEYNsImr8
 xKwRVD1cF1WI6JBfMRw4WbIy09XBwoQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-PMp3dL_xODGFgMmKnlAs7g-1; Fri,
 29 May 2026 07:18:20 -0400
X-MC-Unique: PMp3dL_xODGFgMmKnlAs7g-1
X-Mimecast-MFC-AGG-ID: PMp3dL_xODGFgMmKnlAs7g_1780053499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A9A2195608B; Fri, 29 May 2026 11:18:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98F101800357; Fri, 29 May 2026 11:18:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:37 +0400
Subject: [PATCH 16/32] ui/spice-app: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-16-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPxhqOpiI3mSnM18GPWh7GQCv7XNx9RFo/g
 DYnif9OfsOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5eY9D/9EjtNl6u8rN/TKT8f4gB0sqwvR4qugTHOMjD8CUUtG+ii5/raGCRx8HDDvDGMHnJlc5Pu
 ZVTZCDN0I14wmDTyoqiNj3+fwS6T7jiIiVTwfeHPYpvNIT1iZQbxF7ytFXgcKtzYlv/Jrhr/TCu
 PaMLQdkt2dP9CJmFSKun636Ha/tPBN2GmVxqorl2IGa5BAA4WK6BIBygswlJKMTEG+f3ponuqoy
 pRiANbC0nA5c4hKDdx3iqagLr7fOWN5q8/J3Ke7x0D7HxJjl7ZxZWSBkl9EU0VMy8bV1d/7RfFf
 EZoPIShHNcAaZgPy5Jovg4AzKeKmouJHCQeLydZaAI0V+CRbKGVg0rI0sJlI+t+hdYQReC0k857
 FYcmNbpV6XkiaXXuFJJrrO2LO23FEpf+XaqPJ3Qe3hItLzDj0K+OMppwyVl1IqB7a+si0SEtoDQ
 8S5lcEYOvJSOC21Gx9ywKvmeS4gcStTtNG4EL1h6WsNpLdpE7SusCyCIZQynDXcqScYM+DhRRng
 Gn03QjrJBnuHEZUEvGT0oeDDnd8XkZrUedWJWGbFozOb1JTmkE3mkPbs76amakT3yblpqdQ0to4
 oI40QrNJnXSqIVzrrG9tv2mNLZwSwAwsOgqGCecJ8zHvpaaVx3uMvHolEmAGZDbxVQcz/GYfyB1
 r03sYNpBvDwfLZA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


