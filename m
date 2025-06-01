Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36815C5B559
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 04:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLahd-0006xt-8S; Sun, 01 Jun 2025 00:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLahX-0006x8-6t
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 00:53:39 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLahV-0002QG-Ao
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 00:53:38 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-309fac646adso4044597a91.1
 for <qemu-devel@nongnu.org>; Sat, 31 May 2025 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748753615; x=1749358415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7ZYhg5f98QXcBbYXh1bLssUQ7z4lxRxh40jHAXmpIk=;
 b=jh64UG/cfuMmcZowWBSVewsNE0NWLuU6E0vSf2xMRLzWfiWVptut40sGUN+617Xe+d
 nwT/nwAEQUsDqLuXBeXPsk4cCW2Oyx93LUFg2PtopW+6iGIYApiyWKGrAOtnJyV6kWnQ
 TXyMmRfQo6Mvpj1mr8Z5ZTNopKq8os8iCb/d16osGb6EV/vL0IE7PFApjcDmzrgxr89I
 rTZc7o2zif9uuIsXBMPYUL5WgpiKrulk+ehlceNY8mre4+ILSJ2FJ5PPwrXeYaf1z6zN
 SgESsSWgb9DveRfJ+7RDCq6dWRXiDDpUN8auShWfk0qr5//uL2AoZDEbcpy2EEY36/Az
 B0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748753615; x=1749358415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7ZYhg5f98QXcBbYXh1bLssUQ7z4lxRxh40jHAXmpIk=;
 b=QhF/+S7NrkrWUvYMbCu2eQINV2+UuZ+SqWBM0CFfXMNRWpcSjUaLGqDHVmgAFXxDYN
 P9Tz/GKTfU4LZaP4zw4gCmbMEFGSKSkyatKSD1xeFUGegyV6UvdT7nwEdSClKNBTq1Ew
 ++qlFWwRQkbevsVt1/GpuNYucs25XJn24PiIc0dMIKMTdoFdVgWh3mOfodfwkUGdclav
 JOHn5GEeQsZLWQP54Kvdk+aLPnTpafhDwWlYeUvXqPs4aOL2fakFnDl8UOculvnTc5BI
 qTyp/4OW86SZuUYo2ahhm5ceMKQfztps70Y1GJ7woohtCUn7EksKwrw9g4Wwv1yG+fjF
 sSLw==
X-Gm-Message-State: AOJu0YyQOgjvVozgDk4isgj0ZiBx2wpBaS4kuvTxIyxVR8R5G93JRhHI
 mr3yaM4vywgMcYLHhqlrALmNUmqPKxq9F8luBGWlv/kCaOD+CF3dxDpYcIq27wGEs94=
X-Gm-Gg: ASbGncsAkDx1SqYECEco+OAUrSAH5MqzWVkiOgvkyUc1TRblL+hJkIgp4TqnTbPw1rL
 tWcjcY2KIImHrhAQnmT5ydOZEEqym7InQcIXnD/kR0sxvS2wreBQWv845Lyj1xigOynuVrEDeum
 coYuJDdSnWlnxy9oCkMdzSYvyyJPQ3fWG5PIvojns8KXAAjZEELIq8KrFXk6oqyQDdkjgqA38tF
 EtYqmAi1sQHw3WtIzoc3j7FNLYzUmF24FeSbdRWieTm/oxFFd9m9f1AETntzjneN7WVbKCsdZvC
 cICzeoR2cYmkWk/BTiBf2/wVERMJkCx7Mfon4SOuN+0fM4bL5u/t0zg=
X-Google-Smtp-Source: AGHT+IGGqwHw6ODHmRWSFNxp51iCyS4Jfaoy2DHYndnl8W/ZS5TJcss3iF99UrAPQBMq/xFNS3fIwg==
X-Received: by 2002:a17:90b:4a0d:b0:310:b602:bc52 with SMTP id
 98e67ed59e1d1-31214e11d96mr19215353a91.2.1748753614715; 
 Sat, 31 May 2025 21:53:34 -0700 (PDT)
Received: from localhost ([103.192.227.65]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3124e39742fsm3826144a91.27.2025.05.31.21.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 21:53:34 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] ui/gtk: Add keep-aspect-ratio option
Date: Sun,  1 Jun 2025 12:52:32 +0800
Message-ID: <20250601045245.36778-2-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601045245.36778-1-weifeng.liu.z@gmail.com>
References: <20250601045245.36778-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pj1-x1032.google.com
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

When aspect ratio of host window and that of guest display are not
aligned, we can either zoom the guest content to fill the whole host
window or add padding to respect aspect ratio of the guest. Add an
option keep-aspect-ratio to allow users to select their preferred
behavior in this case.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Suggested-by: Kim, Dongwon <dongwon.kim@intel.com>
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 include/ui/gtk.h |  1 +
 qapi/ui.json     | 12 ++++++++----
 ui/gtk.c         | 12 ++++++++++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d3944046db..b7cfbf218e 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -140,6 +140,7 @@ struct GtkDisplayState {
     GdkCursor *null_cursor;
     Notifier mouse_mode_notifier;
     gboolean free_scale;
+    gboolean keep_aspect_ratio;
 
     bool external_pause_update;
 
diff --git a/qapi/ui.json b/qapi/ui.json
index 3d0c853c9a..4f7d994e26 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1335,13 +1335,17 @@
 # @show-menubar: Display the main window menubar.  Defaults to "on".
 #     (Since 8.0)
 #
+# @keep-aspect-ratio: Keep width/height aspect ratio of guest content when
+#     resizing host window.  Defaults to "on". (Since 10.1)
+#
 # Since: 2.12
 ##
 { 'struct'  : 'DisplayGTK',
-  'data'    : { '*grab-on-hover' : 'bool',
-                '*zoom-to-fit'   : 'bool',
-                '*show-tabs'     : 'bool',
-                '*show-menubar'  : 'bool'  } }
+  'data'    : { '*grab-on-hover'     : 'bool',
+                '*zoom-to-fit'       : 'bool',
+                '*show-tabs'         : 'bool',
+                '*show-menubar'      : 'bool',
+                '*keep-aspect-ratio' : 'bool'  } }
 
 ##
 # @DisplayEGLHeadless:
diff --git a/ui/gtk.c b/ui/gtk.c
index 8c4a94c8f6..9104509ee1 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -828,8 +828,12 @@ void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh)
 
         sx = (double)ww / fbw;
         sy = (double)wh / fbh;
-
-        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
+        if (vc->s->keep_aspect_ratio) {
+            vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
+        } else {
+            vc->gfx.scale_x = sx;
+            vc->gfx.scale_y = sy;
+        }
     }
 }
 /**
@@ -2328,6 +2332,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
         s->free_scale = true;
     }
 
+    s->keep_aspect_ratio = true;
+    if (s->opts->u.gtk.has_keep_aspect_ratio)
+        s->keep_aspect_ratio = s->opts->u.gtk.keep_aspect_ratio;
+
     for (i = 0; i < INPUT_EVENT_SLOTS_MAX; i++) {
         struct touch_slot *slot = &touch_slots[i];
         slot->tracking_id = -1;
-- 
2.49.0


