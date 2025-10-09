Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C82CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ncJ-0005sm-BA; Thu, 09 Oct 2025 06:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncG-0005nl-AB
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nc8-0007C2-9h
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso4558475e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004665; x=1760609465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzb+fRL+OAeimj3XmFSk2+givGUmDmjM5XBZ36oKT/o=;
 b=pEfxC9wzM/CQLFNEfkCpd4RUpOFKam00KnY3OpoPe0DW5125iTDFSsF7hF8CudePWq
 H0s9rh9QjCwgve1HG28VR92w1eyEqUU4w+aN8DO9M5T23KOJNx7AHeLxMrgmX6m6QTll
 MlgYUFiyKUd0iruaovPqoTmDZQToRvXqN1F4zZY7XAHKCB4lNRznT45wtTQ6l4FPGlhR
 RwavqBZVgGNKzUzhOPxcW4gD9WcQo6pXoUGT0O37Bvv/VaFa/BDm8EkLot6MQZHGhuXh
 Glvw21bWLrOCPW930KIg+FpdLNfUy2XufV3G8IrTWmz/y45OOK6HSJd5EV5kMxcKIN5S
 vAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004665; x=1760609465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzb+fRL+OAeimj3XmFSk2+givGUmDmjM5XBZ36oKT/o=;
 b=eU4wkfq9HGkCdyT8n8JLyglCnXAa99eO5Z7j8A0Mfg12uufzZqKL38/hjWEFI6bztS
 nwoq8/3PChtOThIx4dxlR1KfDw1GyeHlTOXfomrFlfsX2u071Sppm6RA/eap5OsFmZTX
 oqAcm8tTHMbB0ej0KisTg0b5aVLAtmBPxsT8z6hgYA/VvdLX9PCiv4UjZSv/PXE6XNxt
 P09KmQlZVI5TfcGYInZx9duwovnffz22PIcWYDXD0Zk+JsIS90v+fxif/tclEXbxDxnY
 B+CVeHNHbxxog+BIJnQx7CWkuuQIMfqPizWNwy4vsVXnRhG7IgfHoaC9sYeQxaYsQGVr
 DNbA==
X-Gm-Message-State: AOJu0Ywi9RvYOuRnw8/NyFdiZ80bHNdI3selD3cbGCdoUkQ9ErXrhtxQ
 OURpJakzow/qGVE2Mq1udLwMfbiiClgMpOnfv4FOJ6d2BuYPfUy5sszY9g+a7+82x07RpKVrPAB
 kXyzbc+Iv9A==
X-Gm-Gg: ASbGncvQ3j1LfiWkCfwQ7FnMgdcbGexeeJxZW/ulW8panPnYjfqzdlbmOAvBqCebgRz
 fecoPBDSVqvoI5A2KRMEzydhTj3zyo+kwN0R8/ISJ+stzs3hQsXJbq0+eVw3LFUbS95HxbSYWpU
 uqdYG4l5hb4rtLbu9IVJpqftKG3ZPxTfJUR1A18e1rj/FxHLWyHl8v/A9CaHgT2UaGFy0E8xNR+
 5MctMhBczXLGtyhIsZiSqZ5lVZmllPn5Sfd/xHAk9CCtlx9yJBnf//dnyaa1TGrzlXVcuZWOKl8
 FVWIKemyOp5CA8FVV6kmJ87lhQyBhC3sAEN+3D5ixzl0x7804e8Xv17ROsdB0ZwB9t93O6qqVWX
 oZ9nbltV8uCESsjbmaRDP+9yNWSZMesEkeAqC2HQL0TQS2LPmiCgz2YZhbkPGOa5IdrMz658p0Y
 TcrmECaLb7qAxFst68iCZ7jrr8XgJ/2vzGtQs=
X-Google-Smtp-Source: AGHT+IFLw+c4Vg8wsmMefZ2E1uqd9K4N9cXK4B5tz306Rmntcirwcps+PMlpRuCnavXU0ybXQnq4BA==
X-Received: by 2002:a05:6000:4212:b0:406:87ba:99a3 with SMTP id
 ffacd0b85a97d-4266e8d8a8bmr3904309f8f.30.1760004665557; 
 Thu, 09 Oct 2025 03:11:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf38sm33605868f8f.20.2025.10.09.03.11.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:11:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] target/hppa: Conceal MO_TE within do_load_32/64()
Date: Thu,  9 Oct 2025 12:10:35 +0200
Message-ID: <20251009101040.18378-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ee0c874342c..4680d826345 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1599,6 +1599,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1617,6 +1618,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1676,7 +1678,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         /* Make sure if RT == RB, we see the result of the load.  */
         dest = tcg_temp_new_i64();
     }
-    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, MO_TE | mop);
+    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
 
     return nullify_end(ctx);
@@ -1691,7 +1693,7 @@ static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i32();
-    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
+    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
     save_frw_i32(rt, tmp);
 
     if (rt == 0) {
@@ -1716,7 +1718,7 @@ static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
+    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
     save_frd(rt, tmp);
 
     if (rt == 0) {
-- 
2.51.0


