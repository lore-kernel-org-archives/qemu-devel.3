Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585B1CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1g-0005gg-26; Wed, 24 Jun 2026 07:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1a-0005ZV-Av
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1X-0008Fz-3D
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouQtgpEKDL4W4jan/ZrtcFmVZ7T7iX7dyBOwLcB+sj8=;
 b=FFBmgn0zh3NdNF9MTCe9iCnoSbx/JHJj2KB7CwepKkCoK/RAyxhDHIW4hllAj1K9bxR63S
 qSphESmbfYg3Tk3B7QWruUYTl0K8Ot+H8OOkEPr+uYyQfKfqJcpwTWgw/lpsWzm8qs5OV7
 Mfkqm2XsPze9epO1Jfl046ROWUCNWNg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-zLJQNRZWNyqr0GXp1WAOng-1; Wed,
 24 Jun 2026 07:44:05 -0400
X-MC-Unique: zLJQNRZWNyqr0GXp1WAOng-1
X-Mimecast-MFC-AGG-ID: zLJQNRZWNyqr0GXp1WAOng_1782301444
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 650BE1955E7E
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:44:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2810B180058F; Wed, 24 Jun 2026 11:44:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:50 +0400
Subject: [GIT PULL 28/35] ui/gtk: fix tab re-insertion order on window
 close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-28-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wdcE/AMI0pHtm512zheMCDtwC3flWPBG3wwf/2Hj1lQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JoudLxFiVOWinrK1IR4JAMggTjnmI7qhNDC
 ucC4f6lSvmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5SC0D/0eppKnCWtcconlg9DYYzRav03Of+3HCqXiFKzXf9Ly7NqZ/S5lWTkvxrD2c3J5ElT4U32
 JuQ/yTdzhGIAYKMdb4WE4DY+M6IuEEHWWsk/sfxc7DiCVEgZ6YXqWqKxaL2lhk22RmOVhoNqrFl
 3u9xGgAAdHxEKnTL3xofktGfvt+NCHMaE6hGdDbDh7l8TsGRRmnjBIslnnp2H8D1K+h5jGQ3OT3
 fGwrfburZbO760KXv9F9y8206lWu/pGT32Ar/pxAnS0wAQrvobvQcbRQRTeLTuIDQYYHFVFOIoJ
 fxbTvXaVM9PbbW9TiAQzRSGZgLpa9YrHqmOyCf1zyoZOiCKPQ5udCqTf74hHMNszFKqIoVgtPkY
 RpOb6ZAoC062vYTR4NSbAQOi4MfV/Sh81UFHlWc0zpWbfauIH4qfbHcd6AtE2F2bPHs6CsbTRgs
 +leGzWee8dbeT02MBtY87VWOxEP4/PxESkqe+K2wx0ZLN32vCMyknjf/QKM+Cdsl4jMqdplUANu
 zabMP6CfcKoFqslLJzcnhFSzrT1Fj03JJXEHGgcFaE1fGgw7SDvecED0pf2ljs40BKBBNu5j1du
 kl3cf/EkR8i9qZgA1WALw79wum0mrgIGs+ej8CTnlwAJC50MDaV7taKXuDf+uRFdQbidCGd++SP
 MMBb4V933CjnHAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Add gd_vc_notebook_pos() which computes the correct notebook position
for a console by counting only non-detached (non-windowed) tabs before
it. Use it in gd_tab_window_close() so a re-attached tab is inserted
at its logical position rather than appended at the end.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-28-4656aec3398d@redhat.com>
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


