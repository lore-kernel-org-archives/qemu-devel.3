Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D202CD8C92
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 13:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVrNX-0002Ru-Qx; Sat, 06 Jun 2026 09:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wVnCk-0000Rb-LK
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 05:20:34 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wVnCi-0003Xp-R4
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 05:20:34 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3967717c951so29221671fa.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780737630; x=1781342430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f2lDKcqQ8unO0L5ykgRMFRBw2EOUQnwyumW8J8Iy/4c=;
 b=Et8d8RhwqZFH+Rlsh3wvKpSLcsN78Dz2IylTb9l4BY8OwK+njT5hPLgqpLQoHdqcPW
 zWTxgkl8kpuG2q7fwDR+v1UHVHQHXHlQOicpU1bLhuPQNe2wUpoxXvhqbOifeu2Y79w/
 kAiIpQnbP7tlSy5wbdT/JfQC4cVZrtSFn30z0VMwle02rozDFqKJMo7Gxc9EmStJxupD
 U7uD0l8vuQ2QIae+luTVu0S8QCXUGlUDD8XGfBJsi1pMr2FJW1tO3/qrTdDvJsnVF6dp
 aEaSPbizUkHhTKy3mqBGoPm8KNgyPt/q0c5lbrmyHRhudlnQeyjS6BnwmIH4LxK89Exi
 luKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780737630; x=1781342430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2lDKcqQ8unO0L5ykgRMFRBw2EOUQnwyumW8J8Iy/4c=;
 b=FHwJd50a6xXDkN5VyhljCmqEECKpCksC6+Nh65YRnUH2rVw7mGQrPaRsjrGGZkJMuM
 1l6slDGOZpRwAE+v/NrOF3b7TPOxegdISk2uuqAtJwW7o+wt06+aIvElpTQ2FKtldwKV
 yqHrPuNBJZm6b3CBhzorGNU1Gw069cLL4Xv6gXvCktF1/f8EcHC6MWBiVxxSZlDuPon4
 07uzRho6i1ryARXnSyfk374xnmQpGo+WFcmKxTS3X33D/hpTlvusnOSmRDOkZ6emM5Y3
 9p1S4yEKXfP+cwXTksG1uVc/h+KVMEoyH5CfSNDuX+mWmWISBUTOH3IniVmov3m2lg9v
 Z7/Q==
X-Gm-Message-State: AOJu0YydjeTN6cK93MES7tkERagjbb8btRpPM614cO5vsDjOFP6Ke026
 /GaJeCtj6ng913u7YnxOU2ioOQ6KUymheEOVvV6d7bjiFMxrsq2SYgaj+W601OLt
X-Gm-Gg: Acq92OGrQbuNmc1aaHt5RpdQz4PWFVlraHoOL9tEokWxZXrNqpgKtxcPP/k5LBr7bwf
 5R+fixgNZJnS4ql1IYoYBPXbEN2OwRv902LU+EkQVcnkDAOpXAF0sEnhzYUrR5c2yBH2QlpDVE7
 s+RArfXqInCEYubqJ3vzcdg1vNNhCUx+aRmrvE3CxuP900XQaRFB6D+8RRZntiUSvUmLzmVlmf+
 zJjLdQ7L4Pi+lJ7Wxcv5HRvdX6PfMeyI5RukmX92GQqHCaPfaynJCzO7o9r/HBOGLfRASDmNE26
 u2r57XRF3tj4LfaijjBe5KgpXTp+TsqBHW2dmmju+Zbvi8xL1nlJHHjmORLXUvFR+twAHVefIcK
 z3rrxsN4sgupehlZfIMj1djJ1cGSnVOer6ZIcwNSCRzcEHuOVme4LBQe5ZIgmVeHfQQxZSTTIlq
 ww84oF+rWeAXOQZGTI9RzHa17oDF0=
X-Received: by 2002:a2e:a58b:0:b0:391:1570:b6c6 with SMTP id
 38308e7fff4ca-396d07f0a62mr20909731fa.2.1780737630144; 
 Sat, 06 Jun 2026 02:20:30 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be11esm29306311fa.27.2026.06.06.02.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 02:20:28 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>
Subject: [PATCH] target/i386: helper_sysret(): Check that RCX contains a
 canonical address when emulating an Intel CPU
Date: Sat,  6 Jun 2026 19:20:12 +1000
Message-ID: <20260606092022.67929-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Jun 2026 09:47:42 -0400
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

Intel and AMD CPUs implement SYSRETQ instruction differently.
One of these differences is whether a canonicality check of the address that
will be loaded to RIP is performed: Intel CPUs do this check, AMD CPUs don't.

Currently, QEMU does not perform this check when emulating Intel CPUs.
This patch corrects this by implementing the canonlicality check on a new RIP
value from RCX and performing it only when emulating Intel CPUs.

Flags and segment registers' caches are updated only after checking the new RIP
value to ensure that CPU state is not modified in case the #GP(0) exception
is raised due to the check failure.

Cc: qemu-devel@nongnu.org,
    Paolo Bonzini <pbonzini@redhat.com>,
    Richard Henderson <richard.henderson@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3223
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
---
 target/i386/tcg/seg_helper.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 58aac72011..d5c174b7fd 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1096,17 +1096,22 @@ void helper_sysret(CPUX86State *env, int dflag)
     selector = (env->star >> 48) & 0xffff;
 #ifdef TARGET_X86_64
     if (env->hflags & HF_LMA_MASK) {
-        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
-                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
-                        NT_MASK);
         if (dflag == 2) {
+            uint64_t new_rip = env->regs[R_ECX];
+            if (IS_INTEL_CPU(env)) {
+                int shift = (get_pg_mode(env) & PG_MODE_LA57) ? 56 : 47;
+                int64_t sext = (int64_t)new_rip >> shift;
+                if (sext != 0 && sext != -1) {
+                    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+                }
+            }
             cpu_x86_load_seg_cache(env, R_CS, (selector + 16) | 3,
                                    0, 0xffffffff,
                                    DESC_G_MASK | DESC_P_MASK |
                                    DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                    DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK |
                                    DESC_L_MASK);
-            env->eip = env->regs[R_ECX];
+            env->eip = new_rip;
         } else {
             cpu_x86_load_seg_cache(env, R_CS, selector | 3,
                                    0, 0xffffffff,
@@ -1120,6 +1125,10 @@ void helper_sysret(CPUX86State *env, int dflag)
                                DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
                                DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                DESC_W_MASK | DESC_A_MASK);
+
+        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
+                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
+                        NT_MASK);
     } else
 #endif
     {
-- 
2.53.0


