Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45723CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54T-000490-5D; Thu, 23 Oct 2025 19:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54R-000436-1J
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54N-0007MR-Cx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-290ab379d48so13783995ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263409; x=1761868209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5FE2heCAcRJvSP8v6hzQsEmDuz5OULa6o5imBMV2Lo=;
 b=NwjIc18gZxdBIBG1dL75s0aVQ6ByPVeVFAb+9iubfXbHo+CVsB9DQ+bqFGInfT35gp
 Qxuhknm7K8zZNOceuiOY+6Jd4dNiSoElf2M+1c4erFpfNmmG65HP9Vbobd1nr1Inf4dP
 nWQHZi80o1x6Mpnb+GZvlKVnAs3gfrAUjwSb370OkAEpwVMweQOAiL1Xjha6Ux9KWYAF
 j4vCoMEBKvup8dM4DPAcBNSv9gU2EUGVGj8Mv7OC1Pog1J1OJCUdCjSJeKmxrFa0bI8j
 KXjkRQPFtjMuY9VGcCzEw97D1hbup6tjcs+8r9FAJZqxebKsZNToK3xBFFp7D10kmvrp
 H8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263409; x=1761868209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5FE2heCAcRJvSP8v6hzQsEmDuz5OULa6o5imBMV2Lo=;
 b=HD5vcE6gulEWzX4o1QI79831EyfUuTq44hnkqfdu8miwMGWliMsSNyshIMyWP1XtpZ
 KdQ/4SpER0UR9AYjvFfbXZbfWGVFCkS40VcZhOW9vcF3B5CxC1tjQJci9fzD0m7fISB/
 xQFqwaCHbl19IRLALZf8JoHsaO1u3/3nCLdF2wWoyb7hMteNMVjvGFW4u8P85OUpg3bQ
 4Wg2nbAavylfSIkyGeJF57txIDcnnDwl9RfcHKFWIHnKh+aBAUKLwECY/7InZC+iHssM
 FyP2Z18aC1woV687JGpVYmELl/FNtuqxITI6hCyy6N2q+pWpkUGwQMOCslF3G8o7ad6Y
 gsaw==
X-Gm-Message-State: AOJu0YxO3zEuFaY3wdUTXjn+WNPiiSF4nP7POxi1QoBVxbuTq8CZPQxe
 dEkXHB9HcwfUqFL1/ZrdbQIw/qBR6ieUBtTWTiMskd6OAR+DccDt8yljIB1klQ==
X-Gm-Gg: ASbGncvbNi9XscMKpjaPLBLsj+PzPhosKiFev6xI12lhwaUkh3QkzrAHQDd90rgIr3K
 43ZQ4wFMx0T49woA68bMtrEq12Un8Jx2EJsZMBde1DP5a9fJRh0k8cSUaSOrh7j90MPusjqqeux
 9Tqt9PInCVMam8KW85c7KM8A7LrZE+yFqcHR4qnNuj3/EKH+cmQ4XpUSXmhjhr5HwpgmIiRishY
 TlFwZoVuV3qvfq++lMZKYJByEXYsBGYwTo2JRX6KFunnAGl5mAwMpYgqh4otSVt1+LeTwW7oMPY
 Lc3Rqj1rs+b7WnsHur8zeKV2xNr22A/CE0uhvvCxtbPqSTrnL2/5IviZWlrNVA7opIqYOxnq/3m
 eck4nOVqzyE9bEtCSPyMxf4MnFIPbQVz7D6uJQc38ZyS8hTgRx9mjMptVmsJ0+Sr6hpY0xwe12N
 cq3+O24I9E/InPgsPp1zOikm0coF6LS/5Ut8G7UfblNE0CwPYMA4ge59PC0oBqUhHxFeNbr3LKA
 pEbEaEFs1jW9zKH1+k=
X-Google-Smtp-Source: AGHT+IE1H4Xrgu14c29Ihaikih9omAnDA8Qmptu/dG4xHFzg+5dvShJZnh2hTfz+aNECJidEG9ECUw==
X-Received: by 2002:a17:903:2b06:b0:272:f9c3:31fb with SMTP id
 d9443c01a7336-290cba4dbb5mr335398585ad.58.1761263408737; 
 Thu, 23 Oct 2025 16:50:08 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 09/25] target/riscv: Conceal MO_TE within gen_cmpxchg*()
Date: Fri, 24 Oct 2025 09:49:11 +1000
Message-ID: <20251023234927.1864284-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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


