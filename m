Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCD8C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0k-0007GP-UZ; Fri, 25 Apr 2025 17:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0h-0007Dz-2Y
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:03 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0f-0000Il-3v
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:02 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af548cb1f83so2894514a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618099; x=1746222899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/zQGxGO/NlI4vEg03ZEmNBPOEr3MMOkBBYL06UjaHI=;
 b=dh265df6BaUE06vDK0Mh+ybdHlnMIzVq6o5dPP8Q79hKAfL0CP4NeoyAuurGc3CDE6
 qTJSlNkYIUHr76ljcR4fU92xMCa39SPavN2W3gRAZ6Ya2MSoP49+6NqQ7cKcyu8ctuZ7
 Jn3skuocxHY88LKwjqT9LW0qC47knclyafH7Y68eAEe/2k4DEG9tVqQFPIMrHRJgfIo8
 l9CenTfsSaY5WtJ6r7B6Ncx76bleQ9dgFXE5vxkbkZmsvWbM0cASW0/ijpk16P32Mxtq
 a9X1uctQQq8X1DRXfrpoLZWWfcD2jMzsTwbuMy/tXBlLPWr1bciSTlWFUPX31Fajh7Un
 O9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618099; x=1746222899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/zQGxGO/NlI4vEg03ZEmNBPOEr3MMOkBBYL06UjaHI=;
 b=KMFH6sHwkdGhkm+GmTtPNpt0RYFlk5nFPJ6ab4vStIW81Xk6iI8wJ/LA4vb6GgLhUX
 0V0rRRQ7b2fWMteZ2UzKCo+d0FW+3FID0g0WEffi7Q7tBZ54A5CnWbnJEn+PlK4hpwvH
 4gwPmrRhNEZQWxl5WyYaLpWs4NK+rLVTPinExuB1qZr1qrKu79W3LxMZUhEFM1KgKyha
 qdPnmOSHWI4Y1BeNlHng2QSrRC6fbLKC4cycCKCRpR+0e5KwTmgeG2ZyAQpFJ1kkd1ji
 Hmd//1DL9SkbWioSxApLw05jPdgmXNbmpBD0kMPKA1lnn0bZtOQCo91ddr6UEG1DCaaE
 kBKA==
X-Gm-Message-State: AOJu0YwZoz++DYkiSTQO6ZVz7KBMCxhbR31lheUkYCHY9zW+L69/0lAT
 31bRveZF18hsWh1QHiInQnKGGXZddWFYgBMHKTmwH1lQKsy+gxC0XWvyfeLd9WUSA9DIM3DWxBG
 9
X-Gm-Gg: ASbGncsbWUzcQK6U2QQ2aSBmvX7IkV66+/eyFmw2oHBx7Ob2VyJ2NoGt7IfJr0TFi34
 EoSBKpt7D0FztdlxEdsVV+brKusmEXTfyya4oms+/NAbuVFuy5Rf2DZFxGxnd5pextxnSpY4OWm
 JJ8Sc5leDDvj6T2rFmQMxiKnJCuzzuQgVe9MFSb0Pj7buqhWHPFMA3LOIrVGNxN4EUVqbqeckA0
 5egJG6LF3Imts7Xz1c6lSWWu02otVOdHigxusqOGtnxai/sVS08uotftiAuRo/KL1jM4oYw1h2k
 KqHTRQ+HJO8P3LcV1TJ3/mOg9R/FKVTewaQNuGdz2mboeB4vlQaifOS+4LgjMZCRKPxMm1aaUEw
 52WGj8E0WOA==
X-Google-Smtp-Source: AGHT+IGtTVwn7jVbT/2fKR6/VfUsyS8bICFFKvpwUxkBDFSTm3osJJ9874zJ5Znd/8qtaW0KjPEMDQ==
X-Received: by 2002:a05:6a20:2d27:b0:1f5:60ce:6cc6 with SMTP id
 adf61e73a8af0-2046a58d8c8mr913231637.21.1745618099623; 
 Fri, 25 Apr 2025 14:54:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:54:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 006/159] tcg: Use extract2 for cross-word 64-bit extract on
 32-bit host
Date: Fri, 25 Apr 2025 14:52:20 -0700
Message-ID: <20250425215454.886111-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fec6d678a2..f68c4f9702 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2804,9 +2804,18 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
             return;
         }
-        /* The field is split across two words.  One double-word
-           shift is better than two double-word shifts.  */
-        goto do_shift_and;
+
+        /* The field is split across two words. */
+        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg),
+                             TCGV_HIGH(arg), ofs);
+        if (len <= 32) {
+            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_LOW(ret), 0, len);
+            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+        } else {
+            tcg_gen_extract_i32(TCGV_HIGH(ret), TCGV_HIGH(arg),
+                                ofs, len - 32);
+        }
+        return;
     }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
@@ -2844,7 +2853,6 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
        so that we get ext8u, ext16u, and ext32u.  */
     switch (len) {
     case 1 ... 8: case 16: case 32:
-    do_shift_and:
         tcg_gen_shri_i64(ret, arg, ofs);
         tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
         break;
-- 
2.43.0


