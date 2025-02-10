Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4ACC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacr-0007ce-KZ; Mon, 10 Feb 2025 15:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thack-0007Ly-2n
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:22 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaci-0003go-6k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:21 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so33298175e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220198; x=1739824998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pv8qJPmK42u5ft2lbwmLghiT3/wjKEkezy3y/HRjV2I=;
 b=VqTSyRoHEpB3/sAVSdw+BRhNg7PDeFOEe9vBEwYF4CjPQoQFdbhtzRCjB9w22d+HA8
 7UgGfenjO9JiAPS3vHvGKragS7yQfN+SVmnFZlN1fAl7nxd8EUkALhV42rm8Fi3GgXeq
 ELTRfKtWAHxN9miV7eeVYTyBqobGoB5cpHZ4VIOkAAOjFOjN45/8uJjPhBl3sQ6sjKNm
 7sA5ZQVjfDKwPUt7zsJQ9tTRgkJKJK/PyhWidI1b386XOjQrR9peFtl7zHwh4s64skU6
 1uY1KaPVHkwkkAnq2Q0+p7aVJTo281zv3vntscbS+PR7UBfDVWw6qxD0oCu58N5s/Y6t
 hVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220198; x=1739824998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pv8qJPmK42u5ft2lbwmLghiT3/wjKEkezy3y/HRjV2I=;
 b=mSrCukXgn0qq9d5thbZ1ObUYjkGmHYvANCJ9nFyQKVy5ML75HB3RlR2OCpSJIeldoI
 4GVC7pCorV/ba5BOK/YolN/FtyIc7WGBtZCmBkC62/C5ix0+C/FpYSjAmWfTuF67a9iV
 2oZ+3bvSeXPBYk2IDRXu6rqbvKccm6mO/oqgE7/xFNByh/1gsidpHNcbFf+TgVzxtn9C
 HvIYHtjh1Fj0h/BqnvAw8U8O6Pb+HmtVSjQKZLIAuG+ojou/tKX1i7iZ+UbbYsqxA7qY
 sxOk4ullVk+AN+2K+++9J/MgerOfnIqcrRku1AdOtdgKXVfAlU5T1EY2OtqLqcOxokK9
 ZySw==
X-Gm-Message-State: AOJu0YzGPBYcPpKTyTj5/xAbDoUPp8myKvF26Q5J8uW8VEsQI+4HJBTF
 R2RaWxTKL3WZgJcs5iUnAZcbJH1UZ/0cSmC6Fsod0jPVF/r/v/lMdrzkq1ifBThNqKoQdm87INX
 oFQ4=
X-Gm-Gg: ASbGncvJBrb1nDFhZhEIObxvO1TnclS8KONYtsKqU6d2/5GBdGwiCxA8tgEpi8+mWm3
 FPzFFEEBj9tJWM8rFeHp4nbYn5xIVbat7UStMbbX8Z5fzcaxKGDwt/L7RWzg4C+HnLa+u2Fh5jL
 CVCu6M53qfIzM2/cFeC/tAZqIA/Gt7BH0vA8Tw2iJ06s7U/kkK4zO6l3j5z2r0KFrkqUz0EF+NZ
 nGCvGpY3nmLdL6ld/Jsiv7z8lO9kyaJMvwYrK60rmEB0GtlG8Ljiguul3XGp+wuHKp8Pos+W+A8
 wkyJj2HhEr6euF8D+a700DQHlFoKeCqbJfUyvgG9GdiVI/YzRVJ+luH2WIgAwpEY9w==
X-Google-Smtp-Source: AGHT+IGrcKR6B3Exm0LtHPP187T7dWDBBKgPGrN9Vtom2CcgrwqLWb2fKGCP810XEysxncmzKv30+Q==
X-Received: by 2002:a05:600c:510a:b0:434:f5c0:32b1 with SMTP id
 5b1f17b1804b1-4392498f0c2mr130787835e9.15.1739220198176; 
 Mon, 10 Feb 2025 12:43:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439471bf782sm30693655e9.39.2025.02.10.12.43.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Subject: [PULL 14/32] hw/display: Have RAMFB device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Mon, 10 Feb 2025 21:41:46 +0100
Message-ID: <20250210204204.54407-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Because the RAM FB device can be optionally plugged on the
TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250125181343.59151-6-philmd@linaro.org>
---
 hw/display/ramfb-standalone.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 6c35028965d..1be106b57f2 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -72,13 +72,12 @@ static void ramfb_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &ramfb_dev_vmstate;
     dc->realize = ramfb_realizefn;
     dc->desc = "ram framebuffer standalone device";
-    dc->user_creatable = true;
     device_class_set_props(dc, ramfb_properties);
 }
 
 static const TypeInfo ramfb_info = {
     .name          = TYPE_RAMFB_DEVICE,
-    .parent        = TYPE_SYS_BUS_DEVICE,
+    .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(RAMFBStandaloneState),
     .class_init    = ramfb_class_initfn,
 };
-- 
2.47.1


