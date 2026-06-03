Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE921CD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcLN-0001oh-MR; Tue, 02 Jun 2026 23:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLK-0001YV-6Y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLH-0004dA-4D
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c0bb4a94b8so24334825ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457549; x=1781062349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/Tioi3dpsi0F/SXE2FE6voGg8/eCNvGNXOCYhrTQy8=;
 b=NQmSajwP5zWbmRIaqgrttm3m1iFbNeJaUXB5QBB/Md2ynFGFhdb2IvnVm0WeCxjwhf
 TSscIbrpcbAWmhIxj+K5b6gY3ADK7APwQKxJeAb0Sr7prVjEzp51X0g0R+J7KC+Ls0eE
 7yZe7P6FAuG01I8n2WOaAazvrYfk4dpeMyr7Pp9Enom9In+xLg6AaHBkjyMq2gbn654/
 YWT+pJdtth1ZhXljkQzNRElbQbHuMvKpc6YH9oamZ/kR9+fphXHnNRlUIV5h0/S/mtyQ
 MteXQIaH/G2EvBAqxN+0fp31MesR4GH0qhgA7jHzl6soKlc8VWDkwg/KoglraQG957Cu
 f9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457549; x=1781062349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z/Tioi3dpsi0F/SXE2FE6voGg8/eCNvGNXOCYhrTQy8=;
 b=gbKuFMPkzvywfQeDH6nuGXXIMpH0yiD4HnnLHBCVDXPYgtaoK+OEP8dQlprngbqhOQ
 bTxT9xGJMMibyj4MX89FFtChdbAa9P4AAa5293xYvY4F8IGxZ6laeHJO48gwnElIhgY+
 nu6KF2GmaxjfjUBui0fdDjn4AOEcRzAKJdzeFUs2UgEb99UqLAxXWA9uBxH766f7ytd/
 om/scFUdYMdsqItLwmdbY/1GN6ZTSoFvJOtyAUxkUMPgX+mwsIR4fWxtYPpQ/sqKSycN
 Y67qkUFSwil2H5Ow6s08Wpd0lyNA49IP/0MFDkuTxTHFYHbxLE98f2aVLcqK0qoJgstR
 jTaw==
X-Gm-Message-State: AOJu0YybvfzKSU6S7Ax+QRxgF5iYYFi/hsEjotfQLBtnRf6OCF0nIkIl
 wHmH9OeZcWqaIs7M+RtJtAx2DSSzE3Ob4y6JBq6ei2rsmk7fboeqIzcjnyyJFIzjKV4f9/XJmBn
 CHJBWn0s=
X-Gm-Gg: Acq92OExpNBzjhMdSwofen/BnZPjkrEVO6+cGd3wE5msrBwTaa7gA+I03kV70EcC2Th
 lhbS6L48tVMXYCnLmWCkzxg0Abfmm8Z+SAC/Vl6D2/SfyLdtk58n6InZ4i2qFHidK3LU3kLwpZ3
 f2z8g8m0U+VPTtN5IPJehnjSNDVQlBtQLq7Mt3gapynrQ9G7Otctv/FJQjg5+VzDDQYy21oG1Rk
 19S2r2OrF8xhRMCqCYOEC9xG845QGcdIfajVqyvsh9zfFiS4tl23++8YgK/+FEpvoHj4rdbwiO+
 Ylemo4SdTdDNtE19Ey9jws24pDHizHkee9LPdZStmhlWdNFPxsIxPrwVqmU0F0AA6iR+4E5DJrn
 Hew+S8DqITytn8TLSVoDL6OVlVXBoSHV76+FecBjbTCijCDN5w34tznEsCPrII/rEmxitMvqi6y
 ApakILKeBerKio9kQciCaMyFkYxNtrxYhO7StoAIM=
X-Received: by 2002:a17:903:41c6:b0:2c0:af09:f3d9 with SMTP id
 d9443c01a7336-2c1644d1700mr16187245ad.36.1780457549213; 
 Tue, 02 Jun 2026 20:32:29 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm7785685ad.33.2026.06.02.20.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 45/45] target/arm: Enable FEAT_F8F16MM for -cpu max
Date: Tue,  2 Jun 2026 20:28:54 -0700
Message-ID: <20260603032855.106930-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
index 7864765ba0..4887a3a7b7 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -172,6 +172,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
+    GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 15dafb9aee..15c1ece4b7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1399,6 +1399,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index dcfb4f2073..64b2a87e1a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -67,6 +67,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
-- 
2.43.0


