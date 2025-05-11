Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEFBC3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1D7-0003xr-5g; Sun, 11 May 2025 03:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1D0-0003rw-Gb
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:50 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Cy-0003fK-Nc
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:50 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30aa3980af5so4332379a91.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948886; x=1747553686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sFHBWAVIFh8hI8jbeBWhK/gCidi77zyIaDSI38tXyQ=;
 b=eC/qaHwR8BgR1omD1V3p+1c2Ozh96aeVGMH1oBf0WXwjpz+q70gQnuYVKk0NSJTuHS
 Edvxfg8ajKOfHhcLSV8gbBpAuHzxiLCHxsMVX5pZhfCyNZrQRTvKfnzekFGavhHFbax+
 dgz030RwKjXq6jAn69/xqNQ/CeUKSKBJUlitkAO6iBLa122Sa+sW2qvJHGnsqLPRh+Zw
 bVivKgpE02HyRcyJt90/ds9eHEKkHA1diEbeWbjMoQu7gbuwccfH7OEYkepwPB8Jf+mY
 6MpGXj4dM7E9apQARR1pIbjrDRXy40Lr01j8fZWa2gjpfhC6ov8S9FOaOOv7qGcsw5WX
 S69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948886; x=1747553686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6sFHBWAVIFh8hI8jbeBWhK/gCidi77zyIaDSI38tXyQ=;
 b=j9uuYAE3EGqJe9TBEWLFts5SHgtpGVmULWxYGhizpFrinXP3lFwCgC24mXdiVy0Dmt
 IFaFY2pzdkBefYgJYfdhtg0bfD3BqF+gshSFvNt6G0i5zJ1r7qjg1k+mB5QUGHdbibYy
 y8LsU1vUwelGmoobCbFmU93HvpaBwP4IAUzS52K18yM8Rx/bzT2wwcc6k9scRl5Z/kcV
 NQXuiwNuZJhKjRuQ/dC/rs0PN5cYPW5+tLJgchQAxv+P0K4XloPHSzUFsq+3DEZ7KBJ0
 B9yEMorks2wxkDbZ+09vsyto279/aBKfvbrbnrssBjguBhloPEdvSMLDx4qAq5QleWL1
 CxqA==
X-Gm-Message-State: AOJu0YyMnGUrBT6oApZqTsYwlOWvem2yxS2MrB8F5g3Vea08BsLhcVmr
 wsRJ52mTwarLEfhr731GyBnESS1IMSg3tDY+/s6qNpA2/ICwpVwm9YxqlM0O
X-Gm-Gg: ASbGncutcB/GKHaWEiTMJi60r7aDgD0bKQh9GBFgsbkh5AV6rnz0Wgds9O6DGf+JLfY
 /BHD7wQWNcLwu/Mfa5SIMvIPGVCP6a1/YX662MO5Np4v6qxA6iECpzzT2qDmKhJ//6Mbdq+yCS+
 huJE6lV+DXX1d7VCp36k2qUcjb7Qh36SNi6u0LYbwrRvx+PhnlEhQ3Wgc8g0lyy4iNpTCHiQWab
 mN4qBDhMNM/NARlYtWWBYi4RUZP64oO5yazS9jXzrSKkMhkeAuls3FMINm+o5U0tTEijiHkAVH9
 7hGABYSIuJRbf2YlhMM/tmy+C29g1PkgYGqkzaqMhNWjeqP95po56IE=
X-Google-Smtp-Source: AGHT+IGttMqI9Kg3Zx/gHkQC95PLDH1RaCsfUaGRjch7zvSNY/t74kjiD0TqIYmGkk5cCHe0mdpbMw==
X-Received: by 2002:a17:90b:1c05:b0:30a:2173:9f0b with SMTP id
 98e67ed59e1d1-30c3d62e5b8mr14580542a91.28.1746948886425; 
 Sun, 11 May 2025 00:34:46 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c394a2467sm4551957a91.0.2025.05.11.00.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:45 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu@intel.com>
Subject: [PATCH 5/9] ui/sdl: Consider scaling in mouse event handling
Date: Sun, 11 May 2025 15:33:15 +0800
Message-ID: <20250511073337.876650-6-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Weifeng Liu <weifeng.liu@intel.com>

When using sdl display backend, if the window is scaled, incorrect mouse
positions will be reported since scaling is not properly handled. Fix it
by transforming the positions from window coordinate to guest buffer
coordinate.

Signed-off-by: Weifeng Liu <weifeng.liu@intel.com>
---
 ui/sdl2.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index cda4293a53..b00e421f7f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -488,14 +488,14 @@ static void handle_mousemotion(SDL_Event *ev)
 {
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->motion.windowID);
+    int scr_w, scr_h, surf_w, surf_h, x, y, dx, dy;
 
     if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
+    SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
     if (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
-        int scr_w, scr_h;
-        SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
         max_x = scr_w - 1;
         max_y = scr_h - 1;
         if (gui_grab && !gui_fullscreen
@@ -509,9 +509,14 @@ static void handle_mousemotion(SDL_Event *ev)
             sdl_grab_start(scon);
         }
     }
+    surf_w = surface_width(scon->surface);
+    surf_h = surface_height(scon->surface);
+    x = (int64_t)ev->motion.x * surf_w / scr_w;
+    y = (int64_t)ev->motion.y * surf_h / scr_h;
+    dx = (int64_t)ev->motion.xrel * surf_w / scr_w;
+    dy = (int64_t)ev->motion.yrel * surf_h / scr_h;
     if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
-        sdl_send_mouse_event(scon, ev->motion.xrel, ev->motion.yrel,
-                             ev->motion.x, ev->motion.y, ev->motion.state);
+        sdl_send_mouse_event(scon, dx, dy, x, y, ev->motion.state);
     }
 }
 
@@ -520,12 +525,17 @@ static void handle_mousebutton(SDL_Event *ev)
     int buttonstate = SDL_GetMouseState(NULL, NULL);
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->button.windowID);
+    int scr_w, scr_h, x, y;
 
     if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
     bev = &ev->button;
+    SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
+    x = (int64_t)bev->x * surface_width(scon->surface) / scr_w;
+    y = (int64_t)bev->y * surface_height(scon->surface) / scr_h;
+
     if (!gui_grab && !qemu_input_is_absolute(scon->dcl.con)) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
             /* start grabbing all events */
@@ -537,7 +547,7 @@ static void handle_mousebutton(SDL_Event *ev)
         } else {
             buttonstate &= ~SDL_BUTTON(bev->button);
         }
-        sdl_send_mouse_event(scon, 0, 0, bev->x, bev->y, buttonstate);
+        sdl_send_mouse_event(scon, 0, 0, x, y, buttonstate);
     }
 }
 
-- 
2.49.0


