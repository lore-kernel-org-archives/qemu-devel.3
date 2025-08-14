Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648A7CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXD-0001Gc-Qo; Thu, 14 Aug 2025 08:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXC-0001FP-6f
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXX3-00048W-33
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e2e5c0d4fso766383b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176287; x=1755781087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we2kBP9OJLrPPGq7QOJ6TSid+ia1Le92lE2F6Wh2Zjg=;
 b=iDWZ1IGNvEB7gRGXOU7o781uyTKmw7Cv0irBoLyNVipTZs7JDma6XtfeivDYHvpnou
 XqPaQFsIocSzW8flOGEILwMnUypTCVfhz+pawz+FaisGAtQYiTo+AtAQU7yZprp2rts3
 SdSe4UH3dOWJUIaK3I/7w9OkibpIITKqUobg2poWCa8jK/SkS8J2hW6v0s5TUmazlt6D
 Zgq1kOsO05WsvGPXETcZ5QB5+UtI0IQTM2XfWZ7wFqN5iPHLDeOxqdX9s/4oQ4HSxqnq
 tHBwGXU8Wf7h9zGK8x60tpvVUy7uHWtcjypsEVszoXBqRO1al6JIweaJN7z8hmnM8RGo
 jHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176287; x=1755781087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we2kBP9OJLrPPGq7QOJ6TSid+ia1Le92lE2F6Wh2Zjg=;
 b=rothQdfIVBa8vWEC9YnS8EfHwRDfaiQeIfQVfRSR2Kgn38HCCPipetCd55xVhtLnIm
 QZef6qI+n7XyvDO4DIrNyiogAUm3cyH6lCQIvnq62QhAusT2w2VqKqufp6nCFR6iaTzK
 1QDh4HzSFZ92qxvAmREABmp8DdDf/l0ZL3EAHJFzMhPnc2QsuaRq6mxFSVsvk+K7KsFi
 63Gvt0rI/NYa/IY/6tinlr8MNiajAqITbuAyZixIPRPsXrrCoQ/8//L7XRxyEBA+9awX
 TF0BYyJQlRyDP8IGHaE9JCEQIaviIfF+TAFKJxk34P2b9L5ziAaPMgCozE//bDmrtL5a
 +oSg==
X-Gm-Message-State: AOJu0YxJwAN1c3BtkTXxsnMgvwzRSNsloWOJ+J7AQAHKpteoJr7e/2l5
 qTKfK+mBKMqGDz8RFk0eVfgp2yid75sPZd0te170V8n9NT0C4bR2nhKwhjvcmVybXjjA8wh+0ej
 LXv6Mrc0=
X-Gm-Gg: ASbGncvchwWVGUtoqf1Mg4lO/A4GT9EgPoYiWdt4qO9o6p89VFoPpo7drqJCG7rdO8t
 3JXW7N4qPxYHI8pbk4++YMnKHT/b3VFYdhZgltD/OqcuKaKii7k+ycfsnRoF1r2o2AkTYSIKeLF
 4bbmpW3q9Joh28ifB4tir9OSDKqvYvdooMy5LWGAhNJG36mdMoVJDjtYGEfMZJUbKGqy4VzISrW
 AMOCm83ldf93N4jQCSJetxEukFXqZKTCpwQCIdhQIfAK8BBAgkTHrspoGePdR24SUKH6gTHBtlv
 MKx/7AfyCDqkf/mKaUfxdEQwSZQ8DAZl74xNQ4uurgZR5ybjWnUa+ltcSJFT7lAZQoYgaZilWOP
 Ubou5huqvOJGgtYcRFUdMHJNq+8htcsrxzJiDhEkNOW3VQxE=
X-Google-Smtp-Source: AGHT+IHMUxnQ4jnW83NGm4cUAtCXOwkEMFLQAShZOd+Ym4yKsYbUm9PxxqPxFk36q1Hm6+OwyQjWpg==
X-Received: by 2002:a17:903:240b:b0:243:12d5:db5f with SMTP id
 d9443c01a7336-244586d9dedmr49353575ad.48.1755176287439; 
 Thu, 14 Aug 2025 05:58:07 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 02/85] linux-user/aarch64: Check syndrome for EXCP_UDEF
Date: Thu, 14 Aug 2025 22:56:29 +1000
Message-ID: <20250814125752.164107-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Note that we have been passing the incorrect code for most
exception codes: uncategorized (do_el0_undef),
systemregistertrap (do_el0_sys), smetrap (do_sme_acc),
btitrap (do_el0_bti) and illegalstate (bad_el0_sync).
Only pacfail uses ILL_ILLOPN (do_el0_fpac).

Note that EC_MOP (do_el0_mops) ought not signal at all.
For now, preserve existing behavior signalling ILL_ILLOPN.

