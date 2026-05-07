Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1E0CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S4-0007ai-27; Thu, 07 May 2026 19:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rq-0007DS-1n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:12 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rm-00027O-1p
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:03 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-694891f8f75so826313eaf.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197680; x=1778802480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx4LZOEArrVWhcrcV8egakiEsG2aRS8cehmkYIp5N70=;
 b=U1T60c2NbTbn/tVInEaUItdPqofrckmskPnUYCJ/5BKrqMKD3TYfbyjmwdiU12Maxs
 VHaXVFsLyAD7uYBxlmTNgSObfbMIARld0Yh2tIG9Vgdqc+AASTfw1No5JdwZ7jDnfPkN
 RyuXzkfhplrE2/CKYkI67dcwWdzIolIKjnbgELximKNqsK7QRzD9Br9n0pCMNjCYFqIh
 1xJyeHplgLzgZNSh6iEStQ7UF25NRcjcEyHpmmblE01GEB8yG8qt00EvSQpNfQHpA0P3
 XBQm2U0Ww7C5JncscIyfGKKLTyn+5oGXZ1lgGoto+L6UZ7uYa93IXU1raAEcZejCsCa5
 t/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197680; x=1778802480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dx4LZOEArrVWhcrcV8egakiEsG2aRS8cehmkYIp5N70=;
 b=fDRccG/iTeHjmmpS2DTzYZ8ScPxPRCkAg0K8kXpQRskn7icnGDl88DUrhQ0tIxb+dB
 lUx5kO+Y/r7NWVKel7Y8CWYPT4YwcUfsmXHexTs35RVGfRwfZplVWbRlKPTkvUPqFJ3x
 n7BGiafxqvWzV09yQK8rUeNdipoTergGwvmHI9x27MVuoOz0nh+kW6cWHG4RnmDvJF2K
 ynGUICwxSNrzjXddPLWuAjqKgekoJKt4AH0ZTGyhjtTXKnGXRTLvAXUS7NOkfG0WFuLd
 zpKpZOi+mrX8VFmau3pKBWLwfPmKgfr7kK/hO8iaG6FOr/62s9oi6I6xEOhisviV4yAJ
 V/qA==
X-Gm-Message-State: AOJu0YyOxzG7GFtXGeYgETqYc/Q/TtVsuDckypqkl704MveigUFbBCta
 m7ru6xEAAj3Rl1HEAZEZYPnXr+fVSNoi1Rrqs1f3PIpR01+29I27Ga8zHKEudvLvZ8mDpotUdTu
 SsmVz
X-Gm-Gg: AeBDiet71x8eC30XrLYU9op5h0SQe2wPcb91v1Rr81ghGojJ4qGtYIoHQTZPVfNmqDK
 LHyuou8s2vps64Wlsnuzu7tVTVRI2IFu8nSEWxOQPAy/0k/nfFKGhh4LONo7rgPwqkaj4W51BPC
 61HW6huSBtzTa8/ZO9I+GlENz2mZtSE8rtQN56SAHjuqfIhuFZjxcqfhW8WU6yHI40mWUZXgFSi
 uv5oNm5vO2XvJXuGBsxzPtx3Z/+oyKfy3OxcFQ222OSU5JHulfL1rdV5exUDkuwkVJtCDOklSvi
 Dc0qegQBTe4mnbo8SC0u3iFSdGeQ1spVAv0e0VQxfTwTMnOVNwh4rhjFAAcCzydhZ+Ee7JHvRps
 t9U8ChiVZ4pEOQ8JbhsMTufv1JnsPPUv74R/Kn1ycMMx7y5r/tpzB4YDikeX0mPm1dbuA7lrG7l
 s0IVDfkE8gV0Nnq/5AEd30srJbtK5LmRZ5i+WtDcCVm9ELZQ/YcLWzHpJg
X-Received: by 2002:a05:6820:3101:b0:694:9e64:678e with SMTP id
 006d021491bc7-69998cb1130mr5910775eaf.18.1778197679719; 
 Thu, 07 May 2026 16:47:59 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:47:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 45/60] target/arm: Implement FMLALB,
 FMLALT (FP8 to FP16) for SVE
Date: Thu,  7 May 2026 18:43:58 -0500
Message-ID: <20260507234413.643512-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
 target/arm/tcg/translate-sve.c | 33 +++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index dcbd839d2d..e5e249d824 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1539,6 +1539,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ea0d66178e..aa785fa0c3 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8336,3 +8336,36 @@ static bool trans_LUTI4_2h(DisasContext *s, arg_LUTI4_2h *a)
     }
     return true;
 }
+
+static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
+{
+    bool fp8fma = dc_isar_feature(aa64_f8fma, s);
+    bool ssve_fp8fma = dc_isar_feature(aa64_ssve_f8fma, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8fma || (fp8fma && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8fma) {
+            s->is_nonstreaming = !ssve_fp8fma;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz,
+                           a->idxn | (a->idxm << 2), fn);
+    }
+    return true;
+}
+
+TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
+TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e2106fc7f5..71ec09393c 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -29,6 +29,7 @@
 %imm9_16_10     16:s6 10:3
 %size_23        23:2
 %dtype_23_13    23:2 13:2
+%index4_19_10   19:2 10:2
 %index3_22_19   22:1 19:2
 %index3_22_17   22:1 17:2
 %index3_22_12   22:2 12:1
@@ -73,6 +74,7 @@
 &rri            rd rn imm
 &rr_dbm         rd rn dbm
 &rrri           rd rn rm imm
+&rxx            rd rn rm idxn idxm
 &rri_esz        rd rn imm esz
 &rrri_esz       rd rn rm imm esz
 &rrr_esz        rd rn rm esz
@@ -1864,6 +1866,8 @@ BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
+FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1880,6 +1884,9 @@ BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
+FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


