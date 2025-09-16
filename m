Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07178CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4a-000370-Cj; Tue, 16 Sep 2025 14:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4X-00035i-Rs
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4U-0001bH-IC
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45dcfecdc0fso58276305e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045989; x=1758650789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=962IUHk4Fm5KFmeKbrFTpPCwGn8ge5yNRC9E10wxbT4=;
 b=sPaQS4P+BSRsyuDiiWdQgMOdQ94/Fc/UqV8VlGd9skSAN6pMZ8ZGehUJV2xPhvenc4
 8vODIVtkwGbHM6Yvv2gfnC/RiDa79MSid66CiMhB5VOOhJo7jmwkJxF/TOlAl2oHyWU4
 tmAENKpEKvxl4voWMo0ip+s23puvJ9rqdEd3mWOhvhJzmZR5e/bHj3NE8qZmajWRYW2B
 pnFFuPVqJUhxI05kW3Gw+iD5a8m4swtVCM8xmT2sMlbquB8nsF5xCAY3LNgf6a97dAFq
 miTqYn+0CBaa00MKqIZXB9jL2Wa2tsl/plib4S66UKnneKRkJBLLDohV9+jDZ2lmHB7F
 1rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045989; x=1758650789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=962IUHk4Fm5KFmeKbrFTpPCwGn8ge5yNRC9E10wxbT4=;
 b=Pnkjn/pf70TGtN/GxmDPm8rT/0hmoK7PPy2uPaRtuKGAASgsv6s3PimSqoc6AEozhi
 Yz9vCY91csBLK204w56k6AmhkK2+y4bFUZryeQYD1KDQ4HgY5kz3WJahS6drjIdmpc2u
 bF+qJ9PY7bQEW6tWzfXMBMs1Iyv6OhkrHkcL5jJCI9ESpdvxtnUUYMPAvRwDrVeU4aGN
 7O/ZVOi2pjtNN2ABO6oT51UIqBRR2CEkB4KXzD59nLqVkHPLa6UDlku3FkVynNYYgGe1
 NH3wjf7TRzpTfu1m908BWHNhAhXrx4QiqAqV4pdPIzvZW4QFiRFmwjAgGGlgXv3ofdQb
 jctg==
X-Gm-Message-State: AOJu0YxAI2Z8/7upxZ90vXOixyRl+dXc/2VA5hu1WBU7LUFc2TQZntU1
 C48pG5V2q2a3oW+dIZAXbWf1xN82he/5SMT2GROfcdRcOZBkFjE2VRTXqXgADDNNqh2kxBZ5Q1x
 8P1KR
X-Gm-Gg: ASbGnctPM1Fa+q42ocyW4DxLP66Nz7hXPqNE7TERaNYK+mP9HRdWATdPprwJI1SMoyK
 +fsWhJ3jOE44d2YyPWLwhQ8HJ0stZ4YxHb0Ejqo8Gu8CRIB5yUmqSmDnWWRf+V6TQCpCBcPIS57
 COemJn7pFdE6EUb1rI9rDsnRtLdLoAO6LQVcz26cVyV8wOTIdueR1T0QO8n3xBiMvYbrb31zPLD
 iOh2mCDsY+hju24AaNTIDQCigts38+6xy8p82d2ehjXciKnHjU3ZWtQQ+wvdo/bntxVF1TAUHDc
 abM0OmXky93hf/wxXdBcwPahSh5icLQaXPWacoA5/yFz5GBa2plTBQZgUumRV+I7NiXY8Vjsb8e
 VbDCXhT98hIezXFtStxzpi/C6EiJZ
X-Google-Smtp-Source: AGHT+IFEXCWxSB5HAmMaNbHPRz3FibqOa9ns3O5p9NQ2qAhRyzaKMOqZepNY6usatT4uSFI3CD68Hw==
X-Received: by 2002:a7b:cd97:0:b0:45d:f7dc:f71 with SMTP id
 5b1f17b1804b1-45f211efc4dmr129586365e9.25.1758045988713; 
 Tue, 16 Sep 2025 11:06:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/36] target/arm: Remove deprecated pxa CPU family
Date: Tue, 16 Sep 2025 19:05:49 +0100
Message-ID: <20250916180611.1481266-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In 10.0 we deprecated the pxa CPU family (pxa250, pxa255, pxa260
pxa261, pxa262, pxa270-a0, pxa270-a1, pxa270, pxa270-b0, pxa270-b1,
pxa270-c0, pxa270-c5).  Now we have released 10.1 we can remove them.

