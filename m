Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F72C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1D9-0003yY-0J; Sun, 11 May 2025 03:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1D6-0003xd-Gn
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1D4-0003fy-Oi
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:56 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7376e311086so4901075b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948893; x=1747553693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxPTXyprH05ofk3pDVq1pDkXDfg1+LVWQQzpYzVenik=;
 b=BmqhtfBLgQKEryb2NAg5xdvSsSkDmKot0kY7VVJh153nUqkb0V1VjfauVV4JpBrlHG
 qb1M42Y41uECnGYAA9/YxAalR8LD8sZUFOc68YfgWOl6lQajJ+Kl9vwWyrDTjQLU7/eu
 96LtW0WyrlS9zkt18BiXpcOIv90eoqGb3OS/krDD8JXQMi1AiVngaVC6rtKEwS6Y23TG
 L+QxZHJlzZi/lrovHaUWrVchf0DqDHvkQ3yfMvQz63EtejW3K2z34aGDVr1HBsvjZoBJ
 +Cj3hrquzqd0EULTU14PQMxSEYrCsoBANGPiULK2UURPpdySmJJ/YYXCfD6uG/D37Z07
 bIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948893; x=1747553693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxPTXyprH05ofk3pDVq1pDkXDfg1+LVWQQzpYzVenik=;
 b=OTr930X1lqd0MpbjI/EXxbkCL5tcT9JzqBfYGUJBS6ZT37WYigwswlFMv9bHBefi5X
 BdT+PRo+78vk0Yi+VtqjHvhv2AGq8M90iz7p2JxrZnsnLTGvtR4G4mHMjLjmBiCQ0VCe
 q/d0uIdaDT9GRXhEx7X5Y2sBvzFJ8slJh+rsuWR4Gzkc/eC6AZ4jAnQUNiMteYFcBX8C
 H989a3ypNnB6jmzY9VKXnCs1mKtrXfra8G9aaIKu7FuTgbzzwOyE8/TB1JzBW8dRC0qe
 pV+v0qgitu3zcu7ajTYxkRlRSeWCaSAuSgelymIASpvygqfWVf+qhunugfLAvjD/wwaY
 opog==
X-Gm-Message-State: AOJu0Yw09ZF+2KuqC5EXC+/2ll6eERSCIfHkex9ogyH3nuEGytlJWWRS
 cxyOAjJlMsA5JkM1UoQQzJCK8wvzWJe0lDw8YIwIP9RZZsZlwCPygSnAAD3C
X-Gm-Gg: ASbGncu6NKQZUOTb2FJu22sOiW65GFByKDpNZkB8PZ4GWEAHx8dj/GDcS3Hct8g9vDZ
 fz/dnaSWnK1qY6B+Ysjv2cTb51Xa4xSMHCFETGZsMGfaS5oECVrpT+dWTLgaa4vZJecrYDyNzcG
 Xj6XbXXeypbBI9RdUT/GL5thRyph2OCMS1Pu2svBbL+GgMIC4Bbd41KXfolAp/k6rCjwt2osNkp
 ClWda6Whf0AOjVJcMc+SHN9GI6BGY1ZLj4urmGcfpoX3jkfqBgrBYlu0IMpY3Ru7ys4hRw9qbsd
 g8J4udgZ/y74dzFzBuAwhd4RgEzcRlIFaLoEkHtCacw77Xjh8NEqyo4gFriRmjwtuw==
X-Google-Smtp-Source: AGHT+IEvZVbcNEFh5WRMsKlP6EsYIiRmw/y7kVqcRh0TZ3orQ4ciHvkWYlfwqXHH8VoA6EH2xx1LMA==
X-Received: by 2002:a05:6a00:2313:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-7423c0421e7mr13911846b3a.24.1746948892731; 
 Sun, 11 May 2025 00:34:52 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a10867sm4112348b3a.110.2025.05.11.00.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:52 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH 7/9] ui/gtk: Consider scaling when propagating ui info
Date: Sun, 11 May 2025 15:33:17 +0800
Message-ID: <20250511073337.876650-8-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42c.google.com
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

The ui width and height sent to guest is supposed to be in buffer
coordinate. Hence conversion is required.

If scaling (global window scale and zooming scale) is not respected in
non-free-scale mode, window size could keep changing because of the
existence of the iteration of the following steps:

1. In resize event or configure event, a size larger (or smaller) than
   the currently used one might be calculated due to not considering
   scaling.
2. On reception of the display size change event in guest, the guest
   might decide to do a mode setting and use the larger (or smaller)
   mode.
3. When the new guest scan-out command arrives, QEMU would request the
   window size to change to fit the new buffer size. This will trigger a
   resize event or a configure event, making us go back to step 1.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 ui/gtk.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 47af49e387..8c4a94c8f6 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -772,8 +772,21 @@ static void gd_resize_event(GtkGLArea *area,
                             gint width, gint height, gpointer *opaque)
 {
     VirtualConsole *vc = (void *)opaque;
+    double pw = width, ph = height;
+    double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
+    GdkWindow *window = gtk_widget_get_window(GTK_WIDGET(area));
+    const int gs = gdk_window_get_scale_factor(window);
 
-    gd_set_ui_size(vc, width, height);
+    if (!vc->s->free_scale && !vc->s->full_screen) {
+        pw /= sx;
+        ph /= sy;
+    }
+
+    /**
+     * width and height here are in pixel coordinate, so we must divide it
+     * by global window scale (gs)
+     */
+    gd_set_ui_size(vc, pw / gs, ph / gs);
 }
 
 #endif
@@ -1836,8 +1849,16 @@ static gboolean gd_configure(GtkWidget *widget,
                              GdkEventConfigure *cfg, gpointer opaque)
 {
     VirtualConsole *vc = opaque;
+    const double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
+    double width = cfg->width, height = cfg->height;
+
+    if (!vc->s->free_scale && !vc->s->full_screen) {
+        width /= sx;
+        height /= sy;
+    }
+
+    gd_set_ui_size(vc, width, height);
 
-    gd_set_ui_size(vc, cfg->width, cfg->height);
     return FALSE;
 }
 
-- 
2.49.0


