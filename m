Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A208D2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz13y-0007pI-2n; Thu, 10 Oct 2024 17:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13v-0007gq-Hw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13t-0004gF-TJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso14393485ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597068; x=1729201868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ui/XvxKnnZVh9IYJxTskSnnCd0iokhNHwaYVOmaueo=;
 b=EBemordH6Voi1K4v1KM4H5xEYSXoKSomt9OpAh2Y9L/tRFfEPqxg4refdIqofHht6N
 69cerGNkmcgyZe174+eKHtV7o3CyNx8oZSFUrkOuBL6xcGkeuk49CpIKqzuucm9tSsQQ
 Z5SurrGKkGQnpwOPgfwUO5MjAAZK6Bh8M/x/h5LaEoFv8+g0fw7nj8ey747hf5JwJCLF
 JCPPpQ46jRIzPpkZWxIheECauqyhvoZvNB4BKd8Ce490FGR7rC5jN2QAw4gpFqwxi+iT
 ahQGkvR3H7bVAUs2Ehezlc1NtOuI7UB238uXIDIVy1DE0aVpoEcfLZKR1JVJ3/wEpppd
 Grjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597068; x=1729201868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ui/XvxKnnZVh9IYJxTskSnnCd0iokhNHwaYVOmaueo=;
 b=u2Tx3ZnawbjCk/qpJc5u7RKyaoUlIaAbnyu6Qy/A6SYxqAuR9beX6F/+4nX+b5vWEo
 9oCHO7fn4aT/LxEAwk6HgHmjmgLzOpZVZXut+WRrvmZN2YF6MMQZLLNGK8DKPPFsA3bc
 X7q0a5gIdDxzW3Fdy2btIUllhvcQeYWGRwzefXiJPumHKT+NhwBtV6mN5j39kq/Mr+K9
 h7e3RCBCDiq+56B4qJ9kqX3115GSX0ZuWpuNxvq6cx+i8TcBpULVr7uCnwO0o4qeijYy
 ZhU2hkqg2mygUG+8GXTyRehvK2lyg1R/MvIgUy24CtdEVaFHsoClm3j40lMzfFc5d5yj
 7F6Q==
X-Gm-Message-State: AOJu0YxP+zBhVdoo+oAQQ3k+p6X3d9aHnhUoKN/HOLRib1MktIVbkuVX
 CkuGdqb7Qg+Unwz/Ko2ugIbbQ2/vO0pr44Ds14V5vo3RJ4PUflE0Zupj/rXvWNGhAbX914KKXa5
 f
X-Google-Smtp-Source: AGHT+IEop/o0ZRQRB0Gwq6mvIVYolw55nW2kEF+2sv03uYD65n+zdcOewG2dHb8eg31HZQCIaE085g==
X-Received: by 2002:a17:902:d50e:b0:20c:8907:90a with SMTP id
 d9443c01a7336-20ca13f732amr4235685ad.5.1728597068001; 
 Thu, 10 Oct 2024 14:51:08 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0f5b90sm13633745ad.128.2024.10.10.14.51.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:51:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/16] target/mips: Factor mo_endian_rev() out of MXU code
Date: Thu, 10 Oct 2024 18:50:04 -0300
Message-ID: <20241010215015.44326-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Instead of swapping the reversed target endianness
using MO_BSWAP, directly return the correct endianness.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h     | 5 +++++
 target/mips/tcg/mxu_translate.c | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index e81a8d5eb9b..c55f90e741b 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -240,4 +240,9 @@ static inline bool disas_is_bigendian(DisasContext *ctx)
     return extract32(ctx->CP0_Config0, CP0C0_BE, 1);
 }
 
+static inline MemOp mo_endian_rev(DisasContext *dc, bool reversed)
+{
+    return disas_is_bigendian(dc) ^ reversed ? MO_BE : MO_LE;
+}
+
 #endif
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c517258ac5a..dd512ce7a48 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1533,7 +1533,7 @@ static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
     tcg_gen_add_tl(t0, t0, t1);
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
     gen_store_mxu_gpr(t1, XRa);
 
@@ -1569,7 +1569,7 @@ static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
 
     gen_load_mxu_gpr(t1, XRa);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
 
     if (postinc) {
@@ -1605,7 +1605,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
     tcg_gen_add_tl(t0, t0, t1);
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
     gen_store_mxu_gpr(t1, XRa);
 
@@ -1675,7 +1675,7 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
 
     gen_load_mxu_gpr(t1, XRa);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       MO_SL | mo_endian_rev(ctx, reversed) |
                         ctx->default_tcg_memop_mask);
 
     if (postinc) {
-- 
2.45.2


