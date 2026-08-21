Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B13BC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUP-00062A-IB; Fri, 21 Aug 2026 00:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUL-0005zZ-W5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:18 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUK-0003AW-C7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so397201a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285055; x=1787889855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sk77f80WPvGO0zvaNiZBatjOOICFxmk3ZLvZH1EsYws=;
 b=wgM85RCKFgEQsb6JogHs0pGd/9v/f5j1eM0VEmENTcGIUnulqcUCVo3LUeqbbjXY1h
 SYz/22MiBKw/Tz+KdB2dppG6KY+t+weYPuqAgvgUtEWfdmhHHS4p8Tk5tMuUGX9bjuN3
 mxuHbn1iWSeh9KgPTd4Onbo2+Hh0LNzMKNmjoFxKRIg+o46Gedq8yEoYGMUiGijSlNtE
 Y6FHDovgQJG0IZ+9/gCHcIzSkqKdr6uGHsl9/l9aahfn9fMVbxcYFlOFhtXyILp03BVy
 xjZNTZQbnTZMIIOQuZ+ZFYGul0uLKjdjBX1AJQIo3g1/21J9lecgxoPqE3pBi+lzdS9I
 iNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285055; x=1787889855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sk77f80WPvGO0zvaNiZBatjOOICFxmk3ZLvZH1EsYws=;
 b=eI8Mce3myjdtFKD7tiiRfINWoajPnrHVJ/vUHtlUfIN3kwdzZpTsGEvgPdzoLkzG1t
 c5kECbJYattSywc5HRvisBb3lFbnzkwX9agxlIp2e0fNxGbxiyxO07WB/HkeAH3oFw7t
 zAjxIgYAdFWjglyjubEfasgQB5SGUb8FveMMb5xRnMqVPPjHsDyz5Ak/FaA7TL7AxX6o
 h90VLuP13EF6PxBl7LUyHo0928UCKcV8zU8o3SMqDUCnjKZrIcALuToRgn9tFSn6q6wU
 keQ0sOAOlWZuDQ/Sx79zIuYP6K3cA+ZmmuukEeKifdW9Kcfq1us/6OD7Ll2PsGXMdau2
 Fk9Q==
X-Gm-Message-State: AFuF++mJvk5Jh+iRkuxN0upRR+l0Ibl8Vo0rvykcEbNVSBI3Sv/fMWZk
 q4RWr50sfYE35QWhcMXhjhohyvovta5KSc3dpothokinxfSCacpw1M4UkquCtILZsK2OmC4uFGO
 ZVT/b
X-Gm-Gg: AR+sD100pxHcvCH7uEHlNRowqNKZ5paVdoBVDhPkMgncxhw41UnpN8HJpvPsYh3uDzU
 7+rgvI94mjRtToD86w6+PfO07sNRHVgShxtBAtuTaSUBJUbGqe2A9N4qL2nGt2FEpq9DTG5RNdx
 0k/pQTU80qlDet2j3jqXL7TG2haLHfwpXXlsM7OSYZLQech1m+1FobJW/01RiAB2ejT35wnoItI
 +MKs4UBawppbOQObYpGenKwm0mqefQb5qqeyGOGIvQMraEJRtR36xwwtTMoxUL3xZnnxG8bjAXM
 TYr2W8xRBAHXL+1EvdDdIGz/pru8TC+iseINEaXcnSJ5+gFiX/L8vUp8Gsr5Hp/aOd3u83DdDxB
 6qsV+Vp/3gGvr1X6kmxaigVtz7cX77/MPz6+CBDj1WEHIAdyjSorfRo405Ilp6/xZm2d9nwNkhz
 o7brPLNmMA+iHJDnJULogJ0KYuAsUZ8BQeNwkmEF5m7x9fiYbYPh3LfiAXiDYPL7p+pdAeEBUV4
 o3Yyg==
X-Received: by 2002:a17:90b:4c49:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-395c354d42dmr5747738a91.1.1787285054918; 
 Thu, 20 Aug 2026 21:04:14 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 05/23] target/riscv: Remove vext_continuous_ldst_tlb
Date: Thu, 20 Aug 2026 21:03:46 -0700
Message-ID: <20260821040404.268123-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Drop the usage in vext_page_ldst_us, merging the nf == 1
case into the vext_ldst_nf_tlb loop.
Inline it into the last use in vext_ldst_us.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 34 ++++++++++----------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index da1e704c56..63a51f2b48 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -272,17 +272,6 @@ GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
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
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
                         void *vd, uint32_t evl, uint32_t reg_start, void *host,
@@ -465,15 +454,10 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
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
@@ -495,13 +479,15 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
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
         vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
         return;
-- 
2.43.0


