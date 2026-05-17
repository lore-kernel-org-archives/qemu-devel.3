Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98ACCD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPT3-0002Ei-20; Sat, 16 May 2026 20:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSJ-0007B6-UB
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:12 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSD-0006rq-5M
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:05 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c80167f56cdso351210a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978037; x=1779582837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZ3I4CizPNDr7l3Qj3+qL13Yx8GTzrnhQalZXWGErYg=;
 b=TOyfU4X6eWdnObyjYzZ/n/IYmENslCcLf9CYS+u71YGnU2YA7eKdrlSiFbPQ/zL3i2
 DwmDYl7Ra2dzJ0/opEq4iMUOrjg+OMZmIN41wgxWLlbrVWBqgqo18H3I58jeuRj50O64
 o/lG0rd3k7KZLnBYuW5NniJsyORmV0jc3q8UUL0pG8pZlTfMbQzvFVJzyJl9mWrjbseH
 AA2MAGdW/3wMyqWHh5kjQi/lF3h+Fi2MkSaGRNsQwW19Z9Ae5DRurXDKG7+/NtKy2qSc
 9YDyidDuEadfRjurJILQ7HPTumDpi31BUPtZ5uh1p1JP6ty7ESDz3mSwu1551X9tKbEf
 hxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978037; x=1779582837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZ3I4CizPNDr7l3Qj3+qL13Yx8GTzrnhQalZXWGErYg=;
 b=B04y5UbJXgNLf00dnwttZWmwkLDqep7ba1xtUVjUhAj88yqn4oParLM5C4QeSiqkpJ
 erJ8gI9YPrQj4gdBZ212y8R01myYucZRRaS6Ms35gvJobDIyXSl0hyLMQYGPG1GMsVBn
 CVLw4k9ICo6nZF/BXVpVly1egq35MasxTDAPOwlsxwO6oEWuvCx4cl/dLPrgUEBhJwpD
 pVk52w6sWV4JB7zsrHhamqVgHU6z6tS8uozlLO55cx72qoD46xsrqtojqsxlk1AvEunn
 1UHCQsQrplTvzugVpONYDulmV8GDVbNn7uXLFp8dy4IdU11UB9yUfc9UEo8E+dnMzwag
 HscQ==
X-Gm-Message-State: AOJu0Yzf9jNhEAh5IQ77m6W4A9ARNIkO69TgDZUpsnwxjjrsXxVdHiM8
 edzaj1+pk9iSxpTZvUgMK3/n7scwjLylmdUGtSWiuyFTA3rvRKUwqQefQ4H/aSHZEOoWfxF5nLX
 FJd8v
X-Gm-Gg: Acq92OFRbpocWv7yvxUmZnRUrRzInbj/j+fyrd7slo+yHhDIk9mrPFfu6KzhbicsGC4
 Fo2r3UrvQbLuJYXXb/35UlDN3Cj/fkzq3Jr1QE9wH8+Bl2aQVioeIa+q+sTULNrFVc0JLn3x+fM
 +tWAjtQphPwueYcGIaHmgqFv3bdrSb1KAu1J1327RR/SC/qyk7EDFLZc4wxhUWaRZ7rot8oT6aI
 7dZiQZa8Pjd3LXfPU+G+gpI1BWvbHXul5fDU9jClQMyaNexuE8jbAj+aqyNlqxYbtnpD1OVDZit
 M74nm0XfW25SDpVZTKe2Lf37kn6iWE1Zqs5wLIpMTVzkJI6B8OtFBAAQR0KP3M18ekUckJ2OSCM
 tRoP4jHcXyzxVcLhiriInqVU5HKJ7fMsbWW9dsWkbLK4+AuZ8qPF1LuGSc70qjiLorIHw2ZkHza
 rNz2bk06CMqtLVzpqZO8s8c1mLTafkHcw5d8PBSwU=
X-Received: by 2002:a05:6a20:939d:b0:3a2:d68d:9e83 with SMTP id
 adf61e73a8af0-3b22e6682e1mr11230586637.5.1778978037506; 
 Sat, 16 May 2026 17:33:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 57/63] target/arm: Implement FMMLA (FP8 to FP32) for SVE
Date: Sat, 16 May 2026 17:29:56 -0700
Message-ID: <20260517003002.321430-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 67b9d7e982..8f6cc2974f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1693,6 +1693,11 @@ static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_bf16(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8d622f9a1c..5bda5f6c01 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8442,3 +8442,19 @@ static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 TRANS(FDOT_hb, do_f8dp2, gen_helper_gvec_fdot_hb, a->rd, a->rn, a->rm, 0)
 TRANS(FDOT_idx_hb, do_f8dp2, gen_helper_gvec_fdot_idx_hb,
       a->rd, a->rn, a->rm, a->index)
+
+static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
+                         gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 26b3c7697a..6610432528 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1808,6 +1808,8 @@ BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
 FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
+FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 Memory Gather Load Group
 
 # SVE2 64-bit gather non-temporal load (scalar plus 64-bit unscaled offsets)
-- 
2.43.0


