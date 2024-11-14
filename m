Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EF8D68B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBdBw-00048i-OL; Thu, 14 Nov 2024 11:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tBdBa-0003mY-Qw; Thu, 14 Nov 2024 11:59:16 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tBdBZ-0002lP-9S; Thu, 14 Nov 2024 11:59:14 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539e4b7409fso786482e87.0; 
 Thu, 14 Nov 2024 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731603550; x=1732208350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OjqNSEAeDqZHUwaEAq62cXj/YVXs2ncKcqAnAF2TK3M=;
 b=ApNjciHF1H96EaU0+SbiC8Pm7QennBIQbXUOTYWbJqrFkEbwEvvbxh6Nz21H5U+h7A
 VemdhCaNCbNHgLiyPQJ+kuow6KiKgRjUz6hrjUYwvUrmeOymUGUAfTokeeeJqFo+ygu9
 wFdE46qdQw1Xe6O6aiD+zr/SckrQaE8eIy+iNjnwbDidTskdQb9pI9Npdh0Ou0ACG+Xq
 JOoEjMw1d3UJFpaRj24YjlqCh9MzJa5yGHPkCAMzgLJmYOW4IdH2En2EVjW3TsIuMV9N
 Un3/S7QxePG/xyf0y0cFEGv1aOToVA3ur+EfIaUM2+4gCWWnyDAP71CyeMWmyPosLSMe
 FGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731603550; x=1732208350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OjqNSEAeDqZHUwaEAq62cXj/YVXs2ncKcqAnAF2TK3M=;
 b=iMTNjSoNTMS7GNMEJ4wml1BOhB4LY7SKE8NkUMm9cDaNXgkUhp5MibIpTgag8I3XPJ
 zyYRqHZKl69SYxWKRKYJp8vwFeIW3YQwo82V/5sx3Ak+ZSMJ7q1eS+27W1I1JdLBqwTo
 8Ca7HOA+JslaPkaZy75Cy1ICq4WbqTqPxfS5IC9bVxFhXxfTwDxw/nibXajiqKgOyHkc
 9CWxONQtL5bL+8osb8cx/K4qiKmw+1yjzxyjdUZO1wp6HcRx+pakQlBenfWOYqoi7oaO
 IVOiRiyocu+0KAzlcnPhL3tkLyXBE0+FUlaLrK3aYTqnY5YU8Dt0S8QJRib4jhX1FVu+
 UYoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpyeaSG96u1ouilesuKcE9is16hxfIdF5XhuNJN4xKJV3o0JR0onA5LU+S6oTWC0vwwR2LuS04jKDN@nongnu.org
X-Gm-Message-State: AOJu0YwzjOUZTXzUmQ0sCOk5l1PRHL3/F6e9t4g0Qv7j86yZN8cszm+4
 Bo5vJ6mENk8F/+rgRa2TnO6NK6v0p/7LqTdU87lFrlXm9ql0LAeG
X-Google-Smtp-Source: AGHT+IG47TayMCK6l/AZ0pwBoivKfYWsYDhm11RjHii9fE03tvtnpnGzrOI4UUXXKJfIhjhOZXNbFg==
X-Received: by 2002:a05:6512:3da4:b0:53d:a550:1efa with SMTP id
 2adb3069b0e04-53da5501f63mr1123684e87.11.1731603549524; 
 Thu, 14 Nov 2024 08:59:09 -0800 (PST)
Received: from fedora.. ([2a00:1370:8180:90b:6639:2dc0:6fb5:8401])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da64f2a33sm243453e87.16.2024.11.14.08.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:59:07 -0800 (PST)
From: Pavel Skripkin <paskripkin@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 1/2] arm/ptw: factor out wxn logic to separate functions
Date: Thu, 14 Nov 2024 19:59:00 +0300
Message-ID: <20241114165900.6399-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=paskripkin@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The next patch will add support for WXN for short descriptor format. To
prevent code duplication, wxn logic was factored out to separate
functions.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 target/arm/ptw.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9849949508..2a3933adec 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1130,6 +1130,26 @@ do_fault:
     return true;
 }
 
+static bool arm_has_wxn(CPUARMState *env)
+{
+    /* TODO have_wxn should be replaced with
+     *   ARM_FEATURE_V8 || (ARM_FEATURE_V7 && ARM_FEATURE_EL2)
+     * when ARM_FEATURE_EL2 starts getting set. For now we assume all LPAE
+     * compatible processors have EL2, which is required for [U]WXN.
+     */
+    return arm_feature(env, ARM_FEATURE_LPAE);
+}
+
+static bool arm_wxn_enabled(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    return arm_has_wxn(env) && (regime_sctlr(env, mmu_idx) & SCTLR_WXN);
+}
+
+static bool arm_uwxn_enabled(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    return arm_has_wxn(env) && (regime_sctlr(env, mmu_idx) & SCTLR_UWXN);
+}
+
 static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
                              uint32_t address, MMUAccessType access_type,
                              GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
@@ -1370,8 +1390,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     ARMCPU *cpu = env_archcpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
     int prot_rw, user_rw;
-    bool have_wxn;
-    int wxn = 0;
+    int wxn = arm_wxn_enabled(env, mmu_idx);
 
     assert(!regime_is_stage2(mmu_idx));
 
@@ -1432,18 +1451,6 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
             g_assert_not_reached();
         }
     }
-
-    /* TODO have_wxn should be replaced with
-     *   ARM_FEATURE_V8 || (ARM_FEATURE_V7 && ARM_FEATURE_EL2)
-     * when ARM_FEATURE_EL2 starts getting set. For now we assume all LPAE
-     * compatible processors have EL2, which is required for [U]WXN.
-     */
-    have_wxn = arm_feature(env, ARM_FEATURE_LPAE);
-
-    if (have_wxn) {
-        wxn = regime_sctlr(env, mmu_idx) & SCTLR_WXN;
-    }
-
     if (is_aa64) {
         if (regime_has_2_ranges(mmu_idx) && !is_user) {
             xn = pxn || (user_rw & PAGE_WRITE);
@@ -1455,10 +1462,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
             if (is_user) {
                 xn = xn || !(user_rw & PAGE_READ);
             } else {
-                int uwxn = 0;
-                if (have_wxn) {
-                    uwxn = regime_sctlr(env, mmu_idx) & SCTLR_UWXN;
-                }
+                int uwxn = arm_uwxn_enabled(env, mmu_idx);
+
                 xn = xn || !(prot_rw & PAGE_READ) || pxn ||
                      (uwxn && (user_rw & PAGE_WRITE));
             }
-- 
2.46.0


