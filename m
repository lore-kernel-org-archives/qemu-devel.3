Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B53CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVp2-0008Rr-Cp; Mon, 24 Nov 2025 07:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnT-0004Zc-0U
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:36:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnO-0007JE-RD
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:35:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so32843495e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763987737; x=1764592537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzsfYVjLziv8GqLGvmBW2tkLI+AhZ5hpP3y9tNvFPo4=;
 b=kTONt8HB+EN7zGR0PjO40HNOGq26ANr8NbL+NDutINLlIYihczugWqyvtvznLwuX8M
 tCxMdV6TRvRi/1xnkVloMVBUrx3Uu2/ruRtnjM8whjV/piQakP2rAEsShXwePp9rNt9n
 Z8y8FTFV3aUZNUPrWxV0OKpA0Nbgtwv/UIBwdjbHQgkwGLCbxiCvI8kA9UgEfwQ5piBO
 623NMhJIvLRor/iSKCJQpJSqP/c2itKyLUKPFOPYfXziNdVbwoG/kq4FhG4C9ea3eXga
 R9Lj1XVTw6uCDQ7YEDz0Mc9J60llD0g1A/Y8EHreIsd2ASY/8/iqEGWW1DUPz0PaI+C9
 aMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763987737; x=1764592537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GzsfYVjLziv8GqLGvmBW2tkLI+AhZ5hpP3y9tNvFPo4=;
 b=LVm0e5Z3Hc1RDFOvfXb69fGeHqW2TDsmE4ofnhwl0ydx6sEdBOWRsp6RbAurjy7lo4
 z/4V53SrQldfBG178WPvk+GnXJQKvLnDzBKgDp54jvC+1Gvnm290ndsdl1A4OBo/hhy0
 2bV7LoIHCr5l/+CyqzUau317QPBy+/qbGWRPVH4UTgXYHnDHQ9bGsExG7lGDX+V/Fosc
 5AlvIyAX23MeUnHzCZ25XxwRFDTkE0yVw61UuPuWXoyTey+hZ+6e/f+YqrFIeSctV3Sq
 cPZt8B/PB1etFi1M2Yhgnrq5UO7RrlySQIM6IS6CsKexyq0OPuzsEPpTt//nB8/1NTiG
 xCLQ==
X-Gm-Message-State: AOJu0YyW5bwIflGFMBlRiGy84soMmSVLcXrxf9fDeQ67fHmr4JzQ+rjy
 BcOexk0tcPEleK7QfiagvACPW5RH27MJpRPtel1M6hL+8CH61868FSsz1eiNK1rI
X-Gm-Gg: ASbGnctwDg8/0yoNik7zkw+mwhr/FbTCouXu5f16OuiTYwIh/p6mq3V9o+Jw0LbXJ8M
 TZuFNgKVCHi9gJSjDIZdPlFPn+PFxwO0/n2wmUm7XxLU1UjchJwedkjI4C1TOyr/nNr7YiF/m5o
 ncQCa3vc2SUwjhvjuoGJCZOP/n4qXoRBVWa0HeDDIIf2MEzXKsRfJvb3eLUIs/sUtZb7NHcqqeb
 slYerrtKqvdSZNND1OOhlwDHHR5Ac4Dr1QCAics66D1IRYudt1dZb7oww/1271+apRxVPluxcj6
 3al08SC+fiFuQXm+O4syHexXxLUA1Npaf62lI/nJiCUjquqb0S+4B5PymkIXjVX44ul1jmTcbJI
 c7EVzsKRtSiixCerefFg+EF0sZE1hoAkfiZQhrVaUDpfbFCRW61nDczh+8TQVKyKSKYL+OyaYIS
 V1vUAxE54MpnyDzo0drU+auK6OgXpx1RQZhNDvcWvyjCNG4giXGVgHPB2LR7K0Y3GC6Q==
X-Google-Smtp-Source: AGHT+IECsFcAHYR33jFD9mzwfbw4MtaGzS8C7Q4+M0di8doEZj3IJ6rfXGJXfOBVchuLt1wvcHjJHw==
X-Received: by 2002:a05:600c:1c02:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-477c01eed7cmr117596175e9.29.1763987737333; 
 Mon, 24 Nov 2025 04:35:37 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8c47sm29398449f8f.38.2025.11.24.04.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 04:35:36 -0800 (PST)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Paul Burton <paulburton@kernel.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH v4 2/4] Rename UBOOT_MAX_GUNZIP_BYTES to
 UBOOT_MAX_DECOMPRESSED_BYTES
Date: Mon, 24 Nov 2025 13:35:19 +0100
Message-ID: <20251124123521.1058183-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
References: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For consistency with LOAD_IMAGE_MAX_DECOMPRESSED_BYTES.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 hw/core/loader-fit.c | 2 +-
 hw/core/loader.c     | 2 +-
 include/hw/loader.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 2dea485ae0..5895e89f22 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -70,7 +70,7 @@ static void *fit_load_image_alloc(const void *itb, const char *name,
     }
 
     if (!strcmp(comp, "gzip")) {
-        uncomp_len = UBOOT_MAX_GUNZIP_BYTES;
+        uncomp_len = UBOOT_MAX_DECOMPRESSED_BYTES;
         uncomp_data = g_malloc(uncomp_len);
 
         uncomp_len = gunzip(uncomp_data, uncomp_len, (void *) data, sz);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index f940b6a227..090af59df2 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -739,7 +739,7 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
         ssize_t bytes;
 
         compressed_data = data;
-        max_bytes = UBOOT_MAX_GUNZIP_BYTES;
+        max_bytes = UBOOT_MAX_DECOMPRESSED_BYTES;
         data = g_malloc(max_bytes);
 
         bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 3371de506f..cbcb274fce 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -343,7 +343,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex);
 
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
-#define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
+#define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
 
 typedef struct RomGap {
     hwaddr base;
-- 
2.51.1


