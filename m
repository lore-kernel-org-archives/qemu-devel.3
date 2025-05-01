Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7E3C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbOw-0005LV-HZ; Thu, 01 May 2025 17:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOn-0004T4-FY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:53 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOl-0002BG-Oo
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:53 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b1f7357b5b6so964137a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134690; x=1746739490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUlQyLw9XbRuGHrkcRVzrQwHQ4LewMHgS3C55fSZYyw=;
 b=Hukc2xo3bz7fOKAL5zcQfbUAo+ZgsPqGbicB3OcDlvbdrKWnFQuZuqyOQzZLwwHEl0
 A0e/70XqDpgtYTFYzPJp39F0rD7IY46cKFT2CsjCWsaCIimcta355bIzF0sziI88JZ85
 uxoGc/S6uYWIBAP4aaeYH8Su0wsVO0WEYvquugHrn4VFQ1ANE+IUEInfENBQGwv7Q/mT
 UrH/ZdUyBATw1tg2A/jCZqql48r9LRQYKBkG6+A4P8u+YlP1movEDBg6QHHRpM5U+YCU
 wS2n42+M2wl8rMD+Cku00VVQU+VOkTyUke5Fzp6z5Ug+n7Fw0J8lsYXDTYMUL2WCPAbz
 hTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134690; x=1746739490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUlQyLw9XbRuGHrkcRVzrQwHQ4LewMHgS3C55fSZYyw=;
 b=nKjuzo/fR42VaYNEuYar+YZorz3dnlwO2MDhDQwSqxbEckl1/kHNeLKLny28zB7Hcq
 IPijfYBTEofetYmv4h7ratELW9/NRpmDDUBXELhLBpMGlcXoesriwBSI0dblKwC7Zo+n
 fhhiF10R4jtgiO759nzIUjmEdNV99AYShu+6NHOkSonkdyOSQLx0bcAC0VS3ceMEDV16
 A83IbB1B5kD8tRs/tWSaLIy6NSoCf4K9vCt3KDU1KD0sQeHd1ngwLb8q384toOnd0jLk
 f5wo2l7fG0ZZ9vxAXaICpNLih8qsEYbjGD9HaBpjw66do68ROifvVTQcH/UCVKO1JMNY
 5okA==
X-Gm-Message-State: AOJu0YwGtlaFTqUlit18hXvlWZp+f7hTKwbDjImX6ZqSgCtMiq0aymCz
 K3XS+OHg0P9YiNMlMKrTY12Z2in6rgXOO2GDGGm8RK72Ouq+1bY/ADLyfU1j+SHjbGYmHV+kOTB
 t
X-Gm-Gg: ASbGnctn7FefPTb+fdGu09V8ziuNXHyf3fNeEMhZsold2kjWKWMjSq6QVP4HZDTgBf/
 cYPXk1we425cx1/eYJXrtUdE9+ahmQeZVrRN2dFex/aKHEJpsiuTpUI7HBgvxP0OU8Sl1qtTl1o
 6TsSPPVBGcnHMmxc1POuFAb/nd4SSOubqCqnP4GFOxJnk0VgcKdWhg1FkgsmQ/kTPEqvk0qfseb
 9A4wwcGAYKAEgkAYow+iwrAm+LwyJdRr5AePit701YiXGpO4RXdlnjngpZ8R5szz84a5l9PczZ1
 4WXLT4OogfuxOjLy+uY4tdV6hHkQtlJ3MI1b4dolg62VE0vc2DYdL/ljoT0ZgCdEnO3bRkKfrkA
 =
X-Google-Smtp-Source: AGHT+IHh7+dhyRwkIPqbFNKnlSaIhtF1QH7Ja56IJRv1KIlZXySkfce9e4t2yLA2W7IkBMHjWbhRQQ==
X-Received: by 2002:a05:6a21:6b86:b0:1f5:7ea8:a791 with SMTP id
 adf61e73a8af0-20cde857068mr556349637.10.1746134690102; 
 Thu, 01 May 2025 14:24:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/59] accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
Date: Thu,  1 May 2025 14:20:58 -0700
Message-ID: <20250501212113.2961531-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

When we changed decode_sleb128 from target_long to
int64_t, we failed to adjust the shift limit.

Cc: qemu-stable@nongnu.org
Fixes: c9ad8d27caa ("tcg: Widen gen_insn_data to uint64_t")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fa4998b341..acf32e6c08 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -109,7 +109,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
         val |= (int64_t)(byte & 0x7f) << shift;
         shift += 7;
     } while (byte & 0x80);
-    if (shift < TARGET_LONG_BITS && (byte & 0x40)) {
+    if (shift < 64 && (byte & 0x40)) {
         val |= -(int64_t)1 << shift;
     }
 
-- 
2.43.0


