Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAC5C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4u8-00057b-OC; Fri, 14 Mar 2025 09:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u5-00056Q-Mm
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u3-00012O-TF
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1172125f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958202; x=1742563002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fHuKfDxA2I3IuqcU9csI6nL0wPvBFIcds8Iwt3qt8Yw=;
 b=rQAzfUs2cahyizvg7F6shx28kr3tGO2z8YxGII8xMwfNpHQEyaeBRBx/eVJVJMWt7I
 dxju8zTSw0s01wXc4IYE8Ty6opTvIHkD4jYOjgNMIJl7ifQrIvCjs2WxnzeWujqhkjRJ
 WByWQB7bayWTE7eaV7Crl6B9ZjyqX+gO8glkOYCV400rBC+src12W6fEWgmPA1K2os3b
 0ExWOuSgUqlvaZwdKU8wMU2I6dOAlE01Uq4+k7SKSWh3m2dlrUag3K3ONl89Mxb7+ySD
 cJDvSSxOct9KIgMdzcL53bQIOUSKxKKVKE1H85z4eK5ia4C3Sm5IFXooXKaZeFm5+Pcz
 lVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958202; x=1742563002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHuKfDxA2I3IuqcU9csI6nL0wPvBFIcds8Iwt3qt8Yw=;
 b=nAGyEXcfRCgH4idGZwFh6Ik7AcYgOIPDn3BtaItlfp06ELvAC0xsD87QNGGoPh6a50
 ziTJ8x4ivAzc5yo3KqIPoj0anNwDET7Z0dp3bu8xOZ4ebNJQ53IesY3DuJvZoY75rpGf
 xVCxwvRqnyfU9cW8azIprAiFUK27m5i4qHmir68ol9l9JMQiva1ko6yoDIVTbCsnzCLa
 alxuSaUt0bMUEw1l4Roz3pFFMpasps30CRELkLZpXDFItSpzdu9QMTVDxsFLKCt3wR7t
 QWkBNUs8Xv9U0tHvUhN8Fh+sMFrRqk8/7+1gJsJ8Ofg0hNxalDR5cjXDloCm5gEh15NL
 6r7w==
X-Gm-Message-State: AOJu0Yy+BlsPsc+foARCW7/842pSP92kXyvLBSdeukEFjk+cHmAytqEN
 C+8ocDG9WcizYAZycnKSbsWNxXD1LjPFWWa7aazmwr8K3IU3PAQzKcRueFyvL24r/TwEkvIczwi
 S
X-Gm-Gg: ASbGncvZtgqJ6cbTbZmX6GPfXE7azEDjmKz12X+ftcdCY7J2j6psyIL7xseiZolKbfi
 ckTYk53/X0nB7CtG0i1tS2PjoOSPHLg3lFZr+3n4Q91GOW1VaGgd1E2VqmTeiMDEdOmLkih54Qy
 HKvGGQq67jSm0eArGjxXZZLPjRJBckGncOT5hzNCZAdkNTH44EZJI7yq90z4AVjF+6lcL1MoM87
 60rdH6ZQdpmZBvDa7+U4tRrMJxqth2Ed+WdZ3y+gzm7/P7eVFwnmk3uIQW/L2I26Aa6OJi4Ovxt
 EUN307Mk6IozICatV+M9mIIwiXWL0oag8ZuupwjtRX6qHR0/tYs=
X-Google-Smtp-Source: AGHT+IF19bRrakaQAXt+EtN/2G3jfmNnfJUo5GSSDvCVFZ6KjW/OpwprXQdP8jVdpzQlqnFMNs/NHg==
X-Received: by 2002:a5d:64ac:0:b0:390:f45e:c84a with SMTP id
 ffacd0b85a97d-39720e3c861mr3390466f8f.48.1741958201681; 
 Fri, 14 Mar 2025 06:16:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] target/arm: Un-inline access_secure_reg()
Date: Fri, 14 Mar 2025 13:16:22 +0000
Message-ID: <20250314131637.371866-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
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

We would like to move arm_el_is_aa64() to internals.h; however, it is
used by access_secure_reg().  Make that function not be inline, so
that it can stay in cpu.h.

access_secure_reg() is used only in two places:
 * in hflags.c
 * in the user-mode arm emulators, to decide whether to store
   the TLS value in the secure or non-secure banked field

The second of these is not on a super-hot path that would care about
the inlining (and incidentally will always use the NS banked field
because our user-mode CPUs never set ARM_FEATURE_EL3); put the
definition of access_secure_reg() in hflags.c, near its only use
inside target/arm.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        | 12 +++---------
 target/arm/tcg/hflags.c |  9 +++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15d3a79b0af..12d2706f2b5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2668,21 +2668,15 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
     return aa64;
 }
 
-/* Function for determining whether guest cp register reads and writes should
+/*
+ * Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
  * operating in AArch32 state, the NS-bit determines whether the secure
  * instance of a cp register should be used. When EL3 is AArch64 (or if
  * it doesn't exist at all) then there is no register banking, and all
  * accesses are to the non-secure version.
  */
-static inline bool access_secure_reg(CPUARMState *env)
-{
-    bool ret = (arm_feature(env, ARM_FEATURE_EL3) &&
-                !arm_el_is_aa64(env, 3) &&
-                !(env->cp15.scr_el3 & SCR_NS));
-
-    return ret;
-}
+bool access_secure_reg(CPUARMState *env);
 
 uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure);
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 9e6a1869f94..8d79b8b7ae1 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -63,6 +63,15 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
 #endif
 }
 
+bool access_secure_reg(CPUARMState *env)
+{
+    bool ret = (arm_feature(env, ARM_FEATURE_EL3) &&
+                !arm_el_is_aa64(env, 3) &&
+                !(env->cp15.scr_el3 & SCR_NS));
+
+    return ret;
+}
+
 static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
                                            ARMMMUIdx mmu_idx,
                                            CPUARMTBFlags flags)
-- 
2.43.0


