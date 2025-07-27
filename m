Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC85AC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMX-0000WT-1u; Sun, 27 Jul 2025 04:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLo-0005HE-VF
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLm-00046D-Pv
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23602481460so35104845ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603397; x=1754208197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jF/EGg3UDomg1t1Cn2r4mChtBaH+ZfabK+9IehzGgQ=;
 b=kLYESnI63pLmb/s3Mt5XA//xthtk7DUoRunHST3Cj5TS8RKELSoEWR3Ca6xH2OBTZF
 yfBawSUCawfjnl84trQwYQSVRjO+bbw76MfskTm8t69GqQVPwmCpWoURjnIt/9bfkKWF
 4jtS1Tp7tHfAZ1nbvQezqeGZcFQKHwBiz04o84M/y8tz2S3+wHWZb3DKR+UargFlrpxT
 PnkwJD+ZuInIzQlCWzsol0wlaxLeJHQXr9WoGnTAMu7io4Ma/MuJxWKMVneUox6JUE87
 9lim2i86TagA3hS0cGKWWTPrKPAYNWj4EHGgCXSSB9jBxWhbBAIaHHH3oSIz7Yaq00+M
 TU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603397; x=1754208197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jF/EGg3UDomg1t1Cn2r4mChtBaH+ZfabK+9IehzGgQ=;
 b=pzgF7DCiVqyiGDLD3enxMj9j4jrMtWqdQqTc1W6z0BQXj8upJ0j1vdgYm4DhAEucVk
 t/oN4gJj57hymrY6IJ6lRmM3r60/ShYyuJrzalUNjKeQCMTOl/Dy20VCf/aOYt4K60/F
 xt+VtcvnlL9wFmqp+cv+J+DZfBpxmhpd3Wq/GXzBhpmm9vPAcpt1p+l+9yN17i1yRPYR
 j0dZJntqFojSez7oU0Ef+lkiPshYA03OSnpMFhrfi4pDdrlMH2l7pLNZZeq2npfm3JoW
 U5xpazF/GUKbHToBvN4+5YREwHienzQfQRzUVIv4ysbB4KkmkZ2zOuGi8M8Xv4bQdygm
 wuhQ==
X-Gm-Message-State: AOJu0YzIclIRxY2joAPzOxeEaWqz6elvigAN8ybj/ok2DfncBtR8UmEo
 ZhXmTo2svXUDl3nU0wLZ61NfkGWoXyggBfn6CTBQmdGU4knY+d7a7MDm7xQvGtTNinwfAivPmYM
 DUbJW
X-Gm-Gg: ASbGncvDuIIGi0AyIUcwQcYt703D4Q3WLh5vggKwYZ9ViiV0Pd1cmK/4T7+pbS4RMKe
 pcqOAClkD61M2qBJ/ZkDi/2D6JwtH+5H68qRuqa3NNeBEyrqde4SIuYFU7geCkW7h7RCtQzSbuf
 rHc6eGXMhcjT9wWAuW/tXAHBhOwZDlQ32IPbVeX7pPalkNyhDxj70VVaFA1Z8AAAHI1CsX+xFnq
 Aww4jRtYstiG6wF4CnozomT1Rc3zuW9qISGAIoWLO/ROypuM1nydFiDI/Svoygu/lEF35RAwQt1
 cT+MVfVOMv3xATz5WR+Uae2Lg+W3Xo+s3HVwKhYVGh8m6zSLDrnhwPFaoM6A0ZooP/WVuK8Rgw/
 BZQf2bpWIxnf16L6GVy/3C/ObnRx3lY6ilmmoaVM9S7nmmciNdpC1umsn118L995JX9G/kB/Xhm
 naNz65yhf4GQ==
X-Google-Smtp-Source: AGHT+IGQ7kH1etKbzOy6oSWGmQG3I7DrwIgM96ODRoqLcUs8QSX22/2YpG4m8g/zyRXiJMTmdDT/oQ==
X-Received: by 2002:a17:902:da48:b0:23f:b245:531d with SMTP id
 d9443c01a7336-23fb3080817mr109082015ad.15.1753603397489; 
 Sun, 27 Jul 2025 01:03:17 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/82] target/arm: Implement get_S2prot_indirect
