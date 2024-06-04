Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E4CC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQw3-0005OC-Au; Tue, 04 Jun 2024 05:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQw2-0005J4-36
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQw0-0002KI-9q
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42134bb9735so29708695e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495106; x=1718099906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVq5FRQEdCU02hRbXIlYUuqMspOJT3T18nLYpVAudrA=;
 b=hqwKUPueMb8RT7UtzGdF315S9iukKo1NivEwR6tUrL5OgwRJSMi1dKsd7c4zUBn7P5
 ulxzxJfdwdgB5d94TnPu/HlGecNrJ2Xa9DIpbHcHp+9v7yYQgqgV0XtlUMkHtZfsIdJR
 2d9K8oZBb9tInDHXclfA5iV3169oqRSlWdVEZFFjsEZPQSXW/KAVZMFtiW9732Ajt3Nj
 7S+/I2wFq0S7UPkyMLTwSdqgIjPjZBwo3HDVvjQDxZm0vkaEVsk7WcHMhGu3N09qtKS7
 xp7v5XLtJLecHF6tiCXnUrEJF7W31Zgp4Ahc2yWS/MOlvfTpdoiZBv6ybPO68E5mauUG
 0AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495106; x=1718099906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVq5FRQEdCU02hRbXIlYUuqMspOJT3T18nLYpVAudrA=;
 b=fdzkGVDDfUNkaxF8st3KBe9iLQmJiTI4tkWQHmiVZ8JejPnhUmo/zvD8pL9H2Amhsd
 4+gp5ki9+S4ktpx80mM7gllmT1F/9mzyYVdT5PqgnIZY4wEZQv35623DJeTSP/amEHej
 xL3K/lz5jjkgQK8uKmHP7kvzUeuZ3RikM+eSO1+8fnOkpzokeHxD0Yxu+LBFeJ8mD3aK
 b0829X+/0YEUMe7KBz+czbpAQw/aHkReMmcF6pmthy7QB3a70dKoT64I98gK5YTMdbsK
 GLpBqlfyACBx/K1Qx7O7MKCFYJcvIUDObBEiwM7XNQwtSGCMqrnoXy4lxwtUfcschvya
 BRbg==
X-Gm-Message-State: AOJu0Yy0+VBx2oEKrocVYI49C/fZlezI9jG/zV9tpq02IgluiRRzpApe
 bOwo1DFCJz7chc84vYNiTibA168wdtL72orfYqSmDjwF6RD9Kkn3aUGNsaDAz/PwRWlLzZUIGrq
 P
X-Google-Smtp-Source: AGHT+IFzhuuGdPzB1aEOkyQhJbsR5qjtHRj1gAg9egiFde3NkinnbmI7sptJs1w/JF3/+3ssBa6MJw==
X-Received: by 2002:a05:600c:4f46:b0:416:536b:683a with SMTP id
 5b1f17b1804b1-4212e0ae76fmr97568835e9.32.1717495106567; 
 Tue, 04 Jun 2024 02:58:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212f0f9660sm138041625e9.39.2024.06.04.02.58.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>
Subject: [PULL 25/32] hw/xen: Make XenDevOps structures const
Date: Tue,  4 Jun 2024 11:56:01 +0200
Message-ID: <20240604095609.12285-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Keep XenDevOps structures in .rodata.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20240510104908.76908-5-philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 2 +-
 hw/9pfs/xen-9p-backend.c            | 2 +-
 hw/display/xenfb.c                  | 4 ++--
 hw/usb/xen-usb.c                    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 62623ecb30..e55a14057f 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -67,7 +67,7 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
 }
 
 /* backend drivers not included in all machines */
-extern struct XenDevOps xen_framebuffer_ops;  /* xenfb.c */
+extern const struct XenDevOps xen_framebuffer_ops;  /* xenfb.c */
 
 /* configuration (aka xenbus setup) */
 void xen_config_cleanup(void);
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index a3ac53f989..79359d911a 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -513,7 +513,7 @@ static void xen_9pfs_alloc(struct XenLegacyDevice *xendev)
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
 }
 
-static struct XenDevOps xen_9pfs_ops = {
+static const struct XenDevOps xen_9pfs_ops = {
     .size       = sizeof(Xen9pfsDev),
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .alloc      = xen_9pfs_alloc,
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 27536bfce0..b6d370bdf6 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -972,7 +972,7 @@ static void fb_event(struct XenLegacyDevice *xendev)
 
 /* -------------------------------------------------------------------- */
 
-static struct XenDevOps xen_kbdmouse_ops = {
+static const struct XenDevOps xen_kbdmouse_ops = {
     .size       = sizeof(struct XenInput),
     .init       = input_init,
     .initialise = input_initialise,
@@ -981,7 +981,7 @@ static struct XenDevOps xen_kbdmouse_ops = {
     .event      = input_event,
 };
 
-struct XenDevOps xen_framebuffer_ops = {
+const struct XenDevOps xen_framebuffer_ops = {
     .size       = sizeof(struct XenFB),
     .init       = fb_init,
     .initialise = fb_initialise,
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 416623f956..13901625c0 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -1083,7 +1083,7 @@ static void usbback_event(struct XenLegacyDevice *xendev)
     qemu_bh_schedule(usbif->bh);
 }
 
-static struct XenDevOps xen_usb_ops = {
+static const struct XenDevOps xen_usb_ops = {
     .size            = sizeof(struct usbback_info),
     .flags           = DEVOPS_FLAG_NEED_GNTDEV,
     .init            = usbback_init,
-- 
2.41.0


