Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39A0C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qf2-0002OA-LP; Tue, 30 Apr 2024 12:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf0-0002Hg-Kb
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005cD-J0
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b79451145so35703845e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495727; x=1715100527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c6JJbqohxseNO79U2Bdi9j1VL8AGsp3zzZqnjvDFGr0=;
 b=y84HdGzKyGNZRSWKWnLtnPb93jMCwT2hKVw3V+ccIOum83flams7aqpk1NbyCZHPci
 l1FggY1Yiik59+pfnoeX4Mg/CqZOivAx7Qz9rJoC5ukPqK4EV39Us+Wi47863HoSKFrg
 10scOZXPDvCPyU8yMyuApQJMINGfKoYdRwgSZWpjmLk35xD7xBkYM9zL70AYySpfrVou
 GLZrDkFHMGhQ7E3e1r4ux9xgWySkAMTtP4e19sdjzS6qUmOJ7VVR46jSubp7gb0nsFRj
 zKg5XOifR3d5xhBq/nU2Zy/36oyoS3ndYfKRxqzs465sSUiRtvt9GBOLT2oHXpahGyXh
 4wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495727; x=1715100527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6JJbqohxseNO79U2Bdi9j1VL8AGsp3zzZqnjvDFGr0=;
 b=lN/WrplsIELTy2QGs3pHsLim9GGNwtxVMYU6oAemD46etO07LYw8pHi1m0CT3zMBo9
 uau1o44mJRBntijClnCXCOqspmt5h7nJ6S/8f9uqjXZqJ+9/551ytk8ppPY8RZNr8oH/
 VGIW4C7F3AxsdN+0Sg/R0SmH7DcRyQT6v+ZA6GLknExkv3hs/vChO56JlP9ndiLgG68l
 xK1D/F8b3GvmJhovychodxI/wraZtgtgtXkd5lza/lW5/tYuvk9OjeW6hZ8IsapeagHQ
 k0panXI8PVBule/g+3vLLyjH859Finpg9C1AT/LKN0vB8jWCpAXZqxkciYCtUFJBoFJF
 gvzw==
X-Gm-Message-State: AOJu0Yz08EEIbfNlVwkF2NdEr3t430Bd65YroBv8yUJBS1M5M4qmyDZo
 /8ST1WOtnQZy+i6ZRad8pf9K7aUs9YPUqRgq6JbxUi1wF7GrVsftE+zF0KmhGYd9pG+EcuokHza
 X
X-Google-Smtp-Source: AGHT+IF6j+bL1mzBkMypGlpNub//3eQy/hVfHnbfJ911ZKR+ZVmNF+DoJZVqRnOQcvrwnABjHFBzsQ==
X-Received: by 2002:a05:600c:3b02:b0:418:f991:8ad4 with SMTP id
 m2-20020a05600c3b0200b00418f9918ad4mr79671wms.6.1714495727034; 
 Tue, 30 Apr 2024 09:48:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/21] target/arm: Enable FEAT_ETS2 for -cpu max
Date: Tue, 30 Apr 2024 17:48:27 +0100
Message-Id: <20240430164842.4074734-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

FEAT_ETS2 is a tighter set of guarantees about memory ordering
involving translation table walks than the old FEAT_ETS; FEAT_ETS has
been retired from the Arm ARM and the old ID_AA64MMFR1.ETS == 1
now gives no greater guarantees than ETS == 0.

FEAT_ETS2 requires:
 * the virtual address of a load or store that appears in program
   order after a DSB cannot be translated until after the DSB
   completes (section B2.10.9)
 * TLB maintenance operations that only affect translations without
   execute permission are guaranteed complete after a DSB
   (R_BLDZX)
 * if a memory access RW2 is ordered-before memory access RW2,
   then RW1 is also ordered-before any translation table walk
   generated by RW2 that generates a Translation, Address size
   or Access flag fault (R_NNFPF, I_CLGHP)

As with FEAT_ETS, QEMU is already compliant, because we do not
reorder translation table walk memory accesses relative to other
memory accesses, and we always guarantee to have finished TLB
maintenance as soon as the TLB op is done.

Update the documentation to list FEAT_ETS2 instead of the
no-longer-existent FEAT_ETS, and update the 'max' CPU ID registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240418152004.2106516-4-peter.maydell@linaro.org
---
 docs/system/arm/emulation.rst | 2 +-
 target/arm/tcg/cpu32.c        | 2 +-
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index d70b66f7530..307539cff91 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -50,7 +50,7 @@ the following architecture extensions:
 - FEAT_EL2 (Support for execution at EL2)
 - FEAT_EL3 (Support for execution at EL3)
 - FEAT_EPAC (Enhanced pointer authentication)
-- FEAT_ETS (Enhanced Translation Synchronization)
+- FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index de8f2be9416..b5a60682fa6 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -67,7 +67,7 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_mmfr4 = t;
 
     t = cpu->isar.id_mmfr5;
-    t = FIELD_DP32(t, ID_MMFR5, ETS, 1);          /* FEAT_ETS */
+    t = FIELD_DP32(t, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
     cpu->isar.id_mmfr5 = t;
 
     t = cpu->isar.id_pfr0;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8ad05c53e8d..ebb585afd85 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1196,7 +1196,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* FEAT_LOR */
     t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* FEAT_PAN3 */
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
-    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 1);      /* FEAT_ETS */
+    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     cpu->isar.id_aa64mmfr1 = t;
-- 
2.34.1


