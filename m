Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F6ECF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoS-0003Ih-5J; Mon, 12 Jan 2026 17:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoQ-0002wE-6Y
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:02 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoN-0003tY-St
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so42738925e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258498; x=1768863298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IwcMUwlQzOr5cia1gD4bDkeN1fDmc5SnYlwm6J+2ScE=;
 b=sMpd1/uZbOoFQ9IRE9N6wooqbLUZhV7YZAcxaQWem6/9jAIHH81b0w1Dm6E84raIwo
 CmS4JitWx6qIy7tlmSjnk7856Y95oX3xzYvzBr7Mf2odLbt2vX0bDapW0FP02Thw8nmZ
 U7A11xTtHQ3du6Cjvl2Ktw6YCSiTo9XPKPlJxjxK09Z6oKLUo6zGOxHmYsS6+UYJP7KQ
 ckxk7hevZk138EnXoXamANmwx0K+2k5vvHrVx4vx0+V8mXyXRM0Vj7izgnSLAKW2VepE
 CGZx+/0Qy5L90NTj9I04LnslkfJruJjfDl0e5e1SXi84MGJ5YKXjRPhhFmLFPCPVyers
 VlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258498; x=1768863298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IwcMUwlQzOr5cia1gD4bDkeN1fDmc5SnYlwm6J+2ScE=;
 b=Qfqa14eAt/60XjivOaZISIK6W4oQnczaAtrEQUl0EqjKpKFHW6Mmn+xNxDcqCn927u
 hhtKDbvV1Lb1vdArVo7rBvSeUDwkgev4ySYZEDZjQsnrJYPNz2fzCyNHx/yJAHRtbAfB
 l11C5K7PnwygrAts7Hd2YtCwDLu7+esUkp8TxqPwpBZrAvqOOMgF4Otx541JrPgHa0Qq
 bUubNXvATHAl5wOF7UOcaOta+Yjq4rjoEkj1XYt7QteP3iF/t/V5wfo95g4msLbi1ZUs
 9F36HEy+hTurNJ4uVgY+KNlU6umjG1I1ucLjcZzJgl4HxB4AnK5twN9FvOvQNhv0kLBY
 eoFg==
X-Gm-Message-State: AOJu0YzJynT6BwcwDfxTjoBieekCKbaA5jQSopAO4fNR46ei8d/SbM6N
 YqyCi7QqWOMg6pnNxEJwfefNlfTlz7A223TEIjvyswD8sWCojgC1vsR6s5U5UbKheKsd2tZdT8j
 8fxUb36o=
X-Gm-Gg: AY/fxX5Sj/Z4OWOKbr+/GkSjBzXJ1+iY4kl6KLpNugO49cApFHNq9XX8nFpJl3rZ/aJ
 JFse4guGe7LGXJA6ZwlPIpZtlUhacu5aI8ypP7JjkqOQybt+eFJ2uZOKMuWEp4Q6CsdFcInqFWn
 2g7ps0QqIjnMmznxFBsyeDzlK6sHFwHwzOG3jVDG9W96UVY2ino/xfNONKZY0rwyPvB/N0diFO6
 5g2R4yfqAKXAwRtvkwfW5mtRxNi9Cv/SPQxMBVdQb6KcLdBOFVAfy3bXHOuwx75sg1Zt6iFYhio
 50Gn/jTNAc+RJRe/K5ZYVvlKCa1cUVojVT+H58He0hXAxW1Y2pJfgHG9IrEaXCq4ZJkUMbVLzL3
 sAZt2Z+5Y2uxLvuc1Q7AVQ/Dhk8YMm6OWP4LqXD4qoPXcwTjIeqayudLEU79LU/KhG1ipfdiEmB
 bvCTM8cYN/kqIvZFcNXAldzjdNMN1teF4UFkR2y3g+SfW0GTDbSn9iqcFzxGs3R2/xRBSIU/M=
X-Google-Smtp-Source: AGHT+IFi/oCAOXtVJU3VZFuxv1KJHZMsjn/fJt0yxdlF+jzCo/wdSCESb0CV/sxG5oNNrGAn2W+0yA==
X-Received: by 2002:a05:6000:2510:b0:430:f9c2:84ec with SMTP id
 ffacd0b85a97d-432c3643608mr25770399f8f.26.1768258497939; 
 Mon, 12 Jan 2026 14:54:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff1e9sm42534571f8f.41.2026.01.12.14.54.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/61] target/sparc: Use explicit big-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:47 +0100
Message-ID: <20260112224857.42068-53-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162642.90857-5-philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 36 ++++++++++++++++++------------------
 target/sparc/mmu_helper.c  | 32 +++++++++++++++++---------------
 2 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..881dbc96edd 100644
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


