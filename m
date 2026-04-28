Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCF9FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdap-0007Q2-Im; Tue, 28 Apr 2026 04:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaf-0006xa-VB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdad-0006Bd-Pu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkoMxUm4vsgMt7DasSOOyZM2kaQiTX4th3X5ACDgNNI=;
 b=B79FosKGe+ioj/xQF8OAZGhSvWZk2MCza3PGy5XYJfkzEVnKtw+RFEXEvFuVYIZEDljQYl
 XUG6IjJk3BCkWpEXcwp0d8xsTr/prPJ5bylwd+eyq+MCsZWAu+O6SnMtvifCcRcv1eBlXd
 f8rFm4u1TxJD70pt2Osc/k3gjAovPsM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-AXIsalAMOI2suB3Wh88mLg-1; Tue,
 28 Apr 2026 04:14:39 -0400
X-MC-Unique: AXIsalAMOI2suB3Wh88mLg-1
X-Mimecast-MFC-AGG-ID: AXIsalAMOI2suB3Wh88mLg_1777364078
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AEB71800378; Tue, 28 Apr 2026 08:14:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F05213000C22; Tue, 28 Apr 2026 08:14:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Jind=C5=99ich=20Makovi=C4=8Dka?= <makovick@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 15/15] ui/gtk: Turn clipboard flag into runtime option
Date: Tue, 28 Apr 2026 12:13:02 +0400
Message-ID: <20260428081303.990973-16-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jindřich Makovička <makovick@gmail.com>

- Compile the GTK clipboard support unconditionally

- Introduce GTK clipboard option, defaulting to off

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
---
 meson.build                   | 4 ----
 qapi/ui.json                  | 6 +++++-
 ui/gtk.c                      | 8 +++++---
 meson_options.txt             | 7 -------
 qemu-options.hx               | 9 ++++++---
 scripts/meson-buildoptions.sh | 3 ---
 ui/meson.build                | 4 +---
 7 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index 096303f021c..761c0436a32 100644
--- a/meson.build
+++ b/meson.build
@@ -1932,7 +1932,6 @@ endif
 gtk = not_found
 gtkx11 = not_found
 vte = not_found
-have_gtk_clipboard = get_option('gtk_clipboard').enabled()
 
 if get_option('gtk') \
              .disable_auto_if(not have_system) \
@@ -1954,8 +1953,6 @@ if get_option('gtk') \
                        method: 'pkg-config',
                        required: get_option('vte'))
     endif
-  elif have_gtk_clipboard
-    error('GTK clipboard requested, but GTK not found')
   endif
 endif
 
@@ -2475,7 +2472,6 @@ if glusterfs.found()
 endif
 config_host_data.set('CONFIG_GTK', gtk.found())
 config_host_data.set('CONFIG_VTE', vte.found())
-config_host_data.set('CONFIG_GTK_CLIPBOARD', have_gtk_clipboard)
 config_host_data.set('CONFIG_HEXAGON_IDEF_PARSER', get_option('hexagon_idef_parser'))
 config_host_data.set('CONFIG_LIBATTR', have_old_libattr)
 config_host_data.set('CONFIG_LIBCAP_NG', libcap_ng.found())
diff --git a/qapi/ui.json b/qapi/ui.json
index e3da77632a8..b2c42a7f578 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1319,6 +1319,9 @@
 #
 # GTK display options.
 #
+# @clipboard: Enable host-guest clipboard sharing.  Defaults to "off".
+#     (Since 11.1)
+#
 # @grab-on-hover: Grab keyboard input on mouse hover.
 #
 # @zoom-to-fit: Zoom guest display to fit into the host window.  When
@@ -1344,7 +1347,8 @@
 # Since: 2.12
 ##
 { 'struct'  : 'DisplayGTK',
-  'data'    : { '*grab-on-hover'     : 'bool',
+  'data'    : { '*clipboard'         : 'bool',
+                '*grab-on-hover'     : 'bool',
                 '*zoom-to-fit'       : 'bool',
                 '*show-tabs'         : 'bool',
                 '*show-menubar'      : 'bool',
diff --git a/ui/gtk.c b/ui/gtk.c
index 8fd39c90c29..ec95f0f294a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2601,9 +2601,11 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
         opts->u.gtk.show_tabs) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->show_tabs_item));
     }