This commit removes only the top level CPU definitions and updates
the documentation. Removing the CPUs means that there is now a lot
of dead iwMMXt code, which we will delete in subsequent commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250828140422.3271703-2-peter.maydell@linaro.org
---
 docs/about/deprecated.rst       |  21 ----
 docs/about/removed-features.rst |  14 +++
 target/arm/tcg/cpu32.c          | 163 --------------------------------
 3 files changed, 14 insertions(+), 184 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b2420732e1d..f0314147698 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -236,27 +236,6 @@ Keeping 32-bit host support alive is a substantial burden for the
 QEMU project.  Thus QEMU will in future drop the support for all
 32-bit host systems.
 
-linux-user mode CPUs
---------------------
-
-iwMMXt emulation and the ``pxa`` CPUs (since 10.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``pxa`` CPU family (``pxa250``, ``pxa255``, ``pxa260``,
-``pxa261``, ``pxa262``, ``pxa270-a0``, ``pxa270-a1``, ``pxa270``,
-``pxa270-b0``, ``pxa270-b1``, ``pxa270-c0``, ``pxa270-c5``) are no
-longer used in system emulation, because all the machine types which
-used these CPUs were removed in the QEMU 9.2 release. These CPUs can
-now only be used in linux-user mode, and to do that you would have to
-explicitly select one of these CPUs with the ``-cpu`` command line
-option or the ``QEMU_CPU`` environment variable.
-
-We don't believe that anybody is using the iwMMXt emulation, and we do
-not have any tests to validate it or any real hardware or similar
-known-good implementation to test against. GCC is in the process of
-dropping their support for iwMMXt codegen. These CPU types are
-therefore deprecated in QEMU, and will be removed in a future release.
-
 System emulator CPUs
 --------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fff781d6b7c..65fd564d229 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1138,6 +1138,20 @@ reason the maintainers strongly suspected no one actually used it.
 QEMU Nios II architecture was orphan; Intel has EOL'ed the Nios II
 processor IP (see `Intel discontinuance notification`_).
 
+iwMMXt emulation and the ``pxa`` CPUs (removed in 10.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``pxa`` CPU family (``pxa250``, ``pxa255``, ``pxa260``,
+``pxa261``, ``pxa262``, ``pxa270-a0``, ``pxa270-a1``, ``pxa270``,
+``pxa270-b0``, ``pxa270-b1``, ``pxa270-c0``, ``pxa270-c5``) were
+not available in system emulation, because all the machine types which
+used these CPUs were removed in the QEMU 9.2 release. We don't
+believe that anybody was using the iwMMXt emulation (which you
+would have to explicitly enable on the command line), and we did
+not have any tests to validate it or any real hardware or similar
+known-good implementation to test against. These CPUs have
+therefore been removed in linux-user mode as well.
+
 TCG introspection features
 --------------------------
 
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index a2a23eae0d7..f0761410ad0 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -807,144 +807,6 @@ static void sa1110_initfn(Object *obj)
     cpu->reset_sctlr = 0x00000070;
 }
 
-static void pxa250_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr = 0x69052100;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa255_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr = 0x69052d00;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa260_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr = 0x69052903;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa261_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr = 0x69052d05;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa262_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr = 0x69052d06;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa270a0_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr = 0x69054110;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa270a1_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr = 0x69054111;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa270b0_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr = 0x69054112;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa270b1_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr = 0x69054113;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa270c0_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr = 0x69054114;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
-static void pxa270c5_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    cpu->dtb_compatible = "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr = 0x69054117;
-    cpu->ctr = 0xd172172;
-    cpu->reset_sctlr = 0x00000078;
-}
-
 #ifndef TARGET_AARCH64
 /*
  * -cpu max: a CPU with as many features enabled as our emulation supports.
@@ -1032,31 +894,6 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "ti925t",      .initfn = ti925t_initfn },
     { .name = "sa1100",      .initfn = sa1100_initfn },
     { .name = "sa1110",      .initfn = sa1110_initfn },
-    { .name = "pxa250",      .initfn = pxa250_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa255",      .initfn = pxa255_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa260",      .initfn = pxa260_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa261",      .initfn = pxa261_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa262",      .initfn = pxa262_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    /* "pxa270" is an alias for "pxa270-a0" */
-    { .name = "pxa270",      .initfn = pxa270a0_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa270-a0",   .initfn = pxa270a0_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa270-a1",   .initfn = pxa270a1_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa270-b0",   .initfn = pxa270b0_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa270-b1",   .initfn = pxa270b1_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa270-c0",   .initfn = pxa270c0_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
-    { .name = "pxa270-c5",   .initfn = pxa270c5_initfn,
-      .deprecation_note = "iwMMXt CPUs are no longer supported", },
 #ifndef TARGET_AARCH64
     { .name = "max",         .initfn = arm_max_initfn },
 #endif
-- 
2.43.0


