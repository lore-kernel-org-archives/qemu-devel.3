Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB7E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDt-00019I-7M; Tue, 24 Dec 2024 15:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDY-00073P-Uk
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:25 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDV-0002yv-W5
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:23 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163dc5155fso55567595ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070961; x=1735675761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTGDXG/LHK+cbArsNVQoTZPhYd/l2OlGD8Apa8yjd5c=;
 b=imwiTqt55KHmMFeNaE75nII/ZaBDuPy4V2/0CiYKrGhPJvZP3fo5s52aC3fAaCl/nI
 j7p3BAT7W1iST011QE1d4DXMdkLgOgCfa5fRNJJs8Uo7FNQHDrWjVoYmwUPIJTRhQ4pJ
 vkFs+tKIaOXDq4a6QeGaZswt/h73Sw75jK7REzqhFlLiSYwIFYyvjmaGwD+zFOaLhfcn
 BMGJOtQuCTdDR+aeumsK8xT76gM26uRH+v6AL6Yte7vLEbzv/K+VFSr54EKyXkBz8GZz
 xOrjVALZWUueqs84l5SaIn58YwXecIj5bbG7SmLgErS+xC7+C8FQ1bTFB6UQIsXzXPff
 ftbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070961; x=1735675761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTGDXG/LHK+cbArsNVQoTZPhYd/l2OlGD8Apa8yjd5c=;
 b=NHVsSth9vzU778W/Kk2Y1v7EdVLkAMSzp9NllZXFVkjB2ez9hEshBiw8ReRIG0l9S1
 OFH6TKfVav1ro4GWPMDDSC8AygH6s4VekW5xw+bC4kRKQqobRDs8GegMpY3CszChZ2mM
 DTjipaUYDTwL/LJ6UDBbJ5A2DFjEROUOZfrpJzX+I3EQTsZImw7dZ6fcjoxec0IsWgs5
 RRANxG/fMjlDWYBpAnQ8C1EmuRhDOfvv9iWzksC8L1YSlA5vb8focMIwMMptdcLuG8b4
 Y+jD7n+AMVjl9PPdiAGq1iCWaNpxJTJwMJXCZFkHhuctL10OuHCF78z4uXTXTM04+Q1R
 84+A==
X-Gm-Message-State: AOJu0YyrZFzuy11SuNdC9z3/h0z+4QiNvdhOt8ChQtlV2aQrtEzwgs5K
 oOZx6sXJbTFrHWpyE71scjm4x1qJjHK+kEMdP2wquc4wfM+X3XqWg1hXomJRusjyYo0QXeHMsP/
 1++U=
X-Gm-Gg: ASbGncub3ERq56oZkJiLTCj90ck1uHcfI4x0CLi/nk6VunFUuQm2EGA2iEf9O4tbO1N
 cqx2Aw0/TOKVQJbSLgyBFOMEzKJiuI4fD7Xn796gqKUE1vnwypP1hCLthPQWq15VjHZWVCdjkCO
 dcIZrR4JApxvV7/9yDvJvf2w3YZqb30VtJDxh+7z+1mbgUn4OuYuRClgQf5v1anF3hCw98bCdRs
 GJPkFVtcMTFIw586eJBasXk2/g43wfLLcNhXvPcPfA4sMSsDus5wWvDoLWnd7Hd67mX9fWhEclC
 yQGCX2GWspSxLJdpW3XxAL4hCg==
X-Google-Smtp-Source: AGHT+IFRCWpNSIzAmDr6P7A4FDXFnFAvgrsxGpgNR/bkTlhB+xuygYXOj2HYo4kFWq24oiREhUpjFw==
X-Received: by 2002:a05:6a00:a95:b0:725:d956:aa6f with SMTP id
 d2e1a72fcca58-72abdd5eea8mr28794770b3a.5.1735070960766; 
 Tue, 24 Dec 2024 12:09:20 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 61/72] target/hexagon: Use float32_mul in helper_sfmpy
Date: Tue, 24 Dec 2024 12:05:10 -0800
Message-ID: <20241224200521.310066-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There are no special cases for this instruction.
Remove internal_mpyf as unused.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.h   | 1 -
 target/hexagon/fma_emu.c   | 8 --------
 target/hexagon/op_helper.c | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
index 91591d6050..ad5df5d038 100644
--- a/target/hexagon/fma_emu.h
+++ b/target/hexagon/fma_emu.h
@@ -32,7 +32,6 @@ int32_t float32_getexp(float32 f32);
 float32 infinite_float32(uint8_t sign);
 float32 internal_fmafx(float32 a, float32 b, float32 c,
                        int scale, float_status *fp_status);
-float32 internal_mpyf(float32 a, float32 b, float_status *fp_status);
 float64 internal_mpyhh(float64 a, float64 b,
                        unsigned long long int accumulated,
                        float_status *fp_status);
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 05a56d8c10..35971b8b99 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -655,14 +655,6 @@ float32 internal_fmafx(float32 a, float32 b, float32 c, int scale,
     return accum_round_float32(result, fp_status);
 }
 
-float32 internal_mpyf(float32 a, float32 b, float_status *fp_status)
-{
-    if (float32_is_zero(a) || float32_is_zero(b)) {
-        return float32_mul(a, b, fp_status);
-    }
-    return internal_fmafx(a, b, float32_zero, 0, fp_status);
-}
-
 float64 internal_mpyhh(float64 a, float64 b,
                       unsigned long long int accumulated,
                       float_status *fp_status)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 01d1a1b1a7..d257097091 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1045,7 +1045,7 @@ float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV)
 {
     float32 RdV;
     arch_fpop_start(env);
-    RdV = internal_mpyf(RsV, RtV, &env->fp_status);
+    RdV = float32_mul(RsV, RtV, &env->fp_status);
     arch_fpop_end(env);
     return RdV;
 }
-- 
2.43.0


