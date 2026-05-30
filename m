Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA02FCD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrR-0000H7-3w; Sat, 30 May 2026 19:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrO-0000Df-TS
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:54 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrN-0007YI-CM
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:54 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so633554a91.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182772; x=1780787572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvTdErfxKyM18jy4fYLJA8neNrcYEuEEmDnUu40A3Ns=;
 b=T9Qnm2quQPHFEt0pu47nzZsDC6wMPMkzDRAXmarE9qjJZUXSXO4WDtxVXzgKdaa5s3
 rOgwFSthlPX6qe8d5evpDWAUI/Y7dFWCf4P7ccqm3WvyzCjCRDhCI4rLCHgQFwg0Shii
 VZDbmgOVHxCpHpTZel16o+jn+BZDooAqB9WujNlIbU98+/Tx7p0PTAr+bZxKzU3X9n3z
 kgzhIm1X3sl8g7VgboZpJQeGTfIWrq4fbLEb3IGMIfvVhonSYoHg4EOPlEKmgoqSQBov
 CWXHP4fHwkDp0PKI7gc5rLY73PZEY3xdK6RCb4Ea/HdTdcku+tzlgj0OsP/zL7eLUmpA
 47Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182772; x=1780787572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZvTdErfxKyM18jy4fYLJA8neNrcYEuEEmDnUu40A3Ns=;
 b=mqAMWHJ4ZyDn703/S3TnTscEknZwgPcmhOcKuIR84wH7VhpDmB+CC4bYZc7y2X87gE
 p8D32LoYjAOyCrDi7wkshO8BrS2d1zJjQcvrCRsZx8fDqe/YdU1bGaexjvwOUrMa3y62
 yO9VbjICbqj+SsJBm+IvV5jJMVDKO7wkVmOA5T2L4vf28z5bk9m8j0QQ7Y+jShuEnL+C
 BLyBY4ekvydv2D6zmjB2HTEr67xVWvILV8q4Vk2yVu0K7p2SwKldhxXLOUA/kpdQJevd
 ycANZ5oH11a9X19phBUHhRB4PUeIrVPqUIULZqC31pNUmzSEWIh2uBBjyfmRmx6/h9HY
 6ynA==
X-Gm-Message-State: AOJu0YynhDfyGWlaCDRH+TZf59sbVuXlvPxfh12tEsqaxo2nu2SvfR20
 5oDM+Lq5pfDLFY5yCZjFZ9UhHyDThF08TZqy8XvnwCagkX7JVQm0hM0O34mjSKsS+bH6q6PAiut
 EgnlLWFU=
X-Gm-Gg: Acq92OFsT3bqGLG8Wxf65uq62zlXspT9G4QExL0lUPS9uaoFqbBdO3hT3AePMxqzjeB
 m1Z3hcHMvjv7oZXWqPo48dAaoYN1Ekr78OfCl1s9YVAJGCqG/e2ej+YtzkojEI87OileDWsd3I7
 gxX4qHhYw4LiD88uozoBByaCIPONVxKBhq4wxT/9ZZTb89Yu0Q6j/7nxtxbdSf6aeZ9Pf0azEzm
 fvDqXhZUtIvgWyi9s7x7hd3+UBRyxLHgF9cEdxjDqB1g1JUjxfOdW7ofoDto4dhhOlWIchBPcst
 L703PbdE6PyHunmDeELW60RDnidnZ9P+mk5K9KI93P1seQHT1CeEqYjLuQUIS9s5RXnjJkMoIhZ
 JhPa2pDyhvjiOANnt5R/Mzip0jsGnzQ5Wm/0Vj4OGZIJGBBKpQ+uFWo/i86BPQFySnKqNyetZtZ
 ZrIm98lA0cuQ3CmfMVbPvTyi5RCPF1bcVR2JxdEVY=
X-Received: by 2002:a05:6a20:c6ca:b0:3ab:2fa:756c with SMTP id
 adf61e73a8af0-3b427bfa25amr5634167637.1.1780182771989; 
 Sat, 30 May 2026 16:12:51 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 20/41] target/arm: Enable FEAT_FP8 for -cpu max
Date: Sat, 30 May 2026 16:12:08 -0700
Message-ID: <20260530231229.400441-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 linux-user/aarch64/elfload.c  | 3 +++
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 10 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 5ed7a7badb..1c0c404b7c 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -222,6 +222,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
+                               ARM_HWCAP2_A64_F8E4M3 |
+                               ARM_HWCAP2_A64_F8E5M2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 39dc769a04..b48dd01a2c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1392,6 +1392,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index dc20632097..470f7d891e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


