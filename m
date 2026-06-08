Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAF8CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUGr-00035f-Mw; Mon, 08 Jun 2026 03:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGU-0002d8-El
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGR-0000pK-5x
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfZGD2CKF+sg59f12dKDT06fKxquYa1/bhpSzhpSmNo=;
 b=iJSlMacgy0F7SzjvVWO64mRHrpgUZcB9Hn3ZAcPfKnI3w8C9olLzRcFqzVMslJ8LKWtKwp
 2i2mery9togmv6Vqo76535dkyOh2rnheYfdWIMTYm8uj2tWTPHoIZ2R/3E4WKclCfgW5lQ
 4EieUmoMOC2QMNU5sbO0Pn+/q9MuxPw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-mDBF2aNePCuMU0SJPJy_dQ-1; Mon,
 08 Jun 2026 03:19:05 -0400
X-MC-Unique: mDBF2aNePCuMU0SJPJy_dQ-1
X-Mimecast-MFC-AGG-ID: mDBF2aNePCuMU0SJPJy_dQ_1780903143
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB8E19560A5; Mon,  8 Jun 2026 07:19:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB8141800347; Mon,  8 Jun 2026 07:19:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:45 +0400
Subject: [PATCH v2 27/33] ui/gtk: fix tab re-insertion order on window
 close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-27-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IQjCpCJjmG96ugeyLyDomxPwrpESOHbu7i2WdeA4Yk0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxNrmyauMf3HTPqpAmUB5ZSJHVtaRR9O5vSH
 Wujf/lHoMSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTQAKCRDa6OEJdZac
 5VBgEACQeNQMwJ5paLJVoiwINQnKPdSwA5o5kM/kehbMoraWHNGKloDrGmQ1y8ZJgfPbmSHgFCC
 LK99TwHlQA7+lSFXE8BJ6fLR7LAXx+8h4ysQ4/3JG/HW4BcAoalLVCS0pcNon30RTw95WhLehKc
 widx5MZnd6EacyuUUpCBiXLEWqSScg1Ssv9jj9Z5BPgoMrOOtq8McvE7ryPTA8LikomgzEs60dc
 0ex5YL0JFFR6zbPRG7btSoeV7rimoYaxBVm0gmxi2PiVmV+GZP8z43VdAbDDNzYDtNtxUkcPXi4
 IE2VyITbMlqcdyR6LkhZcX4QKO2c9Lm79w/6xLNq8VKUcI5Eb8134wdAgKSzgt8MnCvzFX46aO7
 BLHOI8caG5wkXhi5ZzzGB0zL1zr7zXzPI9pLzFBa+IcjdRaINdhHvPrQD3daXEIUL5AQ5ER4yQo
 Y2BtxssDex3topOjRddYVHgBMbhkINbKpbtESMCcWBYPdBscvVRRSELJYD3nKRR/fVcfqmFxpdc
 BKsMgvvokZMhYLqTdyNSjJbChIaMxNq3Zrr+wuvfCVj0S+N4/tCnRXl/jZzI5hhIyNAOz4Ao/gI
 H5aMYDZQOXGV0xkKYFQhlO3O4ntXyB5AaDn6Kzug/kugv3oRqiFOsAe+wIc7lzm8YvwpF8CzIA3
 hCHjRcOZYU2iHoA==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index e86b618f770..32f3a0805e1 100644
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


