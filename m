Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F79DC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUL-0005yd-GL; Fri, 21 Aug 2026 00:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUI-0005xj-Th
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUH-00039f-6W
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:14 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so542805a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285052; x=1787889852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FcNFOnOL8974glwABu+kV2mxfPSi3R5uRGeROQDc4EQ=;
 b=lym96s6HCDxM/MXJMjRramhd6BsKbFyG77i8r1C4BufljHms1t34QQnLHIkvIK974h
 y38LBsE5MpDSOZg7t90vDmBsmaS8rD++MH2wEw/dY+LWdlE7afYy/U5FfSLOrcM2X9mR
 0DwFnUTMUOhO9YJruUft+hltJKNvprs+dF2hgX7frskkzqy2F1REuOcwT8CJFhbAsdKK
 q9EYx/DEIx8l/9bHMN8BlT+rrNQKJkSNatYURgiYrmbB6D9wx4EbvbE0eF981LIwVH4u
 0NHai0yRwhaXCUD/sxFgqHrKa4sejSfMc4xp7nLmYIPk94uUaEkrbBdwn613JgYFLNzp
 X+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285052; x=1787889852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FcNFOnOL8974glwABu+kV2mxfPSi3R5uRGeROQDc4EQ=;
 b=glFo8BEJLyf2ZT4I3zHg4NvR+wbygTqaJX1ujh1YgUd2DAf31xHCmacaxqfARGavcp
 4gcfUGisJxB2OF2oDhOdSmhtcuPn+5mzB06Erk0KmepvBZTcuPnFfd36v9JrF20tSFOA
 uLWEuxm+OMpfo7a/BvgCiNPFftgIjpM9SBzbIyUzWhn6av/b4Qe44HD72PE3zqRmyHjl
 2s1CJCXq2A4nicssNZm22s4Hgg9BmBJTR0sryraFoL6H7qRhqEVlCoilnK2MDTXsTO3I
 eipZEncmQqIWLgy6wTPeFAWIwghYbWCERpbfMv3Y0q7I/Du+U3wLMV6G/7Bnuvy3eGEi
 xHig==
X-Gm-Message-State: AFuF++mANKwjr72FkYkF9FcV5DYmwa5dH9ET1Xk+QYMPFB21z4KToDUF
 tdi+HUdf+4j3vXqEUzfs7n/RW1YihkYAGNSWthDcY5/vT9CTBSUlZDKvGZesIjEVcxOw9LswxLG
 52mS4
X-Gm-Gg: AR+sD12wK/aOd2LsQMgpoPVsJ8olJ9wPkFyrcbyloQpJ2eSzcClPkfZCvzi2DJvcCae
 oKef3y1lWY37GQN7K1sUh6G/SYSbmqk/ouPS9alemo6E+NIWUlyKHO2SC5mQynuNAbvmGogxpBp
 wFfqEfm3xuuOwNT9qG/OKl260+B7Y74vy7lxk8tLlbKXnJscq10oKrN6Byyf6tD97jKoZGZ88Qd
 FcYmas7FvMDPByvifF1whlV6ZpWtJuwWgcoG4QPWE53+1/kZB7RZ9ZeL3nzF5QQ4N4UWTBaFACO
 bZ+38U4DnGNgYfgQ3LiIRVyfmmCwKqU7ZZAoh4vaLx80PKRh0+F7u+h+xmPXLtdhPQhon4tk3aO
 sieU1XYEYQJQHdTglg1BdHjm0/h7LCVaNXyhZd6mCj122oKOEOO4r5ijX0nkIvlVAs6+0K+JpKR
 L1YU9boQziy+28PG+eulk4oZyYiOYYGxeMCb3THE5Wgily96Tr6al1pYj2jz61+rsF5FZx
X-Received: by 2002:a17:90b:58ce:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-395c398662amr6901770a91.16.1787285051829; 
 Thu, 20 Aug 2026 21:04:11 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 01/23] target/riscv: Split out vext_set_nf_elems_1s
Date: Thu, 20 Aug 2026 21:03:42 -0700
Message-ID: <20260821040404.268123-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Provide a helper that 1's element I for all NF vectors.
For the callers, this performs the element mask test once
instead of NF times.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 69 ++++++++++++++++----------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index e28d8a3d9f..20a8f95efb 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -328,6 +328,15 @@ static void vext_set_tail_elems_1s(uint32_t vl, void *vd,
     }
 }
 
+static void vext_set_nf_elems_1s(void *vd, uint32_t i, uint32_t nf,
+                                 uint32_t esz, uint32_t max_elems)
+{
+    for (uint32_t k = 0; k < nf; ++k) {
+        vext_set_elems_1s(vd, true, (i + k * max_elems) * esz,
+                          (i + k * max_elems + 1) * esz);
+    }
+}
+
 /*
  * stride: access vector element from strided memory
  */
@@ -337,7 +346,6 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
                  vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
                  uintptr_t ra)
 {
-    uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
@@ -345,23 +353,21 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
-    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
-        k = 0;
-        while (k < nf) {
-            if (!vm && !vext_elem_mask(v0, i)) {
-                /* set masked-off elements to 1s */
-                vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
-                                  (i + k * max_elems + 1) * esz);
-                k++;
-                continue;
+    for (uint32_t i = env->vstart; i < env->vl; env->vstart = ++i) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            if (vma) {
+                vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
             }
+            continue;
+        }
+
+        for (uint32_t k = 0; k < nf; ++k) {
             target_ulong addr = base + stride * i + (k << log2_esz);
             ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
-            k++;
         }
     }
-    env->vstart = 0;
 
+    env->vstart = 0;
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
@@ -632,7 +638,6 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
                 vext_ldst_elem_fn_tlb *ldst_elem,
                 uint32_t log2_esz, uintptr_t ra)
 {
-    uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -641,24 +646,21 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
-    /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
-        k = 0;
-        while (k < nf) {
-            if (!vm && !vext_elem_mask(v0, i)) {
-                /* set masked-off elements to 1s */
-                vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
-                                  (i + k * max_elems + 1) * esz);
-                k++;
-                continue;
+    for (uint32_t i = env->vstart; i < env->vl; env->vstart = ++i) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            if (vma) {
+                vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
             }
+            continue;
+        }
+
+        for (uint32_t k = 0; k < nf; ++k) {
             abi_ptr addr = get_index_addr(base, i, vs2) + (k << log2_esz);
             ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
-            k++;
         }
     }
-    env->vstart = 0;
 
+    env->vstart = 0;
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
@@ -824,25 +826,22 @@ ProbeSuccess:
             }
         } else {
             for (i = env->vstart; i < env->vl; i++) {
-                k = 0;
-                while (k < nf) {
-                    if (!vext_elem_mask(v0, i)) {
-                        /* set masked-off elements to 1s */
-                        vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
-                                          (i + k * max_elems + 1) * esz);
-                        k++;
-                        continue;
+                if (!vext_elem_mask(v0, i)) {
+                    if (vma) {
+                        vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
                     }
+                    continue;
+                }
+                for (k = 0; k < nf; ++k) {
                     addr = base + ((i * nf + k) << log2_esz);
                     ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
                              vd, ra);
-                    k++;
                 }
             }
         }
     }
-    env->vstart = 0;
 
+    env->vstart = 0;
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
-- 
2.43.0


