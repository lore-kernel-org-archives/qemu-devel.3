Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5B8C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBX-0005bP-I1; Sat, 12 Sep 2026 22:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBO-0004WB-Bs
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBM-000219-Dm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:06 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc4aa02a269so1743885a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267383; x=1789872183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iFaNpqW729rLu6OlcVBaBi0JnrSJPa+sSZOIqrxwJuU=;
 b=JuuIPW0BGUKoeIJ8pn/ugeCuc7Of3PB0+lI9pc5Eg7N2S7QZQHlk11dxsqahteOxSP
 7o+Ar966PEvS1Au78kIz3QN5T1nyMylphl7jw8qPaEjwGv1/Ntxhb1FICTytLS0R/pii
 HvfMR+lefhrazzEQXR0/2DSPVL0LKx+SzLb8UO2Q9FwHXYzNarq43YRHeWbQq/H3s6JU
 Jovfdyb00OcQIaYfhS5Bzpmrv3KUGqqBEObF231P94bv2Rlrwp+wvTA51tgjnDQRb0aV
 0aUWzpgWWxGDDlFU5XKXRvHNxIapoOqodmCfgsOYmU7sEwU1GEODlTtMCmQTBCtyesNJ
 lE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267383; x=1789872183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iFaNpqW729rLu6OlcVBaBi0JnrSJPa+sSZOIqrxwJuU=;
 b=eEwGUl7/eq2QHgfJlDurIjOdf/wLS9StWpuluqrrDm4Q0HpcMCQOoatZlNLR//3TKm
 CbPOiswkn+lgaUL9Enk4j1VBb/WkpIfdqOovhuY5415cJIR6MrqDSoyuN/+dHhkCl3BS
 X2EmUh5a2vSiyOKCIvCygsc5B3yO7r4RhkJte9FS0FwztDWio+opR22S/Bv0e428tq/i
 axI8d/91lNObpG/mbe8zuUXdMAVOvhwLINUdbhA6ZKazJY4LZEmz85KLcC5fGDPsPSN/
 8HGz57fUkXfpZ4Ub3IxsLvST8GklOnY3QHX/fABivw6MsM9/l9tWdJ6wcNat1ev1zlJo
 97IQ==
X-Gm-Message-State: AFuF++lCKIUp1Qf6+Pnicw36D6YD3WuLoNz5+j66iEnnzs8fms56cHpz
 qHrNIcKgr4pFUZDPiCrENYEiciESFpASefEpCuVxaBqtoPIBzLUVqw+BdgUrUPePKGFHtcERiNS
 KsrKRGK0=
X-Gm-Gg: AYBFou0GCWGavdzcQneNKnmUwdCPlnKxixkGaK3Zmvo/5NW48+1vD/94qnpl9pBuEeC
 eu07gsLorK9wX0KjYGCnB+fjKufs6mLylNgX3QgcfcAFf7RmcFhEAZIOF+Yc5n6s7PKgn1zZZle
 6Kv0lot+0I/fUbPhrUnedfCb7esYgxC3NsgcOatfFLrVux44eHQ2bFhWk1XQlddaU5hUM558/cP
 HzNH9UPWvCsmyKfV/AWsXz+++iU0yN2KlXPeznFxTmkB4r5K2OgS0LAS2OnWB6rnTkkW4PBfbje
 YFShUK/9tHxWB7h8gxqEBgar4qpdgLlrLvV9WJ84NdjofJ0UkYLvHekQksyW3N60PaROt+2mwrW
 m5mCfS/2p0M9jJ8VGCGP1waNpQcCW+z6I28fZ6AYPynZ+Sw6pPqAcWJNOqmxeEO+G0w1dT1UwaT
 FfFPu61PMxJOFO6IpJfF2xrCnh/YbHsdsNOzsJWHg/L5vGVpHhsmQUGTnCrsOUMW8TPYeQ/7b1X
 qD/geQ=
X-Received: by 2002:a05:6a21:7e0b:b0:3da:f32e:b3bf with SMTP id
 adf61e73a8af0-3daf32eb452mr16545740637.17.1789267382995; 
 Sat, 12 Sep 2026 19:43:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.43.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:43:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 77/86] tcg: Generic expansion of tcg_gen_addcio_*
Date: Sat, 12 Sep 2026 16:38:28 -1000
Message-ID: <20260913023837.741866-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
 include/tcg/tcg-op-common.h  |  4 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 80 ++++++++++++------------------------
 3 files changed, 27 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c973b002b5e..6835d659cf1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -136,8 +136,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -166,8 +164,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1f6b3e2c464..141c18061e8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b97c9df548c..9fbe6c6b160 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -431,6 +431,32 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
+                       TCGTemp *a, TCGTemp *b, TCGTemp *ci)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        TCGTemp *mone = tcg_constant_internal(type, -1);
+
+        gen_op_ttt(INDEX_op_addco, type, t0, ci, mone);
+        gen_op_ttt(INDEX_op_addcio, type, r, a, b);
+        gen_op_ttt(INDEX_op_addci, type, co, zero, zero);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_add(type, t0, a, b);
+        gen_setcond(type, TCG_COND_LTU, t1, t0, a);
+        gen_add(type, r, t0, ci);
+        gen_setcond(type, TCG_COND_LTU, t0, r, t0);
+        gen_or(type, co, t0, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
@@ -1263,33 +1289,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     }
 }
 
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        TCGv_i32 mone = tcg_constant_i32(-1);
-
-        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
-        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-        tcg_gen_add_i32(t0, a, b);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i32(r, t0, ci);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i32(co, t0, t1);
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1800,33 +1799,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
-        TCGv_i64 discard = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        TCGv_i64 mone = tcg_constant_i64(-1);
-
-        tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
-        tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i64(discard);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_add_i64(t0, a, b);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i64(r, t0, ci);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i64(co, t0, t1);
-
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


