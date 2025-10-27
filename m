Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21452CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRmz-00057g-Tm; Mon, 27 Oct 2025 14:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRma-0004vh-Mr
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:28 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRm8-00040V-8p
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=DdBLmkynQWPUm7c/HYslPmi4M74pSgGv1LWSDvYSNXQ=; b=sZLN39WfxOUWKaW
 bFymzT72+U50mx/Mh8n9aUnJexkyLmkGosBlyVGOv1jIXrdAS5MyNvE0UkCq/SOQbpKxKB0YAZO3s
 JnSt11DJN4Z59hB6FDCWCwyCZPbdkbVL8D7aShfD2aH1kPmTvheKOtfJNF1gbsjUYiWEFqb6S/MBW
 8s=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 23/33] target/riscv: Fix arguments to board IMSIC emulation
 callbacks
Date: Mon, 27 Oct 2025 19:18:20 +0100
Message-ID: <20251027181831.27016-24-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In hw/ the relevant RISCVIMSICState fields
eidelivery, eithreshold, eistate are uint32_t.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/cpu.h        | 42 ++++++++++++++++++++-------------------
 hw/intc/riscv_imsic.c     | 34 +++++++++++++++----------------
 target/riscv/cpu_helper.c | 12 ++++-------
 target/riscv/csr.c        | 24 ++++++++++++----------
 4 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b35851cf4f..d6ad0e1896 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -200,6 +200,24 @@ FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, VEDIV, 8, 2)
 FIELD(VTYPE, RESERVED, 10, sizeof(uint64_t) * 8 - 11)
 
