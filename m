Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1DCC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMn8f-0004FV-G6; Thu, 27 Jun 2024 07:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8b-0004Ep-3c
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:18:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8Z-0000TL-9Q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:18:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so66223085ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719487078; x=1720091878;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gud/N2WVB/hJEuBntpHZ3OPjTaafW+GXbIrsPuTc5jQ=;
 b=bavLiXh/V1+0Ct8MkpiQQDPTjL/L7uk2Bl1lSIGvB9UC4oksZDuAVTETTaG2d7sCVJ
 0/1DcTkSGb9/brUiXr5mCxSEGSSklOsgZ0xTTgyw+Scy5cYD9dXw8Ch5Y1I5xeaZ6LEi
 Kp8ieik/T/gicTrDCW4J72MYU46tpRqBBlhSVjOVY3AMXubC/lLpIteVfnu7bvifS1q0
 Q6I7l75imC2x9b+GdIMTpnqe1vGwM98wzd3ZHvY80IxaxHKEiV5I/bBuiOOJ+xVDCyWG
 yINK/KOFVyTwgs1lJryhheED9Fc593rl7K5S88E5+V1nZNeapa5Nl+zxRqLF0cyFfZCm
 kysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719487078; x=1720091878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gud/N2WVB/hJEuBntpHZ3OPjTaafW+GXbIrsPuTc5jQ=;
 b=RclAjh8ZtCJ3ACdQCeRDbMVK1nmw8jwTMSemCrzrWQXF/024OuIXmyNXtEBkIae0Rc
 i6saT5se3xFEJzUbW/wRsfKSVJ/ICME3cxofRSQSkNUyU7fwstJyLGT1uGkv7ReHdk9m
 vgVsGvBD0OfW58wKXIIh5LgY9kPdhObjixGBEpFKKDuqwjxx49pG5tlPJqFNphTGeJwV
 FcAtzfauAnUe0aMjNQ136pZdjOaybmG6WoFyqczKM0Xwk9UIeoKM+WIKdSKCcccfQlFl
 tgxDprox9aLkqBOEZ0jekQOKXPr769itJDhvGzaF/9GaXx/f/UDnrplNP4rqUHssXxKs
 rFqA==
X-Gm-Message-State: AOJu0Yx5QcRFsD3k2bBB5faBJ8qLRprZRqtdu6YwFOuHw1tdB6tP3xcS
 73eNhKMvfPVRKrye+6NWXwTh98cBr5UA2cdKPvn6wU+fAI7ENdL6MDQ4Jff5+Kg=
X-Google-Smtp-Source: AGHT+IGf5XUgSugWXJu45YD6yrMw+Gjb4x190DGqJN7lNYdIrbtmsgylBHkFuSGBpqlywr9XRkz6FA==
X-Received: by 2002:a17:902:650e:b0:1f7:174e:354d with SMTP id
 d9443c01a7336-1fa23ef7ef4mr102771625ad.48.1719487077980; 
 Thu, 27 Jun 2024 04:17:57 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8e0525sm11203855ad.55.2024.06.27.04.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 04:17:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 20:17:36 +0900
Subject: [PATCH v2 4/4] ui/console: Remove dpy_cursor_define_supported()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-cursor-v2-4-c3cd3ee35616@daynix.com>
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Remove dpy_cursor_define_supported() as it brings no benefit today and
it has a few inherent problems.

All graphical displays except egl-headless support cursor composition
without DMA-BUF, and egl-headless is meant to be used in conjunction
with another graphical display, so dpy_cursor_define_supported()
always returns true and meaningless.

Even if we add a new display without cursor composition in the future,
dpy_cursor_define_supported() will be problematic as a cursor display
fix for it because some display devices like virtio-gpu cannot tell the
lack of cursor composition capability to the guest and are unable to
utilize the value the function returns. Therefore, all non-headless
graphical displays must actually implement cursor composition for
correct cursor display.

Another problem with dpy_cursor_define_supported() is that it returns
true even if only some of the display listeners support cursor
composition, which is wrong unless all display listeners that lack
cursor composition is headless.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/ui/console.h    |  1 -
 hw/display/qxl-render.c |  4 ----
 hw/display/vmware_vga.c |  6 ++----
 ui/console.c            | 13 -------------
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 82b573e68082..fa986ab97e3b 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -324,7 +324,6 @@ void dpy_text_update(QemuConsole *con, int x, int y, int w, int h);
 void dpy_text_resize(QemuConsole *con, int w, int h);
 void dpy_mouse_set(QemuConsole *con, int x, int y, bool on);
 void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor);
-bool dpy_cursor_define_supported(QemuConsole *con);
 bool dpy_gfx_check_format(QemuConsole *con,
                           pixman_format_code_t format);
 
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index ec99ec887a6e..837d2446cd52 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -307,10 +307,6 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
         return 1;
     }
 
-    if (!dpy_cursor_define_supported(qxl->vga.con)) {
-        return 0;
-    }
-
     if (qxl->debug > 1 && cmd->type != QXL_CURSOR_MOVE) {
         fprintf(stderr, "%s", __func__);
         qxl_log_cmd_cursor(qxl, cmd, ext->group_id);
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 512f224b9f58..3db3ff98f763 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -904,10 +904,8 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         caps |= SVGA_CAP_RECT_FILL;
 #endif
 #ifdef HW_MOUSE_ACCEL
-        if (dpy_cursor_define_supported(s->vga.con)) {
-            caps |= SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
-                    SVGA_CAP_CURSOR_BYPASS;
-        }
+        caps |= SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
+                SVGA_CAP_CURSOR_BYPASS;
 #endif
         ret = caps;
         break;
diff --git a/ui/console.c b/ui/console.c
index 0ec70cb50ce6..33976446425e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1001,19 +1001,6 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor *cursor)
     }
 }
 
-bool dpy_cursor_define_supported(QemuConsole *con)
-{
-    DisplayState *s = con->ds;
-    DisplayChangeListener *dcl;
-
-    QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (dcl->ops->dpy_cursor_define) {
-            return true;
-        }
-    }
-    return false;
-}
-
 QEMUGLContext dpy_gl_ctx_create(QemuConsole *con,
                                 struct QEMUGLParams *qparams)
 {

-- 
2.45.2


