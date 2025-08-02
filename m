Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A1BC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLgh-0006tB-3C; Sat, 02 Aug 2025 19:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLg9-0006KW-2u
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:25 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLg7-0004oy-BT
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:16 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-61998205433so135568eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177413; x=1754782213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZO91750IU39C64Ysfe0nf9paxZYyW7yZCYTpOatYiek=;
 b=NLUIaId2k8dOFsyLmq9jQ/tQ0E5vsT3Sn31Pygd4FJ05EEFfZr7fuFi1ilsz7bUaWp
 oSyUyd0sKsMIRA/zIZVVuUPxkZmeIuIsQisB9MGKV/dnhkxmSe3Ok5uUn9oIgl4yLOXG
 4xStDhuLuZ3i3Vlvhy+RjxPwTQUALznTqHBbNwHjEncDVcXFbCJ8dxYV2vxfeHDUattC
 vLicMeB1Ub8bAzvkFtdHybw6MTBANPyCtv1K2zzO/YMdKeRhwPNrXoXfeQgR2tDw167p
 C4vg407lSnAwFMj+qqdfSw7KPF8RcGALbzixOYKS/4LSkcHq/SuRw75C9ja6uCQPu6dH
 Dy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177413; x=1754782213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZO91750IU39C64Ysfe0nf9paxZYyW7yZCYTpOatYiek=;
 b=GnfC6yfxWnkZaBJVXFgBNh7+T4OfWezlVUxvPn3DYYhOGKbMwPoOrM7BmmswwvJNbq
 Gb3dcWJmpYwSDciwl9cWy5Ok8660Wf4HbPhg98AwDq/PSzK1hXovWbS7edP2Q8K2dvZq
 QeYlR8D/grxayHsAP6QkgbtP7RYkgmE6FLLmultzrh4zW8rwjrj/M6ouTzGFGtvTxUUz
 msVE3Rll59IqO989AgXiPaln/jD/Xc5ZvIIpdnjNltKnTlICMJfgz5CG4J8uJxG3D84o
 dEJDwDguMmfpx5gRr3RN9TsiqMpzJ6ZaRUKU7ry741BX44S8ZHDk+hrr1zMbLTebXXqh
 +9zw==
X-Gm-Message-State: AOJu0Yzxu6CyZKIgEwhSCBl478jyYDlVqM55oo6pwABkiNL94g76+Gw8
 01nA4spUw74mJHSz8R4QCpo7g5jXt395h4EKI8E5sDrusoUoQxg6JZ4Aqo5zW2t2cXyd0AmEQPM
 qycE4y/E=
X-Gm-Gg: ASbGncvNs+B/Eaxlc5XMbx2V/cSjCI8sjV+e8ZLQ8dLT3lWxwzZasJHQQdoLPd61NoX
 XyTECuLvTuAvhMvslA31laZTOXyI1xiE0ylgx9G7P/Y8YnblhfnhcNpcA2JVpEtnS5/F9WkBnZ2
 4889J3npRNrvkGLpZ6Nexj5JOLagV48jHCJPVD+zxeXMJNypXj3nzz0Vpjr6MU6RtDSlFVZDCxK
 oMCJpCi9klSmHaRS7/4rEDXoDzRmx87panPg+sMGJCwbItEtoNes3U7TuhYjyqatePEPGTnxESD
 jIWtztKQpJNBdMuXY38JFiiZzsYwXW8ac4SXtsGcqB8drfuhdzLCcwRHDGMvDglcVC2NpKpys+u
 kqbjAYB7yCJSdoT5RM/2RhVk9nlAguDZNXU+KmwcSNb6RSrvx5m89MwmZVhBXROY=
X-Google-Smtp-Source: AGHT+IESz46fEIIeUhfl9lmDOVPJQ5fLDSgl0CbbNblgLjaWHC/6zoKyYigLJ73SMsEqCScEpsLXPw==
X-Received: by 2002:a05:6870:a48d:b0:2d6:b7b:a83 with SMTP id
 586e51a60fabf-30b67608083mr2383246fac.13.1754177413293; 
 Sat, 02 Aug 2025 16:30:13 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/85] linux-user/aarch64: Check syndrome for EXCP_UDEF
Date: Sun,  3 Aug 2025 09:28:30 +1000
Message-ID: <20250802232953.413294-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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
 linux-user/aarch64/cpu_loop.c | 66 ++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 85d455d018..098578978e 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -65,6 +65,70 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
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
+         * In the meantime, preserve previous qemu behavior.
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
@@ -108,7 +172,7 @@ void cpu_loop(CPUARMState *env)
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


