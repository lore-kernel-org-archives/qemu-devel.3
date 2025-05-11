Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D7AC3ABCC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP1-00038T-VB; Sun, 11 May 2025 16:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOz-0002t2-0h
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOx-0006Lm-57
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22fa28c761dso26663785ad.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995758; x=1747600558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PscqTjzHZ6K3OgttLOrZJ3TLkWj4T6L/JjeMXtn1crA=;
 b=DpLBBLV7rpZSsE6eN8bMOJKZYSdtrp3YjJEkDRuSK6XK+IaGWA3G68md3ZPkO/6DBd
 LRXKx8tR1Pisp8N/ltgRqIDWr3kI7Ha1u3QfKuuQ9DgqF5vTPhjkKqgvCWyvSvXeNWuK
 gF+TO4269F+MgH503uIvuu8SwIsdl2vtt5g8D/dr34ZYhvT1+S+GgFxBEoKP0dZajQny
 i6eEldJpEOFm4r1/1NvbTS5CMeWDKCN5ycMlSZobpc+EBEUPFlLwUE/SHaW+Lo9ttsvo
 LGxKR59I4Z/TlyBJIrrPywOveopDhtx1UZQrwCzE4S1uZksoywzZ0yuDqtXVLesShCEG
 weow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995758; x=1747600558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PscqTjzHZ6K3OgttLOrZJ3TLkWj4T6L/JjeMXtn1crA=;
 b=q/me0pHzyJ5Zbl3AVHocy48qP3jwy8T5Iy7rLEQlzSZvqlrR+cOxtrw6oqc7VBjwa1
 d6Bscnjoq9DeAroRctC9NJPYFr8n2CWSBslhIOHotSbKcFQeuSOBVSn8bASWwqwptw0C
 uUTXGH3edOyl6I8YxUj5v3Drom3xS53kVyVmzaTwC5J7u6Q2K+o0w0IFaampu2xPpHxK
 9gIrqaxJWgTrYe0cSzEFEw1xTPsDllAFNoWfHwJZHlWZDzsWTpHuBTnZyFuW0w7Sn3X1
 O22EbuN32acNkSq4ZNrsx+OQSAFEsC40vacFAOReuswnucmiw92ZuVpF+XY3yak8+YK4
 dsng==
X-Gm-Message-State: AOJu0YzWgPJrGOIaoPWxk3FLyQopErmNkAVr0L5QjFEiwqj9DmqZhJyw
 /9kFKGiv+GO08SRx7slg9mT9lhhcEBvtgtLPSDPCqkpbNyVP8ZRnbUpldF2ANCqby3FEs1WMi68
 q
X-Gm-Gg: ASbGncsYGd+RiX+WClL0FzDkTZSqvfcyu1v0EWUj9cJY6OmgWSBJDki509boTERbH/y
 OjEQq9TeYo+bRNryEuhyfZZZ9+d3ausdfY6iMuzACU01WHZJD2CDsVDeZM2yF20DWQI80zT0VkH
 btnst54eiblFUogVN4aG55SQGGcHInAE/+mT2RZiPPXsvFvhVVua1sHiTUHIEU9BCAh3pKJEw/D
 edH/G4OoOT6/u9XKo6ugUPaYfqgILobelRQ/GeBGHj+L+6QT5lqnRcDZFQ9ephKnFkJ/YnLq4Hw
 FR7VSqb2kIWFL9beGa+DVHqblH/VcvIA69L6jFLYVwMXoWQ8KRetO30US5uEH7knobpWv84cW8i
 Cu66kOnrh6w==
X-Google-Smtp-Source: AGHT+IGLqMMPduiRCUOJKi3RSxucRDohXSBUe6Blsbn1igwjwPLOoG5Uo2WaSi5P4YVL9Fx9V0WjWQ==
X-Received: by 2002:a17:902:f705:b0:224:c76:5e56 with SMTP id
 d9443c01a7336-22fc8c7b512mr155473085ad.27.1746995757782; 
 Sun, 11 May 2025 13:35:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 13/24] target/m68k: Remove env argument to gen_lea_mode
Date: Sun, 11 May 2025 13:35:35 -0700
Message-ID: <20250511203546.139788-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the env pointer in DisasContext.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 1a589874db..cc37f7a192 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -694,8 +694,7 @@ static int addr_inc_size(DisasContext *s, int reg0, int opsize)
 /*
  * Generate code for an "effective address".
  */
-static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
-                         int mode, int reg0, int opsize)
+static TCGv gen_lea_mode(DisasContext *s, int mode, int reg0, int opsize)
 {
     TCGv reg, addr, tmp;
     uint16_t ext;
@@ -733,7 +732,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
     case 5: /* Indirect displacement.  */
         reg = get_areg(s, reg0);
         addr = tcg_temp_new();
-        ext = read_im16(env, s);
+        ext = read_im16(s->env, s);
         tcg_gen_addi_i32(addr, reg, (int16_t)ext);
         return addr;
     case 6: /* Indirect index + displacement.  */
@@ -742,14 +741,14 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
     case 7: /* Other */
         switch (reg0) {
         case 0: /* Absolute short.  */
-            offset = (int16_t)read_im16(env, s);
+            offset = (int16_t)read_im16(s->env, s);
             break;
         case 1: /* Absolute long.  */
-            offset = read_im32(env, s);
+            offset = read_im32(s->env, s);
             break;
         case 2: /* pc displacement  */
             offset = s->pc;
-            offset += (int16_t)read_im16(env, s);
+            offset += (int16_t)read_im16(s->env, s);
             break;
         case 3: /* pc index+displacement.  */
             return gen_lea_indexed(s, NULL_QREG);
@@ -769,7 +768,7 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_lea_mode(env, s, mode, reg0, opsize);
+    return gen_lea_mode(s, mode, reg0, opsize);
 }
 
 /*
@@ -827,7 +826,7 @@ static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
     case 4: /* Indirect predecrememnt.  */
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
             ret = addr;
             addr = NULL;
@@ -870,7 +869,7 @@ static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
     case 6: /* Indirect index + displacement.  */
     case 7: /* Other */
         if (!addr) {
-            addr = gen_lea_mode(env, s, mode, reg0, opsize);
+            addr = gen_lea_mode(s, mode, reg0, opsize);
             if (IS_NULL_QREG(addr)) {
                 return false;
             }
@@ -1110,7 +1109,7 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
     case 4: /* Indirect predecrememnt.  */
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
             return -1;
         }
@@ -1931,7 +1930,7 @@ DISAS_INSN(movem)
         break;
 
     default:
-        tmp = gen_lea_mode(env, s, mode, reg0, opsize);
+        tmp = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(tmp)) {
             goto do_addr_fault;
         }
@@ -2673,7 +2672,7 @@ DISAS_INSN(tas)
     } else {
         TCGv src1, addr;
 
-        addr = gen_lea_mode(env, s, mode, reg0, OS_BYTE);
+        addr = gen_lea_mode(s, mode, reg0, OS_BYTE);
         if (IS_NULL_QREG(addr)) {
             gen_addr_fault(s);
             return;
-- 
2.43.0


