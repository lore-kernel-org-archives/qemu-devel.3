Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F23CC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3J-0007CL-3P; Mon, 24 Feb 2025 12:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc34-000754-FE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:18 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc30-0005mw-AV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:16 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-221206dbd7eso96056005ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417310; x=1741022110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/fuvX0Geq5HX68xaNi0dQ8A11vAQj55SFQvqBIm3QM=;
 b=X4EA1BJmdTjsCCe+uvhxge3U/augpFWHHYCIwBHOoMYMh46R2Tqk1hwjvH0PvvVO7e
 iBOlesrv6U7EEumSAq9xBVUrUt6gXY0xtD3sPUSy9+OKwRUKIbQ9bd0BFF5C9+zRtl3x
 wH4OgKY7jMiqnOxpFiRIiumzPbheKVvovQJ+yDK3BNAAenKprroBFi9LHl0pu154kh0U
 m6JKhsao0tc7mghn5q05LNVOlyLR32ke0fPikFFoFAmtO4o/ttYRbzGYwm/0CG+YHkBE
 OsVtLQds3h8XX2iyyR1f2h3b1c1UDmujP6Q02rM5sl1zdczicE9OgoF8H7IPRltru7ea
 LurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417310; x=1741022110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/fuvX0Geq5HX68xaNi0dQ8A11vAQj55SFQvqBIm3QM=;
 b=U2ODFpg/jAro/Mf4m5SfLidUbxceJYJyVAmXQ7929BUT+ww5PfBNvFpnqtrDRt9RFC
 iSzk7+rMPEBAAaZna7NDektZvkLFp1Th2RPqR2EdTotgH1QGJ4L8owf3XDovzsfIDWtg
 TZT2RFVYogZpTVWkIEZGVk+q6XmGiJeqEL2qz67gNSbKrciUJ6TDXqkEmkpvms5RGb8V
 RirUOvlo7V1SlJ8Aqgu4pmKU2Goo3LsDX7M0v+pz5EX9k4FE3TguMIBlrpZEI2PwiiZ4
 WteaBDbD6X98F9PKf3CAwvw59swE77GBz9n3CLMTI6A9IVZiCQ4TmelIhA3uH/ntwaxS
 w/bw==
X-Gm-Message-State: AOJu0Yy55mzUhJy5TR01N0ND7rWeip9p1oLRER9cI0hT8mKdqWjbd8wH
 5Hseo03HVD/+MAsQPYudyY7lTywvq9A56i/g/JgGes4Xpana6OyUgEImJDHY1cPVXINQVsC3MPN
 t
X-Gm-Gg: ASbGncs7qz1i1SAJ4GlkwQPXbdSTAUNjZTZ+Wcy6IF637thh1XlUnaONTjCDywOfZ4R
 KRnptmSQjwtWLFalZAMPdxvzcAQUlJfCDTkHrQijeUo0Z01jRyAVktt7Pua0+a51nnltbgOqrBO
 FtEhwqBNyHRAV2zcVPu4ptl9Tqcmc7hXtXOVW5FrEoXrgKvoWU6Ch3eu+1jNN+ORj64LPlu6Y8W
 rHcFdZFxxgHApnP9QXjCdD25xJelwsDzapArGtpHqrYVJqYz6m/HsSuqV8Qhm2pgsX7X+ddgHKW
 IGAEjhRNg8Rx5LZMsUdq94taLQLyor7Opys=
X-Google-Smtp-Source: AGHT+IEIdDfZBU1WSCR7pEM/kW5ym1qi2RH/NqztR50Pv/Ns6IB2jRTrb3zosufkD2wc/JWUVQw2yg==
X-Received: by 2002:a05:6a00:21cc:b0:730:794e:7ad6 with SMTP id
 d2e1a72fcca58-73426ce84d6mr22330132b3a.14.1740417310522; 
 Mon, 24 Feb 2025 09:15:10 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 18/24] target/m68k: Move gen_addr_fault into gen_{load,
 store}_mode_fp
Date: Mon, 24 Feb 2025 09:14:38 -0800
Message-ID: <20250224171444.440135-19-richard.henderson@linaro.org>
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

Move the exception to be raised into the helpers.
This in preparation for raising other exceptions,
and still wanting to return failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 78d9f24970..69e1118aa1 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1024,6 +1024,7 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
         return true;
 
     case 1: /* Address register direct.  */
+        gen_addr_fault(s);
         return false;
 
     case 7: /* Other */
@@ -1080,6 +1081,7 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
     case 6: /* Indirect index + displacement.  */
         addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
+            gen_addr_fault(s);
             return false;
         }
         gen_load_fp(s, opsize, addr, fp, index);
@@ -1113,6 +1115,7 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
         return true;
 
     case 1: /* Address register direct.  */
+        gen_addr_fault(s);
         return false;
 
     case 2: /* Indirect register */
@@ -1123,6 +1126,7 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
     case 7: /* Other */
         addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
+            gen_addr_fault(s);
             return false;
         }
         gen_store_fp(s, opsize, addr, fp, index);
@@ -4887,10 +4891,9 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (!gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
-            gen_addr_fault(s);
+        if (gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
+            gen_helper_ftst(tcg_env, cpu_src);
         }
-        gen_helper_ftst(tcg_env, cpu_src);
         return;
     case 4: /* fmove to control register.  */
     case 5: /* fmove from control register.  */
@@ -4909,7 +4912,6 @@ DISAS_INSN(fpu)
         opsize = ext_opsize(ext, 10);
         cpu_src = gen_fp_result_ptr();
         if (!gen_load_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
-            gen_addr_fault(s);
             return;
         }
     } else {
-- 
2.43.0


