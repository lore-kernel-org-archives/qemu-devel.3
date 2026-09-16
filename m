Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A03EC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQh-0006Uq-LX; Wed, 16 Sep 2026 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQd-0006CI-RI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:11:59 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQb-0001zE-Sj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:11:59 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c537df4daaso458931b6e.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564317; x=1790169117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IVaObsqt0ns7hxKy9cnnzCP4PzBs/LIDna2n/5S6srA=;
 b=sHFyeQZMMhGsKPQ3MjH9ZlQSnXn9AapUFF7/jHshSzOlF2oG1cWZ5BWbLYcvdM7cHK
 hRtTnNq3rAb/PcDDBV2q1TgoqCndavE0Pl0fFh18Y4QJCU/m9vNbP09CCY3LpE5AWhky
 eAK8UKymIAZo4SgPC1VxKTH9ejZaxhcjZNZKXPb2ikKCqk1NOPCRqA+H+Z/weZAJW+mT
 pw6jZ3e+c6DWXWYKVVhz6hnm5amFD8gLz8OnSSMW7KX6/6dfwcA+njs1lIgC9+CrVHZO
 4iMoJSpAtmqMnWO+NaQWejkvHd8To7P1pZN7Nf6AruqsTMKTjgc4QWu2+pOrCICsuKAC
 PRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564317; x=1790169117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IVaObsqt0ns7hxKy9cnnzCP4PzBs/LIDna2n/5S6srA=;
 b=kbXCYsEhxriJdY1EKIIj9WSPXiEZYbt/Gv1q6XZUjbOHckmwpCNaLQTE79GWnopzGk
 TcdZLa6K9Z0f9ufQcPfBMA9/AZWHjo25qAmsIJ9+cnLdAncf3yn9dkTflg7oc6e6zkD6
 M7JJ4mOYVwKt5QYZ+8zqX+dN29n5KBOnH8pH5Yx2Kn4sMQK260AR8/ARVzrdQfguAYI6
 7n8S7CLPnoRG7QG4yNyTG0feAisOUsgOFXkwLc9xRz41+HOlOdqNvVI/sGMdZ9B7736m
 QD/6swlrFan/7dN1oyti2lv0Tn/lwu6DDag9Q9wlbUcTtN65aQkVURo+R6qnBAtKxgXQ
 MdXw==
X-Gm-Message-State: AFuF++ne77OKyz29owgk7pyVWS8EQrRxoq6Sjlc84F7/v4Uf/1tZ7Vu7
 RpadmuqopTB9sFx0S5jsSf9op5gXggeSZ0chufLkD4kGp7YgDl7xg8ccRLUm/ZjprjhItQS7AiS
 3GkoQBSo=
X-Gm-Gg: AYBFou0DTZUNFOti3Z4bUFCF9YtkVtA01qwulwKQvVNfp4s1x0ylrtUSM4iyWe306Y/
 Bk+ESEC6S002a0Nuv1LwxznHzWkY0PNTPJQ6J5zvDW0a/ieJxB8VkFP9riFgoQ4CBMRT0KIMt7N
 xDVNnV2tbtIsypfL6WiB2vc4EHSEo0WBIsWq48vjgO1eyepW7w/xjEURuafGZFAnxkSbycPchiO
 /O831FoT+QfGtjCfBv4runn+QDTrO5picA929KBa3njJlFj7Tvuaf7fYJ2MB/Bme3jUYwyfDnZL
 Pqdo2BE65hXMzUTmZM35iQjC7swYWyBMpRzFbov7oyKfDDnHBtCGg6EsEM3lva+GQS+dXRSykJc
 32dCA2snVT+uMnrTXDQpXCM30twbfwEXjQxdSUlwJNKqjYdGqzV9R9NhuzIGOtqvtD/cP4SFtzL
 D2hFlbQOwKrgO7RnCQ4PhnhKY/Jvx/EjyOnUqb63PX//4om+/D/goopZRPzUQkqmB7zs/R9mEk9
 0CfDMw=
X-Received: by 2002:a05:6820:214:b0:6c4:a3da:1a49 with SMTP id
 006d021491bc7-6c7d4bee190mr2482221eaf.67.1789564316425; 
 Wed, 16 Sep 2026 06:11:56 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.11.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:11:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 80/92] tcg: Generic expansion of tcg_gen_addcio_*
Date: Wed, 16 Sep 2026 03:03:55 -1000
Message-ID: <20260916130409.3382710-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x11.google.com
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
 include/tcg/tcg-op-common.h  |  4 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 80 ++++++++++++------------------------
 3 files changed, 27 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c60135d2fe4..60a0dfddf25 100644
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
index 88cf2e076e0..c8b5cd2b502 100644
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


