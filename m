Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8698C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkru0-0001bl-Eh; Fri, 17 Jul 2026 19:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtw-0001Zw-1K
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:28 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtt-000717-Vj
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:27 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so557253a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330604; x=1784935404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=axCNshnRaz9sCH+JYe9sKgtaQsPlSADENghL889xQUY=;
 b=jMQXmI+GP4Z8tRctsLixEZRmnkvyHeA3JQdlBwN/T1pm+PIvWbg8ZWZNJuDdE/7tb5
 zWDCWHwi+Hyq8bBx++/Nw7adz90JV7gtH7D/iJq4VromN1ww/6anJQJIigq9zPN+VDyN
 vlUfIzS6Fdc8mD7zSzTkElqxoYBuQnDSB1w+75M/Coev23PTX8ubEaSEM8uMZkqbKbD+
 0SX2lj898Ul22tmbaMXl1HvhYyUdiCvpuX1RA5V57k/CjwPNwD4oSGOLPh9S9NjxO05y
 pI+/lrwoGH6cHRuEfv6o1F6XFZsZSo98tGujNXs8h0EhahDjxvgtPJxGJ5YqWsFDa1kC
 T5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330604; x=1784935404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=axCNshnRaz9sCH+JYe9sKgtaQsPlSADENghL889xQUY=;
 b=k2xSY6m69lUN9eqADWiXFact4FvFV/+QnTpQTnaFa05fWbO6BmNkqp+YVOR92PL576
 6LnCLuISd2FSE0duRibww+/hl69hrFitKM/sNl/eVGj3OnEF4lBGvedx4h4l1fWPZL61
 KVXTtS/MA1TWoo2JZApmK6cuiFKajMMTvpcIR/9PmkDolhxHFTbc+aOD7f260kAKcenT
 AggOVUctnJlK3Ehcu1P53X3JphqIa2sIqjpxlCfpx0HmTUUecyr7r9isIT8L1iLjIQzt
 RkDkTLNIhGVzxgErJvsqZ2TDWnZuSLpdpAvejTxdpxF1OFSwxqbIAL1eOSbyROz4ILa6
 8VZA==
X-Gm-Message-State: AOJu0YxnaeJUgdrClK1N4+KAIzJFfeCVjA5MJhugDqhLwjVUCQTlsRN7
 Iws9BzNSH44PXNmcpt85BS/dAkOy/YrrKOC6jgyxoKVVwfJrqBos1PCGViW+IYJmmGrJicpqyHD
 CfY6s
X-Gm-Gg: AfdE7cnWS5EQakLKO+nwiiGSP8Vi4VkEDsZjtJVCo7S+JWNImqS8O4wMscNj5AlVyR7
 P56wjNYRXuuRN97VG0DPPywZUSV+y5j8gX/tBbyyDWoZ9BjRG+FnDkSyV9J5RC6KzTW+Qxqcou5
 bI3A/y+k8RV6k3coujq3vcbVxfUXCPsqPHIQseSsnhvgvnawY+BTIcLAP9tIqHDV9OYz7VYiJuE
 9E7yoh+VldR6rO/jm6Vcx2vXbs3I8XcaSY0bVw+zOi0w83x6mRvhKKTuoPfT+SzOZKyJaOZOhe6
 fj4h3al02VutJVlWhaISCIAQhHhyvXozzFAoc3l6kpsr+wrI27ay1pyjivNlL9sV9pjEHE2JOiK
 0rAe4Q7BNTekRKfBYFAT7nKk2XHw7ttnHNalNOWF4ZYY58OZ3EkzB94f4qVY4YPLyxMkFQ8IVkN
 jlLlIyIb6GjdlLwhpdKA==
X-Received: by 2002:a17:90b:3808:b0:381:cef1:11bb with SMTP id
 98e67ed59e1d1-38e4b51c562mr4861888a91.22.1784330604256; 
 Fri, 17 Jul 2026 16:23:24 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/17] target/arm: Split out helpers for creating MTEDESC
