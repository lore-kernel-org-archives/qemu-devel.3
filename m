Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3ACC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 16:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhWWh-000803-7C; Thu, 31 Jul 2025 12:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhVbQ-00072d-Ct
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 11:53:56 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhVbN-0000i7-Fd
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 11:53:56 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8fd59485d8so416233276.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753977232; x=1754582032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MHpTrJTNzo7HG29mOEamfx85lbWpbI9V1O1CNxWJ9oA=;
 b=HQs83tA9XzFvTYGiIcZXnRDY4RS9TwWhW/joaToqDONKGw7fF8yG/LjaNlJyd6j6nL
 dQmO/GCD6gfuInpv7xYdGrjOQJVNpxj9fsQ/qWlY4xTOWvXScFeooZ0kmMJaUxvNypjD
 ic8FdFVE0+1Lb6vupEWlXiZH/pLGZGs4AShv2QCvVxM3tE0UyKEpV7t5XxIxVFkXhIt0
 JbMOEo+KL/fKSZ60UWK+dKfKUTlKxuEcwKNzhdB7rLn5KJtTm9EUrir+emf25O9UTXsi
 PaDYAWpDpCdj5xpAy01o84Yn49nuwLehPLd487KUceDCL/8+yiFHXvVM1kq6Ajlyj4u7
 c2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977232; x=1754582032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHpTrJTNzo7HG29mOEamfx85lbWpbI9V1O1CNxWJ9oA=;
 b=AOyLWod0gGjgJPzGEicux3UmpXZD/u69GNx+wR8XHq9PofyyRin6k5tMEn9O/425dg
 ZSAsH56cMiE/A1TQhSfy6q+QRBOl5HSTPvd0vTjMItUGC8STu2V+Cwu5p3T7rK+7jC8U
 mKwhU9Qm+XSnQfxCUe9BTh1pZdpu2/LxbtBljFKS0Hgd04yjFAjX8SY3kPU4dOVnYqrh
 XHCTc+4BkjIqsmnBHqCw3RDhjc1MoBOahERtHntOv8kU0fdxzqkVqDV9VaULygF3P6ma
 uKpSK47S2kiSoMkhtBaen7R/3wU9yw2FR5YvRXGdi7SnXhNgaFRN0V0+Bg1AXU1wMUky
 fnCA==
X-Gm-Message-State: AOJu0Yw4pR6+ARj7XlkOy4IpdMRtzrKrnlADvKHxxJgqbGu9ahsOMvft
 aaQV96DmUDyzgLd4N7tAtholzyeLr52spHfp+zYuMGx/H3idP5ASBS766Haoj3kyJ3jhsZ05ys2
 320h8l19ISMUZeqsT47e6Rc8IYCrFCpiridxw1QzAsg==
X-Gm-Gg: ASbGncsoyOwcG3LTsr0De7g+gDNYsCXdxI1hFld0CgxOOIbhkEVJ1ja7MH+qwjXcSFb
 bYk9MvqF5ZX7/tbSdC/kDVVfD8z5UxIExH/oMIGduXt2RRCFxlZwc5/GZOgkr17pCfZqVkYWNch
 8tYUPfpdYQGOWr4DvnlcWNzHlDwR14/tsWd5AXdZbWr2x+US2Q5+au7amqf4x0QXXDUU4ftxcIi
 K46WqSB
X-Google-Smtp-Source: AGHT+IHbvQip19oLivCPiMTxNYdC6/8OmalMeQJqe8CXzQcKedWm5R8J24ktQNlhiib+qQPxWc8hfSE/RY7aTOcphwU=
X-Received: by 2002:a05:690c:85:b0:71b:4739:9d67 with SMTP id
 00721157ae682-71b4739bbffmr72786167b3.4.1753977231709; Thu, 31 Jul 2025
 08:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250725170136.145116-1-alexrichardson@google.com>
In-Reply-To: <20250725170136.145116-1-alexrichardson@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 16:53:40 +0100
X-Gm-Features: Ac12FXyoD8-2Ybyvoewapl9ttyUs4lzuDiQWHdooaPnzkerMisfmeJ7acFIh7VA
Message-ID: <CAFEAcA9_LB6T_+bkJhBnCAD5-9BT1MPHJf6q_ZOYfV9oDRFj+Q@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: add support for 64-bit PMCCNTR in AArch32
 mode
To: Alex Richardson <alexrichardson@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 25 Jul 2025 at 18:02, Alex Richardson <alexrichardson@google.com> wrote:
>
> In the PMUv3, a new AArch32 64-bit (MCRR/MRRC) accessor for the
> PMCCNTR was added. In QEMU we forgot to implement this, so only
> provide the 32-bit accessor. Since we have a 64-bit PMCCNTR
> sysreg for AArch64, adding the 64-bit AArch32 version is easy.
>
> We add the PMCCNTR to the v8_cp_reginfo because PMUv3 was added
> in the ARMv8 architecture. This is consistent with how we
> handle the existing PMCCNTR support, where we always implement
> it for all v7 CPUs. This is arguably something we should
> clean up so it is gated on ARM_FEATURE_PMU and/or an ID
> register check for the relevant PMU version, but we should
> do that as its own tidyup rather than being inconsistent between
> this PMCCNTR accessor and the others.
>
> Since the register name is the same as the 32-bit PMCCNTR, we set
> ARM_CP_NO_GDB on the 32-bit one to avoid generating an invalid GDB XML.
>
> See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en
>
> Change v2->v3:
> - Moved ARM_CP_NO_GDB to the 32-bit register if Armv8 is supported
>
> Changes v1->v2:
> - Moved to new file
> - Updated commit message
> - Added ARM_CP_NO_GDB
>
> Signed-off-by: Alex Richardson <alexrichardson@google.com>

Thanks for this patch; I added the following comment tweaks
and have applied it to target-arm.next for 10.1 (and marked
for potential backports to stable branches):

--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -1206,7 +1206,11 @@ void define_pm_cpregs(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &pmcr);
         define_one_arm_cp_reg(cpu, &pmcr64);
         define_arm_cp_regs(cpu, v7_pm_reginfo);
-        /* When Armv8 is supported, PMCCNTR aliases the new 64-bit version */
+        /*
+         * 32-bit AArch32 PMCCNTR. We don't expose this to GDB if the
+         * new-in-v8 PMUv3 64-bit AArch32 PMCCNTR register is implemented
+         * (as that will provide the GDB user's view of "PMCCNTR").
+         */
         ARMCPRegInfo pmccntr = {
             .name = "PMCCNTR",
             .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
@@ -1284,6 +1288,7 @@ void define_pm_cpregs(ARMCPU *cpu)
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
               .fgt = FGT_PMCEIDN_EL0,
               .resetvalue = cpu->pmceid1 },
+            /* AArch32 64-bit PMCCNTR view: added in PMUv3 with Armv8 */
             { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
               .cp = 15, .crm = 9, .opc1 = 0,
               .access = PL0_RW, .accessfn = pmreg_access_ccntr,
.resetvalue = 0,

thanks
-- PMM

