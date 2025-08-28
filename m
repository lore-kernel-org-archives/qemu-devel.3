Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C777ACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFT-0000pr-Ql; Thu, 28 Aug 2025 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdEv-0003ov-53
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:04:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdEr-0002sy-U1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:04:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3c98b309804so618441f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756389867; x=1756994667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I2T7Q3Zb2MyINP8iWgz0Bm0qh15QLlWtfSTpJupbEV4=;
 b=PNJzoDCG4SeWo2xn83WBlW6+EXDHOgCJrOCilUF2CHvyfCEc/PV6zL7L3VFsl5onCv
 3p0TYZH5OwPHPW2d7KfAXs/b7VhDyjVIZugVYkrpxw1s/0gaPv5k+emEoliKYOuZeLua
 ZrtyreoroDLYiEMyxY4aPgq0zYaJHdcSC1YjZsWMSdQ7AjN+ybkrJom3CIC9NHOwQMGx
 av3KOEYKj7xAbKeSyaRaaRE7SaC6ePVH+wTBx9ofzANcZSMqlEUPPKx9v1cJeGnPBLYz
 g/FNBgSd+d6Jaancd9ckdxAq4X8S4RXwavbjDfT3bzuifM9+txE7dRVnMBEm4NMevO+H
 yRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756389867; x=1756994667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2T7Q3Zb2MyINP8iWgz0Bm0qh15QLlWtfSTpJupbEV4=;
 b=ZsQtAlwzD3YgIYjLDrYLRSerzaFZffXW/9ngyVOyvypCWxhRHrnESj07H7wzhPweU4
 gtXEFGi1Dzc6CnGVaOFyjzhm6hZu4kRSC2lYb/Yw+/ygORW8kfWhhFAQWqekuBaauIAQ
 DB5+rx/JAP65qdI/6UyPQWQ1VIaWYV2rn1mxTGAEZJf04HO+4sADzB22U65BC7XtBbWp
 P4Ibfu741Gb4D72Ug20XD/F+YvY2XGrDxS5vz+mWGfwr0wdbsxVK5w1BYe6N5wCcFuHo
 oAoXgLC0A5CnPd8NbhRErVLdolZr+3cOiH6sHgkuwCmFqJgqq1zO4g+kEL/XYv1pBnTx
 vEtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpofSjziCL7QpMjsM79NiydvACC/7QMTeQi7dQunAVX/5eXN7eIUuiWZ0jQ3m6cIPZ+zsKLsCDUXYp@nongnu.org
X-Gm-Message-State: AOJu0Yw7GyWmLCIE90E6/iANowJt/2nFWeigII7bNAV3ILkEYRXCKcfC
 7+JZ6N1R8Po3ybMLq6lK13YH/QXvTn66lsELgkLCWzEYT2ebaeb8BNPWIlDKpbMYMZZ0SqUDROa
 xDcou
X-Gm-Gg: ASbGncu9wRNIGTSX1WCU7OO8+nE6eCzUReUzZExIPvGiSOi1qwdDq+P8kCOi5gDm84T
 4r9crjjg2zcPFcuCBmeWl8Ak88qeyKb8g+SX4kutT0tXMe/UlD3Wy+V0g7D/SQTtMYDpm+I802w
 agUemQfw8hV5u8k4B2XCO2/l8xwhZihK2mN8ma+m9mU7aEqHSADPE5J55LRX5VK3Q/9j/AZyBTS
 u9VI2E7xhciwiGNWIV5u0K+Ybw9Aqrv9wP9zpBiNcwWExYsIi34Ho1PkzEytFi2JKUcLBtINeQw
 zLiTpfTLcQiaKc9fLRMauLi9jgiq+sX1exX/lbTIZ/x4tD9WNq9zGqZQfnFJcC5d9DKpYWBSJCv
 K2kysFuAEutTwzMbHzf3oMPPtv0E/
X-Google-Smtp-Source: AGHT+IFH0XDq/ssPXoQnkfS4+9Bxc6c8oppWVUWEBG1khYFDaQepDelGU9jrYcFW3usbI4UVkzA1dA==
X-Received: by 2002:a5d:64cf:0:b0:3c4:39cc:366 with SMTP id
 ffacd0b85a97d-3c5daa292d1mr18156686f8f.15.1756389866583; 
 Thu, 28 Aug 2025 07:04:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cce1724939sm6947712f8f.26.2025.08.28.07.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:04:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/5] target/arm: Remove deprecated pxa CPU family
Date: Thu, 28 Aug 2025 15:04:18 +0100
Message-ID: <20250828140422.3271703-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828140422.3271703-1-peter.maydell@linaro.org>
References: <20250828140422.3271703-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

In 10.0 we deprecated the pxa CPU family (pxa250, pxa255, pxa260
pxa261, pxa262, pxa270-a0, pxa270-a1, pxa270, pxa270-b0, pxa270-b1,
pxa270-c0, pxa270-c5).  Now we have released 10.1 we can remove them.

This commit removes only the top level CPU definitions and updates
the documentation. Removing the CPUs means that there is now a lot
of dead iwMMXt code, which we will delete in subsequent commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst       |  21 ----
 docs/about/removed-features.rst |  14 +++
 target/arm/tcg/cpu32.c          | 163 --------------------------------
 3 files changed, 14 insertions(+), 184 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d50645a0711..5e12567ec68 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -246,27 +246,6 @@ Keeping 32-bit host support alive is a substantial burden for the
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
index d7c2113fc3e..19147487902 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1125,6 +1125,20 @@ reason the maintainers strongly suspected no one actually used it.
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


