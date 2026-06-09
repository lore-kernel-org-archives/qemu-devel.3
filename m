Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1840ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX298-0006ud-Qi; Tue, 09 Jun 2026 15:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX251-0005jo-M3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24w-0005Ws-Te
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c132ac5ec2so58700115ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781033084; x=1781637884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVt54R9Grq/oYBK/4m9vlQsoX3OtzUgK4EG3mmjG47Q=;
 b=IymtBy4YPVg2z9rXeLEU6lXk4H4SQnFbf/UzzjKp3QjNuax9ysK+VszeJds8vxvBer
 5kA7QVZKHRRKBPwSJIFS3AnZhRmi4QLb1KwwE44WwcB6UfHqsYVGBV5TQuYErHcE0cna
 OjK6eHS1LpZ1//AN9c9Pe6dNshQwktk7yZ9bU0STQARBsKY0pyephNhX/nO4/dncy0jG
 HN/iuNxMEwSGHm8SPyBZKObkS2fLxEa6NDndo796tkZA+2WFzxU4sQwGcA2kyk0qKMJq
 q5lXjtMrcO1M+24XLg1vu2b8mH2Fzt3gck3L81uWtY6KorqO323vWWUzG5CexDCBLoWX
 xHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781033084; x=1781637884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UVt54R9Grq/oYBK/4m9vlQsoX3OtzUgK4EG3mmjG47Q=;
 b=LohGmuZ74YzQJ/AJTc4PW0xbsAJQlXifq5oXXKdZ/8IU0cOzj6FHAuR00Kj7y2BRAU
 W0iZmB8AFS/2A91DteNGHvplnLNl10qcywd7mt/iohANkv2MacaErk7wxXVJodH+lP8S
 AIaUblDxo2fyPmr9sRUo+OQXinwITqOt9J4db3EFrfituXbenmEn5HbgN4kX3QDvSWHf
 otfiX7s9wBmDcREZDXlubI4jOYx+cbUHvLIhU8G2j7bGjFC4BYCDay9uFVvhHmAhlaJ3
 +iOh/KkhY5L6vuTYRBuGpjrhq6aBKr2kM3kGYyILdF6SZNgR5oRNVC+TjMYQZutGfGNK
 H/3g==
X-Gm-Message-State: AOJu0YwxJIO9gw+50j1f5PMkfhUeGLsDZXga1qjUVjjZuujSdQatWK9d
 BOongTbsHLYYq29Mtbl2uQIp/FjlitkE0IabEmPzDMXTMKb/MEy4o5B1tPmcEGDtgYDAMad2lAe
 unh8Pa80=
X-Gm-Gg: Acq92OFLzLvs/Jd4KoD/c4hYWM7uv+nVFCP2wE/7TWO1YpVOyLjrHwKbHJN6ENNxCjC
 qjTM968qZIoxD7WHOKXWowgjAl5CnG04GLaJiqv5E6Qwf6MOT5zDxK/G27vemkC9pKrBrYYMpvT
 VFIx5X7++VCuN1/AkYKocDaXJ3ywc3AjGNGHJlfYlFCXPq0qYAOhKPUIsCwj3BsAJxm8SHdgDAC
 QNCfeQLu5vbWIOEcq3Aq0Ui9SUvMqRuwuRgcvXjKABL+ijBLR5UCBjSEnm2CDRDzYnI6kAHwHYm
 uWukcZs5Awv+WXzekplnlKQYzIBxZWHtaC+rntcnKLpIp83C4S6lyF9vWyups/c+eEz6zbLCEQG
 xibIORp6Ftbbkw+sf/lMVrOhe8t1gEoGhrg5GlLE7qU3cPe03tlCkb8IVMJ6ZJtuW2FUroR3KAX
 1aneuqDuguwe2upncoQoCMDqsP1HSk0i0gOKSFwgDmIM8mIAZrWQ==
X-Received: by 2002:a17:902:f64f:b0:2c0:c4c9:4cb with SMTP id
 d9443c01a7336-2c1e7e7a6eamr239468145ad.14.1781033084260; 
 Tue, 09 Jun 2026 12:24:44 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa00b3sm212247045ad.32.2026.06.09.12.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:24:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 42/45] target/arm: Enable FEAT_F8F32MM for -cpu max
Date: Tue,  9 Jun 2026 12:21:06 -0700
Message-ID: <20260609192110.752384-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index d40e39169b..7864765ba0 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -171,6 +171,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
+    GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 893e20f0eb..15dafb9aee 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1399,6 +1399,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index f1c8f5aa68..dcfb4f2073 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -67,6 +67,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
-- 
2.43.0


