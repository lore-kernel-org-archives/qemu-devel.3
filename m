Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D5FCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPldI-0006K8-KE; Wed, 20 May 2026 14:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcN-0004Jt-50
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:08 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcE-000288-Qv
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:04 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c8016d642b2so2669966a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301556; x=1779906356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgEG0/OuigOMwClChXrRoaFDD6e1qpvZV0h5+lZSYqk=;
 b=xxeVcUM4mHFMI3R0Ye5OeymKJH/NC/S4I8vCHkFB3hBaGty99H2WkIXErYA02dA0dc
 Jes6P8U0ExXmv+AmS4L9GywgcakwoEBYco+33CVrqkRY6cvXeL6tOmd1pA4rMGCE6oAk
 tAO5ALZoOAjh3SD9blSBwLePvoitPEyKQ8tuPD43dTSudO/FmZupf9j2gbq+Aeu5Ncr+
 5MUMJNBS9c7/md26EHLwqrMVrB0ReX/Mv/vkhvFPx40SVcS2E2heYBTTxhxn41P71/g3
 wgKWTLARh/6/eumG2hrwTgLc6ic5fA+FiT10DmoJtXG8PXvOUC3+jzpwOUA1ejszV16P
 L0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301556; x=1779906356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgEG0/OuigOMwClChXrRoaFDD6e1qpvZV0h5+lZSYqk=;
 b=tQWFnFKyu4yfaAFSlBzovs8TG5Mx1+begoHf0TkBViQ3dg8bdTngCinM8O2YGqWurU
 rmQrUr0Ai1uddVJx5CNmTB+2P4jB6vfB7Wx6/YBXb9J9ir/9f3igngXtD9jcTNWBFzdy
 MvuyT8pzzYTblmzxC3QNbndTPwf1ws9W8dHJra7amVNTeQZrnIxYwCnYbMY5TmBOP8iy
 M5+fZmpPZq7OCk/9JlMj5xCxG6TlxPtpbK0EfOWadI/jPt51x46XPKAoJGpQxdfPakIi
 l4m92nSRSEYujWrlr45deGsuQJDfdkL+zybhHCWWdoIjNceAKZCnanhRn97yf7uzlNnf
 S8aw==
X-Gm-Message-State: AOJu0YxiSpAG5i04c01U8falfYFdgE4iN9YvvCmrEtijn5niC6V7hXWD
 tN64FH5cG+HWkH9SS9Sx0JP4iHL7u6lpJO9eX84tpNakB+jbRiKDKL/GmN/4XqnrqqjbAXOwl2v
 y1HcC7I8=
X-Gm-Gg: Acq92OHdiF3rGFsXTIfKJl+1fr4AFoFTQGkHxbnkRptcD8xpQia/f1ZP5CTkYnJb8Fs
 KIhEMmGpMuFhLoKmKjrDCwb6limrALe/FPHC66QC2/GNUgRpSvFiBi6oK4YySSMMm4rcZiEpStE
 rFcP0RvjRygzFvaso2mcQBW56BEl/5eQt5v2/3M+SqHOKnXCYmd8BksTw1Z8GoqlOSnxM+WiJlp
 lsXYlHdZm1gOsRM9pADU1tb3U76Inn+Cl72itJdX0lJTVhtGjKs561xBztX4r4e5frqAK/c7VEd
 H0qt/mufyMsgquGdle3V+aNZ0y/ZK0pQ0zek/Mkzq0tuuZXPvN9+519LZ0SFiHQiCZrbc0RrdHr
 3mE1KifQPaa8iQFzD3W4UcW0mZYYkqoQ/6dsZd9pASfANOsDjlbxEgEHunW8v0l48W0dGFxalLD
 0QtnWBq7gsZ3DY9AAKQ8UuUbzm2htV
X-Received: by 2002:a17:902:fc50:b0:2bc:977b:846d with SMTP id
 d9443c01a7336-2be9d41df3dmr5381665ad.5.1779301556085; 
 Wed, 20 May 2026 11:25:56 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 56/64] target/arm: Enable FEAT_FP8DOT2,
 FEAT_SSVE_FP8DOT2 for -cpu max
Date: Wed, 20 May 2026 11:22:05 -0700
Message-ID: <20260520182213.872945-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6dec7e045d..a43b6367a4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
@@ -1397,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bee4e36dc6..875716d18f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT2 (FP8 2-way dot product to half-precision instructions)
 - FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
@@ -161,6 +162,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
-- 
2.43.0


