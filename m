Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F27D6DDF1
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 13:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCffe-0006Ak-Oj; Sun, 17 Nov 2024 08:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tCffc-00069i-Km; Sun, 17 Nov 2024 08:50:32 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tCffa-0002I6-Rj; Sun, 17 Nov 2024 08:50:32 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53da3b911b9so2438725e87.2; 
 Sun, 17 Nov 2024 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731851429; x=1732456229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/c3hbRcpnvd9se7nBaaHtOqLgezKzESTCDuZRz+zEik=;
 b=ErcRpUJar5PiYlN0RpNaFNg0GYD6oH9qb9RnV2o8nsr9pWSeW2Xbj0L+hwpxhB4Pek
 xO5anMFeDo99N8qeDKFRdNXh4f/dUIdAPYpHwGxPmVnNei6GCKvD+w0q0q0VOZYWVae2
 oNlH5pntd6+MAiDo/lvE7TSEOAE0TixcStHpWtNlHIr4bitdTzDMa54k7nEAOTWC9MXW
 JKyC6Kv/MPOBc9QMdp1nBV+19qhr9mw95vazPaw81cj8WntpQofTYh41ooWuzU9YprWB
 AamtNYHX4V3HPbOURH/7ihXv4apRn7udKwbHoKAiC02ydhGa6tV9knBkis/YsNUsuaWh
 c20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731851429; x=1732456229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/c3hbRcpnvd9se7nBaaHtOqLgezKzESTCDuZRz+zEik=;
 b=dkIAclqz2fsEj7cB5n2WPr6vbsb+wUwZbPlc9g7pGXa6ZkL7a0UBC0wwWfAbIs0YQA
 5EGN/AKrwsb8hMiH+FEYnaUHMUNe/qmCjlHUqW+RbyEHm6yzP0tXyP0ONLaU+VO2F4yt
 NSw5eYcwZH+Xxi47GfqX+zT5l17zwQ/165NiJ13Zes0CTWF+8XPqvNn0absqk7R3iktb
 KE86PvKuKEUDaCcv55C2cYZ3LR4ymN2jR4GhbLayI4LJYv1ANqUkq722Xala6hk1bwDA
 fAQDfiDjvN//9qWwgk/K6yaSummAacQB9g2CH4ZvxiCYYdpCn+oo83fYL5/r2yrMXAAI
 unNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxoOhT7FYzSRYcyyZ2y0evytssiLWISerRAwRRhoG+Raw0v0f76tpLdMVIS7/48/nZyWwREYVTLKPu@nongnu.org
X-Gm-Message-State: AOJu0YzUGgdc9GClQ1tawXHvLXrLAhAOPLJllwCZ8RxI0LZmsMQevUqs
 SnX6tZMBLU2AMPWPMncH9db1LSNTBw2z/FY93gaHb8mkFm5QRS5BcRGdTGII
X-Google-Smtp-Source: AGHT+IEuGBlMsbCpxpdtZKWoxuWjf8CQ6l8dHtBRFy6ueO39IpVsbi5P2LlDxKaf0lufXlV4ycC6vw==
X-Received: by 2002:a05:6512:239a:b0:539:f7ab:e161 with SMTP id
 2adb3069b0e04-53dab3bf59amr3430659e87.45.1731851428494; 
 Sun, 17 Nov 2024 05:50:28 -0800 (PST)
Received: from fedora.. ([2a00:1370:8180:90b:d00f:257f:ffb:ac70])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da65019ccsm1293764e87.110.2024.11.17.05.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 05:50:27 -0800 (PST)
From: Pavel Skripkin <paskripkin@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 2/2] arm/ptw: use get_S1prot in get_phys_addr_v6
Date: Sun, 17 Nov 2024 08:50:22 -0500
Message-ID: <20241117135022.37508-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117134931.37249-1-paskripkin@gmail.com>
References: <20241117134931.37249-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=paskripkin@gmail.com; helo=mail-lf1-x12c.google.com
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
 target/arm/ptw.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 50eed0f811..0d003a9f7d 100644
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
@@ -1148,7 +1152,6 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
     hwaddr phys_addr;
     uint32_t dacr;
     bool ns;
-    int user_prot;
 
     /* Pagetable walk.  */
     /* Lookup l1 descriptor.  */
@@ -1243,13 +1246,13 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
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
+        int ap_usr;
+        int ap_priv;
+        ARMSecuritySpace out_space = ARMSS_NonSecure;
+
+        /* NS bit is ignored in NWd. */
+        if (result->f.attrs.space == ARMSS_Secure && !ns)
+            out_space = ARMSS_Secure;
 
         if (arm_feature(env, ARM_FEATURE_V6K) &&
                 (regime_sctlr(env, mmu_idx) & SCTLR_AFE)) {
@@ -1259,28 +1262,20 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
                 fi->type = ARMFault_AccessFlag;
                 goto do_fault;
             }
-            result->f.prot = simple_ap_to_rw_prot(env, mmu_idx, ap >> 1);
-            user_prot = simple_ap_to_rw_prot_is_user(ap >> 1, 1);
+            ap_priv = simple_ap_to_rw_prot(env, mmu_idx, ap >> 1);
+            ap_usr = simple_ap_to_rw_prot_is_user(ap >> 1, 1);
         } else {
-            result->f.prot = ap_to_rw_prot(env, mmu_idx, ap, domain_prot);
-            user_prot = ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot, 1);
-        }
-        if (result->f.prot && !xn) {
-            result->f.prot |= PAGE_EXEC;
+            ap_priv = ap_to_rw_prot(env, mmu_idx, ap, domain_prot);
+            ap_usr = ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot, 1);
         }
+
+        result->f.prot = get_S1prot(env, mmu_idx, false, ap_usr, ap_priv, xn, pxn,
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
     }
     if (ns) {
         /* The NS bit will (as required by the architecture) have no effect if
-- 
2.46.0


