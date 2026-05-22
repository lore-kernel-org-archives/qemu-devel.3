Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39764CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2C-0007TX-Q0; Fri, 22 May 2026 18:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1D-0006ee-BW
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:02 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY18-0002Wv-Ll
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ba0fc8b1f0so55973165ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487613; x=1780092413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tgd+j3lcaK2ld6JxfnCeppQQpXiqWsYa7rmt84Ndi0M=;
 b=gRP4aOG1ShWiIyT9Zpb1JVi4xhRQX1NsjLBkeRqynb4k5DA/LoNnE8jasyScy+se+m
 /maweiZEacMAlqswWhytu9d2BTO7b79UJjIq5p9/b/c9pIuYzb0h90Dq5KRyeCD/FfM5
 9Hix7FvLzPL7rn/xhrUqqjG7nqaa9+v9LYrMN5FsIslE59oxyD2cJF4JKY90hyXYcDnS
 bfaux/m3MOOubbH3FBJuiqIZQDXBXfC139SA/ZUx7BdapfSDVRRvTB1VrhMMG8xLYcCw
 koDhhrGq96yBKnLMJxP60rmX2/JgtejpyWwkAoNiDvBqbu/opMPWv0U+4rQtfiWFpyp0
 2XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487613; x=1780092413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tgd+j3lcaK2ld6JxfnCeppQQpXiqWsYa7rmt84Ndi0M=;
 b=r7p1VeD5oKR48JHPNBw3MzPgHSaNnNWjMmPRXjOSxA1YzBMQTAyQbIORi6wjaVibpj
 Qwlo+KH1IBfExASS86qt9not7+ZG2sNZUKQuOPrm4ItHiLiyN8/35ZXEYxqncw7Z54sC
 BpoBngnS1vqh1+jg443/pmH1jUPQiNFqUYpPdzSOulG16o1Jqr0evLKe9DeFnTSCaZhT
 W/mOMVEJ6QIz4qhXREg2DJT0L8KvTTkwfm8rsAr+QOFBN1fq8FEjMq8IagyeCUt364HW
 0cCeV46hS+m36u8zUw45BV97+NZWQ/7uSUzDIigzvJedkTbPtT3oReRtjDP+p5I1yNZP
 C8og==
X-Gm-Message-State: AOJu0YynErIreoEJkPkUcQ3j7fKMiJ2mCOBtv3Ob+QY+lsryf7TKvOL2
 7xdb4AhrnMe9yKWOZjCuxwozkjAXsMw00EywZt0jYHSIGXhMmxnJ289KSZFRFIIHkx0N7fs0pR9
 l+cqx
X-Gm-Gg: Acq92OEIbDgePYE09R4eRCEtUoJqdSn/B/bjnJyju4X0/KQaHySK4YwO3cDwITpJ23N
 Y0QBadN6WOxLLQHv6njzS9bv5WZWvPh2flj0Jyh6T0XjYfQIXENUS3ixC8Z4B1z9nYR8ScrAXV2
 FIk66njWxUwuJPd6FKOhJW6jMQ1Cw0B5rICbsna8nSm1Z3RdRVsCkLZvmjQv+z5w8JcUAySKdgf
 XgzwsqJ3gohsrB9HfLEIDeu6bHlqU+aPI+6yH6fwszM0oxiKJ7JRtX2uYx7sSVIz68nPeu0VsfX
 RMAPtHAiSQD8mmCBK7fQd055vlH+aYnvTSCJgJJhSaB8DTyQspdTKVOWcCmerAxun0sq1yCu02k
 SbjVt4gL+hHyKOh989gfFzKsDRTRp1KhxILHyQXRk5Ggz6z2+C3lsXx24LYdhz8/7xwM6NRbur8
 KObrfFo0+ecyH3OzOGJaKOuaQMhPte
X-Received: by 2002:a17:903:3c6b:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2beb0715592mr55564175ad.39.1779487612805; 
 Fri, 22 May 2026 15:06:52 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 47/64] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
Date: Fri, 22 May 2026 15:02:49 -0700
Message-ID: <20260522220306.235200-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 7674e308b8..08ee5fd192 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -221,6 +221,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8d0c057902..90214a355a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1388,6 +1388,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index aa0c0ee1c1..9c82df136d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -158,6 +158,7 @@ the following architecture extensions:
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


