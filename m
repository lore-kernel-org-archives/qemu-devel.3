Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F0ECD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUH9-0003NB-9q; Mon, 08 Jun 2026 03:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGb-0002oo-Vo
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGZ-0000xO-Fv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smITB6zL39eWiVsZ5X8YQmvcTjlNu7U6xyC2M1fco68=;
 b=M3o9wGsm24lD3bCUCmw/wSrBaTEYOAu7iQpj1nttfglTRrBmG+QLCTKyFgAuamw0oD29yU
 EVO6sAPtdIZHKZDc9+BbZJzctZeyPOJGXGqCjkeRzjV0ysa2dhAj1mqpwjkWNGnk1J0WXf
 O+pcc+bpzrBH0qBS2qFw34XJ82KIRlk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-jWHCaYTnNTqlvzXSaGdUeg-1; Mon,
 08 Jun 2026 03:19:21 -0400
X-MC-Unique: jWHCaYTnNTqlvzXSaGdUeg-1
X-Mimecast-MFC-AGG-ID: jWHCaYTnNTqlvzXSaGdUeg_1780903160
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5DD1800750; Mon,  8 Jun 2026 07:19:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0D11763; Mon,  8 Jun 2026 07:19:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:48 +0400
Subject: [PATCH v2 30/33] ui/console: register console in QOM tree dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-30-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gHM3wO/P2ne1JXOvnW4MgBu4jfpvTvZCkSPD3/MPa0o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxNFhto47ZXxJcuCkL36/QJ5coCohAPTUODP
 kaAN/Ne2n2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTQAKCRDa6OEJdZac
 5fcOD/9IvqdxetlvLZhAqZdLu5vUxPNbaAl0LYNzo9dFOT5kAsAoStmdcuFw+9QkLoMfEhLLkyq
 AfkNpn/lliTw5hU9QSTj7s6y/R4MyqSYFPTZGHBWVbxmbcs2iEqFfs6+pvzKwb7acZo4mMU7uw2
 tewOp+XDWf2hzKQbEIPZdvxAs6kAOQ/Ypl3pmCGGHRM7vkuf5qkMUFl2bprvzjQ4I2o63BoQjNp
 9vvOPxwGyGr7lQZEEdnQWWva9OB/NC/iGPz2HhqSbv2jxAhQ1BQeOUkYmyFPAh+0rsfzSMQQyN0
 b16YXULHdOV7L5SGxR32oo8nZ88AHDSUy8dMpzjADcJHNBVLJ5VauqmWnhksffLDPm8mfQ9OJqZ
 ez/xdeEh0kwIXTh1ofsHGTC95eDkRGdu1ElPDF7dqNbNFht+mojSPV7SW8Rsw9vb5yUzrdkRr5K
 8rJr4WBawwIZG4VuWTH/9fQgJjc5pBE9+yBSVZfX37fNjNbjTTmbgVmjktdHUTc2gvTK1VmoHAV
 01bjWVU9buvC8fdULnOwXccLLJi37Dc3kIn/H6J6xWmonMblEafqfv9rPLMbSOz+g1qHpmHUAZn
 tM3QJepcM23g00/1W8Z9pLjT98rHhzRsr3Y3VL7haq6lc/Afs7kx0qaxd1ZWTGfCerzo/D8TaPd
 MDepFo6OwdMNqmQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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


