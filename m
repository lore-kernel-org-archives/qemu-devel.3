Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74BDC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P0r-0005hV-UO; Thu, 17 Apr 2025 09:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0b-0005Ve-FL
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0Y-0007vJ-TD
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso5970675e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895420; x=1745500220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guXhwwIF4sCNRuBen3+R6Ruwzx2W7ttUqiq/qsuOdWE=;
 b=Y9w0hIK6dEnfiUVnIUJRbYzUf+xrqNolML5w8fwhBQRmLCrK9yaFvBPsjZVYLqRWji
 8SDnsShxdOyupBET/Cn4VXL9FuGr2uV3B/NL0CVbgmG3DeDs5dKZ+WVaVISgN7+ZD0+d
 tGHE6sJdAxse6d9PXMStKQoFW6ajXx0HlldF5Kd702UklDR0m5rGwV6++njCYZInR/8/
 ouniAPSij972cvqzTCHLRQ8/8MyyiYwC2u2lA75ji6eKVDfDlnoEdg9W9S49UfRXZosc
 aeQ2LAeZw6viufT2W15I25/p185ifxRpr3D6a4aW86RNy1ifxBiWV4B8LWRiMz01Sh62
 mXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895420; x=1745500220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guXhwwIF4sCNRuBen3+R6Ruwzx2W7ttUqiq/qsuOdWE=;
 b=s9HT/Af+zwz5DS5hwNGt64BAolg6krlmYzLOAyvyWdWDOKRcs1bc/MJYoTj+D8RlQx
 vpyKHdtzzbHAdEi9rXnDrwtIxa437A3JOh8cMJnkNRFXXW1jQRC5utNDej/WQoi1J4AB
 4L3Q4H+N670czpS5ywxZnP6LbkxlC8dxQepeNC5Yh27iidrVN0nsslwOln5XSTLN8Uu7
 itVd/9DXCV/lUTgZijaoWGb4TWPFXoZAzLbN3t8cM3ZupwlnnqysBNtSD3qOkSr0gV6P
 l0klsUGDzHPFzKh0enbBvlIyURNOJO9kJx0o0pOHlI2sFGIOEwWQCthM+A0GwA/1ttcT
 29eA==
X-Gm-Message-State: AOJu0YwejLsY1zIZlS0WXc7zsb+7eP3iMcirNjhsD7J2vll9mfXiWAF8
 55uzxxDoZyZPEycRW2iMQuEFLTcTmSP8LqCpKN1GKQ+A83/6hTXW4GCfXD4ygZw7fFevAZRFp3H
 L
X-Gm-Gg: ASbGnctyEhEnIig/y9dqI3wchauFPBlFiOVapwE0M4Fkqk/Wg8n0B3ccPfM3DZG6mTI
 ECdegJJwQPRfe9MGCxWYFxtHSkBWCX3vsevfOG3jv7enEkyMjhCNttlBWTZuSnjJM1RxnHbSrKC
 yT4MrjvYLzhDPdRa8aaauGDvg18ZpIBGH1BSnN2Q5GUlyEL+wIZPDYFpkeT5t9cd3s1AX/U9Bbz
 pfMNSzLZCU1pCQlzaVwkubTUf45+OzTnu95ONG13uKaUNy6UPkXFCwAJFhPg7FUKh7TqxIaX/HJ
 5FGlQWljq+ZrjhulJ3U4fgdFuk5xr3GcKZQaqM69yFG5TQTOtr4VtfcVgdbpA7drxXiWBjAIzKX
 Wmg2jCZW8NfflwhM=
X-Google-Smtp-Source: AGHT+IECld7MWA0uW1gF79OR5VGep+LqKRWn7Ky0/ged6z43ljtt3WSy7D+knfcsqpOn13y2rZjuuQ==
X-Received: by 2002:a05:6000:22c1:b0:391:47d8:de3a with SMTP id
 ffacd0b85a97d-39ee5bb103dmr5246169f8f.53.1744895419956; 
 Thu, 17 Apr 2025 06:10:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445270sm19831668f8f.81.2025.04.17.06.10.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] target/mips: Check CPU endianness at runtime using
 env_is_bigendian()
Date: Thu, 17 Apr 2025 15:09:59 +0200
Message-ID: <20250417131004.47205-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Since CPU endianness can be toggled at runtime before resetting,
checking the endianness at build time preprocessing the
TARGET_BIG_ENDIAN definition isn't correct. We have to call
mips_env_is_bigendian() to get the CPU endianness at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 14de4a71ff6..e349344647c 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8212,7 +8212,6 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-#if TARGET_BIG_ENDIAN
 static inline uint64_t bswap16x4(uint64_t x)
 {
     uint64_t m = 0x00ff00ff00ff00ffull;
@@ -8223,7 +8222,6 @@ static inline uint64_t bswap32x2(uint64_t x)
 {
     return ror64(bswap64(x), 32);
 }
-#endif
 
 void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
@@ -8252,10 +8250,10 @@ void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
      */
     d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
     d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-#if TARGET_BIG_ENDIAN
-    d0 = bswap16x4(d0);
-    d1 = bswap16x4(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap16x4(d0);
+        d1 = bswap16x4(d1);
+    }
     pwd->d[0] = d0;
     pwd->d[1] = d1;
 }
@@ -8273,10 +8271,10 @@ void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
      */
     d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
     d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-#if TARGET_BIG_ENDIAN
-    d0 = bswap32x2(d0);
-    d1 = bswap32x2(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap32x2(d0);
+        d1 = bswap32x2(d1);
+    }
     pwd->d[0] = d0;
     pwd->d[1] = d1;
 }
@@ -8339,10 +8337,10 @@ void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
     /* Store 8 bytes at a time.  See helper_msa_ld_h. */
     d0 = pwd->d[0];
     d1 = pwd->d[1];
-#if TARGET_BIG_ENDIAN
-    d0 = bswap16x4(d0);
-    d1 = bswap16x4(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap16x4(d0);
+        d1 = bswap16x4(d1);
+    }
     cpu_stq_le_data_ra(env, addr + 0, d0, ra);
     cpu_stq_le_data_ra(env, addr + 8, d1, ra);
 }
@@ -8360,10 +8358,10 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
     /* Store 8 bytes at a time.  See helper_msa_ld_w. */
     d0 = pwd->d[0];
     d1 = pwd->d[1];
-#if TARGET_BIG_ENDIAN
-    d0 = bswap32x2(d0);
-    d1 = bswap32x2(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap32x2(d0);
+        d1 = bswap32x2(d1);
+    }
     cpu_stq_le_data_ra(env, addr + 0, d0, ra);
     cpu_stq_le_data_ra(env, addr + 8, d1, ra);
 }
-- 
2.47.1


