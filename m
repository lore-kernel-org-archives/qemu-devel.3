Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD2FC83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDui-0005jY-KY; Fri, 11 Jul 2025 09:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu2-0004Wn-3Z
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtx-00038P-L1
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so1375057f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240896; x=1752845696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dygIx0j1OHWFx1U7iSU+E/yVGwrrZIOhF+fnTVlAKlc=;
 b=uc/SzQsIFDwgEaC1T9p47qPTH+si8US6xbwPqB4vpuIADD5B4Hw2cMuGBunjW3rUyz
 fa5zzzYFCTfgLmfd/IXWicFEjY6X/yypPVPrOQVjWFZRCtYKogAcZz3aBVIzhFQbJZnx
 ECjPj0qCzq2K9ARTjSveBylMWtm6w9cEbhzzzIzPu92WRZeoq7Vggz5PjqTI1RIWY0O2
 JcuGfLv5jxdND8xnJOeAJWib6U3wlYx/JRWL022G0Z9mzRSJmkMg7adDvWFbFAYF+jj1
 LBePJaABnJdKv76uirjJHTKnASsz6YDmrw+wavXYZpo3RMgOVAuFEVDBM6utiWhBf9Pb
 6Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240896; x=1752845696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dygIx0j1OHWFx1U7iSU+E/yVGwrrZIOhF+fnTVlAKlc=;
 b=kBBG5Sx0d2xIeCib5g3BMUgqZ9VRdRmgB27VqXGWo7sl7P0o7OVqiFbBpyEUt7ZDWl
 Nx5Cwlsa8bq2ZR6ift3Dlc1fFjjTrVpPi4cb8X5P8NoJ/V6GQpPiy7jltFA3HZsDgj+L
 4KTU1zswRCcOmhNOgXot4vzDegUem09SeEtjaYQKO7GwOwI3DmqwLPP+lNv5Xk0qD9iU
 ICQlWZmx4Yq+rRdzjHNci00oF3PDWKhBPUyTAGQA8J6y+73AY1+F6v8EqBob4sRvdJHU
 hqkDZ1OXpAqgqRxrKwJ1EwknuHsZ2qTorhRTvfWyq7MGhyXLToF/1XVY+mO+TaaWrUTK
 cQmQ==
X-Gm-Message-State: AOJu0YyPQQwmy/kImwj2sWkrA7oDmCZdSd9lgy4t4rOvWcozj3nSS9IL
 626ijKWPYGHYT51Woih/r30B/XRcvzvQY9zc3M+fmsoyKaM8Gmv9NukiFQNs6MLPm81h5F9glAz
 8c8Po
X-Gm-Gg: ASbGncsNgVlMWAOxgP2bTLaUwEcgV/v/HDJz3neWBWnxPMQXhhuYR6VPGU38iYjFvs3
 I2shewcfyrg0Nx9DqaNIlMnNb5jRquTzaavOaCe+U9qzSvO17PorPhkznwiUwxwQosfkJ6nFQie
 jDBv6znHUXnecJLn80zj+BA0ZmbXCbMfQBL9UwP97y3F+CM2Mstdc0SmnV6tD73KNnwnWI5bdqh
 a45lo5TVNh7G+FqFcERW4P6PJGdoOvwQbJyra6WCWaLO6a8c7azFOdRAOqIujBG9w+LwCDmT8vm
 USnQJS8fSFwOdxgOeKjZLtaQW8KsE+OG1lEHWMG0XytTMGpG41v+JQQAXtixy1KwAYHg2oigSUh
 VJgFQcxkOoh38oEDHdAiv/1b3goRy
X-Google-Smtp-Source: AGHT+IFiTlWl02aqHeSU26/oyyIJEqjLfbs5A8MaQWEJJH6sKyZNpQFyWMZHL/GXSE4DqfK75RQh/g==
X-Received: by 2002:a05:6000:4a11:b0:3a4:e6d7:6160 with SMTP id
 ffacd0b85a97d-3b5f2db1496mr2000194f8f.6.1752240895561; 
 Fri, 11 Jul 2025 06:34:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/36] target/arm: Split out AT insns to tcg/cpregs-at.c
Date: Fri, 11 Jul 2025 14:34:16 +0100
Message-ID: <20250711133429.1423030-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Split out all "system instructions for address translation".
While mapped into "cpregs", these are instructions, and thus
are handled in hardware by virtualization.  They are all
priviledged, and thus not reachable for user-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250707151547.196393-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h     |   3 +
 target/arm/helper.c        | 514 +-----------------------------------
 target/arm/tcg/cpregs-at.c | 519 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/meson.build |   1 +
 4 files changed, 525 insertions(+), 512 deletions(-)
 create mode 100644 target/arm/tcg/cpregs-at.c

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 21a8d67eddf..bcaf8965fc6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1871,6 +1871,8 @@ void define_debug_regs(ARMCPU *cpu);
 
 /* Add the cpreg definitions for TLBI instructions */
 void define_tlb_insn_regs(ARMCPU *cpu);
