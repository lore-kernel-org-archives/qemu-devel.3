Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD76C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIO9-0000Ox-MF; Tue, 04 Feb 2025 07:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINj-0008Lz-8m
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINf-0002Aw-DD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso39332375e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673417; x=1739278217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C04XmL9mrmAcsBNUPKjSrw0Pg8WQ3LqYabnkNL2Gl8=;
 b=i8GhZJ1kmvc+mfHTJAe4NsUJQKxmLHqfT79ggogPZM9xx261aU+X349hJANXjEJwCX
 5Q7DoXsAyClj6Ja4XI9PDpdMS1YmZrDN6UbbTX2IbVivS6kn3fo3Xf7k6CgcZ7vPBKZG
 ivQ4ryx1MuZ0pEWOX6PvxEFMYQ52d4lF1XE1NVEZayo89VA+IlWeyu5BQAt/efm3adPl
 2JF86W/lYMu6RZdV0dNG0pthdusmihDTaLcXdxDjW92D3njPR0qpB2bUiflNgd/JiLrx
 J4TarOdhLOrzU0K1mpgq7takp3nuLVjuzjq+dJCVUbEiZdNUt+nqLq4JjrL6zyqTiiHy
 bZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673417; x=1739278217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5C04XmL9mrmAcsBNUPKjSrw0Pg8WQ3LqYabnkNL2Gl8=;
 b=ndoQwgPC7NycoTZGPVqtcLsJGaARjooyBW9WWT+62e5Qeg5ILuPRD/Eu7w2r42AGHv
 hLdoCrj4xFPBKh2Xqs3hL4+gIFgB6WjHpWoIqCUSFwIMoDh/BNXy1qljZe/HVdMBVgAs
 T2oQqz8by7inu1nlwCXZ3pR7D7L9pZswh1mnVU0npxd5mZVRrRj3PCHuKKqTdk+AQqpp
 fY5bhsfJiF0YAM9Q2zksiCF+3xmuLjMnXxCzso73p/sDcOxnZ7/nmN2he8GqU26gKbfa
 7o6wgB/sItwrCWCPqKyFnkLvj6ZIdzT4q8z6fAl+f8tFv65jNsa91OIChYoL4Jy4jvVr
 BW8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjq1QhtD6ZQk2diPjik/LGOXXykqY/F2U+6ZuIu0NAfDTVGZ+zUfFOafUiLMFZ93bkm7B1+9wybICk@nongnu.org
X-Gm-Message-State: AOJu0Yx9LGuX00TR2DjiI97NknVHfA9Vuvt8gw3umbLasB32fXyJPeHS
 RXJ2eEOY3yJ/Cb1BoUTCPbA0GlNs7tek/C/XC/jxqpCOmuiRId+7dEuF0ukOVPY=
X-Gm-Gg: ASbGncvPEnHlhV9QSncuxF8bBQHgZVZ0kRfXVPqLszLf+A70u0kYHJ0LN/aVON97ylD
 X1BkVLIzovic6divZ4fzsW0Rid4MaoV6OVxMg7lgXDF20REV5JCOxL4RSfAbcLIWh4WZMlkbQ54
 hJCx3xs1rXOuXjWEnLUOr437PLcs70F4NKjHd3pFwdxoc3mmGF5AouuM+Nc7tjKj0C/Mg7zjcit
 sIaBNOibbQkU59Sq7sPLWPTm+kPBh6N3dxxSgaZBLV2NEw6AVyyFqONZ6r1G2W5NeNWjfHRybeU
 CSs1GQ7qVEeO4PywHGZMvg==
X-Google-Smtp-Source: AGHT+IFTiu0seO05C8kwhRsYHHQD9uUyjtaNp+TDBCnSSssLSG+GsXUf1yfFb2Zw0XJaLudjMtU2nw==
X-Received: by 2002:a5d:5f44:0:b0:385:e411:c894 with SMTP id
 ffacd0b85a97d-38c520938eemr24335837f8f.43.1738673416878; 
 Tue, 04 Feb 2025 04:50:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 5/9] target/arm: Refactor handling of timer offset for
 direct register accesses
Date: Tue,  4 Feb 2025 12:50:05 +0000
Message-Id: <20250204125009.2281315-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

When reading or writing the timer registers, sometimes we need to
apply one of the timer offsets.  Specifically, this happens for
direct reads of the counter registers CNTPCT_EL0 and CNTVCT_EL0 (and
their self-synchronized variants CNTVCTSS_EL0 and CNTPCTSS_EL0).  It
also applies for direct reads and writes of the CNT*_TVAL_EL*
registers that provide the 32-bit downcounting view of each timer.

We currently do this with duplicated code in gt_tval_read() and
gt_tval_write() and a special-case in gt_virt_cnt_read() and
gt_cnt_read().  Refactor this so that we handle it all in a single
function gt_direct_access_timer_offset(), to parallel how we handle
the offset for indirect accesses.