Date: Sat, 26 Jul 2025 22:01:49 -1000
Message-ID: <20250727080254.83840-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Move the stage2 permissions for normal accesses to
GetPhysAddrResult.s2prot.  Put the stage2 permissions
for page table walking in CPUTLBEntryFull.prot.
This allows the permission checks in S1_ptw_translate
and arm_casq_ptw to see the right permission.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  7 ++++
 target/arm/ptw.c       | 81 +++++++++++++++++++++++++++++++-----------
 2 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d5f501bb30..f0e888ff93 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1574,6 +1574,13 @@ typedef struct ARMCacheAttrs {
 typedef struct GetPhysAddrResult {
     CPUTLBEntryFull f;
     ARMCacheAttrs cacheattrs;
+    /*
+     * For ARMMMUIdx_Stage2*, the protection installed into f.prot
+     * is the result for AccessType_TTW, i.e. the page table walk itself.
+     * The protection installed info s2prot is the one to be merged
+     * with the stage1 protection.
+     */
+    int s2prot;
 } GetPhysAddrResult;
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7fd1cee98a..323fc8052d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1281,7 +1281,7 @@ do_fault:
  * @xn:      XN (execute-never) bits
  * @s1_is_el0: true if this is S2 of an S1+2 walk for EL0
  */
-static int get_S2prot_noexecute(int s2ap)
+static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
 {
     int prot = 0;
 
@@ -1291,12 +1291,6 @@ static int get_S2prot_noexecute(int s2ap)
     if (s2ap & 2) {
         prot |= PAGE_WRITE;
     }
-    return prot;
-}
-
-static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
-{
-    int prot = get_S2prot_noexecute(s2ap);
 
     if (cpu_isar_feature(any_tts2uxn, env_archcpu(env))) {
         switch (xn) {
@@ -1328,6 +1322,44 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
     return prot;
 }
 
+static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
+                               int pi_index, int po_index, bool s1_is_el0)
+{
+    /* Last index is (priv, unpriv, ttw) */
+    static const uint8_t perm_table[16][3] = {
+        /* 0 */ { 0, 0, 0 },   /* no access */
+        /* 1 */ { 0, 0, 0 },   /* reserved */
+        /* 2 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 3 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 4 */ { PAGE_WRITE, PAGE_WRITE, 0 },
+        /* 5 */ { 0, 0, 0 },   /* reserved */
+        /* 6 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 7 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 8 */ { PAGE_READ, PAGE_READ, PAGE_READ },
+        /* 9 */ { PAGE_READ, PAGE_READ | PAGE_EXEC, PAGE_READ },
+        /* A */ { PAGE_READ | PAGE_EXEC, PAGE_READ, PAGE_READ },
+        /* B */ { PAGE_READ | PAGE_EXEC, PAGE_READ | PAGE_EXEC, PAGE_READ },
+        /* C */ { PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE },
+        /* D */ { PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE },
+        /* E */ { PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE },
+        /* F */ { PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE },
+    };
+
+    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
+    int s2pi = extract64(pir, pi_index * 4, 4);
+
+    result->f.prot = perm_table[s2pi][2];
+    return perm_table[s2pi][s1_is_el0];
+}
+
 /*
  * Translate section/page access permissions to protection flags
  * @env:     CPUARMState
@@ -1778,7 +1810,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int32_t stride;
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    int ap;
+    int ap, prot;
     uint32_t el = regime_el(env, mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
@@ -2096,6 +2128,18 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     ap = extract32(attrs, 6, 2);
     out_space = ptw->in_space;
     if (regime_is_stage2(mmu_idx)) {
+        if (param.pie) {
+            int pi = extract64(attrs, 6, 1)
+                   | (extract64(attrs, 51, 1) << 1)
+                   | (extract64(attrs, 53, 2) << 2);
+            int po = extract64(attrs, 60, 3);
+            prot = get_S2prot_indirect(env, result, pi, po, ptw->in_s1_is_el0);
+        } else {
+            int xn = extract64(attrs, 53, 2);
+            prot = get_S2prot(env, ap, xn, ptw->in_s1_is_el0);
+            /* Install TTW permissions in f.prot. */
+            result->f.prot = prot & (PAGE_READ | PAGE_WRITE);
+        }
         /*
          * R_GYNXY: For stage2 in Realm security state, bit 55 is NS.
          * The bit remains ignored for other security states.
@@ -2104,11 +2148,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
          */
         if (out_space == ARMSS_Realm && extract64(attrs, 55, 1)) {
             out_space = ARMSS_NonSecure;
-            result->f.prot = get_S2prot_noexecute(ap);
-        } else {
-            int xn = extract64(attrs, 53, 2);
-            result->f.prot = get_S2prot(env, ap, xn, ptw->in_s1_is_el0);
+            prot &= ~PAGE_EXEC;
         }
+        result->s2prot = prot;
 
         result->cacheattrs.is_s2_format = true;
         result->cacheattrs.attrs = extract32(attrs, 2, 4);
@@ -2180,9 +2222,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              * Note that we modified ptw->in_space earlier for NSTable, but
              * result->f.attrs retains a copy of the original security space.
              */
-            result->f.prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
-                                                 result->f.attrs.space,
-                                                 out_space);
+            prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
+                                       result->f.attrs.space, out_space);
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
@@ -2211,10 +2252,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              * Note that we modified ptw->in_space earlier for NSTable, but
              * result->f.attrs retains a copy of the original security space.
              */
-            result->f.prot = get_S1prot(env, mmu_idx, aarch64,
-                                        user_rw, prot_rw, xn, pxn,
-                                        result->f.attrs.space, out_space);
+            prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw, xn, pxn,
+                              result->f.attrs.space, out_space);
         }
+        result->f.prot = prot;
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
@@ -2260,7 +2301,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         result->f.tlb_fill_flags = 0;
     }
 
-    if (ptw->in_prot_check & ~result->f.prot) {
+    if (ptw->in_prot_check & ~prot) {
         fi->type = ARMFault_Permission;
         goto do_fault;
     }
@@ -3458,7 +3499,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
-    result->f.prot &= s1_prot;
+    result->f.prot = s1_prot & result->s2prot;
 
     /* If S2 fails, return early.  */
     if (ret) {
-- 
2.43.0


