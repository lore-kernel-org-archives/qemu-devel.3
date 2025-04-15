Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6DDC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHJ-0003GK-BF; Tue, 15 Apr 2025 15:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m9d-0005e9-0J
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:41:32 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m94-0006oL-Td
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2240b4de12bso81525425ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746031; x=1745350831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g2aEMv6VWYiRAak841rTooQ/oVOB//HHfLEvL0eFv/M=;
 b=f2HyIJ2Mi4/ZoXoEvvK0x2LF7zVKBvCW6oR3IvcMYF7qiIuBp3gtAUkRKjhZ/a47P5
 VzXhXnr2t80Jv42pj8ABKs3Zi8+bX+TiIj+H6v0f1oiNX++izAMnZ6iE1dKENSPLr2pR
 5m5dRH94H+jfDclA7LKu0BORGRkYCTx7XAW4KdHr1LPEb3zAGo1q7ugSLEf7Gu7wqu3E
 Fp+/L2OK1aXoa/pLGgWiGEHYvgDv/3CfT1B1lGewuTFiY5RdyYBDX18wXDpXCA6913P8
 oXRwNZS0vLfTDK0f0Rj8jGguP/nm/cz+G4GXpx11okTw6LcFZ2azsHY6F5rE9xHc9GWY
 wSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746031; x=1745350831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2aEMv6VWYiRAak841rTooQ/oVOB//HHfLEvL0eFv/M=;
 b=vLqLDLrwmzZZ/ngTHngIy0cLoHgz60At1JzRj0DF8gJ4ycynhEGf2tWniXVojeNqN1
 rHJKEWBYU7/paS+ulJaSnf1ttIhJAnAEYC4NXvcmZeApcFgZHkfOcXxV5vo/FPYa306t
 FLVOvhyhxibgL+R0NTAT0tffvPcA55ryXJqyQbTPBoalPwQszwMWpv09cHy3sGa4DFpZ
 +U/Yn+igQX4LMf32ILu0fZO/RCKigor9L73Awb5BCzRokIoSR3UzLQiOW22RQjqK/lYl
 Jp6m45839johoy/qSFX8NQ+TmD7uduxYTQdDJjFQuXC5g1/AULoctzQ50ZqTEI1p9Lky
 MFtQ==
X-Gm-Message-State: AOJu0YwHqG5L2r/9pM66ARGt0JncdkpEw6ihwHg/pbg+T2XqyXDp0X4q
 thav63iwUHwLYa9VIToTjhdmslRqJ5CJ++WL2TZ1vHEmPuTmk8pCz5DeTokNNPn7gNsLws0hw1X
 t
X-Gm-Gg: ASbGncstopj5qxZLfcLO+83gSOlnD4VJv818AnOjl450OAn1WdWV3fR987ta5oj6fvC
 xkkmE1fOLNY3zMmbmsRGmLoh5TiV8yVSBI6DhU1q6MRNjz+03jVtAkHfx+e1wdleZAYiavEckhX
 H60ribI7IhzQwsopxdN+QyI6c1J6DGwXU2Vekq/5frH1Smm6qkQmot/1ZJpLK/aDhkxNJPr7yNN
 Hwn/9f9gDisaEw7kHJZBoa8IGetyPOCbgT3uXm+CP3iKp9yhGpqJ+/jc9Hrm+I695wiZkUijrWE
 5X8T/JYqm22qMWCgYNeaiJ4c5mPxzVumWHSjp5aM89okeJOiv+JH0SJ3Sck8mami139aKgO6j7w
 =
X-Google-Smtp-Source: AGHT+IG7atQUvO/3REGWhD7cxztyHl5ixa4C0rn55emmAKC+e6WR2sF6Jayymxkkavjy6YaFyRCIUg==
X-Received: by 2002:a17:903:1a26:b0:223:37ec:63d5 with SMTP id
 d9443c01a7336-22c319f683amr6756645ad.28.1744745573568; 
 Tue, 15 Apr 2025 12:32:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 116/163] tcg/optimize: With two const operands,
 prefer 0 in arg1
Date: Tue, 15 Apr 2025 12:24:27 -0700
Message-ID: <20250415192515.232910-117-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

For most binary operands, two const operands fold.
However, the add/sub carry opcodes have a third input.
Prefer "reg, zero, const" since many risc hosts have a
zero register that can fit a "reg, reg, const" insn format.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1b3d0b5b5d..442f5b75e6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -725,12 +725,18 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
 
 #define NO_DEST  temp_arg(NULL)
 
+static int pref_commutative(TempOptInfo *ti)
+{
+    /* Slight preference for non-zero constants second. */
+    return !ti_is_const(ti) ? 0 : ti_const_val(ti) ? 3 : 2;
+}
+
 static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
 {
     TCGArg a1 = *p1, a2 = *p2;
     int sum = 0;
-    sum += arg_is_const(a1);
-    sum -= arg_is_const(a2);
+    sum += pref_commutative(arg_info(a1));
+    sum -= pref_commutative(arg_info(a2));
 
     /* Prefer the constant in second argument, and then the form
        op a, a, b, which is better handled on non-RISC hosts. */
@@ -745,10 +751,10 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
 static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 {
     int sum = 0;
-    sum += arg_is_const(p1[0]);
-    sum += arg_is_const(p1[1]);
-    sum -= arg_is_const(p2[0]);
-    sum -= arg_is_const(p2[1]);
+    sum += pref_commutative(arg_info(p1[0]));
+    sum += pref_commutative(arg_info(p1[1]));
+    sum -= pref_commutative(arg_info(p2[0]));
+    sum -= pref_commutative(arg_info(p2[1]));
     if (sum > 0) {
         TCGArg t;
         t = p1[0], p1[0] = p2[0], p2[0] = t;
-- 
2.43.0


