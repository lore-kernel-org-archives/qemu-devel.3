Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D727CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQh6-0007ZC-Mz; Tue, 16 Jun 2026 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQh5-0007Xn-4E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:55 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQh3-0003FX-7L
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:54 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36bcf3d2565so3097216a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604412; x=1782209212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+HrF5EfmwyUjjCdSqJXZticw303vVGEPApGGN1NrVQ=;
 b=bHiO24hdeyx9bAgi5tWrNOMEpmdlPsN3QUSkffQXQZHI3sFpvIN/is1MXma0jti7v4
 xeO/bBP6X3hWWYcmiVQEt/0Ac1UTkfSLUykY9sQtKl0DsY/cNV8KiiEzpALVi75Mxs7s
 6QAvW2f7DwFNClt2FfTdBeiXLwmkQIxWHboAhpfSK4Jwz2YFaMGtmd4+B4Ec/jSZ518i
 PBWV0hb/mveShxrYvfH2zYlriWGaZ9b/ZaC12uiS3aoCbxDbvPl9m5f8so4YwxVMyX5G
 4N6iFAZMphLZN12MJUcTr0H1kH/fHMzx+QhJJ7EgGTYBXD9ciojbzNERY5KMMGE4SvU/
 jMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604412; x=1782209212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+HrF5EfmwyUjjCdSqJXZticw303vVGEPApGGN1NrVQ=;
 b=mOq7O1kUGtrpiTQx+ZdgoGrUurmYqkBt52BxIjv3LRiopLUhB4qPlpUhWaaiXd7Smm
 in84Z+XZeLWuKY9dWJ+jKMV98rGCEV9CgfpmseUh3mtPOuwZ43dCv7SAVF80Q9bDTQyT
 rjHMIvdD89qNUED6IQOeXY6D+iciXo0SYI3bf0c87/+WHRvOrihCdmYa4mdjlW08PnjU
 IO2wFBb9mLuzu4STCbNk3GJsgiiyy6rjh51YVX/0M8uxgQgOiRPfjfH8OOC5oD31gLZG
 jYI0dvBjTsj9PZHTEXd6g2XJ0c7kf9SLD5IIfQFuwbJ8CYND3z6UK6Qvyq5Yfo9qgmsy
 0gAQ==
X-Gm-Message-State: AOJu0YwbgxRIV9QpDE0VXzvJ+zmJ5mz40JWfe7O9PjUiZqCgYEI9Zwsi
 WryrP9zUJiJ8xLWtB+ro8FALhilEw+GzaZyhL1SrpNlIYWnpLORZvGr1ORgSL6B1
X-Gm-Gg: Acq92OFR4ouLCqEYyw5O4XJXDt/cbz7whwI7H/8hXvyHDL2IGJLg65QdpyLloZVflX3
 KZOHkSIRzwbqIHPm0OVNVNtPFyb/Qhy35HnGEeZTNnBuQ+3SSBDpa8JqONKMLNtpzSlLXSx9YuZ
 6ZbGSizYEN8nWuFW2f1UuVMe9gwjkgo6vzo0HxXzJ6oloP6dohYU2KsEmype5bjj+BgYbUQgIRt
 1c1awohgwp30GQQ2uzrsY+zMo6N1K+yekKFNJxiSCXvMMeQ67jRkqWXChGoKaf11G+K/Am75rNw
 E9d9BZcdCjWJkwi3SZLSNtNq9b6ASGwaM0wHSeKkt7tqI2GUcVcivqMh0P0aBmIZmYmDxPmzeAB
 jv7RmRx3QBjfhHgLTc0XWZl9lxYR09R/7fpfR+1BkbOd6a5CyQWLQL7M6wyQxizp/A/oAF0sS0u
 TvxsH//2+z1C49sL65FnZDH8RLelIlHk+qt5kjoWzghMe6sjdMrM0=
X-Received: by 2002:a05:6a20:144f:b0:3b4:6265:3788 with SMTP id
 adf61e73a8af0-3b7963c9ce7mr19034240637.21.1781604411803; 
 Tue, 16 Jun 2026 03:06:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/83] target/riscv: Fix size of sw_check_code
Date: Tue, 16 Jun 2026 20:04:25 +1000
Message-ID: <20260616100527.1939565-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Anton Johansson <anjo@rev.ng>

The field only holds values of 2 and 3, fix its size to 8 bits and
update stores from TCG.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-12-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                            | 2 +-
 target/riscv/translate.c                      | 4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc       | 8 ++++----
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ef21972615..4794489ec3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -261,7 +261,7 @@ struct CPUArchState {
     /* env place holder for extra word 2 during unwind */
     uint64_t excp_uw2;
     /* sw check code for sw check exception */
-    target_ulong sw_check_code;
+    uint8_t sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9a0fd700d2..6a1ae92e5a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1400,8 +1400,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (ctx->fcfi_lp_expected) {
         /* Emit after insn_start, i.e. before the op following insn_start. */
         tcg_ctx->emit_before_op = QTAILQ_NEXT(ctx->base.insn_start, link);
-        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                        tcg_env, offsetof(CPURISCVState, sw_check_code));
         gen_helper_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         tcg_ctx->emit_before_op = NULL;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index ff450d46f8..fea05d02cc 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -53,8 +53,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
         /*
          * misaligned, according to spec we should raise sw check exception
          */
-        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                        tcg_env, offsetof(CPURISCVState, sw_check_code));
         gen_helper_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         return true;
@@ -66,8 +66,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
         TCGv tmp = tcg_temp_new();
         tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
         tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
-        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                        tcg_env, offsetof(CPURISCVState, sw_check_code));
         gen_helper_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         gen_set_label(skip);
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 40e5a1b7df..cb9c5419fa 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -40,8 +40,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
                        mxl_memop(ctx) | MO_ALIGN);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
-    tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
-                  tcg_env, offsetof(CPURISCVState, sw_check_code));
+    tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
+                    tcg_env, offsetof(CPURISCVState, sw_check_code));
     gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
-- 
2.54.0