List all other exception codes and document why they do
not apply to user-only.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 75 ++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 85d455d018..deb45eaa73 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -65,6 +65,79 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
         si_code = TARGET_BUS_ADRALN;
         break;
 
+    case EC_UNCATEGORIZED:         /* E.g. undefined instruction */
+    case EC_SYSTEMREGISTERTRAP:    /* E.g. inaccessible register */
+    case EC_SMETRAP:               /* E.g. invalid insn in streaming state */
+    case EC_BTITRAP:               /* E.g. invalid guarded branch target */
+    case EC_ILLEGALSTATE:
+        /*
+         * Illegal state happens via an ERET from a privileged mode,
+         * so is not normally possible from user-only.  However, gdbstub
+         * is not prevented from writing CPSR_IL, aka PSTATE.IL, which
+         * would generate a trap from the next translated block.
+         * In the kernel, default case -> el0_inv -> bad_el0_sync.
+         */
+        si_signo = TARGET_SIGILL;
+        si_code = TARGET_ILL_ILLOPC;
+        break;
+
+    case EC_PACFAIL:
+        si_signo = TARGET_SIGILL;
+        si_code = TARGET_ILL_ILLOPN;
+        break;
+
+    case EC_MOP:
+        /*
+         * FIXME: The kernel fixes up wrong-option exceptions.
+         * For QEMU linux-user mode, you can only get these if
+         * the process is doing something silly (not executing
+         * the MOPS instructions in the required P/M/E sequence),
+         * so it is not a problem in practice that we do not.
+         *
+         * We ought ideally to implement the same "rewind to the
+         * start of the sequence" logic that the kernel does in
+         * arm64_mops_reset_regs(). In the meantime, deliver
+         * the guest a SIGILL, with the same ILLOPN si_code
+         * we've always used for this.
+         */
+        si_signo = TARGET_SIGILL;
+        si_code = TARGET_ILL_ILLOPN;
+        break;
+
+    case EC_WFX_TRAP:              /* user-only WFI implemented as NOP */
+    case EC_CP15RTTRAP:            /* AArch32 */
+    case EC_CP15RRTTRAP:           /* AArch32 */
+    case EC_CP14RTTRAP:            /* AArch32 */
+    case EC_CP14DTTRAP:            /* AArch32 */
+    case EC_ADVSIMDFPACCESSTRAP:   /* user-only does not disable fpu */
+    case EC_FPIDTRAP:              /* AArch32 */
+    case EC_PACTRAP:               /* user-only does not disable pac regs */
+    case EC_BXJTRAP:               /* AArch32 */
+    case EC_CP14RRTTRAP:           /* AArch32 */
+    case EC_AA32_SVC:              /* AArch32 */
+    case EC_AA32_HVC:              /* AArch32 */
+    case EC_AA32_SMC:              /* AArch32 */
+    case EC_AA64_SVC:              /* generates EXCP_SWI */
+    case EC_AA64_HVC:              /* user-only generates EC_UNCATEGORIZED */
+    case EC_AA64_SMC:              /* user-only generates EC_UNCATEGORIZED */
+    case EC_SVEACCESSTRAP:         /* user-only does not disable sve */
+    case EC_ERETTRAP:              /* user-only generates EC_UNCATEGORIZED */
+    case EC_GPC:                   /* user-only has no EL3 gpc tables */
+    case EC_INSNABORT_SAME_EL:     /* el0 cannot trap to el0 */
+    case EC_DATAABORT_SAME_EL:     /* el0 cannot trap to el0 */
+    case EC_SPALIGNMENT:           /* sp alignment checks not implemented */
+    case EC_AA32_FPTRAP:           /* fp exceptions not implemented */
+    case EC_AA64_FPTRAP:           /* fp exceptions not implemented */
+    case EC_SERROR:                /* user-only does not have hw faults */
+    case EC_BREAKPOINT:            /* user-only does not have hw debug */
+    case EC_BREAKPOINT_SAME_EL:    /* user-only does not have hw debug */
+    case EC_SOFTWARESTEP:          /* user-only does not have hw debug */
+    case EC_SOFTWARESTEP_SAME_EL:  /* user-only does not have hw debug */
+    case EC_WATCHPOINT:            /* user-only does not have hw debug */
+    case EC_WATCHPOINT_SAME_EL:    /* user-only does not have hw debug */
+    case EC_AA32_BKPT:             /* AArch32 */
+    case EC_VECTORCATCH:           /* AArch32 */
+    case EC_AA64_BKPT:             /* generates EXCP_BKPT */
     default:
         g_assert_not_reached();
     }
@@ -108,7 +181,7 @@ void cpu_loop(CPUARMState *env)
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_UDEF:
-            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
+            signal_for_exception(env, env->pc);
             break;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
-- 
2.43.0


