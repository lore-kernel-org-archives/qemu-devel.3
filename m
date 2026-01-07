Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82246CFD647
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVF3-0007tR-7G; Wed, 07 Jan 2026 10:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEn-0007mT-LJ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEl-0007O1-GE
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767798853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5N4837EjUk6A+hFp2Rk+h8B1Uk50LtkfD2wo65Id1I=;
 b=B1mCRgaXx56SyEwClHdeIbH3RGlygFmZ/PQWmhiUDTkYIUKUIzPDAeMU7kd+n+fYN3dfQI
 ecLuNvzVGU616gxDOYK8UtAFl0FrKvMHA5aixn8mWSJAGNEy6Yl6Cf1woPxLGhfu2GRW6K
 pQ1JkR/g7Apdl20pT3T2IieH/ZCfVT4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-_EDv0doCMA-XKJFTMbEZHQ-1; Wed, 07 Jan 2026 10:14:11 -0500
X-MC-Unique: _EDv0doCMA-XKJFTMbEZHQ-1
X-Mimecast-MFC-AGG-ID: _EDv0doCMA-XKJFTMbEZHQ_1767798850
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432c05971c6so755726f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767798849; x=1768403649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5N4837EjUk6A+hFp2Rk+h8B1Uk50LtkfD2wo65Id1I=;
 b=f9mFbE5GWnoeFsmdoXkzu/TvRd1r9EujsWlOCb/1zkJOx8JqTmTKVMBt9Q1hxrXT6t
 dEhfC3+WD2/BfncAwSkEMlY4J/SzIap+Xd9CZr3Z4EKah8EEmhsAFi00/pyJFmqPY/YR
 6nnHefOvPCUDSNVTgc/BwH26RzKkVvjP9cTEKAS9Yz29gJdFvq2Zt5GYFSgYyz3MQoIL
 D04Dr1RKBnBJQfBzNl2AsuGKukgafte8noqvu20rTulkuqOZAlXeFpcqgxZ1loa0iXGU
 gy4A4J2mJ0Z0XT8qsSvhoZU/GovVJenY2uxh5Ki8xOQy33ZVcROgRC6puYMctHl5ea37
 cjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767798849; x=1768403649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b5N4837EjUk6A+hFp2Rk+h8B1Uk50LtkfD2wo65Id1I=;
 b=Pjjf2meDYEr2+mKWZANhA1bh+t27VK02kmReNzPX3RVVI++lqyV3A/JczV5LjloM5w
 y5iTjmbiRN3kmkOTXz0SHrXoMDPxYEk2KbyeqN/CEmnUk/xbNopDqooBTbwIe6fTD/fs
 z4AW4P4vRdBtfIvdi3Ig3+Q31pC4HeGwfp5KyvqZXHJ/Ej01PP+zlLEh4MfdC01VSwRK
 6urq3QifvnkYrUq6k1W3VbJXofmbbQPg6UFs0G2qOROsuQ/aUUUJT56gcVrf4QMWIILV
 TL/3TCkCPsMLkGLJLe7wCXVS+d3w16nfwMntNF16vyjA3soqjcIP6fkjYyM8EI5tCy/X
 1srA==
X-Gm-Message-State: AOJu0YyrZqaZpg+leivNQ8tsZxePMA/aVmyuLe1OwJ0RVEVbdcUDLjhC
 pS57Gk7DNX6zYZ1nKPV7xcal/GdnsxKDX9Zl69x4dA+qtkQHJcw2QugxBh4HEEzLSi6EYnVDus2
 ILsu72fNS8vmGX/I5uhH596uEIxxLwSy2XSDakMKUcOG6jGMZHhjlYzJLSWH/yJD1H2yEBHX688
 aOcYn3OSTbOFQttOlIBn6mRax1fn8pQBIy0RGODdY+
X-Gm-Gg: AY/fxX7QQm4g3tYB/toqcQixB+F8MKyMUeqMkQhJETBjluCD9zcDOaVJyQeHoAfbxN5
 QEtf/YGnx+IEGffIqW4KwT2Vg3BXyyy+nytGkXXKWtb6IBCvxBOpVovODMWLoZK1p7vzjcU1+kN
 vzxS/v2Nw710yi9x7ZmvmXvDo1UycCnDI7pusR/tJ5cpN0dd2Kzafo6GP5BGPFOMcpPxKCA4g64
 +XTuU7AxvUqp+rgIGwQR6tNfa5WEGnTGjb3LVQxq4R1Q/bPXPxK3+pvX/Lpa3TvYFmOwubFBAah
 pRCnnvhkHfP9U7XlXNs90isKGaZcMm4LkYwc3Tq7wtC/RcFMJurN5/bOhAYsylYOEvorXtVap39
 FQZeclphnX1qPtg83UKyMO4is8qpot1orKwoNiTZ1U3YLIct8eJpSC6ufNlc47HyS66KtBpwlEQ
 SNRju9RE8wgf9eGg==
X-Received: by 2002:a05:6000:2207:b0:429:b963:cdd5 with SMTP id
 ffacd0b85a97d-432c362bf78mr3691857f8f.5.1767798849262; 
 Wed, 07 Jan 2026 07:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS8lL9c2l2qIT9Gm3wYWE3BvU8lEE5atwed9X2oiUnBRm0UcZY1c5MeO6Nbkjhl4cTKTW7Ew==
X-Received: by 2002:a05:6000:2207:b0:429:b963:cdd5 with SMTP id
 ffacd0b85a97d-432c362bf78mr3691807f8f.5.1767798848762; 
 Wed, 07 Jan 2026 07:14:08 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff1e9sm11438731f8f.41.2026.01.07.07.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:14:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 3/5] target/i386/tcg: mask addresses for VSIB
Date: Wed,  7 Jan 2026 16:13:58 +0100
Message-ID: <20260107151400.273916-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107151400.273916-1-pbonzini@redhat.com>
References: <20260107151400.273916-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VSIB can have either 32-bit or 64-bit addresses, pass a constant mask to
the helper and apply it before the load.

Cc: qemu-stable@nongnu.org
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


