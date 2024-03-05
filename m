Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5ACC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEv-0001pR-Ih; Tue, 05 Mar 2024 08:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE6-0000yD-NA
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDs-0005yV-Mm
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412cf3c5cdeso27802655e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646767; x=1710251567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J1DzK1oxT+Ly6WdUrENKHs1cSZQkyZRc92vsYauFXPY=;
 b=PtmHBvHsBSYd/ZWwKQsFObyipiJhX2IaPfWR3sPjUreuM12U8nl2vfnHA0mWZ3nfy0
 esEfIX/zACZOyQiyPiMi/iDJR9qkIJo2cWN73CKm5wRHgPqve/wC+pwyRS0vxYpo5jIY
 grWmzAGnHyoEgFluNRYZ40NgTUzzUwae8A4eSYe+WVDBxvuTsD8pxUMNjtNFHLioooQz
 A94m4XkblfXUGLjXVQhMYGuYePisQ0grS9Lp0C2UD9HJGoqu2sG/kWflO8I5vo1+gUj+
 w6543xVXf8m+U/FHCWQ5aIgI0ArfYuEZwewwHeb531PF3kr365Uo4rGwBmJ4UioddU0p
 MafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646767; x=1710251567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1DzK1oxT+Ly6WdUrENKHs1cSZQkyZRc92vsYauFXPY=;
 b=PEKzXJap6S5y6RpXqVsOuRd798P0MVj/w5LVts6ybxtKbP1QupHrPYDzvL6G/rsVqt
 7DVthkYZMFOzIe6MoDvpXN+Fo5twd3vUfWtCONnYRaPB9ajWFssjKibVkgop8NoljKHt
 fDhmYnViij7LBJFzxlmc6WScgG5lOINwPPQcCtfJEdOtath9TeKASS6KFzwwNZz4bAh+
 Y/1n+LKwDvgtIfr0XdbG4y9HXk5nBMJnrLw1PY2W3ZZvnokXmi5FodUZ+s5yoNEIXWs9
 fIK056VqfeSSnVRagF/ClO/bI/WPCGj12jvze4xysKWej0OOb53EB/e2V5/4xVPK2OlA
 vGWA==
X-Gm-Message-State: AOJu0YyDxrqVt7R6uVTpH48LKhpnyOoojdiT6rJ6mLfDL+ObGsZMI9gP
 Pbp77h7/R6SnBB8cOgAXjVH2ZZ40wfAaUlx4dGW22IRZv64UEhMdfRMNsAmwi94+pOjeqXlZXQl
 T
X-Google-Smtp-Source: AGHT+IF2xiwQ8BjRCsLL/QfaZa22vUZOZGBNdw6EvjX5NTQSgcyYmjSKthFYkW2Xj/uxR3DT81hoKQ==
X-Received: by 2002:a05:600c:511e:b0:412:b816:1584 with SMTP id
 o30-20020a05600c511e00b00412b8161584mr8555503wms.32.1709646767331; 
 Tue, 05 Mar 2024 05:52:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
Date: Tue,  5 Mar 2024 13:52:34 +0000
Message-Id: <20240305135237.3111642-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

If translation is disabled, the default memory type is Device, which
requires alignment checking.  This is more optimally done early via
the MemOp given to the TCG memory operation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8e5d35d9227..5da1b0fc1d4 100644
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


