Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A33C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kJ-0003Hm-0N; Thu, 17 Sep 2026 00:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k9-0003DJ-Md
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:07 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k4-0006pU-PC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so323939a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619339; x=1790224139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pXBzmLKK2kYI0+zni+gpeQfaJhIUyxpRdoQvDQizyiE=;
 b=eVBenLYl1qsYDM9cd+pFGyDWYe9QOCk9K1ciqd5CAN+zdLOB7dQ+nGPAHMed8jZuma
 dRv656YxGs0xenPPHQZqtuWFzQm/lrbQqErHjugvkOIper9d/A4ZhbjYcD7eIF6RPiLm
 T7YCayr4HD0DrK/ClKr4Z6VVPJb2e3ta0azt5IBCSdIuMjNNC7VTx88rFl8a9g5zA4WU
 1SEQQyox2YBDTBzSDiwGP35peYD6Qs8JHxXGSTAtoHOry+9MbcyUssA4M3aiuLWr7DTJ
 axlg17Ss6irH3wP5RODwy/yGRmav2MZlokGOmN4Ij2g7HvBuWYz9UAc+2h7ZQyy81n4Q
 XtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619339; x=1790224139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pXBzmLKK2kYI0+zni+gpeQfaJhIUyxpRdoQvDQizyiE=;
 b=xbNRRgrtawfO/Hwz+6hZn8yjAOlb62c0Jr9OQpvPAFyykHVB3KGm+usxd5n6K/KY5w
 WctdW9fl1xQVftLd7rhDfJtDEM5u3jarCccUkK0igb4LxW1mgKLJeKIi6ezVtz4r6HZ7
 r4fpuqSvwXJ59XgcqRfrFcr7bP4OuazYEAzbN/mrWNUEk5dCC/wlipqclUUqH2f/xzo0
 qqVXHH+phMlRmSmbHjFH7AJVuTTTCdXLarTfjZoJR2DbqknLm35rJ6m7RrTf+6UAuVwt
 Vfu3jInCbKvld1vQFBoUtAP1fZhe0Tg9gD2rVWry3lWG6ygvRyszK8tprMK0hpdPwjng
 z1rw==
X-Gm-Message-State: AFuF++lDuZe6yb/CyPi66zv4mgJWrpSA9/L7wLTosFu0NDYIGj+c8TL3
 Fq2ayqq/LUWjAPGhuHQW4K5r3T2p5AKE5Q9vQuXThFrfPcjGWjAosnU/0/T2rT+PROxePKmU7S0
 GiQhgBXY=
X-Gm-Gg: AYBFou1pog6bWDm1xjCr42w+cYYWPfJ0hFCHbN56hO3UMZNO1zrSjCpAHCsL1WvOQOf
 4N7X+Rb4ouJN4XKnc+BDIq7/RdvtqySW42EeZLP4KrlM/pEFuiqIUrrGEXjB6liBBLv/EHPmKeB
 XoLPuaXX97VlfQi8i9Q4LWxixt76DHn+VwVpKz21SQsTXx5tirvI/5yUQvTKh1TZZm7uIHZJyat
 S8xExJr1906ihZTPstkxWAFChAl6z1rx/F+kNxQivXb/baaeqzWTNf+nunRqtbafLjwtw7UyZg5
 ylUwL0Get/7ajdpRtQh76puSb3HExHiXl+LbxMT4sojUXPvcMcKA5XVERoeNU/cuLPhoQMeb0OV
 SjhY+twRWR6bf5G//zZ38TrtpXsAPsQOV9TsPWJPgg5XqQED200OPwcdXH6ZmN9FB3552qRWmi4
 2YCqobjZ8XKlRE/DzCZLAOSoI7HLnsLwbr+rNZcQVRc7MT7oDIGYZdqB6IBezz70b+WftZgWLCC
 Zl/uxC0dJwqJrLMpQ==
X-Received: by 2002:a17:90b:3941:b0:39d:f2a1:3a with SMTP id
 98e67ed59e1d1-39e1e43cfecmr11978549a91.15.1789619339363; 
 Wed, 16 Sep 2026 21:28:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 031/101] tcg: Generic expansion of tcg_gen_muli_*
Date: Wed, 16 Sep 2026 18:27:13 -1000
Message-ID: <20260917042823.542588-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 33 +++++++++++----------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cd651d6e427..25e8d27a54f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -208,7 +207,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b620a314480..8e97c1b37d8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
+DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e1338fcbc50..db47364ce78 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -468,6 +468,17 @@ static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
 }
 
+static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_movi(type, dst, 0);
+    } else if (is_power_of_2(src2)) {
+        gen_shli(type, dst, src1, ctz64(src2));
+    } else {
+        gen_mul(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -637,17 +648,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i32(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
-    } else {
-        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
@@ -1576,17 +1576,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i64(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
-    } else {
-        tcg_gen_mul_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-- 
2.53.0


