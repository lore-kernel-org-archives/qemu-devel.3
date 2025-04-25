Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274CDC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9f-0000Hu-Nk; Fri, 25 Apr 2025 18:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7Z-0004p3-30
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:09 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7V-0001Jw-0S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:08 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30820167b47so2950433a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618523; x=1746223323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87bYInJRyVL+HwLQ2oXfycDau4yD/PjsGy7QE2A01nE=;
 b=aPT6Shj1ZiTLYLPHY8gM2b478XBnRQeZrOA+r9SPjssT8TdwbQ+WsP+lmqHimmCHXd
 m/S2GR36ez3zPX2lREzZ0zglaIracwTEgsP1KKnBFZ0bmFa7ETvNzRJ17sq1T2e6N2rG
 BLQeCgTQ+RmxtzLtlYXCDMWTP1/Ug++OB5MtbgQDf9SDjIEn8eFAE2oPMpzUFfRkFDti
 UnwvtFJe1dMat9wR0Uo801Vkxv4KEVWfcg5tGXov/zsRrKZDGlC6lNaMc1Hqg3OsH5AW
 t+94EFZWH8B2D/Qga9umRNDC6zoAbY0McTZgPFFZixcIIaJ8/6EfOqt/MmF7bQ6MjefZ
 IxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618523; x=1746223323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87bYInJRyVL+HwLQ2oXfycDau4yD/PjsGy7QE2A01nE=;
 b=Du4h8VGFbP/3pneDulX//HK5MEMwSXiZrWoC3+6wLi7n1LWVtuBV51A1+YVQ40Yy5L
 TclsV50LSQzFo1rp5xAwtE2uv2qwyV27zys9Z1baZxDe+4yBjGGKGpfteEyGHCErzPSf
 ZVM5DBnWWx3CU9gmefdcwFu8pd/ZM+rZbf/n3b037nD4gCVhN+n6Exf98Xu2nqVIx8J7
 VqnVzlo5Uye7MLcpOuw7krJ/82aq6A7eDeLqYFbqJLB5OcwdEyhVrSG+WQpRtDvyhm8h
 VUpqGKa0XiRqZVOHTb6dhXHbygH8ILneKp0XmQ3wJfLMroLo35ciEM09oiiumSRRTL3l
 I51A==
X-Gm-Message-State: AOJu0Yw0IzA3R2nifIRJBBHkXqX268TOhr43g31Xk6mRVOP7B01bU7Ep
 icK48aQUTG9X/aULb17SZhMN/JtronaUnNC7CHBNt+b+RwAe2Dj+uV8Kp0q3NAumPLmhmAMMg5m
 o
X-Gm-Gg: ASbGncvQTO98CJjGbtoJWREthwOUcMBOC94GuwF8JJGAgbwhOMbfWdSq38XRPpCAV9s
 6OkzAqYGLMLiON1Pi/zn0POdvdWNK/BbQaprju+RBUFlSdO815/S25+9auw5EUE05hXkjSY5t/o
 Q246X78Cc/qHmCmKGrw5MNYjZ3fU4tQaiqeyxqx/v2Ds6rrctA/kh+FPehqy/+BItfZAGr11M9O
 DA/YG5+6OqQO+802LMdL6jA5jXS7uxi6tGDbmf1UF4Bka0cT+mySu7X+TWJE1hbELlNtOqqQ3yn
 8hUWqMO/GXMEwz+kd+gQaHcGaZX3ugbrRvtSl0JdTozrFyLGJYkKHmiyE9L9pEocBBtgMVAroyo
 =
X-Google-Smtp-Source: AGHT+IE7PC+lYULTu3Avr7J84BfzeQFzBAd5Y8n9N5S+zWa7YrSoB8/ifgCytCk7aj9QwSNAGp4ijg==
X-Received: by 2002:a17:90b:3906:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-309ee39451amr11256822a91.10.1745618522662; 
 Fri, 25 Apr 2025 15:02:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 088/159] tcg/ppc: Expand arguments to tcg_out_cmp2
Date: Fri, 25 Apr 2025 14:53:42 -0700
Message-ID: <20250425215454.886111-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 1782d05290..669c5eae4a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2206,8 +2206,8 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     }
 }
 
-static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
-                         const int *const_args)
+static void tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                         TCGArg bl, bool blconst, TCGArg bh, bool bhconst)
 {
     static const struct { uint8_t bit1, bit2; } bits[] = {
         [TCG_COND_LT ] = { CR_LT, CR_LT },
@@ -2220,18 +2220,9 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         [TCG_COND_GEU] = { CR_GT, CR_LT },
     };
 
-    TCGCond cond = args[4], cond2;
-    TCGArg al, ah, bl, bh;
-    int blconst, bhconst;
+    TCGCond cond2;
     int op, bit1, bit2;
 
-    al = args[0];
-    ah = args[1];
-    bl = args[2];
-    bh = args[3];
-    blconst = const_args[2];
-    bhconst = const_args[3];
-
     switch (cond) {
     case TCG_COND_EQ:
         op = CRAND;
@@ -2286,7 +2277,8 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
-    tcg_out_cmp2(s, args + 1, const_args + 1);
+    tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
+                 args[4], const_args[4]);
     tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
     tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
 }
@@ -2294,7 +2286,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
                             const int *const_args)
 {
-    tcg_out_cmp2(s, args, const_args);
+    tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
+                 args[3], const_args[3]);
     tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
 }
 
-- 
2.43.0


