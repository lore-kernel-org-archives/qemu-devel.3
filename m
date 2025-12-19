Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B1D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdTq-0003bK-IK; Fri, 19 Dec 2025 11:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTo-0003b5-Ts
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:24 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTm-0000Qh-PW
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:24 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43246af170aso1152665f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162241; x=1766767041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9motHBrqMt24s1IQyPulB1xIC/+4lJ6JZJS5crr6M0=;
 b=owDoJChSXD8wFdrhCINEtXevmP6BLHcAVK3G32wUsIgYPZjRxJYulZrO6oNAp6itTT
 N5VU4CUxhXe1aX2s5mt0RU1ar6X+SfCIgtjy/0Rsig/nJlZSUunmcX60Fzf53KcvpMOb
 zCr9H4fwwQkoyYHie7/rOdkFQEuTRMDaI2wdIJj0OExJOxo7Jk0cAvsjM4UULB1qUEVa
 jSfNa5fexRC6I0y6vTBxrg/xxDKKxxWIacTQjqXYdg7zsmowwOJjtjgt+Onq7qISE7xU
 ZQjybnNLVUaDPrN6I1CzEIdLKbwIqP8Rtp3ooJ5wK2OpQcQ2CL9CKSwO1vYlDOeW5Aaz
 69ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162241; x=1766767041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9motHBrqMt24s1IQyPulB1xIC/+4lJ6JZJS5crr6M0=;
 b=sQp5PA/tWQVBfRTQ+0tq7Ot2E9Wq1B67yyTr/CDI9CdZX5ySygfYrTh0qjZNXZ08Oz
 uL0DFiMkHZ03Ih+j1KCloGT1t5HdJ5pImSGvS1JErsc8Wjng0nitXlKEnPjPVzEY61iS
 2WWNVenKhJX+S9TIONpQz+cj0fNcv7p9v1SsCL0tYXzS/rCiuw2X+jizFtZLYHwQjG0F
 jAyRKgXzbJMXecmPvbdePmywM7o175PoORwNUoj4E1EdF+0biKEOJoBbsAsDlq/2jGKQ
 rLch2fiG7HcFSo1Ma9c09lt3H6qPXDu8cwTDM442TfWGigbWjV9n5fQ1S+vBQu7R2Lmt
 LUxg==
X-Gm-Message-State: AOJu0YyRgf7CnZOBBuAY9wFg8JNF02etVkdT3RgT+wIcUUq/1q7NS+7K
 sFA+lF70S6dvbwd0NOyrzLi4uzdgCGjoEU7fU1cLFPGlg5/RV0eKEg2kyXVG2wSSxy08HwYffQP
 o/QePZ7M=
X-Gm-Gg: AY/fxX6p8w4yISumKvHetHqe+FOgPIrWJL5ZcLJsox27fPRvl+NskARQW+rFKqsBrq9
 GAjWGI9e3EJx+oiUHt0VQEGEPCERq/GqzGyul+4F00V5qqjw2v+9v2EHZmoxrmVDryRxNudF46n
 C+DiB7BLt+voX1M/OBxwMDpfnaHedh0zQ35ItNo9I31fgKMAw83Tv4qoqrKmAcRcmw/4Bbu0S66
 q23fm2sgoUj7SRBbtqcCmC2uWSKpi+DeGvAsfC0zs7sUCzi/PmCrNdvQNZiNa4iAohR0+9RHzZ1
 ZOrDpiMbMHnDNpB/IOBEzm+DG6pwtODkeCmiOzCdvb9r9T2AFgTQkwujBDW8oa85g3lnOjAch5F
 ihpFaCfGjA4RZxTP/hQAE6XbDkD5n2gdX9/o9OlR1bcCqvrAKnswyRu4Ek8A7w4NuRKuQ1tguzb
 dzVeLWCtF1wSJPJMTu+cI113bwBFvWldqLIij14idnGdOah8wdHzmhfundeqBi
X-Google-Smtp-Source: AGHT+IEDKYBb5hqGU3m6BnshX3o8kMw/6OG8EE6/usnEsCwVia3TUyOkv0X9alMc8plV1loP0KULZg==
X-Received: by 2002:a05:6000:26c3:b0:430:fd37:ef89 with SMTP id
 ffacd0b85a97d-432447959a1mr8026923f8f.6.1766162240547; 
 Fri, 19 Dec 2025 08:37:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2267fsm5741288f8f.12.2025.12.19.08.37.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/9] target/sparc: Use explicit big-endian LD/ST API
Date: Fri, 19 Dec 2025 17:36:44 +0100
Message-ID: <20251219163650.74303-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The SPARC architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/sparc/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 12 ++++++------
 target/sparc/mmu_helper.c  | 32 +++++++++++++++++---------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e9139814c26..043711f11dc 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -861,10 +861,10 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 MemTxResult result;
                 hwaddr access_addr = (env->mxccregs[0] & 0xffffffffULL) + 8 * i;
 
