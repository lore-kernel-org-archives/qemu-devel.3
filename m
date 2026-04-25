Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5792EFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZTH-00059d-Nv; Sat, 25 Apr 2026 05:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZTE-00058j-9S
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:38:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZTC-00060z-DW
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:38:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so4743607f8f.1
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 02:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777109917; x=1777714717; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2dMq8uAY2hZDh7iH5qWRo1QMrdAHDTbtAcXk7hVbErE=;
 b=OVNUlNJMH15KtJQzOb/beX1miL1s8PB0AQr+TAZai80uHWbE/2gkxiPPfpJq6VHzbT
 mk779H3H3ZVDkgznnFV2J4y14Rypb+TDhUCBGlJHT8UnizHi35XPL0LnIPn2qRJoKjcM
 /6ZkXJp5UEW3QKEy23OpJbhZ0iX+dUlqhGllCEHRMb62Rl6iLdjufV1kcJfCtL55aLqH
 8318xhPSwPWedUA8hdXuoT93ZiAKBNl38NxBQDPmAgAWrPbv+97yTVgvV0OEbXUWfURE
 u6SJq0DrERkmDrznbCZ6QLASNFQnRyO4X8gDXFi+S82O5tj7+i4pMkspggHTU/1+X6z+
 znuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777109917; x=1777714717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2dMq8uAY2hZDh7iH5qWRo1QMrdAHDTbtAcXk7hVbErE=;
 b=GbRYgQuZlKcfXqw/qNUiWyH1LHgsHQLX/YTDys2dao6oEOrXkrpA3q0Cz8gkRpGORI
 8UBYksqiSEcCFvSixGvj7yHePbHGtUanWjWz4ng1aQLnsjtjI6GRD8uBztY8WFgZVVYx
 SsoBzlK19nlccTVXFh/KnUDrf+5+OQ1zq8+Kut8I148NHywRYqg0onsJBTkvSoW11LYX
 psa8n2UPnTYE4TxbtfxU6ooOhNGUQrhXKvusxBZKcBAx7C8PfW/u3DPHtxR679+9ALmB
 1JtLQZHnj+uTNmPbV/YCD2RY4VdF9GIuZWafg/z4mVWxDUvapXmFJjwe8Ux9Sqsh5GCs
 S1XA==
X-Gm-Message-State: AOJu0Yx9HeV3jDIlUHqUKo56kcJZhK80qSk+rPpuyhoSkNiPemw9DFG7
 /y+WHUV5JW6fqe3tTY/qGf9EXtybZX+r8CLIr6cgJGLh/LHQO287m/D4Dsd5bP953Yc=
X-Gm-Gg: AeBDiev9nr3lx4Xpxm8NQCUDQYLGQXcAYIC/7d0TfGr1l66Y9+pxw97dRbCLjzTRWsy
 Tqqbj7C+KQd8ixC9Qb3HuvRVS5b67rU8jXst2G2Sb1z5xFQnYTNB24AfZV9q+Vp/4ONZszqw2Uc
 Hxbs3rZsI17EpMJceT6uDdqCSfWw0VsYFNX5HQ2NfDjFcZ9dg/hDGQb0HFjQg/X9Pj1K4dXEgZc
 JeiMCyA3rrEkFd1bZvY2i5b1N6yaufYwDEXFKYKDpwf7DG0hhTpG5KwS+NZyvB/YTQJZuVGWDlE
 sskBkrrfbyq3ejsqD8mZl3Nrf+qW/CvrcMVI/GkoUn7+Xgl2PDsY6JAIhxBUE4Bdni29OsZyq0t
 n8BLhpghxuYFtokAmK/xdp7Bee31ODuOAQvoRXt8PNeOMrconn1gizRNuQucxa8Pa/JH+wPDHpK
 7mq+rju6bwHCOvIMDCL4BaUygaKZks1i4PAXbdTPc=
X-Received: by 2002:a05:6000:40ca:b0:43e:a70d:763d with SMTP id
 ffacd0b85a97d-43fe3e14e43mr54017384f8f.46.1777109916564; 
 Sat, 25 Apr 2026 02:38:36 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm74965992f8f.20.2026.04.25.02.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 02:38:35 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Sat, 25 Apr 2026 11:38:32 +0200
Subject: [PATCH 2/2] ui/gtk: Keep GTK clipboard enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-gtk-clipboard-v1-2-6bd99e708e14@gmail.com>
References: <20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com>
In-Reply-To: <20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=makovick@gmail.com; helo=mail-wr1-x433.google.com
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
 meson_options.txt | 2 --
 ui/gtk.c          | 2 --
 ui/meson.build    | 4 +---
 4 files changed, 1 insertion(+), 11 deletions(-)

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
index 31d5916cfc..1d4523682b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -267,8 +267,6 @@ option('vte', type : 'feature', value : 'auto',
 # of the guest VCPUs. See gitlab issue 1150:
 # https://gitlab.com/qemu-project/qemu/-/issues/1150
 
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


