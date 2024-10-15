Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF689CFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlG-0002zn-DF; Tue, 15 Oct 2024 11:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlB-0002SV-91
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jl9-0000wI-Fi
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:56 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cdb889222so23524965ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007214; x=1729612014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oh4eoC7A4RtAScWxiuA7lur7cdy4r2Qar3xooL6q0Pc=;
 b=LWLTip+aaJ3Ya7d8LqFjd0C5SRLVH9fi59shFjwu6hM4vivPLjFF2y25Bysk9LVkOM
 E3eYYStVqq+u4igdFV9sHUQZIunC84L4o7Gc9IuIzF3ZjLCPD9XIbV4PklGNaOnEnMVl
 OJXVjTeX2udCqFKGIpFy/CpVjBYvA5X5BNetfCVi2O+4N7WlKZs3kwPOSUg98l1v7FbT
 ul4H27H8dhzJ+wzLECHM8EExgL2jPJGsraIODKeZDQgsE2VhztQvTCaPC3nUG1Eh03Ne
 v6HWwUdINISyXGEinks9c+5zax19nn84W54G+6CvRdPnkJg7EnmwXf+pRusLWqGoMWit
 FdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007214; x=1729612014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oh4eoC7A4RtAScWxiuA7lur7cdy4r2Qar3xooL6q0Pc=;
 b=ebmi6HUsfGgexWUwRDTvP37IAu9QEnLTumGxTLU2/qkTK+EPXg+xHe8UWkOfMuFwqO
 RhnCi6njcGfBxhMU0i6XJtg9VWL9t972xVLVC066chzAZ4qgE7BLftZFtQ3qng86xzF3
 +MdXX+Tz1u6UZJfnCr+3b+4sjF2Pb/xkl3aowqhzdEFm6DAz73LHW5FwDc/dWva05fkL
 RE3EmsR6e3odl/AOvljaWZoSv91L9yvQneZLoYrKazyanf7UcgmOsxXuLjJX2cfx4qRt
 fqVG/5nTfYqQkQYKHIZsMEdBP/jnfAQHivJCBGOiOOLJOPwBAJtIh8XBG1eeYazZoipb
 Jb+Q==
X-Gm-Message-State: AOJu0YznDmuASlyio0g/PcGLvvUdpfPJQfOYrQkl/GvpkMui7punW3Wb
 3Jy3Q5eY0zbZA/TimcWW3vdXqm8T1tH/0Jlpw665/1saP6w1jT2LYe9ETp2hq1WBgYMKQdxhrCg
 y
X-Google-Smtp-Source: AGHT+IEcCDEO14LWzBLs+GMWQirR1q8cmIq9rlQs4gQyMGBCPaSU0/p+LTCkND4/YD8+5qIKQhe0Ig==
X-Received: by 2002:a17:902:fc4c:b0:20c:8cf9:6147 with SMTP id
 d9443c01a7336-20ca13f6106mr185357835ad.1.1729007213720; 
 Tue, 15 Oct 2024 08:46:53 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d180382a5sm13428565ad.129.2024.10.15.08.46.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/33] target/mips: Rename cpu_is_bigendian() ->
 disas_is_bigendian()
Date: Tue, 15 Oct 2024 12:44:27 -0300
Message-ID: <20241015154443.71763-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-3-philmd@linaro.org>
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
index 50d8537a3b3..3deb48ace9d 100644
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


