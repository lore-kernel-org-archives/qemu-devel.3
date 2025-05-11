Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222BCC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP0-00032x-Md; Sun, 11 May 2025 16:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOu-0002Uw-J3
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOs-0006Kf-Pt
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so2464171a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995753; x=1747600553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EprzNqSDVLOk3XX3wLzyS3Mr8if5bv8/i0zNJtnFHWU=;
 b=G0qLZVxnZfyFUtlyLVH7xa3RCTedxfb/INRTokgNxOX/e6xgWKNAL7Nzhf+e49VETx
 TwZK/5IgDQ4uUVYwUBNXaWxjh5W+OLiTcVMOWX96wc03F7wRhk1uC8lsdcAsO9k0D0A4
 72GshtJNTVPPwpscgNaFOCuD99gdogAyGhnDcd9pdMyIMRIlrqscdytbT2Wy+7kQz2GX
 dvivdpdwOCKgEX/ExBGY7LUohMtutvDtCGPnDJ+3I4+pxvzCtuyHf6CCoNmE+2PDPmot
 QLrJFW+yevAz3mOdGxwh6BNDmH2gdtaiEsuCp2w9KlwwHv2J7QoKesnalydsjJN7zhSS
 FxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995753; x=1747600553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EprzNqSDVLOk3XX3wLzyS3Mr8if5bv8/i0zNJtnFHWU=;
 b=pinhFWbVtTcsIp+beCIm5DkK53vituPt0OVVhZbxB+F9XjFVk24gDjg1a2xJ5J69GX
 xFHwA8CZUK7NhheNt51INuXhB7bbkMYatUI3isl6+N5Bn42T6/43bXyPNMvLm2WhkH+q
 S+owUpsTttvuUgvA1oWXro9+sGHWWRGslazrpnHAov2PHlsmlIQpjPEKN+RK7NmW7keW
 eq7O7mr87xj+JUkdxD6E9Ydx/1/9XIS9cXf9rNh2d8Y7sC7DEG0ayWXJRiadjMRCwPpA
 ZJ8wTqA2Sam3N3hGN8GhP/j+0clW8eHdrst12mmyDUFAclYic4JdA/UIxQNZCL1j2gFX
 wSew==
X-Gm-Message-State: AOJu0YzavfsiRAT4JNXfi7k/vkr5PQzsjmHcOjJiCW6dRu/347qBbPRr
 Ww8G2LnqggQMwB8+1IuUWM9iMFc/gtQEyEB60BStNcRQMype4FUatL0c6hXDFsEhWVJhXLphg0+
 K
X-Gm-Gg: ASbGncuilBArEAVYuqOuhpvF8tozavxhImFi99Vr066ioPg2IJYk/4hzjtE5bfjiROp
 GGsyi23YgSSBWFHucFR32K4SqkXHyppyYqAxMqf1tiZKmWdfhmxyRSQqBFClr7xkKjk7wupvf1n
 LTFFSqa4UaZiEzcSmpqNeqlb+nQYymF3gDP00+QgtHiPWiK/6Zgb2ZfJtOLpyTEx2gxZ/13iPJX
 i3ffwFONREhwjVKGXZPCqmCVJ6zp262c9ntP8VMB5LIzxdg7DcJxj1fGuM5orrGjcdXCCFOhsFg
 WaMD1iIX8Q+uFmh2kRdcE7j1xQ9yd0UZovd4LJIiPXuEEnFafooaxyIO6YEmoKEbFuU3DS8KHrF
 vtdWtCFexCA==
X-Google-Smtp-Source: AGHT+IELtr+Tp+7OZxEB98qkw1B8Dqgujo3clBqvHOmwmvtNuURD4m2OSpDh9fTeWyWMPFPrZGlHUA==
X-Received: by 2002:a17:903:2f89:b0:224:1eaa:5de1 with SMTP id
 d9443c01a7336-22fc8b51ac5mr129235385ad.18.1746995753236; 
 Sun, 11 May 2025 13:35:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 07/24] target/m68k: Merge gen_ea into SRC_EA and DEST_EA
Date: Sun, 11 May 2025 13:35:29 -0700
Message-ID: <20250511203546.139788-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

This will enable further cleanups further down the call chain.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 340d72bc4f..b9633e06da 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -897,14 +897,6 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     return NULL_QREG;
 }
 
-static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                   int opsize, TCGv val, TCGv *addrp, ea_what what, int index)
-{
-    int mode = extract32(insn, 3, 3);
-    int reg0 = REG(insn, 0);
-    return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what, index);
-}
-
 static TCGv_ptr gen_fp_ptr(int freg)
 {
     TCGv_ptr fp = tcg_temp_new_ptr();
@@ -1368,18 +1360,22 @@ static void gen_exit_tb(DisasContext *s)
     s->base.is_jmp = DISAS_EXIT;
 }
 
-#define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
-        result = gen_ea(env, s, insn, opsize, NULL_QREG, addrp,         \
-                        op_sign ? EA_LOADS : EA_LOADU, IS_USER(s));     \
+#define SRC_EA(env, result, opsize, op_sign, addrp)                     \
+    do {                                                                \
+        result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
+                             REG(insn, 0), opsize, NULL_QREG, addrp,    \
+                             op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
         }                                                               \
     } while (0)
 
-#define DEST_EA(env, insn, opsize, val, addrp) do {                     \
-        TCGv ea_result = gen_ea(env, s, insn, opsize, val, addrp,       \
-                                EA_STORE, IS_USER(s));                  \
+#define DEST_EA(env, insn, opsize, val, addrp)                          \
+    do {                                                                \
+        TCGv ea_result = gen_ea_mode(env, s, extract32(insn, 3, 3),     \
+                                     REG(insn, 0), opsize, val, addrp,  \
+                                     EA_STORE, IS_USER(s));             \
         if (IS_NULL_QREG(ea_result)) {                                  \
             gen_addr_fault(s);                                          \
             return;                                                     \
-- 
2.43.0


