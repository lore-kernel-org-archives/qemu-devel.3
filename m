Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F2FCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FPM-0004EH-VQ; Fri, 10 Oct 2025 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FPK-0004DY-E5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FP8-0002c6-0w
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so14163285e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111492; x=1760716292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/UOAMuWHFSXqGALj87y4eMXTkQjeecfZopjSv8ekkA0=;
 b=C2dl8uqVBkRhBorYUhl3RzoLheI2Yh7NWl5UzqL5dbnrl/IZuUdHSkO6zeLIYAnhlB
 s5x6VscTQ6/zBpcwMvRYo9WWuayimMNK6KMwbnUgpagDpy9LjcqzLWOtTBkSK1quFLe1
 ea4+bXgsBrmITMdMVGRgR+wcXB3eWqH6/nHq5lh867M5C6uF5cmVKqBcyEedvQLmKYtQ
 1fkRoYD2+QqTRr89oZSNwOnJzUxI2pQvEcF4tGblUL4QTIXWT/ef/0bsUxT1zmLEswGF
 njnMFEgiZXrqpnZOHygrWj2sVe8GUtTiqXL3Q/HTOttqjnLE3fdlOZIeirR0M4U/gipo
 8+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111492; x=1760716292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UOAMuWHFSXqGALj87y4eMXTkQjeecfZopjSv8ekkA0=;
 b=clGOLScsf8KUrpWe0iF2WowiP/5JyGSWSAeXTq2MihfpB7Ybp9K373qNgA5moBWTGn
 9L1KH0rgS2fA329n/owqp2mFIvVsxb2vTJUZSnc1SBVZlcqnzuWMvw9pbuNkElnfZ6yQ
 Xbs0JY8zDRMc4JufumwGfzM9cU2zT2uMsDCjGJLt+CsVQS+zWk3cO+qZJgbv1iGayihr
 du5pyYKj/P2LpfUJjpqDk3Aq0nlPAajoKHK26qHbGASlzTAoQCi3HXzbn0xMUP5DJjtp
 Jl2E4fPVkqYAk2pFv1fPz+kC37IzYQNICOHXuvGP4Yjhh6TMv4ouv15LgtabMzrN7xaU
 cbPg==
X-Gm-Message-State: AOJu0YwtZRqVmCP62Yck5ZQhaQiZf5EPdG8G7FdSu4w/wywpS4sOQ78o
 dByGT2C3fBhaGhjp6Y9bHQi+tXoFwkAINd3kYb0S4f8fvQI4PLP8hvb+d78WUYUAWxhCftFXQGZ
 T78xcHje8eg==
X-Gm-Gg: ASbGncsRm0t6ZmGUibA/0sJkUBc00nQBzTTntrbKP9HqvoaStP5RC03PKobZDcYWEMs
 kvWIX5jtbyQ2xEQ/RoUnptUp6ebwRDgwBGoUzObpoLYPYHF1SNaQOpThsxl4SKe/LD+ZEueTiIQ
 k03UqB0vBTLA5QnsyUteymL8ETiqDbzqDc6qocX0lFij/5aIlFijO3nuDVV2lY7xSfqPvV7m1mx
 Cy5+dPrO4R7xEzyOzIF+NJ/564VomoAxtDdgur3IvCCtZAk95LFoe0sCu8Fq/voajvibHsO9z5J
 EiXq/Kn4dfRH27hjP+/RKeSqCG8ZKd68EYNT1x5xqb72ZhT7iHbKXmTWYbGbDbwdcvN6YxbWm0s
 Ttgc6ZxvNcEom+kD/M5bUkNt5ohVKO+1QB3pKYdmVGeOqjl3QDN95S2qmvyKLJwFbAfMuHodW3G
 zrMxjn2EADjYrFTMG0Qus=
X-Google-Smtp-Source: AGHT+IHDyN6MU4HwLRTS0l4dOb6E5huCUFW4mK9urBDTrxZ9KU8uRu7FSltR0041qcX6du6mQ08FSA==
X-Received: by 2002:a05:600c:8487:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-46fa9b13ab7mr88850395e9.36.1760111492268; 
 Fri, 10 Oct 2025 08:51:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb483bcf9sm53312185e9.6.2025.10.10.08.51.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/13] target/riscv: Conceal MO_TE within gen_cmpxchg*()
Date: Fri, 10 Oct 2025 17:50:40 +0200
Message-ID: <20251010155045.78220-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All callers of gen_cmpxchg() / gen_cmpxchg64() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c                    | 1 +
 target/riscv/insn_trans/trans_rvzabha.c.inc | 2 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc | 7 ++++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 94af9853cfe..2e6f39aa02d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1156,6 +1156,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
+    mop |= MO_TE;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index c1f99b65f09..302c63f2a3d 100644
--- a/target/riscv/insn_trans/trans_rvzabha.c.inc
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -141,5 +141,5 @@ static bool trans_amocas_h(DisasContext *ctx, arg_amocas_h *a)
 {
     REQUIRE_ZACAS(ctx);
     REQUIRE_ZABHA(ctx);
-    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_SW);
+    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_SW);
 }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 5e7c7c92b72..d850b142642 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -25,7 +25,7 @@
 static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
 {
     REQUIRE_ZACAS(ctx);
-    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_SL);
+    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_SL);
 }
 
 static TCGv_i64 get_gpr_pair(DisasContext *ctx, int reg_num)
@@ -76,6 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
 
+    mop |= MO_TE;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
 
@@ -88,10 +89,10 @@ static bool trans_amocas_d(DisasContext *ctx, arg_amocas_d *a)
     REQUIRE_ZACAS(ctx);
     switch (get_ol(ctx)) {
     case MXL_RV32:
-        return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
+        return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_UQ);
     case MXL_RV64:
     case MXL_RV128:
-        return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
+        return gen_cmpxchg(ctx, a, MO_ALIGN | MO_UQ);
     default:
         g_assert_not_reached();
     }
-- 
2.51.0


