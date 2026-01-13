Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE819D0C856
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLW-00039s-E9; Tue, 13 Jan 2026 06:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLP-00034a-5J
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLN-0008Qo-EY
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAGJdZeq72e7lqjI+nG9SVEULVr7dvOgvkxQoZpywUo=;
 b=RVEjzhFI5Mi58nBzilWXzMrwl/wX0IiZVekDhKiP7oGj16fvIH2FvKK1Zfb46inU+TQrNe
 9EAMlu6QU1Y7FGfIL/vI9EKqTFxeFOqkGc3FvjAy9kvwZm5j72eTbGBt0/rAChn5WpmcXC
 ock9+06nSfx/mM1FGYGvcgfFmZGPwqY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-hEvwZ2fGPduJ-aeVb14YPw-1; Tue, 13 Jan 2026 06:13:47 -0500
X-MC-Unique: hEvwZ2fGPduJ-aeVb14YPw-1
X-Mimecast-MFC-AGG-ID: hEvwZ2fGPduJ-aeVb14YPw_1768302826
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso58011305e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302825; x=1768907625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAGJdZeq72e7lqjI+nG9SVEULVr7dvOgvkxQoZpywUo=;
 b=kLGXRvZ759VYqGHOLPXZLYDGcZLqH0We4zl6kvFEB/2r6zqRB+gSkzduzqaZblfcPh
 SWqk5T3xZB4IbhoFHVhnjFHWeJ+lMmLJRzKxBqD9uMANvg6JwBk8nVMMkcviPZRx5QWg
 hpUhx75CbrplJN2eeXj5T/UXSu2Va2xS5XxptOP+OdJPynLX2D5sZ/yvLwn7L0LPKSW8
 CO1RW9e/y8Xi5bFrbTI2S6zfh12iDBvTxhmGTQwWKfOR4kEX/aeowlz+2Ld3MpaqBrwO
 g0kBKt72DzVcy+lqD2l/Na7bRBVgsx4qqTBObHNnY7Qd2dByT5vfL2P/jczkHfiBRE2A
 Aesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302825; x=1768907625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZAGJdZeq72e7lqjI+nG9SVEULVr7dvOgvkxQoZpywUo=;
 b=sUhgdOClRlxcl6UvICLc81rNuaG7LGyyzOJWbLb0SL9yApxMRl1llReguTlVTd7IRP
 nvuNhl92oHOc1f1Ke2GCI9LgZuHuVn0SppdEDaZM51qoCtOV2eH+OAwbKmfBr+JAkgyb
 W0n4kXoTlY5NFgCrDVLfs4t2DPmoPvh7oC4Hx7X0xl86OCDpvUBg9hmrZmJWdq6xEmjN
 ZX0yUlgsaNP9EXAGgxppKIJs96c4i8pecQKjVUusVv0xVZwN1CsjxpMW0VLDHKJ8JdxP
 92bWiTux6KS2njwvK0LBz+/j2R2JwzcV0H4wNtRPpIAL9tFhAOcGh7OIRDt+MvukQCP4
 jGWA==
X-Gm-Message-State: AOJu0YzKmT9W2KFcDcZPkkx+wNaKZNGWB84czzQpFJDKesVrng90z7Co
 Lf3PgAcdzQthZA/0+wAhKY7ZXI6pxsLxGRCsqz9c3+8yAfX5CrbDBODt4L8ux0/X74VN9EUyXB+
 vaOUPJvaZWxijw/RkelPCwb3uajSBYoZcIFceZdkeJqQYCr7HLqcKDhrdRdSuohVO+e/1Ronj4t
 ws1htnTyWOcJUE27dscviL9dVKWDM4JBxFkSdamwrQ