The call in the WFIT helper previously to gt_virt_cnt_offset() is
now to gt_direct_access_timer_offset(); this is the correct
behaviour, but it's not immediately obvious that it shouldn't be
considered an indirect access, so we add an explanatory comment.

This commit should make no behavioural changes.

(Cc to stable because the following bugfix commit will
depend on this one.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h     |   5 +-
 target/arm/helper.c        | 103 +++++++++++++++++++------------------
 target/arm/tcg/op_helper.c |   8 ++-
 3 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 863a84edf81..b4b3d196191 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1819,9 +1819,10 @@ int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type);
 uint64_t gt_get_countervalue(CPUARMState *env);
 /*
  * Return the currently applicable offset between the system counter
- * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
+ * and the counter for the specified timer, as used for direct register
+ * accesses.
  */
-uint64_t gt_virt_cnt_offset(CPUARMState *env);
+uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx);
 
 /*
  * Return mask of ARMMMUIdxBit values corresponding to an "invalidate
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 01ca222903d..c021c237b9b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2455,14 +2455,6 @@ static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
     return 0;
 }
 
-static uint64_t gt_phys_cnt_offset(CPUARMState *env)
-{
-    if (arm_current_el(env) >= 2) {
-        return 0;
-    }
-    return gt_phys_raw_cnt_offset(env);
-}
-
 static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
 {
     /*
@@ -2489,6 +2481,52 @@ static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
     }
 }
 
+uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx)
+{
+    /*
+     * Return the timer offset to use for direct accesses to the
+     * counter registers CNTPCT and CNTVCT, and for direct accesses
+     * to the CNT*_TVAL registers.
+     *
+     * This isn't exactly the same as the indirect-access offset,
+     * because here we also care about what EL the register access
+     * is being made from.
+     *
+     * This corresponds to the access pseudocode for the registers.
+     */
+    uint64_t hcr;
+
+    switch (timeridx) {
+    case GTIMER_PHYS:
+        if (arm_current_el(env) >= 2) {
+            return 0;
+        }
+        return gt_phys_raw_cnt_offset(env);
+    case GTIMER_VIRT:
+        switch (arm_current_el(env)) {
+        case 2:
+            hcr = arm_hcr_el2_eff(env);
+            if (hcr & HCR_E2H) {
+                return 0;
+            }
+            break;
+        case 0:
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                return 0;
+            }
+            break;
+        }
+        return env->cp15.cntvoff_el2;
+    case GTIMER_HYP:
+    case GTIMER_SEC:
+    case GTIMER_HYPVIRT:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2561,34 +2599,14 @@ static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - gt_phys_cnt_offset(env);
-}
-
-uint64_t gt_virt_cnt_offset(CPUARMState *env)
-{
-    uint64_t hcr;
-
-    switch (arm_current_el(env)) {
-    case 2:
-        hcr = arm_hcr_el2_eff(env);
-        if (hcr & HCR_E2H) {
-            return 0;
-        }
-        break;
-    case 0:
-        hcr = arm_hcr_el2_eff(env);
-        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
-            return 0;
-        }
-        break;
-    }
-
-    return env->cp15.cntvoff_el2;
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_PHYS);
+    return gt_get_countervalue(env) - offset;
 }
 
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    return gt_get_countervalue(env) - offset;
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2609,16 +2627,7 @@ static uint64_t do_tval_read(CPUARMState *env, int timeridx, uint64_t offset)
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = 0;
-
-    switch (timeridx) {
-    case GTIMER_VIRT:
-        offset = gt_virt_cnt_offset(env);
-        break;
-    case GTIMER_PHYS:
-        offset = gt_phys_cnt_offset(env);
-        break;
-    }
+    uint64_t offset = gt_direct_access_timer_offset(env, timeridx);
 
     return do_tval_read(env, timeridx, offset);
 }
@@ -2636,16 +2645,8 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = 0;
+    uint64_t offset = gt_direct_access_timer_offset(env, timeridx);
 
-    switch (timeridx) {
-    case GTIMER_VIRT:
-        offset = gt_virt_cnt_offset(env);
-        break;
-    case GTIMER_PHYS:
-        offset = gt_phys_cnt_offset(env);
-        break;
-    }
     do_tval_write(env, timeridx, value, offset);
 }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 02c375d196d..30786fd1ff4 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -427,7 +427,13 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
     int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
-    uint64_t offset = gt_virt_cnt_offset(env);
+    /*
+     * We want the value that we would get if we read CNTVCT_EL0 from
+     * the current exception level, so the direct_access offset, not
+     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
+     * which calls VirtualCounterTimer().
+     */
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
     uint64_t cntvct = cntval - offset;
     uint64_t nexttick;
 
-- 
2.34.1


