Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94508C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbNA-0004mU-Ps; Tue, 18 Jun 2024 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbN9-0004ir-Au
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:51 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbN7-00082d-Dq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:50 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so98808041fa.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726867; x=1719331667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgUnXKkoM7jtlbKnZKLo4tSSRCpVvLzL3fhZptpwhrQ=;
 b=qlzVBCzeNWM3z10jbymipWUzLbHCgfifZ/FNHa3JPNYy1YBOeerfO0Dsr/ZzxWJ+s1
 fZrf6xqe0fCQjBSXKFLAF1uK8X8eP+xQht6GKi1VP1j0r0aNmDzWURSZi1wfAoPhMmjk
 Mcg65UXs7Zm0DIIt1RINE3vLc0ey/Pgi8IBNzu8DYl6AQfWlYellXvRDn7HsNbYfElpG
 2hFF6Q5Lb5Mdwj7Zi3VowJIjnAo/7NvGLpEpiohg+SSSFlo3wCWmZbjwPGiA+EhGYYmd
 M2exSL6FeGqQrJ6dxMu4Ybi/6q2rALaD4dIFKw1EckdGCWPUfQIxf81kRw0PN4h+BTSz
 0aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726867; x=1719331667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgUnXKkoM7jtlbKnZKLo4tSSRCpVvLzL3fhZptpwhrQ=;
 b=XR5m8EJChQT3VYGyJjoxI1rBOuEH/v5QOgQj8mxh/454swanQOuAXF/+SfYygbCuQ5
 18yj39Hon7/wMsB4zPfoti+uvUQCc0LQm4or4ReKv3b1IjxeW1P3N69IH1sFez/jp1UL
 eMG4n5zfJOzbUppsqXQHDOU5EXvyeoIyCfqKtXBRBLlx6jPNiM7703LFQTN5ExA3rkJD
 918fKUilMJXRLscWI2+zl/YWWteYC/Pebt6dKbqFpgbAlgBVV6xzmWNIszs5y3LT513n
 iIJrinRKyTtdaO0RH2yVPVqwydmzhFFDeO9LYVfEA4UQ2qrT1HBDPMQpNczNeTciq5ou
 ASUg==
X-Gm-Message-State: AOJu0YyoFuJng5XxFZIqKu5UsZK/p4/yFBZk8TsP54RiZjlsycXLw6BD
 75/JFqxqSU+vdoz1tmo6E32MEvbuewGCQnOIVMR3wRFD3J3LC5JZHx/ba+B0wwg35LptVqX6Htl
 o
X-Google-Smtp-Source: AGHT+IFoeIkxTwCxnVKltMzFdkLcbzr2PUSrlz6Mj1FvmWspmk7UJOEdPm6PsWgufO8vIz6EfT1lGQ==
X-Received: by 2002:a2e:7814:0:b0:2eb:f365:8751 with SMTP id
 38308e7fff4ca-2ec3ced1e1fmr2599821fa.31.1718726867397; 
 Tue, 18 Jun 2024 09:07:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320b11sm193452445e9.29.2024.06.18.09.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 74/76] stdvga: fix screen blanking
Date: Tue, 18 Jun 2024 18:00:36 +0200
Message-ID: <20240618160039.36108-75-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

In case the display surface uses a shared buffer (i.e. uses vga vram
directly instead of a shadow) go unshare the buffer before clearing it.

This avoids vga memory corruption, which in turn fixes unblanking not
working properly with X11.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2067
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240605131444.797896-2-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/vga.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 30facc6c8e..be2b19b839 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1762,6 +1762,13 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
     if (s->last_scr_width <= 0 || s->last_scr_height <= 0)
         return;
 
+    if (is_buffer_shared(surface)) {
+        /* unshare buffer, otherwise the blanking corrupts vga vram */
+        surface = qemu_create_displaysurface(s->last_scr_width,
+                                             s->last_scr_height);
+        dpy_gfx_replace_surface(s->con, surface);
+    }
+
     w = s->last_scr_width * surface_bytes_per_pixel(surface);
     d = surface_data(surface);
     for(i = 0; i < s->last_scr_height; i++) {
-- 
2.41.0


