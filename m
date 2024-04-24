Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698B4C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYH-0008QF-Iq; Wed, 24 Apr 2024 20:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXa-0008Ae-0N
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:49 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXW-0006Bb-L4
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:39 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6001399f22bso319001a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003236; x=1714608036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n/r2YLWc+BBa+Umbvi1fDfG0Z/QeFXTc8hx5u3dy+3g=;
 b=ylWKKaqYp9yiUC6uzijN6bZWjb5OMLsMD3XOphZ021TQ+P93ZUhold6YEj7C6zeqVe
 adR4zQkZ1FtwGMos0MHqlAWiIqsmbC+Q5tWXfK6L/n+MnfKWtYzse6D/XqMrGWsfxMRf
 91nEkJH4rIvaghmIOrLKaXI1arFKI/0TQVhwMWyl1RAvDk1wqot0CbyzoIgYBt46/APg
 Y5/wD5Q4+7dwaGmehwoOF+5XCv1M2Bx/cJjFmAgWBQfOnQnYo0kaVvcIUWSokEHQyAZg
 9XT5Rj+kyJEyS6WN3USg2dnAeYkj9rmybKZ6oOKbxeQ8m8Phe5JUR7H3vuVAomzMKtbq
 IF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003236; x=1714608036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/r2YLWc+BBa+Umbvi1fDfG0Z/QeFXTc8hx5u3dy+3g=;
 b=U3uGk4Qj1kVqN+Mt2DTXo8TJGUe6pnU9Yw9M6F73uCwwFaSW3bOiaH13tZD2fdpGej
 BC+iIiQj71oCubGxHGi8Ncc43WTV5prGnRe0N5LkFugiSbkhYpdM5+w8c6CLMClnwfB4
 RXgJLnmFR02ZRaEzTNL/frTrZ4UixQP4YWRU07bMitD677pICtRAUgAqbRBp3QZOmtuz
 YH3DB5+sxNb0I1+UPs2pMikLquruSnSFX+/ax8u4TmYOomxXti12loqjlpAhyMnxwDk1
 fgkymmTgW+jjb1wMD8RXbCjs5jph7GnTY4z9Ttkyrd85lzUrope8tIuaMjDHmYLWTwGt
 oJfA==
X-Gm-Message-State: AOJu0YzqO6ad+GbnJ0Zl1oEQgZzjtDNq7PGR/nXzVWJvLC+QqMsAO8GE
 ca5Ar3nAhtf4gWlbyIFUJUAtww/aGwHB6njWI206mxtmMVhDyEWqE/L+BJUgw3DSeN1TIB34jea
 n
X-Google-Smtp-Source: AGHT+IG//pcGeSFC76kx7BQoZI1uJ7O/5quzvuXDMLgc6wJzyl3evuHO3TQvS/V7y6OUWHJE7+anjg==
X-Received: by 2002:a05:6a20:8423:b0:1ad:31e2:56c with SMTP id
 c35-20020a056a20842300b001ad31e2056cmr5095535pzd.8.1714003235869; 
 Wed, 24 Apr 2024 17:00:35 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/45] target/hppa: Skip nullified insns in unconditional
 dbranch path
Date: Wed, 24 Apr 2024 16:59:48 -0700
Message-Id: <20240425000023.1002026-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ac181180a6..6a73b1d409 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1804,11 +1804,17 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
-        ctx->iaoq_n = dest;
-        ctx->iaoq_n_var = NULL;
         if (is_n) {
+            if (use_nullify_skip(ctx)) {
+                nullify_set(ctx, 0);
+                gen_goto_tb(ctx, 0, dest, dest + 4);
+                ctx->base.is_jmp = DISAS_NORETURN;
+                return true;
+            }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
+        ctx->iaoq_n = dest;
+        ctx->iaoq_n_var = NULL;
     } else {
         nullify_over(ctx);
 
-- 
2.34.1


