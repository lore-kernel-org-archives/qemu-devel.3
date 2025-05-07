Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80982C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm55-0006EG-Sa; Wed, 07 May 2025 17:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4u-0006C5-Kp
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4p-0006EX-Gs
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b12b984e791so183614a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652394; x=1747257194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ok53xIzLI2IBSSccdU4efHkh6BRF9PSHfrGqxYvdbXk=;
 b=Am771bU0KSsXIqYZ4VB3vBHFmgktt9L8wOj1ydknzXcyFx54cDOleNRG9qrEPFg37q
 l4kresnTcNukkCmpTRtevW8LHPxlHf7ZbjVTW9acKbvBgVemTp2o0oVX/V7VyfbvXMwL
 cuYn3i7651aVCA9kk9kIA6Ma98hq1441p/EV0AAn9lMoY6nP+0I9e87kb/+sg4OaMud0
 J/IHaFuo/oyPKZOstroCV37FFsIIcH5MFjKSnZqGUmIfIy0hhkQMpCFzSlZxoCHJF8kv
 z6Z1bBPsBOJcb9EIa3IUvKZ2C3i312zGabZJaNo4ytwYtRX3kYNUxVRF67BRyx1uFGeh
 FRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652394; x=1747257194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ok53xIzLI2IBSSccdU4efHkh6BRF9PSHfrGqxYvdbXk=;
 b=HCfzyTApZ6fp/tKyu3Lsw+Gcfffp2uGYsV9sRnp9G8T1GHI3puO68Ruum+Z5ATcWt+
 jfPMocWcoyU5r6loALZZDFhY48d+KXM30v+5Ifw0+ZhbNN0fZK1JRu+e+NMRVQJGG18/
 4l01qNOJx5gwFukJXQ99j95awAEAC8Jsx7w8dDRXtQxd+hKwMkUkEWbbINQJ6pXhCL3H
 Tmtrg2acuF8JFwLl4wNFb7j/LvUlP0ouuoI4SE2jazezrxkKvLRjwn0Pi2RuP7vpIN6w
 T2Bclfnq6SjATl9bT+DHpidbWWSS67PBorlHArTIQSpQG/uDG/tyCQeQHj4oo4wbPN4V
 SO/A==
X-Gm-Message-State: AOJu0YxCFxoYam/Xsysed3v8xI5SQ1xvFFlSaJT1gGZNPk4FvbllPTE8
 kJmRIAEJmA9dFbxGHNtI54a3Ww5JQcYTrcTupiCAeRmpG67TmYf1oYgqf6jFYcxVQifPEfM/ysM
 v
X-Gm-Gg: ASbGnctfCrFUhd8zsx4RI2zcbZtXEpJ3PqPA5zgRDDYQz//gctvdNIXgRRvhP0/0J8A
 4xWOCi2g+dVWG6yqr0Ff3CArrZRtj40nnRSNKYnsRKI5PwjN4JaPT4HBj5/MGR6IKUGtcpJLVRh
 lj26n5Il0FXOVpPQhafyW2gmZkncopLXXs1gkTpa6UNcxBrdwf9OXmiiiooMTspMAjBQ4rvgSxq
 5VW5UoGg27Ci4IJ3fFSH8fwf1vIYtIPAbAyZyDtcexGVDMXVDiQ0SW2CJuTLLFo+ypVGBCWwX5q
 VI8u1teYajLtU5mgaswLFmQmFjGQft848XvXphk7L0hH4/02jkHy3xwYNl0JjIIJ7awln+stOYs
 =
X-Google-Smtp-Source: AGHT+IGFQ6tKIbiQ90B3nP8HhVQiXBLEvzOWLPMQNmgAbIf+hsbLfYSV388aOMokXm2sxcu+yRqIbA==
X-Received: by 2002:a05:6a20:c992:b0:1f5:67e2:7790 with SMTP id
 adf61e73a8af0-2159af61f1fmr920053637.17.1746652393791; 
 Wed, 07 May 2025 14:13:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 14/24] target/m68k: Remove env argument to gen_load_mode
Date: Wed,  7 May 2025 14:12:49 -0700
Message-ID: <20250507211300.9735-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 target/m68k/translate.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e0482bdbec..ac48329674 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -776,9 +776,8 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
  * a write otherwise it is a read (0 == sign extend, -1 == zero extend).
  * ADDRP is non-null for readwrite operands.
  */
-static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
-                          int mode, int reg0, int opsize, TCGv *addrp,
-                          int sign, int index)
+static TCGv gen_load_mode(DisasContext *s, int mode, int reg0, int opsize,
+                          TCGv *addrp, int sign, int index)
 {
     TCGv reg, ret, addr = NULL;
     int32_t offset;
@@ -799,19 +798,19 @@ static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
             /* Immediate: sign extend values for consistency.  */
             switch (opsize) {
             case OS_BYTE:
-                offset = read_im8(env, s);
+                offset = read_im8(s->env, s);
                 if (sign) {
                     offset = (int8_t)offset;
                 }
                 break;
             case OS_WORD:
-                offset = read_im16(env, s);
+                offset = read_im16(s->env, s);
                 if (sign) {
                     offset = (int16_t)offset;
                 }
                 break;
             case OS_LONG:
-                offset = read_im32(env, s);
+                offset = read_im32(s->env, s);
                 break;
             default:
                 g_assert_not_reached();
@@ -1324,7 +1323,7 @@ static void gen_exit_tb(DisasContext *s)
 
 #define SRC_EA(env, result, opsize, op_sign, addrp)                     \
     do {                                                                \
-        result = gen_load_mode(env, s, extract32(insn, 3, 3),           \
+        result = gen_load_mode(s, extract32(insn, 3, 3),                \
                                REG(insn, 0), opsize, addrp,             \
                                op_sign, IS_USER(s));                    \
         if (IS_NULL_QREG(result)) {                                     \
@@ -1700,10 +1699,8 @@ DISAS_INSN(abcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                        NULL, false, IS_USER(s));
-    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                         &addr, false, IS_USER(s));
+    src = gen_load_mode(s, 4, REG(insn, 0), OS_BYTE, NULL, false, IS_USER(s));
+    dest = gen_load_mode(s, 4, REG(insn, 9), OS_BYTE, &addr, false, IS_USER(s));
 
     bcd_add(dest, src);
 
@@ -1736,10 +1733,8 @@ DISAS_INSN(sbcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                        NULL, false, IS_USER(s));
-    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                         &addr, false, IS_USER(s));
+    src = gen_load_mode(s, 4, REG(insn, 0), OS_BYTE, NULL, false, IS_USER(s));
+    dest = gen_load_mode(s, 4, REG(insn, 9), OS_BYTE, &addr, false, IS_USER(s));
 
     bcd_sub(dest, src);
 
@@ -3120,11 +3115,9 @@ DISAS_INSN(cmpm)
     TCGv src, dst;
 
     /* Post-increment load (mode 3) from Ay.  */
-    src = gen_load_mode(env, s, 3, REG(insn, 0), opsize,
-                        NULL, true, IS_USER(s));
+    src = gen_load_mode(s, 3, REG(insn, 0), opsize, NULL, true, IS_USER(s));
     /* Post-increment load (mode 3) from Ax.  */
-    dst = gen_load_mode(env, s, 3, REG(insn, 9), opsize,
-                        NULL, true, IS_USER(s));
+    dst = gen_load_mode(s, 3, REG(insn, 9), opsize, NULL, true, IS_USER(s));
 
     gen_update_cc_cmp(s, dst, src, opsize);
 }
-- 
2.43.0


