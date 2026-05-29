Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C10CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvFi-0007Nq-0K; Fri, 29 May 2026 07:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFe-0006ue-TN
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFd-0000Dd-7H
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smITB6zL39eWiVsZ5X8YQmvcTjlNu7U6xyC2M1fco68=;
 b=Bf0YwOeL4XltxPs4hQ89ty1bOpcvZekMwhk2GKFSiI0cTgRVdCbHiNnDPXr97a3WLQk+Jr
 wbabyoTD/9Nqme6kg2kyuwq539PE4bVG5TXBPSMLLSRyoqoH8r+gE6MOGCV4zNDRHHq821
 JJhgBnTGTiOpLanOC/TyNbUlMAJV5lQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-q-UsIZ3YOseU2FhNMuMfUw-1; Fri,
 29 May 2026 07:19:36 -0400
X-MC-Unique: q-UsIZ3YOseU2FhNMuMfUw-1
X-Mimecast-MFC-AGG-ID: q-UsIZ3YOseU2FhNMuMfUw_1780053574
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFF3B180060D; Fri, 29 May 2026 11:19:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B917F1955D86; Fri, 29 May 2026 11:19:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:50 +0400
Subject: [PATCH 29/32] ui/console: register console in QOM tree dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-29-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gHM3wO/P2ne1JXOvnW4MgBu4jfpvTvZCkSPD3/MPa0o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWQy/b9MKcRmFpSaHxkJD898mWb2alxN1VNg
 20ICO7eFvWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1kAAKCRDa6OEJdZac
 5ZFsD/9jRC4FxM9B5YFaanyNkWIz0YAl0Qih/AL0GyYec77ibO1jlMMRdXpsRBcZq5SQYQ6TGge
 0ej3MtXY/HzeaORt8KAjWN17DwlHsfAcS+2r1HBSB6h+0qgmHLgBbSo+d6ka6cfS53ZT74ML7y9
 wvXckKdpS4IjFA3Bs6h3jz1q0QweRnRkIu3W88QCb7lz75HSEsivrZAjV+JKMaRXtEVsZkg+oIf
 IISS2ndyy5lHAgtKhjPL4H+5rkUwxpbrWFt5fe//7mNtRAuUjHRqQ489KiwSDr69WTxO9pFPBTF
 Rj/b7GjJRSH0RyIZGszOrHh979RC1yLbZ5A4i10y9vk/M8XeTnFr17Cc+JvdXdPd+Gl5AeIjdpl
 27ArrL6QnsXrPLlwLbhjDq2DXJfuP6iknJKkLc1Dx9+kSYDmWXawaAnqGZJGs1FZe4shetSkIc3
 Z0LoiFQi1dmfpdfAaTrDjdR9tqO6mT//dlZ1HUj82Je1xJRTNp3bOeTuR/Z6qtB2H6BMFwjUMgu
 8p8JjZE50N36+HhoEQ5nPVb15945lIhwzrOBG28puo5QlpVus12UR+KHXg9wwXcAR8oSJ6jd6um
 NFVjy1fgEtsKMHHfoavmWcaMm8rt6gLMugCKWSjTApLbsNx3pm42RoT9tJTwrRjfWhHfYIMW/J7
 e+U24MqEr8HeDkw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Consoles created after init_displaystate() (e.g. hotplugged
display devices) were never added to the /backend/console[N]
QOM tree. Extract qemu_console_add_to_qom() and call it from
qemu_console_register() when the display is already initialized.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 975eaf15706..e01d893df4b 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -376,6 +376,13 @@ void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len)
     }
 }
 
+static void qemu_console_add_to_qom(QemuConsole *con)
+{
+    g_autofree gchar *name = g_strdup_printf("console[%d]", con->index);
+    object_property_add_child(object_get_container("backend"),
+                              name, OBJECT(con));
+}
+
 static void
 qemu_console_register(QemuConsole *c)
 {
@@ -413,6 +420,10 @@ qemu_console_register(QemuConsole *c)
             }
         }
     }
+
+    if (phase_check(PHASE_MACHINE_READY)) {
+        qemu_console_add_to_qom(c);
+    }
 }
 
 static void
@@ -1089,17 +1100,13 @@ void qemu_console_remove_notifier(Notifier *notifier)
  */
 DisplayState *init_displaystate(void)
 {
-    gchar *name;
     QemuConsole *con;
 
     QTAILQ_FOREACH(con, &consoles, next) {
         /* Hook up into the qom tree here (not in object_new()), once
          * all QemuConsoles are created and the order / numbering
          * doesn't change any more */
-        name = g_strdup_printf("console[%d]", con->index);
-        object_property_add_child(object_get_container("backend"),
-                                  name, OBJECT(con));
-        g_free(name);
+        qemu_console_add_to_qom(con);
     }
 
     return display_state;

-- 
2.54.0