+/* Add the cpreg definitions for AT instructions */
+void define_at_insn_regs(ARMCPU *cpu);
 
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
@@ -1981,5 +1983,6 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  * specified by mask changing to the values in val.
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
+bool arm_pan_enabled(CPUARMState *env);
 
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c1b684e3d1c..0883246905f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -270,7 +270,7 @@ void init_cpreg_list(ARMCPU *cpu)
     g_list_free(keys);
 }
 
-static bool arm_pan_enabled(CPUARMState *env)
+bool arm_pan_enabled(CPUARMState *env)
 {
     if (is_a64(env)) {
         if ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1)) {
@@ -3448,402 +3448,6 @@ static void par_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
-/* get_phys_addr() isn't present for user-mode-only targets */
-
-static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 bool isread)
-{
-    if (ri->opc2 & 4) {
-        /*
-         * The ATS12NSO* operations must trap to EL3 or EL2 if executed in
-         * Secure EL1 (which can only happen if EL3 is AArch64).
-         * They are simply UNDEF if executed from NS EL1.
-         * They function normally from EL2 or EL3.
-         */
-        if (arm_current_el(env) == 1) {
-            if (arm_is_secure_below_el3(env)) {
-                if (env->cp15.scr_el3 & SCR_EEL2) {
-                    return CP_ACCESS_TRAP_EL2;
-                }
-                return CP_ACCESS_TRAP_EL3;
-            }
-            return CP_ACCESS_UNDEFINED;
-        }
-    }
-    return CP_ACCESS_OK;
-}
-
-#ifdef CONFIG_TCG
-static int par_el1_shareability(GetPhysAddrResult *res)
-{
-    /*
-     * The PAR_EL1.SH field must be 0b10 for Device or Normal-NC
-     * memory -- see pseudocode PAREncodeShareability().
-     */
-    if (((res->cacheattrs.attrs & 0xf0) == 0) ||
-        res->cacheattrs.attrs == 0x44 || res->cacheattrs.attrs == 0x40) {
-        return 2;
-    }
-    return res->cacheattrs.shareability;
-}
-
-static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
-                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                             ARMSecuritySpace ss)
-{
-    bool ret;
-    uint64_t par64;
-    bool format64 = false;
-    ARMMMUFaultInfo fi = {};
-    GetPhysAddrResult res = {};
-
-    /*
-     * I_MXTJT: Granule protection checks are not performed on the final
-     * address of a successful translation.  This is a translation not a
-     * memory reference, so "memop = none = 0".
-     */
-    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
-                                         mmu_idx, ss, &res, &fi);
-
-    /*
-     * ATS operations only do S1 or S1+S2 translations, so we never
-     * have to deal with the ARMCacheAttrs format for S2 only.
-     */
-    assert(!res.cacheattrs.is_s2_format);
-
-    if (ret) {
-        /*
-         * Some kinds of translation fault must cause exceptions rather
-         * than being reported in the PAR.
-         */
-        int current_el = arm_current_el(env);
-        int target_el;
-        uint32_t syn, fsr, fsc;
-        bool take_exc = false;
-
-        if (fi.s1ptw && current_el == 1
-            && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
-            /*
-             * Synchronous stage 2 fault on an access made as part of the
-             * translation table walk for AT S1E0* or AT S1E1* insn
-             * executed from NS EL1. If this is a synchronous external abort
-             * and SCR_EL3.EA == 1, then we take a synchronous external abort
-             * to EL3. Otherwise the fault is taken as an exception to EL2,
-             * and HPFAR_EL2 holds the faulting IPA.
-             */
-            if (fi.type == ARMFault_SyncExternalOnWalk &&
-                (env->cp15.scr_el3 & SCR_EA)) {
-                target_el = 3;
-            } else {
-                env->cp15.hpfar_el2 = extract64(fi.s2addr, 12, 47) << 4;
-                if (arm_is_secure_below_el3(env) && fi.s1ns) {
-                    env->cp15.hpfar_el2 |= HPFAR_NS;
-                }
-                target_el = 2;
-            }
-            take_exc = true;
-        } else if (fi.type == ARMFault_SyncExternalOnWalk) {
-            /*
-             * Synchronous external aborts during a translation table walk
-             * are taken as Data Abort exceptions.
-             */
-            if (fi.stage2) {
-                if (current_el == 3) {
-                    target_el = 3;
-                } else {
-                    target_el = 2;
-                }
-            } else {
-                target_el = exception_target_el(env);
-            }
-            take_exc = true;
-        }
-
-        if (take_exc) {
-            /* Construct FSR and FSC using same logic as arm_deliver_fault() */
-            if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
-                arm_s1_regime_using_lpae_format(env, mmu_idx)) {
-                fsr = arm_fi_to_lfsc(&fi);
-                fsc = extract32(fsr, 0, 6);
-            } else {
-                fsr = arm_fi_to_sfsc(&fi);
-                fsc = 0x3f;
-            }
-            /*
-             * Report exception with ESR indicating a fault due to a
-             * translation table walk for a cache maintenance instruction.
-             */
-            syn = syn_data_abort_no_iss(current_el == target_el, 0,
-                                        fi.ea, 1, fi.s1ptw, 1, fsc);
-            env->exception.vaddress = value;
-            env->exception.fsr = fsr;
-            raise_exception(env, EXCP_DATA_ABORT, syn, target_el);
-        }
-    }
-
-    if (is_a64(env)) {
-        format64 = true;
-    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
-        /*
-         * ATS1Cxx:
-         * * TTBCR.EAE determines whether the result is returned using the
-         *   32-bit or the 64-bit PAR format
-         * * Instructions executed in Hyp mode always use the 64bit format
-         *
-         * ATS1S2NSOxx uses the 64bit format if any of the following is true:
-         * * The Non-secure TTBCR.EAE bit is set to 1
-         * * The implementation includes EL2, and the value of HCR.VM is 1
-         *
-         * (Note that HCR.DC makes HCR.VM behave as if it is 1.)
-         *
-         * ATS1Hx always uses the 64bit format.
-         */
-        format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
-
-        if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_E10_0 ||
-                mmu_idx == ARMMMUIdx_E10_1 ||
-                mmu_idx == ARMMMUIdx_E10_1_PAN) {
-                format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
-            } else {
-                format64 |= arm_current_el(env) == 2;
-            }
-        }
-    }
-
-    if (format64) {
-        /* Create a 64-bit PAR */
-        par64 = (1 << 11); /* LPAE bit always set */
-        if (!ret) {
-            par64 |= res.f.phys_addr & ~0xfffULL;
-            if (!res.f.attrs.secure) {
-                par64 |= (1 << 9); /* NS */
-            }
-            par64 |= (uint64_t)res.cacheattrs.attrs << 56; /* ATTR */
-            par64 |= par_el1_shareability(&res) << 7; /* SH */
-        } else {
-            uint32_t fsr = arm_fi_to_lfsc(&fi);
-
-            par64 |= 1; /* F */
-            par64 |= (fsr & 0x3f) << 1; /* FS */
-            if (fi.stage2) {
-                par64 |= (1 << 9); /* S */
-            }
-            if (fi.s1ptw) {
-                par64 |= (1 << 8); /* PTW */
-            }
-        }
-    } else {
-        /*
-         * fsr is a DFSR/IFSR value for the short descriptor
-         * translation table format (with WnR always clear).
-         * Convert it to a 32-bit PAR.
-         */
-        if (!ret) {
-            /* We do not set any attribute bits in the PAR */
-            if (res.f.lg_page_size == 24
-                && arm_feature(env, ARM_FEATURE_V7)) {
-                par64 = (res.f.phys_addr & 0xff000000) | (1 << 1);
-            } else {
-                par64 = res.f.phys_addr & 0xfffff000;
-            }
-            if (!res.f.attrs.secure) {
-                par64 |= (1 << 9); /* NS */
-            }
-        } else {
-            uint32_t fsr = arm_fi_to_sfsc(&fi);
-
-            par64 = ((fsr & (1 << 10)) >> 5) | ((fsr & (1 << 12)) >> 6) |
-                    ((fsr & 0xf) << 1) | 1;
-        }
-    }
-    return par64;
-}
-#endif /* CONFIG_TCG */
-
-static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
-{
-#ifdef CONFIG_TCG
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
-    uint64_t par64;
-    ARMMMUIdx mmu_idx;
-    int el = arm_current_el(env);
-    ARMSecuritySpace ss = arm_security_space(env);
-
-    switch (ri->opc2 & 6) {
-    case 0:
-        /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
-        switch (el) {
-        case 3:
-            if (ri->crm == 9 && arm_pan_enabled(env)) {
-                mmu_idx = ARMMMUIdx_E30_3_PAN;
-            } else {
-                mmu_idx = ARMMMUIdx_E3;
-            }
-            break;
-        case 2:
-            g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
-            /* fall through */
-        case 1:
-            if (ri->crm == 9 && arm_pan_enabled(env)) {
-                mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
-            } else {
-                mmu_idx = ARMMMUIdx_Stage1_E1;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
-    case 2:
-        /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
-        switch (el) {
-        case 3:
-            mmu_idx = ARMMMUIdx_E30_0;
-            break;
-        case 2:
-            g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
-            mmu_idx = ARMMMUIdx_Stage1_E0;
-            break;
-        case 1:
-            mmu_idx = ARMMMUIdx_Stage1_E0;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
-    case 4:
-        /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
-        mmu_idx = ARMMMUIdx_E10_1;
-        ss = ARMSS_NonSecure;
-        break;
-    case 6:
-        /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
-        mmu_idx = ARMMMUIdx_E10_0;
-        ss = ARMSS_NonSecure;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
-
-    A32_BANKED_CURRENT_REG_SET(env, par, par64);
-#else
-    /* Handled by hardware accelerator. */
-    g_assert_not_reached();
-#endif /* CONFIG_TCG */
-}
-
-static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                        uint64_t value)
-{
-#ifdef CONFIG_TCG
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
-    uint64_t par64;
-
-    /* There is no SecureEL2 for AArch32. */
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2,
-                         ARMSS_NonSecure);
-
-    A32_BANKED_CURRENT_REG_SET(env, par, par64);
-#else
-    /* Handled by hardware accelerator. */
-    g_assert_not_reached();
-#endif /* CONFIG_TCG */
-}
-
-static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                     bool isread)
-{
-    /*
-     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
-     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved. This can
-     * only happen when executing at EL3 because that combination also causes an
-     * illegal exception return. We don't need to check FEAT_RME either, because
-     * scr_write() ensures that the NSE bit is not set otherwise.
-     */
-    if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
-        return CP_ACCESS_UNDEFINED;
-    }
-    return CP_ACCESS_OK;
-}
-
-static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                     bool isread)
-{
-    if (arm_current_el(env) == 3 &&
-        !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
-        return CP_ACCESS_UNDEFINED;
-    }
-    return at_e012_access(env, ri, isread);
-}
-
-static CPAccessResult at_s1e01_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                      bool isread)
-{
-    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_AT)) {
-        return CP_ACCESS_TRAP_EL2;
-    }
-    return at_e012_access(env, ri, isread);
-}
-
-static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
-                        uint64_t value)
-{
-#ifdef CONFIG_TCG
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
-    ARMMMUIdx mmu_idx;
-    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
-    bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
-    bool for_el3 = false;
-    ARMSecuritySpace ss;
-
-    switch (ri->opc2 & 6) {
-    case 0:
-        switch (ri->opc1) {
-        case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
-            if (ri->crm == 9 && arm_pan_enabled(env)) {
-                mmu_idx = regime_e20 ?
-                          ARMMMUIdx_E20_2_PAN : ARMMMUIdx_Stage1_E1_PAN;
-            } else {
-                mmu_idx = regime_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_Stage1_E1;
-            }
-            break;
-        case 4: /* AT S1E2R, AT S1E2W */
-            mmu_idx = hcr_el2 & HCR_E2H ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
-            break;
-        case 6: /* AT S1E3R, AT S1E3W */
-            mmu_idx = ARMMMUIdx_E3;
-            for_el3 = true;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
-    case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = regime_e20 ? ARMMMUIdx_E20_0 : ARMMMUIdx_Stage1_E0;
-        break;
-    case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = regime_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_E10_1;
-        break;
-    case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = regime_e20 ? ARMMMUIdx_E20_0 : ARMMMUIdx_E10_0;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
-#else
-    /* Handled by hardware accelerator. */
-    g_assert_not_reached();
-#endif /* CONFIG_TCG */
-}
-#endif
-
 /* Return basic MPU access permission bits.  */
 static uint32_t simple_mpu_ap_bits(uint32_t val)
 {
@@ -5094,53 +4698,6 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
       .fgt = FGT_DCCISW,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
-#ifndef CONFIG_USER_ONLY
-    /* 64 bit address translation operations */
-    { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .fgt = FGT_ATS1E1R,
-      .accessfn = at_s1e01_access, .writefn = ats_write64 },
-    { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .fgt = FGT_ATS1E1W,
-      .accessfn = at_s1e01_access, .writefn = ats_write64 },
-    { .name = "AT_S1E0R", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .fgt = FGT_ATS1E0R,
-      .accessfn = at_s1e01_access, .writefn = ats_write64 },
-    { .name = "AT_S1E0W", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 3,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .fgt = FGT_ATS1E0W,
-      .accessfn = at_s1e01_access, .writefn = ats_write64 },
-    { .name = "AT_S12E1R", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
-    { .name = "AT_S12E1W", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
-    { .name = "AT_S12E0R", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
-    { .name = "AT_S12E0W", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 7,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
-    /* AT S1E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
-    { .name = "AT_S1E3R", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
-    { .name = "AT_S1E3W", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
     { .name = "PAR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 7, .crm = 4, .opc2 = 0,
@@ -5148,7 +4705,6 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .fgt = FGT_PAR_EL1,
       .fieldoffset = offsetof(CPUARMState, cp15.par_el[1]),
       .writefn = par_write },
-#endif
     /* 32 bit cache operations */
     { .name = "ICIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_ticab },
@@ -5751,33 +5307,6 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
 #ifndef CONFIG_USER_ONLY
-    /*
-     * Unlike the other EL2-related AT operations, these must
-     * UNDEF from EL3 if EL2 is not implemented, which is why we
-     * define them here rather than with the rest of the AT ops.
-     */
-    { .name = "AT_S1E2R", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 0,
-      .access = PL2_W, .accessfn = at_s1e2_access,
-      .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = ats_write64 },
-    { .name = "AT_S1E2W", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 1,
-      .access = PL2_W, .accessfn = at_s1e2_access,
-      .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = ats_write64 },
-    /*
-     * The AArch32 ATS1H* operations are CONSTRAINED UNPREDICTABLE
-     * if EL2 is not implemented; we choose to UNDEF. Behaviour at EL3
-     * with SCR.NS == 0 outside Monitor mode is UNPREDICTABLE; we choose
-     * to behave as if SCR.NS was 1.
-     */
-    { .name = "ATS1HR", .cp = 15, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 0,
-      .access = PL2_W,
-      .writefn = ats1h_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
-    { .name = "ATS1HW", .cp = 15, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 1,
-      .access = PL2_W,
-      .writefn = ats1h_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
     { .name = "CNTHCTL_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 1, .opc2 = 0,
       /*
@@ -7704,32 +7233,6 @@ static const ARMCPRegInfo vhe_reginfo[] = {
 #endif
 };
 
-#ifndef CONFIG_USER_ONLY
-static const ARMCPRegInfo ats1e1_reginfo[] = {
-    { .name = "AT_S1E1RP", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .fgt = FGT_ATS1E1RP,
-      .accessfn = at_s1e01_access, .writefn = ats_write64 },
-    { .name = "AT_S1E1WP", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .fgt = FGT_ATS1E1WP,
-      .accessfn = at_s1e01_access, .writefn = ats_write64 },
-};
-
-static const ARMCPRegInfo ats1cp_reginfo[] = {
-    { .name = "ATS1CPRP",
-      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write },
-    { .name = "ATS1CPWP",
-      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write },
-};
-#endif
-
 /*
  * ACTLR2 and HACTLR2 map to ACTLR_EL1[63:32] and
  * ACTLR_EL2[63:32]. They exist only if the ID_MMFR4.AC2 field
@@ -7773,6 +7276,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #ifndef CONFIG_USER_ONLY
     if (tcg_enabled()) {
         define_tlb_insn_regs(cpu);
+        define_at_insn_regs(cpu);
     }
 #endif
 
@@ -8506,12 +8010,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
                                      offsetoflow32(CPUARMState, cp15.par_ns) },
               .writefn = par_write},
-#ifndef CONFIG_USER_ONLY
-            /* This underdecoding is safe because the reginfo is NO_RAW. */
-            { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
-              .access = PL1_W, .accessfn = ats_access,
-              .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
-#endif
         };
 
         /*
@@ -8917,14 +8415,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pan, cpu)) {
         define_one_arm_cp_reg(cpu, &pan_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
-    if (cpu_isar_feature(aa64_ats1e1, cpu)) {
-        define_arm_cp_regs(cpu, ats1e1_reginfo);
-    }
-    if (cpu_isar_feature(aa32_ats1e1, cpu)) {
-        define_arm_cp_regs(cpu, ats1cp_reginfo);
-    }
-#endif
     if (cpu_isar_feature(aa64_uao, cpu)) {
         define_one_arm_cp_reg(cpu, &uao_reginfo);
     }
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
new file mode 100644
index 00000000000..398a61d3989
--- /dev/null
+++ b/target/arm/tcg/cpregs-at.c
@@ -0,0 +1,519 @@
+/*
+ * System instructions for address translation
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu-features.h"
+#include "internals.h"
+#include "cpregs.h"
+
+
+static int par_el1_shareability(GetPhysAddrResult *res)
+{
+    /*
+     * The PAR_EL1.SH field must be 0b10 for Device or Normal-NC
+     * memory -- see pseudocode PAREncodeShareability().
+     */
+    if (((res->cacheattrs.attrs & 0xf0) == 0) ||
+        res->cacheattrs.attrs == 0x44 || res->cacheattrs.attrs == 0x40) {
+        return 2;
+    }
+    return res->cacheattrs.shareability;
+}
+
+static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
+                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                             ARMSecuritySpace ss)
+{
+    bool ret;
+    uint64_t par64;
+    bool format64 = false;
+    ARMMMUFaultInfo fi = {};
+    GetPhysAddrResult res = {};
+
+    /*
+     * I_MXTJT: Granule protection checks are not performed on the final
+     * address of a successful translation.  This is a translation not a
+     * memory reference, so "memop = none = 0".
+     */
+    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
+                                         mmu_idx, ss, &res, &fi);
+
+    /*
+     * ATS operations only do S1 or S1+S2 translations, so we never
+     * have to deal with the ARMCacheAttrs format for S2 only.
+     */
+    assert(!res.cacheattrs.is_s2_format);
+
+    if (ret) {
+        /*
+         * Some kinds of translation fault must cause exceptions rather
+         * than being reported in the PAR.
+         */
+        int current_el = arm_current_el(env);
+        int target_el;
+        uint32_t syn, fsr, fsc;
+        bool take_exc = false;
+
+        if (fi.s1ptw && current_el == 1
+            && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
+            /*
+             * Synchronous stage 2 fault on an access made as part of the
+             * translation table walk for AT S1E0* or AT S1E1* insn
+             * executed from NS EL1. If this is a synchronous external abort
+             * and SCR_EL3.EA == 1, then we take a synchronous external abort
+             * to EL3. Otherwise the fault is taken as an exception to EL2,
+             * and HPFAR_EL2 holds the faulting IPA.
+             */
+            if (fi.type == ARMFault_SyncExternalOnWalk &&
+                (env->cp15.scr_el3 & SCR_EA)) {
+                target_el = 3;
+            } else {
+                env->cp15.hpfar_el2 = extract64(fi.s2addr, 12, 47) << 4;
+                if (arm_is_secure_below_el3(env) && fi.s1ns) {
+                    env->cp15.hpfar_el2 |= HPFAR_NS;
+                }
+                target_el = 2;
+            }
+            take_exc = true;
+        } else if (fi.type == ARMFault_SyncExternalOnWalk) {
+            /*
+             * Synchronous external aborts during a translation table walk
+             * are taken as Data Abort exceptions.
+             */
+            if (fi.stage2) {
+                if (current_el == 3) {
+                    target_el = 3;
+                } else {
+                    target_el = 2;
+                }
+            } else {
+                target_el = exception_target_el(env);
+            }
+            take_exc = true;
+        }
+
+        if (take_exc) {
+            /* Construct FSR and FSC using same logic as arm_deliver_fault() */
+            if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
+                arm_s1_regime_using_lpae_format(env, mmu_idx)) {
+                fsr = arm_fi_to_lfsc(&fi);
+                fsc = extract32(fsr, 0, 6);
+            } else {
+                fsr = arm_fi_to_sfsc(&fi);
+                fsc = 0x3f;
+            }
+            /*
+             * Report exception with ESR indicating a fault due to a
+             * translation table walk for a cache maintenance instruction.
+             */
+            syn = syn_data_abort_no_iss(current_el == target_el, 0,
+                                        fi.ea, 1, fi.s1ptw, 1, fsc);
+            env->exception.vaddress = value;
+            env->exception.fsr = fsr;
+            raise_exception(env, EXCP_DATA_ABORT, syn, target_el);
+        }
+    }
+
+    if (is_a64(env)) {
+        format64 = true;
+    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
+        /*
+         * ATS1Cxx:
+         * * TTBCR.EAE determines whether the result is returned using the
+         *   32-bit or the 64-bit PAR format
+         * * Instructions executed in Hyp mode always use the 64bit format
+         *
+         * ATS1S2NSOxx uses the 64bit format if any of the following is true:
+         * * The Non-secure TTBCR.EAE bit is set to 1
+         * * The implementation includes EL2, and the value of HCR.VM is 1
+         *
+         * (Note that HCR.DC makes HCR.VM behave as if it is 1.)
+         *
+         * ATS1Hx always uses the 64bit format.
+         */
+        format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
+
+        if (arm_feature(env, ARM_FEATURE_EL2)) {
+            if (mmu_idx == ARMMMUIdx_E10_0 ||
+                mmu_idx == ARMMMUIdx_E10_1 ||
+                mmu_idx == ARMMMUIdx_E10_1_PAN) {
+                format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
+            } else {
+                format64 |= arm_current_el(env) == 2;
+            }
+        }
+    }
+
+    if (format64) {
+        /* Create a 64-bit PAR */
+        par64 = (1 << 11); /* LPAE bit always set */
+        if (!ret) {
+            par64 |= res.f.phys_addr & ~0xfffULL;
+            if (!res.f.attrs.secure) {
+                par64 |= (1 << 9); /* NS */
+            }
+            par64 |= (uint64_t)res.cacheattrs.attrs << 56; /* ATTR */
+            par64 |= par_el1_shareability(&res) << 7; /* SH */
+        } else {
+            uint32_t fsr = arm_fi_to_lfsc(&fi);
+
+            par64 |= 1; /* F */
+            par64 |= (fsr & 0x3f) << 1; /* FS */
+            if (fi.stage2) {
+                par64 |= (1 << 9); /* S */
+            }
+            if (fi.s1ptw) {
+                par64 |= (1 << 8); /* PTW */
+            }
+        }
+    } else {
+        /*
+         * fsr is a DFSR/IFSR value for the short descriptor
+         * translation table format (with WnR always clear).
+         * Convert it to a 32-bit PAR.
+         */
+        if (!ret) {
+            /* We do not set any attribute bits in the PAR */
+            if (res.f.lg_page_size == 24
+                && arm_feature(env, ARM_FEATURE_V7)) {
+                par64 = (res.f.phys_addr & 0xff000000) | (1 << 1);
+            } else {
+                par64 = res.f.phys_addr & 0xfffff000;
+            }
+            if (!res.f.attrs.secure) {
+                par64 |= (1 << 9); /* NS */
+            }
+        } else {
+            uint32_t fsr = arm_fi_to_sfsc(&fi);
+
+            par64 = ((fsr & (1 << 10)) >> 5) | ((fsr & (1 << 12)) >> 6) |
+                    ((fsr & 0xf) << 1) | 1;
+        }
+    }
+    return par64;
+}
+
+static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    uint64_t par64;
+    ARMMMUIdx mmu_idx;
+    int el = arm_current_el(env);
+    ARMSecuritySpace ss = arm_security_space(env);
+
+    switch (ri->opc2 & 6) {
+    case 0:
+        /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
+        switch (el) {
+        case 3:
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
+                mmu_idx = ARMMMUIdx_E30_3_PAN;
+            } else {
+                mmu_idx = ARMMMUIdx_E3;
+            }
+            break;
+        case 2:
+            g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
+            /* fall through */
+        case 1:
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
+                mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
+            } else {
+                mmu_idx = ARMMMUIdx_Stage1_E1;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+    case 2:
+        /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
+        switch (el) {
+        case 3:
+            mmu_idx = ARMMMUIdx_E30_0;
+            break;
+        case 2:
+            g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
+            mmu_idx = ARMMMUIdx_Stage1_E0;
+            break;
+        case 1:
+            mmu_idx = ARMMMUIdx_Stage1_E0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+    case 4:
+        /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
+        mmu_idx = ARMMMUIdx_E10_1;
+        ss = ARMSS_NonSecure;
+        break;
+    case 6:
+        /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
+        mmu_idx = ARMMMUIdx_E10_0;
+        ss = ARMSS_NonSecure;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
+
+    A32_BANKED_CURRENT_REG_SET(env, par, par64);
+}
+
+static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    uint64_t par64;
+
+    /* There is no SecureEL2 for AArch32. */
+    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2,
+                         ARMSS_NonSecure);
+
+    A32_BANKED_CURRENT_REG_SET(env, par, par64);
+}
+
+static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    /*
+     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
+     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved. This can
+     * only happen when executing at EL3 because that combination also causes an
+     * illegal exception return. We don't need to check FEAT_RME either, because
+     * scr_write() ensures that the NSE bit is not set otherwise.
+     */
+    if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
+        return CP_ACCESS_UNDEFINED;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    if (arm_current_el(env) == 3 &&
+        !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
+        return CP_ACCESS_UNDEFINED;
+    }
+    return at_e012_access(env, ri, isread);
+}
+
+static CPAccessResult at_s1e01_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_AT)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return at_e012_access(env, ri, isread);
+}
+
+static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    ARMMMUIdx mmu_idx;
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
+    bool for_el3 = false;
+    ARMSecuritySpace ss;
+
+    switch (ri->opc2 & 6) {
+    case 0:
+        switch (ri->opc1) {
+        case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
+                mmu_idx = regime_e20 ?
+                          ARMMMUIdx_E20_2_PAN : ARMMMUIdx_Stage1_E1_PAN;
+            } else {
+                mmu_idx = regime_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_Stage1_E1;
+            }
+            break;
+        case 4: /* AT S1E2R, AT S1E2W */
+            mmu_idx = hcr_el2 & HCR_E2H ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
+            break;
+        case 6: /* AT S1E3R, AT S1E3W */
+            mmu_idx = ARMMMUIdx_E3;
+            for_el3 = true;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+    case 2: /* AT S1E0R, AT S1E0W */
+        mmu_idx = regime_e20 ? ARMMMUIdx_E20_0 : ARMMMUIdx_Stage1_E0;
+        break;
+    case 4: /* AT S12E1R, AT S12E1W */
+        mmu_idx = regime_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_E10_1;
+        break;
+    case 6: /* AT S12E0R, AT S12E0W */
+        mmu_idx = regime_e20 ? ARMMMUIdx_E20_0 : ARMMMUIdx_E10_0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
+    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
+}
+
+static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (ri->opc2 & 4) {
+        /*
+         * The ATS12NSO* operations must trap to EL3 or EL2 if executed in
+         * Secure EL1 (which can only happen if EL3 is AArch64).
+         * They are simply UNDEF if executed from NS EL1.
+         * They function normally from EL2 or EL3.
+         */
+        if (arm_current_el(env) == 1) {
+            if (arm_is_secure_below_el3(env)) {
+                if (env->cp15.scr_el3 & SCR_EEL2) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+                return CP_ACCESS_TRAP_EL3;
+            }
+            return CP_ACCESS_UNDEFINED;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
+static const ARMCPRegInfo vapa_ats_reginfo[] = {
+    /* This underdecoding is safe because the reginfo is NO_RAW. */
+    { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
+      .access = PL1_W, .accessfn = ats_access,
+      .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
+};
+
+static const ARMCPRegInfo v8_ats_reginfo[] = {
+    /* 64 bit address translation operations */
+    { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E1R,
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
+    { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E1W,
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
+    { .name = "AT_S1E0R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 2,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E0R,
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
+    { .name = "AT_S1E0W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 3,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E0W,
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
+    { .name = "AT_S12E1R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 4,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .accessfn = at_e012_access, .writefn = ats_write64 },
+    { .name = "AT_S12E1W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .accessfn = at_e012_access, .writefn = ats_write64 },
+    { .name = "AT_S12E0R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 6,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .accessfn = at_e012_access, .writefn = ats_write64 },
+    { .name = "AT_S12E0W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 7,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .accessfn = at_e012_access, .writefn = ats_write64 },
+    /* AT S1E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
+    { .name = "AT_S1E3R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 0,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
+    { .name = "AT_S1E3W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
+};
+
+static const ARMCPRegInfo el2_ats_reginfo[] = {
+    /*
+     * Unlike the other EL2-related AT operations, these must
+     * UNDEF from EL3 if EL2 is not implemented, which is why we
+     * define them here rather than with the rest of the AT ops.
+     */
+    { .name = "AT_S1E2R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 0,
+      .access = PL2_W, .accessfn = at_s1e2_access,
+      .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = ats_write64 },
+    { .name = "AT_S1E2W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 1,
+      .access = PL2_W, .accessfn = at_s1e2_access,
+      .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = ats_write64 },
+    /*
+     * The AArch32 ATS1H* operations are CONSTRAINED UNPREDICTABLE
+     * if EL2 is not implemented; we choose to UNDEF. Behaviour at EL3
+     * with SCR.NS == 0 outside Monitor mode is UNPREDICTABLE; we choose
+     * to behave as if SCR.NS was 1.
+     */
+    { .name = "ATS1HR", .cp = 15, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 0,
+      .access = PL2_W,
+      .writefn = ats1h_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
+    { .name = "ATS1HW", .cp = 15, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 1,
+      .access = PL2_W,
+      .writefn = ats1h_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
+};
+
+static const ARMCPRegInfo ats1e1_reginfo[] = {
+    { .name = "AT_S1E1RP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E1RP,
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
+    { .name = "AT_S1E1WP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E1WP,
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
+};
+
+static const ARMCPRegInfo ats1cp_reginfo[] = {
+    { .name = "ATS1CPRP",
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write },
+    { .name = "ATS1CPWP",
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write },
+};
+
+void define_at_insn_regs(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+
+    if (arm_feature(env, ARM_FEATURE_VAPA)) {
+        define_arm_cp_regs(cpu, vapa_ats_reginfo);
+    }
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        define_arm_cp_regs(cpu, v8_ats_reginfo);
+    }
+    if (arm_feature(env, ARM_FEATURE_EL2)
+        || (arm_feature(env, ARM_FEATURE_EL3)
+            && arm_feature(env, ARM_FEATURE_V8))) {
+        define_arm_cp_regs(cpu, el2_ats_reginfo);
+    }
+    if (cpu_isar_feature(aa64_ats1e1, cpu)) {
+        define_arm_cp_regs(cpu, ats1e1_reginfo);
+    }
+    if (cpu_isar_feature(aa32_ats1e1, cpu)) {
+        define_arm_cp_regs(cpu, ats1cp_reginfo);
+    }
+}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index c59f0f03a1b..895facdc30b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -64,6 +64,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(files(
+  'cpregs-at.c',
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
-- 
2.43.0


