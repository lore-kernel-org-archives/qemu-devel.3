Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED88C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kli-0008O8-Lt; Thu, 24 Sep 2026 10:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klb-0008LD-Fi
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:46 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klW-0005EW-6w
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:43 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-8692a856865so984814b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261377; x=1790866177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r+hPJBn6W1w3TeSRLCX8j8LMzNUFdeN/iLWVFxCqtMM=;
 b=qQnRnxOQndTdF/8tLykxsBuJT4ZrleI0fx+5oedYSSdnUFWx6mPc61F0Ds/iXdPOXM
 pZfAy+M8W8vbRLEbHRBISjZptl9iPC77onHFTHPeIPCsb5NFXctcT8MRsjVdG64+UKTh
 iVt2H91r4VUOAoHFgWXMuMXpOvJ3gKWYbCBDNKBuTC/Id1sMxo9nK6KFOQgQRgR9gx2q
 LPatLNXgHJwnbP1juXqjJnbGTeLwsQOUQo1Ah2otHD+qPMsANYbtfvyinwdNH6c/nivS
 wvJlA2tk99LuPUnV72sfUZjEUk/8dQNk3vk8ZK53OkI6zdv5lA488Rya4DoFXjfvNYLb
 aqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261377; x=1790866177;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r+hPJBn6W1w3TeSRLCX8j8LMzNUFdeN/iLWVFxCqtMM=;
 b=Lp6UncXowpx+zHGgbVBEGrWIx0d1eXII6HTYgZLv9ByxHm6IcqozVdqE6qe3jKWDkE
 pAnLWrbpcQjT7FB+Zxa5mkM72fbmaHlL3WCa8bBwwao3Z7R3BAUuMrtLoqnHj2hoW3NT
 JlX0YfYY0QjM2t7uG8zQO8Dhq6/0y7V5JK+TJgRZ13Fq73gqAQv1oQY+ExsDRvwx3vGx
 0T9gTxCeJocFGRWhf94KM/HFy9tyBVkMgKIjaXlnTlPV3HqAk6dNj4cXYdanWMKsXR/+
 6+wvm/9VkiyyD0KtJ1/WQaf3xqiQ14oHftTaqEvEn8u8Qs0Pawhj67mHSwF3UjGGTTd4
 0C1w==
X-Gm-Message-State: AFuF++mG7aIo61VaXhupCZEOJOXPqD3kOsYbSlgftSjIyZ/RHhGz+Nqr
 35/1gBGgzl73KFtzu86lkMhypc06vo7Dj5fW94p2G10s+jGYT1nAo68MdD/ERr3zlNIuzoHG8aT
 c3sOj
X-Gm-Gg: AYBFou0HyFeIyJ8XJySp1ZMC4lKVYRx4PH3Ekin4t7tKmJ99bbYaU4c0IY7bUZh8F3T
 vnCujDxbsI4z5Ak08Bar51rdlww7waBcadOSD4GYHZIXriYBzgFv33XALweHnvP291W0vXytUfB
 cx4OLtw6U40Aa0xg3o76+cxzeVcLzVCDIHkJznHA12T3rHjnnqaId57Xu2FB3TSYhPZhtktQg1s
 8SflbGscvvzC/rUiUqa7Dl0axIvkDr823JBKtf0Ff6/GNaVb+jmyz7kPdYHOuyLqch2tSADPmxL
 rM30wiKKeyIqNcI7WT6uWtTGO5/erWyqsIOR1L+8iV5ipqTLRTlqqUYrp5hU4zMcoSnpfGkJU+O
 LjFBAlLb3fWt4uEwPkkDs9jEHZgOg6FZXW2oFS4VXpe2U8e5cmgJJiAXZuCUO8fCE3krw892r+T
 Ff6zsXaIJ28HHKTWlwpE6MG/9Tfltpl7pZLHikgvKILPW9tMT30PN9Blw4xyGOlne4cnOgXhw7P
 qIG1fn7silRJMfOme7I7KT9j4b0jQ==
X-Received: by 2002:a05:6a00:44cc:b0:87d:d6d1:c627 with SMTP id
 d2e1a72fcca58-87e9b3b6b2bmr2341046b3a.38.1790261376424; 
 Thu, 24 Sep 2026 07:49:36 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 4/8] target/mips/tcg: Split out gen_mxu_logic
Date: Thu, 24 Sep 2026 07:49:27 -0700
Message-ID: <20260924144931.161335-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
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

Split out a helper for common expansion of a 3-operand insns.
Drop all the special cases for 0 and let the optimizer handle them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 122 +++++++-------------------------
 1 file changed, 24 insertions(+), 98 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f30883f976f..3f8acfcdb8f 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1685,14 +1685,11 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
  *               S32NOR    S32AND    S32OR    S32XOR
  */
 
-/*
- *  S32NOR XRa, XRb, XRc
- *    Update XRa with the result of logical bitwise 'nor' operation
- *    applied to the content of XRb and XRc.
- */
-static void gen_mxu_S32NOR(DisasContext *ctx)
+static void gen_mxu_logic(DisasContext *ctx,
+                          void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
     uint32_t pad, XRc, XRb, XRa;
+    TCGv_i32 t0, t1;
 
     pad = extract32(ctx->opcode, 21, 5);
     XRc = extract32(ctx->opcode, 14, 4);
@@ -1701,24 +1698,25 @@ static void gen_mxu_S32NOR(DisasContext *ctx)
 
     if (unlikely(pad != 0)) {
         /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 1s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0xFFFFFFFF);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the negation of XRc */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRa zero register -> just set destination to the negation of XRb */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to the negation of XRb */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_nor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+        return;
     }
+
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+    gen(t0, t0, t1);
+    gen_store_mxu_gpr(t0, XRa);
+}
+
+/*
+ *  S32NOR XRa, XRb, XRc
+ *    Update XRa with the result of logical bitwise 'nor' operation
+ *    applied to the content of XRb and XRc.
+ */
+static void gen_mxu_S32NOR(DisasContext *ctx)
+{
+    gen_mxu_logic(ctx, tcg_gen_nor_i32);
 }
 
 /*
@@ -1728,27 +1726,7 @@ static void gen_mxu_S32NOR(DisasContext *ctx)
  */
 static void gen_mxu_S32AND(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) || (XRc == 0))) {
-        /* one of operands zero register -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_and_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_and_i32);
 }
 
 /*
@@ -1758,33 +1736,7 @@ static void gen_mxu_S32AND(DisasContext *ctx)
  */
 static void gen_mxu_S32OR(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the content of XRc */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRc zero register -> just set destination to the content of XRb */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_or_i32);
 }
 
 /*
@@ -1794,33 +1746,7 @@ static void gen_mxu_S32OR(DisasContext *ctx)
  */
 static void gen_mxu_S32XOR(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the content of XRc */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRc zero register -> just set destination to the content of XRb */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else {
-        /* the most general case */
-        tcg_gen_xor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_xor_i32);
 }
 
 /*
-- 
2.53.0


