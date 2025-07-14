Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C96C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLJc-0002mJ-03; Mon, 14 Jul 2025 11:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1ubK0a-0008Hn-Ew
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:18:21 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1ubK0X-0000PK-1c
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:18:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso5023683a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752502694; x=1753107494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BnEv1rhPyuqGeOqhJG81aiCKY6SFUNUyQxrFxmuLHBA=;
 b=Zzh0iTJmPsHWoZCPV95c1h5Fkq6N2KZdgNSPxge6muAG/qm5IaCJb8NwwULbluPasI
 OIpUPuJ00TOGFqyCRNx5DbrMkvwuHBXL5vlnbsNlzlN+GVjtIkao7LZ3PyiO7TqOdXxn
 SYN+3KWuEgduLJhGqgzC4JXH6Ul82Z1p9RSnMzR3kFo3mcoHvPusyuckC02WXkEHzwPK
 ceOW5CHVAExSTajZq6ZRk6lAO1Y5PIVv5+U8w4tEzNl8vv74sm7h0jY4YrQ19cDvboLJ
 fi0v+VrnFEabECwqwHm56k0UPIWzZawo8/sCpTjRKCMYWTLuCnjGlSg6Dj3ZKZuhGxa0
 dGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752502694; x=1753107494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BnEv1rhPyuqGeOqhJG81aiCKY6SFUNUyQxrFxmuLHBA=;
 b=erAletC3WmBf7705FZabSq8kN8NH0Ph4qJS1JOTStJYMeKqDmOhogK5IF+sqIJTU4o
 I2mwE/1E1yHM7BzDXA59v4JWzThB4CxfURI4vV9lHLkcTqty4CX7sOksq2X8C6KLS0Cm
 +B75jmAvC/dOm7NcB+GFBz8T47vQJtdBIoACE2Jx2fhE3v9RKV2mRHsVKJW27bbmj6fR
 Na7CJBoX1ztjhPRiYR9tc0bRRksXnOBExbNnVRf+KUnI4q5lHDOJnXa4bTI0BOXVoMRR
 a6KapAle15WzlVj05hX86zZytiUjT5ATBuXFCfypr0sD7m0OMxiXC6bs5eF15lFZFjPy
 /jbg==
X-Gm-Message-State: AOJu0YyTLcbY+sWq+oqs+RRJqk1g552mMUd2wBvq2Lk3pHFzTn0caf0i
 790ZeSZA8pYTrikBrSKQ1uGngaJcpD0e725fBXDcUhwUKzD0eYPriFi/waa8s+WGS5w=
X-Gm-Gg: ASbGnctPWCmLiCHKp5aQ6fcjSpKc17amMPoX5ddXL79wVFYAV7d6P0KzWN+qFYf3MFR
 1P5QFfKZEJgklgjEFCGJ+OzR9DS3qwMyv2BIO7/Kz0kM3v5rFMG3/xMqtDwwT8osVdafH3LCyIy
 8iIaaARzLYNeSBk+3RPQyOEd46Ar8GX1qgAfmbh0DXBt/r7eoILBkYNk+s4IanO8QxSeEIlLLho
 RVuAhN8M3XT9Fgn87nD/iwS/uwzNqThQk7JEX/3dYQkoNzgJOIT1MrPBncAdlUyecym+d/Tmmfh
 m3Z6h8vKjkL/48hAXkuXUHG9+2SNiEqbPm3hHv/mdtjQYBxy8yGR5qDkpW8NsL3m1ZFa94ARVjM
 k5BqcNeD3zKWFB8eE0NM2xmAJz/s=
X-Google-Smtp-Source: AGHT+IE/Si003LAV3ECTYELp+xDAVyo3ipn/4u8D1TlcNQiKgtZYwgCeWgKREFnmKQY9apmmVyDKNA==
X-Received: by 2002:a17:90b:4c0a:b0:313:17e3:7ae0 with SMTP id
 98e67ed59e1d1-31c4cd5618dmr17698480a91.34.1752502693722; 
 Mon, 14 Jul 2025 07:18:13 -0700 (PDT)
Received: from localhost ([103.192.224.247]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c3e973e75sm10663890a91.16.2025.07.14.07.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 07:18:12 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH] gtk: Skip drawing if console surface is NULL
Date: Mon, 14 Jul 2025 22:17:54 +0800
Message-ID: <20250714141758.10062-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pg1-x529.google.com
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

In gtk draw/render callbacks, add an early NULL check for the console
surface and skip drawing if it's NULL. Otherwise, attempting to fetch
its width and height crash. This change fixes Coverity CID 1610328.

In practice, this case wouldn't happen at all because we always install
a placeholder surface to the console when there is nothing to display.

Resolves: Coverity CID 1610328
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 ui/gtk-egl.c     | 5 +----
 ui/gtk-gl-area.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0b787bea25..ae9239999c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -72,7 +72,7 @@ void gd_egl_draw(VirtualConsole *vc)
 #endif
     int ww, wh, pw, ph, gs;
 
-    if (!vc->gfx.gls) {
+    if (!vc->gfx.gls || !vc->gfx.ds) {
         return;
     }
 
@@ -112,9 +112,6 @@ void gd_egl_draw(VirtualConsole *vc)
         }
 #endif
     } else {
-        if (!vc->gfx.ds) {
-            return;
-        }
         eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                        vc->gfx.esurface, vc->gfx.ectx);
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 8151cc413c..05fc38096e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -48,7 +48,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
     int fbw, fbh;
     int wx_offset, wy_offset;
 
-    if (!vc->gfx.gls) {
+    if (!vc->gfx.gls || !vc->gfx.ds) {
         return;
     }
 
@@ -135,9 +135,6 @@ void gd_gl_area_draw(VirtualConsole *vc)
         }
 #endif
     } else {
-        if (!vc->gfx.ds) {
-            return;
-        }
         gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
 
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, pw, ph);
-- 
2.49.0


