Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA30D711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMII-0002EG-JN; Thu, 18 Dec 2025 17:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHk-0001wD-Fh
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHf-00072C-Vj
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so6944935e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766096142; x=1766700942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQBTMCfea7CrgtYIaGV0TP3JWVGEy3fzFkDzZcaRRcU=;
 b=wri4t0v3y76EXcyHjtssS0hqFbFRfn4K+mSLxHPJaLF4HqBXs8nX2IAJlTDnEqMPJ3
 cWwzPsay2MbdvWqvdqVTTJ15cSLt5sB1hlf9rd4EBX9GmbKDsgg4qYgqrFTKnyQTihe/
 RIoI9GOA6ha32N3NpRrb8/I8PlsQcaNkyHK9aBTJ4dXsLq0Nik4bq0q9U8Y19aZdp4FJ
 r4SiZMOu6cxypWADCO+rLZjn6THq/dWfDVmLNNLsgRI9YvrXZ/5Xc2wA3KwPb3KDU7ZA
 u4oGyBggTiDuDgDYm6PAENeYERMhWDISCmqqkTKCltiDcOqQDJgZbRKgH8MZMFA3cDrW
 RTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096142; x=1766700942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lQBTMCfea7CrgtYIaGV0TP3JWVGEy3fzFkDzZcaRRcU=;
 b=XEdZvxVMcmD5F86weWlYYHOZ8sRYqawSZbIoCzwHxRU5juAp2wr1GGfc1qJ25DXFAx
 pdkb5VQ6b8HBasmS1aLUhWCE3NFu+DqXsUUfWRZcDyLYEzbi+OF+TaIE09jmj//G99Mz
 DFbgeQAlqCMrXTMtZdenaA8pq7+NZsh1RFsx5s6UUn9+ED20JCkcPWE1H6FZ+HnNfxph
 P9cGBu+Knm2NMTIWyMNItMVwJf8Clo36YZM6q0aA5RCDJcx1D69Xq99GkNK4f+18bhnO
 2xoMIx5Ee5aDWqWLa0491YlpvZASfx+LcbFzrii6BARsYvKbPgP067bAnT953GBwz9OS
 e9hQ==
X-Gm-Message-State: AOJu0YybsCgBSxr71wbR3M+VQg/8YIY+Yu4+OOc7RNx9C7WtzBaRU4QV
 ruJPbudrdHqGpZ4Rl7TPZ7l/B+L8ufeXmqDKOiPJ66ysbqrYTGJPcjswgEQKDpw0K3QNBc8efQC
 jYFPp62U=
X-Gm-Gg: AY/fxX7IGdj7e1IM9H1o3mf+DIAj6a7WsHgCgm9o9CrutAdIp5ze/gQcm5fdP5gzkl8
 vNR2Ohv1mhWpC9gkAm7jSmAJYmXDEf8H2G0xd44MwqN+qBSu+VJwXpiuHMZVfg0BBP4W9to0E1c
 KLgTQhdjGdiGZcmuIFggzpbfkkLL7/YPicCNOmQ7yeiCUga1Z1mnxpcZvdw3nFxdfl3muzINwlI
 bdxc2VWV9vlHxt6SGsYVtEY4cxhoJCQDSSVmMvJFt11xGcIea1f5z4QWxl+46qgzAOolWrvdTQO
 SbBMfZfCJIvG2N07c34v5BFVx1TyGa1UTH+puwpQMkyKWSchhbPCM6oiDq+HlmgCxqOK5SEOrVT
 2v9iDOhJOL+0F31HEEsnZULDieqqfL5WfvNnh8UV2UVAHvvUmigK5fb7zZ1F20XpaR+MrmwR66B
 ewwDctRFWQONeUBkxHNJoFbS0YLh9YEmAyh0ebW8/pQAE2pKZqIxU332sYSeOFw160620hvus=
X-Google-Smtp-Source: AGHT+IF1zd8m+r0uNjInsUOLt97Eed+6ln7aydXlyXRU8sR76Wmgh1KI1R7kt4ezvYxaA16zwHzO1g==
X-Received: by 2002:a05:600c:3b07:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-47d195917d2mr5425505e9.35.1766096142163; 
 Thu, 18 Dec 2025 14:15:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm63348565e9.3.2025.12.18.14.15.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 14:15:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] target/sparc: Use explicit big-endian LD/ST API
Date: Thu, 18 Dec 2025 23:14:56 +0100
Message-ID: <20251218221457.73341-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218221457.73341-1-philmd@linaro.org>
References: <20251218221457.73341-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
 target/sparc/mmu_helper.c  | 30 ++++++++++++++++--------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 052608c02d8..ed79a506584 100644
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
index 46bf500ea83..035be5b4f9a 100644
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


