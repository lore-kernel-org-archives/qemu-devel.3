Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4005AECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC5-0005Ti-KA; Mon, 09 Sep 2024 13:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBw-0004mw-K1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBu-00063O-Ts
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fee6435a34so39721185ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902921; x=1726507721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFzduEvNp99h11xV1aQH9cRrEGMBljq+h6uoDBRgGBU=;
 b=QRLBBJpAARUoSjp/9eka9DMZtfMv8TU7G3/7O3btN3eLOey3WPZkqlsFdyODqyo06C
 PzoI6XTHSiFzV7bIAJ0NlWSeelGHm4cgL1M/AM4MFM4dzsLTAf5HVUAsHhkBzZeOtTNl
 LPbdyvCK044zlkJZPAbxo449rfqdjg9nUMKp5Zkd2lhTWb30Tw7hKi85SlWCDycfR1zW
 vxMQnRaypOD7e3XujJn1GRtQUOTv1mMp+I6RaK8SJVM2peRwR0ZaoeP5fVDkRCcTgmH9
 n1U43rk2ctnraEFyoocHefCzNBmo4SVGb6kYDWeqCefaHHbdTqYe+qgy7uooP3+PNCpC
 F4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902921; x=1726507721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFzduEvNp99h11xV1aQH9cRrEGMBljq+h6uoDBRgGBU=;
 b=KjqwheyQ0X/djnmqqYFwVh1x9GW5CbFUcFuQISV0nrssdUQ2hiM9at2BVBKAOxpITw
 IqPVJa/1RQqpCU8iVhGx/ay4CItuOCmK9jciFAqK3sENQJOyHjp1+JzPkKyy9IOPTZ8x
 WuHJlP9A0gcQH265e0Ccj0qYBfI04GN4370choxYffUO6dX0o0gromUB+/Jg0gj0FHpk
 CgV5sSruG4xrHQeB61pOKxT9J8t94s0TMm52N6rur8A8oApXUtfrUjBf8tIlYbYL7o+S
 6gOoTnUWanQtvegT54ZzLP3FMDz3rqN88A2+7uFKFVWVelust7MEZn3kWEKsfROTjT5J
 8/OQ==
X-Gm-Message-State: AOJu0YyF0Ae8qDGo9SR7o6ZGzV6Fp6pAeeLCKVGCM2EsjQ5PA82WYLx/
 +Y3tlbl2oqk8H727+hTHJbLbhnBVw4RQV/Ab92TAh2zGHnsRrUZAtYUjg6D4qfdaZPEP7kblxJk
 r
X-Google-Smtp-Source: AGHT+IGZSsNMKFGGZfYq2cw2Yf+eH9M1KGjBucdo4/Qv2bNVqlPi9QguvWZs8FDY7ckvItbYyN6hrA==
X-Received: by 2002:a17:902:ec8a:b0:206:91e7:ba98 with SMTP id
 d9443c01a7336-206f0622a02mr114515685ad.50.1725902921559; 
 Mon, 09 Sep 2024 10:28:41 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 18/26] target/m68k: Remove env argument to gen_ea_mode_fp
Date: Mon,  9 Sep 2024 10:28:15 -0700
Message-ID: <20240909172823.649837-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Use the env pointer in DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 8a96b38682..5bfdf9aadf 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1011,9 +1011,8 @@ static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
     }
 }
 
-static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
-                          int reg0, int opsize, TCGv_ptr fp, ea_what what,
-                          int index)
+static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
+                          TCGv_ptr fp, ea_what what, int index)
 {
     TCGv reg, addr, tmp;
     TCGv_i64 t64;
@@ -1058,23 +1057,23 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
         if (reg0 == 4 && what != EA_STORE) {
             switch (opsize) {
             case OS_BYTE:
-                tmp = tcg_constant_i32((int8_t)read_im8(env, s));
+                tmp = tcg_constant_i32((int8_t)read_im8(s->env, s));
                 gen_helper_exts32(tcg_env, fp, tmp);
                 break;
             case OS_WORD:
-                tmp = tcg_constant_i32((int16_t)read_im16(env, s));
+                tmp = tcg_constant_i32((int16_t)read_im16(s->env, s));
                 gen_helper_exts32(tcg_env, fp, tmp);
                 break;
             case OS_LONG:
-                tmp = tcg_constant_i32(read_im32(env, s));
+                tmp = tcg_constant_i32(read_im32(s->env, s));
                 gen_helper_exts32(tcg_env, fp, tmp);
                 break;
             case OS_SINGLE:
-                tmp = tcg_constant_i32(read_im32(env, s));
+                tmp = tcg_constant_i32(read_im32(s->env, s));
                 gen_helper_extf32(tcg_env, fp, tmp);
                 break;
             case OS_DOUBLE:
-                t64 = tcg_constant_i64(read_im64(env, s));
+                t64 = tcg_constant_i64(read_im64(s->env, s));
                 gen_helper_extf64(tcg_env, fp, t64);
                 break;
             case OS_EXTENDED:
@@ -1082,9 +1081,9 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
                     gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
                     break;
                 }
-                tmp = tcg_constant_i32(read_im32(env, s) >> 16);
+                tmp = tcg_constant_i32(read_im32(s->env, s) >> 16);
                 tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
-                t64 = tcg_constant_i64(read_im64(env, s));
+                t64 = tcg_constant_i64(read_im64(s->env, s));
                 tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
                 break;
             case OS_PACKED:
@@ -1121,7 +1120,7 @@ static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_ea_mode_fp(env, s, mode, reg0, opsize, fp, what, index);
+    return gen_ea_mode_fp(s, mode, reg0, opsize, fp, what, index);
 }
 
 typedef struct {
-- 
2.43.0