Date: Fri, 17 Jul 2026 16:23:00 -0700
Message-ID: <20260717232306.378988-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Assert that align and size values fit in their fields.
This results in more fields being filled than some
helpers actually use, but uniformity is for the best.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 123 ++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 65 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3d838a4cc1..590c7d8064 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -292,6 +292,43 @@ static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
                             tcg_constant_i32(1 << log2_size));
 }
 
+static TCGv_i32 gen_mtedesc_xas(DisasContext *s, bool write, int idx,
+                                unsigned align, unsigned size)
+{
+    int desc = 0;
+
+    desc = FIELD_DP32(desc, MTEDESC, MIDX, idx);
+    desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+    desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+    desc = FIELD_DP32(desc, MTEDESC, WRITE, write);
+    desc = FIELD_DP32(desc, MTEDESC, ALIGN, align);
+    desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
+    desc = FIELD_DP32(desc, MTEDESC, SIZEM1, size - 1);
+
+    assert(FIELD_EX32(desc, MTEDESC, ALIGN) == align);
+    assert(FIELD_EX32(desc, MTEDESC, SIZEM1) == size - 1);
+
+    return tcg_constant_i32(desc);
+}
+
+static TCGv_i32 gen_mtedesc_xmop(DisasContext *s, bool write,
+                                 int idx, MemOp memop)
+{
+    return gen_mtedesc_xas(s, write, idx, memop_alignment_bits(memop),
+                           memop_size(memop));
+}
+
+static TCGv_i32 gen_mtedesc_as(DisasContext *s, bool write,
+                               unsigned align, unsigned size)
+{
+    return gen_mtedesc_xas(s, write, get_mem_index(s), align, size);
+}
+
+static TCGv_i32 gen_mtedesc_zva(DisasContext *s)
+{
+    return gen_mtedesc_as(s, true, 0, s->dcz_blocksize);
+}
+
 /*
  * For MTE, check a single logical or atomic access.  This probes a single
  * address, the exact one specified.  The size and alignment of the access
@@ -305,20 +342,10 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
 {
     if (tag_checked && s->mte_active[is_unpriv] &&
         (is_write || !s->mte_store_only[is_unpriv])) {
-        TCGv_i64 ret;
-        int desc = 0;
-
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, core_idx);
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(memop));
-        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
-
-        ret = tcg_temp_new_i64();
-        gen_helper_mte_check(ret, tcg_env, tcg_constant_i32(desc), addr);
+        TCGv_i64 ret = tcg_temp_new_i64();
+        TCGv_i32 desc = gen_mtedesc_xmop(s, is_write, core_idx, memop);
 
+        gen_helper_mte_check(ret, tcg_env, desc, addr);
         return ret;
     }
     return clean_data_tbi(s, addr);
@@ -339,20 +366,12 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
 {
     if (tag_checked && s->mte_active[0] &&
         (is_write || !s->mte_store_only[0])) {
-        TCGv_i64 ret;
-        int desc = 0;
-
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(single_mop));
-        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
-
-        ret = tcg_temp_new_i64();
-        gen_helper_mte_check(ret, tcg_env, tcg_constant_i32(desc), addr);
+        TCGv_i64 ret = tcg_temp_new_i64();
+        TCGv_i32 desc = gen_mtedesc_as(s, is_write,
+                                       memop_alignment_bits(single_mop),
+                                       total_size);
 
+        gen_helper_mte_check(ret, tcg_env, desc, addr);
         return ret;
     }
     return clean_data_tbi(s, addr);
@@ -3119,16 +3138,9 @@ static void handle_sys(DisasContext *s, bool isread,
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
         if (s->mte_active[0]) {
-            int desc = 0;
-
-            desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-            desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-            desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-            desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
-
             tcg_rt = tcg_temp_new_i64();
-            gen_helper_mte_check_zva(tcg_rt, tcg_env,
-                                     tcg_constant_i32(desc), cpu_reg(s, rt));
+            gen_helper_mte_check_zva(tcg_rt, tcg_env, gen_mtedesc_zva(s),
+                                     cpu_reg(s, rt));
         } else {
             tcg_rt = clean_data_tbi(s, cpu_reg(s, rt));
         }
@@ -4967,7 +4979,8 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
                    bool is_setg, SetFn fn)
 {
     int memidx;
-    uint32_t syndrome, desc = 0;
+    uint32_t syndrome;
+    TCGv_i32 desc;
 
     if (is_setg && !dc_isar_feature(aa64_mte, s)) {
         return false;
@@ -4992,23 +5005,15 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
     syndrome = syn_mop(true, is_setg, (a->nontemp << 1) | a->unpriv,
                        is_epilogue, false, true, a->rd, a->rs, a->rn);
 
-    if (is_setg ? s->ata[a->unpriv] : s->mte_active[a->unpriv]) {
-        /* We may need to do MTE tag checking, so assemble the descriptor */
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, true);
-        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
-        /* SIZEM1 and ALIGN we leave 0 (byte write) */
-    }
-    /* The helper function always needs the memidx even with MTE disabled */
-    desc = FIELD_DP32(desc, MTEDESC, MIDX, memidx);
+    /* Construct the descriptor whether MTE is enabled or not. */
+    desc = gen_mtedesc_xmop(s, true, memidx, MO_UB);
 
     /*
      * The helper needs the register numbers, but since they're in
      * the syndrome anyway, we let it extract them from there rather
      * than passing in an extra three integer arguments.
      */