-#ifdef CONFIG_GTK_CLIPBOARD
-    gd_clipboard_init(s);
-#endif /* CONFIG_GTK_CLIPBOARD */
+
+    if (opts->u.gtk.has_clipboard &&
+        opts->u.gtk.clipboard) {
+        gd_clipboard_init(s);
+    }
 
     /* GTK's event polling must happen on the main thread. */
     qemu_main = NULL;
diff --git a/meson_options.txt b/meson_options.txt
index 31d5916cfce..286461129bd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -262,13 +262,6 @@ option('vnc_sasl', type : 'feature', value : 'auto',
        description: 'SASL authentication for VNC server')
 option('vte', type : 'feature', value : 'auto',
        description: 'vte support for the gtk UI')
-
-# GTK Clipboard implementation is disabled by default, since it may cause hangs
-# of the guest VCPUs. See gitlab issue 1150:
-# https://gitlab.com/qemu-project/qemu/-/issues/1150
-
-option('gtk_clipboard', type: 'feature', value : 'disabled',
-       description: 'clipboard support for the gtk UI (EXPERIMENTAL, MAY HANG)')
 option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
diff --git a/qemu-options.hx b/qemu-options.hx
index 21972f83268..e780bc2ac06 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2209,9 +2209,9 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     "            [,window-close=on|off]\n"
 #endif
 #if defined(CONFIG_GTK)
-    "-display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]\n"
-    "            [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]\n"
-    "            [,show-menubar=on|off][,zoom-to-fit=on|off]\n"
+    "-display gtk[,clipboard=on|off][,full-screen=on|off][,gl=on|off]\n"
+    "            [,grab-on-hover=on|off][,show-tabs=on|off][,show-cursor=on|off]\n"
+    "            [,window-close=on|off][,show-menubar=on|off][,zoom-to-fit=on|off]\n"
 #endif
 #if defined(CONFIG_VNC)
     "-display vnc=<display>[,<optargs>]\n"
@@ -2295,6 +2295,9 @@ SRST
         drop-down menus and other UI elements to configure and control
         the VM during runtime. Valid parameters are:
 
+        ``clipboard=on|off`` : Enable host-guest clipboard sharing,
+                               defaults to "off"
+
         ``full-screen=on|off`` : Start in fullscreen mode
 
         ``gl=on|off`` : Use OpenGL for displaying
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index ca5b113119a..80de8c4af42 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -124,7 +124,6 @@ meson_options_help() {
   printf "%s\n" '  glusterfs       Glusterfs block device driver'
   printf "%s\n" '  gnutls          GNUTLS cryptography support'
   printf "%s\n" '  gtk             GTK+ user interface'
-  printf "%s\n" '  gtk-clipboard   clipboard support for the gtk UI (EXPERIMENTAL, MAY HANG)'
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
@@ -336,8 +335,6 @@ _meson_option_parse() {
     --disable-gnutls) printf "%s" -Dgnutls=disabled ;;
     --enable-gtk) printf "%s" -Dgtk=enabled ;;
     --disable-gtk) printf "%s" -Dgtk=disabled ;;
-    --enable-gtk-clipboard) printf "%s" -Dgtk_clipboard=enabled ;;
-    --disable-gtk-clipboard) printf "%s" -Dgtk_clipboard=disabled ;;
     --enable-guest-agent) printf "%s" -Dguest_agent=enabled ;;
     --disable-guest-agent) printf "%s" -Dguest_agent=disabled ;;
     --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=enabled ;;
diff --git a/ui/meson.build b/ui/meson.build
index 3d15ff96287..ceaf110683d 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -112,9 +112,7 @@ if gtk.found()
 
   gtk_ss = ss.source_set()
   gtk_ss.add(gtk, vte, pixman, files('gtk.c'))
-  if have_gtk_clipboard
-    gtk_ss.add(files('gtk-clipboard.c'))
-  endif
+  gtk_ss.add(files('gtk-clipboard.c'))
   gtk_ss.add(when: x11, if_true: files('x_keymap.c'))
   gtk_ss.add(when: opengl, if_true: files('gtk-gl-area.c'))
   gtk_ss.add(when: [x11, opengl], if_true: files('gtk-egl.c'))
-- 
2.53.0


