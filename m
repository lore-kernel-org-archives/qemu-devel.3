Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4EFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP1-00034p-Dc; Sun, 11 May 2025 16:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOy-0002pX-8t
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOw-0006LW-Cg
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22fcf9cf3c2so22769065ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995757; x=1747600557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5FWppD/cbhMUZHBjw12HnH7OS5qQsdQuaNDHpmu3f4=;
 b=QYc2YbXQb/QsVR3QO2FREW/kUELbO0fVcpjpU4t/hGAO2wkahbPB/rFEJ5U0UwmMlX
 XGDZVdSXGx+48LNaoK2K/MZKy8rFX9FZPey0IhXDdBY7AgSNe9PRGw2D62t2PoZ9N30S
 RXPJ9bHJr4teNMqI8exQOAo33FUa2/sAPbnjw7yXF6QDNC2SMhfIk9Q0B8UlRABxUs+W
 hdimxTxga2uJ9N4NOI8duVRwdoWq1jNd2H/rJHiDMqP4xkeGol0mrn9zBsyjLQFzoy1y
 Awnv15+/Ybseb52OueDG7RNC2GJkAN4Ed3SQcVmP6GB4RvjfxfXe1p52pQNNaegu4fVK
 sTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995757; x=1747600557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5FWppD/cbhMUZHBjw12HnH7OS5qQsdQuaNDHpmu3f4=;
 b=mzSeAhMJKwFeHdr7cujQBb1bwEc9D65I/H9MrM+OAZ+DwqZ8dTRF3VbgguaQ6QROso
 NiRBw0fYVPo2i41la3/ZZPOhe1YJ3zLhzOnGDKTAylethDf5MnYepqDfXreCYnq/czBH
 ENrO4ufIk57rNqHxf+Mtm3eRY8mG/LjZEGSsvBfdXn4zamp//l93Ioa9MwBt1HV48xwo
 YvthjOIiZ4N6Q7ts3GY3Skol0N67xSOZXckz1yz/rOCA9j0UTAMYsBYXq9ey3L9Ph/kk
 6P+2SYujj6u76Ioug4py+I+yDLUo3iXriAs/nTyRee1mgNZSGbfnss/xYsFS9fAOp75l
 b+lA==
X-Gm-Message-State: AOJu0Ywc3e4wd+Ltsnui6hJUgxyKCCIOWm5/FLRCfKVBqYkf6wwYPFF7
 iOQweSFBGl63nskUz6WEuwixIV2ylAXPC3haIITCm8mlOw7QqQVfupOWSS4Gnl6D2pRWF6yT+02
 O
X-Gm-Gg: ASbGncuHuoOlDiydGQXnJhtB0yzfhH7s3gzqCVV9TIwCuSBWQ0epa3zoX8fi85oqs4N
 I6Prtek4dzuGtQGN3PgmCgYqBVtNORQIcBsxsUSRefyaSOo400r5CIYIjqVg6lleRNKE1gh54Li
 OzVdoMJ4d19CzX2WcA/5FyEcBSUtMOGZpozZtLj+Lp36osQlAsEiFXbEaS3Kk9wCIBuxK+3fYM7
 YAkY1BvyzVzDnaoXIUVtwJclCVQvqYuatKiIpjwQA/aDTYWn4l/PAEVhph6OveKVJyjECLo6sHK
 JZlFmsd7sOPT1aM9mpHWJ2pBnPnxrYELz4AqeLptdbav6AsLcl2+ie/b4J7lklfZePUadUxBUSc
 y9+zTnILTfA==
X-Google-Smtp-Source: AGHT+IHYMqEo8lbATWn/NokwABGNZ869e/OLnQVU7w8Y9NzF2T6lIkIQ8D7BjMrd7RRHFuIn2yXZhA==
X-Received: by 2002:a17:902:f70a:b0:227:e709:f71 with SMTP id
 d9443c01a7336-22fc8c8ccf0mr166381225ad.29.1746995757149; 
 Sun, 11 May 2025 13:35:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 12/24] target/m68k: Remove env argument to gen_lea_indexed
Date: Sun, 11 May 2025 13:35:34 -0700
Message-ID: <20250511203546.139788-13-richard.henderson@linaro.org>
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
 target/m68k/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c16925670d..1a589874db 100644
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


