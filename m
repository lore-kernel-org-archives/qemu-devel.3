Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99074D24458
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz13Q-0007Ik-5j; Thu, 10 Oct 2024 17:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13O-0007IO-HS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:38 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13M-0004dn-Rh
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:38 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e9fdad5af8so986999a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597035; x=1729201835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFvM5p2iz7gGtejSk+Rwmp+tzqXM6h+c71GxLbFxjzg=;
 b=m42u07vwUDDRSZb4mWaJ4fDZFU8d/tnRq6a+i+ChGXkDTW3fJoabyKPw+gf4s7sFiq
 Qc8cIKScq02i9ofoSr77zclVrs8PuzQUJHVpxdgv2R05F7rzfWEJv9SaLCGOmBh4eJw3
 cr5//dcIxqAbll/nOv6UGroCDrBnG5knsa83wuCXLAfmPOVvjdYysO1/7rtuMHYpe1OS
 knrhzw8dFWEkK2iKDeYPQZnFR01Z+XvZY9x5OgwhpNy7/lfY47SJ3TZG6BgFozz8cady
 UycGOKa5Hhc+sz/8hflGwdxweGZ7ITZKMGt2iowYU5YtKqp9cDTy+Z7uimzdaM6+0sN4
 aqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597035; x=1729201835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFvM5p2iz7gGtejSk+Rwmp+tzqXM6h+c71GxLbFxjzg=;
 b=s8IwcloOZKOLrOVWzXijO5LlgsEysGvhaPHaI4vRMnNXcgUuqjzQhjXLi280nepYzc
 kxq1PT+rWKwICrSWkTNmiQ8xyiWLfWC4KzVGVP6XfGrPQ3jaZp3gFWiWmRmMgGnp1xO5
 WE1BjSIi0rG2S224OO369GBC76jmjGEqqczwrlkNazNjbHZuA7heYQMSLMe/R9mpIW5v
 0DrurhwknIEkqBIAGK3+EHOoehEiR9YcJhu+99Z/3nrcbTfXG7PaMx+zeDdE2KhGIItq
 h5bM6FUkD11iCAHD1jkx/FSITpoJQP8M7ic7mezFvPtZ/8bgKWjaOKewXSJaXd0CZ2kP
 cZbw==
X-Gm-Message-State: AOJu0Yys8wb6jXwZUkVObEmwcTB7KBoHsSZne9vvS00HEq6aFpyVdDIE
 FBVItYooVZ17fbT0XibnNNbEmtxFIvhe54vYQ1MwRYrYAeCxNkAUl+iPTGFb1zdsQwtDItuENin
 9
X-Google-Smtp-Source: AGHT+IEwehXEfqlyGUt3bHVES0e1gA/SJKC260SeDFjRAfvsNXy/3mYlWpVty+uXx4KwTiafRbEviw==
X-Received: by 2002:a17:902:e5c9:b0:20c:805a:537 with SMTP id
 d9443c01a7336-20ca16d6c8bmr4649145ad.51.1728597035248; 
 Thu, 10 Oct 2024 14:50:35 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c212d40sm13711015ad.195.2024.10.10.14.50.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:50:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 02/16] target/mips: Rename cpu_is_bigendian() ->
 disas_is_bigendian()
Date: Thu, 10 Oct 2024 18:50:00 -0300
Message-ID: <20241010215015.44326-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Methods using the 'cpu_' prefix usually take a (Arch)CPUState
argument. Since this method takes a DisasContext argument,
rename it as disas_is_bigendian().

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h              | 2 +-
 target/mips/tcg/translate.c              | 6 +++---
 target/mips/tcg/nanomips_translate.c.inc | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 2b6646b339b..e81a8d5eb9b 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -235,7 +235,7 @@ bool decode_ext_vr54xx(DisasContext *ctx, uint32_t insn);
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
     { return FUNC(ctx, a, __VA_ARGS__); }
 
-static inline bool cpu_is_bigendian(DisasContext *ctx)
+static inline bool disas_is_bigendian(DisasContext *ctx)
 {
     return extract32(ctx->CP0_Config0, CP0C0_BE, 1);
 }
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 333469b268e..9a855e6547e 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2010,7 +2010,7 @@ static void gen_lxl(DisasContext *ctx, TCGv reg, TCGv addr,
      */
     tcg_gen_qemu_ld_tl(t1, addr, mem_idx, MO_UB);
     tcg_gen_andi_tl(t1, addr, sizem1);
-    if (!cpu_is_bigendian(ctx)) {
+    if (!disas_is_bigendian(ctx)) {
         tcg_gen_xori_tl(t1, t1, sizem1);
     }
     tcg_gen_shli_tl(t1, t1, 3);
@@ -2037,7 +2037,7 @@ static void gen_lxr(DisasContext *ctx, TCGv reg, TCGv addr,
      */
     tcg_gen_qemu_ld_tl(t1, addr, mem_idx, MO_UB);
     tcg_gen_andi_tl(t1, addr, sizem1);
-    if (cpu_is_bigendian(ctx)) {
+    if (disas_is_bigendian(ctx)) {
         tcg_gen_xori_tl(t1, t1, sizem1);
     }
     tcg_gen_shli_tl(t1, t1, 3);
@@ -10856,7 +10856,7 @@ static void gen_flt3_arith(DisasContext *ctx, uint32_t opc,
             tcg_gen_br(l2);
             gen_set_label(l1);
             tcg_gen_brcondi_tl(TCG_COND_NE, t0, 4, l2);
-            if (cpu_is_bigendian(ctx)) {
+            if (disas_is_bigendian(ctx)) {
                 gen_load_fpr32(ctx, fp, fs);
                 gen_load_fpr32h(ctx, fph, ft);
                 gen_store_fpr32h(ctx, fp, fd);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index b4b746d4187..6e0df1a8c36 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -999,7 +999,7 @@ static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
 
     gen_base_offset_addr(ctx, taddr, base, offset);
     tcg_gen_qemu_ld_i64(tval, taddr, ctx->mem_idx, MO_TEUQ | MO_ALIGN);
-    if (cpu_is_bigendian(ctx)) {
+    if (disas_is_bigendian(ctx)) {
         tcg_gen_extr_i64_tl(tmp2, tmp1, tval);
     } else {
         tcg_gen_extr_i64_tl(tmp1, tmp2, tval);
@@ -1031,7 +1031,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
     gen_load_gpr(tmp1, reg1);
     gen_load_gpr(tmp2, reg2);
 
-    if (cpu_is_bigendian(ctx)) {
+    if (disas_is_bigendian(ctx)) {
         tcg_gen_concat_tl_i64(tval, tmp2, tmp1);
     } else {
         tcg_gen_concat_tl_i64(tval, tmp1, tmp2);
-- 
2.45.2


