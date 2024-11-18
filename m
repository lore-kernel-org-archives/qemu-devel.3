Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61701D49231
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3dh-0003Cw-OZ; Mon, 18 Nov 2024 10:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tD3dM-0002z5-TG; Mon, 18 Nov 2024 10:25:49 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tD3dL-0004bl-42; Mon, 18 Nov 2024 10:25:48 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539f84907caso4703332e87.3; 
 Mon, 18 Nov 2024 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731943544; x=1732548344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K12m86+3CyNiSslbgGmodn9GxajRPUsJHFARu9nTIbs=;
 b=KKs9ItxnvZdyOZ87T1m1HJ5m/tHkyDjcuEeXNzAzUGap41RNz0vuUeSQUEmOxctjOs
 cEYCMjIjbpYdn8tWwBz7OhYyp/AD9O1yN+YrcMscV7Uzp9nXVPzYHBLbQzAdpRyjjUl0
 dkS2CfU2qQq22kKGJV6qzV/5jImTjBa/sPITyiH7nnJWU4cOVQuEDHDtBPqq0FsiIYBU
 kg0V0+D5/NPnat55kYyHs4eN5pXTKWKH34FAvqyB1kjL+4Cpq0PflVLZ3SEXAqbb4bYu
 /Bim2BXoA3W13yj5ZTirDll8mJZIpn89Qlsh+O2H8FBRs3wIc6Iacyotj8oGbuBMhhnZ
 CruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731943544; x=1732548344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K12m86+3CyNiSslbgGmodn9GxajRPUsJHFARu9nTIbs=;
 b=P6KFzkydclzcMy+iNlJf9+jNbdjrwOEMNFO6eHdno2P1NVtxik3Nc2G9lE+SW3u6qx
 VQlTeO3xkhqCLMVwR9DtRcyfEVZT/iEdotUtd5JXjq69bLE8DxQ9Az7FilEmeWjXLy2C
 +31Gy0LzjvkllvF/yYDbfrISFi+2xw/i7S/eOYxwYgvfOkUQhFizdVEe8rIsj/CCc5L3
 VHyNyhHBI00shi9cFaczyfJYNGagNLt+fEHcI6xzFmpTWG6FXZKNpdCA3fEgmi8bwWIy
 sBoowPoqD4HvNVmL1gyT3q/hgwHPm0RmZ2Wam1XpoHzYOQv/ryrLdQrqubjAVC5FPAtJ
 2kiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYPeHdJ3GOd1D882OM1PS7+yOdHkyCoPXkxMNF/H+Ehu3392YDt6XF0/ofvCJ3cChxgLQOEHzjI/a+@nongnu.org
X-Gm-Message-State: AOJu0YzPu+UhBD+ArIYm/kHFhoBxyH4OIlqeS2I0oCj0bgKcuC4d3xDT
 JRHFFTBVg2La+ATWGo1O996EGJUtV+Uh+0isN8RNnyPVFS9yKTBYJ/xnh75b
X-Google-Smtp-Source: AGHT+IHPZQzFW4/Pmb0XMu/cvXX4HEwrkzr4C1vjMx7TPy+cS5LhF7VfNrop9chbt4QdzXmnT+Qn9w==
X-Received: by 2002:a05:6512:224b:b0:539:e776:71f7 with SMTP id
 2adb3069b0e04-53dab3b0843mr4984525e87.37.1731943543709; 
 Mon, 18 Nov 2024 07:25:43 -0800 (PST)
Received: from fedora.. ([2a00:1370:8180:90b:d00f:257f:ffb:ac70])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da64f2108sm1654514e87.17.2024.11.18.07.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 07:25:42 -0800 (PST)
From: Pavel Skripkin <paskripkin@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 2/2] arm/ptw: use get_S1prot in get_phys_addr_v6
Date: Mon, 18 Nov 2024 10:25:37 -0500
Message-ID: <20241118152537.45277-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118152507.45046-1-paskripkin@gmail.com>
References: <20241118152507.45046-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=paskripkin@gmail.com; helo=mail-lf1-x136.google.com
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

