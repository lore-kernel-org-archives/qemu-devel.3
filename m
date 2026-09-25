Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA6AC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADpE-0000CX-Pd; Fri, 25 Sep 2026 17:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoI-0007n1-7T
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:27 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoC-0007ng-Hj
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:23 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 d2e1a72fcca58-88098dbba5fso192930b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373018; x=1790977818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DgcW59+pyp3+kc3Gq1uovvoNZ6RuVzP0QLBQ3UuY5fU=;
 b=HpZQLiPA0YZ4zTpblzejDOKDBMoHOGjrM6g2SYxa8lQ3RQL3rF+vys4NVtWb6ECQ74
 ilERqbayHqrpdwh+1NTeKmpqO5Pr/KDbhOhlXOKmCYX2tC8KSx/IxpQAANPnJmB9Mbi5
 If7Exl/L17PMwFWQmFPmRKzo9zxdl+ykfAgx2zrpwwu6OYFwULe3zlasqzU7vsYajSmR
 OC7ck/oEkG0v2tDCvdtBNnxxfEBfpjDrkYvv20Vpf+jViqAkL2tDegymVYamXJK6IDO/
 OkSNjc/rLv6XLg7RASseL+f6iWp9hkG2S7fjGoI97HIFCw6dpZ8Hken+n0bhheozMn1B
 6NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373018; x=1790977818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DgcW59+pyp3+kc3Gq1uovvoNZ6RuVzP0QLBQ3UuY5fU=;
 b=zXE8n+ckpy5ll3d3gXCNeoWBvQWdnYS2/zi6yTVpkE0VhXlIe9BdlYS9pUi88Awpae
 2jdBlOADrSK4N4ee/+ZD81LOVOVC7KExpqQTdU7WQkIZF4XbttWgBXUOPC72s3Fn+6zY
 7ItxQydx5gk7JGkdhULlN9W38mXO/TNEeManx30yJMkfNK7Kmt/noR1Iy0okr0Ve8BUc
 nQ6zQAxGEvGdxF7YtawxQXxr9tsnuubn0zFaJ2ttItt0VAWrF/eaZVsVEFUgXKi+Ot7E
 wEF3hOjAOYzrulcwgT39UonIltOruLhWkyCXfPiVe1WiC8g5dl9n3FUdgUUMdyYBnIUs
 PcRg==
X-Gm-Message-State: AFuF++kUziJ/GTfUCVY6Vo8ONRZwdWqCTKgYbbtjQ8KsAiI7vycZft5I
 hsUQ2dfu3zq5pnbsVdIP/OyDC30B12cyid5MOxhHS54EcCBkHwGdrJhI8L8jcwdkERzCx+x9c0q
 1A7wF
X-Gm-Gg: AYBFou3AsKrlpZqRH8pJMSwlFXRf1I46WOjTaMLi80zi2edZtge5kJ1eT0MuR77AQoh
 7EfScUTGD3h7LZgAUrtRCM+fSIl9Cvy8eWin7ILqvAF5ngXRcem/hAur8xPIv+vDxiwENRrZFLB
 ucnEG4TlY8AyKtUR9derXZ928nyBBcdtIAqB2edPAwJl9CBm6Kn1uOTdPUhxWKqUU3Gl1nnFh3q
 RxYfmrFKFXf69jehDKzLHW0dzXPQNEsLS6acp/wrcjFU2YeQjBDF1nlK8l+a1KWi1lJ+CWYMMCZ
 JqHF6pq3yWhdW2P+aYFq0vqMShgjGsVcchC+HijUSRp9JWlR0Ss4PnJ+8QWsKz8/vfpAz0ITZFM
 K0iJlUeOnE2zghR4CzHBSntnZlj6JMBzd/Nrd1XLaKr7xBV3NRAC75Gy04Lnkvnm16XLYloUzaU
 PDREGGsYFT06//RqcNNGXXhpd1ARFe9ki6Z9uoMgEToZk5Nb1yL8SLct/eLQ/Bz9mkXtZQqLlZS
 aCF/LhRfOC9MT6zRNrcNyzE1iuSVQ==
X-Received: by 2002:a05:6a00:3a06:b0:878:3704:e0f1 with SMTP id
 d2e1a72fcca58-87ea07d0e7fmr3855395b3a.23.1790373017912; 
 Fri, 25 Sep 2026 14:50:17 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 11/14] target/arm: Add PSTATE.UINJ to tbflags
Date: Fri, 25 Sep 2026 14:50:01 -0700
Message-ID: <20260925215004.456336-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 3 +++
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 5 files changed, 8 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 735e777d103..4e8a472ee71 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2483,6 +2483,7 @@ FIELD(TBFLAG_ANY, ALIGN_MEM, 10, 1)
 FIELD(TBFLAG_ANY, PSTATE__IL, 11, 1)
 FIELD(TBFLAG_ANY, FGT_ACTIVE, 12, 1)
 FIELD(TBFLAG_ANY, FGT_SVC, 13, 1)
+FIELD(TBFLAG_ANY, PSTATE__UINJ, 14, 1)
 
 /*
  * Bit usage when in AArch32 state, both A- and M-profile.
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 31f52a34a68..f633aa265f0 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -155,6 +155,8 @@ typedef struct DisasContext {
     bool align_mem;
     /* True if PSTATE.IL is set */
     bool pstate_il;
+    /* True if PSTATE.UINJ is set */
+    bool pstate_uinj;
     /* True if PSTATE.SM is set. */
     bool pstate_sm;
     /* True if PSTATE.ZA is set. */
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index cf7d49be908..c0b47f484e6 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -121,6 +121,9 @@ static void rebuild_hflags_common_aprofile(CPUARMTBFlags *flags,
     if (il) {
         DP_TBFLAG_ANY(*flags, PSTATE__IL, 1);
     }
+    if (env->pstate & PSTATE_UINJ) {
+        DP_TBFLAG_ANY(*flags, PSTATE__UINJ, 1);
+    }
     if (aprofile_require_alignment(env, el, sctlr)) {
         DP_TBFLAG_ANY(*flags, ALIGN_MEM, 1);
     }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c60f4c4103d..b3438235828 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11028,6 +11028,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
     dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
     dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
     dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 8c56348a665..f32200cc47e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6418,6 +6418,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
     dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
     dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
 
-- 
2.53.0


