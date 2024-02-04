Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4048FC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFU-0002jG-By; Sun, 04 Feb 2024 16:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFK-0002XE-Q8
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFJ-0003Yr-4d
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d94323d547so29786105ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082907; x=1707687707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYMLLwA9gva4L4uzAlLYH7HUcuo07hrL8DJH/YZuBt8=;
 b=GSebdVSurZNb6NcQ68d5k/THNdh+/FUoAiMdoPp+85YcC8QM60JNah0jtvpsjNb9XQ
 X3XZBPEg7EaFwvWpuqdr2EYcw3Wdxmi4Zi4gEIhZhC34WuXy95EgvesdW9M1gJOYPWUI
 VmnCkB78YHHT46TjYyHIh8cfTHHaMamhow6jya/ZJ4DbXnAS84vpx3EWk6XnnJ4CryIP
 4z2qqPVCDveChe9Vpef0rUntfE+BKp+cT0MKwA4KBLZdLzEIRTsoK0j6+ayBXw9YTpbP
 0x1kqt/leOiXWL9SrL0sI0ruHf6iosW4tApTFFt53FyGdl+1YPLqttn9v26rt52gPqAr
 2NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082907; x=1707687707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYMLLwA9gva4L4uzAlLYH7HUcuo07hrL8DJH/YZuBt8=;
 b=CLNgRHN8AQhewfSXYFDPGjG6z6NArmR6Ra6kiE4gQbxoNr2cEv8R/SZOSJLtqdXm3w
 vro/wCc8neAGmsxTzQlOi+VSxBq3NSX7SZXIud+XX0QquGlxEl/a1RHialVwsuuIuJoD
 dL7YFlwY2vATw1gfFznHBzNN7EfVaN5QzraDhh+rS3gSGzIFWHQfEbc4TJlhf55ahvOZ
 EsU4R8LsjmCLNZ2MSS4W7zO83gjWLf500DdBDs+cwcpbYsdJ6rrk77WqPEWDLp2ybOaN
 S/fC6WbGjcPvgikPJLPR/5tUD8GE924ja/2S7vX8DDnP9fbO7ZrXzd5xpcezAYHYBdnc
 WXyg==
X-Gm-Message-State: AOJu0Yywf6ZIC2b3KYlb5z9yKMAohpmu7VLYfHer7XCiltYjicG5SeoM
 hPiGWYAsYzznemNCNpaclTcay5sNcxrQW88RYiHo2iklGl317oj+PFCgNsKVcKa+xH7USDrj1hP
 vh/k=
X-Google-Smtp-Source: AGHT+IGR0he9cJNfevHB2nMD9AuVYykt/bFev5VhpBq5GNef69mri8NSc8MY0mH2RYFzkGP1TYZrKw==
X-Received: by 2002:a17:902:d507:b0:1d9:b789:b1b9 with SMTP id
 b7-20020a170902d50700b001d9b789b1b9mr1201114plg.40.1707082907030; 
 Sun, 04 Feb 2024 13:41:47 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/39] tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
Date: Mon,  5 Feb 2024 07:40:37 +1000
Message-Id: <20240204214052.5639-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Return the x86 condition codes to use after the compare.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2d6100a8f4..02718a02d8 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1449,8 +1449,8 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
-                        int const_arg2, int rexw)
+static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
+                       TCGArg arg2, int const_arg2, int rexw)
 {
     if (const_arg2) {
         if (arg2 == 0) {
@@ -1462,14 +1462,15 @@ static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
     } else {
         tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
     }
+    return tcg_cond_to_jcc[cond];
 }
 
 static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *label, bool small)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-    tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
+    int jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    tcg_out_jxx(s, jcc, label, small);
 }
 
 #if TCG_TARGET_REG_BITS == 32
@@ -1561,6 +1562,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
 {
     bool inv = false;
     bool cleared;
+    int jcc;
 
     switch (cond) {
     case TCG_COND_NE:
@@ -1597,7 +1599,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * We can then use NEG or INC to produce the desired result.
          * This is always smaller than the SETCC expansion.
          */
-        tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, rexw);
 
         /* X - X - C = -C = (C ? -1 : 0) */
         tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest);
@@ -1644,8 +1646,8 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         cleared = true;
     }
 
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-    tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
+    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    tcg_out_modrm(s, OPC_SETCC | jcc, 0, dest);
 
     if (!cleared) {
         tcg_out_ext8u(s, dest, dest);
@@ -1716,8 +1718,8 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
                             TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
+    int jcc = tcg_out_cmp(s, cond, c1, c2, const_c2, rexw);
+    tcg_out_cmov(s, jcc, rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1759,8 +1761,8 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
         tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
-        tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
+        int jcc = tcg_out_cmp(s, TCG_COND_EQ, arg1, 0, 1, rexw);
+        tcg_out_cmov(s, jcc, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1


