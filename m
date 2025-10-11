Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BB5CCD18A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 08:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7UmA-00010Q-QU; Sat, 11 Oct 2025 04:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Um6-0000xr-3z
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:16:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Ulw-000743-TV
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:16:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso2009846f8f.0
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760170569; x=1760775369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FBnfhHMUFYNDwVvtl5qN7dApjjvakN4F4owV5DUAVs=;
 b=hlatoyDUMDOwVAKI5FK4AI5nVy3Ova/aI+PzRpFedKMO/x1b7LLssNSB8qyv6Dpv9A
 9AzJtlmRyqNdDMHidZ0cSkY3IyumARkHpHC6H/5ArKvVzBqpYidFkUt5Lbi5x03C45Tg
 2EzDZG0CGR408j1jKuDNarl1kvTOqHT65UYTkbyW/lNjOKZfZFFzp5LxUG/dyP5zCS7P
 YDr6uKvAXZ7z87fj6A0pG/TDLxxOj7ZJ6JWwofllPF94j0+Jcl+VUIm71TkVi0U1YdZq
 6LLuwPSHsWF5zqw9mXqMxNw+UWnJETkE7vIlQNbjIjFTr968WdKKRHDezFo1Lg+ei+Nb
 mkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760170569; x=1760775369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FBnfhHMUFYNDwVvtl5qN7dApjjvakN4F4owV5DUAVs=;
 b=e5AEI4WClHsdwUv4toDrtyav+wtXhTn6WlnyoFuiSQyGStgjxdGJk5z7yQYoJ5lNuX
 WLdnUny3tml7jj2EwNtgdEHXn9dwKWHRBtkfUkzoAYctBaBngLa4fxGngm2aTtBPhmdF
 OXUSPJWAqftR1LWibrpIX5+Bi/QZye+UWmoWwRuzDncLyNb0rSLLx2dlWez823JfhtfQ
 2fOFXu7k1aEsIP/7I1Pf3H3JXU5yrVtvrkeqIBE6nTJWTkK4/YcKgsTZn+ACenish6vA
 lhMgUVsyo5VwC5zCHe+5uZRrKyVZapG7e72H+k8QoNpJQPxY3F+zpUCHjUdiVzk/iDXf
 /OOw==
X-Gm-Message-State: AOJu0YxnkczAJzTHleZ//Z6p3vKQ0KeuZCP/3K+5SnnA/WVWQJNMi6w+
 5bHGZZ7CmvIMIE5C9wlvayAhD6Nc+Vspfs1xJPx5Ip/e9HMG90H8T9ixmXVGyd6z
X-Gm-Gg: ASbGncvdoCxgtpWtYAIbhK5g2I4TixPZhJ/MrEz8WeNIz4+Rrhs1sO29y3vD0mBBi2o
 QS2hHJAO6/3jd1eqOcDUYYhFBxBPVY1Wox2dDt5ObNT4e553ap5KLllYMKePtQStpehA4ImVrng
 vaUu9ayaK6LxeGYvQkx5zSb7myNoBIw25T3RdYIbnLsnk8ro7rtYZt5K+WvbtuhTZPIo5vcbUH5
 WaI/C3DhrGcTdGNPULwVSJBjPyn3yTcToaeajP1ch6G5CAQKITKhT/JxnWaAIYEC+XU1zBlDOlb
 R56nF6alwTiOkATaVRB+55IAio/q9YW5Km+8Fq8NS9xMyHOlPNMvHqy+Ln4u3kOVe/90m715WTY
 bFff1WgMU0+YnqMUW3wUWeL4xTWAEAB08lIa71lQ4oq8DffYaugGnMwqHZyP/Gpcava/IHjJNee
 j69K8fUbvg3giT4kQPKPgE
X-Google-Smtp-Source: AGHT+IELU9OZMbXEHwlJT+37YBD7d7K7WDVpJF6yK5bSFT4OhxbUOpNm+eiGSP2KBdgsjPRcoaVt2w==
X-Received: by 2002:a05:6000:26cc:b0:425:8134:706 with SMTP id
 ffacd0b85a97d-42667177f6emr9710173f8f.16.1760170569231; 
 Sat, 11 Oct 2025 01:16:09 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe69sm8045969f8f.32.2025.10.11.01.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 01:16:08 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH v3 2/3] Use g_autofree in unpack_efi_zboot_image()
Date: Sat, 11 Oct 2025 10:15:52 +0200
Message-ID: <20251011081553.4065883-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
References: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 hw/core/loader.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 42edcf2d98..a511888aa3 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -864,7 +864,7 @@ struct linux_efi_zboot_header {
 ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
 {
     const struct linux_efi_zboot_header *header;
-    uint8_t *data = NULL;
+    g_autofree uint8_t *data = NULL;
     ssize_t ploff, plsize;
     ssize_t bytes;
 
@@ -902,12 +902,11 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
     bytes = gunzip(data, LOAD_IMAGE_MAX_DECOMPRESSED_BYTES, *buffer + ploff, plsize);
     if (bytes < 0) {
         fprintf(stderr, "failed to decompress EFI zboot image\n");
-        g_free(data);
         return -1;
     }
 
     g_free(*buffer);
-    *buffer = g_realloc(data, bytes);
+    *buffer = g_realloc(g_steal_pointer(&data), bytes);
     *size = bytes;
     return bytes;
 }
-- 
2.51.0


