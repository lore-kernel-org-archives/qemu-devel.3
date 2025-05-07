Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6CBC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm52-0006E9-AB; Wed, 07 May 2025 17:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4p-0006Am-Ag
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4n-0006EN-KP
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:15 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso332471b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652392; x=1747257192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBax0cC3ZufDDhGNQHmjQs1Q+pCQRm4ULGyIRNgSwMs=;
 b=px+oLuFZvozpcRD1Md7w+LAgyzchvfnPYO8Kfqvo+MBPGmJrdhvffegO+olAf1B8TD
 Ht/0pbyYPOavYcOg+O/h+Uk2O4aMf4v7oUz5AQTdTHO77mgr6riEa+IirMFs/6bAe444
 +tc/kJJ3iVABPlvySlVKyalumAM+PT8/KaMIx4H3oJz96Zb1oDjmMSH6toAhzSM+7X5y
 lIMpPgVpiJ0t/Y/1ScONZ8iGC6DfqYok3wEM/TipYA3X25fQ07xti0cNNyf5XjSl+0Gs
 SS1eTBrvpLSodp7DBsgT3KTsO6pnaOiYlOHXhPlBHSYGl0kHCXkUB20CUPuuleF6Glwp
 5i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652392; x=1747257192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBax0cC3ZufDDhGNQHmjQs1Q+pCQRm4ULGyIRNgSwMs=;
 b=SLgopLgIU50KZxSlPPqo62pwGbMyjfk4Teb0ebTmUc4eky0FM0E7RexNB+hNeN+afb
 5rxhG5p8ixMJSwrdLgCoed/z/ulybOgRba5xZpxUx+mrvlZWq5oAC3zk1cfbaPy6ks1e
 xQD8rpFda+coNjPTdAgEG9OvD1wox8p22aT+j5V1YowxzX4ESWkrWbKS2oHZR/jzScx1
 mmoxlyjtj9XJcjr5pmm85gzHMH7FmcG2xkMqh2oEXZOYbSCX7lYj40XFCYUK19M2IqGW
 1YN2+l0iGKsmxJN5oMo27jCOum14F74i+6KDVzIuf8VkLP07JNs4xhxpVIEx33y4Kx7N
 dpNA==
X-Gm-Message-State: AOJu0YymyX6XmrxzFFwlnGMqfOR4Hmy7yKLAmi7mnn6C35pCtz4Jrp1f
 qsiROYrdDhYcHvufJuRW8dLTh8e6Ro8fv7ZEMnmXsdt/rJZhlhHrm8ipge52PXYAjiwzUJNpgvq
 +
X-Gm-Gg: ASbGncuXpe07DWPu2zJ0RD/2ePC8GYhYaSc4zjboiW8a5XMYokwn1KrkIyupSq/Xf8d
 TbUhEpMa1aBa7yImATPyZnneUZWNdMd1WQBmzbaxSynsZImRLyNmvxf2eD+iFL+82BJJjrIlOUS
 gEVBpdZJWLQ+Kj+YYvvDlhcffrpWtzfayxQ8w9+1cqNzBjZfXv3A5JGe1wU7RaN3tIzyB8CIAdZ
 EL+F5WEeGuuiV3PV21IW9Zo+iP85s98XX4pGJyoi7ejFzIEsOcFXYZTAnwpFoLgfsVKQjF2v7RY
 SzvQyGzMmnNjorxJMgiaNfG+7K1jy5l+8uIYXK+a/17ZrdEgnVjIOlcpLjF+J8KdMuJJOYD9w2k
 =
X-Google-Smtp-Source: AGHT+IEyd2W3c6Xy6e70VabgMD4ha3EYrdsLco7KeqYCoZIpEFYHjo9/Vmux86JW1pBjPqranMcIQg==
X-Received: by 2002:a05:6a00:4296:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-740a92f97bfmr1403215b3a.3.1746652392154; 
 Wed, 07 May 2025 14:13:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 12/24] target/m68k: Remove env argument to gen_lea_indexed
Date: Wed,  7 May 2025 14:12:47 -0700
Message-ID: <20250507211300.9735-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 target/m68k/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0abdb1673a..532b050ffa 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -392,7 +392,7 @@ static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
  * Handle a base + index + displacement effective address.
  * A NULL_QREG base means pc-relative.
  */
-static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
+static TCGv gen_lea_indexed(DisasContext *s, TCGv base)
 {
     uint32_t offset;
     uint16_t ext;
@@ -401,7 +401,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
     uint32_t bd, od;
 
     offset = s->pc;
-    ext = read_im16(env, s);
+    ext = read_im16(s->env, s);
 
     if ((ext & 0x800) == 0 && !m68k_feature(s->env, M68K_FEATURE_WORD_INDEX))
         return NULL_QREG;
@@ -419,9 +419,9 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         if ((ext & 0x30) > 0x10) {
             /* base displacement */
             if ((ext & 0x30) == 0x20) {
-                bd = (int16_t)read_im16(env, s);
+                bd = (int16_t)read_im16(s->env, s);
             } else {
-                bd = read_im32(env, s);
+                bd = read_im32(s->env, s);
             }
         } else {
             bd = 0;
@@ -467,9 +467,9 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
             if ((ext & 3) > 1) {
                 /* outer displacement */
                 if ((ext & 3) == 2) {
-                    od = (int16_t)read_im16(env, s);
+                    od = (int16_t)read_im16(s->env, s);
                 } else {
-                    od = read_im32(env, s);
+                    od = read_im32(s->env, s);
                 }
             } else {
                 od = 0;
@@ -738,7 +738,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         return addr;
     case 6: /* Indirect index + displacement.  */
         reg = get_areg(s, reg0);
-        return gen_lea_indexed(env, s, reg);
+        return gen_lea_indexed(s, reg);
     case 7: /* Other */
         switch (reg0) {
         case 0: /* Absolute short.  */
@@ -752,7 +752,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
             offset += (int16_t)read_im16(env, s);
             break;
         case 3: /* pc index+displacement.  */
-            return gen_lea_indexed(env, s, NULL_QREG);
+            return gen_lea_indexed(s, NULL_QREG);
         case 4: /* Immediate.  */
         default:
             return NULL_QREG;
-- 
2.43.0


