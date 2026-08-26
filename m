Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1099C61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeL-0000TW-Vh; Wed, 26 Aug 2026 13:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdy-00007b-80
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:34 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdw-0004p9-FE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:33 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso912705a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766151; x=1788370951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oZW3qoD7QrbM4MXrB8JSaCeBkeFxfPJqAEghSbxmme4=;
 b=nJZ6G3yxx3ksDSa/G+pWfoWA8KDwXV77mAartVWWBZ6ZE/Mpgl2LlFqeoHo1lNfDyf
 w5eZF6L8AZYMjJulUUZ/VGqEePHuBaAaj4WfX2Zy03okpeQ9Icg1BBStlC2I/PDzAJ7D
 zmGogfgih9yDmXLeQ2p5FHYj7iHXNRA02jLWGZVTlKQNIMDpkzptG/20PeGEc9NNDXsf
 faVBAl4GF61CxhhGJTTSDyvAskEQTEE9B/ArIlJ5GNbvf8/sTaergolg5/dwb57nakXF
 THsQ8nWlTlO9BB1YfXtcFuzcy971FmAXH5ZB1nPaoMbzdouP5L8+2MLEC/yWJmpMDpHO
 P40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766151; x=1788370951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oZW3qoD7QrbM4MXrB8JSaCeBkeFxfPJqAEghSbxmme4=;
 b=ZPT6WAbAPWyFcXbxUZEQ/jxClv8C2UDTG9B4bMo568UEgZzP8k1Cz7bUF0nQ6rANja
 T3LQiYwMicUdVA0WpCrYmmDnFchDF+uqRrIuDd4HD/lG3ZAy22fkFBJ/c8snBITmPvMU
 N16NOt6eTAh4N/6db59M2ViWKOn8ohOcY2Aq8fNBxI9GfCvAlDxeFwzR4tHHO0ukQ+8O
 Cmn9eTeaaXsY8KxewYJLJPmyo+T+9gcv0cv8GEZr2iE+KfP3NFuNKlaGNw+I2mYGxUsm
 avdHh1pG9puVSRe8HVINc9wBJhi+U14/jmg4OlO4pnKT6jEkJOvvbERqsDZSzlF1d4Hk
 XVwg==
X-Gm-Message-State: AFuF++ngO0jefyCtlZ1QXqjafkpap2IAxL6IM40F9w1aF5+kcNi5Gnsw
 GjeRKxTzB/5222v+0UsX+SJix9vGdXz74Udb+d0xjLEsyVwhVfU/OCtFLhrFf+HukClMOEbicB2
 aP+/VTME=
X-Gm-Gg: AR+sD11T3sx+JQDnxFZ4I5p70qrpSyzx5VIbXdUoI1mbcFpcuLpveKxPJ4A+JbOzBlI
 6cq80LUJM9ghJeFvPIdixLg2vc/0wiRKRgMN1Rxy7xMW3SGmu0MMFzo98C2MhmRD6a5M2jetFpt
 9iHQgjBXOpN3kMqsuEV+0SOkF+ih9MvNxvRhhDtRzDKNgBlMKM+OkprwXLTk0KeGV9r1bWRVrJr
 zASxyKWPtrWB1L6W9lTbZh64NCrsM8BPfsOcoJMReoCdyp5SHQV2eWFStUwO9gLlAsjdtLqUlQQ
 D54CRHSidplEgBiHEu8kbpTSkczTc57aZP5ASmwULivisajum9X9NZJavz9eBOJ1S0pag3psHBw
 N5wDm7EF81CNOTWRm6KT2lWPU8RjZ1STLpN1USQvvQCUPE1ItA3EYzKX0OMORTS11CzPnooR6ZX
 QpMUwV4Qx1SsA66kc3jTo4JUdLOwa3YO6rCLkco4WBdrrKjCJtQEZEOGvaS8N33yUg3qTqVhvsW
 1JZkA9EPsA3XtWmNprt8ugNJZkx
X-Received: by 2002:a05:6a21:3315:b0:3c3:875d:c52f with SMTP id
 adf61e73a8af0-3cf83239ac1mr18129710637.10.1787766151051; 
 Wed, 26 Aug 2026 10:42:31 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 14/25] target/arm: Enable FEAT_SVE_BFSCALE for -cpu max
Date: Wed, 26 Aug 2026 10:42:01 -0700
Message-ID: <20260826174213.614571-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index c086548f7fd..bcf2e6b9c18 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -180,6 +180,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sme_tmop, ARM_HWCAP_A64_SME_STMOP);
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
+    GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7cad37ae61a..f04d708bcc2 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1473,7 +1473,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
-    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 2);    /* v9.2: FEAT_SVE_BFSCALE */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
     SET_IDREG(isar, ID_AA64ZFR0, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index eb22469bb36..d41ad978bbd 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -198,6 +198,7 @@ the following architecture extensions:
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
+- FEAT_SVE_BFSCALE (BFloat16 Floating-Point Adjust Exponent)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
 - FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
 - FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
-- 
2.53.0


