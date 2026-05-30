Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4888CD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrS-0000J2-KZ; Sat, 30 May 2026 19:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrQ-0000GT-P4
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:56 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrP-0007Z6-3g
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c858014845aso472611a12.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182774; x=1780787574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dF/XamizDFHvwhOgZesNBvMvEKMQrxAaauoIb0LzJE0=;
 b=Doz/C/h8tgkAchsSB9GkCP+C4U/jrDHnzbT9EhVq+EfwuAK8qDSYO017uKheHJ7f/8
 XAN/2AUb7jcC8eWlnv7P6nhBOb3I3azxCRFbmWmu6hpFsdAWFMjRAF97uXQudnm49t7V
 y5ovSNXutu4886WzQ8B912t/fHD48RNUAJ+8HFwHmip2d5mU+GQ71Rx8nNg/ekO5gGdi
 S5DkF5jucld/OvrEKvE1S8URRuQHh/2Cg5Ac454+IwHG96BDIN/hCwLKGtUVPYYSVS4q
 8bPs2ClWWRCotmwTEvBDEArdVvK4olbuvydNtIfI9ROsgyM0TxwtOW1ulKJNGgZGyCPQ
 mbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182774; x=1780787574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dF/XamizDFHvwhOgZesNBvMvEKMQrxAaauoIb0LzJE0=;
 b=lQ3N26XSu7rJKWKF7O14zKnJtuG7fm0XHLaZgMroCGozcSj7O2lafAmIMzqxeQ4YWR
 4Jf+WGSBKZtherQ2hiwO9pmudzbF5dWZZc7flutwvWJsjjTpA9BuFYFGWmlcsR2qrj9Z
 /UR9oLY3R55uEldwDQQk7rBl14DvckSwRZ+WAo41VFK9x2I1bs9ameqiiRQtixB4iUjA
 xlDElSmQD0LjeHU/2XnPrbn/JkTLtKtiY/U/rqI97bMjctFWjZDmkT2WvlgaB7aufL3F
 RnJsmgkLaqFx1j4o6+qvlB4sY2/tMoVrvkNaHKb0qlCSo1xsde8ByLlSunCX24w4jGMw
 AOXg==
X-Gm-Message-State: AOJu0Yx5DiFj2tMj3Ubps0giqg90vVd1oAqdu6jun/6BtrirsUqitjXX
 rikWQXs4g3PLo0SCpIaBicWBxPcBSPfPvnGHrnHT7TrUvYHyuvYvaYIOAeK4Cx8ZAzPruzQ2wI0
 PDf7tlMc=
X-Gm-Gg: Acq92OGIWGcuGSzpazK/KHhy+ui2DNZgQkHKEb+66CCgmG4R1OxMP9BN70MB963Q/P3
 S7R7ot2qopoVTLDhIlAg5blmatRv54g7YuZJy6z+ytrAaTQmgb/ftGZ3CUDFV63D5kgRr4qtriB
 KzgRgsqQsj+rDk1+CqbAke2ZLRR2jfSmvmANXYruUiMBJFZMSiJdDFZbReFslMapZHrd0YM84An
 Pkyo2r4r5YFvdpWKBs24KAjrxxsk+jL+L0MWGql0VcyzvN95KXrB25Z4oA3jRSmNz9ZJtrDn+V8
 O8rj+ib7iztR/GlKlfXKJJ8PqrkDvogV5vOrcnUr61dphf6a54yAizfnWvgJrfp1i538M7zB6Hq
 7MVChZV0fESgSX0eVrYgbJ9U/U0OeP+vuk0MH/E0+SCbefOqzsqNwXF+Ehk16us18LMKQVXhzIZ
 4xFcFLo9enqMaA8dfH+nHCgcW6nRtJW6fTuhsw/D0=
X-Received: by 2002:a05:6a20:450c:b0:39c:4e62:b843 with SMTP id
 adf61e73a8af0-3b426791ab1mr4428143637.10.1780182773695; 
 Sat, 30 May 2026 16:12:53 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 22/41] target/arm: Implement MOVT (vector to table)
Date: Sat, 30 May 2026 16:12:10 -0700
Message-ID: <20260530231229.400441-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 18 ++++++++++++++++++
 target/arm/tcg/sme.decode      |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 3a754f8d61..050a826849 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, FA64);
 }
 
+static inline bool isar_feature_aa64_sme_lutv2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, LUTv2);
+}
+
 static inline bool isar_feature_aa64_sme2(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) != 0;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 76bbacfb6e..c4bede2ae3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -391,6 +391,24 @@ static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
 TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
 TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
 
+static bool trans_MOVT_ztz(DisasContext *s, arg_MOVT_ztz *a)
+{
+    if (!dc_isar_feature(aa64_sme_lutv2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int tsize = MIN(svl, 64);
+        int offset = (a->off % (64 / tsize)) * tsize;
+
+        tcg_gen_gvec_mov(MO_64,
+                         offsetof(CPUARMState, za_state.zt0) + offset,
+                         vec_full_reg_offset(s, a->rt), tsize,
+                         offset ? tsize : 64);
+    }
+    return true;
+}
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i64);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 2b9e41a75a..339de72b8a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -141,6 +141,8 @@ MOVAZ_zt4       11000000 11 00011 0 v:1 .. 00110 za:3 zr:3 00 \
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
 MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
 
+MOVT_ztz        1100 0000 0100 1111 00 off:2 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za off v:bool st:bool
-- 
2.43.0


