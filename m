Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2C3D16243
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0J9r-0006VL-MV; Mon, 14 Oct 2024 07:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9p-0006UY-Ur
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9n-0002bt-5G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so2254686f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728904953; x=1729509753;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjN8wKf5K4ezvTvEHU+TdCvJYSkiifzqI48ozvO9hPc=;
 b=OF3h6zDa2Qu2X35AyMNZjVJPNoK0d0CqCiV2aCnfC7AXt1o8/kmfFd2LkK9ASX0Ryq
 ROZzFbIPJ3lpxxEEI0mESO47UoWR8HN2KfEjkq3xHKHJAWKyxL1fU9DGl+zc0BjDzd8M
 G7rcWp9/tly2xN/5HUbUMoG9LEZCLSLmgj/ry5Kj5gn2B1Yc985NANTgEdj/HZQqpH7S
 HfQ5NO1oOIGGzBmqd4r30yk73NK0BQrsCir/MRX9/e+FvhI34RdxQGBhIj8XCXgH0X8B
 EB1T4kK6w/Kpd7UUQ1kla+DdZEWrTwSWG5+oqu53idNEFq7QyWhty0SDq2ex4dkitamy
 7GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728904953; x=1729509753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjN8wKf5K4ezvTvEHU+TdCvJYSkiifzqI48ozvO9hPc=;
 b=HnDwrf2wgpppyqYwf9fX6w9ImSmav3jSyC1I4Rz1ll5xzOrjekkipk/pPYM3W7qS62
 evIJOD7yTrgv77d4p9PsC8LEQdo+Xcw4Twa+mUytlLuKj9brMJRbwaMLF7zfHAl0/P7a
 gEw8FEZTShWk6OeOHS350SLGEQpDPrx4GHLoL812vnYf+1nlTbwSQC5Rco4y/bp68Ch2
 vfVhwAYGUJWRyaJNadd5yCERr9kIWiOlo1w3h/zNUhBl/MQvTjFwtzRgQFI6n1poWKlh
 jDKwi+/+w5ty/o2PVRKx2ng7NQI/YocJwPJgHtAnCRAWDz2JG5otgMQHsRaM9/0n5s2R
 R1ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfcRZyZOT2HhXK6f9yeTDsBLxojyorFtTx/ciAYhjK8+oecx9sKtg6s/GimVsEYojNq4APaidP5Wxa@nongnu.org
X-Gm-Message-State: AOJu0Yz/YahTWIr5mL6NAzxdEYvloPA+Akp9YGvgVU3JeUDgTsVCv7DQ
 qpgZb2VnUvWmN2eEVaaMO6TeFa9L2STEkhwReRj586Z5u1UX9iWc3IYMfuzXXXA=
X-Google-Smtp-Source: AGHT+IGbPzMcm/Zfjl0n05/ZyduCCSZBi+fLF4QFyNAiF3cWdTPk7r1AQRqagmIxtqV9k8E1fM5AAQ==
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id
 ffacd0b85a97d-37d551fba84mr7417012f8f.26.1728904953126; 
 Mon, 14 Oct 2024 04:22:33 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd382sm11117303f8f.43.2024.10.14.04.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:22:32 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] target/riscv: Add Ssdbltrp CSRs handling
Date: Mon, 14 Oct 2024 13:22:11 +0200
Message-ID: <20241014112225.90297-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014112225.90297-1-cleger@rivosinc.com>
References: <20241014112225.90297-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add ext_ssdbltrp in RISCVCPUConfig and implement MSTATUS.SDT,
{H|M}ENVCFG.DTE and modify the availability of MTVAL2 based on the
presence of the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_cfg.h    |  1 +
 target/riscv/cpu_helper.c | 20 +++++++++++++++++
 target/riscv/csr.c        | 45 ++++++++++++++++++++++++++++++---------
 5 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a84e719d3f..ee984bf270 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -553,6 +553,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index da1723496c..3a5588d4df 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -558,6 +558,7 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
+#define MSTATUS_SDT         0x01000000
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 
@@ -588,6 +589,7 @@ typedef enum {
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
+#define SSTATUS_SDT         0x01000000
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
@@ -777,11 +779,13 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_DTE                        (1ULL << 59)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
 
 /* For RV32 */
+#define MENVCFGH_DTE                       BIT(27)
 #define MENVCFGH_ADUE                      BIT(29)
 #define MENVCFGH_PBMTE                     BIT(30)
 #define MENVCFGH_STCE                      BIT(31)
@@ -795,11 +799,13 @@ typedef enum RISCVException {
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_DTE                        MENVCFG_DTE
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
 
 /* For RV32 */
+#define HENVCFGH_DTE                        MENVCFGH_DTE
 #define HENVCFGH_ADUE                       MENVCFGH_ADUE
 #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
 #define HENVCFGH_STCE                       MENVCFGH_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ae2a945b5f..dd804f95d4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -77,6 +77,7 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_ssdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9d0400035f..77e7736d8a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -63,6 +63,22 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
+{
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
+    if (!riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        return false;
+    }
+    if (virt) {
+        return (env->henvcfg & HENVCFG_DTE) != 0;
+    } else {
+        return (env->menvcfg & MENVCFG_DTE) != 0;
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -562,6 +578,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
 
     g_assert(riscv_has_ext(env, RVH));
 
+    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
+        mstatus_mask |= MSTATUS_SDT;
+    }
+
     if (current_virt) {
         /* Current V=1 and we are about to change to V=0 */
         env->vsstatus = env->mstatus & mstatus_mask;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e5de72453c..d8280ec956 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -540,6 +540,15 @@ static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
     return hmode32(env, csrno);
 }
 
+static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException pmp(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->pmp) {
@@ -1402,7 +1411,7 @@ static const target_ulong vs_delegable_excps = DELEGABLE_EXCPS &
       (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT)));
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
-    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
+    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS | SSTATUS_SDT;
 
 /*
  * Spec allows for bits 13:63 to be either read-only or writable.
@@ -1600,6 +1609,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         mask |= MSTATUS_VS;
     }
 
+    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
+        mask |= MSTATUS_SDT;
+        if ((val & MSTATUS_SDT) != 0) {
+            mstatus &= ~MSTATUS_SIE;
+            val &= ~MSTATUS_SIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -2354,7 +2371,8 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2374,7 +2392,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
@@ -2425,9 +2444,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
      * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
      * henvcfg.adue is read_only 0 when menvcfg.adue = 0
+     * henvcfg.dte is read_only 0 when menvcfg.dte = 0
      */
-    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                           env->menvcfg);
+    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                             HENVCFG_DTE) | env->menvcfg);
     return RISCV_EXCP_NONE;
 }
 
@@ -2435,6 +2455,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
+    uint64_t menvcfg_mask;
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
@@ -2443,7 +2464,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
+        if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+            menvcfg_mask |= HENVCFG_DTE;
+        }
+        mask |= env->menvcfg & menvcfg_mask;
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -2461,8 +2486,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                            env->menvcfg)) >> 32;
+    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                              HENVCFG_DTE) | env->menvcfg)) >> 32;
     return RISCV_EXCP_NONE;
 }
 
@@ -2470,7 +2495,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
-                                    HENVCFG_ADUE);
+                                    HENVCFG_ADUE | HENVCFG_DTE);
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
 
@@ -5246,7 +5271,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
 
-    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
+    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
-- 
2.45.2


