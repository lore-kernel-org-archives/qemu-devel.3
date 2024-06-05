Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8EBC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMD-0006Bn-NT; Wed, 05 Jun 2024 13:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMB-00069z-Pt
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:27 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM9-0003w4-Ad
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:27 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-681ad081695so20636a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608204; x=1718213004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e/sMbuHp6e8KS7pLRZ3vm91uHnOthMxgaLS9ywSrdw=;
 b=WD69spkZGNAD+yT1YlGCKTVnT1PN5ncStfCZe6wPneDsCZ8Wxjmd370rSL7cSsgqeV
 y1iIeT4mvm4x8sS+ighfWPexSVyTL6DIYzB56hpwODZk3ajReWrzjc8dDfvhG86Uphit
 t6rFhX0/bYFe8jo8ytu+/2K3tO+p0XnihTRSmR5nBApJZn3epbhwJdHKZLy95cIHAMRN
 snndA1Ez/GrvgRkgkD9S7zdjPj3We7SC7ch36UGQNkmlzFFNEyqLtbMJ4VFAjIpsmMJC
 XjfVU3ZlrbdXVRwpufdKCJgbim+JFwGWwr0Y5HWzpcup+LCAAAIzH9ROImJARfxvkxG2
 Y+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608204; x=1718213004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5e/sMbuHp6e8KS7pLRZ3vm91uHnOthMxgaLS9ywSrdw=;
 b=jtQjFKEc8HRfxfq/KYsPdNtfgASHFCmMz/JCJFjBN+ZX+ZnQuEhfIAGwS79/4EIoY4
 DlI8dmC6MBXiWTOHKKMj1fXxJKfUUSwnUsYdDgefx6Z/HhHyShMCABbNmvV5oZ5MF/BB
 TQQgz4AnzQJH6GJrPrwuwOrKLdYoWFeKTNzcxcxcTPee0fJ5GLqNX6ohdjmpq5mLmE5k
 kDoWu4pWl6zdFR011jl4unD/ddYqAGEVyansIz7f1AVdr8LIFCAb2RzFYtLcVcBM95uX
 Ab5KvnwevqzdS07Z9Pu7mODbUpWt8VkSKro04+5PLV4S9vaZVfV+kYiT/Yg01aRSqz8d
 /kgw==
X-Gm-Message-State: AOJu0YxGn4vrDqzQQ96TkC/oUsHMDWka+3IPkjDOes1+XLMAW93mFnxn
 7SvBGImAGhznJxKod/e8rYwo7Zmi4Dz2L4sIJOwrxm+UxEu/MiXJC8nqSlXCNY3KK9SPKFeI6vs
 V
X-Google-Smtp-Source: AGHT+IEv2ewTTvRoyXBm6sqH1tXs3aZRGsdne6v5aVhdC+9A/XhrLRyDv5h6KpQMSqVHtw0mXh8rAg==
X-Received: by 2002:a17:90a:ea8f:b0:2c1:fef4:698b with SMTP id
 98e67ed59e1d1-2c27db53e96mr3554022a91.34.1717608204000; 
 Wed, 05 Jun 2024 10:23:24 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/38] target/sparc: Implement FALIGNDATAi
Date: Wed,  5 Jun 2024 10:22:46 -0700
Message-Id: <20240605172253.356302-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5d85e124ed..0913fe7a86 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -446,6 +446,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @d_d_d
     FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @d_r2
+    FALIGNDATAi 10 ..... 110110 ..... 0 0100 1001 .....    @d_r_d
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @d_d1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6fa0bb6ff5..f51ce2ff2c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -809,7 +809,8 @@ static void gen_op_fpsubs32s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
     tcg_gen_movcond_i32(TCG_COND_LT, d, v, z, t, r);
 }
 
-static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+static void gen_op_faligndata_i(TCGv_i64 dst, TCGv_i64 s1,
+                                TCGv_i64 s2, TCGv gsr)
 {
 #ifdef TARGET_SPARC64
     TCGv t1, t2, shift;
@@ -818,7 +819,7 @@ static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
     t2 = tcg_temp_new();
     shift = tcg_temp_new();
 
-    tcg_gen_andi_tl(shift, cpu_gsr, 7);
+    tcg_gen_andi_tl(shift, gsr, 7);
     tcg_gen_shli_tl(shift, shift, 3);
     tcg_gen_shl_tl(t1, s1, shift);
 
@@ -836,6 +837,11 @@ static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
 #endif
 }
 
+static void gen_op_faligndata_g(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+{
+    gen_op_faligndata_i(dst, s1, s2, cpu_gsr);
+}
+
 static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 {
 #ifdef TARGET_SPARC64
@@ -5068,7 +5074,7 @@ TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
 TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
-TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
+TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata_g)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
 TRANS(FHADDd, VIS3, do_ddd, a, gen_op_fhaddd)
@@ -5229,6 +5235,27 @@ TRANS(FNMADDd, FMAF, do_dddd, a, gen_op_fnmaddd)
 TRANS(FPMADDX, IMA, do_dddd, a, gen_op_fpmaddx)
 TRANS(FPMADDXHI, IMA, do_dddd, a, gen_op_fpmaddxhi)
 
+static bool trans_FALIGNDATAi(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst, src1, src2;
+    TCGv src3;
+
+    if (!avail_VIS4(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst  = tcg_temp_new_i64();
+    src1 = gen_load_fpr_D(dc, a->rd);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    src3 = gen_load_gpr(dc, a->rs1);
+    gen_op_faligndata_i(dst, src1, src2, src3);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
 {
-- 
2.34.1


