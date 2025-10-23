Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5C5CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjP-0000j6-N9; Thu, 23 Oct 2025 00:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjM-0000e8-0H
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjK-0007Jf-3Y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:15 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso376062b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192912; x=1761797712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVk43MZU3eODXH5tqOa2IO00Re4cjN++W5+uBbDHnOk=;
 b=MTdsakn5gDvM8H6EzXGh6N2XYuj5iL1PQp3UnRM+t0O5IjiL7ZLz0ZECVihA840gMP
 ++edDcp+SD8S8psSxcVNrtMrCJLrYHBJBwgAOE3yrfVRc3uJMAIh1piNv6sy3zqaNl1s
 qcBXuy9IEw4UaWyX13ywyweG+dayLUUFemNE6fRthCrpE92ykuBWJZo4oQAGQje7yHwI
 UUQgOj1WHaROaj3i35Oek+b0mSgUUaHEGoqpEgdnjMvpn0UqZdYT4nkUIkJJ7k/7AH1c
 b0mtQuiOjZ/IqU4EJB7Rl/qI59cR4zZxtpzEuMb/eGDIoizEWdoADAjI6G5OKiiMCqcu
 E4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192912; x=1761797712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FVk43MZU3eODXH5tqOa2IO00Re4cjN++W5+uBbDHnOk=;
 b=jpRzeYlvDAXnTMbAFqsoQ5GU0AYSJweH5pt3xmQOQN+t4kwtcru/ejwnas/x9AQyMZ
 a/eL7ftjphYTYAuRAwysvvmLTGB0H3Z1+KtQfVezauAoP1cZxgNYxVbksZq/2D8KgEa7
 MuXFth0I4vooV7VchQF/VJIp7LpM2SoMP/06DDfooZxLTLbtpY/O3K3zQUe62I5EUU/k
 IERG6ibQ/cAzljvVKi3vTSCAUPZJ8GOJtvAUmSL9mdoDfMIl7yXQJKzK0FR5kejOAcZQ
 PT9Ic3KzcF0bq6e97HXhz/Xc+TjzQQVldlAGb7aENBCyygi6hqMIKTdjCC8OG5XrvrE8
 GGoA==
X-Gm-Message-State: AOJu0Yz9+QTGQ2V5z3rlxACDR2qSa273bgFx/Vb7GwzAymz7e9s8wKjX
 Xqm4Klx/Nuq+WLNGhsFobWl/McbJetWW0w/CV1swykt3lkx+qSu3uLsvwg7owg==
X-Gm-Gg: ASbGnctQ6bpdYw9w0bF0f7MZQJ0HxPSJ9pQFm7JZCBcExFW6xjy7fuaUj1DY/qlIKo/
 Btsd/+7pHiEjtgJdi5AcZVm7j+Oaix9wuyqaz1LbwEhywH8gEGqDNtOfZ/OYJzXRW1FbXi+hW3p
 ISugLNOFwisPy/+8E3wUB8UmhrGAmf3L5Kh840tXa/YEhb6Z1X3UqccXoB8Ui9yd/8aIVuMh1j0
 wrYStlIW/bUKpjl7xxV7Jn7XdL3tA8IVKSdZ7nL7T2zoaD3RkoihVBncD1ddrSw66HaIzWYbpyd
 QvJB0Xl35Kb2K2LA1ZteDvIBH1uI4DWBMox9X2lD1ZWekq3d9MLoVxb/OJMzxH6vDTv5G07hvCX
 cQVQzj8tuH9eENMvkD2RhgzY6uyG+ZL05H3a2oKWfqblZs6OictvNE/xtNs5AfTDNrU5WHAGyqx
 SslnXzK2SYeMw1+ssjXlp05Y9H7anfE/VpW0MCHeAwAznVzDWMYxdM65yJLH4DiMzBfF8SH1eE/
 vjY1Y0xww==
X-Google-Smtp-Source: AGHT+IHoR1FNv21hNSxMAio8UNGaDxftyenzMUFtaJfHmXmKSELU8p5JytmGSbbw3DSEiAtP5naukQ==
X-Received: by 2002:a05:6a00:809:b0:7a2:7a4e:116c with SMTP id
 d2e1a72fcca58-7a27a4e132amr82731b3a.30.1761192912247; 
 Wed, 22 Oct 2025 21:15:12 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/37] target/riscv: Conceal MO_TE within gen_fload_idx() /
 gen_fstore_idx()
Date: Thu, 23 Oct 2025 14:14:05 +1000
Message-ID: <20251023041435.1775208-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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

All callers of gen_fload_idx() / gen_fstore_idx() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-8-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 70c563664a..859cbc26cb 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -349,6 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
     if ((memop & MO_SIZE) == MO_32) {
         gen_nanbox_s(rd, rd);
@@ -369,6 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
 
     return true;
@@ -379,7 +381,7 @@ static bool trans_th_flrd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, false);
+    return gen_fload_idx(ctx, a, MO_UQ, false);
 }
 
 static bool trans_th_flrw(DisasContext *ctx, arg_th_memidx *a)
@@ -387,7 +389,7 @@ static bool trans_th_flrw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UL, false);
+    return gen_fload_idx(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_flurd(DisasContext *ctx, arg_th_memidx *a)
@@ -395,7 +397,7 @@ static bool trans_th_flurd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, true);
+    return gen_fload_idx(ctx, a, MO_UQ, true);
 }
 
 static bool trans_th_flurw(DisasContext *ctx, arg_th_memidx *a)
@@ -403,7 +405,7 @@ static bool trans_th_flurw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UL, true);
+    return gen_fload_idx(ctx, a, MO_UL, true);
 }
 
 static bool trans_th_fsrd(DisasContext *ctx, arg_th_memidx *a)
@@ -411,7 +413,7 @@ static bool trans_th_fsrd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, false);
+    return gen_fstore_idx(ctx, a, MO_UQ, false);
 }
 
 static bool trans_th_fsrw(DisasContext *ctx, arg_th_memidx *a)
@@ -419,7 +421,7 @@ static bool trans_th_fsrw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, false);
+    return gen_fstore_idx(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_fsurd(DisasContext *ctx, arg_th_memidx *a)
@@ -427,7 +429,7 @@ static bool trans_th_fsurd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, true);
+    return gen_fstore_idx(ctx, a, MO_UQ, true);
 }
 
 static bool trans_th_fsurw(DisasContext *ctx, arg_th_memidx *a)
@@ -435,7 +437,7 @@ static bool trans_th_fsurw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, true);
+    return gen_fstore_idx(ctx, a, MO_UL, true);
 }
 
 /* XTheadFmv */
-- 
2.51.0