X-Gm-Gg: AY/fxX5eif8rNtZG/3gEbeM6LLxsnOYn6QMsJjUeNN1YzbCSLO9TmAyo00P+No5bQA7
 8dqNL4mL4jdETv+5t3RXmCLgooqNysFf5HRCOPxmH2NByZD7kCkEE13+nEvJoYuYlovFWRDBZJv
 sPtTQif05tC/CRa0byW2+mEybBk98PuhnUvwLKmJhkVBj0MwNWGPDsrWrdGjNgfF/9kJeFrju8p
 FOWVa+lfJ/WjjljvVg4vyD5TFVEbSrX7Dpq2m/gOYFKdRNRG1m46Y+iYp4DPsjDuZUr6KTA792u
 u1ACFX4yM5stJ5SggKCTiOr5bpD2fNleSWrYbwVT0nTzxWC1rOm+zayGnxY6+YTVIXF1wYwTe3G
 B0fPSaFFlpwrJzrjVGCRWniD0lw3KlvWYlx0BOVa6KrS6bkptRBoBKfdVd+IOLENZzHPblXlKtV
 rNi5KF8CgWkqRAHg==
X-Received: by 2002:a05:600c:630d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d84b1fea3mr282725615e9.9.1768302824862; 
 Tue, 13 Jan 2026 03:13:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0vu7l+29lBBF5GQXB2a7VgpynFCRmINiKpzuZKLbgoF77PKUp47VonpZ7ssytXaEORzSZGA==
X-Received: by 2002:a05:600c:630d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d84b1fea3mr282725135e9.9.1768302824392; 
 Tue, 13 Jan 2026 03:13:44 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dfa6dc4esm21790413f8f.23.2026.01.13.03.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/7] target/i386/tcg: mask addresses for VSIB
Date: Tue, 13 Jan 2026 12:13:30 +0100
Message-ID: <20260113111333.1138160-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
References: <20260113111333.1138160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VSIB can have either 32-bit or 64-bit addresses, pass a constant mask to
the helper and apply it before the load.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h                | 16 ++++++++--------
 target/i386/tcg/ops_sse_header.h.inc |  8 ++++----
 target/i386/tcg/emit.c.inc           | 17 +++++++++--------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index a2e4d480399..853196b2bbd 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2362,42 +2362,42 @@ void glue(helper_vpmaskmovq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 void glue(helper_vpgatherdd, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (2 << SHIFT); i++) {
         if (v->L(i) >> 31) {
             target_ulong addr = a0
                 + ((target_ulong)(int32_t)s->L(i) << scale);
-            d->L(i) = cpu_ldl_data_ra(env, addr, GETPC());
+            d->L(i) = cpu_ldl_data_ra(env, addr & amask, GETPC());
         }
         v->L(i) = 0;
     }
 }
 
 void glue(helper_vpgatherdq, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (1 << SHIFT); i++) {
         if (v->Q(i) >> 63) {
             target_ulong addr = a0
                 + ((target_ulong)(int32_t)s->L(i) << scale);
-            d->Q(i) = cpu_ldq_data_ra(env, addr, GETPC());
+            d->Q(i) = cpu_ldq_data_ra(env, addr & amask, GETPC());
         }
         v->Q(i) = 0;
     }
 }
 
 void glue(helper_vpgatherqd, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (1 << SHIFT); i++) {
         if (v->L(i) >> 31) {
             target_ulong addr = a0
                 + ((target_ulong)(int64_t)s->Q(i) << scale);
-            d->L(i) = cpu_ldl_data_ra(env, addr, GETPC());
+            d->L(i) = cpu_ldl_data_ra(env, addr & amask, GETPC());
         }
         v->L(i) = 0;
     }
@@ -2408,14 +2408,14 @@ void glue(helper_vpgatherqd, SUFFIX)(CPUX86State *env,
 }
 
 void glue(helper_vpgatherqq, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (1 << SHIFT); i++) {
         if (v->Q(i) >> 63) {
             target_ulong addr = a0
                 + ((target_ulong)(int64_t)s->Q(i) << scale);
-            d->Q(i) = cpu_ldq_data_ra(env, addr, GETPC());
+            d->Q(i) = cpu_ldq_data_ra(env, addr & amask, GETPC());
         }
         v->Q(i) = 0;
     }
