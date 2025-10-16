Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4843ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mv3-0007O8-Qh; Thu, 16 Oct 2025 08:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuO-0006VX-AZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuF-0008DY-SS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471131d6121so4554355e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616983; x=1761221783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rlVpuArFjAw3dN/Cwj1g8B2gPq+rSQ2NGEpOANnS6IQ=;
 b=du5hrK0l9k+z+PJALoM9VH3q0+eE4EDzqAjSb77R8TbafXLtPn+eRmBor3F3IoIAae
 ptNy+M2/WiGOCex0PBy/CPLPRAc5gBxOvKt4ipayew3MPpcfiX6EL8y+L1sI70PXS6hP
 t1zgU6Vo2R1ggCoGUq/2myFgXTXqhYJe2gfcpst5U4//T7zzRSU8Mbuvxyw2jXf9SVdy
 W1qZXHKyYw/awQ3KbBvoSRtkzNUp/Mgj2POULPJhMce+IYyf0BmR46pA3hgnvF2cczP+
 o5dZEXgAnmbIkNJgo+4IgKrFFVQ5vDTWuVISvmVjhtBIsR3EBFBKA9zdWoiiTHGoFUSl
 S/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616983; x=1761221783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlVpuArFjAw3dN/Cwj1g8B2gPq+rSQ2NGEpOANnS6IQ=;
 b=DeKoSih/gCW1ZQ5KrkG+IkZR8KepKDJAr137sVxEPAsjwhPPRASOOW+a6QDSdhUFdd
 fNbZppncs0kRnrXiCri54oKq2G5F3okKFZY/v11l2QUddDzSxjUqYsRQugNNnVYysc9x
 z4kVDgmR5gxddQO59JUa8FJOeMReLJ7RyK6BFdZI8Rkj6ErETUsaR4eFI4aXZhh+CiCv
 L9JBg8GuewdOQjaIYK1z9DaHI802sjpQIbIRxY67MrPCuKqyeNTSN8Ubzu0aRsDI3hku
 xnBP68NK7TQrQJ/0FxBVPD2sH1edZu1aD+Z4LIQCKYncEGYWPomUEKG6BER0LRaDVolg
 FVeA==
X-Gm-Message-State: AOJu0YyAR09yv73rV3mmkG4hpkYbwFiJ/xBTF52kvUJic0BQEGoUXXI2
 v47K598inw5dVMd58XZUd0KN2F6gko9PlQW7KnS21rNlzZP0AwEJ6ga8iucWptLMGHPJ/jK3HuB
 6y8WrTH4=
X-Gm-Gg: ASbGncvRnbvdjXnLM6GmjAiZ3Tb6qgj1OA7ZlFfwN7fkrPdPhiZhodXc9oZr5dEaSmS
 q7MJckrUWUXBNubZGRN64Ms7Vd6tDJ5Pk7Q1k+q+10bfjvo67pAV9uyfJSYAsCos0QuTM6O1PKw
 Yga4xWbHYtPKl6r9kgUgHiVWA4LP2Yin5wO+Gb3Bn7P5rOC8fKK5t8F737ZFCdlFqxzgFcrUryF
 6JLDJ7ueyal2nmCMeGK46UrVpgWplZN3Y+zvUYDVWO73D8hsMyDJ7qPoOVJzmZTn7perxNl+nt5
 zRG947ewiYJJsgkILUX0oPhxtNWyPQ/+f0mbxN2ixaqg1mxYs5UGFwGPrEVQbvvPk1BjSNCf5Ys
 Rr8ey6qPk+K2EeEfeRd6qsWFKt91Wy6GwWMUwa9pcQd7ZRUSoXRS3UQpuUX44ilJbOOchKi1Pb1
 9VyDnMagCGWBBZCv9XjCjeWKQWzAF7mGWkny+qz+c8JSgYA1tmKg+8Vg==
X-Google-Smtp-Source: AGHT+IEe34xz2iX5zlGNJG6ifFb54HQ+8LlI08z+p25EtdIjvIZ2s4wQyr3IBPssIp9Vzuh+X86Tow==
X-Received: by 2002:a05:600c:1e28:b0:46e:3edc:2811 with SMTP id
 5b1f17b1804b1-46fa9aa45e2mr205285125e9.14.1760616982796; 
 Thu, 16 Oct 2025 05:16:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8207sm33624709f8f.47.2025.10.16.05.16.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/75] target/hppa: Conceal MO_TE within do_store_32/64()
Date: Thu, 16 Oct 2025 14:14:26 +0200
Message-ID: <20251016121532.14042-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-8-philmd@linaro.org>
---
 target/hppa/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3f78bb2a76a..92071affe47 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1637,6 +1637,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1655,6 +1656,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1739,7 +1741,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
                      int modify, MemOp mop)
 {
     nullify_over(ctx);
-    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, MO_TE | mop);
+    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
     return nullify_end(ctx);
 }
 
@@ -1752,7 +1754,7 @@ static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frw_i32(rt);
-    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
+    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
 
     return nullify_end(ctx);
 }
@@ -1772,7 +1774,7 @@ static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frd(rt);
-    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
+    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
 
     return nullify_end(ctx);
 }
-- 
2.51.0


