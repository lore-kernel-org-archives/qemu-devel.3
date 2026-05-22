Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE17CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY37-0002hE-0X; Fri, 22 May 2026 18:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1W-0006sO-3g
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1K-0002tK-MQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ba928852a5so54804785ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487624; x=1780092424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSJGtTmXrIutJTfw225D/kpWUuwozty16kvKc6iYOfg=;
 b=Pbf6h0k2Xag4vqiz5MRHyMRoSFRI/TNdrQSd2oV2eLQpRLlMf3POy2wbnspjX8Qb/R
 f3um2VuVTMNXYDTUGamp7T2KIXd1Nr+cxBrE5WlsKLNTpOAL9+jVPocIz5Rng+kM2D7o
 FnUuqnqA7k0roDGmPQD3+e4LpI/0meqr5SAD0bMgD7GgQ0+519zEFHn6Vtq2AbcKJRFR
 rbXHlXM5JqlcxMgxApNb8OZcpuFUoNsQSJ9K5BZu5v2RtlVWzHDx2iajkKLhasEyveKw
 b5G/4Cw022lS1ISkYHt6Ac9D3tfqHgUo9mMil8d8gXHZxNglUrnPGVgfFZFcwYYk/QSP
 +jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487624; x=1780092424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tSJGtTmXrIutJTfw225D/kpWUuwozty16kvKc6iYOfg=;
 b=V9jlGEuSgpDhB8up9He39ZA4LCyTVfBycgcoM8w0/6p4vNKEK3AUfnl77CDhPEuzza
 vBKbziRCb1MXoinr74Sf1cjrB0SBlT7KygrUNxMDA3JdEPbe3rKB8J7xv5pYwBkYDyF5
 OVLeO8uL0QqC1bWqLIm4fa1n6KIijTnrue0eFtOZ6YusyKzu4rIZttbjn5o5nn/imx/J
 GCH0FXCfMx07AfBnwmq+w9RcWlUyLVdEk8Ko5jhoXljSWIeslvJtd3eIUno8Q7DkXN/s
 BWveJZ2d7P/BW0ADr/6bPfs1a6t+UxC8+3Tv1/PPkasD9UearmgYc3AkjvhOFWFnj1gt
 DX1w==
X-Gm-Message-State: AOJu0YytGPuzFFmkY8Vxk0VJMzWs3E2HPdh+x1JoqwcfCNsYbt/0DLTD
 Zm7Mu/Fjt2jpVvOl495JhPEjM3PYvUefe4eOd/or+8PWVimxwI7Wpnj3iBZp4tHsB6rclXAF44o
 0+nw5
X-Gm-Gg: Acq92OEtSYDX+Dido4CY6bZ5AqBa5n2RRIQTyBJKO2xiZ1FPzM5NpcDIHiT5ge09iZf
 7290C5n8kmeWqV6MII75r5Bfj5scuyCccajpXYIbdfPq9yA+S18EvHEmCMDcYJIHBHxdCAEkklT
 Lw2/dPguSX54astPh6Z+2AZZYIo2V0mn1f37edDBp2qCzS9vvBTC4O8HZfaqBNtK8ITfdrrbAjL
 fEUjBl7B3AZJkSoxPR0UWHKkcvWZ+ok4CkObX33dStuTghIqX2YuoexHO3s2NXtujIfNmNoooFx
 9lq3bs5nL/rqctYJanw51w6PlbqbYYLFV3WTLgnmQn7LfqXYQQ0azyuuZYqPIvR0NDX/tI43mXt
 8PSgnLtdQ0Q10gZaOHR1PPgoAeznjFXO+HkFaqqhYblE7jXd17iFTL48ju/4K7y1Yiizfhj0LNt
 qaeyybYtmb+bDBDp0qWWXsSUI5VVjA
X-Received: by 2002:a17:903:198c:b0:2bd:2de3:519a with SMTP id
 d9443c01a7336-2beb06ea5e1mr60150835ad.7.1779487624467; 
 Fri, 22 May 2026 15:07:04 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:07:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 61/64] target/arm: Enable FEAT_F8F32MM for -cpu max
Date: Fri, 22 May 2026 15:03:03 -0700
Message-ID: <20260522220306.235200-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
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
index c9ab26b2f5..160a6c7769 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -170,6 +170,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
+    GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a43b6367a4..7a47af9f5a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1398,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 91e66096ca..0091b8d337 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
-- 
2.43.0


