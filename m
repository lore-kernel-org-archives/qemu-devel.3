Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82A7CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB6b-0000BW-B6; Sat, 17 Oct 2026 16:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5Z-0005j6-7F; Sat, 17 Oct 2026 16:33:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5W-0004de-Qy; Sat, 17 Oct 2026 16:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268895; bh=HvVxrMWANmmigS6XJMKkjruHYgespJRHf5h4WfPbtPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z39CWz93LSm0geGtHsHQNmmDOiOoA/wNLSBMndlCv0ZK4mE6wAkeBf97avTNova7o
 wNQ625IllXd5sLE4Q1Pn8buTBfByYUyvfiwp5QEECU4NXMn6GPeOGDBIPYjl2ciy4Q
 yyzTLHQPJinNIVDw3tCcb1nCWjKmMi0xxnUUF50r7bU3NLeagtWw8mlCIvmjnRay+Q
 6OkBz9/ji4ZNcKlkzmfMkD8ucTGPiD2zrj0FzMUuI54rAZs4vZZxfPGnWz9ft+qMlj
 ICJy2bjuuSIgGADAcjbaeE1A9LEwEmUUL8auJAGuA9oYpSFsv/tfSPtoAExqvRzGf6
 orm6MvCBjGYFg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A14481DE780;
 Sat, 17 Oct 2026 23:28:15 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E465B443452;
 Sat, 17 Oct 2026 23:28:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Gong Shuai <gsh517025@gmail.com>,
 TianCheng TANG <lyndra@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 64/73] target/riscv: Restore LCOFI handling in
 interrupt CSRs
Date: Sat, 17 Oct 2026 23:26:22 +0300
Message-ID: <20261017202638.728621-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit 7f9ab1dc6c6e0f855e0b098b3d8f404e760a1df5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index a4cd126999..b24a3448a5 100644
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
@@ -2245,8 +2281,10 @@ static RISCVException rmw_mideleg64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t mask = wr_mask & delegable_ints;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mideleg;
     }
@@ -2296,8 +2334,10 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t mask = wr_mask & all_ints;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mie;
     }
@@ -2346,8 +2386,10 @@ static RISCVException rmw_mvien64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SMAIA);
     uint64_t mask = wr_mask & mvien_writable_mask;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mvien;
     }
@@ -3780,9 +3822,12 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
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
@@ -3896,9 +3941,12 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
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
@@ -3927,8 +3975,8 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
         alias_mask &= ~MIP_STIP;
     }
 
-    wr_mask_mip = wr_mask & alias_mask & mvip_writable_mask;
-    wr_mask_mvip = wr_mask & nalias_mask & mvip_writable_mask;
+    wr_mask_mip = wr_mask & alias_mask & (mvip_writable_mask | std_mask);
+    wr_mask_mvip = wr_mask & nalias_mask & (mvip_writable_mask | std_mask);
 
     /*
      * For bits set in alias_mask, mvip needs to be alias of mip, so forward
@@ -4061,9 +4109,11 @@ static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
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
@@ -4131,9 +4181,11 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
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
 
@@ -4316,6 +4368,7 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
                                  uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
     uint64_t rval, mask = env->hideleg & VS_MODE_INTERRUPTS;
     uint64_t vsbits;
 
@@ -4331,7 +4384,7 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
     wr_mask |= vsbits << 1;
 
     ret = rmw_hvip64(env, csrno, &rval, new_val,
-                     wr_mask & mask & vsip_writable_mask);
+                     wr_mask & mask & (vsip_writable_mask | std_mask));
     if (ret_val) {
         rval &= mask;
         vsbits = rval & VS_MODE_INTERRUPTS;
@@ -4378,7 +4431,9 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
                                 uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
-    uint64_t mask = (env->mideleg | env->mvien) & sip_writable_mask;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
+    uint64_t mask = (env->mideleg | env->mvien) &
+                    (sip_writable_mask | std_mask);
 
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
@@ -4391,7 +4446,7 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
 
     if (ret_val) {
         *ret_val &= (env->mideleg | env->mvien) &
-            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
+            (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS);
     }
 
     return ret;
@@ -4733,7 +4788,9 @@ static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
                                     uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t mask = wr_mask & hvien_writable_mask;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->hvien;
     }
@@ -4857,6 +4914,7 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
      */
     uint64_t alias_mask = (env->hideleg | ~env->hvien) | VS_MODE_INTERRUPTS;
     uint64_t nalias_mask = (~env->hideleg & env->hvien);
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
     uint64_t wr_mask_hvip;
     uint64_t wr_mask_mip;
 
@@ -4878,8 +4936,8 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
         alias_mask &= (env->hideleg | env->hvien);
     }
 
-    wr_mask_hvip = wr_mask & nalias_mask & hvip_writable_mask;
-    wr_mask_mip = wr_mask & alias_mask & hvip_writable_mask;
+    wr_mask_hvip = wr_mask & nalias_mask & (hvip_writable_mask | std_mask);
+    wr_mask_mip = wr_mask & alias_mask & (hvip_writable_mask | std_mask);
 
     /* Aliased bits, bits 10, 6, 2 need to come from mip. */
     ret = rmw_mip64(env, csrno, &ret_mip, new_val, wr_mask_mip);
-- 
2.47.3


