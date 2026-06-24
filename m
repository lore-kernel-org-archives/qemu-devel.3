Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6E5CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1u-0007AO-Ax; Wed, 24 Jun 2026 07:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1q-000728-3E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1o-0008Is-AZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rA0q9DcPM5/f4+PbY7T73EQOB8BG7DyNQr5nJhN2zNI=;
 b=Lou8FuGTI9DfVpIEOi+Apf0zkKP4k6Oc/sKTqI4zCLom0j84kAiWwzizg72qMEJ7xA6d3s
 BevvBP8lHmUA9YdPO8hhxpwTiOluOoiNOjXNu1lenHEQnzxVuP1IIrdhu5jZe2Il4qPjal
 /DAO1ut51atpvx8ZgRorlUExyKcbda0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-hxy01CEJPIOhHOTy1w4b1w-1; Wed,
 24 Jun 2026 07:44:22 -0400
X-MC-Unique: hxy01CEJPIOhHOTy1w4b1w-1
X-Mimecast-MFC-AGG-ID: hxy01CEJPIOhHOTy1w4b1w_1782301461
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C09EE1801326
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:44:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 749C536924; Wed, 24 Jun 2026 11:44:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:53 +0400
Subject: [GIT PULL 31/35] ui/console: register console in QOM tree dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-31-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eo/F9jEsUV6ERVf+hKfhWAKiQgI+iE7YRBT/y12gavA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JpbS5WV1kAgrMt8Z3cLs88NRNmP3Oay76ge
 FU62/ZE/kWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaQAKCRDa6OEJdZac
 5bZ0D/4863dZl06oYqWKtAPK7bmqvf1wshCZuR1Uv0iR9csNO8Jh27BBYCxkXiA6sNHgVm9IsEE
 dHbAd2JHAGajwv2VCcfJ/vr2NH+aO3le8Qajo8XOulacioi1yOvWAbhF1NUjR7bRj2/eeu8Ove2
 0oqMhaqxLDyvKqkBDbaNVMjYLM4B51F1Iku8tUFQREa5uJ1i2OkTavRaw3UgdKxB/1qo5M9W6/b
 xmv9dgoNm9btt6SBdvA7ykdj6ayB4++PD+y4uUwBZf5TClje5+lkIozld28f8Fa1Gnzu3zDNos+
 XrRnQ47HcA62r8egMtTCJ0Wt4Rs7XO8McVrUxu1zm982FSNDVdNfpdI+HPWANuUd8MkQKjH47DH
 zkfUq+6jz3rgycQeCqzIXcbC2sHmGo0rcKVVLF5g/6GdXSQdQsG9xP7VpDzIWi+nH5QNUygZ8n9
 n4cwTrwZ5RdXHt/d71cF5B3YCqBJ93CPOdYSGqpXGqWPnCfqLtb7JbFPa7wVlPhuySRfAL7t1B4
 uR6tRI25usTbkjXJwdDS2jNVmu+J3LMLDIW4iWjBUxagjlDQXmiVxQDMCx0K1hki+QRS/quJ4rn
 ecR0wmXzvfV/SubdqKXkroc++Nr7kyDGphL3Y1Ux45AhwaWb6FezexpJvB11oy4x1RtQv4MG4Pe
 bAtGnmHLw5MVhCg==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-31-4656aec3398d@redhat.com>
---
 ui/console.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 975eaf15706..db9aaf85f59 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -68,6 +68,7 @@ struct DisplayState {
     uint64_t last_update;
     uint64_t update_interval;
     bool refreshing;
+    bool initialized;
 
     QLIST_HEAD(, DisplayChangeListener) listeners;
     NotifierList console_notifiers;
@@ -376,6 +377,13 @@ void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len)
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
@@ -413,6 +421,10 @@ qemu_console_register(QemuConsole *c)
             }
         }
     }
+
+    if (c->ds->initialized) {
+        qemu_console_add_to_qom(c);
+    }
 }
 
 static void
@@ -1089,20 +1101,19 @@ void qemu_console_remove_notifier(Notifier *notifier)
  */
 DisplayState *init_displaystate(void)
 {
-    gchar *name;
+    DisplayState *ds = get_alloc_displaystate();
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
 
-    return display_state;
+    ds->initialized = true;
+
+    return ds;
 }
 
 void qemu_graphic_console_set_hwops(QemuConsole *con,

-- 
2.54.0


