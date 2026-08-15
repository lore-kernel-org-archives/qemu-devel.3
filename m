Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE8CC5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKk-0007Mu-7w; Sat, 15 Aug 2026 15:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKS-0007Gq-Gi
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKQ-0008FS-3m
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d5655cc850so2241565ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823160; x=1787427960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FcNFOnOL8974glwABu+kV2mxfPSi3R5uRGeROQDc4EQ=;
 b=ngVXFLKiuracZoCOGOGSLyBeH/M2RMz5k819RLU37JYetNRMe/UOEdmNxRTZ97eqlB
 CWmPwxVQNlCIoJGly8xfKI1FBsi6t8qzSbBgMYqJ6t0pNAuOyuAT4cmJXufribmAUeUw
 MdQXfHjxMYjgfKzsZJMnFLZKD1+XuVpkbxvAmHecHYJPDRaYtUYd6+wPpnt/14hI4FqL
 XPvDgIOpVs/qqicB0Bo8sSsBcf+X4RfL8QbYXLcr1/QwGEjulZFez3WnTp1ozYKkGu/C
 iCE2qkveMtK597AsNoE+AHqzD4F5F+Jwy4LlZAcpvbF+3kCmKJbNfZUv1sTPtdtLts3Y
 51kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823160; x=1787427960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FcNFOnOL8974glwABu+kV2mxfPSi3R5uRGeROQDc4EQ=;
 b=hsvkvXEzSEFs716i7lD16/325i5DfBh65mMlsPCpL2gTKpxdvkS9Z02p/Xiz0i9PWU
 Lk3oXDZ7iR0BrKwH7HmT7vka81nym+F5pLIZvDGME1pc6KR0QYL/T/uK2xeZU8gVR1eq
 hNM3DgNy5razTLM0vahF+Px+trVHQ9rAx8pF1kIT4yrQ51Izr1yEnMUFgEDmBAa2WjY7
 75+JlzOC7SPfp6OK3k4YA0rBtOYJJPs4FyA9XBciQt0IjNfD+wGrn+e3RLlA42IHRmFB
 bHGUZb9ooKAK7Qa3zBKgFIu93yNpnWOSluGYOGvwFAduLWpFFYzEpXE8Qd+WMYL2VSdn
 WlAw==
X-Gm-Message-State: AOJu0Yx9h5aeoYneujF92thrJF0LCs6qI/G3WeTdSLzsmEE+43w7Naib
 ECUdYjMC9zCPmoHBNwOoboWgd/UGpG0SH49nGrmb4utxpNqyxBvHm04Z8JPjFdESEreR46MlQAg
 RlK6b
X-Gm-Gg: AR+sD12MDr8P2znUeTBSXemlpvi2jzqASeCukRamSs2gbZU8MSKfkroRvkg7Ag1hus/
 V+8B0pumEFZLlZtUrIj0x0R6Uy9EdB6h4nNDXuxJrBb1jvZNsDGITZHI9KZDKusYNCNjBzQKbnq
 5vxQLqax9uYk6mZi9aDI0ItXLiHUKWtWBviwUR8QSflKx5bjvD9veVuzDrImxSHqZNSmWqc/kSN
 b9WJOwIFoCOdSap7FdkeXm0rna40Ebn5nhrpaYDooWGGGjlaLCtoa8CaCimh3KtE4ZgdQT9DntO
 G/Hi5ocSjMqNXjgBLSQnV9H/+wJSSsrfqksNJphLlJciSDRAr+BMulb1WFfKN5lv/s14B79vqoD
 smktqFx08ETtpBUhCS8Y0wUFnBtgm0f+qTGDn0xlRrBEoKWS4bDnESZxBzz52ImqkVW6X5RgWkp
 YxPH37z7LrTYJysXQmdKVHhoc8d8nm9SRNSwlJUd1R8yGVuFf+Q3nFzNWEs72nRjZ0qgJCmo4mn
 xnT76BO6xpEwmfBRmR2paQkf+hz5Gg=
X-Received: by 2002:a17:902:c40a:b0:2c7:f4bd:91b5 with SMTP id
 d9443c01a7336-2d3b04bba89mr151713965ad.0.1786823160413; 
 Sat, 15 Aug 2026 12:46:00 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 01/23] target/riscv: Split out vext_set_nf_elems_1s
Date: Sat, 15 Aug 2026 12:45:26 -0700
Message-ID: <20260815194549.1377505-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


