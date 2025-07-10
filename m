Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F62C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 21:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZyXy-0000Z7-6X; Thu, 10 Jul 2025 17:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXs-0000XL-Vq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXr-0006eR-Co
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso14047725ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752181866; x=1752786666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxglZr9FSbfBVmHLZ+FvVDfQKN3fWf8b03y6OHhLFac=;
 b=S2ubFhecNrlcE0wHvzSd++yXvrycuf426RKI3nyvqXRxAJO+rp10BunaJO3R6CbvLJ
 5iRLSMhsHbhAUhJ5ErlhM2AL7OwNa0eoxwgTdO0c3lW0ypnK0ubyAQirEeK1H79rpGbd
 iXcQDAxy0LYW87ouBC5Fy7GHhO1ygSHHjWqk9Mc3C2l2nOpSN7yTgjHYZCpuoBNmTfEr
 ZyhTyqVCs2a8C643FZKoSAn1IBFkxpHXAqw0q7s2mZ3lNbK201jOOVV8wxPhW/OkVLuz
 eR3NkZhvqhfcF4uf5e+bUPVC6UKWqzoFBpXBn0mMRQHkmiAFh7E4KinellZyMhFC2MWM
 AbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752181866; x=1752786666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxglZr9FSbfBVmHLZ+FvVDfQKN3fWf8b03y6OHhLFac=;
 b=LSA1FATAu08MbSiubhLpdom9PjFLQoDexQhsVPjbyFtNeeJvBLyt2FJ8iNdjwP5PlR
 3JlAnB1c/a/axCHoRNK6yR0wd/BFIWl3XqpuI29WS8/wQrdOQeL6xPcSmfsXxny9lska
 SpE8CNzxNJ2k437jdZ3nsJM3Sl4RbXVJQPWD/yAwuBkb9M6uqUJnW4qrNFe7cR9q7YQ9
 LSNbywN0p9ZLqqp/rc8E55t962mQYJf+lvNKouIOeEjfDvK+renIFooEws899DIF3AI9
 qoJFP9EI2Ba4WXWKheKRBzyniCC/T4C2uYhmUE4oDERCbUucTu/lDXQNbXAASRuXmXaU
 v4qA==
X-Gm-Message-State: AOJu0YwVgL9mvgiBsFYyBNnkoXRHrsqMgcGTqJtkZvT2saFUa5hjc3nO
 UTGA3c7Fjcc3dsw23q8TCQWjP5fRrcDH38E5TLUD2W+qGSvq0xraTTQaYR5Vqu4CpYE=
X-Gm-Gg: ASbGncv8wfh8go9uC8IGVPpZweg3xGHefI5I+cPIiMrZlGB0Gx9M7DUXJ/Ifjps3H09
 Tn0b8O2tpLd/DOBAELF6TWGt2SSFFI7FSPzYjzFYqfLx8XpWjFSxzZ3Yz6vrxugbwNub55wdh6L
 7sCFZV/4LCHUOFYVcKiIYCaa+OP46+UCnf3ub1NGvmbn8XN0tCL6Y9Ul750vIuKM46e/s4djTX7
 5XRCoGKmbagj9fOxZ8v+FK2K3FV4X0C/HBcrvjYYYf764zRJ4k4AwR6RVoOaypg2DT4bb3Ya+lG
 AvifutYAV1ByyTbCn41U7IOL9DbHjS5mTlxu8869ChKzoHw0ayCN7VWZ4FKAQAnLuimoNiYTXhH
 I0f6/KYNRPzxtjaI4QgQ4CAReAVCA84lEqY2b79GfTkrxYiF1+1ymmjMm0g==
X-Google-Smtp-Source: AGHT+IGRi/54l7dYMIvw7MZjU0TCT2MYW3MaMAMb7gvme9jACt4mMt+PGVFnwDgSGyEgz79DhyRmOg==
X-Received: by 2002:a17:903:2f85:b0:235:f45f:ed53 with SMTP id
 d9443c01a7336-23dede8914fmr9118495ad.33.1752181865996; 
 Thu, 10 Jul 2025 14:11:05 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de434d6b0sm30447775ad.203.2025.07.10.14.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 14:11:05 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 6/6] target/arm: Advertise FEAT_MEC in cpu max
Date: Thu, 10 Jul 2025 21:09:41 +0000
Message-Id: <20250710210941.1098088-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710210941.1098088-1-gustavo.romero@linaro.org>
References: <20250710210941.1098088-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
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

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption is supported, but software
stacks that rely on FEAT_MEC to run should work properly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 3 +++
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1c597d8673..d207a9f266 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,9 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
+
+  * This is a register-only implementation without encryption.
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ae2046a7f6..1b9b6475b6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1250,6 +1250,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
-- 
2.34.1


