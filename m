Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD61DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP2-0003CU-R6; Sun, 11 May 2025 16:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOz-0002yq-Qm
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:01 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOy-0006Lr-09
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22fac0694aaso27071475ad.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995758; x=1747600558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpTbNPfyDTwnZROaQJM3hL9QPrm4wpK5u5e1FadsZ4Q=;
 b=ZsIWkW/UU6GM8nTntSCjhz4fQ7VHqFS6OYwbZvNeJUFnDcRmWpmpGX43EuIMUTplzC
 VmSYzy7PWB4621uu3nLTK0vYZU+F6XhLRdyInArpuFF4B4viAG7IA2z0WmOnkFYNHqxf
 kyGSDhFJCQUwkbfeBiO5B5SOFSdx/X+9sMl6/huaweMyWllL+cH+8DLo9ZX2gQlHRYo+
 eT/UDsJQVpKi8adj8445tYxayv53r5KjmNlA1jdnC8wiKidOzAiNhT/6BmnPKMgH1f45
 MX6dBF8Np6bAcGyhNAhfvghzjtgNHhDEV2+f4h9ROBb3a+ZtYG2EoBKLibR0PKoQb9jW
 hNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995758; x=1747600558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpTbNPfyDTwnZROaQJM3hL9QPrm4wpK5u5e1FadsZ4Q=;
 b=mpJFVkN13VvmVbmmtKE99Jhyv9TA29hHnBQRyPkCqCJ5SMTkf1LZpzHw8UVzRq3p0T
 Zi65F5SJZseUOtCbt+leDL+dd7hWV64ULpBupHGR6j37PRSf2F2OoGmyc5MfUcb5Fnmt
 CadW8U87HJS6zrA+TX+EW8Iy47mYKl5E0OyLA3YA5GtJvADqvKwulzziIa4a21mH4lar
 pR9HAm+tVi3S4KZMly+u8IVDzF7aotI4k15ux2rW6bj3Ok5m/Cvy/pQSqrf/vqwll3rf
 M6b+NWwHiYHuIQUbxG6tfhKhjT7oawt4SLDThP4wXWrnUTrBHRbk6q/tqDFXJlWd5Fri
 T6xA==
X-Gm-Message-State: AOJu0Yzq//UK5NzkTxJ1eKAbfYzis3ZN3NVWBG9f4At7n7oMuEkjWz5k
 OBp+lryrxTnLOrHvuA3oQNVK/J1mOS4mLqpu/hepVQT/t9/IwjO9yvOGzvZBjq63ytAky1Yfayv
 W
X-Gm-Gg: ASbGnct1NpeZbAy7swg0dklSmyrKSCLfJf5CjxnvrBPxrTSH+j4x9xOjVQovTTCEry2
 QdfGt4fa4j/CltmjVCwJbt9VTNHpnkNzV+I2QxFewW81Vo98lL/dYOffAmSrF0NzPeeScso4HQi
 HoRWjy4YToKgrjJUtD97vl65mN46twdMhpcXMalVMKMC4iIq3rLk6cCk0x3LEM9MsBBZ65NzKBI
 VJPP8VSPN7glaaPGNqg+MeKfOroTsgaMHxsg4Qu7J4DUMBvpvCWlbBNTh+v01Io+CrkKcLSGGQN
 DS9bv7cnD50dvxeF35ieIS74zWHOBD+iVpZXg3bhhcEMl+eMtb5ZjWwE3qHIkWBNs9iOFM+bJeX
 mfkUdjTBUXELYpog1K+48
X-Google-Smtp-Source: AGHT+IHo0ewUI6A+tnlXRD/3wj/4ke/cA8EXulrqak80+xsax0WOUjE+1hGF8w7yfOScc1U+igQyNQ==
X-Received: by 2002:a17:903:990:b0:22e:485a:b45 with SMTP id
 d9443c01a7336-22fc918d07emr168690335ad.46.1746995758624; 
 Sun, 11 May 2025 13:35:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 14/24] target/m68k: Remove env argument to gen_load_mode
Date: Sun, 11 May 2025 13:35:36 -0700
Message-ID: <20250511203546.139788-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index cc37f7a192..c3cf1c9f91 100644
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


