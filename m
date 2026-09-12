Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A97C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L58-0000uw-EM; Sat, 12 Sep 2026 06:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4t-0008F9-Cs
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:23 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4p-0008KL-5f
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:22 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469e25400so531584b3a.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209317; x=1789814117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UbgM0h6t04svFpwEFwCrC8F5A20yvLD6K7H04+4hfg0=;
 b=J5ycFYLAbVK9FB7Wh8a7IvGSOwmuMK+EBQhRefKJ+zZkInDgUOAqGKu6l0q6udXvp3
 lLRlwpSXET3UGDrjUgZktfqBFJ6NJV2SXFgTLQGfOX9p8+QNRhcO+C4hC5ii8Ou0+tCX
 vwfukxmD370nyZfiKExMDro7IzwIvJ0K12H1vxutI0YgcgWfA50iRxp2EN5CfR8m7I7g
 sLC9dRsvqZcNDs4GighBZLj8PSk0CyxNM2mGKuIGgkC6UUvSxSwejEvK3C0CbUxG5mRk
 EEut2U30DMxHzy1NFUfwQuC+wolKKw8wkPgwlphP/4/olxmYFVlKRavOC2ZZTJDjkf8M
 MFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209317; x=1789814117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UbgM0h6t04svFpwEFwCrC8F5A20yvLD6K7H04+4hfg0=;
 b=I6xv13w+vkXX8VFMsoU3+VEhZu9jXftUUcM80iGb0ywLiMrkbt7mRxZE3+3EQQbGr1
 Up1i0GiVqEc1+uScWhpN4ja1I++wnnAiQtMO1ozyBHyHEjwfMM7fWPF2tPMp7wZyGUq/
 EsDMxzjDPtgkE5c0NoJQcChucrVoOgR6iSd92oyQFH/sCttAgbDneUxnbzFb4qZ2VeH1
 pHsvTTlwh8bpYA0W76ojxkyLUZbeIPiF1u1Yiab8eaqzcWK8BhZ82J2BoXF+N9zIfCpk
 ASQE4XN7LRy1CxML8twVM5NUvDtWx9qmvVy8A4KuQXcX2k3pGvjt8rQRt8kA0ot93tvZ
 sHow==
X-Gm-Message-State: AFuF++m3wooHVrI/SuG8XvRqqOyXepRahlknK+BgdRqhX8eCU3QSbOK7
 eXUBAGQpgDkjm5F8Cx4gfvo/U4LrYZnsw1vulYLkl857tHwbFHPj181s+wnuYRxi9+u5sW1jZ73
 /q6Zx4LU=
X-Gm-Gg: AYBFou2L7jZNy92o1N8AdhFwif02JJW/IClrYs+8IdgniPlI1bI6ie7OhRz1wEib1xf
 3KG1VPAcbrASFONUcWt2BH3wdQJH+NnWgYCB4GK9TLDHz16KmbHZHD4CnXWCS7xqXykmoWTR54Q
 IMk483/sGAoWw0nOISi3XVMuJj809HfDkBBLY/wV+oN7XsZg6bOg5fdeEU8PlaEXQSh5GPEEWtO
 yy3HRNzzw3azQvsh1Iqr7SSeUzS74G0013UE2GFCufuBADbq6zUm73px/noLYmWabqlobKoz1gy
 2M2uSfqYRtm6ddjjjflbLf0dxCWlBnq6gyAvpM7DDRaDqIuoCcPiUJBNMR+Wx0A1fg9SkdjxGDe
 cM7ypB2qv7blwJBZep/N5DkV9lK40aRx6JIU4PuD8uaAjIDWEKTiQpkBaWvnlAmuf85JiMR7qUL
 5jgg+S8TwGaeqivEW5Gc5sv76hVgk+vOmSNC6YFI1m9Nh63y5XhPVRc/ln4CtHOttNZG3OHCUZp
 WOjF/0=
X-Received: by 2002:a05:6a21:113:b0:3c3:875d:7053 with SMTP id
 adf61e73a8af0-3daed2bd99dmr17268057637.8.1789209316865; 
 Sat, 12 Sep 2026 03:35:16 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/82] tcg: Use signed integer for tcg_gen_{clz, ctz}i_{i32,
 i64}
Date: Sat, 12 Sep 2026 00:30:53 -1000
Message-ID: <20260912103126.598030-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

We use signed integers for all other functions, and the
sign of the second source is not meaningful here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h                | 8 ++++----
 tcg/tcg-op.c                               | 8 ++++----
 target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 62b8a579691..1a58971d211 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,8 +143,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,8 +203,8 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 217dc3409b8..beaa9024369 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -873,7 +873,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
@@ -918,7 +918,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
@@ -1794,7 +1794,7 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
@@ -1828,7 +1828,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index c3d8bbf2670..4e521e44bb5 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1551,7 +1551,7 @@ static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
 }
 
 static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i32, TCGv_i32, uint32_t))
+                     void (*helper)(TCGv_i32, TCGv_i32, int32_t))
 {
     TCGv_i32 t = tcg_temp_new_i32();
 
@@ -1567,7 +1567,7 @@ static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
 
 #if defined(TARGET_PPC64)
 static bool do_cntzd(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i64, TCGv_i64, uint64_t))
+                    void (*helper)(TCGv_i64, TCGv_i64, int64_t))
 {
     helper(cpu_gpr[a->ra], cpu_gpr[a->rs], 64);
     if (unlikely(a->rc)) {
-- 
2.53.0


