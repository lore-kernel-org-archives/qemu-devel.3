Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560C5CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXxi-0007iD-C7; Fri, 22 May 2026 18:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxd-0007en-E7
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:17 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxa-0007i3-SH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:17 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso5101246a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487393; x=1780092193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmXdq9ODYKdXc+cytYsEHp3t3uaJcjbDztZoPpOdHO4=;
 b=gSrALNNz3V42YHOiAR73vjFvgcYz2eZ1ZStTLcDfWkGb5wFP78fr95oV+UiGU1LNsY
 u1x9lMCzbYNwZE0hGdPUvolKCWch/vTTq5xK0fVV/Ro2Pmbem0LCFan9LeaGmJ/cprS1
 etG0Jn2MIY8PjgIfeS7wg4oHsoawuC9qGV4rGEPdyOqlGs6fZdI61nVwpN8/4Owcd3L9
 mW+6o98gi12Cj1RNZ4Lx3MPrztzlTcDKZAKpbNmV24DEhtI5rclH8oCqZ7f7DPLGAtNQ
 j9RIid2xEfJhmx+wVB3YxlLAKZCiXfOGIghpgy2rmOpqPvYlfn9n9nPW7RiFZHwciZ/2
 MJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487393; x=1780092193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KmXdq9ODYKdXc+cytYsEHp3t3uaJcjbDztZoPpOdHO4=;
 b=Oy0wLagEirOmjHVitQgoDEuwNqNh68A/4uOK4PyiZNAt1filntTo3CZ9s55yLCCf5Y
 jC91yDI2RddOafcu2plDJ8BfUBC+Q03vxgXQKM2hL2tKUcRLuyZJYo5Hh+vrTNASC59Q
 ab/jK+Ew3K0kiqGAzWV/pCMd+Nylq7KX3difVEdFqPZmh2eeee6SsBeMVU7qZU2PaGuB
 AMstmLABn4AclhC6cj5ZkR4ter/cDdLB4oRqrfbkG1U2rOZF4e/Pb57T6SYKH8ZJB+h3
 DBsOmvK1Z7a3NORg5UPrOwPf3EDpHBbDQOOc0JXnN5zTcKry+3KUvP1vNrlemDXNVcde
 7+6w==
X-Gm-Message-State: AOJu0YzAPTAJN9w1aKgyArLcBAWVzMzUxEd3bCrHEBN7ULqTlRmrpGk9
 1TjFF16SHHJWdhjQ17wPuejcl8fkwO+rgliZ/GnhlTXXwdaQsoTnnKgRUFg/VJmeJUMw8Kt/xW0
 PBjNZ
X-Gm-Gg: Acq92OFQUd3FueSzn5DHgHFvNfHt0f7VEragrDtU63tvZxKQHgOvTCumq9a9zkbh3oZ
 XXRu+GbPPfxR/fHgD9pSvYW/BDyMtlwYOl96gNTmAR1WCua391Pn1VZfiwq7ZA9ClCB8axu48Oq
 cnuUo079u1ZXLOi9H8/sq6d6PQkaHrZnAMR84ljdtIjwiudDfJ+eHxM8u1R15/8It7QTi41yisj
 lNxlyZRP7W61s8jIBFuIuDvxqKTpDlm14NeWv5k0TOcuJ81jQTdV1qvyg+P4EXEOlbw6ZNRbKR1
 YltjtEVIagtYIPiYDmjKEKgW21uUu/rDo/WQ1tXNK0ZFuVngNieEewSaFscKmB8IMEd3jDfBA0i
 2xZ0yP6l51/W8LpNy1ugIZexO+ezAzEb3Knp8Ynp+jnwf86mphk3lssikp41zqpCdQU6udvQsvu
 GH960QRnq9zNseQqadB4U/Gom1rws/
X-Received: by 2002:a17:90b:5188:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-36a678479d6mr4947674a91.21.1779487393331; 
 Fri, 22 May 2026 15:03:13 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 05/64] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Fri, 22 May 2026 15:02:07 -0700
Message-ID: <20260522220306.235200-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 3af5a37776..c5ffe21368 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -218,6 +218,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
     GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
+    GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..ff0c2b1c47 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1266,6 +1266,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8cd7fe7b00..da5f7efce2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -68,6 +68,7 @@ the following architecture extensions:
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
+- FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
-- 
2.43.0


