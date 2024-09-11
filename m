Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1ACEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKq-0007xG-Gc; Wed, 11 Sep 2024 08:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKk-0007cY-P2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKi-0007yB-Pl
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso23686595e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057227; x=1726662027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsK0mdY5OlPxji3PY5r+h72YwQWFU0AxW9NvQTZMW7U=;
 b=u7+MSQb2UDgsa7MXNtwayQKUqEvYsdRjrM+1fOCjckgOwjzE3cfKumnYfMNf7ey3Hh
 GY/5x7gC/noYYvciqOiiBtxwCk5O3sa8G479CLc6oGpy+Zh63R6Tr720Oj2gAHHnJ5p4
 7WVdB8tKxevXtp4cPsvVI4NEF3HIv1sIJIhmOWYKw2tHKyam49gVC+8+vN6yMrNDR6ng
 eCIpi/8ZLEtXsaQQymw8wVl2zmXUtBobzuqRx2WgOa2PLlVsqy2ZRULLd391tqFwD6+M
 k+etd1yzDx8mFFEEMKkCtNSZxVnrltzHdEvmbfBMkdIdIOQSu5rbrj1KpQSnvaqqnN3Y
 v2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057227; x=1726662027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsK0mdY5OlPxji3PY5r+h72YwQWFU0AxW9NvQTZMW7U=;
 b=tXBpFoGNdDkLW8mNXUY4dPXxX2kSvvfrizO8shXtPuYvDQzn4l6vvW5KHkfTfegE+i
 G5hvCsSdQ486xtDVQq1evcVGH6mySYurpJmK1kdfOony9BYfMDsYClUhllblhLUGp5o5
 gkyUjNT8BGjaYgevDQnIpdqBJaoPr723r0TlqwvcUnZ00HaEwP7uzZ/6YXUmBR9YUiVV
 dhyAKAHK2v2lXjsIyR9APP7ZkTTPaFSHTTlsyX5/NRk1YgBqsurNfTSIwCKZYYgSN0u2
 rIwSCLU3muAth72RSELzjz75EkT1qHHqHfxQm+DjZmsjW8yZk6ofDJfsV262kjY9JDLx
 BYfw==
X-Gm-Message-State: AOJu0YwHcAHO0MtDQ+Kcq6lzMaX26r2rDnwtGRRwTe1xzEQUWC3NfP+6
 4XJN76ShbTT80eDqJ/2ymSUjilcmgC/W/CGLa2SbwBJqbPyCBaQkG513BaBbwL2UdUqnORoMSZu
 h
X-Google-Smtp-Source: AGHT+IEI8tLAsTrL3BEevsqzMIXSEz/dFFBNMk7axa+KxsHZhPQhB/HVcNvzCXfCOIqq3LbeC1R1dw==
X-Received: by 2002:a7b:c858:0:b0:42c:af06:71b with SMTP id
 5b1f17b1804b1-42caf060978mr98192025e9.28.1726057226929; 
 Wed, 11 Sep 2024 05:20:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb815f4sm142611685e9.30.2024.09.11.05.20.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:20:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 54/56] ui/sdl2: ignore GUI keys in SDL_TEXTINPUT handler
Date: Wed, 11 Sep 2024 14:14:19 +0200
Message-ID: <20240911121422.52585-55-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Volker Rümelin <vr_qemu@t-online.de>

Ignore GUI keys for SDL_TEXTINPUT events, just like GUI keys are
ignored for SDL_KEYDOWN events. This prevents unintended text input
in a text console when hiding the text console with the GUI keys.

The SDL_TEXTINPUT event always comes after the SDL_KEYDOWN event.
See https://github.com/libsdl-org/SDL/issues/1659.

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20240909061552.6122-3-vr_qemu@t-online.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/sdl2.h |  1 +
 ui/sdl2.c         | 17 +++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 6907115809..dbe6e3d973 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -42,6 +42,7 @@ struct sdl2_console {
     int updates;
     int idle_counter;
     int ignore_hotkeys;
+    bool gui_keysym;
     SDL_GLContext winctx;
     QKbdState *kbd;
 #ifdef CONFIG_OPENGL
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bf6868f204..574a22306d 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -388,12 +388,13 @@ static void handle_keydown(SDL_Event *ev)
     int win;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
     int gui_key_modifier_pressed = get_mod_state();
-    int gui_keysym = 0;
 
     if (!scon) {
         return;
     }
 
+    scon->gui_keysym = false;
+
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
@@ -419,15 +420,15 @@ static void handle_keydown(SDL_Event *ev)
                     }
                 }
                 sdl2_release_modifiers(scon);
-                gui_keysym = 1;
+                scon->gui_keysym = true;
             }
             break;
         case SDL_SCANCODE_F:
             toggle_full_screen(scon);
-            gui_keysym = 1;
+            scon->gui_keysym = true;
             break;
         case SDL_SCANCODE_G:
-            gui_keysym = 1;
+            scon->gui_keysym = true;
             if (!gui_grab) {
                 sdl_grab_start(scon);
             } else if (!gui_fullscreen) {
@@ -440,7 +441,7 @@ static void handle_keydown(SDL_Event *ev)
                 /* re-create scon->texture */
                 sdl2_2d_switch(&scon->dcl, scon->surface);
             }
-            gui_keysym = 1;
+            scon->gui_keysym = true;
             break;
 #if 0
         case SDL_SCANCODE_KP_PLUS:
@@ -459,14 +460,14 @@ static void handle_keydown(SDL_Event *ev)
                         __func__, width, height);
                 sdl_scale(scon, width, height);
                 sdl2_redraw(scon);
-                gui_keysym = 1;
+                scon->gui_keysym = true;
             }
 #endif
         default:
             break;
         }
     }
-    if (!gui_keysym) {
+    if (!scon->gui_keysym) {
         sdl2_process_key(scon, &ev->key);
     }
 }
@@ -492,7 +493,7 @@ static void handle_textinput(SDL_Event *ev)
         return;
     }
 
-    if (QEMU_IS_TEXT_CONSOLE(con)) {
+    if (!scon->gui_keysym && QEMU_IS_TEXT_CONSOLE(con)) {
         qemu_text_console_put_string(QEMU_TEXT_CONSOLE(con), ev->text.text, strlen(ev->text.text));
     }
 }
-- 
2.45.2


