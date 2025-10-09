Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB4ACCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ncI-0005q0-Qf; Thu, 09 Oct 2025 06:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncF-0005mM-GD
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncC-0007Cw-4F
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so382788f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004670; x=1760609470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ/SOnUMyxLw9ci57BdZscKv0DcNFcjBm0P6Y7cC7Ps=;
 b=uxow4MCs24FJEbhdhOIYlLI9mbjGjUp2j7QZ6OQBxLhR49rTthjnnU2hUbr3+mULBJ
 NaNX30lS9Kl6XfTiguE0/NE8MzWult7nrTbkRvA4oxjvN3q49gcX3ZIVdZc7BqZOpcuX
 /WPADp7r8Rm5aPeQdY4u6hgPObgzONqlx48p0kd9/cPPsjy7QQiEcCFPDC/6GafbMl3u
 FfA3n0aGq4y42+iMByjBTtK59sqvbhExeaPyApW9RKGplVs+YtRScbmpylGiKHu2OlKZ
 3xJTEU67oQrHon1ML8e3wurECoezAkIs1TLRq24/MF4Au/ddfZkRMb11VIQ1VdcsUn1D
 bJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004670; x=1760609470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ/SOnUMyxLw9ci57BdZscKv0DcNFcjBm0P6Y7cC7Ps=;
 b=iw+kKRy83zLLKnWHPOfOIUQVGyjk1Ox0vUROxfZAiw0BQk5++Bj2KsrosuVIGanDCh
 pR1nwVP81c+icMXJx4c4gxMBp9B6IJFQhiHbN45rbexiTlJ+HwWA+ArNIbFx9n+c/Q5f
 7O+STRtW8kVZP0In2pYlbm+RqctAdncQ8RSDuUk8ciQ18r0FhlEAvXHM6HthQ+5VWsXG
 JtImGszU9SdNp/7HKhgcoDsgIVd7IrYO2Qg65g4snQqguB72Vac3GCPdJkM6ZbYE/mLt
 RRkUN0Wt9cScTXax9WMgNBmxtei1FdJ00D6hG9qz04Mgg5x9XTKiWkC2jkG/aL7Dwq7J
 3o9g==
X-Gm-Message-State: AOJu0YwH35vcOo60Q8BXkKV5jNfp/FahZ3fO/dK5B7easA6drSfe1119
 yysSeH5TD35r5SlEe/NHh97Y3nRnKxUms7QWqFnSXZj35prTsLZ3IH7wH/iJDS40PtLvn0zUcTP
 yrYIg+A7vRQ==
X-Gm-Gg: ASbGncvGg5ndsgmOjJVeKzGrAqZNJ890OZyaz45ApTN7d+EudG2YSUzqNaF0Sxn5JMB
 D4btsG66D7RBhI+o1/i7hCctig6YQ65oN87AU5u/XvdljYpnKwySUPBADSvtuVLBJBs/H88Eky1
 +pf8eenc2OwthMYro413yBOxORjXD4gBHApkbiFaYFPPdDNfgSEiVaBGkREQffqb6YBbrrRHL7a
 dITvlQdNquyqQHiQx6b6YmRjNuu2lsmCoK8X3GnGx/c0Ia/nBzBZrYs1RF8M8swdrZBGXpVLJJP
 OJ0lYGOuDXaDFADMTWouuuuYerEIXJGsiSUA95i2JeHdxNhQqb1xFMOpoO24NHagB0uuSxq6XjE
 zK0+X/2EdnyzPdb1Ysg0FqrLrOefBfvkYuJLsN3LGWt1P+kfIgIuxXYYh3ycwVW98XcwCczc2Xk
 oOs1DnM2H5zbqMru8aNGgq5uYL1/8sw9KDVfg=
X-Google-Smtp-Source: AGHT+IHDKEGK9q4w1Rcy2UZgwOWGxuXl1Dgo9XHMY9iW6qxN5/Sb3Lk45wH6GEyNaFyX5R5YSlBiYQ==
X-Received: by 2002:a5d:5f48:0:b0:3f6:9c5a:e202 with SMTP id
 ffacd0b85a97d-4266e7bf23cmr4177506f8f.24.1760004670224; 
 Thu, 09 Oct 2025 03:11:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf105648sm40511225e9.2.2025.10.09.03.11.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:11:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] target/hppa: Conceal MO_TE within do_store()
Date: Thu,  9 Oct 2025 12:10:36 +0200
Message-ID: <20251009101040.18378-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4680d826345..3f78bb2a76a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1739,7 +1739,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
                      int modify, MemOp mop)
 {
     nullify_over(ctx);
-    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
+    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, MO_TE | mop);
     return nullify_end(ctx);
 }
 
@@ -3313,7 +3313,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
     if (!ctx->is_pa20 && a->size > MO_32) {
         return gen_illegal(ctx);
     }
-    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size | MO_TE);
+    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size);
 }
 
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
-- 
2.51.0