To share missing SCTRL.{U}WXN and SCR.SIF in short format walker, use
get_S1prot instead of open-coded checks.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 target/arm/ptw.c | 54 +++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 86d6255713..8150410eff 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -85,6 +85,10 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
 
+static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
+                      int user_rw, int prot_rw, int xn, int pxn,
+                      ARMSecuritySpace in_pa, ARMSecuritySpace out_pa);
+
 /* This mapping is common between ID_AA64MMFR0.PARANGE and TCR_ELx.{I}PS. */
 static const uint8_t pamax_map[] = {
     [0] = 32,
@@ -1148,7 +1152,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
     hwaddr phys_addr;
     uint32_t dacr;
     bool ns;
-    int user_prot;
+    ARMSecuritySpace out_space;
 
     /* Pagetable walk.  */
     /* Lookup l1 descriptor.  */
@@ -1240,16 +1244,18 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
             g_assert_not_reached();
         }
     }
+    out_space = ptw->in_space;
+    if (ns) {
+        /* The NS bit will (as required by the architecture) have no effect if
+         * the CPU doesn't support TZ or this is a non-secure translation
+         * regime, because the attribute will already be non-secure.
+         */
+        out_space = ARMSS_NonSecure;
+    }
     if (domain_prot == 3) {
         result->f.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     } else {
-        if (pxn && !regime_is_user(env, mmu_idx)) {
-            xn = 1;
-        }
-        if (xn && access_type == MMU_INST_FETCH) {
-            fi->type = ARMFault_Permission;
-            goto do_fault;
-        }
+        int user_rw, prot_rw;
 
         if (arm_feature(env, ARM_FEATURE_V6K) &&
                 (regime_sctlr(env, mmu_idx) & SCTLR_AFE)) {
@@ -1259,37 +1265,23 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
                 fi->type = ARMFault_AccessFlag;
                 goto do_fault;
             }
-            result->f.prot = simple_ap_to_rw_prot(env, mmu_idx, ap >> 1);
-            user_prot = simple_ap_to_rw_prot_is_user(ap >> 1, 1);
+            prot_rw = simple_ap_to_rw_prot(env, mmu_idx, ap >> 1);
+            user_rw = simple_ap_to_rw_prot_is_user(ap >> 1, 1);
         } else {
-            result->f.prot = ap_to_rw_prot(env, mmu_idx, ap, domain_prot);
-            user_prot = ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot, 1);
-        }
-        if (result->f.prot && !xn) {
-            result->f.prot |= PAGE_EXEC;
+            prot_rw = ap_to_rw_prot(env, mmu_idx, ap, domain_prot);
+            user_rw = ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot, 1);
         }
+
+        result->f.prot = get_S1prot(env, mmu_idx, false, user_rw, prot_rw, xn, pxn,
+                                    result->f.attrs.space, out_space);
         if (!(result->f.prot & (1 << access_type))) {
             /* Access permission fault.  */
             fi->type = ARMFault_Permission;
             goto do_fault;
         }
-        if (regime_is_pan(env, mmu_idx) &&
-            !regime_is_user(env, mmu_idx) &&
-            user_prot &&
-            access_type != MMU_INST_FETCH) {
-            /* Privileged Access Never fault */
-            fi->type = ARMFault_Permission;
-            goto do_fault;
-        }
-    }
-    if (ns) {
-        /* The NS bit will (as required by the architecture) have no effect if
-         * the CPU doesn't support TZ or this is a non-secure translation
-         * regime, because the attribute will already be non-secure.
-         */
-        result->f.attrs.secure = false;
-        result->f.attrs.space = ARMSS_NonSecure;
     }
+    result->f.attrs.space = out_space;
+    result->f.attrs.secure = arm_space_is_secure(out_space);
     result->f.phys_addr = phys_addr;
     return false;
 do_fault:
-- 
2.47.0


