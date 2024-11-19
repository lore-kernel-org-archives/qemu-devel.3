Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4ACD44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8h-0005vq-2o; Tue, 19 Nov 2024 09:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8d-0005tr-3w
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:31 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8b-0006DQ-2h
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so8980845e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026207; x=1732631007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CmWCC2CxsP9hklr4mLV7JuMCZSWJOJa4bduw2FlH0m0=;
 b=O+T6XMA+oZj35LH2NdxZFje1ZcIABOmMG6jYzCOTBAKQhkJri+8YuHqLK2Ivx++q2A
 +VhMGSPhOaL6PGhnJc5BCk+5Fo/o5hltxMy3FnpGenM4YOJRyZ1NV6vwPztbaDEgErwJ
 u+R2NE63KdhRBDC7GwLSB94D9qN0cSZM8iIKDNfQQFE1cb88hyXZiXPKXwqbbI7k+bvh
 lLpoZF/n6k7iQqHeoSuhw6ZMmD/lx7B/CwlyL6G7gIBlCpmaIqQDsyC5iAxJJbZRZqtD
 po6iqrJOQORdYB3b74F8nA2F4wHQprtexbuYFonAiZntpMQFVRY4DjEYBbeM3LMMF6Hf
 ttjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026207; x=1732631007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmWCC2CxsP9hklr4mLV7JuMCZSWJOJa4bduw2FlH0m0=;
 b=Dr3GtYm37ixmD9Ss6f6DJNw+V6504vQBIb5mJctAyD0R9amhBCWHQ5o/BppKR71gWa
 16r1bGMaE4OE3olyP+YsmzDGuRy3viZi96iiJU25DzFB7Q4xpz9nyq5L0cneQcDIVsI7
 GBxRNxaPy7MV7LEOFGsAmYfb9RozbbaKHuS7oc10xbEEJ/oIyzM95hZbDJ1Jfz4vf06/
 LY0Hu7CsBjLEArhY31MKR5FeKZrjl8Rwc78vn18CwMfqMrLN9L4VQSZEpNFtEn9oLYEX
 1wbWqDu3HC9V51SbWolmQI+PFC3FZhe7j23gc1gQvx7FEx1Mz+YOByRYi6q94gPr4vbu
 I8uA==
X-Gm-Message-State: AOJu0Yzvca8t9xK7Ke5fGFF6arJRMTMhYw+K6gslehOzrNPTDXX6iqvn
 0WkdBifWeboCu20PNgYVmtHEuWYrSGm6tFfgYbNA/1c+TeSs4zXCfQnhjBkxra+qumJ/IXdsEVP
 o
X-Google-Smtp-Source: AGHT+IFVkSFBdagkbMkIdkJt7TivPxUZWPTHenKjQcZMDtQBfGRQj3VT4qu5zxKkgjzbnmWWADoz8g==
X-Received: by 2002:a05:600c:444f:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-432df74eb09mr159873445e9.16.1732026207556; 
 Tue, 19 Nov 2024 06:23:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] arm/ptw: Honour WXN/UWXN and SIF in short-format
 descriptors
Date: Tue, 19 Nov 2024 14:23:15 +0000
Message-Id: <20241119142321.1853732-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pavel Skripkin <paskripkin@gmail.com>

Currently the handling of page protection in the short-format
descriptor is open-coded. This means that we forgot to update
it to handle some newer architectural features, including:
 * handling of SCTLR.{UWXN,WXN}
 * handling of SCR.SIF

Make the short-format descriptor code call the same get_S1prot()
that we already use for the LPAE descriptor format. This makes
the code simpler and means it now correctly honours the WXN/UWXN
and SIF bits.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Message-id: 20241118152537.45277-1-paskripkin@gmail.com
[PMM: fixed a couple of checkpatch nits, tweaked commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 55 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index b132910c401..64bb6878a48 100644
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
@@ -1240,16 +1244,19 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
             g_assert_not_reached();
         }
     }
+    out_space = ptw->in_space;
+    if (ns) {
+        /*
+         * The NS bit will (as required by the architecture) have no effect if
+         * the CPU doesn't support TZ or this is a non-secure translation
+         * regime, because the output space will already be non-secure.
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
@@ -1259,37 +1266,23 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
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
+        result->f.prot = get_S1prot(env, mmu_idx, false, user_rw, prot_rw,
+                                    xn, pxn, result->f.attrs.space, out_space);
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
2.34.1


