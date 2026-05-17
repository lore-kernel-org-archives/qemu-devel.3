Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542E1CD4F49
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSk-00089h-Bu; Sat, 16 May 2026 20:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS2-0006j3-93
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS0-0006oX-9B
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so6602115ad.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978027; x=1779582827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6l26rPIuII3YImkqTasNjpDKWjPGdRXt+dWuq4seH0M=;
 b=X3jkfJRkLJ30Zkbtn3w8WHcaIPpiBrx7+ieJb3gadSfTzcj33X41BuSulhTDuY6v1F
 oMgS2fzZsdigVQ8TDAPqiaRR9Dpe+CWC9oajKBhdAsG4I8qBbPoUUaiT1+ZLLDifw3vT
 KJqN9U0rB5uGRDOo3aOcSaOSqGrZUgmEr/Ns5+jcwTFMCYOjuxjv7LBL/78gJDayU9xT
 ExBK1OacoHHXwGTluVQmJY3665+CyoSZDsDCNE3x6OcwyvVL3XV9vJDPFMxs9GBWJ/gj
 iTkWjN1+zQwwmqADr2RvRxXHiZK6tU8pTm4jX1G4DuSee7hP/lD84VdTjr+6lReVzsoK
 WXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978027; x=1779582827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6l26rPIuII3YImkqTasNjpDKWjPGdRXt+dWuq4seH0M=;
 b=lYVkRt1y7Dfjr5LlnUFpCECxRWSiD2r5UuCiGO5lG+lSH7iyPGiRZBGg5soM+2Gu/3
 NZngdtFIzWI2jsRr7XFj4XAGxAOQaJaDVq4D6jD3G4AK5LqkiUQhV7Dc3ksLhQc62I1F
 wX2rtL6DUxkysHO4RYSS7CB636vknGJhCXtZOOUofZZ8vf7CrB2+Fijfx5RXlnmXqauU
 7UtkjYOrU2NqDH0PJORNseIFQpSYIuPTFaOLVUrVPL00LkKdDxqgq5qkkNz0+uTpgw4n
 szEIckQKTuTj5n6Go5VFxCEXf5ztVKjodhuKVx342uqE8jnhfmV0dnc/hAEyaQSCsNk8
 JBJA==
X-Gm-Message-State: AOJu0YxSsKNWm40JBvVMw3Z+80sdm7BbsCxqogb5xm210iffXeSi09qg
 g4MA6QTB4RdE2W5pmzeoYGaRHNH5smtsvtlU4L+n+a6TRFtEJHj1wcQwn7TUUwF/loIMdjVsJqK
 g4WT6
X-Gm-Gg: Acq92OFHqOqcPe345O6ubQwiSQqzmDeGyIEeDjKohZ1/1QyJEh26AEil/u2Ag+xcQfW
 vAuyITsSdp5YcnfUvviVi7mjf6retNMbA3GCP+2scs1srzkzdQ9OVNgb6xGaRk0MnBuArQQ3qXg
 5hczT+s7Fs78M/CEOt3oU4deKnJ5rvafUFR9k52LWhX4M9uk/J4xfc0DlHOSh8CR9YV7+ELjACf
 DqvqreM8sCL/UsWxB/UjZUUGcBod/tfHgOQesFFX1Ei9h7AhzyRQNMF6PQYYic0BiohLF4hdDL3
 QJN+jMbQCAN+jn7U1FpD8380duKuXrGi3ZM9WHB5g5rlHgaa2ZQhE2nca9YXt93TSPKsUDSaAM1
 0VFR4cjrZrGDg5psR1XENA8OWFCOlJZJEQbqKL0unqrLvVYlrlDUo0TXURwS3gcR1lbTHYq8bOu
 skK/xVYX5mjrR/5LqY+bF615oCMG7berHpjtUcRsI=
X-Received: by 2002:a17:903:440c:b0:2bd:9a27:70f1 with SMTP id
 d9443c01a7336-2bd9a277240mr66141525ad.30.1778978026638; 
 Sat, 16 May 2026 17:33:46 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 46/63] target/arm: Implement FMLALB,
 FMLALT (FP8 to FP16) for SVE
Date: Sat, 16 May 2026 17:29:45 -0700
Message-ID: <20260517003002.321430-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index ee20d74164..c0b646415c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1545,6 +1545,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
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


