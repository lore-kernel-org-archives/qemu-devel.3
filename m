Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1917C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUO-00061b-A1; Fri, 21 Aug 2026 00:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUL-0005yv-Eo
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:17 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUI-0003A2-OO
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:17 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso687692a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285053; x=1787889853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=taAgCVdsYQnHbEJNFb0X0g9aT5v9jNXyAHV3dCosVWA=;
 b=zR/hYNUheXP3fxmqSwV2kMCBUCydFFrVouoDIIa7WiAmWSasnCHNjzGm9Cof6K0Bh8
 F4Vo0n6z1v4QhWcrCIitSEYu83Rh2XQtyzsBcVGtXfEs3muNxGLQB2xDbcRJvn1Y+VXF
 TUmi1bn+mY2xt4imXBMoZOoduzJ92g4CoAZx7/9WQqr+ojLpOORINzK0Q3pa3xiTMZyN
 i9PdBco9zul0eM2PO2Gr/8m0xJK+BSqF7ywFmiwFtTQBNVe+6j4Afnf/UodzsAHoodEA
 jS7SojaFyrh5WzpXXY6acENbL4fP4mWf/eH79HI3g2Rc4K3PGafb8qGbfClONaQdvbW0
 D5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285053; x=1787889853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=taAgCVdsYQnHbEJNFb0X0g9aT5v9jNXyAHV3dCosVWA=;
 b=MOpOorY6kQ8VQAgcrYO1c6jSuOL16OhUsWqzgas8GY9CQh2RSObaz3Rb6g3JHHje8N
 6by7aeiEeLGD0Cg+ZAqw43JY3+QQlyd2coTfVfXcuLm/n/VQa+bqzx2XlsYgsEyytpyh
 Z9CJnU0WNzRR4D0sUfJEDeVbVQh7RoY7JgDf6J8Zpet6Xlg9nZc3XU8eMG28/dRyoS2F
 s5Pz7he/q4bq2Igh4qRXAT69oYPo0CnqapcvYGj0OmXHW1V5bTa4f3E3v55AIhK2cTs3
 JXynw10E5MinMJTeZQUPnAGwyh4hYPESH3eEyMHdvYmEcLjKTqr65Iviq9/pGGfXrvaF
 vJ3A==
X-Gm-Message-State: AFuF++ncUBZgSrn/TZnAipDUMjjv2KvcDaDp9E9qvTf98EKSB/WXnJBY
 tRspcvUyL7ENUAXFcApXitBYBLuAZiYdW7xuGc6/O7Ma86bcVagtyrJtlepkrPCymIYMy2UDToY
 W/50J
X-Gm-Gg: AR+sD12YmwI8zaBLijG4e67ZD6keprDT68OAVnNYHkkH2wYjybQUsuKQB7HuLFRrsPC
 iwxipmTtOGJV73VC6CfSSEbC1Fmq3qaVvLzhvighyGzA3c6w2Ssr7D1P+BzxDY6kOcEGhrAkRBf
 y0caekkB/Z4rwZFfGW0m3h/4X0buOVZXEn5Sva6PKrOy9Ozg3B0axcucJgXyUEkRS6fZdS1vXAs
 FFCv3MEZ3do6lUZD1utqfgB3ET3P7Rq5/gULCFzOOcfeg3DIzTNBJ3Z7Inn34tBI/79jAgKMlOB
 eA5upC1vuxrpKMh57aRCZJ7TeZVg4C0ADfAGNNqpTI4fGjIe6P8qTp3mA7QCV1yYbPqlhGNdmeN
 fh4EQMDyrzo0YvxO9T7ORhZrAEKHtt8DGmHO/5G9i0CJq1zKD+Eu3DA/yoK3sXiKLbJK1RUDDNV
 u2M5oLcxTup5yb/CDZ+5wph/2NyXU2AQm4eiKa0StZPAzzHPfvMdzqRw1NOxVpQRsEOSc=
X-Received: by 2002:a17:90b:5846:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-395c3718ee4mr6983439a91.8.1787285053274; 
 Thu, 20 Aug 2026 21:04:13 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 03/23] target/riscv: Split out vext_ldst_nf_host
Date: Thu, 20 Aug 2026 21:03:44 -0700
Message-ID: <20260821040404.268123-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Provide a helper that calls ldst_host for all NF vectors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index b04d461c08..6108cf3a6c 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -337,6 +337,15 @@ static void vext_set_nf_elems_1s(void *vd, uint32_t i, uint32_t nf,
     }
 }
 
+static void vext_ldst_nf_host(void *vd, void *host, uint32_t i, uint32_t nf,
+                              uint32_t esz, uint32_t max_elems,
+                              vext_ldst_elem_fn_host *ldst_host)
+{
+    for (uint32_t k = 0; k < nf; k++, host += esz) {
+        ldst_host(vd, i + k * max_elems, host);
+    }
+}
+
 static void vext_ldst_nf_tlb(CPURISCVState *env, void *vd, target_ulong addr,
                              uint32_t i, uint32_t nf,
                              uint32_t esz, uint32_t max_elems,
@@ -419,7 +428,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
                   vext_ldst_elem_fn_host *ldst_host, uintptr_t ra)
 {
     void *host;
-    int i, k, flags;
+    int flags;
     uint32_t esz = 1 << log2_esz;
     uint32_t size = (elems * nf) << log2_esz;
     uint32_t msize = nf * esz;
@@ -450,13 +459,9 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
             vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
                                       host, esz, is_load);
         } else {
-            for (i = env->vstart; i < evl; ++i) {
-                k = 0;
-                while (k < nf) {
-                    ldst_host(vd, i + k * max_elems, host);
-                    host += esz;
-                    k++;
-                }
+            for (uint32_t i = env->vstart; i < evl; ++i) {
+                vext_ldst_nf_host(vd, host, i, nf, esz, max_elems, ldst_host);
+                host += msize;
             }
         }
         env->vstart += elems;
@@ -465,7 +470,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
             vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
                                    ra, esz, is_load);
         } else {
-            for (i = env->vstart; i < evl; env->vstart = ++i) {
+            for (uint32_t i = env->vstart; i < evl; env->vstart = ++i) {
                 vext_ldst_nf_tlb(env, vd, addr, i, nf, esz,
                                  max_elems, ldst_tlb, ra);
                 addr += msize;
-- 
2.43.0


