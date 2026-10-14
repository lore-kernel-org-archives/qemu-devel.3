Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4473CC6B1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqG-0004tt-Me; Tue, 13 Oct 2026 23:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq4-0004qT-WD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:40 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq1-0001Kf-2q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:36 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab8309dcbaso2659925a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949168; x=1792553968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8YFPhT6aOCuG9UYnv1AULvKlN1lwEIlGrbq+GhNIGTo=;
 b=OnuO2HSisBG4Mb59C/dEjEeVAApKgfINFJuy4ee0j6rnqVtxlUGO6sU2nEAxRhYKCG
 gMBeECZ2iUNvyzRwQVVfExbeA4CTh7GvSy/uj52xbqXhRLi5i1+B2MayY6PDbp8IlBEq
 Xer1F5dN+ZQSnM52ut2YUDHsK5dy88LQOeXI4p9N/kEhfc+nmZjyp+3oDBBjV+PeIkkQ
 JmWK+IUPovxXfH66vhJwnMQtiZ5Ff+IWnGMOXQwpU2x6gxg8QSch89Hl76Un/jISHnCK
 Y62qy1kB3rZuhR7E4y8qs7rchmZzbTOnViU8yE/DlF19TNBAPNhICEkJDlD8pqsjlXxO
 yRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949168; x=1792553968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8YFPhT6aOCuG9UYnv1AULvKlN1lwEIlGrbq+GhNIGTo=;
 b=Bb/jbCZbDAAXMtxdJN6SDY78pJrOUt0EBWLD1+8cB2kDXNSOGVQ2kur5u/yHNap3NL
 ackapJ+fJAw2RJ5rnnwgr5x2UrYCkEblGREN2ZeNI/pIPlmvqUuQKYGZ+mgcmsbphlsq
 q1eyRbwgVAPzq+bUowEDqAwIdlpamF63j4vyy0QQZ+J75c4fbsrUMLF++ZRdT2qT9WmX
 LGToGzeECmcbTJFj3THAcvROfSWqkLA/GG1D8oYRrY5kkblrEJuzOYvYPxVSqUQ1mTNt
 R1UoKm0mQgPUA8ro4UWQJF7+yTrjKd8kraum7pfK24XDAMRMU1o2zVxR8fhvCohU5m1/
 fCbw==
X-Gm-Message-State: AFq9FYKRg0lRwIIsInULYezZfKcEwZz/MzXCY9NsVh+XmVusRqnDOJAq
 9InqNspRnr30RgRzsrZxSnFXggj4SJYR4sIulHTOagIV1jYzxoaRWexKWvqgCQ==
X-Gm-Gg: AYBFou1OENWIdAQcvu5MVpAwebxCvvawc/iaOIEFrH346K5cMBy+aqWIuc9SFC+WHom
 FIRu3OUQhBQ9bhTY+2fAThrs7p7G5X8TzkjeQeS6D25TuT4HIrWPf2HyDv/gjMuBrQU+oMPDx9Y
 7t896ETFTpGF59YmIogyP4BDMiompZSuouCXUzI8wFitR99I3z0GJrvVYk2PlizJfGjuPBxVQKG
 KWVfyIyo6/RDLJzfBw7KYuB03Cp7eg3O+8mBGDuBb3VppV+Pina67uY+Bj8iASrzk0tT1PQpHfC
 XmtzZ1k9QwV4BJgymb+8KG3iNtPQenCe20k8QhG4tUHQEplXPF7AYD6zz/Y1K2iqC7VlEu/4Pl/
 K9MSaCjL5UPePWXQIRjzHPpX0NxUENOoqAJfOByciM4EPzpf/M+zG05jFGLX8sbsX2AVXqsodok
 wM/V+95F0GxjxYJSD6oy1A9ZgCqCCyonXno8/5gI2IjWUz9u7+rka98YCAki0kWaJwUsJpshoiP
 SbCwppzUewAjyfD