diff --git a/target/i386/tcg/ops_sse_header.h.inc b/target/i386/tcg/ops_sse_header.h.inc
index d92c6faf6d6..bbeb7301c33 100644
--- a/target/i386/tcg/ops_sse_header.h.inc
+++ b/target/i386/tcg/ops_sse_header.h.inc
@@ -388,10 +388,10 @@ DEF_HELPER_4(glue(vpmaskmovd_st, SUFFIX), void, env, Reg, Reg, tl)
 DEF_HELPER_4(glue(vpmaskmovq_st, SUFFIX), void, env, Reg, Reg, tl)
 DEF_HELPER_4(glue(vpmaskmovd, SUFFIX), void, env, Reg, Reg, Reg)
 DEF_HELPER_4(glue(vpmaskmovq, SUFFIX), void, env, Reg, Reg, Reg)
-DEF_HELPER_6(glue(vpgatherdd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
-DEF_HELPER_6(glue(vpgatherdq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
-DEF_HELPER_6(glue(vpgatherqd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
-DEF_HELPER_6(glue(vpgatherqq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
+DEF_HELPER_7(glue(vpgatherdd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
+DEF_HELPER_7(glue(vpgatherdq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
+DEF_HELPER_7(glue(vpgatherqd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
+DEF_HELPER_7(glue(vpgatherqq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
 #if SHIFT == 2
 DEF_HELPER_3(vpermd_ymm, void, Reg, Reg, Reg)
 DEF_HELPER_4(vpermdq_ymm, void, Reg, Reg, Reg, i32)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e55b65176fc..bc3a07f972c 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -43,8 +43,8 @@ typedef void (*SSEFunc_0_pppi)(TCGv_ptr reg_a, TCGv_ptr reg_b, TCGv_ptr reg_c,
                                TCGv_i32 val);
 typedef void (*SSEFunc_0_eppt)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
                                TCGv val);
-typedef void (*SSEFunc_0_epppti)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
-                                 TCGv_ptr reg_c, TCGv a0, TCGv_i32 scale);
+typedef void (*SSEFunc_0_eppptit)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
+                                 TCGv_ptr reg_c, TCGv a0, TCGv_i32 scale, TCGv amask);
 typedef void (*SSEFunc_0_eppppi)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
                                   TCGv_ptr reg_c, TCGv_ptr reg_d, TCGv_i32 flags);
 typedef void (*SSEFunc_0_eppppii)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
@@ -1100,18 +1100,19 @@ VEXW_AVX(VPMASKMOV, vpmaskmov)
 
 /* Same as above, but with extra arguments to the helper.  */
 static inline void gen_vsib_avx(DisasContext *s, X86DecodedInsn *decode,
-                                SSEFunc_0_epppti d_xmm, SSEFunc_0_epppti q_xmm,
-                                SSEFunc_0_epppti d_ymm, SSEFunc_0_epppti q_ymm)
+                                SSEFunc_0_eppptit d_xmm, SSEFunc_0_eppptit q_xmm,
+                                SSEFunc_0_eppptit d_ymm, SSEFunc_0_eppptit q_ymm)
 {
-    SSEFunc_0_epppti d = s->vex_l ? d_ymm : d_xmm;
-    SSEFunc_0_epppti q = s->vex_l ? q_ymm : q_xmm;
-    SSEFunc_0_epppti fn = s->vex_w ? q : d;
+    SSEFunc_0_eppptit d = s->vex_l ? d_ymm : d_xmm;
+    SSEFunc_0_eppptit q = s->vex_l ? q_ymm : q_xmm;
+    SSEFunc_0_eppptit fn = s->vex_w ? q : d;
     TCGv_i32 scale = tcg_constant_i32(decode->mem.scale);
     TCGv_ptr index = tcg_temp_new_ptr();
+    TCGv mask = tcg_constant_tl(MAKE_64BIT_MASK(0, 8 << s->aflag));
 
     /* Pass third input as (index, base, scale) */
     tcg_gen_addi_ptr(index, tcg_env, ZMM_OFFSET(decode->mem.index));
-    fn(tcg_env, OP_PTR0, OP_PTR1, index, s->A0, scale);
+    fn(tcg_env, OP_PTR0, OP_PTR1, index, s->A0, scale, mask);
 
     /*
      * There are two output operands, so zero OP1's high 128 bits
-- 
2.52.0


