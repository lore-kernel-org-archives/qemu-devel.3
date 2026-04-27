Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B78BFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSEa-0005VP-KY; Mon, 27 Apr 2026 16:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSEL-0005U5-IC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:06:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSEI-00058M-K7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:06:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so181006365e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777320413; x=1777925213; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/jY2+kwe2S2V0RgrKuq3DboBzyZETsHe+RrPp0TFj/g=;
 b=OzPy7KCk5IhOaiKMqvFv6ZmHPivm+pa2TX+GXnNcahAROWIaeKuWJtPqT9rhQ73ECM
 rVY7PupJwK6pc9+zGnwbKmPlJEI7zbEW2+pasbz9l9OTOn3Ys/UjNGRm1khzKmZCQ/jF
 5Qny7DvT9y2V09hdmSglH6JXeS+Y2JBCoWUblWrkyW/PVmf0ohQ82kZNjN/nvgROXTkS
 hepnncpud5yYqpL/9xRHexrRKG+Kv9Xssn5zKnvsWpAZ+RUSvQZ4P7E08Z5wCdqP+Vg4
 7wH0bZ6YyZ1m0xODpefw0IuFkYOb/kxe/LOxI2kxMnHiZC5nYEQkl5xVe2YY9ageH/O8
 qI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777320413; x=1777925213;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/jY2+kwe2S2V0RgrKuq3DboBzyZETsHe+RrPp0TFj/g=;
 b=SW3FUlh2fL94GT9Dw5VA7fy0Cza+E89LaOFTDOlbzW2qzs8IdQ2pvZy2tWKOZUb2GF
 itHUPZ5Z32Bn8ClgVa7grpeXbAkj9YepTQKml/z+J55vTDiCexeQsaXrXWMOAlHpsVdq
 Tazrc6d021l0uxm7xZ3eDuFI3f2Q5oRmL22kFg1aT1jcn7ErejtXk1VHe44Ke+NVBmDg
 6MbUuFCGNRFGOpgDjN4DPKorr89G8dX5VfQAUQQk5sQwus7bluGD2BSlZekKNWkjindo
 2eZ2ZpAdKKBLVqdDf8SkDL+Tsn275fm8TcFEKJnYu7zRZg1njfwpIhPEF89UWJrGsPMQ
 ELAA==
X-Gm-Message-State: AOJu0YxDOyRLAayZatlHtSLgLVdDSpnshkkb4WMkTvHOLgdIzcEMR3YG
 Q7t2tS2PzzToL5DrGXxJ93PyfEEd4zmMPVen0zASqTLf8a2LUn9ey0JKIZiJ5vNRxJo=
X-Gm-Gg: AeBDieu3lL8dWA3aIi09HOezPw21JyGa6uLvoFB8WEt05Tg67foml6NUJGmu8LuvOfY
 9JZxaaqmdaiC5ibmoBV5GXhLB0hKnUzGOOr4Lg9UY+ZGwkXhuZ3dOXuAsPkeA9tVZ/vjmlPCiUV
 SbjTYZkDnaJVMVrhzQjMk+dWLJiN/0WjVqaTJ4Oe/jKOSIuRyRSLvWvg6MjsGexCGVIrSJKOlw6
 kNm6AHRWycNZDUy3QBbcIcQMDz24jgYrA+ziOn4jMggbn/bsgkn2Ve8oVp8oEik6V1Dw0oJjmyK
 AK3m2b4j0KJ5tbwJaf+8vfDve3+mrb56OPKtuFGObXJCrojJ6QjRrH6VtUUUjupdowdTNFGpkbs
 iHUudO4SLr619RO5dsmDZGVjNH331VYjXC9StA5qZVKhyDUzgDSXlJSZhbFdSwJiATVB0ZB9pjG
 DrzB3XNAeq8ir2v4DhfW1a/EHxowu4N6Jp5bFYHb8=
X-Received: by 2002:a05:600c:4f8a:b0:489:d1c:d468 with SMTP id
 5b1f17b1804b1-48a77b24d5bmr1787845e9.31.1777320412954; 
 Mon, 27 Apr 2026 13:06:52 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773efe38sm12767755e9.13.2026.04.27.13.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 13:06:52 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Mon, 27 Apr 2026 22:06:44 +0200
Subject: [PATCH v5 2/2] ui/gtk: Turn clipboard flag into runtime option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
References: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
In-Reply-To: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

- Compile the GTK clipboard support unconditionally

- Introduce GTK clipboard option, defaulting to off

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 meson.build       | 4 ----
 meson_options.txt | 7 -------
 qapi/ui.json      | 6 +++++-
 qemu-options.hx   | 9 ++++++---
 ui/gtk.c          | 8 +++++---
 ui/meson.build    | 4 +---
 6 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 096303f021..761c0436a3 100644
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
diff --git a/meson_options.txt b/meson_options.txt
index 31d5916cfc..286461129b 100644
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
diff --git a/qapi/ui.json b/qapi/ui.json
index e3da77632a..b2c42a7f57 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 21972f8326..e780bc2ac0 100644
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
diff --git a/ui/gtk.c b/ui/gtk.c
index 9ebe7e8df0..ab5f1ef7aa 100644
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
diff --git a/ui/meson.build b/ui/meson.build
index 4e533d3046..6405e21d5d 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -111,9 +111,7 @@ if gtk.found()
 
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