+#ifndef CONFIG_USER_ONLY
+/* machine specific AIA ireg read-modify-write callback */
+#define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen)                 \
+    ((uint32_t)((((__xlen) & 0xff) << 24) |                                    \
+                (((__vgein) & 0x3f) << 20) |                                   \
+                (((__virt) & 0x1) << 18) |                                     \
+                (((__priv) & 0x3) << 16) |                                     \
+                  (__isel & 0xffff)))
+#define AIA_IREG_ISEL(__ireg) ((__ireg) & 0xffff)
+#define AIA_IREG_PRIV(__ireg) (((__ireg) >> 16) & 0x3)
+#define AIA_IREG_VIRT(__ireg) (((__ireg) >> 18) & 0x1)
+#define AIA_IREG_VGEIN(__ireg) (((__ireg) >> 20) & 0x3f)
+#define AIA_IREG_XLEN(__ireg) (((__ireg) >> 24) & 0xff)
+
+typedef int (*aia_ireg_rmw_fn)(void *arg, uint32_t reg, uint64_t *val,
+                               uint64_t new_val, uint64_t write_mask);
+#endif
+
 typedef struct PMUCTRState {
     /* Current value of a counter */
     uint64_t mhpmcounter_val;
@@ -465,20 +483,8 @@ struct CPUArchState {
     void *rdtime_fn_arg;
 
     /* machine specific AIA ireg read-modify-write callback */
-#define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen) \
-    ((((__xlen) & 0xff) << 24) | \
-     (((__vgein) & 0x3f) << 20) | \
-     (((__virt) & 0x1) << 18) | \
-     (((__priv) & 0x3) << 16) | \
-     (__isel & 0xffff))
-#define AIA_IREG_ISEL(__ireg)                  ((__ireg) & 0xffff)
-#define AIA_IREG_PRIV(__ireg)                  (((__ireg) >> 16) & 0x3)
-#define AIA_IREG_VIRT(__ireg)                  (((__ireg) >> 18) & 0x1)
-#define AIA_IREG_VGEIN(__ireg)                 (((__ireg) >> 20) & 0x3f)
-#define AIA_IREG_XLEN(__ireg)                  (((__ireg) >> 24) & 0xff)
-    int (*aia_ireg_rmw_fn[4])(void *arg, target_ulong reg,
-        target_ulong *val, target_ulong new_val, target_ulong write_mask);
-    void *aia_ireg_rmw_fn_arg[4];
+    aia_ireg_rmw_fn aia_ireg_rmw_cb[4];
+    void *aia_ireg_rmw_cb_arg[4];
 
     /* True if in debugger mode.  */
     bool debugger;
@@ -646,12 +652,8 @@ void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
                              void *arg);
-void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
-                                   int (*rmw_fn)(void *arg,
-                                                 target_ulong reg,
-                                                 target_ulong *val,
-                                                 target_ulong new_val,
-                                                 target_ulong write_mask),
+void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, uint32_t priv,
+                                   aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 6174e1a05d..9274a1e842 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -88,11 +88,11 @@ static void riscv_imsic_update(RISCVIMSICState *imsic, uint32_t page)
 }
 
 static int riscv_imsic_eidelivery_rmw(RISCVIMSICState *imsic, uint32_t page,
-                                      target_ulong *val,
-                                      target_ulong new_val,
-                                      target_ulong wr_mask)
+                                      uint64_t *val,
+                                      uint64_t new_val,
+                                      uint64_t wr_mask)
 {
-    target_ulong old_val = imsic->eidelivery[page];
+    uint32_t old_val = imsic->eidelivery[page];
 
     if (val) {
         *val = old_val;
@@ -106,11 +106,11 @@ static int riscv_imsic_eidelivery_rmw(RISCVIMSICState *imsic, uint32_t page,
 }
 
 static int riscv_imsic_eithreshold_rmw(RISCVIMSICState *imsic, uint32_t page,
-                                      target_ulong *val,
-                                      target_ulong new_val,
-                                      target_ulong wr_mask)
+                                      uint64_t *val,
+                                      uint64_t new_val,
+                                      uint64_t wr_mask)
 {
-    target_ulong old_val = imsic->eithreshold[page];
+    uint32_t old_val = imsic->eithreshold[page];
 
     if (val) {
         *val = old_val;
@@ -124,8 +124,8 @@ static int riscv_imsic_eithreshold_rmw(RISCVIMSICState *imsic, uint32_t page,
 }
 
 static int riscv_imsic_topei_rmw(RISCVIMSICState *imsic, uint32_t page,
-                                 target_ulong *val, target_ulong new_val,
-                                 target_ulong wr_mask)
+                                 uint64_t *val, uint64_t new_val,
+                                 uint64_t wr_mask)
 {
     uint32_t base, topei = riscv_imsic_topei(imsic, page);
 
@@ -149,11 +149,11 @@ static int riscv_imsic_topei_rmw(RISCVIMSICState *imsic, uint32_t page,
 
 static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
                                uint32_t xlen, uint32_t page,
-                               uint32_t num, bool pend, target_ulong *val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint32_t num, bool pend, uint64_t *val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint32_t i, base, prev;
-    target_ulong mask;
+    uint64_t mask;
     uint32_t state = (pend) ? IMSIC_EISTATE_PENDING : IMSIC_EISTATE_ENABLED;
 
     if (xlen != 32) {
@@ -178,7 +178,7 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
             continue;
         }
 
-        mask = (target_ulong)1 << i;
+        mask = 1ull << i;
         if (wr_mask & mask) {
             if (new_val & mask) {
                 prev = qatomic_fetch_or(&imsic->eistate[base + i], state);
@@ -197,8 +197,8 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
     return 0;
 }
 
-static int riscv_imsic_rmw(void *arg, target_ulong reg, target_ulong *val,
-                           target_ulong new_val, target_ulong wr_mask)
+static int riscv_imsic_rmw(void *arg, uint32_t reg, uint64_t *val,
+                           uint64_t new_val, uint64_t wr_mask)
 {
     RISCVIMSICState *imsic = arg;
     uint32_t isel, priv, virt, vgein, xlen, page;
@@ -383,7 +383,7 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         }
 
         if (!kvm_irqchip_in_kernel()) {
-            riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
+            riscv_cpu_set_aia_ireg_rmw_cb(env, (imsic->mmode) ? PRV_M : PRV_S,
                                           riscv_imsic_rmw, imsic);
         }
     }
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e0a324b401..b102f15ac6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -765,17 +765,13 @@ void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
     env->rdtime_fn_arg = arg;
 }
 
-void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
-                                   int (*rmw_fn)(void *arg,
-                                                 target_ulong reg,
-                                                 target_ulong *val,
-                                                 target_ulong new_val,
-                                                 target_ulong write_mask),
+void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, uint32_t priv,
+                                   aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg)
 {
     if (priv <= PRV_M) {
-        env->aia_ireg_rmw_fn[priv] = rmw_fn;
-        env->aia_ireg_rmw_fn_arg[priv] = rmw_fn_arg;
+        env->aia_ireg_rmw_cb[priv] = rmw_fn;
+        env->aia_ireg_rmw_cb_arg[priv] = rmw_fn_arg;
     }
 }
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ebdb955869..491186d9c7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2637,6 +2637,7 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
     int ret = -EINVAL;
     uint8_t *iprio;
     target_ulong priv, vgein;
+    uint64_t wide_val;
 
     /* VS-mode CSR number passed in has already been translated */
     switch (csrno) {
@@ -2681,16 +2682,17 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
         }
     } else if (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST) {
         /* IMSIC registers only available when machine implements it. */
-        if (env->aia_ireg_rmw_fn[priv]) {
+        if (env->aia_ireg_rmw_cb[priv]) {
             /* Selected guest interrupt file should not be zero */
             if (virt && (!vgein || env->geilen < vgein)) {
                 goto done;
             }
             /* Call machine specific IMSIC register emulation */
-            ret = env->aia_ireg_rmw_fn[priv](env->aia_ireg_rmw_fn_arg[priv],
+            ret = env->aia_ireg_rmw_cb[priv](env->aia_ireg_rmw_cb_arg[priv],
                                     AIA_MAKE_IREG(isel, priv, virt, vgein,
                                                   riscv_cpu_mxl_bits(env)),
-                                    val, new_val, wr_mask);
+                                    &wide_val, new_val, wr_mask);
+            *val = wide_val;
         }
     } else {
         isel_reserved = true;
@@ -2922,6 +2924,7 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
     bool virt;
     int ret = -EINVAL;
     target_ulong priv, vgein;
+    uint64_t wide_val;
 
     /* Translate CSR number for VS-mode */
     csrno = aia_xlate_vs_csrno(env, csrno);
@@ -2947,7 +2950,7 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
     };
 
     /* IMSIC CSRs only available when machine implements IMSIC. */
-    if (!env->aia_ireg_rmw_fn[priv]) {
+    if (!env->aia_ireg_rmw_cb[priv]) {
         goto done;
     }
 
@@ -2960,10 +2963,11 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
     }
 
     /* Call machine specific IMSIC register emulation for TOPEI */
-    ret = env->aia_ireg_rmw_fn[priv](env->aia_ireg_rmw_fn_arg[priv],
+    ret = env->aia_ireg_rmw_cb[priv](env->aia_ireg_rmw_cb_arg[priv],
                     AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, priv, virt, vgein,
                                   riscv_cpu_mxl_bits(env)),
-                    val, new_val, wr_mask);
+                    &wide_val, new_val, wr_mask);
+    *val = wide_val;
 
 done:
     if (ret) {
@@ -4428,7 +4432,7 @@ static RISCVException read_vstopi(CPURISCVState *env, int csrno,
                                   target_ulong *val)
 {
     int irq, ret;
-    target_ulong topei;
+    uint64_t topei = 0;
     uint64_t vseip, vsgein;
     uint32_t iid, iprio, hviid, hviprio, gein;
     uint32_t s, scount = 0, siid[VSTOPI_NUM_SRCS], siprio[VSTOPI_NUM_SRCS];
@@ -4443,13 +4447,13 @@ static RISCVException read_vstopi(CPURISCVState *env, int csrno,
         if (gein <= env->geilen && vseip) {
             siid[scount] = IRQ_S_EXT;
             siprio[scount] = IPRIO_MMAXIPRIO + 1;
-            if (env->aia_ireg_rmw_fn[PRV_S]) {
+            if (env->aia_ireg_rmw_cb[PRV_S]) {
                 /*
                  * Call machine specific IMSIC register emulation for
                  * reading TOPEI.
                  */
-                ret = env->aia_ireg_rmw_fn[PRV_S](
-                        env->aia_ireg_rmw_fn_arg[PRV_S],
+                ret = env->aia_ireg_rmw_cb[PRV_S](
+                        env->aia_ireg_rmw_cb_arg[PRV_S],
                         AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, PRV_S, true, gein,
                                       riscv_cpu_mxl_bits(env)),
                         &topei, 0, 0);
-- 
2.51.0


