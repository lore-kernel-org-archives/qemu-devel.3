Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C680CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfc-00088T-Bu; Tue, 29 Sep 2026 06:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfK-0007d2-7M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:28 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfI-0008GF-15
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:25 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so2415244f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676143; x=1791280943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sLwGhsAhnQ1hR2aRiWts4FnTUYr8rzSUb6aL3HPnY5s=;
 b=inglY8QzKJJNyMjgSP8w3FrKdKrJzXxC/+V7fusZSUXGiqh1oBW4ug2cmFverxhRNs
 LvC7VsreDXRWFVEMar8lHUvyXf1dRdL7I3SgvgDcROZYVYB/h8CJUMcC4ti/eUq13s+3
 21u9iopNHctACVhdu/5OijV5TrnIATI5C3o5fVg/fy7VRPFZtSllJSXEmbCmPpG5C3vc
 5yWChX6MvJJaOBDN1xD1h6lvVENyECZj01P5ZAkQlACbNgQIh5YD3WiIpFFlcOU0mo/w
 XKbUQZ5svB/45oEpF5ahaMtGdTI+FGwVJAwbasYUZNsT+6IHxAKnAhtxocOZ6CpIcgG4
 hmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676143; x=1791280943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sLwGhsAhnQ1hR2aRiWts4FnTUYr8rzSUb6aL3HPnY5s=;
 b=U+7YOdSlM8zo+tVykjtawjhHD1BHzf8GSAUrO2x2KaynkwgcrlyGNvivm7tTAzn/FO
 nzRQzwEsZbbOdVI8E8Rcwx9qIfSrXZYATGPRikcdclnopR+BXu0Np83+k5SuO83y4xpb
 6plXpG7Ab5C4FUk2nc3t9x2cgHeDliWub59uNBs4bHOsxfbcEMeN5j/1lGItPzP4tyON
 R3E4aqStsZSchZ+XSTXiiunp0WDOPDHmIA25pXqnSoZIvhnNyqt9nk3VUBcUjgvh7bcR
 R/eBGSrJNwJG73msmIisp2/CUdoLEqfsGFdhuin0vpFkQ8dR7CH06g13nTXFpJNOOipm
 3tQA==
X-Gm-Message-State: AFq9FYLkUlX7ATcAzmyVrEIKzSrgaI85HcIoF/Jxmu1d7rw/o3c7TTZd
 c3wB7TsF1iEvrfPkhhgYifApLcy6DeOnrl5g0nv7SI0VbL3NYnEXwzFp1ux6HKC7lp5qFSfqJzC
 JdcxQ
X-Gm-Gg: AYBFou2R9WXZqCbGX81EjWCgJ+kmkbg4aG5JbDl9FUUDMXWRPPhkREVAnee/cxwgeR7
 4SEV0fbf6QfDQJB0fQnn2UThmKoGv9l9Y2gWp3HbMIa5XXLqFbN2DeDQT/lObz8ZnnATAV3Zx0X
 tc71SKuSYskTcQfjvhHdDoXMxxedEACHBubonHA6wR6Qs67iOgPFM6qX6rOYPiDrpIV8sQYF2jR
 ZyDfsdrFnlCKhRwJRmd7IyQo3w3XfxvaYfVYdfFNZCyvN2Vp9nMUCq7qRnmlOhkquj3Pgpv5MNr
 Ux1yAzjHfFPOlbZZeX64uBKgsWJqQwgmT60zNUeRNzf9qniKL+2GdT6iS3PPOqzxMkrZzahphT6
 DHDm0F+24smq4woTzAYOboLP6WluQxKl2GMOiSeP0LiU+pF/upWWAgjC54Bwk3V+ZyArkAzJUHz
 LdFBRY4gi32ovCPv45ItbTr6A++XdAmT4mlJNT4sdxrEeU0IMfBdBKKx/4A+JuhrLnCYTCQEDTv
 OnWoAOlfG+/SzL0A2NoDLq1B0a6gTbPqytg4Ln4DT95atPetSwHx0V/e5o/831u03FpwSVzTQGZ
 EnTt/a9BuLnFfw==
X-Received: by 2002:a05:6000:178c:b0:485:8ee5:5ffa with SMTP id
 ffacd0b85a97d-48871703b57mr28484111f8f.38.1790676142468; 
 Tue, 29 Sep 2026 03:02:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/37] target/arm: Read and write PSTATE.UINJ
Date: Tue, 29 Sep 2026 11:01:26 +0100
Message-ID: <20260929100133.2598676-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

With FEAT_UINJ, allow PSTATE.UINJ to be set from aa64 and aa32 modes.
Read the value back for SPSR_ELx from aa32 mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260925215004.456336-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c    | 13 +++++++++++--
 target/arm/internals.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f843f281fcd..9a90ab68071 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9523,8 +9523,9 @@ uint64_t cpsr_read_for_spsr_elx(CPUARMState *env)
         ret &= ~CPSR_DIT;
         ret |= PSTATE_DIT;
     }
-    /* Merge PSTATE.SS into SPSR_ELx */
-    ret |= env->pstate & PSTATE_SS;
+
+    /* Merge PSTATE.{SS,UINJ} into SPSR_ELx */
+    ret |= env->pstate & (PSTATE_SS | PSTATE_UINJ);
 
     return ret;
 }
@@ -9533,6 +9534,14 @@ void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val)
 {
     uint32_t mask;
 
+    /* Save SPSR_ELx.UINJ into PSTATE. */
+    if (unlikely(val & PSTATE_UINJ)
+        && arm_feature(env, ARM_FEATURE_AARCH64)
+        && cpu_isar_feature(aa64_uinj, env_archcpu(env))) {
+        env->pstate |= PSTATE_UINJ;
+        val &= ~PSTATE_UINJ;
+    }
+
     /* Save SPSR_ELx.SS into PSTATE. */
     env->pstate = (env->pstate & ~PSTATE_SS) | (val & PSTATE_SS);
     val &= ~PSTATE_SS;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 843e12487ec..c41fa5225c7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1392,6 +1392,9 @@ static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
     if (isar_feature_aa64_nmi(id)) {
         valid |= PSTATE_ALLINT;
     }
+    if (isar_feature_aa64_uinj(id)) {
+        valid |= PSTATE_UINJ;
+    }
 
     return valid;
 }
-- 
2.43.0


