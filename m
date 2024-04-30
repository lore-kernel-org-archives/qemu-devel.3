Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90801C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfJ-0002XY-Vj; Tue, 30 Apr 2024 12:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf2-0002N0-4m
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005c2-Iw
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ffso25559925e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495726; x=1715100526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GnJgeVKHvPlaeZft/qWQKP+8OV+SlqGxnSR+/DTTccU=;
 b=OUmHPBF4HjyTz9A+uTcUlYHCO/zcNVV9w9t7PeWwMLHA6+eNgwKEktLdOSEj7ocO8c
 iinUjjyG5qAMWF2jVXrU8DeQZvJzkGALaiV4DB4FhzWSKQlZzojHps7yzSGHg5DTRxqP
 Tj4F2aBQX9j5tmzioaTYklr9P3RbjY34sx5jgkWqN+VrJLuwVQ/9+aKiykqlm6a78vZ5
 cKOQNv2rQHJMBRGNy5ikKTBv1382HJjv99blK6KbisbJA79Cp3wWq+RWyGW1tJz1g0K/
 ZHvFU7fi5cPAx6LE9feZImEUbvI1lLYW/wtoPaiFvIKu8wYGh8iKEIgYoYsO56UzZ9FP
 pjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495726; x=1715100526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnJgeVKHvPlaeZft/qWQKP+8OV+SlqGxnSR+/DTTccU=;
 b=Y5yqgdXUU+Ky++ow/doR60+bYR4Chy7tD4HLO81c5DMf9aYIZ/H/hBSZSSH0WmM3/Z
 iS1d76B2jxn7a97XfBzjyRpFm16Asdwk88TESw3GkJvAAxSrZqYgH/vErZzvRXY3/6m1
 FjjbEfmpBq9HjtIXcYUgiasWXclSKoQpEe6zFengbZ5dwwFq8/dy63v3nRB8KmwoT3y3
 AAFy3DO4uZ4AY5bnF4sILFWJPTUybdFyR+xnAao9EV0U/WRyoRjY2p6qGIRKa74qLQzn
 VVDfm4Nig5yk2z+9HyHMh3fp7KPXjqgs4qbMpkFy496pzVOmWGsg1IHe/PE+a0kjakPa
 TmYQ==
X-Gm-Message-State: AOJu0Yyz6GcbuW5hlgpH+kqa2zGeuHohUUX2nsVoUQPME4KhSA8Y3mb2
 4DEpMomh+vkJZddSxyuwiAX/otyeAka7C+8PWYf5rmx6rNDl7nWVS7a+UEPEMnxKy2GN8jdepkp
 v
X-Google-Smtp-Source: AGHT+IGGgD7ud7QOgTSfz9l9o/wNDQHKBO184fJwJo1EASTlrYUbU5I6KGwbIKTrOqQ0OYXL3IGuPQ==
X-Received: by 2002:a05:600c:19c8:b0:41b:4caa:554c with SMTP id
 u8-20020a05600c19c800b0041b4caa554cmr405837wmq.2.1714495726225; 
 Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/21] docs/system/arm/emulation.rst: Add missing implemented
 features
Date: Tue, 30 Apr 2024 17:48:25 +0100
Message-Id: <20240430164842.4074734-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

As of version DDI0487K.a of the Arm ARM, some architectural features
which previously didn't have official names have been named.  Add
these to the list of features which QEMU's TCG emulation supports.
Mostly these are features which we thought of as part of baseline 8.0
support.  For SVE and SVE2, the names have been brought into line
with the FEAT_* naming convention of other extensions, and some
sub-components split into separate FEAT_ items.  In a few cases (eg
FEAT_CCIDX, FEAT_DPB2) the omission from our list was just an oversight.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240418152004.2106516-2-peter.maydell@linaro.org
---
 docs/system/arm/emulation.rst | 38 +++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a9ae7ede9fc..5fdc64a944f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -8,13 +8,26 @@ Armv8 versions of the A-profile architecture. It also has support for
 the following architecture extensions:
 
 - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
+- FEAT_AA32EL0 (Support for AArch32 at EL0)
+- FEAT_AA32EL1 (Support for AArch32 at EL1)
+- FEAT_AA32EL2 (Support for AArch32 at EL2)
+- FEAT_AA32EL3 (Support for AArch32 at EL3)
 - FEAT_AA32HPD (AArch32 hierarchical permission disables)
 - FEAT_AA32I8MM (AArch32 Int8 matrix multiplication instructions)
+- FEAT_AA64EL0 (Support for AArch64 at EL0)
+- FEAT_AA64EL1 (Support for AArch64 at EL1)
+- FEAT_AA64EL2 (Support for AArch64 at EL2)
+- FEAT_AA64EL3 (Support for AArch64 at EL3)
+- FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
+- FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
+- FEAT_ASID16 (16 bit ASID)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
+- FEAT_CCIDX (Extended cache index)
 - FEAT_CRC32 (CRC32 instructions)
+- FEAT_Crypto (Cryptographic Extension)
 - FEAT_CSV2 (Cache speculation variant 2)
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
@@ -23,18 +36,27 @@ the following architecture extensions:
 - FEAT_DGH (Data gathering hint)
 - FEAT_DIT (Data Independent Timing instructions)
 - FEAT_DPB (DC CVAP instruction)
+- FEAT_DPB2 (DC CVADP instruction)
+- FEAT_Debugv8p1 (Debug with VHE)
 - FEAT_Debugv8p2 (Debug changes for v8.2)
 - FEAT_Debugv8p4 (Debug changes for v8.4)
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
 - FEAT_ECV (Enhanced Counter Virtualization)
+- FEAT_EL0 (Support for execution at EL0)
+- FEAT_EL1 (Support for execution at EL1)
+- FEAT_EL2 (Support for execution at EL2)
+- FEAT_EL3 (Support for execution at EL3)
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F32MM (Single-precision Matrix Multiplication)
+- FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
+- FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
@@ -60,10 +82,13 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MixedEnd (Mixed-endian support)
+- FEAT_MixdEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
@@ -76,6 +101,7 @@ the following architecture extensions:
 - FEAT_PAuth (Pointer authentication)
 - FEAT_PAuth2 (Enhancements to pointer authentication)
 - FEAT_PMULL (PMULL, PMULL2 instructions)
+- FEAT_PMUv3 (PMU extension version 3)
 - FEAT_PMUv3p1 (PMU Extensions v3.1)
 - FEAT_PMUv3p4 (PMU Extensions v3.4)
 - FEAT_PMUv3p5 (PMU Extensions v3.5)
@@ -97,8 +123,18 @@ the following architecture extensions:
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SVE (Scalable Vector Extension)
+- FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
+- FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
+- FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
+- FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
+- FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
+- FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
+- FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
+- FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)
 - FEAT_TIDCP1 (EL0 use of IMPLEMENTATION DEFINED functionality)
 - FEAT_TLBIOS (TLB invalidate instructions in Outer Shareable domain)
 - FEAT_TLBIRANGE (TLB invalidate range instructions)
@@ -109,8 +145,6 @@ the following architecture extensions:
 - FEAT_VHE (Virtualization Host Extensions)
 - FEAT_VMID16 (16-bit VMID)
 - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
-- SVE (The Scalable Vector Extension)
-- SVE2 (The Scalable Vector Extension v2)
 
 For information on the specifics of these extensions, please refer
 to the `Armv8-A Arm Architecture Reference Manual
-- 
2.34.1


