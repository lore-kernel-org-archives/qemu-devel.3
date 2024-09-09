Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB18AECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC2-000568-GE; Mon, 09 Sep 2024 13:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBt-0004Wg-19
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBr-00062X-BJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2053525bd90so39040705ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902918; x=1726507718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpkHGNCwIxJL+Ub/QiAiuLzqpRZVFPeNdY4siUkENhs=;
 b=j4hb8TAi9+bJigYJk00fNg4f6+y4T3Fh5UPrc20BiT3KqcHhGKGDeZg5EidgKyiuVZ
 JmSYJHH+lBx+llt3BtvE72VMHjUywj0i21IGy4NhGMrMqVJJefChswvqGSEzfo7h4lGU
 MZsFCvT1aLKrUTz6596YkOZdzK/by8b4E0PChwCL3KHRbFTiEauK09nFsmigLxCvJIVG
 xRtUB714vCeGG/ZMIMlRYbM/IIIN0qvQJlqvwkqz42pyQ3dxfg0Y/7Vm0PdkHPIkC+/P
 99gb2xnGQ4+D0Rz97QKHX99B6Vt70vcnNwp/+hRCWxH2BiPFH5dbeNOqrhkdNHCgeuI7
 OddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902918; x=1726507718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpkHGNCwIxJL+Ub/QiAiuLzqpRZVFPeNdY4siUkENhs=;
 b=Yasq7uoY8QJnMGR6xKvbKwQDQhNH6RwWgPiqUNMs2MClUQ1IyWKXuamrjhBag8EbDe
 uaXFN5ZkdNPjg8snMxpR2sDtWTCc/AqGcSVWCyCp8DLs3rGtRmrlufWkOXWzkCUoXm0r
 S/5RrnpgVY/t07amKBZWtgwmhiFeTiBKHFxVyTMbQOyQfPSGjohHJnozR4UPwO//4IS4
 xqo/aXczZ3HRMyFkwIwXss4fh/ssorozHath8LCQnTqMwtvGVUTQahP1bL64L8WQsdmg
 mCQPERDf6SCL1lI4ry5Eh/Ov4Uuiian8xkyTeyKHpos1uCTa0//xME9MAI0pk1hJl1pr
 yZHg==
X-Gm-Message-State: AOJu0Yy7pfURkexHGaOJLen0sQ1U7t4HhnUO4EmYDYPpvAXGRROQUEMo
 TJ4giU74OnPRYjh0ORFNuDgo6yJitqy6LLZprJAHqTYBzyKrQ212o5Eiphw1Da77K+DP6hzS866
 C
X-Google-Smtp-Source: AGHT+IG6z4i3ZswPz9L/LasGNmG98wVEzGJZPUvqPvqotrUqrvJIdIjBExWA5qeH+XP+9Rpisi2uOQ==
X-Received: by 2002:a17:902:f550:b0:206:b250:1e1 with SMTP id
 d9443c01a7336-206f05f6425mr143626225ad.45.1725902918039; 
 Mon, 09 Sep 2024 10:28:38 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 14/26] target/m68k: Remove env argument to gen_lea_indexed
Date: Mon,  9 Sep 2024 10:28:11 -0700
Message-ID: <20240909172823.649837-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/m68k/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 2c0852ac3a..78a9358416 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -391,7 +391,7 @@ static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
  * Handle a base + index + displacement effective address.
  * A NULL_QREG base means pc-relative.
  */
-static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
+static TCGv gen_lea_indexed(DisasContext *s, TCGv base)
 {
     uint32_t offset;
     uint16_t ext;
@@ -400,7 +400,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
     uint32_t bd, od;
 
     offset = s->pc;
-    ext = read_im16(env, s);
+    ext = read_im16(s->env, s);
 
     if ((ext & 0x800) == 0 && !m68k_feature(s->env, M68K_FEATURE_WORD_INDEX))
         return NULL_QREG;
@@ -418,9 +418,9 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
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
@@ -466,9 +466,9 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
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
@@ -737,7 +737,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         return addr;
     case 6: /* Indirect index + displacement.  */
         reg = get_areg(s, reg0);
-        return gen_lea_indexed(env, s, reg);
+        return gen_lea_indexed(s, reg);
     case 7: /* Other */
         switch (reg0) {
         case 0: /* Absolute short.  */
@@ -751,7 +751,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
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


