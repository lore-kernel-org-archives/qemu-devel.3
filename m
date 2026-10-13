Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E0FCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcUD-0001YS-IF; Tue, 13 Oct 2026 09:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUC-0001Xc-CR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUA-0004h2-N2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYrqo3oSWh5uaQgXUmXMIEyQ/A2ZmqLqoItYDWQ7/kE=;
 b=iGSZOBmkGYs+9IB6HLKZoSW2UYq6Q6+KEDF9T0nw7hjVj/d0RNPBkxELW+hguncXNZZgb4
 +MCxjhJ7lgm/ylDvaRUYNZxMRrw8WV2czDAQD07PQI7Lzwqt38/F0rkNZ8Lwz8O8IjluYK
 nlua1d9sRkvO6aeiiADgqFnUwGO9ZdE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-nvCQVlbQPRKgXTPVpbPRkg-1; Tue,
 13 Oct 2026 13:24:04 +0000
X-MC-Unique: nvCQVlbQPRKgXTPVpbPRkg-1
X-Mimecast-MFC-AGG-ID: nvCQVlbQPRKgXTPVpbPRkg_1791897843
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC2891828B22; Tue, 13 Oct 2026 13:23:58 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C46B768; Tue, 13 Oct 2026 13:23:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:07 +0400
Subject: [GIT PULL 10/40] ui/gtk: forward gtk console size to vc chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-10-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=c3WIoqAn1m+q9dzTTfyGE/ZWv/l2LEbXJxu3wH4b4KA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCw42jQ0+PsTKNks49wy3bvx/cNJO7C9+vm
 smgFHb0nE2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5QVHD/4nEzEsJHwZgyVutqmu3maHiKTxvXgB8YLwXqkNUR0zQxTGNLdp5QH78RNDv8/kaUcSBFk
 mnck6gHkxkazuRFna/wkdibZXGh/Zw34IDRmQ0fnp/3I4YZEfcqATT579GUMZ1s6Yi7hGub30JW
 go0G96abDEXibeNQPZu4PHowNT+OxtIIMclbalR76ECK4yl4aAZJkvP5iyLD15K0yGpSqtuuEQp
 s84FLC56U2HjJhNeZKfI2At/oqgn181q9U/m+6lH7xcKQ8MVNS3zIz665jtStDXtSrS6VGFtvGx
 LE9uOlhxbUqWotIX9s6Z8n7rM7cmnY+0s9cS8/tCBs0rGU37RRMNZBTEsixY7hzAt0XlamoeUJy
 9ZmwOPEKypXpVKmWtgEPItvlN7jXvPkiumIQlD0D2hucmFysKD4/DoHpsgBN/pfbIjNImGRbodH
 TGEdTuOcYVbrsYUCWeyZSbTvj8tNhlgBscVvM/LXwY1DB/CthqePJMJAVqMJ+FJbOQGp5xRG7T8
 TYKlpagRYwJGlxvbdzENCEIN4FranlJYydvgSboKcsC/fUnLZTzBLWmwaNkkF05xhKLbnG/QVmg
 Fuuv4XCiuDvLG1o2+gSEEfWc5Gp2aTv6TSORUs5vKLS7x8PvxqgDvCdUZXU7YHvJpRz+MCGzPUU
 O3uimXumgZz579g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Filip Hejsek <filip.hejsek@gmail.com>

Query the terminal size from the vte library when creating the console
and every time it might change. Vte doesn't send any signal specifically
for terminal size changes, so instead we register callbacks for
size-allocate and char-size-changed.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Message-ID: <20261012-console-resize-v10-9-2c3b10d829b3@gmail.com>
---
 ui/gtk.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index ed7ffc06b154..8d312d6a4b06 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2196,6 +2196,28 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
     return TRUE;
 }
 
+static void gd_vc_vte_update_size(VirtualConsole *vc)
+{
+    uint16_t cols, rows;
+    cols = vte_terminal_get_column_count(VTE_TERMINAL(vc->vte.terminal));
+    rows = vte_terminal_get_row_count(VTE_TERMINAL(vc->vte.terminal));
+    qemu_chr_resize(vc->vte.chr, cols, rows);
+}
+
+static void gd_vc_size_allocate(VteTerminal *terminal,
+                                GtkAllocation *allocation, gpointer user_data)
+{
+    VirtualConsole *vc = user_data;
+    gd_vc_vte_update_size(vc);
+}
+
+static void gd_vc_char_size_changed(VteTerminal *terminal, guint width,
+                                    guint height, gpointer user_data)
+{
+    VirtualConsole *vc = user_data;
+    gd_vc_vte_update_size(vc);
+}
+
 static void gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                            Chardev *chr, int idx)
 {
@@ -2258,6 +2280,12 @@ static void gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                              gtk_label_new(vc->label));
 
     qemu_chr_be_event(vc->vte.chr, CHR_EVENT_OPENED);
+
+    g_signal_connect(vc->vte.terminal, "size-allocate",
+                     G_CALLBACK(gd_vc_size_allocate), vc);
+    g_signal_connect(vc->vte.terminal, "char-size-changed",
+                     G_CALLBACK(gd_vc_char_size_changed), vc);
+    gd_vc_vte_update_size(vc);
 }
 
 static void gd_vcs_init(GtkDisplayState *s)

-- 
2.56.0.116.g6de20f6092dc


