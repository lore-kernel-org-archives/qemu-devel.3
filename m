Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F757CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjU-0000kZ-UC; Thu, 23 Oct 2025 00:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjS-0000ju-LK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjQ-0007Kf-P8
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:22 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-781010ff051so263833b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192919; x=1761797719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5FE2heCAcRJvSP8v6hzQsEmDuz5OULa6o5imBMV2Lo=;
 b=Yeq0pfoGHw3L/VXGHhCQzaU+jMf+N+/WTrbReXdFnk9nAyafliL3VVvO8pQncnh2eU
 iKvc7GhyHcPTFmbGKt5gnp0HyAA+3jUwKJtr62FKAAZD3PT7J0pIVxw4nwrDBS7OG2/d
 MjARrty+pq2IRqVel+KVGN8ZPzm5/Qnm7xmh+RCeHMW2UJcf1P2ewy29N3IXlSjsFbjZ
 rhmc4HACidKhoGFNvf0SQIOnpJLW4VHhl/f5wo6d25PgRJiSW76eTL1jb7sefVfhnP5j
 E/a3VlcU92a+1t4yuVCua/SlztSToFFiFQMehZuqIz/QixBPIDRRYPCIXOguUOEoL/+H
 FY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192919; x=1761797719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5FE2heCAcRJvSP8v6hzQsEmDuz5OULa6o5imBMV2Lo=;
 b=gdRXbgODfuI6Bzqh3dBDidvAJv4x/RkEN0+qD9Yvs1u8xhsYM+7zXqgUEAVH2TO6rm
 E+BQOnF/Le6WFYHjsCK/Six07tbu9XmX91GzCQI1HZ+cTiMQum0kSCyXVYk0aGYWwf+O
 qXC/RmAGmH1clzYyw9a1GHwmFU3MiaV4amQrsGwcU3XBBBvgfSz34LcA4Fobd2S6/vht
 k+J9z+qAeMIY1KbUjv9Oj5VDifYCjwxq68joYWwwXDOTNoPgv83afiFjL9RpfoFUCI3l
 XWIVgLaDtsk6GRCjIKu3fUgNdBaMV+80JWEZjoYq06IKbM4dRSBz7uwcBw17u+28Wf9T
 M2sw==
X-Gm-Message-State: AOJu0YxKi/6mqwsyn3WpB7tJ8Yd7Vmqz2qRN1bDuqIkTtkB2BRhRESML
 VouxZHJFP1Vm7wLJdlxwjQZ7ih+a7XIeG1Gb91TH9KsERcbc12wwWHcQpkwIPQ==
X-Gm-Gg: ASbGncs4J2jO7asP7s0CD6uw7Bc8IEmiP8ybJtPv1GrtkVbimcExlHjqPsn2qGJWIM/
 m7epvMx1NcP/kfSQEAaUoHGC3OlkokyqjPhQsNpVPkbLlowXwUuI2Z77po2izI+4hmjAW67tWqe
 1RLBQI+/ilANQWLsbamj9WwFVAaAaKBT6Vl+3VAsP5YeJIZsXYmP5uGpD0110MUj/2xfkHAdwdk
 JSKe4iFxdlAVDp7KQvfezBzvjSL+pjlcr6UkZ8iHulFLg3mk2V3OJPt4ItF9CdHd3QSRqslPLri
 e8M0uQjWmOxQIy7bzZH26NgFOKZ8MMKuVKWtHBfpO4Mf2x4WJjcg+EQe20ZXDVHpYt1eqZuhNez
 z8jYxfVqk4q/Dcov7MA25b9IROf6nY7oev71pZKxApf9zoAzbCTkWZZhrPOQ1XohjW12mtVx0eT
 z29zZBqaoMkCgbVC9kgGQawO+oW+BgoSkLnRSZvDTHY2hBoW3k3X34vZW9s+vkz0dFHdPr22fe9
 zHK2mq6cw==
X-Google-Smtp-Source: AGHT+IEDnNPV6+YnVl52C8DvzFj9p+k+rK8uqvGT+ZHf3z3Yp/jvWjT8t6bhfXBDmbx6ZwkDnqVNFA==
X-Received: by 2002:a05:6a00:22d4:b0:774:1f59:89de with SMTP id
 d2e1a72fcca58-7a274ba902amr1333631b3a.11.1761192918850; 
 Wed, 22 Oct 2025 21:15:18 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/37] target/riscv: Conceal MO_TE within gen_cmpxchg*()
Date: Thu, 23 Oct 2025 14:14:07 +1000
Message-ID: <20251023041435.1775208-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_cmpxchg() / gen_cmpxchg64() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-10-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                    | 1 +
 target/riscv/insn_trans/trans_rvzabha.c.inc | 2 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc | 7 ++++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 94af9853cf..2e6f39aa02 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1156,6 +1156,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
+    mop |= MO_TE;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index c1f99b65f0..302c63f2a3 100644
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
index 5e7c7c92b7..d850b14264 100644
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


