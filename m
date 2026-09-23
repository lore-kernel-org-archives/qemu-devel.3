Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854F4C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9V7H-0007SF-EY; Wed, 23 Sep 2026 18:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7G-0007RS-5Z
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:02 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7E-0005nP-NC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398c066106cso872995a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790201219; x=1790806019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAyp949LNBvVK79JDJyQf1Lb+4iiscDMV5iiqGpwpfM=;
 b=d7o9zqaPDNyGkA/Ma0b68YIL3xqcBYVot/YdtPstv+baxjZHCrh6AUhTyYpfgEptZh
 Ft4N8wpkzE9gNxPKP2ZECKsAlqV5X3X5SPCyr628n/hu/gflBbrNYRXaWoPx9mCIIKLc
 5JqRh7fM2CyGaNnZ8NtYphY8EccA4NKuhK4iSLZW8dLeOrzKn+ram3jDtwBtz3gai9CJ
 zekx1eJ+geN/2vFEhQC+hKXmQsRlwUAoFPxMY2EPsQnQezzKPMdc/RqOmFo1NcG0U351
 kCgpNXKSQCXbUcvU9USbAzTYt8JMzxhxiYWokrzX+t3w8e9Q0gMl1vptYNWZgG19AF3P
 LI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790201219; x=1790806019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zAyp949LNBvVK79JDJyQf1Lb+4iiscDMV5iiqGpwpfM=;
 b=1Kp8vMonBB2EXTqx9433sSguwdVZWLTV+r50q25IF56NZNbbVNftjmZHXP8xwiMPar
 s+K+5J1HygJ2uJdfkAJBhjSYGY+RUFZ+0NffyOMxae7Z9uJR2SCmztsg566vfpfn/zlx
 10UocMospX5kqNkmBAmKJ8LZcpHAFCIVve9CNhlyGjnFQhtaU9gp/b5xKt6sztMBxGSZ
 H+7jHO24CjkqpMeELLiTaSIyqPCF44DhCZP3Buzo/vkPw1ETp7fzswK2y8xPTIQb1JuL
 6hSl3OYn/J1/U9RoO4gt5l/oFSBjXKwzi4isZsixVgQ6YPAgBWhX//zluCd9U1NePrQe
 /ynw==
X-Gm-Message-State: AFuF++lfZtkY0Br+I8sDGfyekeZrHBpF8UCFmIycyH7QV6ofAYmPopLj
 5HBV9GL8hxEkejUHo6TDFOghhpKF1+YmfCp+fXiIBKuM0Hbu8cf+cLqVZ4NT59lCK4kRe1weEHy
 EbMJ4
X-Gm-Gg: AYBFou3PHXXgWgEzhuTFNDMRBRf6LJbWJAj+sAnRPEpRY8AMcWUyFgKYazMBHvakfNq
 wNCk4en2ZGwwTGnnXy8a4U0wxeT8jse/+ATJY2YUMd6JSBKSuWV0PkC7esEoKIH2PiOUBWHvGNy
 PSEMzcdkJsvJW5QDp0jk3g2v0aD+VZcqRMfVDBLdbJ2XEKHpmHxT3F9orHbNkZbmnPtFyu2pJoo
 RiIcLIPk/lsY+VHBMFlmyjMbEhtXWK+3YwoR42UT2cLFXCQsT3/kJn3x1vcTLXeBORS2Jqogeep
 WnBb1SzHcjj21J+/qpnIA9UBUeLCnH5+rMjuUYAtu0doRcn8eOoufvq5qg1MRl5l5XyED3J23tC
 Kfdi9OpAom5X3vZl62BGjmW10s3R2+ugSzzPzoIWWUu+ApxClGo5DDE+jYnbZ9D9LQ+kgIISg7A
 J1qgF6CZQAfGZag5i0v8brluiJF1ZgjQ5JT/geOkkqEvme9CXmgH/ee92yx4voieL5C1G59VMZ4
 Bz8NmSBFUJDYYCNeRdyokdfV5oWfA==
X-Received: by 2002:a17:90b:2647:b0:39d:ef3e:9035 with SMTP id
 98e67ed59e1d1-3a0985bd43dmr411144a91.10.1790201219205; 
 Wed, 23 Sep 2026 15:06:59 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976ca5f9sm998322a91.14.2026.09.23.15.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:06:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mpatocka@redhat.com
Subject: [PATCH v4 3/3] target/sh4: Drop use_exit_tb
Date: Wed, 23 Sep 2026 15:06:54 -0700
Message-ID: <20260923220654.127167-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923220654.127167-1-richard.henderson@linaro.org>
References: <20260923220654.127167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rely on cpu_exec_step_atomic setting CF_NO_GOTO_TB and
CF_NO_GOTO_PTR, which will cause exit_tb to be used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index c15c0802f78..5729a757f19 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -221,20 +221,8 @@ static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
     }
 }
 
-static inline bool use_exit_tb(DisasContext *ctx)
-{
-#ifdef CONFIG_USER_ONLY
-    return ctx->in_gusa_exclusive;
-#else
-    return false;
-#endif
-}
-
 static bool use_goto_tb(DisasContext *ctx, vaddr dest)
 {
-    if (use_exit_tb(ctx)) {
-        return false;
-    }
     return translator_use_goto_tb(&ctx->base, dest);
 }
 
@@ -246,11 +234,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        if (use_exit_tb(ctx)) {
-            tcg_gen_exit_tb(NULL, 0);
-        } else {
-            tcg_gen_lookup_and_goto_ptr();
-        }
+        tcg_gen_lookup_and_goto_ptr();
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -262,11 +246,7 @@ static void gen_jump(DisasContext * ctx)
            delayed jump as immediate jump are conditinal jumps */
         tcg_gen_mov_i32(cpu_pc, cpu_delayed_pc);
         tcg_gen_discard_i32(cpu_delayed_pc);
-        if (use_exit_tb(ctx)) {
-            tcg_gen_exit_tb(NULL, 0);
-        } else {
-            tcg_gen_lookup_and_goto_ptr();
-        }
+        tcg_gen_lookup_and_goto_ptr();
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
         gen_goto_tb(ctx, 0, ctx->delayed_pc);
-- 
2.53.0


