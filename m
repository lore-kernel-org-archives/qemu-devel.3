Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3034CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNva-0005Wr-2j; Sat, 30 Aug 2025 11:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELP-0005nz-Vq
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:44 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELO-00041Y-4M
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:43 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32753ef4e33so2086395a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532500; x=1757137300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvWWI/Hwe2tsOELzBbjd3DP4kSVprV8wMOEgKmW2NGs=;
 b=Z0j1qQ77vkJ+3TY2cKdJCSvL9SItqspC0XPiotEY7BmCBoQ/8OAQXwKF0yY5QKIwGq
 KV45o7zuzPcUx9MmH5X7wa58pFcU48sQuEsYI0GoM7EHW2DkMsXIjRJ6suBgDSAvI8nZ
 RpgMpHsJq1QAimF3la0ZCmjMgJSy9z1X2PcPJTDuuLZ2hHokkiyUbSkvA6XozuRv/kUP
 11WjW9cCY/aicGlxJzhjELjcxYLCfdgHzPnkgzBr4z+mMdNVZsmFBuQ5uiHVhn0zo5Mh
 hhKfgMYTiWT2nLiokuAPy/3npWMbYKV1zohxJNMY5f0yq+EgCVN/ACrQ5Bopt7b4hQGX
 VhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532500; x=1757137300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvWWI/Hwe2tsOELzBbjd3DP4kSVprV8wMOEgKmW2NGs=;
 b=nH0xaYGF2ko1r8iYiBbIEPdsLiogcIECX9ymfLNRQ6aMrqUKzyORmCsOQ+NJe8Y8oD
 geCee+lMpd8rTxq34/h91lSROY3Nm5TwqVsRumnvJOPyf/5xTrQu/DZ+82ugPelXdE86
 dY4MWNBg15S5uSy7B/z1NPObGEUvOFeNd8Vy6K0rsj7nie3y7cuZe7uOrPqyiUZ+MCZl
 ZjaFsz/cKIIVdHoOxppQspxUHCGrebfQ9MHllS/CDtg7f19V5ZTkaTQAm6qF8HlOAkBv
 zOFWgL30exIOOytkWaQzjY6uCsBz19BOfM9KimvOmE8Jzfkx/BcNIFKtHg67klazv98T
 rlyA==
X-Gm-Message-State: AOJu0Yzy8n5iYSJiOkl5wNDN7HlIIQ6i+nJFIi3V+XiAu52lrtR6ZMOR
 DJiZxzXHltArQGxLIbeowZXeRR0dJxRDNteBLCiyhWKPMxcGjQhD1WmwYXjto+yAy+W7KUqX8x9
 a+lrsp88=
X-Gm-Gg: ASbGncsLTa9ZWQWG7AiBsmdVTNpzzvh3+g6VmBXaT4k4odCmPAaMy6ioIvpL/8o6HFS
 TdxeBWkutVuOEpDFjWBTBXxXIMVOwm7ESH/CnDFZB0QzqDuhOcxhiA12zPWmrPoBpzydT6L99XJ
 LFHRsPanuJ6f5l+kFN8hGKBHG5xiQsa2066wCzyjnRenYEH/6purfRG1ENWCH6PqHt++xfYCibx
 lR3aTgo2fUEgmh2ovgTJz1Q4C8qGIBYCQ9guBbEAdihRMUMphA7U487w1CZf2GUiqgjWqNJeMKc
 6juzdq6ZzpOtN4X8LC1MpVYNsmtCVjsmHr065Zm8THlqWJktk/2jCbjX9xuekXnstYeaRnX10Vj
 l9CP4KvJ12FAkf2b3co+tt4NPuzTlqryVv/IdPneAhlCZAX7fxi1Cs7HCWTQlpa4FIzMLP0s=
X-Google-Smtp-Source: AGHT+IH2SeyC/Bq4iCcnct16kijzpG5niptNeAgVpdvmuzGUfNz08ys8fOOQ5mePwjG0aThKb9FGUg==
X-Received: by 2002:a17:90b:270a:b0:327:d8e3:1b9e with SMTP id
 98e67ed59e1d1-32815412c60mr1659563a91.3.1756532500430; 
 Fri, 29 Aug 2025 22:41:40 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 02/84] linux-user/aarch64: Check syndrome for EXCP_UDEF
Date: Sat, 30 Aug 2025 15:40:06 +1000
Message-ID: <20250830054128.448363-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
index 3b2782581b..7ad26316de 100644
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


