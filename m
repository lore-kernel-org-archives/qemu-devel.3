Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2974C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFWV-0001X5-PR; Tue, 21 Jul 2026 14:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUm-00011F-Kl
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:15 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUj-0006ca-L7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:12 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-384c94c9414so7079495a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659628; x=1785264428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NDgsrg/XkVdVwBY/tNiDUZOq6w7K8FLPP7xWC9cjtnY=;
 b=eG6qqm6WIECvgGUFIU3y+at9164D2d2YIQ2eaAviZ6hfugAOfmcgXIX7qeGBVFkW69
 js+ZYdmVTZaOXeSj8bIa5/VFgasyqD+NrF6ELOR7DvyeYWtZrrWHoZ8udZ4TEzb0sClb
 SLukyUN/krZ10McS/vUy3efK4ZcNLSv7gsc0Khgnb8U/GMGVgyinP7Qr/MxaHUcSZDTL
 zWiWFieZwGrEVLa2NJtsdKIX8PmpvepUzNjNHK5MQK6CkluoY0G8w30kGCx8tbUM9169
 6wBfe5sAyfb1YiH4YWey008/d8GUcvtXccVZPXqZy+qpugUfC9GJLn9yYc9NKCnHKM9W
 6N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659628; x=1785264428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NDgsrg/XkVdVwBY/tNiDUZOq6w7K8FLPP7xWC9cjtnY=;
 b=VASn5yQTPw5wiqlgcSUbqPyE0TcOiEtsZPUpPUYZofNkMP9R0M+R46E3ukga5Y5Q2c
 DudksAHrN7ETizstprHCC7OhPIObV9nC1xYvoKh8q9NqQpsqRM3hYn/MomZEYBDGdFcV
 mqIW3fEY2imkFKI4qhksEwS4VzqJFpFwK68uDs75Jj0gK5y7sKgurjMhgJpfrAiZYsqA
 LAVLhHiwa8CUiL9WxvTznQi84s4bB3g4LYpiOl35nfVfHs8N0qdkTHJqcA4xz9WSonEn
 fumpxJQbt6s5MdcsOXkLp9JydWvU04lpUUUa5HNuUzzCuMkzc3uIrlYhXVImN/4z9jbY
 qgnA==
X-Gm-Message-State: AOJu0YyAosW4sIMndLoizDQahwLIL2Z4thWgDUTbk0j4qigcpK786sIK
 7CcvH/Fhii5qEOX7i9ElEWJw2u2SzkC+2Hl4sFMz6Myy1XdJdNaFEcvWOg3z/PRVhksByHmbYyM
 UqfHx
X-Gm-Gg: AR+sD11qo4r6dp+n9DlT7LsTR7lkw21rqg7sv5VX0IcZ80fHdUjWPFN8wDesj8aGz/E
 +WlQTd1zLQreqGoolPyAxu4WqWQEJVkSjRfsIvQxaoKQClpfGds/6ImIuXa8Ycju/ep2zkNPgiz
 QZ9VzqJQPnzIMzdwI35kLRkmclT8GUkM2m3rEkPZVAvSRh80DznPeT++RWYZ2flcpONrH/dR+ZE
 EKp9E+D45meTmIDFgIq4qKOzcSfWzazvp3oSu01Fyvtd3wtGAs+oFZoR8y5BTtuSv5eylBdsZNO
 MhB12PR25uvDipLImTjNQj+Z+7Ik7++sECP+pZXlpX7VveOP8sL8OhrvgtwK14bi+EfeuIuxi4V
 fsb+dNBzlt8Kch1b045NlhD4Dqwt2T7JeSYRg2QGoNc83JVK1U+IZnmGmbU7F00wZnaEhgITCQv
 XUnwAn+mB0EXMABtb/kQ==
X-Received: by 2002:a17:90b:2244:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-38e4b402565mr17622996a91.11.1784659627567; 
 Tue, 21 Jul 2026 11:47:07 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/20] target/arm: Implement SVE BFSCALE
Date: Tue, 21 Jul 2026 11:46:42 -0700
Message-ID: <20260721184656.530230-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        | 5 +++++
 target/arm/tcg/helper-sve-defs.h | 2 ++
 target/arm/tcg/sve_helper.c      | 1 +
 target/arm/tcg/translate-sve.c   | 2 ++
 target/arm/tcg/sve.decode        | 5 ++++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e444397a47..76859c1f74 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
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
index 19bd936f6e..f78e77662d 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ac96b18784..8389dce629 100644
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
index 919ff1b217..52f370e47e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4505,6 +4505,8 @@ static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
 };
 TRANS_FEAT(FSCALE, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fscalbn_zpzz_fns[a->esz], a)
+TRANS_FEAT(BFSCALE, aa64_sve_bfscale, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fscalbn_b16, a)
 
 static gen_helper_gvec_4_ptr * const sve_fdiv_zpzz_fns[4] = {
     NULL,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 07dac681ac..ed19ae237f 100644
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
-- 
2.43.0


