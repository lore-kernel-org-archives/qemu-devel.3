Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75815C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGb-0005sb-C6; Sun, 23 Mar 2025 13:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGX-0005q6-NI
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:41 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGV-0002uD-Uo
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:41 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so7017751a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751458; x=1743356258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKxBSROc4fhAqj5Wcj6941rZxM/sEBCStnSlK0YH6kE=;
 b=BSCOsNn+RrVlvksWYlHTa9OlrmJxL2YQg1V947Y72dmwRXXTECUIlqGzPedo8XGaU7
 ekrH6RwflwDHIy9v0ppTvfvxKJCMA90cSvhtUtXc3NOdXYeP3GoHjAsjJSTBHy2Kg0I8
 9E+4ZqeqnpQxgVayeUEdBty6GRDjMoUqDQcaGpO3G6dLsezTUOyFM5ZWqT/ow7Oq0Qgd
 rZ8pl9kJ8DLOEeOSpS8OzTVjshqzgXbkK/prWlVwUe6H8s5vyuWuNZX9a6twwhGxVU7J
 sncoIw6mXaDkrTh94dNlj1dJlJzFoZDKz6NflLLchVEZQSad28dhr8otMfwwUVFdxibv
 eabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751458; x=1743356258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKxBSROc4fhAqj5Wcj6941rZxM/sEBCStnSlK0YH6kE=;
 b=wI7V21w/wo75vpXO3n77WO91WxeU7Ta5Ny6AJvV20G6qUKjl56SbG/xsDAO/bNAgoR
 qO22Ly+wOPHGFDvZ6544BUiI4HRbhH6lpEO6Nvi+xVxubQauqyV05CgXCra+hcOw4lQb
 KdAa+snKISQicY6tzi+PJY/meL8A9bJqgDFNeRxrygV4fE6YeSugQP8QyFr1dQ/PUEUd
 33hFbixF2D5ZsREJH583cGpmwrnpuD/3fL9mViqCdlNXBp5xXl/ADk4jRqP4AXmFdtHC
 Lnc19woHIv5NrJYK8acqvskFKADeTdOvyLraILg0sTpiGrkPv1AKabcecR7TYbxbz1+c
 xgWg==
X-Gm-Message-State: AOJu0YyFwCcGUupqLgH5VAffNXndoV290sJWYglEhzMkDpbVM/LGU0AK
 V3Z1sL43P55k1LsBaVR83BjPDTWHy+5YwmlxWMlFapE5sABkJgYfa+myFtLVcTwZ6cZSrL2H90o
 4
X-Gm-Gg: ASbGncvmXz8aoDgqsY0BMQrwTo7FRkRdY4eM4KhLXMHLh2JVN/JHTqs7x+h44duONUU
 F0uAqYBu2CXfKq18re/m2Begu6ezTB1gKqXuM4ytWaKPs/KjjY8fqYiIdpsPWIGdH2ARF7ibtoN
 Hgk7Rfzh0svgR22TVaJvjjJguD1E92/y/d30f6YYnFeeRH5LZ7fbSJPhtJrDOLm7UaEcQt1FsGy
 1neAF/gyxW8crfVwSdbYEQrh7cRF6sIULSlwvxNV0UrGzhq5zCcvh9qf3ynIxvoF7QVhsI7zHKO
 Ma7UM+AMgDmsJZ5Qw7wIPDjbCVENnq8rNZMNhEBgel8ybTOe2jE6Kvh0FqQCQ8cnRvPL0KSMI3+
 m
X-Google-Smtp-Source: AGHT+IEajP91z75ij7xeEfQRGHNWuLk/kKXx+wbyQCdKDelckUwcG1W4W5QhaGPOphqdkjgBmYOoew==
X-Received: by 2002:a17:90b:224c:b0:2fe:a545:4c85 with SMTP id
 98e67ed59e1d1-3030fee95b1mr16929947a91.27.1742751458085; 
 Sun, 23 Mar 2025 10:37:38 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 09/17] target/avr: Introduce gen_data_{load,store}_raw
Date: Sun, 23 Mar 2025 10:37:21 -0700
Message-ID: <20250323173730.3213964-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Prepare for offset_io being non-zero; also allow folding
stack pointer offsets into the arithmetic.
So far, all offsets are 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index e9fef1aaad..6bb4154dff 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -198,6 +198,28 @@ static bool decode_insn(DisasContext *ctx, uint16_t insn);
 static void gen_inb(DisasContext *ctx, TCGv data, int port);
 static void gen_outb(DisasContext *ctx, TCGv data, int port);
 
+static void gen_data_store_raw(DisasContext *ctx, TCGv data,
+                               TCGv addr, int offset, MemOp mop)
+{
+    if (ctx->offset_io + offset) {
+        TCGv t = tcg_temp_new();
+        tcg_gen_addi_tl(t, addr, ctx->offset_io + offset);
+        addr = t;
+    }
+    tcg_gen_qemu_st_tl(data, addr, MMU_DATA_IDX, mop);
+}
+
+static void gen_data_load_raw(DisasContext *ctx, TCGv data,
+                              TCGv addr, int offset, MemOp mop)
+{
+    if (ctx->offset_io + offset) {
+        TCGv t = tcg_temp_new();
+        tcg_gen_addi_tl(t, addr, ctx->offset_io + offset);
+        addr = t;
+    }
+    tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, mop);
+}
+
 /*
  * Arithmetic Instructions
  */
@@ -940,21 +962,21 @@ static void gen_push_ret(DisasContext *ctx, int ret)
     if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
         TCGv t0 = tcg_constant_i32(ret & 0x0000ff);
 
-        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_UB);
+        gen_data_store_raw(ctx, t0, cpu_sp, 0, MO_UB);
         tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
     } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
         TCGv t0 = tcg_constant_i32(ret & 0x00ffff);
 
         tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
-        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        gen_data_store_raw(ctx, t0, cpu_sp, 0, MO_BEUW);
         tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
     } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
         TCGv lo = tcg_constant_i32(ret & 0x0000ff);
         TCGv hi = tcg_constant_i32((ret & 0xffff00) >> 8);
 
-        tcg_gen_qemu_st_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
+        gen_data_store_raw(ctx, lo, cpu_sp, 0, MO_UB);
         tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
-        tcg_gen_qemu_st_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        gen_data_store_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
         tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
     }
 }
@@ -963,20 +985,20 @@ static void gen_pop_ret(DisasContext *ctx, TCGv ret)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
-        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_UB);
+        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_UB);
     } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
-        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_BEUW);
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
     } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
         TCGv lo = tcg_temp_new_i32();
         TCGv hi = tcg_temp_new_i32();
 
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
-        tcg_gen_qemu_ld_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        gen_data_load_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
 
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
-        tcg_gen_qemu_ld_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
+        gen_data_load_raw(ctx, lo, cpu_sp, 0, MO_UB);
 
         tcg_gen_deposit_tl(ret, lo, hi, 8, 16);
     }
@@ -1498,13 +1520,13 @@ static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
     if (ctx->base.tb->flags & TB_FLAGS_FULL_ACCESS) {
         gen_helper_fullwr(tcg_env, data, addr);
     } else {
-        tcg_gen_qemu_st_tl(data, addr, MMU_DATA_IDX, MO_UB);
+        gen_data_store_raw(ctx, data, addr, 0, MO_UB);
     }
 }
 
 static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
 {
-    tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, MO_UB);
+    gen_data_load_raw(ctx, data, addr, 0, MO_UB);
 }
 
 static void gen_inb(DisasContext *ctx, TCGv data, int port)
-- 
2.43.0


