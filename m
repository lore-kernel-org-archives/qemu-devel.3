Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8046C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 16:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3AC-0001XB-18; Fri, 28 Feb 2025 11:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to3A8-0001TS-51
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:24:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to3A6-0002W2-1B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:24:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so15617625e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740759868; x=1741364668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hv5zzt4u5f4vowmmRU23adl9qYXTG9rnBzhDNQshj7Y=;
 b=t6TN8gg9oGezx94XbIyX6WkQnPZgrF9Yc2ttBzCcIv62VHvTF3HO+3iJqUGshY/bNh
 Kn4VdZVHSU+BF6B+qnm8iTsM7WS9ShNOil0ofPeuDTgm4aF5fDLnuohwshpcUlXZ8Wew
 ystdZGEJ5sPIetX8HDihLa+jdeS023WLc0H7UeTjkjKcHw2OY5aHU1Dj953Ol6JkgiTx
 Qr6zzG+UPm1LhGzZfvG48JseczN3B1jYEAhN1Jzbn1aAYg5UmEBlvCDYec6fTF/0LPS0
 +E26L5GKR2RyZcjm3ZRIsmMb4NlDNxX5KjeuZqCRxp7dj2eB1oSxVgjDPBzddOzOXSME
 edhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740759868; x=1741364668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hv5zzt4u5f4vowmmRU23adl9qYXTG9rnBzhDNQshj7Y=;
 b=WvA6P8H2ldZsNK5XZvdAYCYS0c3S8ArFyPR80eFeYGPAJM7I92bAapHeVTVzBQn8iy
 I7e9y61ns5CAqL9MX/Y4U6cJV9QW2ylGJhsUTcIMAKpLgWo1sN8JbrnlwP4jWm3moSZL
 NTckR8ShwcpfcILeX5cpeVnO2QeDekp4o2agAS/3GZjkCYDXjtIz3/PTvLPshWPuM48M
 zy7YNORE1QrE6/t59WKKYgxFgvNMxkm48ZxVRkDAEBuFJaOl/KDlavw14lIpqJiKrqXC
 7zBJGRsBbqsRD1iGtT/YuFtbt/ZK3eRZKQOBTUg+JDFLbZgFBy9THXPXxRNsDSg+n/0i
 Zz8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPYa2nnYdhUraKF+QAQfMf7AE2M66HpsEHZH4fuLFuGby/sO8mJothmi/cgk/KeYi/L3hwM89p8jG+@nongnu.org
X-Gm-Message-State: AOJu0Yw8KbyRvuf3MpREre4icoPc2HJLVwePaZtLnGgEiBeg3buAwZRO
 ggSVkSqzGuhI8QevBjR8qJH0LLkLTI5zR43PBIrlSamqGIP75R3s9RMfoRIbNpk6FgY0u9F8ag3
 Z
X-Gm-Gg: ASbGncuGf55NYmFNI7OEghE36hwcAAbfJvbzcKdY6CVTO7jzWVL7BQZe/BmAgBmV+y0
 OqRrZ4fJrwh3PpVE3RjmM5+1S+lT5yX2eZe/m6a3C2ExOtFpTQ/YkCjg9wSCByMcS1h9GuLJ0Nu
 oyf54JtatN65ykIBFUldPcfICom5JK8V+mFgAuAipR8FkxyArUpbNpNG2CBdaHcCxCOTSh+Taxr
 L4gQOdEXsfz4DfuDHl77gRKxhoc/hDmAyG0gQuBEXbkgTIyaCzV8/ioUxhwM3HYUJcbQtsnfYh2
 86T6AMUpQ2+ObFWGgO+zkxiig1T20IdJ
X-Google-Smtp-Source: AGHT+IEmA5kxpcMdxa0hZ3znu8BaoAaj4PVcH/23SZzvSDW22+feJY5dxekVgw4E9orAuDOR+2BYOQ==
X-Received: by 2002:a05:600c:3ba5:b0:439:942c:c1b5 with SMTP id
 5b1f17b1804b1-43ba66e6fdamr38823255e9.11.1740759866781; 
 Fri, 28 Feb 2025 08:24:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b73704228sm63460415e9.15.2025.02.28.08.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 08:24:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Make dummy debug registers RAZ, not NOP
Date: Fri, 28 Feb 2025 16:24:24 +0000
Message-ID: <20250228162424.1917269-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In debug_helper.c we provide a few dummy versions of
debug registers:
 * DBGVCR (AArch32 only): enable bits for vector-catch
   debug events
 * MDCCINT_EL1: interrupt enable bits for the DCC
   debug communications channel
 * DBGVCR32_EL2: the AArch64 accessor for the state in
   DBGVCR

We implemented these only to stop Linux crashing on startup,
but we chose to implement them as ARM_CP_NOP. This worked
for Linux where it only cares about trying to write to these
registers, but is very confusing behaviour for anything that
wants to read the registers (perhaps for context state switches),
because the destination register will be left with whatever
random value it happened to have before the read.

Model these registers instead as RAZ.

Fixes: 5e8b12ffbb8c68 ("target-arm: Implement minimal DBGVCR, OSDLR_EL1, MDCCSR_EL0")
Fixes: 5dbdc4342f479d ("target-arm: Implement dummy MDCCINT_EL1")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2708
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a very old bug (a decade old or so), and Linux doesn't
hit it, so I didn't think it was worth adding a cc:stable; though
it's not a very risky patch so there's no particular problem
with backporting it either.

 target/arm/debug_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 36bffde74e9..a9a619ba6b1 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -1037,7 +1037,7 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
     { .name = "DBGVCR",
       .cp = 14, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tda,
-      .type = ARM_CP_NOP },
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * Dummy MDCCINT_EL1, since we don't implement the Debug Communications
      * Channel but Linux may try to access this register. The 32-bit
@@ -1046,7 +1046,7 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
     { .name = "MDCCINT_EL1", .state = ARM_CP_STATE_BOTH,
       .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tdcc,
-      .type = ARM_CP_NOP },
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * Dummy DBGCLAIM registers.
      * "The architecture does not define any functionality for the CLAIM tag bits.",
@@ -1075,7 +1075,8 @@ static const ARMCPRegInfo debug_aa32_el1_reginfo[] = {
     { .name = "DBGVCR32_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 4, .crn = 0, .crm = 7, .opc2 = 0,
       .access = PL2_RW, .accessfn = access_dbgvcr32,
-      .type = ARM_CP_NOP | ARM_CP_EL3_NO_EL2_KEEP },
+      .type = ARM_CP_CONST | ARM_CP_EL3_NO_EL2_KEEP,
+      .resetvalue = 0 },
 };
 
 static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
-- 
2.43.0


