Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DCAFF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGznO-0005QP-GZ; Sun, 26 Apr 2026 09:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznL-0005HI-2T
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznJ-0001GJ-CQ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so58238185ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211108; x=1777815908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QysjQPlG+quCcTNk8MlI/u+wQMnFH+nnF7tjS6d1GzM=;
 b=L7lnjkT965UddlrqWDViZH97Bw43vt1Bu2CR9pQTCGbO9H71TdMmwAHfxB2gAxghji
 6D2pLsFSn2Jh5YEdQnCU2gc/YF9o3rcLfFiJAWrguNxNj2yPVb7TfeLYLZPPaBVngtjW
 oxO3nVlTxzW9iPUlRyxf4TQRwacwxTbox8QFuSHUTYTg8zdRsqvgDG2uB/IExZzmfOeU
 6hTUgRzqcHPXB4xpMdTlZhrjz0KnDK/fXY133JPR/8DbAO02z61kHzeXPoAajUBY0NUM
 0OtBigrDa4gVMkkR23rxPEnYe7M4/rV7I0C85kdGVneiMcYnOHlKspBJUDUasUVRekxe
 nPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211108; x=1777815908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QysjQPlG+quCcTNk8MlI/u+wQMnFH+nnF7tjS6d1GzM=;
 b=XYAXnzAA4eGz2N4oAPTomqplVk2mTfv/owb4LyyTtlCioRm2AhP2rK3T5IuItre5uP
 YrWN/rONK8Vosijv+OYABHXmTaqWQJA1q290yRdueFO/TfI9aPd12CtC29Yljl4u5CL9
 v9qGzD1itgGaEnS9E+Hc2soFOkWOfn3wkmR9XAbztVzKLIXe4V4jFcrIPHSaRX9RWmgU
 etNrTVuwJ0pWHKF4LDSWTmRzilJJz9NAM+LI44TRClcoTqLHzyGijVMLP4zsVi5Evx+g
 z623xBHDuquUnS/FTpap3ca7HlgA/jnjrchWVHUkw62NLESgpBJSVdzdRCTQI6PwGzyP
 CJqA==
X-Gm-Message-State: AOJu0YyOAniKRl8btHkLNhs0gwSbw+oluZkZ1FgfG5PD5Wl6rVGym4AU
 TKCD0ukCiXQW504PBdeoU6/enatahbVeMsM2lrSIKxeWq1QP9rELfi2WQNyNrCxrTAbcDJCAKgb
 egXX6Lno=
X-Gm-Gg: AeBDiesrgo4TD5zjkAAZPRQ3psQdyEcM53RQ302/blyKOXRW4VLMHG2s+XZqaC1w9oP
 hUfvpcRcEaItk/3v87iRN1WB8SswoccMiFXLIjfnXYmoIgrs8vMNBkf+qADvYac/r8bzpaLlYQe
 xtkmUrm14X0wstPYojZqLVgqVWavRakdUHJw3I6smgQ/jFHtWFyQkqH4cKyqyM7TSSsSjTI8DHw
 eurCF22sqQmN/hWINkiLvWYs0f75r03+kgZbxuVoVvfltpfs1lvuKn/Xtjjhxq/lq3WOqOn+zGW
 sSoTiIDGApjR/hoDLmJd2BPE+rHSXqAkj05w9N0Hi0jN1v3JT56K0DeyJP6DbBwPV4EdOG6mtmO
 BqLeeoWksvlvOeG20XSVto9D59jwniY3ciN3WIUmSStzx450RXBLiGxs61bsYIfDdUbrbrJz4Aj
 BO0cWxP+T0vnZt+rN9jTG8uen9WrYEZdPz/tTY8YLn
X-Received: by 2002:a17:903:b06:b0:2b2:5491:e32b with SMTP id
 d9443c01a7336-2b5f9f2bd43mr407843025ad.23.1777211107991; 
 Sun, 26 Apr 2026 06:45:07 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 44/84] fpu: Inline floatx80_unpack_raw into only caller
Date: Sun, 26 Apr 2026 23:39:21 +1000
Message-ID: <20260426134002.865628-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b3208c1891..5412fd0360 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,16 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
-{
-    *p = (FloatParts128) {
-        .cls = float_class_unclassified,
-        .sign = extract32(f.high, 15, 1),
-        .exp = extract32(f.high, 0, 15),
-        .frac_hi = f.low
-    };
-}
-
 static void QEMU_FLATTEN float128_unpack_raw(FloatParts128 *p, float128 f)
 {
     const int f_size = float128_params.frac_size - 64;
@@ -1626,7 +1616,12 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
         return false;
     }
 
-    floatx80_unpack_raw(p, f);
+    *p = (FloatParts128) {
+        .cls = float_class_unclassified,
+        .sign = extract32(f.high, 15, 1),
+        .exp = extract32(f.high, 0, 15),
+        .frac_hi = f.low
+    };
 
     if (likely(p->exp != floatx80_params[floatx80_precision_x].exp_max)) {
         parts128_canonicalize(p, s, &floatx80_params[floatx80_precision_x]);
-- 
2.43.0


