Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01209FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9Q-0006Lb-Uk; Wed, 29 Apr 2026 20:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9O-0006Kd-J1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9M-00069c-Vu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so325532b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508463; x=1778113263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=dSOQ1kJakcn2euojOxZ6/dR3B66VkHEX+lYBTWMLKwiOYh2FjpBFslzVzEam934Za8
 3rRzXHb/UEvv3wTJZyOW8CQ2DXBV60qKjxOdD4i/RN/Jv4OGjQhEaIzKc5pG9ZH1EbU8
 ulZiVBDreHAYt8VLRe2qJ6Ev5vdJUO8KvDMVZK+L6OveVCoHuDVcmRFWqZgoyNKYF1nE
 mK+zgnyZf6YgSPov5ULuSBWGljT1o8+Cs/sNpQGDZu1pyT3e+PYr/tGqsnucKjnBmVtX
 0p2grxkX1ZeVZQg/1cjRGDqz7Ox0cqVEfsDHdVio/VZgNPGaUzr6qSQYe3Xnzk7g2n6p
 teuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508463; x=1778113263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=R+xuTA/iOmaX6bvzIGyS7wSOpfpc6fL5tjHKGrVbhLCmYJ9rZtKtwbgXKefsh4yOF5
 CQGe0KERqoQTefpEjLvCw5D+Pu0nTvHJl7bVQL9ZNrwVp/oeuaZdajfsP2tno9XR/thv
 d1DSQCLkSiALZkPCHAC4zr9gjOyepb5yhj27wChE3GomZfGDGv2LtnhkC7z/QkQsOzmv
 ncjRTGUAf48jdg0qktYg1JM/OZFv+4vnYL7mIpNaS0tuDr87x4locPis/F8nR811oJdT
 Yp3t9SZqoKGlnY3cUs0ZRHgWjq/61abLiTkuydf54B6nqneczfhPIGWU3B3obRUIAXMA
 yWpw==
X-Gm-Message-State: AOJu0Yz/IhJi37wyCvvQddOEY3dHEdVmUXDynhNdEmChUPcnQfY02F1v
 nyA+irjOofQNv0l9e9qzpi7OTc1j8YXhT6Ei4bz2PC3ysBvlkhbAy1v/MDQPGYqcEjk8Y4pm4/1
 +b/yxN8A=
X-Gm-Gg: AeBDievWzct8293w4ggS6NJHcqG4tuQEmghiDsnm2shvH4Lb0oRm54maNkHcJsUSJLs
 fnLiAO2AVOWaNSeBaJiS8xhpL4nSmQdsYvBmIKer+3LFWO0+ba3PE3PGjlSIAByZKYisR694YpP
 qODwFDy3LQZoVwNj7B56dkhVFidenbyUmfcCUIL9QExzzGVgHoR82kJoxEVemzB9gZ1p9mxYpp7
 1tFf6TetKPcVarMikR7+VnraAzEeIkRUsIV3A+t5NseSccex5vgufWAyQ3/BZvl+XUMzpjNN4t2
 9XK/kZPQE4IbnMgejkjKyAZh1rTjaJWDcABxvVkANycFAugdx9UnGGPH19rXbXrAFtwxuJKOY1k
 3P4esB0kjBX7WFtxutySTZY4QBkCkxCpFY9zFKgcbZnuoUuxDA10kCAXyQf85SsXx5ufe0pnnZ8
 07RqmvfuR3dDSeUeDcmaLj9NLAEjRagobUtQBwAnN3
X-Received: by 2002:a05:6a00:399b:b0:82d:5da9:adc9 with SMTP id
 d2e1a72fcca58-834fdb0f112mr895384b3a.12.1777508463456; 
 Wed, 29 Apr 2026 17:21:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 05/47] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Thu, 30 Apr 2026 10:20:04 +1000
Message-ID: <20260430002046.59739-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

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


