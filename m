Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE10CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvFf-0006tg-5N; Fri, 29 May 2026 07:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFX-0006GC-Ev
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFU-00009Q-Bm
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFLQic1odOEJS7jxxkDIvznt7a1JZqAICE40xDmHx0Y=;
 b=S+OB2x7L5IAkRiNekFaOUklcLnaOO/PmYSWPzeF3DUYDIpgSm/6x8HVlUzBWWMvVL0yAFR
 KXaeiEbwtdFDT5xZTZ26MYbijryZ/UpdsbLexYIv1M1TjU4SZGRuhb0nORh80FfPEe3Mse
 01HTg12E/VrIcAnxw81XNi8p0rrWsAA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-OkiouUlAMAGQ2ecXLdx9NQ-1; Fri,
 29 May 2026 07:19:18 -0400
X-MC-Unique: OkiouUlAMAGQ2ecXLdx9NQ-1
X-Mimecast-MFC-AGG-ID: OkiouUlAMAGQ2ecXLdx9NQ_1780053557
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 781B41800367; Fri, 29 May 2026 11:19:17 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3180180034E; Fri, 29 May 2026 11:19:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:47 +0400
Subject: [PATCH 26/32] ui/gtk: fix tab re-insertion order on window close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-26-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KvnVhLJN6mddD7fzqPwpeGKA7KloxgOqh/fGh8tpBws=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWQswSKBfnedUlS8e+L8BSQ2b6+JY9r32sm6
 P5EZ2HmW1+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1kAAKCRDa6OEJdZac
 5X+jD/91sHWZyKn02vNDc+/wn8ZcML7JqYzd68qCeUXwEPbBFOD8z56qT2hUyhQirotmtipE7Pl
 uw56Sk0gaNyhLfdVc0JPmCpwG/RH3/YWjRQGBc1XlM2YMqsf7vFG5ugxbW2FUdt1kCw2q3pXlnh
 2aJCXZg4jAArk32tT88F/KR1Ttaa6hMg+KFiZGsYTTJdyBUIUIPcIyzOulxqDR5jYgwcW/TXfZV
 TwPijEV/SEoxBsHTzQRGZLLlaSQJGo7FtBB/U5CFyyBIFnVioc111nP0PfZ9duC3qJq425xcNKs
 kPYoAhqYUY6VoCAhzmH8/Zy1yP6BFZ/DKYOaPttOE2MAd0L2zQ87aHi9nOLHjpFSmQbBh9KCWov
 vSU2iuylxFEz4S9kToAfDFLU6mbCaZNKYV5VVGpww20tbhCKL+RkmwxB2Qhnk268sjF1rQ1ep/W
 QLifVbTfg/x1Gv8RLKQRVF7+i1ZlpoMoZ4OnQfdewS8Vz8gtSvBsXOWR6Zt/HerhEtU5y9A/3nD
 eVU9YNPisOqkbn983ZcHqxmPH9DfzWlZU4IQj9FTOY/8F7AHSFfi5SruxY5sUmWV5kF6OOu9Eb3
 DNfhmCF3YcjJExWSyUgKBK3NrWSMuiytHw9pcSgChAqsVW1FsJqVCU9zakInbqCELQEEpqY5tQN
 8AwtbpRPc9nJqDA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Add gd_vc_notebook_pos() which computes the correct notebook position
for a console by counting only non-detached (non-windowed) tabs before
it. Use it in gd_tab_window_close() so a re-attached tab is inserted
at its logical position rather than appended at the end.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 1b9523739f6..c4d05757c75 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1464,16 +1464,37 @@ static void gd_menu_show_tabs(GtkMenuItem *item, void *opaque)
     gd_update_windowsize(vc);
 }
 
+static int gd_vc_notebook_pos(GtkDisplayState *s, VirtualConsole *target)
+{
+    int pos = 0;
+    guint i;
+
+    for (i = 0; i < s->vcs->len; i++) {
+        VirtualConsole *vc = g_ptr_array_index(s->vcs, i);
+        if (vc == target) {
+            return pos;
+        }
+        if (!vc->window) {
+            pos++;
+        }
+    }
+    g_assert_not_reached();
+}
+
 static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
                                     void *opaque)
 {
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
+    int page;
 
     gtk_widget_set_sensitive(vc->menu_item, true);
-    gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
-    gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
-                                    vc->tab_item, vc->label);
+    g_object_ref(vc->tab_item);
+    gtk_container_remove(GTK_CONTAINER(vc->window), vc->tab_item);
+    page = gd_vc_notebook_pos(s, vc);
+    gtk_notebook_insert_page(GTK_NOTEBOOK(s->notebook),
+                             vc->tab_item, gtk_label_new(vc->label), page);
+    g_object_unref(vc->tab_item);
     gtk_widget_destroy(vc->window);
     vc->window = NULL;
 #if defined(CONFIG_OPENGL)

-- 
2.54.0


