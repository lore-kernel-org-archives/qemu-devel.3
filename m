Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776A8C3ABCC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP3-0003F4-Cg; Sun, 11 May 2025 16:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP1-00036G-HJ
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOz-0006MJ-O8
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22fb33898bbso45013775ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995760; x=1747600560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWbmGVAs1ZD9rubpd6cvwq4CGTb/LrxmBUpkdFa6TBU=;
 b=hHN3Oq7mbTi6t301VvogwtjROzHtBsgHOMFWz++JYp+Sazk2qAPsDn+5mCQLp1xhsh
 3Ch/3iB29HTjXuX2Om+ilbuSR1sFIzkPMfaORvb0U9t5of3iZ5SNy5fz1xJV5Mv0+GU1
 nlRBW24EFJAzbn7uAnmyg/NLZWHiURHurJOfO1KQGzwa0/dj+O3pHNHfqxRX73nGR+Ow
 PDdbza3/W233CoSJYoqVzHJ8JDzQwn/9Swbb5AEKdvsmogv8cj6mLZhX/+3JkZPoIn2V
 UY3Cx2/pcCGD1Hj/ZtZJsBUoTrMPBOT1FpzHeQUs3SjsZYnaNbxW7XwbtfMlkLIxv5Xz
 9BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995760; x=1747600560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWbmGVAs1ZD9rubpd6cvwq4CGTb/LrxmBUpkdFa6TBU=;
 b=q1LMNqB4Lj+M+JiSz/03d4Xp8eeJv+TmB9E/bP8lj1K5BlmlP6tRY7nxczc4mhWRM7
 n2J4ZE/vkkQV8RR8INWD/tXpwAz5S1+HvFMgUHa65NI99YHczxM3EEIw+XDJHJ81w2lR
 7tbeVpgfbtXgsDUaz08nTh+z7yz/AeCw4lAA3LcsS5OY0zHF/R+BYb2MMkUyzWcUXRC7
 AbIsRL0tg3hvUKGdz/h3CSpFh92hD1t2l74uDjg3xvPzyxMQxLMY2syeHshM+TZ1MfMy
 BPsggjrdq5ngNoRhMHWhHAtj2ImkeuCK9eGncb4/VTtI32UsonVTE3hltcU76O/UxWUY
 W6Rg==
X-Gm-Message-State: AOJu0Yx4cXyBaqDL+5i1ZSSzpfQj67EAiYMcZ7jS3gYiWEr6JntwvHK7
 1w30aTMvMhA6aSaEc1QTCZwN+KsSSz03CxfNG/bQzU/mnXiJa1MOn7IPAYMYFd8iwtBu18kEmtE
 P
X-Gm-Gg: ASbGncsFXLZrhejdb29nnoEJDX/uOscEoyy0vY2aFoRGQHWTkQfMFjxoeyrlHAOsdCz
 EF8R8EUhDf4nFm3yGbcyZ2DNzlQ5U11BRCwt5xXVD2OrXG02MFdOAzmXO1XzjWy/mfxuzENpt1/
 EtM611jt1Iz1n94+eebiqBUmexmNgld+aEmEn8CigJdqk/JyNSJyw9l2GeV/dICt79/ykaNXYxI
 YPrtx8FvsTbJLqaGLgmaotUpR50RhY2mRu+8Go+LtBFRRYA/f2RHjRnBYpDqfRwTaZSIBR737G+
 1dN9Cm8El49BSn6INMXuHAinM9GZlYOIQP6xq0gjS5VNaZ9lhyYLt9oki14me6Uhx0ERGtI/ty4
 yCT+vNPp5rw==
X-Google-Smtp-Source: AGHT+IEnpovCWJW8mHRIto2omqCrwa0b8ofpzK7lJc6Iavp8U+SpQgZ8eH5huQnHFKPmx6ZrBUKSSQ==
X-Received: by 2002:a17:902:ce11:b0:223:5c33:56a8 with SMTP id
 d9443c01a7336-22fc9185dffmr189726695ad.35.1746995760290; 
 Sun, 11 May 2025 13:36:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 16/24] target/m68k: Remove env argument to gen_ea_mode_fp
Date: Sun, 11 May 2025 13:35:38 -0700
Message-ID: <20250511203546.139788-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 2c2d83e61b..779890d3d3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1012,9 +1012,8 @@ static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
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
@@ -1059,23 +1058,23 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
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
@@ -1083,9 +1082,9 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
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
@@ -1122,7 +1121,7 @@ static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_ea_mode_fp(env, s, mode, reg0, opsize, fp, what, index);
+    return gen_ea_mode_fp(s, mode, reg0, opsize, fp, what, index);
 }
 
 typedef struct {
-- 
2.43.0


