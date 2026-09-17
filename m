Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB714C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73qs-0003Uc-3b; Thu, 17 Sep 2026 00:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qm-0003Bk-Qt
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:57 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qk-0007v4-R7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:56 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf03so351396a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619753; x=1790224553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kLu6Wqk57UMkOUoF7hXNbINLwaGB4za07LnDfLySSDI=;
 b=s30ffKOlCY7xIUPld4gKlXfXcpqiqMSl3LkjhtBGzuEND7Zd05gSC02BqGi1l4WFcd
 fylQ1w7IOFwrM3xfG5dcAMwE7djimA/Oa5g5g67L+1Dt+r/mg/YRlt/FcyXl6GUwiHja
 hjcvjyInZ2CHDKgmNZQAY/r90mLAOU+sh5mUyM5JCzl2kl7lU3wuNdcOBQg1Puou/tlD
 QGnznsUQyb3Z6d1WfetGBf01M/jsaNJ7OOc8ECaqlH+UYK6hpunMszKhRS5JMPhpcqdE
 glybTb8iULNFYuw/F+Y7Y/gfAf0khkIiN+6zfuOFI0+6ZymaIl17TmLY+wk2gOl0ZEi5
 ImDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619753; x=1790224553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kLu6Wqk57UMkOUoF7hXNbINLwaGB4za07LnDfLySSDI=;
 b=qOn3SW7kE1fmjKpCkb9FTjjASEeBrV1eETIUT8U4J5d96eWq1uYp5zGpi0SUHEwBqv
 n1stRRsiqIwjFOs2JH0PgfvBA/orZOQAxkMTii8/W90X+DAun4yw0OQEbqyh71BswAJL
 tGkOH4MKk7Zd6vI3S2Dp0paCGnbOYflUErsoDPCmSbLNAaD6+smMZXNDerSbByZXYXOK
 iYkTEMlB0SBVpZCrBSQJUKvD46LZsqVO4T05yNfKwMjV6g6XNQBLWZH/f6tsA2PAXMUf
 s3SvBcSuMh4LSqKVl6opoKj/nJcQrRuJj2m+M69ftLU0OZltz4Y8sW4TLZZY/Ngdei3K
 VgPA==
X-Gm-Message-State: AFuF++mzyoZfyoVVlykWA8EzjLCkXqBZVQv8CRXmGBxGqM5NB93+Nk1z
 MIH9wndYX6EkvxaJQ3p/SlT4m9dyyc0EepepmzLIL4i8JvIEgYsl1dg0DUENSk2HbM7bFcIP8vD
 COM90
X-Gm-Gg: AYBFou3vaf/ra7u4g/dMBc4uGgUawk9BFDQ44QWMMrCgIGa0uzmEt32fL2UQGCELgdY
 iamVOyJOxOx/1H7WL/QYU40kg2CYsQNpbh8Qk7mu7TvxFD7fYidJYgNYqa0DPNnB2qbEAjH9cGL
 MS7SAEtPBhos8sel29gHdv6iCg+ZiKLM2s42LDXXcNP2HfK6dIvURtPNEf4aZ4Dk5o3YR6uoGSO
 wCSqYfIs0c4v+PumN8ytfCgkq3ZdDPtjyh+iYhvurjWIK6PcEYBJ41pCnDmD7lj1Flq+Mwyyl+N
 r7DzM0cTPQRlh6BIQ9qG/gSV61kS3ZZTrgZyhvqJsV663O1VlHVM5+Qc8nYqhEv0bE5aF+62sOB
 vh4juBfcAPGUgFasPn5u+vxi5P9HeNxq26qxCFawC0KrtVLJ7Qnt6L9S2lfJyiMFVu9qI6Wx4ro
 ReYKZHuoE3EEzjDv2qsU3rK83lqmGKzWsrVXRMeRf/9TWQFtauPI9QH8zEAB2brbWv8nDBgg5vd
 qc5esA=
X-Received: by 2002:a17:90b:3d47:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-39e1e26a235mr11414797a91.0.1789619752990; 
 Wed, 16 Sep 2026 21:35:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 082/101] tcg: Generic expansion of tcg_gen_addcio_*
Date: Wed, 16 Sep 2026 18:28:04 -1000
Message-ID: <20260917042823.542588-83-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 77 +++++++++++-------------------------
 3 files changed, 24 insertions(+), 58 deletions(-)

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
index 04faf9bb69a..c534acbdc74 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -430,6 +430,29 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
+                       TCGTemp *a, TCGTemp *b, TCGTemp *ci)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        TCGTemp *mone = tcg_constant_internal(type, -1);
+
+        gen_op_ttt(INDEX_op_addco, type, t0, ci, mone);
+        gen_op_ttt(INDEX_op_addcio, type, r, a, b);
+        gen_op_ttt(INDEX_op_addci, type, co, zero, zero);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        gen_add(type, t0, a, b);
+        gen_setcond(type, TCG_COND_LTU, t1, t0, a);
+        gen_add(type, r, t0, ci);
+        gen_setcond(type, TCG_COND_LTU, t0, r, t0);
+        gen_or(type, co, t0, t1);
+    }
+}
+
 static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
@@ -1250,33 +1273,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
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
@@ -1787,33 +1783,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
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


