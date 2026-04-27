Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9E3FF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRnn-0007U9-NO; Mon, 27 Apr 2026 15:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRne-0007TY-CQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:39:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRnZ-0006sC-3Z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:39:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so76837915e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777318755; x=1777923555; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/dB9Jl1UuY5f333X9zTcSj/D8VVe4daYWJBNZAwS8QI=;
 b=aRsQ6Xo41JmKqiiqpSBXPduSbdu8YHbe07YOTpmJrEUkZdq5PK6AFeGlWb2qgUr1N9
 3+/JfN7PCdRpqfsoapenNWVi1CGp8G+fkeQicYkOndhV2jn/LaPLM4tXnjgTZhRY8Rzz
 Edl2rB0+4taz96mhwNC0msh6kqzUsbTp+rFG37w3bzVusc/TvPGxP/xMj8KMfmrwX275
 K/xGIltN97SZJ3Hd89JhDINOaWcO3afJk/Pw8pOOH50+LT3vet3l3bWjbEoyHHBYadfz
 imr4qJjLw6lXGEF9z5UdLsEP3CsVHJoAGM7KAbus/JX7eix8cjsEWiqBHXY61WqAmbPG
 xS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318755; x=1777923555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/dB9Jl1UuY5f333X9zTcSj/D8VVe4daYWJBNZAwS8QI=;
 b=p9kNreMBVWFqzYKxicX2OCd3LNv96owclPKo1R0pSBiDaWqGgKatfgn3oe2/xZkH0N
 Q3ge3MFfSFLsiK+gXJ0+PmkIOU2Le3qjU+dCKPjzal0nIvv6j7fuueEh7x9WXbxK2SVC
 1rvKHwgfkSjyp4OHM/usVGpM5Y457CmCzJKPpMjBZIfFJdCDkK0OSEZLuymW3w23qMjL
 tTO05PfGSOD/2iRis78tQf3nvIMH8WFJwW4CtM9SsLGRp/RWsahEq40ENJNiGYEnAZ+r
 sIkruRPl6F2tv5MkvSSM5c+3Ury+mcwwVaduiYdj/WckkL+iA6A+oe3SXwAaFYhM/9dJ
 VvsQ==
X-Gm-Message-State: AOJu0YzjTPSFsE0n0cLwDvFeXLxhbAIvs5mdd93cMAut1xqcYL/HZFDs
 No+PtDH9QfQ6VUjDWNE+dcqi0Rb35IIuYiSONgeTdpe3uLTrW49WZHvm
X-Gm-Gg: AeBDiesK9PPLQ+knx7w1z1Y7utHt9rXpqb532nRGxgkErJD7sb+BIkXtIp6OlJKEUbJ
 l3yTeAzRl/9nlq1icFg6bH2cC75j1e5WvJ7vvuVoI6vTx35pDqvJrrol3runBmCJ8m1RgcU1Mk1
 4LUyJDI0obWELFBKxXK+IvD8yIghFEegFKhnXDKYM43A2496Nb1Ma+p8bQQA+Ag4XwVWFiPfq/J
 ShyL/CvVPSCKFsforuwu4O45HYZJkcNQBDbs8H8OpohGfbjLAu+N/y7+McAYsyuHgjNI4FXviai
 PqlC2oBK9CACW+vo1YKqc0lf7bgNr1pOuFhQjJug6nJ7zHTobEWM95EyIs6CS5CmYwIMKG9CEUa
 il7O8hzDFnvisawR9xT7L6l9WMqb5FdMk+b1eYYbXN6PElmRPhL9fDzDWHHi5Y2q3KnW+tgKd8z
 5v9P0bMobKust3eaSRXHKaq1kcqy9tK+ja0o5ju8o=
X-Received: by 2002:a05:600c:4593:b0:48a:599a:36fe with SMTP id
 5b1f17b1804b1-48a77b1d78cmr1131295e9.24.1777318754992; 
 Mon, 27 Apr 2026 12:39:14 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773e70c2sm8281035e9.10.2026.04.27.12.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:39:14 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Mon, 27 Apr 2026 21:39:11 +0200
Subject: [PATCH v4 2/2] ui/gtk: Keep GTK clipboard enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gtk-clipboard-v4-2-176ad9919931@gmail.com>
References: <20260427-gtk-clipboard-v4-0-176ad9919931@gmail.com>
In-Reply-To: <20260427-gtk-clipboard-v4-0-176ad9919931@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x329.google.com
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


