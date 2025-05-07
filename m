Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB807C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm51-0006DA-EP; Wed, 07 May 2025 17:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4r-0006Bm-5i
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4o-0006ET-LX
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so337620b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652393; x=1747257193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V28X/B7HKspQXCAbFSu75wLrZk2W+uEoRdz2oWfmGic=;
 b=SNgoFLk4Lj7X/Ad7ET+u1PQvinr/BwKp9XzuxEegss4f9+TGQJKh/wGaQWevU3z4z8
 Ser+EFtrl8fr36T41DIRYFf6RlfjVFJ7vXGVv2QtZqGUqozj15bHTBfohIvc16LEqSyG
 y/uKpuoqCDOw7IPsnumXAoFBx45mYVP8WJD24qk37s1+hhljWzi5FzUfIXtJL+sJVTVt
 OU7TZ3jyCVGpjntdHVlvDyg0C5MoKUGhExeIsKmyVf7+/XAX8a9wpKpyss7hW4wFH1ao
 +ca97yZP0XFM7eHegFCtbFo6YN5eezh3KegJNAGbbARwPbhEp5JOa1xekhKoFKK4300B
 nJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652393; x=1747257193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V28X/B7HKspQXCAbFSu75wLrZk2W+uEoRdz2oWfmGic=;
 b=Aqsia7IcaljVmAbsLIg8QRqiHpfX9H8fepiON4UMpjIVY4Hll7snRflxwsDzY0/yro
 klsxdyoGbU5P8EHxqSGrqblnDvipo/WJEaWBKVsPomMZraRd4oBra+tHcQ2Wz8dzx+gM
 NXHdqIkglkx0Fu7u/bybwSjYsAznuP4yQobLJ4xX7HuV1k5Y4tshF2dZ2amsGuRObUOb
 mg38mAR3lrx3hCRgrHKBGinwmW/hj3natX2k27pEObiMFNfjYjjkJTbdTxsfjfVa24bD
 K7pH/l8/gptN+CkgGOI2PHKKkYyLLlp8BomWSAmO/Y7+8sv9kLud+BPAbSIGS9MSBt5S
 GZ3A==
X-Gm-Message-State: AOJu0YybD4kEqrzxtXb1h6qIfd/qbP1AZh+e5HWUBkgPZOgO3g/cyL8M
 9zKd0mHUWaRThT4+jmi+yMnTi9JulqgIJ6cDeLDLp/23OmfRckkjLSU3V2SLrGA5P5teLzcgU9r
 7
X-Gm-Gg: ASbGnct6pyEHJFkZ8uKe6VqRVUxVE/Jpacz8Pgs2N1M/W8QhyzCXskC+61+M0CgvkcG
 m7B2JX6swo8A4IZFtbHLvno/DsadMAMOpOKaoaSkKj/5tIyVhI5vo8JJ7MZ+Q8bndIfKCUGT7nV
 Vxw0xFrTOWv1bjFOrHe0+CZa5yJAT0wtKwRKqxODbP4wP07hYiNcnc9nehVtu100AvnBN9zePgo
 P8AOBjPjuD6x+TLDEhe315dnsgNZsrxT4J+EgCbKvn1TzALmKjk81m53odG7gyqCIxVD3UF1HmG
 4Dd75vFJmABeTueMqBKmuzxYMtYgRrCoNTwmRuLj1jZXOwEKeG7kXPS4wuKtoRVTXUQZ2TKCe+0
 =
X-Google-Smtp-Source: AGHT+IGJLMjr8QAue3nQP39yhZYUX2EFWfJ3/Xvb6FBTEFNRUxSXofghUMp/Kuz61fMPvm98b8CjNg==
X-Received: by 2002:a05:6a00:e8b:b0:736:6ecd:8e34 with SMTP id
 d2e1a72fcca58-7409cff5cb7mr7155216b3a.18.1746652393020; 
 Wed, 07 May 2025 14:13:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 13/24] target/m68k: Remove env argument to gen_lea_mode
Date: Wed,  7 May 2025 14:12:48 -0700
Message-ID: <20250507211300.9735-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 532b050ffa..e0482bdbec 100644
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


