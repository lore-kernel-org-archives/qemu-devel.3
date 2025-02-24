Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C929EC021BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3C-00076O-QU; Mon, 24 Feb 2025 12:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2s-0006zS-GX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:07 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2q-0005aK-I4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:06 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-221050f3f00so105831135ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417303; x=1741022103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tg2zteOZpC9Wey89dCxgtFEoBQa8KJNvVhInvL38LKQ=;
 b=JCcb3gMIuosH2lgPGpolNZjWFUEu/kV6sc6sM5+6noqLb54in4SD+YEqvD2HYlzaHh
 2DAh4UOcJYn15JD0PBRZYWqlLCxf9o6GGVgS7IrC7rVcJuyHTB4p9HuTUWzDYRg8rgab
 Dok4zGs7PE+VLrZY7r12zyBrSSKZADAA7DmF3VWBp/iy+e6K0/7EKZLK0+TRkfuSsMmA
 Ir7LKdtvybEj19OWvBlFJwp7pGKaI7Zr20NwFmD9TD/fjJshtG8VuNUs1iru8Qq4APLO
 a3LJErQbmHMGLKDUow88aNfjPm98HZnQKNdpshORD7oArBLWC5lWkfEAbFe5eHjvNVgk
 Uh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417303; x=1741022103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tg2zteOZpC9Wey89dCxgtFEoBQa8KJNvVhInvL38LKQ=;
 b=CPs4e4J+K9W6dEVwRqELe8H8OCtdy7fGvcbSmOO9EAu7VX4B0M94BchXalk9YUzlFB
 YfXcGtu41y+CMSFLo0Deoii7fZojYWsVjvSaF2U5/t2Scu+ADX5ycWB01cUaF0m+i3XS
 XyMFV6J5XzNeJ6AsBKt5AiL7RBumBUi5BzEbMQOo+jF8BC/0bZkdo28Ya48rjyrFX6c8
 WQRAQRKsh4J2HVx2gQ5W23+jSwcmlOzctaBIAUjbdBLvGYClMPMkahPCagZdTFT5fK0N
 CodIzl/3GquCCOekM9hjUAHB8MG2sMUldoSb6/gzd+murn0nlQtNev5KGwaeXP4gUEwQ
 Fcmw==
X-Gm-Message-State: AOJu0YySmSnrEx3KjSiEDlq2ERk2TifIB7LiVtkp6fXgnFU8z5woJyNC
 O0e3ma0uM/lbvisiXt6QMDn/s6BfgvxqulXCbP7md9eR1MLSJGlm8a+FKVArQ6944x46mfHgy0d
 9
X-Gm-Gg: ASbGncvLNWBzEFBfSTpBqiZISZBVXJpk6Al2jWIVuUl5lm+6LMfzPeV5QgmqTkKNZoe
 +UeUSyoQw98XznwCdKVcE3BFhPx4ZwwDTsiaifSeSLuCmV8xpGqrAGv6MwgyCnV/CbfZrh3pCT6
 merziV533gVxofsiRq63IovEnBO81MZhmpe37zjwlXuxOVjmWnNHyxQlB1OEQMiANWnF/TQ/X0y
 5lziIL08ujhiNF9Vos89Rw+nJKDFYrNukUda5jPNy0dJHPhB2qmiUyT4vW5DOBKxnoSrm6wjKyS
 7333MNhkrte1bLbjSO3nypijIomUP6MKtmI=
X-Google-Smtp-Source: AGHT+IHy1asuAui/AE0XVlhWzSPfTjDeUMSPkZUxgfCzglqeOk1IatF45jtQXVEM1zqcr1KMHzuyvQ==
X-Received: by 2002:aa7:888e:0:b0:732:5a8f:f51b with SMTP id
 d2e1a72fcca58-734790c6cc2mr14666b3a.8.1740417302829; 
 Mon, 24 Feb 2025 09:15:02 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 12/24] target/m68k: Remove env argument to gen_lea_indexed
Date: Mon, 24 Feb 2025 09:14:32 -0800
Message-ID: <20250224171444.440135-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
index d6f848c48d..0aa0721778 100644
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


