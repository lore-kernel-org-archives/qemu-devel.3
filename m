Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1153C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKk-0007Nj-Qn; Sat, 15 Aug 2026 15:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKZ-0007Iy-K0
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKY-0008I4-0I
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso19521715ad.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823166; x=1787427966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xezu+aLsn29Ptsvz8sNuNE28HxsbWNLxvXcnJIkVSDs=;
 b=Fe6TLIt884ZvJ+ohOFN/jdS8H4addubspWwEcIwnv3B9WXJoP7+3wT1MKe6bAfx/av
 vyMQscmYYjgGn2IBOFEFsGAst3T2FnXwLjobMZawTpQ6AkyF/TjHmYC29h/zE3s3q8nR
 PhpET2RKIYZXVF4AOvK4k2OxhZfIpBcYiXWqPdKtF+HRfIrVPHRQLtVojkgtlTmruCJ3
 xFvFyDYwc0vbDtGbEOR6WUAI3tl7igzXyGUcSC7s+Hp+rb1mrX+KHsa2iir9LAY3OKGc
 7GYvV5FvBaOTbp17siZ1khqnIf6wgso+QKBX+isOWkJyw8MVYgEr4w4CsUEoWjV7RTdc
 n7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823166; x=1787427966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xezu+aLsn29Ptsvz8sNuNE28HxsbWNLxvXcnJIkVSDs=;
 b=G6Jzs6c1bsd9lWwUyVI/rh0LkBc/Gjkdu8P3vgVgWq6vusP6y9pS+kxWQpuD0opUyy
 L/RgvhJw5jl6xlX3MBbHWnLED1PEl7hgzxbAmWAF7e6O+iSTtIx2LMvOoThqu/p9I01R
 nBpdpSKROGhAxZNAI5xJemICLXoXshO9o9aqWLNWAzDmiZccT5+tYNH8Wqe8+qnKc4pu
 qu7U8EoeTvsK57+brJa8J4lLuUUD8/A6CfWYNnW2m/JYGazrCH2qqTQ+r7BGEjxzUcoV
 mRq26rdG/AsJldEK4NqtyxPBPiiuYm++Kf8gt42LrH84sRRPwHH07VKwoVeShbNSKgHK
 ZoMA==
X-Gm-Message-State: AOJu0YyrZ41fF91WXA3rBVxbqpMRE99ArhO10eMbgqACtRGFj6UKW3Sk
 /DpVZ+VT1rS3wuzqkQs81/k1I82QDhqBIDa7NYo4/j/H8MfK24I5PedBSK7gB1bb9vmYRO3Tq+C
 Cj3jx
X-Gm-Gg: AR+sD10Z4rGlOnjfksWNHIQvrqovwLnRwxfklGYziwHFF9vNmhYeu0flHaXESy2EM5W
 eGJ8VxsGfCwTHZNJKL4susFYBwHSyaWN3hMqf63mr4gh+WgeJyaOsn+WPdaPrXspwWgxkJ2a91h
 4STItK3QMiFp2ikreob/hj9S+ZiAoUUJAb4EH0wnYmYuYTnUWceUqNivmt94CSbztaQ3UgtiCd+
 k7cjoHWimLknfwR065TY3C75jjdXqYiJTRzLxvyFfzy5fdCSoSTkiBg8u35EEp9U9If5fQCv7tF
 1zkEaTYpvzLVEJbZjf/qWIpkib73NVhlPC+5QMPQzo5KQwGHP3O2z5yiJml0Lod9TuUiSPcYhMJ
 urKh0JXoqTLg9g9H/wilsAQlziWTXA1DPiWQmNQk3qQuYecsaN5Nr9aqIxZL57B+PKUKn8y26Pu
 ez9QVFUwTOa3rZ93wg/An6FXfqyhPdrIw+0fFDyE7A89iHJe+24nJNI+SeCx1DneaFN3jirZSxM
 587EJvwd/zOO+m3JkarXws34LVi2vI=
X-Received: by 2002:a17:902:cf03:b0:2cf:ca89:499d with SMTP id
 d9443c01a7336-2d3b0b1f7a7mr153331045ad.7.1786823165729; 
 Sat, 15 Aug 2026 12:46:05 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 07/23] target/riscv: Remove vext_continuous_ldst_tlb
Date: Sat, 15 Aug 2026 12:45:32 -0700
Message-ID: <20260815194549.1377505-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Drop the usage in vext_page_ldst_us, merging the nf == 1
case into the vext_ldst_nf_tlb loop.
Inline it into the last use in vext_ldst_us.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 34 ++++++++++----------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index a571982388..79c1d77a14 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -297,17 +297,6 @@ GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
 GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
 GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
-static inline QEMU_ALWAYS_INLINE void
-vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
-                         void *vd, uint32_t evl, target_ulong addr,
-                         uint32_t reg_start, uintptr_t ra, uint32_t esz)
-{
-    uint32_t i;
-    for (i = env->vstart; i < evl; env->vstart = ++i, addr += esz) {
-        ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
-    }
-}
-
 static void vext_set_tail_elems_1s(uint32_t vl, void *vd, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
 {
@@ -456,15 +445,10 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
         }
         env->vstart += elems;
     } else {
-        if (nf == 1) {
-            vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr,
-                                     env->vstart, ra, esz);
-        } else {
-            for (uint32_t i = env->vstart; i < evl; env->vstart = ++i) {
-                vext_ldst_nf_tlb(env, vd, addr, i, nf, esz,
-                                 max_elems, ldst_tlb, ra);
-                addr += msize;
-            }
+        for (uint32_t i = env->vstart; i < evl; env->vstart = ++i) {
+            vext_ldst_nf_tlb(env, vd, addr, i, nf, esz,
+                             max_elems, ldst_tlb, ra);
+            addr += msize;
         }
     }
 }
@@ -487,13 +471,15 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
 #if defined(CONFIG_USER_ONLY)
     /*
-     * For data sizes <= 6 bytes we get better performance by simply calling
-     * vext_continuous_ldst_tlb
+     * For data sizes <= 6 bytes we get better performance
+     * by simply calling ldst_tlb.
      */
     if (nf == 1 && (evl << log2_esz) <= 6) {
         addr = base + (env->vstart << log2_esz);
-        vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr,
-                                 env->vstart, ra, esz);
+        for (uint32_t i = env->vstart; i < evl;
+             env->vstart = ++i, addr += esz) {
+            ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
+        }
         env->vstart = 0;
         if (vma) {
             vext_set_tail_elems_1s(evl, vd, nf, esz, max_elems);
-- 
2.43.0


