Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F81FF885D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZi0-0002wW-BB; Sat, 25 Apr 2026 05:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZhy-0002vm-BD
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:53:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZhv-0002B9-R4
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:53:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so5901072f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777110830; x=1777715630; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/dB9Jl1UuY5f333X9zTcSj/D8VVe4daYWJBNZAwS8QI=;
 b=XH251KxSkJt5l4cS9OuzkjaCGXG4P4EVJVvXIBKdgWoPdIgP8uVfJZHJ33Fe2NbGnH
 EdPnQCekERzS8bYSl5b6A4XoVD+Z+Xuv78cZ8vertP5FNJqN9aVpn670CJ7EFhIRClmO
 KwMPJLKJgnVNSZYsu/W8jmk4u3j/HMFw6OnIW/Y4K5kIN1IoskWWd2pWubL0ufwo/3uA
 cYoHNJ+Uq2rpHS4C43frve5xLXKj6WCx/ehaZwQWukwM+xUEyuqenoUyc1vZAgmgQIcI
 RNH+nsa3r0aTiBFO9I+VkHaDwjBWUeO8zCALbIID6Ajz+Qco7wE/CSG8x+ZoRhHATDYb
 f+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777110830; x=1777715630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/dB9Jl1UuY5f333X9zTcSj/D8VVe4daYWJBNZAwS8QI=;
 b=a6VnKjGOLR4eId2LinwHbjzKpF3F2Pe0ZfRFB6sMwOqGSZEGDvCtrDJLPD8V17/UfE
 brYL1R9XV7J3ID/gX6L9dIohTDnt41dIHAvbsprfSbopStO+Fggd8/actN4bU15TJ6XJ
 xyHvnT8MWMZfNLbWFLgjKFZb4pxn8nDuTNwKq/nsNfsaYf2e2EbDDUgiY0THzHRUu7GS
 2RJhCCWMuzqKJfGeYQSCa1x7DiPGYEyUrvzWIBjZA1rSTC88cvWnS0iy+pk/CAlA/fDe
 MrPymnyCQApd/GuUJOzU+hNKSEahT1JqOzmBcMLVGS3B0VD08jaKn+OU+LIW0A73Xv7D
 Vmig==
X-Gm-Message-State: AOJu0YyaWr7Gyr8ylABMEdw45dyGDI2YHsTcw2x/sIzruseZWXvgvGVt
 u6bNUvavGz4koaCccWAFvOuAPt7OeeQkGtHooL+f9XKPKTZ4G9KdOU1TFNdkQnFfCIo=
X-Gm-Gg: AeBDiev8qiAS4uFAx4aElIkdJdDSR13jnAHLcBIfxahf4yUtZw8FmnX4sAyaINvzwsV
 5v/0vpqVWW45FtTbMwrBLH44LjPwO+aUjvF2alOuUEqdXCxu+QSS/FSxVo9sJD8MqJkQckuDV6q
 QiHpPCi2OhNKtrOgVWK7QSPq6c/UwcsZzDZqj7qszC/c7B4BpZjxDtngTLcbwosISpn3rq+Wzch
 OCA5yCJwCYlooKh/rQZxxb5Unu4zOHsNWhh/4OruZpXpyzHXX3j/nAzVKxIvVk5PqhwTlP49PrZ
 ImXZdYH5EUkTXjHkDeoy7ApbRtlqoo0WVZzZgMFQ2oAluRIXE+5RcWGDOD14XD+GtrAqrzDprZz
 MDgnHw0pEKAVCJHaS49ZfJ7JOfznd4uLuDPk6vd+k1g0hC+2bj2ulOPBrwAFO0QddmZo9VDCa9k
 Aq9HcB30jVtQlTIKr3237nb56MLdf9GDlWX4fCAUw=
X-Received: by 2002:a05:6000:4550:b0:441:37b5:d788 with SMTP id
 ffacd0b85a97d-44137b5d7c1mr2669049f8f.8.1777110830202; 
 Sat, 25 Apr 2026 02:53:50 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm67574574f8f.10.2026.04.25.02.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 02:53:48 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Sat, 25 Apr 2026 11:53:41 +0200
Subject: [PATCH v2 2/2] ui/gtk: Keep GTK clipboard enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-gtk-clipboard-v2-2-b098f3cf69cc@gmail.com>
References: <20260425-gtk-clipboard-v2-0-b098f3cf69cc@gmail.com>
In-Reply-To: <20260425-gtk-clipboard-v2-0-b098f3cf69cc@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=makovick@gmail.com; helo=mail-wr1-x431.google.com
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

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 meson.build       | 4 ----
 meson_options.txt | 7 -------
 ui/gtk.c          | 2 --
 ui/meson.build    | 4 +---
 4 files changed, 1 insertion(+), 16 deletions(-)

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
diff --git a/ui/gtk.c b/ui/gtk.c
index 9ebe7e8df0..5e63c502ed 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2601,9 +2601,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
         opts->u.gtk.show_tabs) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->show_tabs_item));
     }
-#ifdef CONFIG_GTK_CLIPBOARD
     gd_clipboard_init(s);
-#endif /* CONFIG_GTK_CLIPBOARD */
 
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


