Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA495C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9h8-000200-Ga; Fri, 01 Mar 2024 15:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h6-0001yz-NI
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:24 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h5-0006zk-3b
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:24 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso2048025a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709325681; x=1709930481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Kev1JbGsH8SPuVfwyjwv2zI6xwvmoOl1CfSqGhDN5g=;
 b=AD0X293sR33vul23ICEgKF0ZARYgH6FiQECEvBIRq98p45Ug5WG8Ts9ftxF4Wplmqg
 JiyZ12OTPent3DOId430dDaH2kIO7dqOpU4qzGXjglc9kXwI1HUIS9FsQiyDp8J6PVPn
 sc3tPu5alDsLE15z9bDpcFN4LXgWcKDn5bHzCMhh2Kjn16BPUJKYrBH9pMSWWcpIKLD+
 B6b1cLohHaXTvL8epL4y9y/hkn5OJVinhqi8d7O36yEWH3ofY0r7Cmj7xsdhatBxSFLn
 +TFc71oY+1qeBo1Hz5xMAhMkEblR72cQBDocFgMp2Y+spBynRVy0gZbRcJVFvb0SN5JB
 WuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325681; x=1709930481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Kev1JbGsH8SPuVfwyjwv2zI6xwvmoOl1CfSqGhDN5g=;
 b=Rlv7EVwTRSk0rsmx3KZf2ofIFke0G4Qo3HeqDKJcgKywNZAjLnl7btBFLpI134WnfL
 q2CWFHm8w0tSrWT2UXtms4ZyoUgMCeqDVwjNmgF1K73htneT9hkxZ0j2CBS+LmUtm7Fn
 SP7dXSMt8Ij6gHcGHmM6oiy+5sF6YgNxJE0t4Jqvi5jHRsNlUpWFNmVbwW2uxGOlzfGJ
 m04TEqMAKB1hT15M0XiBhxF9/50MgSMqS0G0xgotX88nP1EixwEhouhynE38i3SGbN0s
 IMatx8CTYSUqEeRUofkQozlzw8R3db0I2Q1ILnVvLkd0y+lan151T/j0jl/0WVmxYNtj
 SN0Q==
X-Gm-Message-State: AOJu0YwqdcAqxf161C+nHhHn2c3m4hHuUUwTa2MstQ81d6FibHQutRLY
 LJiPfWkg9zVgp4FW751YfbsvMccIu6yj5Rp1+yFiZ/TnDji+kXw9+chDtBimWPP+8c72M/MSxQt
 S
X-Google-Smtp-Source: AGHT+IHU5POW27FZ8Fo1Kq7j28DoKXd6/4y2eT83rpvvocbH+cIbsuGFpHV0gh+M9vfQlzNshhu1Pw==
X-Received: by 2002:a17:90a:4a0e:b0:29b:1073:c038 with SMTP id
 e14-20020a17090a4a0e00b0029b1073c038mr2745323pjh.32.1709325680787; 
 Fri, 01 Mar 2024 12:41:20 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a17090ac58300b0029b2e00359esm681947pjt.36.2024.03.01.12.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 12:41:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Idan Horowitz <idan.horowitz@gmail.com>
Subject: [PATCH v3 5/6] target/arm: Do memory type alignment check when
 translation disabled
Date: Fri,  1 Mar 2024 10:41:09 -1000
Message-Id: <20240301204110.656742-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301204110.656742-1-richard.henderson@linaro.org>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If translation is disabled, the default memory type is Device, which
requires alignment checking.  This is more optimally done early via
the MemOp given to the TCG memory operation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/hflags.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8e5d35d922..5da1b0fc1d 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -26,6 +26,35 @@ static inline bool fgt_svc(CPUARMState *env, int el)
         FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR], HFGITR_EL2, SVC_EL1);
 }
 
+/* Return true if memory alignment should be enforced. */
+static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
+{
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
+    /* Check the alignment enable bit. */
+    if (sctlr & SCTLR_A) {
+        return true;
+    }
+
+    /*
+     * If translation is disabled, then the default memory type is
+     * Device(-nGnRnE) instead of Normal, which requires that alignment
+     * be enforced.  Since this affects all ram, it is most efficient
+     * to handle this during translation.
+     */
+    if (sctlr & SCTLR_M) {
+        /* Translation enabled: memory type in PTE via MAIR_ELx. */
+        return false;
+    }
+    if (el < 2 && (arm_hcr_el2_eff(env) & (HCR_DC | HCR_VM))) {
+        /* Stage 2 translation enabled: memory type in PTE. */
+        return false;
+    }
+    return true;
+#endif
+}
+
 static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
                                            ARMMMUIdx mmu_idx,
                                            CPUARMTBFlags flags)
@@ -121,8 +150,9 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
 {
     CPUARMTBFlags flags = {};
     int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
 
-    if (arm_sctlr(env, el) & SCTLR_A) {
+    if (aprofile_require_alignment(env, el, sctlr)) {
         DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
     }
 
@@ -223,7 +253,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     sctlr = regime_sctlr(env, stage1);
 
-    if (sctlr & SCTLR_A) {
+    if (aprofile_require_alignment(env, el, sctlr)) {
         DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
     }
 
-- 
2.34.1


