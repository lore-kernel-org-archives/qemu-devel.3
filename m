Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A695C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Iz-0006kG-4A; Thu, 20 Feb 2025 11:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iw-0006jD-SO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iv-0008BC-0C
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:38 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso7455635e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068495; x=1740673295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nK160VxNKO+hZXvX3m+rBefBJKypuk+nREPBBQoUO4c=;
 b=DsYqBED1qTcj13rw1GmXU5GchaaQ8DXmJbWsjK34GW+5ApBiRpLNVNMwxrzWMjFmLq
 XMduJDdYz3BLYpCvRPK1+Vnv94tarqXM531Wa5PMimQMDvys/Yju+0MbC567mEw41AVw
 u8zDD4v8qUfsFKk7RQ33vi1oxZLVD98VUd5iK8kK5MM6Bbz1SAvhY13fH43is9RQ5M4w
 /Ae1MmnFejPZS2J20Mfoj3ZsFdc3RNOvBbnpigkwzPX3VtsXsHJPhGI2PYwShr0x2O0x
 dU4B1Wgnghxs6/v/zqE5ou44sf0qw+AyuFhR3JHH5qXsMthLYMORKqHGHRBJ+6V6J6QB
 +IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068495; x=1740673295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nK160VxNKO+hZXvX3m+rBefBJKypuk+nREPBBQoUO4c=;
 b=wynQe2ShyFTyeHXcCg0S6rR49MTQsWToVfaw8QUY/9u1tgwkFpDB/eoarwUK6q6e1K
 QkxjnzmOup621JRCwC6RgnVgqmQzqfTWfwiZfS4wesad5uL9KQQHKLZRmmph+XaehX5w
 Z4Fz+z13Opxk0MXBHjtL6TmuGP5VlLGBPvCOa4gbnyVD4SG23iZfUNWCqrr8M3UeVWvn
 pHR+s8n03LKS7avLwnuv9tLRDy/lnUZ/xMabKhxGGPTFUBw5PYYWgqI+kr9EVwImE+Sd
 /xZyh78TfO4fKniuZtpwmT95NVaCWZiUPief9V2Q78MfhT6wD1Rtqn1fyOc7r4aKYoM6
 rJnA==
X-Gm-Message-State: AOJu0YyGaf1VXZNtei0293csiHH/UpJKZZvb1d5IF8PAGvWsOcBGMr16
 iqKeCRyS+uYXnKVCVpPOV9XLGUL1cGZwihpRidgJiFovfzdLtkrVMYJiXNl+CDk/ciUBvr+85BG
 C
X-Gm-Gg: ASbGnctrzrnajGlvhjWv7Ekb75hvdHFddxdm+sbhiNBs6kRL73s1uq/G+QfS9s57oAX
 HXpzBSmwYWvzuto6OZ7SiY1DtMeCZe2l+JeV/NvQxMZyQ+ZiEOTN4piHHehqaVz/4wc/HsY9Guo
 J3z2eXaTZPnlF9uR4fMehwyOYXGD7cnUlvip3xIkkPlvT1qHEUz0zCXooBoRdj0YqHiJj8mmk4r
 dHWCFW3eFkBwrrpC7UUQLAA0hHDtOEcYdRR/lwCKYk0Ub97SOwUMN0Q7+3/9vSGSEW1ma4V/D6M
 YMk5litRwJ49wk7Lu1jRwA==
X-Google-Smtp-Source: AGHT+IEMv4BgtFLQ/vlT6zjNKO9RxUXfXUkHk7lvVNUesh83tpkoBUGzyg4pI2v8SJNn8P2kr5I2EQ==
X-Received: by 2002:a05:600c:58d4:b0:439:9536:fa6b with SMTP id
 5b1f17b1804b1-439a30e65c0mr36147735e9.13.1740068495162; 
 Thu, 20 Feb 2025 08:21:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] target/arm: Honour SDCR.TDCC and SCR.TERR in AArch32 EL3
 non-Monitor modes
