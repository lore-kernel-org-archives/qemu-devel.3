Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FC7C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luS-0008Px-TU; Tue, 15 Apr 2025 15:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luN-0008MD-0i
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luK-0007v5-I2
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso63496995ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745118; x=1745349918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/zQGxGO/NlI4vEg03ZEmNBPOEr3MMOkBBYL06UjaHI=;
 b=BUVEO/W1OLm2odocvh/xlaRHrA+35jgD8VgUFLOuwoZGaHpqCe1VYGBNlhucw+AQaU
 nxnJ2LYbWGadcXdNw1tVL8u5YqGqsyInd8lVG5PaQ1QQu2gMfBC1KBUAqGxjq3EQxx9e
 7Cow0QUi0M7ziU6ezG1fVv8ZoplfHZ5TAdGoJOyTywcHr0FJQIuHfvma85t3MgvrkfZf
 1Wal8JwjVjgip//O7o26FXO5ys/I0TVzUaOYc2u4z0wtikCMEHMyzxTqKKzPFGoEAmwA
 wzSbvEedac7j9VTS6q9Cvt/euS0RHXVsZpdNiXrpBeIJw5lgAHmIYWpZ38iWzA90Kdz7
 Ib1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745118; x=1745349918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/zQGxGO/NlI4vEg03ZEmNBPOEr3MMOkBBYL06UjaHI=;
 b=Exv2hhQRe6eN7t124Te0aUko/nnFE96RJGu2Y+H92HYCi8d5fMe9JeyMumR9SSt7gn
 gwFoDjE7sDeXO3YNrYyBQpsW5T+D2YxaKtQdTOa24WjOnVDfE4D+mjkfyyb4lx24Myxk
 soRH+2Su7wLCOQe3Lb0zKj5zr9vD3fblzqNbX7BUUmbsdngTA8BGvfwKCl1hwn2lEGbh
 czBflSBtsZDJ15IxgaXBFdPVjVaYPJhz30WL0FUFfxNDZr5FhQGLYqKvpr+LLomvFDpt
 DuuQEg9BHWg4ebDgSZVlzXzv5zsZAV3SwRj+/s+BKsN6RT7jFZa34NQ7AXYbq7XVhfm+
 gz1w==
X-Gm-Message-State: AOJu0YwR2OR9YDNLIZa4BhSE+ACkYOHIvd5V0g0BzXol2gb4tE0Ul43c
 UFlK1AMl72weLAY6P0tWxIzYN3eQmi5tGnl3EgI7Rc4E3hJmToYecZ/vd2EWqyI7joAy2dHUVOd
 /
X-Gm-Gg: ASbGncv2He5PBh4Q4xTXBfiFEJjT69ntjIsSrKrwNXomXvW+XBtEEYprGuzmEhWrJqi
 EvxFRiK/CQ5bl/CFyVvxKi2WYFodD1pY5hlgszC+hfsxVtGXzNOu8aX1PBqMi3fjv9520h3/dxm
 gWLjWvFGCAIMgvbdREza66SRwI1Wxzo5RWrvGe7hICLgB2k+ITl72F2NptQjajeJ7trAuBpQ3ia
 9zQGfF02ytak0KZYY6e8OE+U34sKb5bCsHkjwt8lrWDmXYezuW9NClMJR2N2pCT+Zhec8c984g8
 AQOX/0D68sRrh4iiZUT4s/ykKVnWO3w8k6UpDVpAZf2ZUy1yQag+BDYo5hzd63f+cC9/fzVKwrp
 vJZavfPeFuA==
X-Google-Smtp-Source: AGHT+IEa15BXuh2roAcsQ5C0ecuEJlaFTegZ8gc1lXSeLEjZ+639aJGk9jmsNAHQ+Z/s204ypG/rUg==
X-Received: by 2002:a17:902:ea12:b0:220:faa2:c917 with SMTP id
 d9443c01a7336-22c31a7ab9dmr4634005ad.34.1744745118000; 
 Tue, 15 Apr 2025 12:25:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 002/163] tcg: Use extract2 for cross-word 64-bit extract on
 32-bit host
Date: Tue, 15 Apr 2025 12:22:33 -0700
Message-ID: <20250415192515.232910-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


