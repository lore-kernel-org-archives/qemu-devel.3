Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948D2C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONZ-0001E8-RZ; Tue, 01 Sep 2026 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONY-0001Dj-Vb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONX-0007KJ-7h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:20 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c25366c9b42so102363666b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268698; x=1788873498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uVPxQDhxI2au/Ew0b23LZPt7RptISjtkf7L0+V6de5Y=;
 b=v1I23qXb0SbgniHXo0Tbg/5lva4h1WXXe063f9r6aoHW86zQuC/hOjhajcYYFoS1W5
 CCftWimtVqs0Fu9vy0llzHpvmMQWh1zFkL5tm2fN4xaFchFrdMnW2ch3p+NOzoSK7QSh
 4Afr0qqunPSAV8vxK+b+9SMluhaz1Ihmth4aFxzMt9l2AtxbdY29bQon8UhF/bg5+ZNc
 HRE4CzYWjlqOJYee4uzOzcULJJ4Cq/e3P5LlckitLZwCxuc5XkpUh2L27FbGPC+uCENc
 jwIM8LlXwNcJnkSsvlyylzvQp/mqrAGQL5rkZff5xXro2HAeZcfQiR+M0gARW4gD3qLa
 DGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268698; x=1788873498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uVPxQDhxI2au/Ew0b23LZPt7RptISjtkf7L0+V6de5Y=;
 b=SWfqBNhWD8MPXVuTDDJu417sDAdD7QUh1IgN58Ay3rYarirC8qt3QX+n9hWk4t5kvK
 aJh17TYOfDnfM3LMk7jQqa4Un+xjvxZjFg7Zm/g7VD7jD550nkDhcauaYJbqx45D6uTC
 07XPb2JZzVy/I1sUAziw3cM9r6Sn1nDL8719SXJRiy06zl+g5TxARSNcV1/sz2YKG5Fe
 PLW33vATQ9WK4rPR0NlKEpcW0lOEaXvce0ZzgBffVEDPJPAjvrQr+jhV+XWJ85hgNMvF
 aqmYULiTlbXnw7RRFrdUsScygrj7hDWul4ABHnMYVrGQjAw9DoRiqV4WeW80cnCAUQcC
 bHUA==
X-Gm-Message-State: AFuF++miwnMBEec7z6Cooa27sO35ztk2EUb0n05DL+7YkV6q6rmgNc4W
 j2SbWnIVhxSUxCoG3r5tqEdVVpeZ4qgURtkEkZfv5unSJzSqkkOn6bI3UaVZFK89j4DCSlt403V
 31UhpKYQ=
X-Gm-Gg: AYBFou3nH0BTOUqIY71kg8zXGqZVj7IV4QXloEWPb6POxKu+g05+ci9i35+6t1tse/c
 v6VevaB/PXnCFrvlcSF3XK3cjzqlqF5lv+4dYg6VHHCZyb2OmHb2sii35sxzRwTDrRW6YeOHWi/
 YI13Mk22Rs/7q3sIXz21txERuqx2yUgp9HWrELmlE3sUG9Dh8ZX3fxH67qK0CnWL5c1iGlTDA54
 eaXqnCKkpMAuSIKON8/dUDYXFFY3AaJ3OOa45jQFLahPYun7Pql6h1y+Il0evErOLHF30qgbQH2
 1i1EqmxT3Mn3C1fGbu+7+vPNPH54AeZa87TSfPs1JSYKku6IiMkWPC1eaZNXsmLOP5VGTRtLNQW
 26m/cNu2IbzF1RZ2pFiuuUaCy3/D7hfT6YGbnfC/Seu70UWq+TuYQvYH1+p6yX0TduNXSKqmn7d
 NjT2GcRb6E777CtbGC9Fj/lpNi4cA2UFM1XpNm8Nk3h5Aj/yLkbR3M2lDGLN3ep482iBOyqheSe
 Dr7WSoHWj4QltLLILTIdZA8H1WRhvSUHTwF6qJjBjp5qAveTZ+noDGoPhdo4CbtpXJCChz5eh31
 nd7W
X-Received: by 2002:a17:906:6a29:b0:c20:9447:bd6d with SMTP id
 a640c23a62f3a-c25574337a0mr2279011166b.11.1788268697734; 
 Tue, 01 Sep 2026 06:18:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/58] target/arm: Implement SVE BFSCALE
Date: Tue,  1 Sep 2026 14:17:18 +0100
Message-ID: <20260901131732.2263947-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        | 5 +++++
 target/arm/tcg/helper-sve-defs.h | 2 ++
 target/arm/tcg/sve.decode        | 5 ++++-
 target/arm/tcg/sve_helper.c      | 1 +
 target/arm/tcg/translate-sve.c   | 2 ++
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b803fff2ffa..60463a67431 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1585,6 +1585,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_sve_bfscale(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16) >= 2;
+}
+
 static inline bool isar_feature_aa64_ssve_fexpa(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SFEXPA);
diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index 19bd936f6ef..f78e77662de 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -1303,6 +1303,8 @@ DEF_HELPER_FLAGS_6(sve_ah_fabd_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_ah_fabd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fscalbn_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 07dac681acf..ed19ae237f4 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1196,7 +1196,10 @@ FSUB_zpzz       01100101 .. 00 0011 100 ... ..... .....    @rdm_pg_rn # FSUBR
   FMIN_zpzz     01100101 .. 00 0111 100 ... ..... .....    @rdn_pg_rm
 }
 FABD            01100101 .. 00 1000 100 ... ..... .....    @rdn_pg_rm
-FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
+{
+  BFSCALE       01100101 00 00 1001 100 ... ..... .....    @rdn_pg_rm_e0
+  FSCALE        01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
+}
 FMULX           01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
 FDIV            01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
 FDIV            01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ac96b18784f..8389dce6299 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4827,6 +4827,7 @@ DO_ZPZZ_FP(sve_ah_fabd_h, uint16_t, H1_2, ah_abd_h)
 DO_ZPZZ_FP(sve_ah_fabd_s, uint32_t, H1_4, ah_abd_s)
 DO_ZPZZ_FP(sve_ah_fabd_d, uint64_t, H1_8, ah_abd_d)
 
+DO_ZPZZ_FP(sve_fscalbn_b16, int16_t, H1_2, bfloat16_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_h, int16_t, H1_2, float16_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_s, int32_t, H1_4, float32_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_d, int64_t, H1_8, scalbn_d)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0ad0aff0504..37875b6b366 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4515,6 +4515,8 @@ static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
 };
 TRANS_FEAT(FSCALE, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fscalbn_zpzz_fns[a->esz], a)
+TRANS_FEAT(BFSCALE, aa64_sve_bfscale, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fscalbn_b16, a)
 
 static gen_helper_gvec_4_ptr * const sve_fdiv_zpzz_fns[4] = {
     NULL,
-- 
2.43.0


