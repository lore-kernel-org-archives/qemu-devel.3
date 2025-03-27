Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89F8C36008
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 03:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txdSy-0006v3-UC; Wed, 26 Mar 2025 22:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSu-0006tj-03
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:33 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSs-0007eB-B8
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:31 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3014ae35534so657179a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743044368; x=1743649168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXFloiaUByT6PAJnSmPRRnUpAjTWzgnn3bGjuppZjsw=;
 b=C0P5Uejl55zR71PDNdJsMyAMhh5Z9k2YJKunQcLJhPhei/V3e+qB8bRNwIIzoztIlz
 L+fzHW9YeFF6DTZQGgVAvRRPN2lDzZa7qXIB49AsLE1Azwtw/u3UStigQpbplYrRnSIR
 bj/5noBF5RPTeP3AZYJ6/BnMGJDfdb8FNQwhTsBu3CCd6KdnCHgVdcrGAOW40HBW6MSj
 Gt2m6VSMPlZKt8z+0jBXDXgtdLTZ2lCNOPMSdK8hWIXRqqa/8/DUNTfSZILmpcph5UHS
 U5kUMYwOlGOsfLZxfNIzdvBTnAFkBkuN+CoxIxSvJ41uTkoAS0FEPYr+DVTIXgO2uTZL
 YAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743044368; x=1743649168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXFloiaUByT6PAJnSmPRRnUpAjTWzgnn3bGjuppZjsw=;
 b=qxXsz8IiD101m4jNj1g/eN9xps4clW74Mk8X5skxHZvO1HTtv5a/gqIJ95wW431Hdp
 dRAwaijnDI4CnA2KqM5hiSKHMp3PdUgiJMNeFKzeap8gf4eMWcGc1dA/bRiuBYZOB8Dg
 DlcxFEeUiPLJBs71N3QQKtWs8RMtiXFrUDHgyGFkB/CH0HVmfva4PkhK4mDI04sG/6Kw
 Fsk9Cq372pnNQ5jDONlbd/VYCi4T6u33slIq75Ju33KAQr0cgtfgbWAfzE7gfhQUELAE
 DMdl2X8JNx8vT4KblB0m0cWLe8w7hPxFCNpqhzimNu3F70S6+Kx+j1+KhXM0z4NcixSw
 JDJA==
X-Gm-Message-State: AOJu0YyFAwMuvMt7JRO82Rp7QBZxmHFVFv658QbgUIiz1IxvgEGV11xg
 TDZXBlJrmjTsCph50gOXYfVSc5iAziUnjH93TrJGZzI/xW648yIoQqa8Yckd
X-Gm-Gg: ASbGnctjhkc6x/me1PXev43i2n3UTun5sIR1l3JJUXZWuUft7p2wwQpURR5i3UZL6Ws
 9anJyqf+0lIzd30gNl/cHYMWfXhCYzGJ/rHB81fzAdf4PMqQIe+0eYv69MdI1JDNj7xTmXLjH5o
 mDvFd+a9rzDQdXmyzDQlqtksfl1fXUZI3MAomZXzWrjE8xVJPY8j0DzBZ+LA04Wtpi1ZcfwpmW7
 H8h1UL2+yqMrtDMdHP+Cg7GRmFqEHEAoBIXgJxf8cpQIzEoziwZBetLoOpLU9ZEjagRjVHt4Mv7
 N4AtleQJRmSZSi4s8JvYGlsdhy0R598hPmruOZXEGv8pfzcsnZe12Qph+eQw5pXdV/ZY9wK7c4T
 nVynaJpSE56S58Hv4qeT9
X-Google-Smtp-Source: AGHT+IFjLlYN7z56PQtF1BkCe+hic6l4pBbw7P4UKNOTpPia2yFp3vXwlCGKgneFQ157CW6zoA9thA==
X-Received: by 2002:a17:90b:39cc:b0:2ff:5e4e:864 with SMTP id
 98e67ed59e1d1-303a85c8f86mr3200578a91.25.1743044368076; 
 Wed, 26 Mar 2025 19:59:28 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd37e5sm1027698a91.2.2025.03.26.19.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:59:27 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 2/6] ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
Date: Thu, 27 Mar 2025 10:58:44 +0800
Message-ID: <20250327025848.46962-3-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327025848.46962-1-yuq825@gmail.com>
References: <20250327025848.46962-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=yuq825@gmail.com; helo=mail-pj1-x102b.google.com
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


