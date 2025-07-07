Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8F8C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpYT-00054N-Sx; Mon, 07 Jul 2025 13:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWT-0000kS-7K
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWO-00058S-5F
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so26806745e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908847; x=1752513647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFonhSB51r1m9DRDPq3gxW3IKaSRsXZYDkC267ansE0=;
 b=tX5jj3y6GzOlWOO/ey+MQQQDZWQeuOK7XpbtwCtlOQoxxs76dz884cYpP/0bltCmZB
 oqVX5nJhP6SfaqfNCMLZ27pYjgSJ6W85nibSfS2/rAO4bEA//DrykmlcQ6aaXsgW849R
 dkJpuVl22zxEuLSfxPiHNYq71e0von0zZagxgl7V7cl9gUPuqlheENGZ+AWmzV72Er9o
 0hNLElbsFX3kkvVi1UaMg/+0aONG+dT/Nqi6O4W6nP4OE5OCe6Kr+hWU9EJDRp/O1ktO
 so1weJGw8GgWUpi7ViNX2ePS1kskk0kmRIhDzQKxlZ6rTLhnNQ89sw7U+/GY4aEMwcSx
 6PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908847; x=1752513647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFonhSB51r1m9DRDPq3gxW3IKaSRsXZYDkC267ansE0=;
 b=ThGIRJxMnmctgLb25d14LmV85LTHivsDlahyd2h37l12+hqPNBaKuAs7fxGQUQMLUQ
 kYrs8KVXJcvDs3lpGnbbC7qbYa8uL390NTVShBkKvT8+Y2sIg4anBh3h95GjEB2tNKdd
 RSMV7o+d9TpLGh9TZWyRZq9J1/TuraIRi1hvz4v2ZP2Kj45paL9J6DIFgENxUqytdngr
 R5psceagsfFq0WT+q8prir3BE6SRjPaqxZWTiPZzRNA89NZ//ViN2414/btUecQkytFD
 7EyPEJKXTJrFqrVNbbP4kXX/r2mDD2y7uwbLqleWwwE3QVVdEZe69xdKrJQH+ZO2Ho2m
 2VFQ==
X-Gm-Message-State: AOJu0YwUWALYJ2ooNhNzavTj4D9BrZIUe7sK1BgA2xRGt9GZd/r/bI9/
 aWbAw/06Xk+2GNAePSvDbdIBHQWSH+jweFirmha7vPLArnY7sjFHv2hd8YVQ+SwiVmdVgHWzUSh
 XXYkQd7o=
X-Gm-Gg: ASbGncvp8ZsVjPLyTRT/Gc8gdRfkVQIUUcBGlg4VzJe/GI0nsEi0HwdUTNyKcp16dpC
 IjKDA+ZsottACcMrn1n0QjYiGejGqs14Lqt956+Qh2chFVIW2SLsDbBb/eafMamWNQ7oIKz+mw7
 qyMSL1VOdYHQLok4wAfsBI2OzI09rPfjEKKVO/D8hoB2i3gDbj+tNejep46hvTWSeb68Kw+52b0
 /MnfgsYizR7rhJKo1nGNuoBd2G0ETqCBmhjUO9ZTmUx5TaEWTMfw+KcAYnL23i62N34uOcwInM3
 b7GJX1nF36tahsFMfvJvlBTTMSIuM9JeQoF4G0nBUpAyGAT1sfmaAVGATpBMp+934J4qEYvsfwI
 lTze/DNp0nGytpNZnbRVsERtKSp7axQWV80OL
X-Google-Smtp-Source: AGHT+IGhI82KjTmq2GBYUFjCnNZWFDyft3wJhBMSIY8cUy9DDxHlM8oqhAuXnW0mZvX6TO7CAfhsVw==
X-Received: by 2002:a05:600c:818c:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-454ccc799d0mr4855545e9.14.1751908846639; 
 Mon, 07 Jul 2025 10:20:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcf35csm147172605e9.20.2025.07.07.10.20.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:20:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v6 07/14] gdbstub/helpers: Replace TARGET_BIG_ENDIAN
 -> target_big_endian()
Date: Mon,  7 Jul 2025 19:20:01 +0200
Message-ID: <20250707172009.3884-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
References: <20250707172009.3884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6f7cc48adcb..1411b136d5c 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -16,6 +16,7 @@
 #error "gdbstub helpers should only be included by target specific code"
 #endif
 
+#include "qemu/target-info.h"
 #include "exec/tswap.h"
 #include "cpu-param.h"
 
@@ -55,18 +56,14 @@ static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
 static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
                                  uint64_t val_lo)
 {
+    bool be = target_big_endian();
     uint64_t to_quad;
-#if TARGET_BIG_ENDIAN
-    to_quad = tswap64(val_hi);
+
+    to_quad = tswap64(be ? val_hi : val_lo);
     g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_lo);
+    to_quad = tswap64(be ? val_lo : val_hi);
     g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#else
-    to_quad = tswap64(val_lo);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_hi);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#endif
+
     return 16;
 }
 
-- 
2.49.0


