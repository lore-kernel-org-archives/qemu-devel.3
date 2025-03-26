Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82AAC3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txN9o-0000xR-My; Wed, 26 Mar 2025 05:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9n-0000wz-E4
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9l-0003Wi-Hp
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-225477548e1so127779085ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742981679; x=1743586479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJXmFtW3xpZS/E0hzVsrasLFEbBGzKrORRb7gCBCf34=;
 b=Ginp3pmlljz5g1WM+uFLMfXjOIRTBbJJ2FfdHVJDUbaSKsuDhqetFhO3eZhn83CO8C
 q8UB1lq6l5xnpTYOV584/lWAIfX+UYDApdf3YWWoYUDFdKf8+tWB6CrYe5zqVfCaxvB0
 FQgA8gWVX9dw9+JnyqYubYBi9bMp8Fy1w4icDBgu2nG9pOki4oRck/+n+AatMwgToCh2
 YRNiwhhajUAnxvYc17cYpJkfeT5HpuGZMnVxuamO3R2bwX46mB6QNCip4dbJzsv+1PD4
 yRfvsmr98srGTTbI0sjzPdM3wkjZXmYGUQPVvnrI43AeUq9Qcgkfou0QO2gqHuKwTFRA
 RS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742981679; x=1743586479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJXmFtW3xpZS/E0hzVsrasLFEbBGzKrORRb7gCBCf34=;
 b=tw2uoXRPsHEKhZw1YlTyF6CxwcRvvBd3EXD/2kcFp9z43vdwb8DJoYS9b3QiHIcLpu
 z57S5djAPROSu0kvXEjMalrYpNFWcH987d+NILM4AEzb1BQUI+RUtjwppDb1m0CoMM+A
 nGD0YsFVp6dYnohLywqOB2BpYNhW8u+uCZmvA9U62fr5J7y91CB5cdkjix+kOkOKGfwP
 AMy/tKREntKYFJLFeA67sjq0YUhFYU2HLqcs2NxNJn/qd5UWv6GtVwchIIBldJMyQmtR
 71oypxuCeNuEB2NTOQf+IfR3dHTdQAZBjJWoiExB9frCO9oxIvQ86SR3RC1ZM1eIEXEq
 PUUw==
X-Gm-Message-State: AOJu0Yztet+fNZsl63gJT5Qz88ts7E1Mk6Pu49EfzMJ2QIz5CVpty5OB
 QLSYu9XeUBEcfeTlpFwaxiMta9Jc7E81764uOQLJyACg0p6EE1y7XhaUb175
X-Gm-Gg: ASbGncvBQj9SkiTMq8Zu6gwAWbbwJB/V4reD3wzt6UAlywhaEOKQCKNdA/ltMw9HeAO
 npMDG+8pCAq6lCtrVv3U8/K5HPfjHpil1p1L15UMppQBGH6Bo3VDGZ4NDJHpS0+vfzpCLzW+6DX
 HiJuIxka1t1qVKG7qwTJmH+RRrEcVtM76gYhwXq1bGlm48djDV/N5ahSfeyergDZSfqWAanv959
 qtMITHyP6ygkIeg7zdFn8Z2sbf7yt/l8/VfrVMah9xvAflB4Rv3O/LfNUtojjOW9txM/p+hjyna
 pdlL6Y/Fsow+8f3A7zRpIi3JBUwf1LIXfDzrR9tT1w2HjQCjL3rH3sfMbEJupPg61w+w1AGDEfR
 HmEKIdMnhBk5SzGMAFyVW
X-Google-Smtp-Source: AGHT+IE+UHmVvMjAbSulO5GFvXf0xugw8ZDMzZ8QEoZqtFet67V0YYIjv0lXviev2Sg1S+6SiFD2Tw==
X-Received: by 2002:a05:6a00:ac8:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-73905a63bd5mr35314224b3a.20.1742981679403; 
 Wed, 26 Mar 2025 02:34:39 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd57f7sm11729684b3a.44.2025.03.26.02.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 02:34:39 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v2 2/6] ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
Date: Wed, 26 Mar 2025 17:34:14 +0800
Message-ID: <20250326093418.397269-3-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326093418.397269-1-yuq825@gmail.com>
References: <20250326093418.397269-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Qiang Yu <yuq825@gmail.com>

It's used already, just check it explicitly.

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 ui/egl-helpers.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index d194d004b7..432863d702 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -257,6 +257,11 @@ int egl_rendernode_init(const char *rendernode, DisplayGLMode mode)
         error_report("egl: EGL_MESA_image_dma_buf_export not supported");
         goto err;
     }
+    if (!epoxy_has_egl_extension(qemu_egl_display,
+                                 "EGL_EXT_image_dma_buf_import_modifiers")) {
+        error_report("egl: EGL_EXT_image_dma_buf_import_modifiers not supported");
+        goto err;
+    }
 
     qemu_egl_rn_ctx = qemu_egl_init_ctx();
     if (!qemu_egl_rn_ctx) {
@@ -308,7 +313,7 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     EGLImageKHR image = EGL_NO_IMAGE_KHR;
     EGLint attrs[64];
     int i = 0;
-    uint64_t modifier;
+    uint64_t modifier = qemu_dmabuf_get_modifier(dmabuf);
     uint32_t texture = qemu_dmabuf_get_texture(dmabuf);
 
     if (texture != 0) {
@@ -328,15 +333,12 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     attrs[i++] = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
     attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
     attrs[i++] = 0;
-#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
-    modifier = qemu_dmabuf_get_modifier(dmabuf);
     if (modifier) {
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
         attrs[i++] = (modifier >>  0) & 0xffffffff;
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
         attrs[i++] = (modifier >> 32) & 0xffffffff;
     }
-#endif
     attrs[i++] = EGL_NONE;
 
     image = eglCreateImageKHR(qemu_egl_display,
-- 
2.43.0


