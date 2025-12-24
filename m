Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5902E776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRi5-0007iC-KN; Wed, 24 Dec 2025 11:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhu-0007fg-KF
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:26 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhs-0003mn-MS
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so3109085f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593641; x=1767198441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0c/mySe6v1ckZ2Oupf+IHYume+MJC9Oj74k6isdDL0g=;
 b=FtvVNZ8vRu7Tf6NCdbnVI8tzE4ut+XEFD+slvrw+0W2FAReZJlq2s2MKsjQXajRQwe
 cKiJJdnbc1lR40ZJNfYqLLQS03mTlGlSWmVfHneFaQNrbYE3sJ428k0D4Qaww1RYOTdi
 VGJyylZzDV51T89gic7H6tXC8YLVN8XdxU5ppiadUTZdw50jBQtKxbEXIymBmfD6vAO1
 W7o3ajap4Ps13nIcjFHQ9dz5zCvvug38wlv9F8zNw6+bYAmZs+mKe7OSJD5SwvdjeX8U
 Q1cHqQFIjlyCiEwCVKMrCzgqF+1euHaV16k5n/sBksNcukYT/xTGIDRIlIv+KUAUsS54
 9z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593641; x=1767198441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0c/mySe6v1ckZ2Oupf+IHYume+MJC9Oj74k6isdDL0g=;
 b=dmIaIQt/yHd8b4zsgtkTbfRlwf8I5I/ym+GTcnvzSMIbb597icH5B4NF6AK7wlsc05
 tRh/GH1AQsd9TYHLUDm7lbLzFQ9D17nHeiSj/ctAKdjq1CynCrXbynGSXuAaQUaSq2UP
 J88E+d87HMGDYOnllS/QH4vJiirCBvRfpqA2EX12o01//2CMURcx9DJlf8HEO+Ndhpam
 eN0weeVdywhF5uuKEqCcao7LzRWfnzmazzYj6IHkCI22isYOq33kUWYyak6U/YNliAd/
 opw7+nabGuezVRcRD5GpC3Zy5iPbEGrcQ6Hwsfsi4UcYi8TTsCCus2h80bvQeKXMf+eF
 UNtw==
X-Gm-Message-State: AOJu0YzD8+FX9jn287PPsnXFEKhb43TRt34oJY1FQudkkHHZvA9NSVbu
 v40g+S5fSIdRjxito5sx/mB3Lou6HTQl+ohfT1l4Qaumg+DdRB8ktJOH0IYyCbokzEwmWgC/Ixh
 oMPcvKA0=
X-Gm-Gg: AY/fxX53FpRz3Tt1bXGJL3/MTRYMk1R0MeNFl7DifDm3dC+Kcz0PhiCwEz2UdHteTwz
 M3I78eaTLrmZkowHNUPLe1U7wQWmax8wvFOoDt1irqd66MZqesiISJI6g2JTq4isesZqWiG2ZtG
 ljDzjP9RiPq6+27cGUjAHHxBMAVmHA7+giNzFPxpMy/5Z8Ce4qvStRBHvIiLWI4GAWFKQLh7MQ4
 1mf50cNM8TS7Vdi89+Y7jueR+Exl+F9xCDgXmBqlE0HB9ixBlPHNtgJh4HXA0KlE31LpnMcQbYx
 vJ+BZW0/WMwApfUdI6doaao95gzHMBJPOESqkDVNzu+CNI2qpfEH7nb0wnsIkad+Ql0+WUpKB3p
 yxQOtJsLOam5rTaRw+Jxk7jAZzpIYtsHBuh1wo2wHFJvYSOQmc82e+euK54nmx4KX6IgcBNC3Bx
 vSVTm+Hu+P9YE6XTwF2j4wPpud4INPjH0JNcFOB9gDlo1HoAUxNtRVCcmvFddsPhaCFQ==
X-Google-Smtp-Source: AGHT+IGiE4oKKUNR2ofAJgPK//pcRQI3YJTXXrCwOyrQcTxF7UH9qNND30a8fNJuP85/hOGEn5paag==
X-Received: by 2002:a05:6000:220c:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-4324e4c9627mr21155343f8f.14.1766593641108; 
 Wed, 24 Dec 2025 08:27:21 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm18740820f8f.26.2025.12.24.08.27.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:27:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/9] target/sparc: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:26:36 +0100
Message-ID: <20251224162642.90857-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
 target/sparc/ldst_helper.c | 36 ++++++++++++++++++------------------
 target/sparc/mmu_helper.c  | 32 +++++++++++++++++---------------
 2 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index a87a0b3eee0..9892c8f61c6 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -707,17 +707,17 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
                                      MEMTXATTRS_UNSPECIFIED, &result);
             break;
         case 2:
-            ret = address_space_lduw(cs->as, access_addr,
-                                     MEMTXATTRS_UNSPECIFIED, &result);
+            ret = address_space_lduw_be(cs->as, access_addr,
+                                        MEMTXATTRS_UNSPECIFIED, &result);
             break;
         default:
         case 4:
-            ret = address_space_ldl(cs->as, access_addr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
+            ret = address_space_ldl_be(cs->as, access_addr,
+                                       MEMTXATTRS_UNSPECIFIED, &result);
             break;
         case 8:
-            ret = address_space_ldq(cs->as, access_addr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
+            ret = address_space_ldq_be(cs->as, access_addr,
+                                       MEMTXATTRS_UNSPECIFIED, &result);
             break;
         }
 
@@ -878,10 +878,10 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
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
@@ -906,8 +906,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 MemTxResult result;
                 hwaddr access_addr = (env->mxccregs[1] & 0xffffffffULL) + 8 * i;
 
-                address_space_stq(cs->as, access_addr, env->mxccdata[i],
-                                  MEMTXATTRS_UNSPECIFIED, &result);
+                address_space_stq_be(cs->as, access_addr, env->mxccdata[i],
+                                     MEMTXATTRS_UNSPECIFIED, &result);
 
                 if (result != MEMTX_OK) {
                     /* TODO: investigate whether this is the right behaviour */
@@ -1072,17 +1072,17 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                                   MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             case 2:
-                address_space_stw(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
+                address_space_stw_be(cs->as, access_addr, val,
+                                     MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             case 4:
             default:
-                address_space_stl(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
+                address_space_stl_be(cs->as, access_addr, val,
+                                     MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             case 8:
-                address_space_stq(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
+                address_space_stq_be(cs->as, access_addr, val,
+                                     MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             }
             if (result != MEMTX_OK) {
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


