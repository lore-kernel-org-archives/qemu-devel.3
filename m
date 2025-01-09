Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5445E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzg-0004lM-5j; Thu, 09 Jan 2025 12:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzV-0004iT-Na
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:42 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzS-0006zu-Vu
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:41 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso429795966b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442396; x=1737047196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gi+ukBCOErHL45ERN6Ib1p4GgIF2LltQZlgS/5QMd38=;
 b=lTHequDd1XDS4yne+HhQQTdVt23zzJdgxKV7AFRIyWLjtGS+GaKfKQKDgZR6mfdnjW
 Wd6fa48lnhxWkdPbS7+E4LwFUmSOVrLloWpWV/xSa7/1aVGeZs0bx0jiwS81+pjPuEql
 D1ccyoAuqU7hvQp/+MrcV8J7Ruyun1+YPsSRZDS+dzMS/Op85g8hGG1yp2BQzBfER7bY
 cbvSTLtR5xnIAaEnLSUIFsaJvWUTmotY8AskkwkMlcIB5p0cWMYBeBK5ZcLwzG2rE/sU
 lUL7EnXMajnA4jqSkkAeOMtQBy+tsSgl139dltxP8tQJB/LKI8om5D8ehv7bSp6PvBPx
 KBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442396; x=1737047196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi+ukBCOErHL45ERN6Ib1p4GgIF2LltQZlgS/5QMd38=;
 b=Q6uJdRsp98k5WaiARLL1rZvIml5la7DZNIJ8JoRF1Nc+73VEYHy57SxlANgCA2I316
 tfgFsAy2gvf/WOcg1Tp8ma2S0Z8+Zx1IYScvwLAqKHplimIJCOrNMauQrioAUnFTL2X2
 L5vuoICA11fbhY1gfcDZo2uc5aMgZsGnLfJMxN7tmMzzjN8BpgyhSj4YxKr3XzE9MT7G
 3xcfJpMBffV1kNkN3iA2HZtqIMYJc/6W57MLG3vx21GNPUD/FvnKqs4pJCfgOHpedT+K
 DHjHwdBPrd+n+Mn0kTk0nz9kzroZl6FIXCll8fZXg/3Zaj5dcHXepV8jCO0l9J+gZWCh
 NSDw==
X-Gm-Message-State: AOJu0YwKnO03GpPeryJZlzA7Xv69d3WAgDdbNV2JKkAr2GpQpP897ipC
 Liqj2avYpIfixxgH6+kChIqdl6EEVsleodIHAX95cgA8o3QM2+cFk3+Q+krbrg8=
X-Gm-Gg: ASbGncut8oZb4ZmxReAmMnPuP6hm+6HVGjW0p9Ej3DAlfAXpk3hZV4eAt7L1YlAVxH4
 FPvKaoEdmctdsofvgisC+SPeRhpwhwLk2klJb0fJkyF/33aFRJo5IDXICQzGtU7Rhr3oRX4FEY4
 /KqhLzXExsBUJlQlitK4HdvO8HO8MpS4/gCJjP/gH4TmzXzqwtvNkCHN5NNew5fzN5AARo+FuBx
 C4DJMfYXsK0SS7ZPX/a+XO5oWwoGWPfpDGJye5LW9ARzPZjEOTHqks=
X-Google-Smtp-Source: AGHT+IEFTlaKPt2f7slTro0PSAaVnUjk4aQ4Lb9kdg+dM4rJY4H5Fmc+r1pAcgirLQOEC1kU/+5MYQ==
X-Received: by 2002:a17:907:1b05:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-ab2c3c7a0c6mr416537766b.14.1736442396325; 
 Thu, 09 Jan 2025 09:06:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9563b06sm89348266b.100.2025.01.09.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 743DE5FA29;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 07/22] semihosting/meson: Build config.o and console.o once
Date: Thu,  9 Jan 2025 17:06:04 +0000
Message-Id: <20250109170619.2271193-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

config.c and console.c don't use any target specific
headers anymore, move them from specific_ss[] to
system_ss[] so they are built once, but will also be
linked once, removing global symbol clash in a single
QEMU binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/meson.build | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 34933e5a19..86f5004bed 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -4,13 +4,16 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
 ))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'config.c',
-  'console.c',
   'uaccess.c',
 ))
 
 common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
-system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: files('stubs-system.c'))
+system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
+  'config.c',
+  'console.c',
+), if_false: files(
+  'stubs-system.c',
+))
 
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.39.5


