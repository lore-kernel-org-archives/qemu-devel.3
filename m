Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4227D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlg-0005fp-A2; Tue, 15 Oct 2024 11:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jld-0005Gt-76
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlb-00011E-GY
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:24 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so3060990b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007242; x=1729612042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGnol72aGQVf38Y6d7/nrQevxwXxOL9LU8zx2/PrN8w=;
 b=DZn2+7GeMYmDdOaPCfNnsnWRtaFGnpsCg3DgBCNAlsZBnS1OaPGOl+OHNmAu36ewBr
 pYR/G8u7hmay5OHwUUiwBRs0OvPaZHtluiDStCgV7AE9peReNG99bYOWgPA6iURk/5uD
 P+6fyNLqRkRtA9lThd73h8LMqrejfzmvAJbCDbqZDxD4yA+C85xF8Nhy10Bpevx258+k
 JA7hAuqFiePUZISYoomTlA9ZDrRuIvokFuw03xdQp41nAUIpra3j/cGO0YXh9NL2xU8a
 QNcV1GqeS0LaoG74QnwBUfhCB/xVg/BoYzCERhHNOsUGL5du/7zWd50YdxMvA7v/82xt
 NQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007242; x=1729612042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGnol72aGQVf38Y6d7/nrQevxwXxOL9LU8zx2/PrN8w=;
 b=BE/OrjFfdn2nn6l8eE69LNs+/qFl82NpgmAjqeqwmhiW3uBIViLGAP5t1vxHnpm+L3
 BVTzc8fUdhRU/YHAMYy9oDqfRLObwptDoAuwdFxFFQc5jP/mtesTCWnfvE0mRpkomdq5
 w2dcR2TEzPCrC/B8g1z0Yl6GBbwjsbftIySUCJzfU1RLgC4qVFTOsTUDu+kO2EVnksPS
 eqnAavEQGReavhb28R3Xjhsc6qyX+eU4yNTTVqBJ7Az5LZhVTBYqNE7djtANmNVf2mOy
 xXXP3pdb8ZKeA0ADSEqqSxlfJAvGCy7ciwXP/hmeoef1AKnaHXDkY+BZ07eLEB0c0urJ
 k7Pg==
X-Gm-Message-State: AOJu0Yzf4QyTut/Xnlo62DJo3Z/oe551DYs3obn0wirRT5V6vOHJlQI+
 CBvNcKDn5kDaPeompwowWAP92bSF2USAxRvv5Q0vYIwh8HOrepcZEsHLjuTBbA35yS7l5oZYFti
 R
X-Google-Smtp-Source: AGHT+IHlWgmtdgOP19ho1QqJ7f9QRhwvRXMd3xzuNc3tSk3+5+JGdhgahsJSi6wT4eLZis6I2wJmIw==
X-Received: by 2002:a05:6a20:e613:b0:1cf:4679:9b97 with SMTP id
 adf61e73a8af0-1d8c969991cmr14944384637.37.1729007241956; 
 Tue, 15 Oct 2024 08:47:21 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774a41afsm1412231b3a.113.2024.10.15.08.47.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/33] target/mips: Factor mo_endian_rev() out of MXU code
Date: Tue, 15 Oct 2024 12:44:31 -0300
Message-ID: <20241015154443.71763-23-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-7-philmd@linaro.org>
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


