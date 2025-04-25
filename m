Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ACCC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzL-000077-Oh; Fri, 25 Apr 2025 11:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzC-00005K-94
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kz8-0003W0-1L
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso14449885e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594940; x=1746199740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdo7Xbgn21HSVu7ZHUjvfQORqZjCBRL3kE4FdFeU+do=;
 b=LT7UY9bvP3P4ggBczaNNlywrZsIj9XcadshZDStVE1s9YxKaV+uiIRsuuMdHDfnsBF
 neCY79ZHlbkb3EO6IzQMmc8+9CN9UbawX3yL+Zm+xHq3g9+8UGG748WSolk9CaZ9aDDM
 dLG2oJhxhPfAY5y0O/i/jWvlx7GArvHfxMxKwX9HR5RPrwL8r9PV++OVhfaR+P1TY6PM
 ePzrezklKVuLtvXydurDeFwog8ih2D6bC1UNntWKueMnUi87DYC6p3rDskutoi3qWOni
 92vmo+i0ldRjNu+UXwMCCVnkxNTRD9tEyeVX9XIgQreYx0n86LQn250LX3w1EZBy7ugJ
 jITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594940; x=1746199740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdo7Xbgn21HSVu7ZHUjvfQORqZjCBRL3kE4FdFeU+do=;
 b=XhVnwH286A2z4yWIvMxx3/xBmCJpjzLMvhv8J9fieStDTODzQKcS1aoYeikQPkcrEH
 TyVQnEznRlqm1nmJ24YaSQgaCjk3821L8M8xddzMJTdWwbVxzTeO5VusSeB+juK9qMSk
 LaWA/5zOo7GrRdcGU2BPxbHknUaaOQHT1m7u8vZaWsBXzzFWe2sRMEE9XRzqSpjsDo5t
 TPra5npyunsZRarY3qPNql4kNYAGYDd2IZWDwT75clLOURpLIJEYBwY8m8aNa1EPLU/p
 h/1T0VCjQizuIjoQwGwH1muAss8ruvuI0TFh6MVKGWqAFio4eGuceMn2lABRX2j0H7dY
 Xj/g==
X-Gm-Message-State: AOJu0YxJy3jymIXyJ+Gy1nZ+bObrX80cs8CScBuifUeyoE7DIo+wqFQU
 a6uJ8ht3lvz6L6MhBuyM/LlTIPF4Oqbhvj4KUT/WSPszCxKZJktHOOvt7A7HzzlqQjMg6acn/Si
 x
X-Gm-Gg: ASbGncvyWyPhnw64BRJUs7yrEi/zZnWdoEMRIKiI4tESly3YEHFNxdOLHcuy/V+AuLl
 v+L1fI0x6FKJnKlx5QmfsewiRN4ogsXUHFbSWOz2/nuqbT43vYnAyLxHgK4gmY+Y8U9NmhE8hhf
 9rNwZ43+3KWo4D9q3M9DuQKQGtT3FIMGxEKG89RvFzXHVy19WoA6p859Yl4Jsuc1rXP3HLvSPNM
 j1hW8AcubqH+d9I7jpp03f2ZH7DI+d5hQ40pe7jo49PlMyIukJ1/RoM5Yuso2PhxVK3ZUwgsQt8
 RIuECZqGLAa5uhM6VS3VgAxfKZfRIoSHUiW0x0kdzeJmrlG64/yM8uzt74HYtzdwHQdAmJXg60d
 I4lwwyjinJh6qADw=
X-Google-Smtp-Source: AGHT+IHg5Cp0m8cXlJu7JskjOYRYdEajE/BwUaL2LvwaHg+COkXiScEQ8GtxDwWPSszLA2FuAHmfGA==
X-Received: by 2002:a05:600c:46c5:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-440a66ab4cemr27817715e9.31.1745594939978; 
 Fri, 25 Apr 2025 08:28:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53870f9sm27851985e9.33.2025.04.25.08.28.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:28:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/58] target/i386: Replace MO_TE* -> MO_LE*
Date: Fri, 25 Apr 2025 17:27:47 +0200
Message-ID: <20250425152843.69638-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The x86 architecture is only implemented as little-endian.
The MO_TE definition always expands to MO_LE.

Replace:
 - MO_TEUQ -> MO_LEUQ
 - MO_TE   -> MO_LE

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250312142124.15138-1-philmd@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 4e09e96fc13..ca6bc2ea82f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1813,7 +1813,7 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
 static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
 {
 #ifdef TARGET_X86_64
-    MemOp mop = MO_TE | MO_128 | MO_ALIGN;
+    MemOp mop = MO_LE | MO_128 | MO_ALIGN;
     TCGv_i64 t0, t1;
     TCGv_i128 cmp, val;
 
@@ -1870,10 +1870,10 @@ static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
 
     /* Only require atomic with LOCK; non-parallel handled in generator. */
     if (s->prefix & PREFIX_LOCK) {
-        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_TEUQ);
+        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_LEUQ);
     } else {
         tcg_gen_nonatomic_cmpxchg_i64(old, s->A0, cmp, val,
-                                      s->mem_index, MO_TEUQ);
+                                      s->mem_index, MO_LEUQ);
     }
 
     /* Compute the required value of Z. */
-- 
2.47.1


