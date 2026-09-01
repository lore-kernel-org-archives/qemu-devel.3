Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946B0C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONd-0001Pt-RD; Tue, 01 Sep 2026 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONc-0001NF-Lh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONa-0007LB-R6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so814945666b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268701; x=1788873501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hy8yKWy9n2uxw8IOTSNsNMbC5ckMz5zyVCI3Ph+PgrM=;
 b=ksK2sPqoY27B6RCqoCB9jnubKkLLPYigpusB8xo1UZRrVt/fRsikRgG5ZfFKYz0KA0
 8dsTAZt4wNXFQctNcEBSQBh03kYM9LK9GE2N72zzV76x77cDMOP8o2wUC1vTrnam9WFL
 F9CrtAtbN+NolVW4/X6vcfO/rkNof2qp9M6ZFvKp81mloKqim3vAwuK2CGF1R72ZxLXZ
 72T6CIlMdqLz/sSBn3SlX1bj3BsxH6sPZUJaaCzZb3wUzZDwnzyluwQhLOlBxoClS0DY
 1D5Sn3hSy4BjZBo1BxajS8G8Lq/BPqFY+Hb9vY+aRt1t5L77RkK9429uqUdMPmguJIII
 rMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268701; x=1788873501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hy8yKWy9n2uxw8IOTSNsNMbC5ckMz5zyVCI3Ph+PgrM=;
 b=A9SJ2IMVUkGUtSeu7QcuRotAmJKO3FF0M8raw/NuvmGKDE9bPW7DOLYNJJ+RxJ4wFH
 QGzVSP1NgqVvyIjSynJ9eR4O46bzLLacxKRHWq6MqOHvDwPLngx8OuORIP6okbKO7Ih1
 UL93kbNf6Zad61VfLiPIdsoFlbRxCzqhuppyRp/ddZjeZArtx4+nAgn4YnmKuhJum9SH
 y9mOYdbFLU8UiX+k8B/oU66HofbtxYydCeP/QfM0wHHtgMSeKrddWDQArbKF5lKvBTpS
 mxx/Eu5P6g5qtO7tsqkxobqBCNjjIj99/dFpaKzndZC2Bp4R0tEhStzdST078Y2/lBdV
 kpPw==
X-Gm-Message-State: AFuF++lWfyKC4yKXNfZQdp+Ng0iLG6YeV8Sen0cblWktnQ74vNlkZ1Ql
 1KAuxG16oQDELQ6pUOcwboCBg7p+o770TPDhcDpBkV91OGxVN4KewBHoElIGuvq6dqVw4RzBTtW
 6mPi54nc=
X-Gm-Gg: AR+sD11p9JD650QpPlZydtqeM6waVAE25AhIbUIDwYgoUzsDEZ1TRd8IssMJlEFzEEi
 v5i1awoz7DMBtOYGf6xg9N9BlAU8L05egH6O61/WfYAzwVSTJAXStD15vp2IuM+QHvSO1YYKoHE
 saP3zTP99gnAe537pH5gQd0oz0ldoNPUxm8+hzgrpPnzzfM5PMhykiCbvdCqTHvM9cwaZ/lckGf
 2L0V3VUT+6lMSJolmpIw5QQireLbCHQVzbG99BUExAq/g7ObyUZFq4iEJ3BaTcMRW1WiHzyNSiQ
 8ZwOVDaQqWP/afbBHDToV2+DX2ngJxTyexleiX9cSEmAwO0g2kOwx/CWqeFq8S69UjUC3/KLjg+
 +QG2CNoq2Z6a6e+h3zR/Ox/JTna1S2qGK6q82s/axpyPGs5FsKwyj9HcderX4gshTXe4UCbugY3
 I0VkO+n7KwUO5eeB0O9ib608JjWbRJggOHN3rrxpZ4fuVqM3s1EFppcOa0VOlh4+vOKHJL5pTSu
 vxSzjDYMqtjHX+aEhNtMt1JBGN4MDOVAY7RYHcFkJxuHvUMWe64MHOMWSUVGwzBwcZU4g==
X-Received: by 2002:a17:906:b816:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c25b3d93374mr444689866b.24.1788268701452; 
 Tue, 01 Sep 2026 06:18:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/58] target/arm: Rename isar_feature_aa64_sve_pmull128
Date: Tue,  1 Sep 2026 14:17:22 +0100
Message-ID: <20260901131732.2263947-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

Rename from isar_feature_aa64_sve2_pmull128 to match
the feature name: FEAT_SVE_PMULL128.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/cpu-features.h          | 2 +-
 target/arm/tcg/translate-sve.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 2fb7dcd778b..6f9d192b4ff 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -127,7 +127,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
-    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index bcf2e6b9c18..40c5e1dbd38 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -193,7 +193,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
-    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 07507d263e9..8e00b82ad18 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1539,7 +1539,7 @@ static inline bool isar_feature_aa64_sve_aes(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;
 }
 
-static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_pmull128(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 2;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 37875b6b366..773e4ba4e7b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7243,7 +7243,7 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
     };
 
     if (a->esz == 0) {
-        if (!dc_isar_feature(aa64_sve2_pmull128, s)) {
+        if (!dc_isar_feature(aa64_sve_pmull128, s)) {
             return false;
         }
         s->is_nonstreaming = !dc_isar_feature(aa64_ssve_aes, s);
-- 
2.43.0