Date: Thu, 20 Feb 2025 16:20:48 +0000
Message-ID: <20250220162123.626941-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

There are not many traps in AArch32 which should trap to Monitor
mode, but these trap bits should trap not just lower ELs to Monitor
mode but also the non-Monitor modes running at EL3 (i.e.  Secure
System, Secure Undef, etc).

We get this wrong because the relevant access functions implement the
AArch64-style logic of
   if (el < 3 && trap_bit_set) {
       return CP_ACCESS_TRAP_EL3;
   }
which won't trap the non-Monitor modes at EL3.

Correct this error by using arm_is_el3_or_mon() instead, which
returns true when the CPU is at AArch64 EL3 or AArch32 Monitor mode.
(Since the new callsites are compiled also for the linux-user mode,
we need to provide a dummy implementation for CONFIG_USER_ONLY.)

This affects only:
 * trapping of ERRIDR via SCR.TERR
 * trapping of the debug channel registers via SDCR.TDCC
 * trapping of GICv3 registers via SCR.IRQ and SCR.FIQ
   (which we already used arm_is_el3_or_mon() for)

This patch changes the handling of SCR.TERR and SDCR.TDCC. This
patch only changes guest-visible behaviour for "-cpu max" on
the qemu-system-arm binary, because SCR.TERR
and SDCR.TDCC (and indeed the entire SDCR register) only arrived
in Armv8, and the only guest CPU we support which has any v8
features and also starts in AArch32 EL3 is the 32-bit 'max'.

Other uses of CP_ACCESS_TRAP_EL3 don't need changing:

 * uses in code paths that can't happen when EL3 is AArch32:
   access_trap_aa32s_el1, cpacr_access, cptr_access, nsacr_access
 * uses which are in accessfns for AArch64-only registers:
   gt_stimer_access, gt_cntpoff_access, access_hxen, access_tpidr2,
   access_smpri, access_smprimap, access_lor_ns, access_pauth,
   access_mte, access_tfsr_el2, access_scxtnum, access_fgt
 * trap bits which exist only in the AArch64 version of the
   trap register, not the AArch32 one:
   access_tpm, pmreg_access, access_dbgvcr32, access_tdra,
   access_tda, access_tdosa (TPM, TDA and TDOSA exist only in
   MDCR_EL3, not in SDCR, and we enforce this in sdcr_write())

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-8-peter.maydell@linaro.org
---
 target/arm/cpu.h          | 5 +++++
 target/arm/debug_helper.c | 3 ++-
 target/arm/helper.c       | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83ceaa58c2c..215845c7e25 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2596,6 +2596,11 @@ static inline bool arm_is_secure_below_el3(CPUARMState *env)
     return false;
 }
 
+static inline bool arm_is_el3_or_mon(CPUARMState *env)
+{
+    return false;
+}
+
 static inline ARMSecuritySpace arm_security_space(CPUARMState *env)
 {
     return ARMSS_NonSecure;
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 2212ef4a3b9..c3c1eb5f628 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -880,7 +880,8 @@ static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el < 2 && (mdcr_el2_tda || mdcr_el2_tdcc)) {
         return CP_ACCESS_TRAP_EL2;
     }
-    if (el < 3 && ((env->cp15.mdcr_el3 & MDCR_TDA) || mdcr_el3_tdcc)) {
+    if (!arm_is_el3_or_mon(env) &&
+        ((env->cp15.mdcr_el3 & MDCR_TDA) || mdcr_el3_tdcc)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2bf39a2051d..535870f69a6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6103,7 +6103,7 @@ static CPAccessResult access_terr(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el < 2 && (arm_hcr_el2_eff(env) & HCR_TERR)) {
         return CP_ACCESS_TRAP_EL2;
     }
-    if (el < 3 && (env->cp15.scr_el3 & SCR_TERR)) {
+    if (!arm_is_el3_or_mon(env) && (env->cp15.scr_el3 & SCR_TERR)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
-- 
2.43.0


