Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E112C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUc-0001Ha-4D; Mon, 16 Jun 2025 10:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRAU7-00016a-4o
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATz-00040y-2W
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4533a53a6efso10971335e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082800; x=1750687600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LChNT2oan2dCMkf7YUp2ghN9GIJ92+FXAYXzABpNUw8=;
 b=yplTDK2QVw1f7Pv+/Dt86BXSznEG39wVACjtlZIP8bEZAqYLWpFcxQlgmR92k3Cu/M
 alj6gSWF5nKSNw5NXfmm51qG7j2pUlv0stLMy/iOg+oivCsxWDyosb/cByDtWPQpMxXy
 lC+nMsETsq6gcJareYU4TGAKmjxwHxLXgvcvbTwGXwFtBcuG2GYT49CU3JuvYib5hsQ6
 tceaOW9aeVauCOAi9OWVmg61QCR0DNolhXT28VfsKnWs1wEamThONLDQVEX8+sQalVCt
 hn/fo7XIt58CqExRzM34lMxJlVUdt6dHkzxpxNuZ5m4Ox3ortLurGmcct0cMMZIhi8Zu
 y0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082800; x=1750687600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LChNT2oan2dCMkf7YUp2ghN9GIJ92+FXAYXzABpNUw8=;
 b=j0s+i3XnBfYkubB5imNWLmHIPD3lejyv9xe+s2/GdsTCsVDwz7BWVMKjrqyj7qq0Rz
 a//zsxggmZHr/GbiuVdBsbIGcIwdDvqFHl340VdSKr4bt5P6ATwV2P/B+Ap+f7N9ET2r
 kOWJ0nrlZYoDzJ8IfNJ1HOuxg+v3f5XC+S8xdUz1orKG+SV21XFUQuVq5GbuEYWjR4/h
 hc4cfS+lp0u/76NE4xjEfW98uq9YB7IQmcFLQ9K5/d/YDssMHi65r9YthQsbvIab400U
 iSiG9kgP3YAV1sKncpdichDsrEnGxNgPHRD5LGOYSSZlQrBpMPCPgW0FJxH0aijKfFq7
 n7uQ==
X-Gm-Message-State: AOJu0YxDe16DVTaRBsa2REC7EY5hM4MOqkRlmKKJXw3iL57T1aaKW57r
 1seqmj3FqJ7vaFeKVaTnBehmBkn96yhw4kycvXAC+zN6s3taoPvj7cQ9IDLUcKpGKX1QqFScJBB
 akbbZ
X-Gm-Gg: ASbGnctHe7IsRR13E5qm37ItCQzLgESft+VE7PFDJdl/gqCEcZx6zao3oPeLVjx10L2
 t4/KvFVHY4JR9ujLo0IkHFVHPCE5TgQXvT+6TF/5Z/vH0Kn0mhtM/O6SGneeaYQpBpoc4poTjPY
 I4mKTBYy3FbuI2gHDN0cvl1FZl3JbZUpVFUO8elBvldKMZd872V66Qg8Guq+xRi9+bRPOwPli43
 cwlEQBoq7xcNcYRbP3REJh+ZNXGHyQp5uYSQw6/JZya7MmODZczSM5SCuBZxurGLO5ePbu7ET7J
 ZlBozsMKtfeumfUEvBSK0gvLqf0CyoUn8aaigPeBxA54G4D6VHxQAwWEU/+oMPJjA9Bc
X-Google-Smtp-Source: AGHT+IGJqHXYcba1VCswTvfaxnwCn7dIqydzLTDOlZAKGF5MFlnGtikP7ITD9CNBuvxnHo7lVRItJg==
X-Received: by 2002:a05:600c:1549:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-4533c97c5eamr85760065e9.16.1750082796972; 
 Mon, 16 Jun 2025 07:06:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] target/arm: Define raw write for PMU CLR registers
Date: Mon, 16 Jun 2025 15:06:25 +0100
Message-ID: <20250616140630.2273870-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
default write function, which clears written bits instead of writes the
raw value.

PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
had ARM_CP_NO_RAW. Commit 7a0e58fa6487 ("target-arm: Split NO_MIGRATE
into ALIAS and NO_RAW") sugguests ARM_CP_ALIAS should be used instead of
ARM_CP_NO_RAW in such a case:

> We currently mark ARM coprocessor/system register definitions with
> the flag ARM_CP_NO_MIGRATE for two different reasons:
> 1) register is an alias on to state that's also visible via
>    some other register, and that other register is the one
>    responsible for migrating the state
> 2) register is not actually state at all (for instance the TLB
>    or cache maintenance operation "registers") and it makes no
>    sense to attempt to migrate it or otherwise access the raw state
>
> This works fine for identifying which registers should be ignored
> when performing migration, but we also use the same functions for
> synchronizing system register state between QEMU and the kernel
> when using KVM. In this case we don't want to try to sync state
> into registers in category 2, but we do want to sync into registers
> in category 1, because the kernel might have picked a different
> one of the aliases as its choice for which one to expose for
> migration.

These registers fall in category 1 (ARM_CP_ALIAS), not category 2
(ARM_CP_NO_RAW).

ARM_CP_NO_RAW also has another undesired side effect that hides
registers from GDB.

Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
PMINTENCLR and PMINTENCLR_EL1; this fixes GDB/KVM state synchronization
of PMCNTENCLR and PMCNTENCLR_EL0, and exposes all these four registers
to GDB.

It is not necessary to add ARM_CP_ALIAS to these registers because the
flag is already set.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20250531-clr-v3-1-377f9bf1746d@rsg.ci.i.u-tokyo.ac.jp
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 76312102879..889d3088079 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1904,7 +1904,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcnten),
       .accessfn = pmreg_access,
       .fgt = FGT_PMCNTEN,
-      .writefn = pmcntenclr_write,
+      .writefn = pmcntenclr_write, .raw_writefn = raw_write,
       .type = ARM_CP_ALIAS | ARM_CP_IO },
     { .name = "PMCNTENCLR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 2,
@@ -1912,7 +1912,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fgt = FGT_PMCNTEN,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
-      .writefn = pmcntenclr_write },
+      .writefn = pmcntenclr_write, .raw_writefn = raw_write },
     { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
       .access = PL0_RW, .type = ARM_CP_IO,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
@@ -2029,16 +2029,16 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
       .fgt = FGT_PMINTEN,
-      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write, },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
       .fgt = FGT_PMINTEN,
-      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
       .access = PL1_R,
-- 
2.43.0


