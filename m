Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D2C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFX8-0002vG-37; Tue, 21 Jul 2026 14:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUu-00015P-VN
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:21 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUt-0006ft-2i
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:20 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so3793656a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659637; x=1785264437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXdLcTVmLaodZE2u8MGvlXRVuwgv/NIQIsqWIhdsBA0=;
 b=qFAZdXG6eVFYRd/DWP2zAC25gZaSJpLUA2n00uuxDAVRSpN1ldZBXAFzpm2B+jc3vU
 y20u7+Q2oGM1dQeotm9BAfjb5/IWQmEGEtrEKivKor99p5pv++/3XYoZUGi2bKglcwV5
 v+CjNtadMqidzkh3Wurp3eZe0LDwodynB9AxrrH8HsDiDpVeRQCjKmKrJj/y0HIdy9ev
 heyf91+Mkko5bbXFmC/23kcZjlazrpSvtKHKaITloT6LleaniSYGmSV5KK6X1oH6TGnL
 /WSrg7pWGyhHtZSLaXS+H8vMctRFdlzhBv4NttdpwiJafT8TT1nZITU/dnRWOn6vaScI
 chwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659637; x=1785264437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zXdLcTVmLaodZE2u8MGvlXRVuwgv/NIQIsqWIhdsBA0=;
 b=ZPbJgwzs82fGXjEHg5LDis/J9eNFoTtec0O0Cy+2914pZWgXRc3CXswewN24kZiyKZ
 qWoOlYrRfIOnFDJSHkoNL3gu+hJrnxCYsSiGf20onRnkJ4nhXXAXxE148uEn9fRR6Wb7
 GQZAWUAwxPnEMxrWOcLdn2ReW/Bl6wtQXrz77ts9wDaNycXosH1R3iRli8gnkYlduQ7/
 EukTmW5YMaIyAm39FVSF+yVou94bPYNnYYYe82oFtZrpNrxyBpLN0bMcmosmZqTQnzxd
 K3GIbjl0lpEAvu818aN5ebwnLndGNcni6OBdBsl4PpZkMXqKmQ1yPEeeOm0lZDuhXuXF
 Ooig==
X-Gm-Message-State: AOJu0YxZWDYoNKpvOdtkhdia2gcD88ly6aEOg3g6f023cIKhDTw/QAmg
 GjM9+jGJSCHsbMVBwSoW9TpjYaMowTfRiJUxj7i5duiIFZ/BKyIXAvM76THz8IUS1ncaA8ng+qT
 xegXz
X-Gm-Gg: AR+sD125SP1UBgH1LK04nSny3rRZfd9mkDU0tLXzaLGxnQgj6grkrt+uxjrOAX3QqpO
 ecgeQ09AFXEkr+zB5FyyQumT8zw/EumUwujKqtDnfDRTKrmHTeSDnP9TdLTDdyspcpTggwKkdBR
 Z7lfgOPwVPGz38nttS29oWuzz8KHdTmwyRoKGw+K4Jq/CD0Kgl4pttdBvoxRXZQ0uwHbKpBFH67
 mVo1aTl6huOpV9OBtF2FeyZbdjaUDff7iOTy4pGXHHepP+BvliM3xGSdM7TWJBEQR6Q2NpjVQhC
 qw1kfBXYoWx32ov8+u4ezI1qJowQfz3l8RRS61l5+M1fup7WI07jDVgZWYiQMFG3D4fGd2ItkEF
 N2tzleJTVUUTDZEezSD+WFF44rKTdMbrZmr/3fpzT4IRgOW/7WeNjUeZOaUqNhBGrWRb9pyoTWF
 dS6gYrnsU=
X-Received: by 2002:a17:90b:2fc5:b0:38e:2c8f:a01a with SMTP id
 98e67ed59e1d1-38e4b4119c7mr20424288a91.11.1784659637131; 
 Tue, 21 Jul 2026 11:47:17 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/20] target/arm: Implement and enable FEAT_SSVE_BitPerm for
 -cpu max
Date: Tue, 21 Jul 2026 11:46:50 -0700
Message-ID: <20260721184656.530230-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 12 ++++++------
 docs/system/arm/emulation.rst  |  1 +
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 44dfc7d457..d3130fbe67 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1605,6 +1605,11 @@ static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
 }
 
+static inline bool isar_feature_aa64_ssve_bitperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SBITPERM);
+}
+
 static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 7afbfca418..4359312ee3 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -181,6 +181,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
     GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
+    GET_FEATURE_ID(aa64_ssve_bitperm, ARM_HWCAP_A64_SME_SBITPERM);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4a44d148e2..c7f8217cb3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1390,6 +1390,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* FEAT_SME_TMOP */
     t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SBITPERM, 1); /* FEAT_SSVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0b522e22ef..08372d9d8b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7420,22 +7420,22 @@ static gen_helper_gvec_3 * const bext_fns[4] = {
     gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
     gen_helper_sve2_bext_s, gen_helper_sve2_bext_d,
 };
-TRANS_FEAT_NONSTREAMING(BEXT, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bext_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BEXT, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bext_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bdep_fns[4] = {
     gen_helper_sve2_bdep_b, gen_helper_sve2_bdep_h,
     gen_helper_sve2_bdep_s, gen_helper_sve2_bdep_d,
 };
-TRANS_FEAT_NONSTREAMING(BDEP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bdep_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BDEP, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bdep_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bgrp_fns[4] = {
     gen_helper_sve2_bgrp_b, gen_helper_sve2_bgrp_h,
     gen_helper_sve2_bgrp_s, gen_helper_sve2_bgrp_d,
 };
-TRANS_FEAT_NONSTREAMING(BGRP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bgrp_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BGRP, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bgrp_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const cadd_fns[4] = {
     gen_helper_sve2_cadd_b, gen_helper_sve2_cadd_h,
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4c91bb45c8..fbc98d47d4 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -191,6 +191,7 @@ the following architecture extensions:
 - FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SME_TMOP (Structured sparsity outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
+- FEAT_SSVE_BitPerm (Streaming Scalable Vector Bit Permutes instructions)
 - FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
-- 
2.43.0


