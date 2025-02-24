Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451D2C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3F-00077y-BF; Mon, 24 Feb 2025 12:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2t-00070e-PH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:09 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2r-0005gz-KX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:07 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220d398bea9so74156315ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417304; x=1741022104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1wokWjEQnWGkNFvw6UwauoupCQ0IGRtX5SJLE3+d9Q=;
 b=XjMuJw9pmj4DGjR1L7uPs6Vp2j4JfRXmZE92hlOgH5gridIN1LxD0gPIP8BkUcxXQT
 Jc9ozhWn4ypOjwZzTMsj08wFfP04rO1bWxjtKIT9M7kRm3B6u369rQ0blZe26E8VucBY
 XkrXSAPUqjRFH2f5xJVRUhC/FkpjTR3R+aCEgxpO+xlmTRcAE2hUmIRZweYGq/SI+t84
 n2l9cPhhl+s7MRrxsmIB0IBJwn+nmULsgwN2lCg8yNy/C8XT/MZlgq9oHqh9RVR9709J
 vljAoMAfmurKtBGLnLNO0Thl8wG+jqvz/UuzbWq72OUhn4Ihk0+sCBjfmo4h81wS+w7z
 7RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417304; x=1741022104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1wokWjEQnWGkNFvw6UwauoupCQ0IGRtX5SJLE3+d9Q=;
 b=G1IVCojsCzj3xyr83tWoX/AZdse+yebrEsZGu55KZR815cATYl/iRSPQvHL5R9AeYJ
 twM5L01tAqz/Xfe9HeS9g0+19kz/YznIkiNzpqUQDxOO6J9yevjQzzZhd4bfmt0Bo9fF
 mgo7fZ2o5DPch3krr13XFlmnA74FyUS5NOqN50QlFyalSNTJIUJQ8V+NsCInowfaWKxn
 q3KjvqQDTSrCyhFoXDmhLDaSvKJM+fS8KIMVvCKlN6nApcHNkdC4lvNrz7malhpqo3/W
 Qj7KVA/Sn1NtoQc28HlY6zZ+7by+GNZ+huHFnGJxbvB2mon2DrmnzLDyG+ibvWHqAfgD
 /YkA==
X-Gm-Message-State: AOJu0YzlJi8flxrS6xiKFbx4Gs/f492buK0eLH2gldK/nLDlJjGSeMzm
 slQCdX+VHgKZfZy8hHN+IREHkMd3RSSWqaiVgAFn7GdSiYBOAZQe7v70NEdQPyC3FGr7q70T05p
 W
X-Gm-Gg: ASbGnct6kpv67UHIQKiUG96wzDtnZ+tmLNxYI6LLI2VjCMX67IxRJL0W2lk5xoQsX1p
 mnvg9m8ZmxuAgNXYiFoZM8jMfwCIIs3dFC4JOpjki3xASOZj5AscQVoL4UsuVXsnYiGDdyKuEv2
 i2gL8DMvvdz58MVlkuWbgODQydsTNvkzaPx7tD3zTU8/uDVY7y5K7v72kA7iZpYPr3uIZtxJYXE
 4rYdwDccPEgSvMLaq8ivBOsSRodZ2NadF8QYVHHkIzI7L0Thphk5yFd0f09aVWUirvMQuVkVzls
 iVTiL7iy3AZuTEx9HMltmlI5dE8tHPxpMt8=
X-Google-Smtp-Source: AGHT+IEbkMX/LdioLvXT2jUIwCO5ZVGohbE4xkZ1GuZrkjQVSKkCyV8MffUbHBIA/Me891eRoMZANA==
X-Received: by 2002:a05:6a00:2441:b0:732:a24:734b with SMTP id
 d2e1a72fcca58-73426d7271emr21724552b3a.15.1740417304070; 
 Mon, 24 Feb 2025 09:15:04 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 13/24] target/m68k: Remove env argument to gen_lea_mode
Date: Mon, 24 Feb 2025 09:14:33 -0800
Message-ID: <20250224171444.440135-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index 0aa0721778..73189d1da4 100644
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