X-Received: by 2002:a17:90b:224c:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3ab3a9a8dbbmr10003802a91.18.1791949167584; 
 Tue, 13 Oct 2026 20:39:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Gong Shuai <gsh517025@gmail.com>,
 TianCheng TANG <lyndra@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/52] target/riscv: Restore LCOFI handling in interrupt CSRs
Date: Wed, 14 Oct 2026 13:38:17 +1000
Message-ID: <20261014033907.3332383-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>

Commit 27f9566dcd98 dropped bits 13-15 from the LOCAL_INTERRUPTS
macro and hence also from individual masks such as all_ints,
sip_writable_mask etc.

As a result, even with sscofpmf and ssaia enabled, the LCOFI never got
delivered to the host OS and guest OS respectively.

Add back bit 13 in all the affected masks, but gate it on Sscofpmf being
implemented. For the virtual interrupt paths, i.e., mvip/mvien,
hvip/hvien/vsip/vsie registers, bit 13 is additionally gated on Smaia
and Ssaia respectively. Bits 14, 15 can be added when those interrupt
sources get defined.

Cc: qemu-stable@nongnu.org
Fixes: 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Suggested-by: Gong Shuai <gsh517025@gmail.com>
Suggested-by: TianCheng TANG <lyndra@linux.alibaba.com>
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Message-ID: <20260921145334.419651-1-mayuresh.chitale@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 88 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9db77..a3351428cb 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1815,7 +1815,7 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 #define LOCAL_INTERRUPTS   (~0xFFFFULL)
 
 static const uint64_t delegable_ints =
-    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
+    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS;
 static const uint64_t vs_delegable_ints =
     (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
 static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
@@ -1877,6 +1877,42 @@ static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
 static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
+/*
+ * Selects the extensions that need to be checked when accessing various
+ * interrupt registers.
+ */
+typedef enum {
+    /* Accessing mideleg, mie, mip, and alias paths  */
+    AIA_NONE,
+    /* Accessing mvien, mvip non-alias path */
+    AIA_SMAIA,
+    /* Accessing hvien, hvip, vsie, vsip paths */
+    AIA_SSAIA,
+} AIAExt;
+
+/*
+ * This function can be extended later to configure mask for standard local
+ * interrupt bits 14 and 15, once those get defined in the Priv Spec.
+ */
+static uint64_t std_impl_intr_mask(CPURISCVState *env, AIAExt ext)
+{
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
+
+    if (ext == AIA_SMAIA && !cfg->ext_smaia) {
+        return 0;
+    }
+
+    if (ext == AIA_SSAIA && !cfg->ext_ssaia) {
+        return 0;
+    }
+
+    if (!cfg->ext_sscofpmf) {
+        return 0;
+    }
+
+    return MIP_LCOFIP;
+}
+
 /* Machine Information Registers */
 static RISCVException read_zero(CPURISCVState *env, int csrno,
                                 target_ulong *val)
@@ -2249,8 +2285,10 @@ static RISCVException rmw_mideleg64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t mask = wr_mask & delegable_ints;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mideleg;
     }
@@ -2300,8 +2338,10 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t mask = wr_mask & all_ints;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mie;
     }
@@ -2350,8 +2390,10 @@ static RISCVException rmw_mvien64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SMAIA);
     uint64_t mask = wr_mask & mvien_writable_mask;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mvien;
     }
@@ -3784,9 +3826,12 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t old_mip, mask = wr_mask & delegable_ints;
     uint32_t gin;
 
+    mask |= wr_mask & std_mask;
+
     /*
      * When mvien[9]=1, mip.SEIP is read-only and reflects only
      * the external interrupt signal from the interrupt controller.
@@ -3900,9 +3945,12 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
      *  alias_mask denotes the bits that come from mip nalias_mask denotes bits
      *  that come from hvip.
      */
-    uint64_t alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    AIAExt intr_virt = ((csrno == CSR_MVIP) || (csrno == CSR_MVIPH)) ?
+                          AIA_SMAIA : AIA_NONE;
+    uint64_t std_mask = std_impl_intr_mask(env, intr_virt);
+    uint64_t alias_mask = ((S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
         (env->mideleg | ~env->mvien)) | MIP_STIP;
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
     uint64_t wr_mask_mvip;
     uint64_t wr_mask_mip;
@@ -3931,8 +3979,8 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
         alias_mask &= ~MIP_STIP;
     }
 