-    fn(tcg_env, tcg_constant_i32(syndrome), tcg_constant_i32(desc));
+    fn(tcg_env, tcg_constant_i32(syndrome), desc);
     return true;
 }
 
@@ -5024,7 +5029,8 @@ typedef void CpyFn(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32);
 static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
 {
     int rmemidx, wmemidx;
-    uint32_t syndrome, rdesc = 0, wdesc = 0;
+    uint32_t syndrome;
+    TCGv_i32 rdesc, wdesc;
     bool wunpriv = extract32(a->options, 0, 1);
     bool runpriv = extract32(a->options, 1, 1);
 
@@ -5048,29 +5054,16 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
     syndrome = syn_mop(false, false, a->options, is_epilogue,
                        false, true, a->rd, a->rs, a->rn);
 
-    /* If we need to do MTE tag checking, assemble the descriptors */
-    if (s->mte_active[runpriv]) {
-        rdesc = FIELD_DP32(rdesc, MTEDESC, TBI, s->tbid);
-        rdesc = FIELD_DP32(rdesc, MTEDESC, TCMA, s->tcma);
-        rdesc = FIELD_DP32(rdesc, MTEDESC, MTX, s->mtx);
-    }
-    if (s->mte_active[wunpriv]) {
-        wdesc = FIELD_DP32(wdesc, MTEDESC, TBI, s->tbid);
-        wdesc = FIELD_DP32(wdesc, MTEDESC, TCMA, s->tcma);
-        wdesc = FIELD_DP32(wdesc, MTEDESC, WRITE, true);
-        wdesc = FIELD_DP32(wdesc, MTEDESC, MTX, s->mtx);
-    }
-    /* The helper function needs these parts of the descriptor regardless */
-    rdesc = FIELD_DP32(rdesc, MTEDESC, MIDX, rmemidx);
-    wdesc = FIELD_DP32(wdesc, MTEDESC, MIDX, wmemidx);
+    /* Assemble the descriptors regardless of MTE enabled. */
+    rdesc = gen_mtedesc_xmop(s, false, rmemidx, MO_UB);
+    wdesc = gen_mtedesc_xmop(s, true, wmemidx, MO_UB);
 
     /*
      * The helper needs the register numbers, but since they're in
      * the syndrome anyway, we let it extract them from there rather
      * than passing in an extra three integer arguments.
      */
-    fn(tcg_env, tcg_constant_i32(syndrome), tcg_constant_i32(wdesc),
-       tcg_constant_i32(rdesc));
+    fn(tcg_env, tcg_constant_i32(syndrome), wdesc, rdesc);
     return true;
 }
 
-- 
2.43.0