-                env->mxccdata[i] = address_space_ldq(cs->as,
-                                                     access_addr,
-                                                     MEMTXATTRS_UNSPECIFIED,
-                                                     &result);
+                env->mxccdata[i] = address_space_ldq_be(cs->as,
+                                                        access_addr,
+                                                        MEMTXATTRS_UNSPECIFIED,
+                                                        &result);
                 if (result != MEMTX_OK) {
                     /* TODO: investigate whether this is the right behaviour */
                     sparc_raise_mmu_fault(cs, access_addr, false, false,
@@ -889,8 +889,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 MemTxResult result;
                 hwaddr access_addr = (env->mxccregs[1] & 0xffffffffULL) + 8 * i;
 
-                address_space_stq(cs->as, access_addr, env->mxccdata[i],
-                                  MEMTXATTRS_UNSPECIFIED, &result);
+                address_space_stq_be(cs->as, access_addr, env->mxccdata[i],
+                                     MEMTXATTRS_UNSPECIFIED, &result);
 
                 if (result != MEMTX_OK) {
                     /* TODO: investigate whether this is the right behaviour */
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 46bf500ea83..5a58239d65e 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -102,7 +102,8 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
     /* SPARC reference MMU table walk: Context table->L1->L2->PTE */
     /* Context base + context number */
     pde_ptr = (env->mmuregs[1] << 4) + (env->mmuregs[2] << 2);
-    pde = address_space_ldl(cs->as, pde_ptr, MEMTXATTRS_UNSPECIFIED, &result);
+    pde = address_space_ldl_be(cs->as, pde_ptr,
+                               MEMTXATTRS_UNSPECIFIED, &result);
     if (result != MEMTX_OK) {
         return 4 << 2; /* Translation fault, L = 0 */
     }
@@ -117,8 +118,8 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
         return 4 << 2;
     case 1: /* L0 PDE */
         pde_ptr = ((address >> 22) & ~3) + ((pde & ~3) << 4);
-        pde = address_space_ldl(cs->as, pde_ptr,
-                                MEMTXATTRS_UNSPECIFIED, &result);
+        pde = address_space_ldl_be(cs->as, pde_ptr,
+                                   MEMTXATTRS_UNSPECIFIED, &result);
         if (result != MEMTX_OK) {
             return (1 << 8) | (4 << 2); /* Translation fault, L = 1 */
         }
@@ -131,8 +132,8 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
             return (1 << 8) | (4 << 2);
         case 1: /* L1 PDE */
             pde_ptr = ((address & 0xfc0000) >> 16) + ((pde & ~3) << 4);
-            pde = address_space_ldl(cs->as, pde_ptr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
+            pde = address_space_ldl_be(cs->as, pde_ptr,
+                                       MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
                 return (2 << 8) | (4 << 2); /* Translation fault, L = 2 */
             }
@@ -145,8 +146,8 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
                 return (2 << 8) | (4 << 2);
             case 1: /* L2 PDE */
                 pde_ptr = ((address & 0x3f000) >> 10) + ((pde & ~3) << 4);
-                pde = address_space_ldl(cs->as, pde_ptr,
-                                        MEMTXATTRS_UNSPECIFIED, &result);
+                pde = address_space_ldl_be(cs->as, pde_ptr,
+                                           MEMTXATTRS_UNSPECIFIED, &result);
                 if (result != MEMTX_OK) {
                     return (3 << 8) | (4 << 2); /* Translation fault, L = 3 */
                 }
@@ -189,7 +190,7 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
         if (is_dirty) {
             pde |= PG_MODIFIED_MASK;
         }
-        stl_phys(cs->as, pde_ptr, pde);
+        stl_be_phys(cs->as, pde_ptr, pde);
     }
 
     /* the page can be put in the TLB */
@@ -276,7 +277,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
     /* Context base + context number */
     pde_ptr = (hwaddr)(env->mmuregs[1] << 4) +
         (env->mmuregs[2] << 2);
-    pde = address_space_ldl(cs->as, pde_ptr, MEMTXATTRS_UNSPECIFIED, &result);
+    pde = address_space_ldl_be(cs->as, pde_ptr,
+                               MEMTXATTRS_UNSPECIFIED, &result);
     if (result != MEMTX_OK) {
         return 0;
     }
@@ -292,8 +294,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
             return pde;
         }
         pde_ptr = ((address >> 22) & ~3) + ((pde & ~3) << 4);
-        pde = address_space_ldl(cs->as, pde_ptr,
-                                MEMTXATTRS_UNSPECIFIED, &result);
+        pde = address_space_ldl_be(cs->as, pde_ptr,
+                                   MEMTXATTRS_UNSPECIFIED, &result);
         if (result != MEMTX_OK) {
             return 0;
         }
@@ -310,8 +312,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
                 return pde;
             }
             pde_ptr = ((address & 0xfc0000) >> 16) + ((pde & ~3) << 4);
-            pde = address_space_ldl(cs->as, pde_ptr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
+            pde = address_space_ldl_be(cs->as, pde_ptr,
+                                       MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
                 return 0;
             }
@@ -328,8 +330,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
                     return pde;
                 }
                 pde_ptr = ((address & 0x3f000) >> 10) + ((pde & ~3) << 4);
-                pde = address_space_ldl(cs->as, pde_ptr,
-                                        MEMTXATTRS_UNSPECIFIED, &result);
+                pde = address_space_ldl_be(cs->as, pde_ptr,
+                                           MEMTXATTRS_UNSPECIFIED, &result);
                 if (result != MEMTX_OK) {
                     return 0;
                 }
-- 
2.52.0


