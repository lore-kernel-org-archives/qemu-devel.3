Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBEFC4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVdu-0000jy-Ay; Sun, 19 Jul 2026 13:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdl-0000gl-UA
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:27 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdj-0003Dn-Pz
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:25 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso5477390a12.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784483360; x=1785088160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0CtLZvXDNlXfS9i+K4OAJUmjoEmIO//slYt8sWEi78s=;
 b=sqWR9BbSqxIs9xHVlhrwisWU5oNC8ugUFuo/o8oiqoWxw7cXSf6Kz+8zPTI7/PgpYp
 lQmrE7Is02n9Hkzd48Nko2TBXIsjLtXif8BoOmDjP3948XHznX93GUpkfcv/RQORSCbe
 Out7GwJITP03jSxjYtVO3QGAOxGzbJ8+f4D5gK/zZM58puPNZzjzvml4iqO2EAhhTTIQ
 eYp9JwIIOvN/U8WyxJEgcWWJaM+0qn5S9mxz20XMOjMlf6+sLrGFIZr1erX9K2uOBQcn
 C5CYiLPEXMXaaQkzZqaNvTVg00lVTTSrsuVHqIZZtCorRkvsVZinNBq3UDp3mrPKIb7g
 fsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483360; x=1785088160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0CtLZvXDNlXfS9i+K4OAJUmjoEmIO//slYt8sWEi78s=;
 b=rhQ1ztL8bwba78IMWLoZe84ss8ckgJ5yV8LDNtVSYKaSYnebwfyFK3NdG1wq/gk4Uc
 4Wcc3NGl5wd+HnlWmH+/ygLKjBxe2GN7uwPtnwTRWXsLFEKb1ppFO1I6NQcRnQ0oPzsi
 9NG3f6reG8kfbeiY5ARcsgKouk5GA6374DtJ5kLObOdM64uysfY9Dymo+yqxycvFmpcw
 aAWTaFxWn1kFc8PtI78kS4AhgMEXzssrvwDm493Q4/yUBkrAhxq4BqFX51h5EVVSRxDb
 rPpRVsWfwItrWn/3mqQoVeQEdbZD4Dex7pD+5D3soXz7i7bLuJB8aspdI5aUbmVkXwJx
 Ub/w==
X-Gm-Message-State: AOJu0YwfzevPmleTi7tp2E3gh3g54hyEtnf4dJm+uR9f36hV09Z+Wcv5
 4UeXSjGvMExUKUGZqY3L1cYZHpYQbtoNylz5khavXyL0hBiV29TllobRCtVU+RyFy87tmH6tFn4
 E7kRF
X-Gm-Gg: AfdE7ckFhh5JgBqvsPwA2+SqIjVzfNjBOBIxF3f25yUoBstQZAdfq57h7y35ZRU66zW
 /4IWioj2wislc8+jW2ydipGztvvhMjAGlr5TXmf+QBZ029y4lXqpFtD6fbEKmcHcVtqn7qS38UX
 ixk8jPctXRo4VMmgna1NN8U+l0OoAx2SvzZTDrBMNYLuWX+pwCFOcF1f8mlamkpeXLtSRfQ7vtk
 wxTKn63StUI5kAZbVarVKv7dC7BFSCGIcKLVFT0W8Qs3qpiLrwYrRXI+qMw2dT6Ql55DcUP0AhD
 bqbRw6QgEsOgEe5aXXmER9nO5xp8q/u6f1+uVSIZcpajjIlSjLWNu7hS6alqnXwGsSRkJOKGnJ+
 kF69oCbycYDecI7743CviEEWE/zJmf00EgttmhCvGYvRyNGC9PX9KvLEOAo279bHx6VN/8DBaVK
 W95YUTVeK1Y4Mlx1MMlw==
X-Received: by 2002:a05:6300:95:b0:3c3:859b:9178 with SMTP id
 adf61e73a8af0-3c3ad7a3a0fmr11907378637.34.1784483360514; 
 Sun, 19 Jul 2026 10:49:20 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm30471881eec.29.2026.07.19.10.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 10:49:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/6] target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for -cpu
 max
Date: Sun, 19 Jul 2026 10:49:05 -0700
Message-ID: <20260719174905.420725-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719174905.420725-1-richard.henderson@linaro.org>
References: <20260719174905.420725-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

These features are tied together if both SVE and SME are enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 5 +++--
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 48be49580a..c086548f7f 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -178,6 +178,8 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
     GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
     GET_FEATURE_ID(aa64_sme_tmop, ARM_HWCAP_A64_SME_STMOP);
+    GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
+    GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 24f34947ec..33eafb467d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1365,8 +1365,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 3);    /* FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
@@ -1403,7 +1404,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 3);   /* FEAT_SME2p2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index cc42db9e0b..4d33be615f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -179,6 +179,7 @@ the following architecture extensions:
 - FEAT_SME (Scalable Matrix Extension)
 - FEAT_SME2 (Scalable Matrix Extension version 2)
 - FEAT_SME2p1 (Scalable Matrix Extension version 2.1)
+- FEAT_SME2p2 (Scalable Matrix Extension version 2.2)
 - FEAT_SME_B16B16 (Non-widening BFloat16 arithmetic for SME2)
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
@@ -203,6 +204,7 @@ the following architecture extensions:
 - FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
 - FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SVE2p1 (Scalable Vector Extension version 2.1)
+- FEAT_SVE2p2 (Scalable Vector Extension version 2.2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
-- 
2.43.0


