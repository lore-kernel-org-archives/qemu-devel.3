Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343A8C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P1o-0006W0-99; Thu, 17 Apr 2025 09:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0y-0005iX-KX
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0w-0007yb-Py
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so626045f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895443; x=1745500243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KjVHOR8bZyQPFDZiY73GKKuG9sQW4JTgljoEvbnw6g=;
 b=vaa4SuHcDYBPhWZ3HyLa9xrar1Buj5AijrlhM74tpVl0BDunM27hgD1VShEM0U8qpZ
 Dnz1RVzldi7i0mPMLeJW1EMmRQib3UPW5Vu0TgFT6ra1YJzT/xeX4n8gU8uJMTzsw++f
 Ew/1sc4XWmjMmKOLX4sbXGND2sTAPCdWF+ZwIEE/o05cvw9PnyvdME2ywUCFMMik1604
 l9uEwMLI1HxB3YPFXRUrptt9i4jD1ZATXCNQ5L8Emhh5Kd51K4HNtZwSgnz2aEfW9U6P
 B5xauOlugD+2fY2M4gzh9czCrvkOPT/o5HxTZoHjh7q3TR5CbX2PhANyjuNGf4H3bLix
 Y3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895443; x=1745500243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KjVHOR8bZyQPFDZiY73GKKuG9sQW4JTgljoEvbnw6g=;
 b=HYkGQVp5SabK5roCBh6inkLO80H2VjplIAr4gPo61JRrgitkdLSWpD3wU2iNI6+4W+
 z/vuUzXel06CJuo5WChbKg67DpKoEgKhXKDIdEzPpujE2KbWi7DBBihpxgGb7Pmu6AQo
 26DQuAd+JeZqaOevfYgw0uoQ4bjjsOURYZsQctody5kI1kli081VLRv0O8fBbsV6ToE4
 LyCo0XQhfC3+pLMKM2nmVT5uWkKOQPBErvRm+FIGZS2TtrYHLd4H/286TD2AHDuq++qd
 Oo0fLI9P3nEx7SKlaqL3gfWYvAALep7LwXZ47688egPgWb44a9QfVk4D/P3ZA22fcC+e
 ICkA==
X-Gm-Message-State: AOJu0YxM6NLAVOIsexaOhke+AMhOh7Tz6Ufch5AFVJikGuFZugWYJOyW
 dCHPvMpp3a+v9l0QMuV1J5/N5W6v5vZx94i5imv8cwRTFns3MMDqD+nHWsbqFTsA3Zor+w8NZZ7
 k
X-Gm-Gg: ASbGncsG7vw+Vm6GbglfM9ja105b8tAQhRjuPLFaSCVkxRtEUjStj+j762YSuPRoQpP
 gJEqbCYUkI6rxnISj7uDGHcjMgavbCqjLGfQYJ8pQlet/tPDbeNbWNzfjihhYY2DjtZMUlg/7fU
 T7QJMKvTMnO7nV86mHzWQOTl+D7JN9f+Z3LnaJBYXpqBBJ98RO50JMUfH6ckLcG9G7WBaGHcm92
 x4Pe9Y5TOAyq2GXnoROhT2dJf6FMazwBfL7PtahGhplyleQ2zKJ3D9FIbSViDUv39M9NiTEncka
 xyQYb6Kk+SjusjfVp7oGYUwiySu6WezF1+Ue9Ssqz9fkbohTNDRmRrY85gQsFs5+T20YOXbqToq
 Haps0a6bgSC4bwm4=
X-Google-Smtp-Source: AGHT+IHBUcAssXSi8aWc9mY/yNKPqImO/d1q+tvka80aYydoEczQ6d97xe5f/M0E5k6yuM4N1w/9TQ==
X-Received: by 2002:a5d:588b:0:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-39ee5b36643mr4900202f8f.32.1744895443530; 
 Thu, 17 Apr 2025 06:10:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44043529fdbsm50566085e9.1.2025.04.17.06.10.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] gdbstub/helpers: Evaluate TARGET_BIG_ENDIAN at compile
 time
Date: Thu, 17 Apr 2025 15:10:04 +0200
Message-ID: <20250417131004.47205-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
time via #ifdef'ry, do it in C at compile time

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6f7cc48adcb..c33d5dfca3e 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -56,17 +56,10 @@ static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
                                  uint64_t val_lo)
 {
     uint64_t to_quad;
-#if TARGET_BIG_ENDIAN
-    to_quad = tswap64(val_hi);
+    to_quad = tswap64(TARGET_BIG_ENDIAN ? val_hi : val_lo);
     g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_lo);
+    to_quad = tswap64(TARGET_BIG_ENDIAN ? val_lo : val_hi);
     g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#else
-    to_quad = tswap64(val_lo);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_hi);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#endif
     return 16;
 }
 
-- 
2.47.1


