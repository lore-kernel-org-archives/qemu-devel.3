Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A39CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvqo-0001Bu-Vc; Tue, 23 Jun 2026 03:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqm-0000x5-Vx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvql-0008L7-JR
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXp6IDcQDWTnCpWDPYd10qxyz4SzrMGhedvswMrxwag=;
 b=PKI5pYDHHQVThNhZQD+U7ulTRnAXvQkymQy8ycxd+f/TybrFjEG9GfyNfAGoAUnzIICDGo
 AjSKFj6680Dn4f8ZkL6nxOApsjo9dw6J4c0R+bH05pQ4hsZ4DA8B9dW7Et6ah8QoGsiLOA
 WlLXn1AwkrkQ7cbxxMerwuYt/UDY0Iw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-pE1Fu-kRPI-_tm42RFsQEQ-1; Tue,
 23 Jun 2026 03:47:11 -0400
X-MC-Unique: pE1Fu-kRPI-_tm42RFsQEQ-1
X-Mimecast-MFC-AGG-ID: pE1Fu-kRPI-_tm42RFsQEQ_1782200830
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F18F1955F7E; Tue, 23 Jun 2026 07:47:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5359195608E; Tue, 23 Jun 2026 07:47:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:43 +0400
Subject: [PATCH v4 28/34] ui/gtk: fix tab re-insertion order on window
 close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-28-4656aec3398d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xP4Iks1pyzqBMR8iuAQ0TMhb5HtWj5rEEvbuyLR4l2o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjler0UI9aB2SiyVMZlNVek3Zorqsxipx8wPv
 1GfyDrNCmiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5QZyD/wOF1wW9zI1pAl54jgG/FeaeuKp96xYcCcSmKEZL2G3sTkIc4hPAbmYv7HRqmHVzQNWiu/
 s1W2bboFYWZDTwT5DUmrZ8hzN8pgGMY8LCMIcfFerrA0N6VF65XVY/vYqaQRtU2sW5cBQcHG+eq
 uSkJAseRYBFT7jBwRM3tC4O2lBCBidzqgkDARh0qaauEq3mxL2O4Rso0T8FsPJ03xbHVYRwx50J
 B+O4ILxoNidZgUv4pc4w6ZRvT1VCJ1npFARud9Yqu/u8FfBBqL5tKRuudIWFg5V3qEzOjjDALC0
 FsG0gJKqCHO6J2RQBdNLNTXXCQCok/dOYjoEcDCGIXy62nZwlpdhl2Xm6KGBMZjYTJkgrZvw3hf
 RsekyaKkTeK+g7JS1EwY5lgxO963Z8RZQBoizj3DwLBrMTh8i58/ZvrPv7aendUTkRw5Wp1T1P6
 aAoNzZVrOMQ80lte/dSyXsKfJJaRAB8erQjEEoOcAAjIziCUW1K7+eX136ZX63HQuuYl+qkNa4I
 NsQyVoyIQn5j8JgfFCdvNsANrT6ti+VJxdRnoaYYUQppIj7ylTNLfNmVorG6GCJ0idHzyhRRv4W
 dOSfy4l7UerqqDAGw2Mq8krECqDcqP6DKr8k6QkiVlB7LUJ6y3fW9JSMRqdpertZ86Ea2SsAdN+
 cgldSLrxeb0mAVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Add gd_vc_notebook_pos() which computes the correct notebook position
for a console by counting only non-detached (non-windowed) tabs before
it. Use it in gd_tab_window_close() so a re-attached tab is inserted
at its logical position rather than appended at the end.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 929e4cf43f7..741f7bfe373 100644
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


