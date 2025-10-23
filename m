Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4374CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjA-0000aw-IE; Thu, 23 Oct 2025 00:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmj9-0000aM-Ax
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:03 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmj7-00076Y-4D
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so308256b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192899; x=1761797699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHjfQYpCTiW1R4NgEmT3AjTpMFUr4UkyBfGUa9q+sU8=;
 b=hZitf5Pp6YPGOEF7HuukhO5iJFglCM4MEOl3bqK4pTbq7/FezrA0Cd7tOLSuIwAp6x
 udXYfp4aMj9M7iWQ+p+A+e6+lOxv/DZpvwJh6n7kOxTFFX8LNZX4mYyziskwl1Iy4FGT
 995W8S7BibhVmk9GtctB06Q84e0A9o8Dx4AvF0Y90CjBWSXaHbtJcp3+CAGiWv9EQo/o
 QyKZSYn/uTmghulDvwtohPynCfGKEhoVPiVdcP7CK7Dr3AheaxavPBuA2ozfgpZm3FOt
 mqDL64pjvicZrWQ3ZJDhrgqhKk733qOQ2LA5Qo7jAsKmjPrz/hZfwI4oFlsb++nOPdUc
 8gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192899; x=1761797699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHjfQYpCTiW1R4NgEmT3AjTpMFUr4UkyBfGUa9q+sU8=;
 b=i2As+xQIsyg38JXN3NJbCwfGBCvsD1FWWZxQSFx81LHqsExnOLWnBZ22HbQ3VoKGAV
 6kvdeYiuFcvxsc5CL1mDYOFlJOp0NzI1338hoyTRouoJ7VwukuvPKOJN2uPaRn3i35DM
 7qP07X9dVu6pGwyP9TevsMUwK2Kd75laCqVJl5R5K1bCnVCRFSf8w7E8wXSzvbQwitMT
 Ar01s22VsbF0QhaqcAQzmCrU6/igkLuq922l+deZltv6IAn5WGR/YCAc5C+nqUKCMkoh
 DOfHgSKbXCF05QzYri/X9d1P8DoWiuzyHTPUGw15ACTPPFqW/P+2iba6obrblCQMDmmj
 PreQ==
X-Gm-Message-State: AOJu0YxOSbdCQmESe/rfW50gsRZZMsCCig6IhsOJ0MjwmrRxFbbnDCTY
 /9qo1R4LScGrurpnOe8viR2Yq85wNyklA0KAydp9sBjPggRgjXpK4r5hIEhwKg==
X-Gm-Gg: ASbGncsgq6X3qf+Nv5mKBcscrVHix0K9jPLNbtLrdmcU0aFCrmRCSdPvba6DqrHNf5v
 RsyG00h6FKPK1+nzZ7MmnFINHJSrjOPiN0ydECNapkvNGI8/6dlYcnLfD1U1QowatYMG+AnF13p
 5r/No9egM/VwG1ALrqmD2oOYUYl23XiktnNGkpV1JNb2Uh2STq676+fPgVNo9aMzSMjo1wY9+x0
 Ew6x2pD7Qp3xtJHTIPUN3yQKGVlmz7U+5g9QgYKa4HWEHBWAFlY0sXiKJ8BpjtycCEt58/YValf
 TO4X+smONt3uX14IQOGZCV70sJAVyW0d6bmV1DYZTQcgRjFWqGlX1mlnTpvqtIgi6ATwH03UHtj
 9g7tcPx1hPqman6s7JRPKBwQJYCwjbMB6kbLcRInHQuQ5xBcZBQ4xfvTo+CdOnHqL4N6XxPDxvB
 lsvZhjBVaj6jXkuUUjbgs4UBvFvwgzAuowh8nV/z7D4DGWYbyjock8T6QihJclpGVztFWmS5ULW
 UStf6Kr11Dy2aU1uklXT7ShLbeSGrw=
X-Google-Smtp-Source: AGHT+IE/dEGJvdoI2bBCIbaxySHuca3FdghsSHiOi0+wq7ET/O7+8TRnr9iVrOPES6w5W6QtYGXy8A==
X-Received: by 2002:a05:6a00:124c:b0:7a2:74e5:a4a4 with SMTP id
 d2e1a72fcca58-7a274e5bcf9mr1453646b3a.19.1761192899199; 
 Wed, 22 Oct 2025 21:14:59 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:14:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/37] target/riscv: Conceal MO_TE within gen_amo()
Date: Thu, 23 Oct 2025 14:14:01 +1000
Message-ID: <20251023041435.1775208-4-alistair.francis@wdc.com>
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

All callers of gen_amo() set the MO_TE flag. Set it once in
the callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-4-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                    |  1 +
 target/riscv/insn_trans/trans_rva.c.inc     | 36 ++++++++++-----------
 target/riscv/insn_trans/trans_rvzabha.c.inc | 18 +++++------
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9a53aecbfe..94af9853cf 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1135,6 +1135,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
 
+    mop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 10e4c55efd..e0fbfafdde 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -111,55 +111,55 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SL);
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SL);
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SL);
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SL);
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SL);
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SL);
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SL);
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SL);
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SL);
 }
 
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
@@ -180,61 +180,61 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_UQ);
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_UQ);
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_UQ);
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_UQ);
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_UQ);
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_UQ);
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_UQ);
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_UQ);
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_UQ);
 }
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index 25db42d24c..c1f99b65f0 100644
--- a/target/riscv/insn_trans/trans_rvzabha.c.inc
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -79,55 +79,55 @@ static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
 static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SW);
 }
 
 static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SW);
 }
 
 static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SW);
 }
 
 static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SW);
 }
 
 static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SW);
 }
 
 static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SW);
 }
 
 static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SW);
 }
 
 static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SW);
 }
 
 static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SW);
 }
 
 static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
-- 
2.51.0


