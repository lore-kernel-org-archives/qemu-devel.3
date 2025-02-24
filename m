Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76034C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3G-00078t-75; Mon, 24 Feb 2025 12:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2v-00072B-Fk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:12 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2t-0005lp-BL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:09 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220c4159f87so65446555ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417305; x=1741022105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3tkcbPQoLdcbi8H1E2Irpn3GIVeScWhj/F3Kesih3M=;
 b=eoKJ8DJiy7Hi3/AFDkkSQUeDrUgZsMTtvDsff3AEKOoGLLMA2AX4dVqMviabIGzVsE
 UERnlif+ojLM9PpZS3UtCzUa+IEcCkwneum8VITWbF5pJIKS+NWDtvlkHae/1Ilp6iTl
 Xun6h4I3afBw0soyyx1PkOjSFVZpHXpY2TwElcn3kgnY/z/egIJfTkdeO12NLTA8ku8J
 KrU95rmy/GZov9VaNeCs9f82jYkD457UJo8bOkqSPDXHusfddAN3FXBdksmvwtTftG38
 bKcinbohrW/EL6kMs91avypAR8BN6KRNhvXu/76urmItL6uhp+dG/OPop/nx27t9rN8f
 +8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417305; x=1741022105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3tkcbPQoLdcbi8H1E2Irpn3GIVeScWhj/F3Kesih3M=;
 b=Vekcmb+RisnbvxCgdQhzIikFQ+UNuCVs9b56TXwcyFwh591gK4bBycoA98ktCZiRou
 xjqMLvlIgSfxm7eNHAFe+eGWZD7s8xtmn0AJnMzruA/oxdhbkpCowEA7ah4mKD1Vlk82
 FU3X57uls7Yn1IrapsFMKG+VRGq/BZViyXI1rhGsUWCSGCSjfHyXAHkAftYqqQeA7pbt
 IdZ+PEKXOxoLZYCltxMKIZGbBod+14KBrkITHtWl5ugxUUaeGstK558mov30ztp5Opst
 0V4TCu21VuVKv0N2uoZBV9WF3p1IKg6MW/lXXMsN2ppAU+DOzQL0Meq1KOgF+wuDbMte
 CFOQ==
X-Gm-Message-State: AOJu0YzeQvr/nsA6RSau/yt7IVd5ZsPLcb2/OKokCe+b+fc7zJOwGpAj
 OOV2BgiSU1wkzyRyfdeO2DebKhDBnVItOm04bUKgn1l93UJCabtNyZ/E0EvyBF0FvyzIT/DXNA/
 A
X-Gm-Gg: ASbGncu/PutEucPc3zs/i+O/ATiEic8htD/vUEEmWOLXOtGHd5h2uxgG/dMEvdXSHgy
 gzz+0LrvQChnhedgTatqt3EKKE7PhJVvi2liy7PXmAx/uHB/B/pynQnT9QRa/OBzqOik8bS4W32
 fxHzBWeIgqPJMqH0GiqihuFviBt4klSD3zZ309raXHvlbv2aHshGD0Q+VKa65ejPG3O1QstG69t
 JyoB7xG34E3iQnH+AQC6HDDMjv+n/uVUEKvUYlexe5oUm3hMDydDSyNCRj338GzB6llfzDBuUPG
 yl4gyIJAaQ/qImDT6lLo6V6HIXCb/Bk/YuU=
X-Google-Smtp-Source: AGHT+IErN/jshs59DQ+Wsv39jnXHhR65InecRsL2loaK/Ljw45IQ0BnElJMImeO0jBjsoeHlwt1sVQ==
X-Received: by 2002:a05:6a00:805:b0:730:75b1:7218 with SMTP id
 d2e1a72fcca58-73426d7782emr25159335b3a.16.1740417305390; 
 Mon, 24 Feb 2025 09:15:05 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 14/24] target/m68k: Remove env argument to gen_load_mode
Date: Mon, 24 Feb 2025 09:14:34 -0800
Message-ID: <20250224171444.440135-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
index 73189d1da4..47938b9cb4 100644
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


