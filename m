Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7841CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FP5-00049Y-8H; Fri, 10 Oct 2025 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FP4-00049I-Hb
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOy-0002WB-BV
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso1552280f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111482; x=1760716282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=caCZcdTZcK2izzqG8Sgv3bdl6ME2ZyIpYJtnkxpQrBs=;
 b=bFHEKYtrwJY8BLfd/MJO56JpHTg3U/0ow0wGmqQ6O20Cyj2/E3EXBtKR34PPZnTwkc
 80vOR9VPootNn2fPAGYLGNAjcyU2S10vxRj86hVVe3MsjqsdBqnE0DWd5hkit76s3+Dk
 CdUZlZxis1eGVhqOCyOH+ZNf85BkP6tIMDNt01lGp5CcgmN43nmEMs3Yc/YGN29W0OfM
 ApEuv16Te3gUeWAlK3dROfSZhAIQoGwajYcv3BKsulrjeKhZ2OR6FhhTZd7R9zhzV05v
 m2N9Y/mXR1ZcltPe9joXYuwiV8jPhFMO3oiO8yaB/yb1HaF68lPzzHPbbMHXR6tLRuPs
 cgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111482; x=1760716282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=caCZcdTZcK2izzqG8Sgv3bdl6ME2ZyIpYJtnkxpQrBs=;
 b=KRrvRY+dAPT65PG+awlgTqYcP8EO8UdWUYav1WW1qAREebUmxB2Xcj7PdJinH/BIqZ
 RJ9ZFS2UTGxIu+5PzpKWrmJHvptt35OZ7Ctoew4T232EC8MbzdJXAz3WC9avdKpWrkLz
 +hJDRM1jPPI5XpZnQSlnq158uo+fKWr9hxSAYiMxdrnyiKLYFB5tccuRIRUKo086xBxU
 NLITB98CfqUW3+yOpgM9xWBwo8ZKYMTE68U1d8DxxWz90HJeXtDxV+w3Jgkq0YlnPf6m
 yFbBoxjROElwlv9XA3o+9PVBdzM/gNXUuB97JZCWmYAMshubGXMKYsZy2DhnltaXcUzk
 nQQw==
X-Gm-Message-State: AOJu0Yzx7COC2XlG+hY6gZ3IivMU9Cc06atMu/ayU/Oqy7sBPgYWSIDb
 lDRc98vVROavHThlAFh21xfDgqnq2pm9djnTdKMZzGu4BQDRmCE9R1YiD2R+ovSecpfM53aGMoo
 ue70x3MauJg==
X-Gm-Gg: ASbGnctfFqTlqAyLRdo6B80V3uvs8T0TYFot9XSwQHl9rcTVpeCazH8QxavRT0f/l+c
 3trDl+dLg899XGMH0+3Y8u+IFD8woo9D1dgRZyF2WqWYbT6a8bhAro8gBgJcvABM6scw7diqMHm
 5ayVRWllvWbOnms4oliunAmNjwpApN0KoevZgZO5hRGo3aWHTCJYF+/BN/WtOg3OU/ljGpa91vx
 Yn+drgsJS3ZKR72V6CbUGqEE9ZrasYHRrjrz5IYthVWaqIY6j5jm3AO2+nSr9opR66BmmK6Wby1
 VtxqrL7AuBLgSqXu5gYG4AgwbKBc0az/M2X2Pxh8kqJXvfDmSTnDJUUNbQnag9Ubw2Th0Aqr0HE
 Li2xA/mWb8K2oKZYHrFcmcic2CS/3FadudVm0b7ULNwni/4L0X3wULi9PkOPqrv67e2kHZWFjcO
 2WvsP2EddGoB1f9VHhp/M=
X-Google-Smtp-Source: AGHT+IGF7GmDeGBEtquYI6CzkkaQKIuOdBtgkItLXocniOCzY4QqLiy5I42+Z8c9SucK6vOSORVbEw==
X-Received: by 2002:a05:6000:2483:b0:3eb:4e88:55e with SMTP id
 ffacd0b85a97d-4266e7dfaa1mr7815794f8f.41.1760111482482; 
 Fri, 10 Oct 2025 08:51:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8207sm4622865f8f.47.2025.10.10.08.51.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:22 -0700 (PDT)
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
Subject: [PATCH 07/13] target/riscv: Conceal MO_TE within gen_fload_idx() /
 gen_fstore_idx()
Date: Fri, 10 Oct 2025 17:50:38 +0200
Message-ID: <20251010155045.78220-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All callers of gen_fload_idx() / gen_fstore_idx() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 70c563664ab..859cbc26cb2 100644
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


