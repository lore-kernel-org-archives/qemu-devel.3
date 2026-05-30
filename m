Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FC8CD6E56
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrb-0000Us-VH; Sat, 30 May 2026 19:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrY-0000Px-OC
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:04 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrW-0007co-QD
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso10533765ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182781; x=1780787581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDizsp0TNMdOeGSvDCCF2t8154x2x+b4OLcJcvFBJCI=;
 b=FflS1D7AAsH4sJlmg61Et7PugWgBuZE6MJhAd2pLIO3FYjXRnYP/rRxMc/ihMetp3O
 Wk/HDSha0GOFli2mvPd+ZsG5hIZNOh94xllR6uV1g4LGf0khdV8/7WkaF91N9fGMZ8du
 2Dn6k1HS1yQqD5yD4Dca20zx4IVLg0Qh3lGPHmKRJmG5D3LCSBeSgX7ghQ8f2UpyzANy
 lnLMiSKuOF8NSbFdPljzBKM9OORtFvPUEixqypVy6VEWOA6wCWAreZ+h7wtDOx2CNpMc
 UFMswYuBy98jT56C9TRtN2kk7GsjKxSXjUPnDpME4K4cICnIoaYnl6eqwfWtUpivIAKq
 wOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182781; x=1780787581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SDizsp0TNMdOeGSvDCCF2t8154x2x+b4OLcJcvFBJCI=;
 b=YvG7/gaiSu/D+8DuV+yhO7g0DDdzs+HgA1EjiEdVqobnIKUqFLNkA2MZY1DSrBacJE
 6FgVnpwQJb/Om4IbBacJV/Ehw+gMnugCuDpuWwwES09GCp4trUtJzfg39NVmNlczDtVo
 +QgBBrp0he4mNRCBjf1WuVngifPLX0aiBNj24pJtAqSWOVbC74JxtMP8g2UPe/+NbNvR
 9GBAvfNmDIc3RFlgcxgLh8c5rh0pU15jeSVArch23K3ZdE4FWecV9i+eWnYOLdowJNnR
 4JUd2jVD67qsg9IPs5sccdaldTdRX7/heP4a/9eHjiPX/3IpAgfD3ML5ZqaI4c7DA66y
 yBJg==
X-Gm-Message-State: AOJu0YxbV9KW1Kpj8uVsMtK0xrkDVSNzJB8aV8iCvJRyyJAR/IFdzrB9
 lAOfJ3tRTlpFJMqPybMec9AS12GFk+fywsg760XYEAdTKm+I9rGATcEK3HgEObjeELaBQ8sFDxn
 +JPsSFJE=
X-Gm-Gg: Acq92OGwwp2OeEg29aJuTQItAGzwbCb93LvKdZT5Lv96ol6tELR3pZ1ucc+aGQjoskW
 OhZtBXOUH6Hpn1fB7y2iV/0eV4yb2rjUwNVtqyzIGMt1RuyDB3PuhCZsxHASZPUrws4h1XckqTS
 nLt3tu5e4FjwtJRjlB2iAEx0DIDeZKQFIlZZhh0sGA4i0y55aVkmnyYlUEeGu+nyhX0/XjB5faL
 gbEyig33/BikSqh99Zx/Ll6gJCVfMSGP9DlStXZydvK6RIgC0jVeyjqMomaOMw8m5u5WpNsM2j3
 j7NSwXDCFb2/pNB20Zm+ALEgskBr7ZGuw/w64rvCCeruUFmh+OWAwpgHiEMQ6ILgYl/EmOX7unv
 P4Ut5z1EUmOj0sxqTLmE0uxi+bJr90zH6rDogbsu6BmEpooq7879PPWSqMapzaMB7V2YtkqDIIF
 BKZVPimdn7G5JELHi7YfQhLgSw0j0jdI71qMcDk3PLc/1slk7aNg==
X-Received: by 2002:a17:903:15cf:b0:2c0:ca99:3d8b with SMTP id
 d9443c01a7336-2c0ca994083mr2056605ad.40.1780182781275; 
 Sat, 30 May 2026 16:13:01 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:13:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 34/41] target/arm: Implement FDOT (FP8 to FP16) for SVE
Date: Sat, 30 May 2026 16:12:22 -0700
Message-ID: <20260530231229.400441-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f6184b80de..4629a3cf3e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1565,6 +1565,11 @@ static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP4);
 }
 
+static inline bool isar_feature_aa64_ssve_f8dp2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP2);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 96ea0b4bd2..cf370b3c86 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8426,3 +8426,38 @@ static bool do_f8dp4(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 TRANS(FDOT_sb, do_f8dp4, gen_helper_gvec_fdot_sb, a->rd, a->rn, a->rm, 0)
 TRANS(FDOT_idx_sb, do_f8dp4, gen_helper_gvec_fdot_idx_sb,
       a->rd, a->rn, a->rm, a->index)
+
+static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                     int rd, int rn, int rm, int index)
+{
+    bool fp8dp2 = dc_isar_feature(aa64_f8dp2, s);
+    bool ssve_fp8dp2 = dc_isar_feature(aa64_ssve_f8dp2, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8dp2 || (fp8dp2 && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8dp2) {
+            s->is_nonstreaming = !ssve_fp8dp2;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm),
+                           tcg_env, vsz, vsz,
+                           index, fn);
+    }
+    return true;
+}
+
+TRANS(FDOT_hb, do_f8dp2, gen_helper_gvec_fdot_hb, a->rd, a->rn, a->rm, 0)
+TRANS(FDOT_idx_hb, do_f8dp2, gen_helper_gvec_fdot_idx_hb,
+      a->rd, a->rn, a->rm, a->index)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index c49e992f10..26b3c7697a 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1875,6 +1875,7 @@ FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 FDOT_sb         01100100 01 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+FDOT_hb         01100100 00 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 floating-point multiply-add long (indexed)
 
@@ -1900,6 +1901,7 @@ FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
 FDOT_idx_sb     01100100 01 1 ..... 010001 ..... .....     @rrxr_2 esz=2
+FDOT_idx_hb     01100100 00 1 ..... 0100.1 ..... .....     @rrx_3a esz=1
 
 ### SVE broadcast predicate element
 
-- 
2.43.0


