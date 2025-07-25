Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927FC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 23:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufRXD-0002sg-S8; Fri, 25 Jul 2025 19:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRXB-0002rE-QJ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:09:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRXA-0001pC-3R
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:09:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-237311f5a54so22137875ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753484939; x=1754089739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xv/DPsQ51oL4gzkHoBA4GyM8WSLp/SLOF+zyYz+j7XU=;
 b=Jj1uBQLtwEnJNDfxt26YZEp/17H/qBH/VGxShOboSzq/Ddai5CqxqRfsVNNbFKj4N8
 ME5t4oeEhku3qAhQD1Daz3OTJkwOM4AW0K2dool9w6pfggK6ZaS5KIDnknQGBPyGMdT1
 HmBCitxuNytdptzkM51+t6YMOxXSbtwrQ7SzgbCLPjWd5Vljz/2jCU2P+/6KiyZItnBB
 0c0SeGPBhl1hoxck0y5LB5OypA0oR2FsSrMoeZ9oVsmtUyiSL6BZFjd7uS4uO7wHFbLS
 CKnCHvAtXm0g7ZzrdH+QwKZBqkA8tArDwhPI9df5xb+UAxxZnzM+QUq4e1P2/5WmXTv/
 iafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753484939; x=1754089739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xv/DPsQ51oL4gzkHoBA4GyM8WSLp/SLOF+zyYz+j7XU=;
 b=W1p3OvBs653v5/PlYki0ksprQ9Jaj0Ra6R9Z/ksKk2mRhp48YRQyoWCC854ZPj4E7e
 7qXIC0W9P1dfilRPMyEnxDREbmNqg4xmdf/DT9Apn7WOgzmaxDqbzF2L9uIQB70LFmNl
 hUEgvtj9n4jdRRmhn7GPbyAu+WecmIB1US0oCGkCyIQIcPbhHDNjnSj4uIQe2u+3MBSs
 bJoP1yEPNW5RpWymqbYsShFhOMY3p0EGR3Gg2gVpF9DXU1sYCrudypsqIEwJP14HALJI
 fqvt5TCUmVMe+BiIRtZNu4CakRwo8vgehOxtATxPwagRpZAuA9EwrjC0BYjgxuoYlwT4
 yeTw==
X-Gm-Message-State: AOJu0YxTat0XUfVXtlTFoHL+TEqNPGxIz25+YXaGaJIB9SbsBQPHsXnE
 b/8XleWZ7eX6jACR/CfAoK0Ied0+kuSTYuJV02QoHPPDZkcBqJ7jzA0gRarw0mFm2aKrLORbnoA
 7rf00
X-Gm-Gg: ASbGncvA5wsem7G/WyU1/cBVgSD5U9eChZOwYIP8Ru2oMu2bgd1OKyVdStcKU5S/Iwj
 djz4OO//p4J/g/zMxKt4cXoy7c2IOmDJ8VXI7azDqxkGuIKutjewRojTqwuBA1D0xjbxdCVnUQg
 daZkIg0rSRqbat1YOpG+JlmiPBDCIeHdn2ydVXLAP9bl3o98iW2MlNVdZ1HbprbrgFZSXiSzSwZ
 uhk0tSm95dayJbmkhdulDgnU3ei+4pjorBBhaHkN3eRwysncKjt+Co383rkNZxxMdnOGWzLHCxO
 WJkCyaykZ64A6oxqPWcpP0XWYIBO3kogmiZPyZYmGYVzCfgcgkp3t9SKWJZ6ZsuETowJ5sHgJjz
 FwRUFzo8X5cMMKKI4PslyIY4MNecr51H4RiV0DLA4BAVWgNja+egNuJ9MqyDspQaM071Xt3Ebgw
 HbnO8jFHYSiA==
X-Google-Smtp-Source: AGHT+IEJjLnnVOewzzW2PGDnxN7J2Nh7+K87fX74F4Ot2wTT5tBmnNTmoSXssQHepU3bqt7f7JghZg==
X-Received: by 2002:a17:903:252:b0:234:a139:1215 with SMTP id
 d9443c01a7336-23fb3178ce5mr53731385ad.35.1753484938609; 
 Fri, 25 Jul 2025 16:08:58 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe545368sm5033375ad.172.2025.07.25.16.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 16:08:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 2/3] linux-user/aarch64: Check syndrome for EXCP_UDEF
Date: Fri, 25 Jul 2025 13:08:48 -1000
Message-ID: <20250725230849.13026-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725230849.13026-1-richard.henderson@linaro.org>
References: <20250725230849.13026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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


