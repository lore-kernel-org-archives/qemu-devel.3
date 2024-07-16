Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFAAC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTme8-0005Se-11; Tue, 16 Jul 2024 14:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdV-00024C-Ac
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdS-0001Jm-7a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so46458345e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153444; x=1721758244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPwMKRXBS8MyVAS8Asd2KzqkL8mMuPjVu/RXCe/87vw=;
 b=uViokpyN300etDlrmR1YMqz/MNQJa6g9Ny1E4sx9+bvTlExBRIFFVPFml4lv1J/Ww8
 WL9Wl0MnKFg5Vv5qkkPq1wmKP64ZZakPs/STu7+EkD7xLm4QxLIgaYPHBIbJkoG3ekRa
 iVDzuRS/NZWvOW8ABLvL+Nm5orhl5nOclwpbmYMImEB5TwOY7IyzV/MpbDRe2LLTORoS
 WDxPwE2mx+pLkxxIhje6R53EV8nhYHGT64ob7/y6K4Xm54j9kQLdZxtyB48fgk28K62j
 yGwsvQ1Q+XnaLdjJUmf+4dMh0jwbHU5Shibs5O/MdBPioWL6GzwRKpn+GSUmVYa5Qgw3
 6F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153444; x=1721758244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPwMKRXBS8MyVAS8Asd2KzqkL8mMuPjVu/RXCe/87vw=;
 b=dqymLERuwfRqL0UkIK/9cbiMwLZsbguiKla1FhFx7CHvKuT+nifOmuPOcA24fetdA1
 xzlPK57+BXgAqk5YYB4CLaPPrQ5xWrLOtIKC7nB/mJ+mNGVn76Lsx5xMHb3FCpMgrUh+
 dJIP3c5oEECo0KoyTUvFrJOkyhUk36Hhzo8gpzuzCJF+fIyj5KnvrBRoJsyaqINMfF7r
 6eAQ/jzzMvf0rV75FFzidkRUBDRl/n6h33exH6KDY1QDUerrNHAncwsSYysE2ibeCA/U
 HRNofYCPvN3hsL55CWpL3sFlaE69CX/+OE7pcDhnh9hx/j1hK+WBVnYXBg9pDe5EinSv
 oa1g==
X-Gm-Message-State: AOJu0YzVAQgjtjYdTDMKqNGviFVlDIJFwuEKSbdZ/gejl2EqOWZa7xYu
 g3lKZjia+1j62l4HA62o5rIdRnRswyTDf2BSyFqdCRKGR/uha3EdZ6DAQzyiSh+lCGGae0Kbb2p
 QdY934g==
X-Google-Smtp-Source: AGHT+IFMUW5x06wlcO4afTshW+UATphB8dCVN6/HvK8wPm7/IVym/4vfak8A+ybHNPNdN47aq2FaUQ==
X-Received: by 2002:a05:600c:35c7:b0:425:64c5:5780 with SMTP id
 5b1f17b1804b1-427ba64e216mr28107175e9.1.1721153444384; 
 Tue, 16 Jul 2024 11:10:44 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d74d5sm175755225e9.46.2024.07.16.11.10.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/13] ui/console: Remove dpy_cursor_define_supported()
Date: Tue, 16 Jul 2024 20:09:38 +0200
Message-ID: <20240716180941.40211-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240715-cursor-v3-4-afa5b9492dbf@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/console.h    |  1 -
 hw/display/qxl-render.c |  4 ----
 hw/display/vmware_vga.c |  6 ++----
 ui/console.c            | 13 -------------
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 82b573e680..fa986ab97e 100644
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
index 8daae72c8d..335d01edde 100644
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
index 512f224b9f..3db3ff98f7 100644
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
index 8e9cc1628a..e8f0083af7 100644
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
2.41.0


