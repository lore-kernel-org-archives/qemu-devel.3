Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B9C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7tL-0006PF-9i; Mon, 18 Mar 2024 03:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7tJ-0006MJ-BE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:42 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7tH-00011Q-Rh
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:41 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so2678193a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748718; x=1711353518;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7omncbBFnXPn26MWJ5RizssmxUalSXb3km7TZBwCRKQ=;
 b=oW6O0ZFfl+A/Irs/DUmVdUDTVvy+8am3UdSFmzeg3ooLYd5AtecxM4LJTo7wsvfjA2
 OMKI/KwZPl1Nr1N9F6+yHddQM/I1nGdgmWpdoMT9Kxex6lWv5UGXW7unuunRqDv86ZwW
 H/KlY5EKTdnuSiwAsyaQkjNRKWtp34Vy0hm/aErXV/12O8FXOh2chee2UdkBZa5RsHmt
 aWpIf7wLGX7DM9PshVSw51YEGmcSszim8/5+sdFZliv6sutwl5q4Jjx92+UB+OeKL6ya
 oM98xXV4/sZJsxmVHfQ6bIwvh1z78l0/QPWIDpe+Mj36HFeJ14GwtGrqakKH/btBqlcC
 ub7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748718; x=1711353518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7omncbBFnXPn26MWJ5RizssmxUalSXb3km7TZBwCRKQ=;
 b=tVlydU6M19zDUCnVSMQNQeb8rBiy9K67hHPA43DIHsQiGMdWddlSyIAvx04A9NZXzt
 QU2FhJdI7HvBrd8drjoqUCJ5d/oDjYBxVNkYW85q32Y4ABYSe9aC8XmIWy+vKURXqUpx
 ZuU9eMVvhm+NWjJOizCzrzJHbfENbgSGoYFVmhAvrT4ZwAk/zptEuGTntqg/EIPFfCp6
 kNBHWODG/Vp1ff9/nfaCkHF+w8lup3eXcfvVwdrF+ShYYqZQr9KdZryjH6xt0rYbMlhh
 kfIQrxmQtbytj6riICcHKcpldy/WqpV4HDPKFrvRQLnL5g/R9QM3T6rB8PSo6PJ66Ets
 nwlw==
X-Gm-Message-State: AOJu0YzveOYsdbCc+WPT5/O9I+q25Ayu9ZyxeSeMTmcN4aGUI2qyuRkD
 S/YkJt50DyPOaOs6LnJZeswIhoCDehWSPE9P6hqhWMywWmZD0SSi4ACgqvvMVDm0xmFphRxaNZW
 r
X-Google-Smtp-Source: AGHT+IGtaByUPjXfLY/OJifM6QpaOKksDLe9+gMj0dUnUYLg7vFQ25IUG8DeNoZxmm5W2qvROn7GKg==
X-Received: by 2002:a17:903:1c9:b0:1de:f32d:f5ba with SMTP id
 e9-20020a17090301c900b001def32df5bamr9995657plh.42.1710748718468; 
 Mon, 18 Mar 2024 00:58:38 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 mp14-20020a170902fd0e00b001dc3c3be4adsm8548688plb.297.2024.03.18.00.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:58:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:58:14 +0900
Subject: [PATCH 2/2] ui/console: Remove dpy_cursor_define_supported()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-cursor-v1-2-0bbe6c382217@daynix.com>
References: <20240318-cursor-v1-0-0bbe6c382217@daynix.com>
In-Reply-To: <20240318-cursor-v1-0-0bbe6c382217@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index a4a49ffc640c..7566282be986 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -342,7 +342,6 @@ void dpy_text_update(QemuConsole *con, int x, int y, int w, int h);
 void dpy_text_resize(QemuConsole *con, int w, int h);
 void dpy_mouse_set(QemuConsole *con, int x, int y, int on);
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
index 1c0f9d9a991d..fadfefc4c67c 100644
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
index 832055675c50..6b6f57441c53 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1058,19 +1058,6 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor *cursor)
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
2.44.0


