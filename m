Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44D5E77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ57-00077U-Ii; Sun, 08 Dec 2024 17:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ56-000772-44
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:52 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ54-0006CN-Lt
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:51 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71ddcdc445dso648030a34.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698129; x=1734302929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9b2+DSqhBa/dazX8A7Z/P3d2MSjAQkUApSkOVB3SGA=;
 b=XEJhXX7Agf1n1w+PifTvnhp/DEeEZAqijqiBcbiOxHlWvfi0sgvzSdfErhBShZqVmE
 bS1yw9N92SymblRCGdfdK9gvvXfsmwUxe8Tq/ne9JNZqUhjGNjO3teB4a3CxQv4deAr+
 1lCCY35ttw4TJxSaZgSpokA+aglUZfCHZiTAoXvR3jnFoHZqOWgoj7eJ9A9MPtBfEpZl
 +6w7MongBRykeNgAE/cbo70TrFD7cruni/aQeXYnSsJ9g1fnTiRb47U5z0bwNFdBXHVa
 OZPRZtHznZRPQHFbLLzhJ5RHMaU9cIzOBxQhYu4toYZIlEpZh4OY5l6UYOsOoC68BiHw
 4A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698129; x=1734302929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9b2+DSqhBa/dazX8A7Z/P3d2MSjAQkUApSkOVB3SGA=;
 b=ip+PBMUOAkuHBEQjatFcIPwJJy6pe3R9L5JoY3w6/US2xd6CnzhnnUzHG2OJHEommz
 eo1yLgei0NSKSkTr+0vjL3utnIPiTFrcJRV0ytlkxl7QZGaPcaJXE3KOLCa7fY2nhEjz
 QX4YlndBJHby99gneza+ppNDIZTacaO9yxQOowA/yUMc0/OIXE5PoEB9+qQHMCb/TUQO
 gnbrcPT/lkcjpXnHjOT5crdiSW1AFEjDBCRa1GRBnunqhteex3JEBWAQa9rGzljAyQJj
 Z+z7lUqr4mRtpwXR213yD5mtq8WxJ+eG7iZMYYx8gst5e1Tfde9ON1tnh8vbIIevH79R
 W8eA==
X-Gm-Message-State: AOJu0YxBQb24Ku/8IwNs1pJIG0DzsOCfcfPAb3Emen/krsclYUfkVjxn
 4UR5O4xMr9TS8SzAuJzw69h4B1RgUESwC7h+gh/gk3MNWbAzIUWYCNDD93rkwleA2QWdoJ/9wBW
 E2sWBAA==
X-Gm-Gg: ASbGncuxJXvvP9JC/8JFcjCU6sWFeff0ycoiANLUma4qdzFMfwF21cFl7ySn3Utc4/d
 pf0xV71OPqf5xZNp+PmPVJWc5rsqjudi5zlyPd6ygs9jJTGIEORjebIOixs9HG7WGXS4u81Rv96
 QIgmprpSSUn1BZPNuAeD7//8VbhL3egbM2kYWaa1apudA6w3SP/oPYGQ1O7bRm+Ov40QoH0RXt0
 Dd8Nc68ZAlSVQrOO6K87re0GUe7/Ci2w90288eewd2Wq27BZ4J9MPAdMdwODNu5vmI3iK0PAJkP
 amqLLuCCb0fqfc317Y9LUGSgNCYEvwdwdzjm
X-Google-Smtp-Source: AGHT+IGc38L+LM76Qt5L0OXSPjwseM49Tb4cXMbWHv3+Ab8cgPId2Xks7PhBAxRhFRN8294ssomp7g==
X-Received: by 2002:a05:6830:d8b:b0:71d:dc6b:8792 with SMTP id
 46e09a7af769-71ddc6b88a5mr3762436a34.2.1733698129019; 
 Sun, 08 Dec 2024 14:48:49 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 02/17] target/arm: Use float*_muladd_scalbn
Date: Sun,  8 Dec 2024 16:48:29 -0600
Message-ID: <20241208224844.570491-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Use the scalbn interface instead of float_muladd_halve_result.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 8f42a28d07..265a065f6f 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -273,7 +273,7 @@ uint32_t HELPER(rsqrtsf_f16)(uint32_t a, uint32_t b, void *fpstp)
         (float16_is_infinity(b) && float16_is_zero(a))) {
         return float16_one_point_five;
     }
-    return float16_muladd(a, b, float16_three, float_muladd_halve_result, fpst);
+    return float16_muladd_scalbn(a, b, float16_three, -1, 0, fpst);
 }
 
 float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, void *fpstp)
@@ -288,7 +288,7 @@ float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, void *fpstp)
         (float32_is_infinity(b) && float32_is_zero(a))) {
         return float32_one_point_five;
     }
-    return float32_muladd(a, b, float32_three, float_muladd_halve_result, fpst);
+    return float32_muladd_scalbn(a, b, float32_three, -1, 0, fpst);
 }
 
 float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, void *fpstp)
@@ -303,7 +303,7 @@ float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, void *fpstp)
         (float64_is_infinity(b) && float64_is_zero(a))) {
         return float64_one_point_five;
     }
-    return float64_muladd(a, b, float64_three, float_muladd_halve_result, fpst);
+    return float64_muladd_scalbn(a, b, float64_three, -1, 0, fpst);
 }
 
 /* Pairwise long add: add pairs of adjacent elements into
-- 
2.43.0


