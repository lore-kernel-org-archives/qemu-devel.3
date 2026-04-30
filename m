Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB27FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuP-00064H-MR; Wed, 29 Apr 2026 20:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuM-00063M-MD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:34 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuL-0001ha-9X
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:34 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso178951b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507532; x=1778112332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PrlanBakDW1aJjxZgN4Ch42cudiBjZCS7+sWrmaubM=;
 b=jbD+EkhE5OdorXL6tesqRADtOGN64GgnZHMi7vtdGTYCe9inW5Mz5oGqcKlsUFHTzT
 1UuED5yKvnYSPFTX+ouGIB2x9jQGGEVGdFwKeuygbfA8R8qPQo4H31Sd4lNUAn9KcndS
 IVLWO9V7FzmTHEQH6P+O5uZesqN7hWwNLMbNIUJln9M79o1oyToZrGA4eQcYZhJm0HVr
 OCO0kFKvDZ0t34+pxE7ctDnS37xBUN9l2oz34Nm9HFE7WFmj6n0FTxlkfuqm8VBxm8tw
 9W1xGst/Ycm8VQua0Ino6biGiUCjLU8A6Jx3zDOiVeAbJj+Zs9n3Yb0zwQRFPDsp1Enq
 G+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507532; x=1778112332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8PrlanBakDW1aJjxZgN4Ch42cudiBjZCS7+sWrmaubM=;
 b=sDlFiUfZgjtRwtlaODicij2uHMP0/E3iwpgl4bVKUVoIi2wVPn9ElgNjU2NKi+nHMc
 cIr06TuYxFf75LoYYvPINakIG58FMc21BWRtQTMdSga5ZDa8xIWP6H8g85qlb+8ifapt
 45W3SBzY6JSPkO7PfdksP4BKScYZTQHzT9DUBBIY5RMopWSIeeEzDLotKJ9U9G+27tJ4
 sywaiTVKjowiIqMMxsjYjDud7WSNEpB2b3CSATaKZ0DdKhOda1lVKZgAOz7iYEfSLX7R
 YwxyZryH4WJJ7yDcOPfCLAZOBryi7KCpHs/IOlfT4J+X+OSERF3+Ru5u9RZYN3KMtB3S
 b3iA==
X-Gm-Message-State: AOJu0YzOSKATJmrhYIk1UOZ4ya7amx88X93tyNvFKG92qp3NR2riYsNs
 TgZMsA29MTn2PE+V8lDzxed/qF4qapOQWOBC3hOFAu/FxVglEFbeeULplv8d+zVIiYrRBqbSeSS
 p6Lvoltg=
X-Gm-Gg: AeBDies0XldwiCQY84VEGNgQAYhh8sVIijPrYLuLGzwzaZ1R5EIW2i1POyeXmE0hIpa
 TuxdhXF5BRLeLtnipyNBhD7GnOLnodNH9MrmXhmaZbDq+w25USFVJR6+DK1FlSxE6QiMPRbrksZ
 y6AGbaQpKTPsv2UAtaSAXL265MjWIlTksn7qddoFeO3AjgCm3xkZIQ9ef6sBjNI1ycepE71N57T
 cKeKWxod2Q/CC1szK3iOMXIQYwRfN5uk0ZHltYBYRMih3DnQj0omh/EZxLttP/5vsoF1TNSCtw9
 Z+I8khMYWI1f74vHsQereGpp4ryLjFZJ/KcCrHUOgtQgJK6bSTxxWAIQXmYREKoLvxraiRGIM7R
 n2UNrAcgNWPRkqGPxIx4RZAiWTaXnpcJr7twzkNmidpdacfj9iFP56r3AglwjBFJZf7b+VBYe7z
 WkikahhVk/N4M629Cr0yyeTCD48Jj4gH1xCYVzL7cJ
X-Received: by 2002:a05:6a00:1741:b0:82c:e1a0:3453 with SMTP id
 d2e1a72fcca58-834fdbe1749mr763374b3a.26.1777507531654; 
 Wed, 29 Apr 2026 17:05:31 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 01/40] fpu: Inline float8_e4m3_pack_raw to single caller
Date: Thu, 30 Apr 2026 10:04:44 +1000
Message-ID: <20260430000524.56046-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 fpu/softfloat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5d58caf5ea..18f2ca900f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float8_e4m3 QEMU_FLATTEN float8_e4m3_pack_raw(const FloatParts64 *p)
-{
-    return pack_raw64(p, &float8_e4m3_params);
-}
-
 static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
 {
     return pack_raw64(p, &float8_e5m2_params);
@@ -1474,7 +1469,7 @@ static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
                                                     bool saturate)
 {
     parts64_uncanon(p, s, &float8_e4m3_params, saturate);
-    return float8_e4m3_pack_raw(p);
+    return pack_raw64(p, &float8_e4m3_params);
 }
 
 static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
-- 
2.43.0