-    wr_mask_mip = wr_mask & alias_mask & mvip_writable_mask;
-    wr_mask_mvip = wr_mask & nalias_mask & mvip_writable_mask;
+    wr_mask_mip = wr_mask & alias_mask & (mvip_writable_mask | std_mask);
+    wr_mask_mvip = wr_mask & nalias_mask & (mvip_writable_mask | std_mask);
 
     /*
      * For bits set in alias_mask, mvip needs to be alias of mip, so forward
@@ -4065,9 +4113,11 @@ static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
                                  uint64_t *ret_val,
                                  uint64_t new_val, uint64_t wr_mask)
 {
-    uint64_t alias_mask = (LOCAL_INTERRUPTS | VS_MODE_INTERRUPTS) &
-                            env->hideleg;
-    uint64_t nalias_mask = LOCAL_INTERRUPTS & (~env->hideleg & env->hvien);
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
+    uint64_t alias_mask = (LOCAL_INTERRUPTS | VS_MODE_INTERRUPTS |
+                           std_mask) & env->hideleg;
+    uint64_t nalias_mask = (LOCAL_INTERRUPTS | std_mask) &
+                           (~env->hideleg & env->hvien);
     uint64_t rval, rval_vs, vsbits;
     uint64_t wr_mask_vsie;
     uint64_t wr_mask_mie;
@@ -4135,9 +4185,11 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
-    uint64_t alias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & env->mideleg;
+    uint64_t alias_mask = (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
+        env->mideleg;
     uint64_t sie_mask = wr_mask & nalias_mask;
     RISCVException ret;
 
@@ -4320,6 +4372,7 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
                                  uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
     uint64_t rval, mask = env->hideleg & VS_MODE_INTERRUPTS;
     uint64_t vsbits;
 
@@ -4335,7 +4388,7 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
     wr_mask |= vsbits << 1;
 
     ret = rmw_hvip64(env, csrno, &rval, new_val,
-                     wr_mask & mask & vsip_writable_mask);
+                     wr_mask & mask & (vsip_writable_mask | std_mask));
     if (ret_val) {
         rval &= mask;
         vsbits = rval & VS_MODE_INTERRUPTS;
@@ -4382,7 +4435,9 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
                                 uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
-    uint64_t mask = (env->mideleg | env->mvien) & sip_writable_mask;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
+    uint64_t mask = (env->mideleg | env->mvien) &
+                    (sip_writable_mask | std_mask);
 
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
@@ -4395,7 +4450,7 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
 
     if (ret_val) {
         *ret_val &= (env->mideleg | env->mvien) &
-            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
+            (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS);
     }
 
     return ret;
@@ -4737,7 +4792,9 @@ static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
                                     uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t mask = wr_mask & hvien_writable_mask;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->hvien;
     }
@@ -4861,6 +4918,7 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
      */
     uint64_t alias_mask = (env->hideleg | ~env->hvien) | VS_MODE_INTERRUPTS;
     uint64_t nalias_mask = (~env->hideleg & env->hvien);
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
     uint64_t wr_mask_hvip;
     uint64_t wr_mask_mip;
 
@@ -4882,8 +4940,8 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
         alias_mask &= (env->hideleg | env->hvien);
     }
 
-    wr_mask_hvip = wr_mask & nalias_mask & hvip_writable_mask;
-    wr_mask_mip = wr_mask & alias_mask & hvip_writable_mask;
+    wr_mask_hvip = wr_mask & nalias_mask & (hvip_writable_mask | std_mask);
+    wr_mask_mip = wr_mask & alias_mask & (hvip_writable_mask | std_mask);
 
     /* Aliased bits, bits 10, 6, 2 need to come from mip. */
     ret = rmw_mip64(env, csrno, &ret_mip, new_val, wr_mask_mip);
-- 
2.55.0


