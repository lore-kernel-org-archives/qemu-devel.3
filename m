Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1832BC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twd30-0006IZ-31; Mon, 24 Mar 2025 04:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd29-0005wR-0H
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd26-0008UG-SV
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224341bbc1dso73076785ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742804381; x=1743409181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX3LCBnlWo3L0OhbMJDGZVsE/frfpvzUUAqMxsgq760=;
 b=P1XwqQzSf9L0B5ZknFamIlmgnMolL78ve07nJ1fCqPLcTNi7WX5B4B9x6Rhpr/KMEZ
 PRXFBIYo+xOdAD1DDF3gF4IMsP+gMWO6IdXKrSMWufcC4hb3IPF+kB7Ka2S93NJSbnh/
 pok7o4VWj9YjxD48uPi5MhzgNSXCC2HM4ejPGbBZQOf2WvIntMIqSXAgTpx1AmRdZVRe
 vq1B0FX73HA68AH58ZtOWDuCQpk8PibWKluw9xWeY2Ce8TuI1E9EMBymiqyYoAs/ayFw
 IYDPh9JkX0U3lfskTWXpwDkZFySxDVtPTEqwweqf/J6ye1/BKrcA0eLfyVOMQNBmeupP
 J2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804381; x=1743409181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CX3LCBnlWo3L0OhbMJDGZVsE/frfpvzUUAqMxsgq760=;
 b=jVpB8zMSxnhivkWOIwj9PqHWU3218kI18gA9Meud454wDIeEMM/wgzDIuOKKzbA/Yc
 BUo6s0kXTdcvD81Mvcu1wMDiNOsswbUX1FkZJjYRbR8odpsLhCGQe08hOvEJSOCfEUaG
 eykI/KCJnuO6xbxJdarkRIQVZuvUhQrN6+6fycXL7hCP6RG9Ig8lLOeyMOGglmN44oYe
 W2yyqRX9a/VChqGDKdh+RrScyQh/SVHNVHKqvWbXmDRoCeVIsBdwrCGVcI+elZJIWXe0
 6XhfI4iynW8GAD57a4cIyTrzo/m+v1qlr1oQDTayopo3TQpElE2IpfeBUCoXvMeUi+GX
 7oug==
X-Gm-Message-State: AOJu0YxhBCBxvV5BU7OlwNYp3nrn4vj3qC6/3cnOxVXHoep0jJXtLzMy
 aAPocdwqN3Ro2acp1cik6aPTFKgZGdyLG6xWZ/pjO/+pC/xozzoHyfE2xNRR
X-Gm-Gg: ASbGncsIDQDHYzoLh/MlsvZtJKEhKDMpoJIvBx3rbEnS7xspe8iqQXcSCH/PvfvsOcc
 +23lZlkYT6Yn9bJhbNm7Y1kf+RaCRikuaKazWk/nmjGg+f5mv2cqZMcrEzfYryMoatXTnoqH6GQ
 rHEnMES6Yh15xWTTy8CtelwwMva46QkUyeb8cUawOeZ9Yi+qsIt+x10bID/+pzADc2YKQoQK4Rc
 UyZgB3T4dy5ZcaHyRcS9lmP0D1gR+zSfPBaZ1ILnrd59f7AAO3r8XmgMu3sYGNJ0TAgZMSUFyYM
 D4lKCfEG/Lp8R7P46RrxssLyQCwjEQxpkiJlRMlzUzLPY0KpskFnioHnKpXxR2wBEMpQsZKdNx0
 7s+tIYOmgIrVqCTBQ6igV
X-Google-Smtp-Source: AGHT+IG/XdccdoLiPWfQ8qMZl0lG00DL8ZVvdp3e+/2bhlueGXUeZ3i7PPgoTZW4oo6aftm+evx9Ug==
X-Received: by 2002:a17:903:98d:b0:223:5e76:637a with SMTP id
 d9443c01a7336-22780d980fcmr198374405ad.23.1742804380580; 
 Mon, 24 Mar 2025 01:19:40 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a5b6sm64717685ad.252.2025.03.24.01.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:19:39 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 2/6] ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
Date: Mon, 24 Mar 2025 16:19:17 +0800
Message-ID: <20250324081922.359369-3-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324081922.359369-1-yuq825@gmail.com>
References: <20250324081922.359369-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x62c.google.com
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
index 72a1405782..45b1b0b700 100644
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
     attrs[i++] = qemu_dmabuf_get_stride(dmabuf)[0];
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


