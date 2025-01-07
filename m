Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C45E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bp-0006Tv-Nv; Tue, 07 Jan 2025 03:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ab-0000Yj-Nz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aU-0003PX-UW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2156e078563so192292785ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237115; x=1736841915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUyTSeraC12XJxdhEuNCPLUxDmWr+MLOvb+/7fq7Io0=;
 b=SE5kSEzaD2ovKOh30E/ob3Gccym0TX7DmnpG4/8REXpdZvNPLOMEHm4IxEnvi+pfJ8
 V0UvvxmGApCucacHQzatSYRh+uk+x3F5O2yYw8wrPB2CU7zaUo1TFpNa3vuqpxIBLIo0
 lltYouozRIPpSqiabuNtYOP7LqQ327TB8KRpAu3wOoAqq9Bm82506DseDN/b3MQ7FLkO
 Uw5ubq7ZQAA8/pwRGm3AsJ9gzaqfKcaJ8D6iBCJYa1EBEV6tiSoMlipg4gOgBFE2hvPV
 iPdfV/kJtyTefnUD2Kn0j5KEj2g0UWmLlj26Br+8DEi3TXwwsE32NOuznIJCC4HssRh8
 s9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237115; x=1736841915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUyTSeraC12XJxdhEuNCPLUxDmWr+MLOvb+/7fq7Io0=;
 b=a7kP39Kl1QxQPX3nWrvvjyytft/gv/Qox/QLVe77ix9+41QQWRZroUrCBxka/twFpb
 vYgkrP6s7gpsbnkFf2Lifho6xtfs8g9dLmapQjrkvfCjn8yYNoZrcUwc5uvNP0OyoWfc
 L/rvgdMoYsrgFlY7Pw1Vc6+XxRKnTqa+Wcc64yPmGX3TUBQoicYiebs2stwF7izZnly6
 K8zq0BXGPjIrZAFgaD5RkDXWNer2IWANvNhfGLkKbHMBpTLp37LFQE5bLUKYDQWPmQo5
 jW/wTBz1upvW4wTzJL5nwx3pxwAp/9NAxu0kb0ZR1M6lt/JbwwoLAdKOvSnH2Fnfpa/x
 TW2g==
X-Gm-Message-State: AOJu0YwyZXiXlibna3CQ9fWzz4IamggzZrL7zsH9J2G8aEB68os6dMn0
 ByMNCU0X0zte493f49QeocRmUoMFJ5AkM4QC7yeviL+IJPdLRW9D12OxhCV0Ib8CE0BK0GNjCgk
 t
X-Gm-Gg: ASbGnct6KbN7Ljv1GstwHZi7Kn9lnod2isk/qrx7X/5BObIADyjfX4h0wseWPXAUK8z
 r175GroaVogN3ImgFk43azsT8raxXZmCiYISbn/AoOM3ofQp3eaFlCy45jjXwVLPDaqyV/bwlR3
 Eh172qAVTw1myWhVvJO6DCYntGJctz9RelgF8qjI06wYrCmaKSBJDvn+whpCSP+DCZAsxDPVWuv
 ofQYaLSCcOOq1KuBtF/MrD7n8Jehiiz06GPm3Pp9eQ+1DEw+axh5c/EreCY7ueyyFMNP9Li4+3D
 ruV/fQPGFKYvvG/kng==
X-Google-Smtp-Source: AGHT+IGk9TIlCMF+Guh6ghFPhCUV5IyYkL1W0YJ3yl50eFWclZvVQ/KNdsDwlExQFZ9HvdW7vFj/5Q==
X-Received: by 2002:a05:6a00:8c4:b0:727:3c37:d5f9 with SMTP id
 d2e1a72fcca58-72abdeff523mr75999478b3a.26.1736237115287; 
 Tue, 07 Jan 2025 00:05:15 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 57/81] tcg/optimize: Emit add r, r,
 -1 in fold_setcond_tst_pow2
Date: Tue,  7 Jan 2025 00:00:48 -0800
Message-ID: <20250107080112.1175095-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We canonicalize subtract with constant to add with constant.
Fix this missed instance.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1dd7b0e0bc..465e29494a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2286,7 +2286,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode xor_opc, neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2308,7 +2308,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        sub_opc = INDEX_op_sub_i32;
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
@@ -2320,7 +2319,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        sub_opc = INDEX_op_sub_i64;
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
@@ -2364,10 +2362,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     if (neg && inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_add, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
-        op2->args[2] = arg_new_constant(ctx, 1);
+        op2->args[2] = arg_new_constant(ctx, -1);
     } else if (inv) {
         op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
         op2->args[0] = ret;
-- 
2.43.0


