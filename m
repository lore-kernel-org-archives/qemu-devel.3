Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CD8CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvr5-000257-FK; Tue, 23 Jun 2026 03:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvr4-00023L-C1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvr2-0008NV-UD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NBCtQ/LDlj7bqt4GsZQ8DDG3CW8/CbEEUHOSI/t16A=;
 b=ElB2lZ0V4MHDPkxxnq+Bhu41RCvej5RWCvs0x2VkbdefQXZRLQLeG2HnxaG0S/vmYOq2gy
 0gyoPpYpBq0F0UfcOUGncqHG4VTmX26/ceFLPH9gH3Bu6q1b2HSsINn3qCh73pb3YUXyuw
 SK5pnS+lYAhjBqfBO/T/iZjabEwIZXk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-WF1hMYAdNLupsYvBDe0tlA-1; Tue,
 23 Jun 2026 03:47:29 -0400
X-MC-Unique: WF1hMYAdNLupsYvBDe0tlA-1
X-Mimecast-MFC-AGG-ID: WF1hMYAdNLupsYvBDe0tlA_1782200847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC21B180025C; Tue, 23 Jun 2026 07:47:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5571D180057F; Tue, 23 Jun 2026 07:47:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:46 +0400
Subject: [PATCH v4 31/34] ui/console: register console in QOM tree dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-31-4656aec3398d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+6tAA5uwDh2I1DKjrGBRjiPVFRwcgi1oOVH5ZTlowwM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjleF9urb3gnJSPR4XvFrpnHHW5+r477W4ehq
 zTngZ2g0XyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5f8RD/0Y0R675/WtZK1mHt9KtTOpBeDoiOcWpDL3yv9ACKjM+dKn2jHj2bi5UQhrlOwsTR8+WSR
 3xNMeNXR8bt8xODZELh9/zxcOyLhhz1cyV63jh4HT/HgbQSP++iQmfxIiJjAryvfardVKaVt6RV
 2yjtw8uv7+c0D5o24oG2d9VVU54kDtHe/votJ7FH4FJvageUGLSS/gKJ88lSNN2+o1dDZ2yPV+k
 AV/sizHlg6OLBg3aglif1FBJLTBTpL0phopZra95qCrFQxYm6oVMr/sU4/VfGgI8g0PqO+0SQ7p
 jvBlp2HScxfpO3QOyER+HnOKQEHSWCJxLqKBohthlRniBsNGnaZK7DT9xJzmf4mLkcKeylo/xDm
 2pqxszjyy8foXZAZd1HnAkLFPO4MQKFyi5MTsyX5mge57xZRftnHhBubgtkZ0cfSzX1wp3XvmSF
 fFeKNnE9y5wPRRVLVqBfDtFQtW5IormDUy2lLxI6UpF2W2sno5AJqPjxhB29rc6tHXZlA/Ofb2C
 nmJLk2OHDVq3L1nV91r6KnCFG3neSg6d1uh0/or5Kb5UEC7EipyRHjwLNXs3wi0fsEPWihc3puy
 0oLDFGNPulzYYYJ0cvrEp5inV1+cyPOhXC0eOjATrtjwbDTqNaesWyUjBXAEE99OukWGnwxBQaz
 OA8PxLCQKI8F3QA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


