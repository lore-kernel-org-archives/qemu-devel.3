Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0FECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4O-0002mv-5e; Tue, 16 Sep 2025 14:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4K-0002eA-DW
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4I-0001Yj-Ew
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3e8123c07d7so60261f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045977; x=1758650777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vfHq27lDhQ4NQ1/qJQUOtg7oMOlcyoNuyBnvQMqib1Q=;
 b=G7gyUIu9uKNVJCvLM6+x0+F/QsFUd5AVGkQ8xeEU4a3TVM6wJw40JItG15tnZx7EKR
 2FlA3twhu3gpjOlfHtOPGoQnBvhm8/uVmnQZC3oe7VUC/2+IwQw3thzLp3yEpGXUdzbe
 Ni3z+LxpWnXVuXhDgPuM2asGLBLB8AdEFjY+e0Y91likdvSS91QWX1GUhoOj+LSz+VvB
 50SGN3xXnVwGVWFZdLh7eG3LhN2Kx4KxHfatXpAMd6WXkpdn3VBcouWPlK/Y9NCvsak4
 6QHm974dzMaNemDwHYS4efnePPeknMEYJer57h4m9DqdfmMIgUckPBS3ylHM7O69MoTn
 I1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045977; x=1758650777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfHq27lDhQ4NQ1/qJQUOtg7oMOlcyoNuyBnvQMqib1Q=;
 b=OOdIG/fICBZnsKYaQlmOjzKhgJVTtfiDWbslgRzsl0qNS0P4fVKegW7/kyo+dSXBG5
 pjCFrRPT8hNmzSni1qcfjdZEA3myQG9gyV1HgvwMPcpxEnttvuhwE62pnU7tyYUTnW+f
 7qysLPd1xZDJKFpNk3z38ytBrEN8D8v5BHgNxG5qJceGVaYr09Ri4G0BW8DRpf7fjUwC
 bcZ4eBJu4hMS5sIYiAb67oYpAkrSx3hON3PF667ckPQuYGXHXmTewVJKNj9FyU4kZe7D
 9VfY3s6CKYGghlieRC6nlGjR0hmYJHG3da9lcID7d5o0uYpdjoN/quyYZ52ZfHYK6GtC
 f6sA==
X-Gm-Message-State: AOJu0YzxlU7bhQ10ajBM5hWvUriM/+S6cy3Xx25Gzr0Joe4szw9DtQBN
 +Ajjuo7KDkS+esx9Wb64eedfqGUgAOKic2WTl4uetFgAb9hlcndCQ48St7JsJ4+YXZVLHcLXZMv
 l+IJ6
X-Gm-Gg: ASbGncssunna3Jr4oPtASPKMZPAwtVr9Oy7YgyeprLxDBq3Qdi2o45+fMzoZ3tibj4X
 92/dP5ckWUCQ2iyThqfXRp8ZsvZadAHBcLLCQxgu0z8W9L1bxbX/c2BCeKxNpnP9EffjoKywwN0
 8ZTOzbnq0PW/Bjy4sp8t4meBgIXbnJYP4QXut4JTt3EffqQ44RR7f5jSgIkZR60AOE519Du5ROc
 srS9OZYf46NpKV9IDga+9MAtko6ekU7N7oEPrATrwQYkmgYTP9VwVT9F+jREfvYnLSWRiOBXfAb
 xlZFVh0EpoWSoYMzFvrdjXxNuSH6YWKvqsvH5hNiVqipX5uchP/K9jyQlCIsSg0FWFfiErMOxzT
 CrFIT4uMa+ylVXaQiTYCF7pnK0uTB
X-Google-Smtp-Source: AGHT+IHJu8ejvhEihPCbrj+9/WOpUE8iFe6NJ0esruchP//WzSkHzF4y311neI07pWxFdL+lbOZYPA==
X-Received: by 2002:a5d:5885:0:b0:3df:22a3:d240 with SMTP id
 ffacd0b85a97d-3ec9d70e262mr2983297f8f.4.1758045976907; 
 Tue, 16 Sep 2025 11:06:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/36] linux-user/aarch64: Check syndrome for EXCP_UDEF
Date: Tue, 16 Sep 2025 19:05:37 +0100
Message-ID: <20250916180611.1481266-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Message-id: 20250830054128.448363-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 75 ++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 3b2782581b6..7ad26316dea 100644
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


