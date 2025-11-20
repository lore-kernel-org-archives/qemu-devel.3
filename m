Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253AECF64A0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLt4z-0000FY-GC; Wed, 19 Nov 2025 20:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLskj-0004HF-AN; Wed, 19 Nov 2025 19:42:25 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLskg-0002S0-H8; Wed, 19 Nov 2025 19:42:24 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 49B0F60185;
 Thu, 20 Nov 2025 00:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC160C16AAE;
 Thu, 20 Nov 2025 00:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763599339;
 bh=ZoKXyBiS0bJFhqyVI65ezn+Mu3I5RJvtW5nvhBqRgC4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=N/kT5CTQrRHNl8GaM9v7Fc8JBtmLb2L/Gvt+kR+J3yuQviUqZbzWaN2mzYNXpfrpn
 rajtzB6Qp3KtJJekt6EMyec7bu9ckRgi0HC3qnmIcU/ikCnrRrPJiYl8ldpy90i9Kw
 g/R5ql0D2ToMGPYLRXJgmA/blPQuHgBcSsbn5Q4kDhcrhhPmP2TaOJOAeUmplXVdPb
 jUblBe5di8kiFEMs2kY1Dr6KTHqcZ52N2JjZJpAzdvuWnAVWGxuuiFwswmzoDbwfQ0
 ykFBq3AEhHbjACuue81nNJ9UDaO7thsAsy7sH20OSsKEerYVhKWTj+Prx+jxCdq+32
 R1jdFHFZWmySg==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 19 Nov 2025 16:42:17 -0800
Subject: [PATCH 1/7] riscv: implement Ssqosid extension and srmcfg CSR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Nov 2025 20:03:18 -0500
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

From: Kornel Dulęba <mindal@semihalf.com>

Implement the srmcfg CSR defined by the Ssqosid ISA extension
(Supervisor-mode Quality of Service ID). The CSR contains two fields:

  - Resource Control ID (RCID) used determine resource allocation
  - Monitoring Counter ID (MCID) used to track resource usage

The CSR is defined for S-mode but accessing it when V=1 shall cause a
virtual instruction exception. Implement this behavior by calling the
hmode predicate.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0/riscv-cbqri.pdf
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[fustini: rebase on v10.1.50, fix check_srmcfg]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 disas/riscv.c                     |  1 +
 target/riscv/cpu.c                |  2 ++
 target/riscv/cpu.h                |  3 +++
 target/riscv/cpu_bits.h           |  8 ++++++++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/csr.c                | 34 ++++++++++++++++++++++++++++++++++
 6 files changed, 49 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 85cd2a9c2aef..86fc710528c1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2289,6 +2289,7 @@ static const char *csr_name(int csrno)
     case 0x0143: return "stval";
     case 0x0144: return "sip";
     case 0x0180: return "satp";
+    case 0x0181: return "srmcfg";
     case 0x0200: return "hstatus";
     case 0x0202: return "hedeleg";
     case 0x0203: return "hideleg";
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c84..2e2e642de26b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -216,6 +216,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
+    ISA_EXT_DATA_ENTRY(ssqosid, PRIV_VERSION_1_12_0, ext_ssqosid),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
@@ -1268,6 +1269,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
+    MULTI_EXT_CFG_BOOL("ssqosid", ext_ssqosid, true),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
     MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f100374d..21688d8ca002 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -336,6 +336,9 @@ struct CPUArchState {
     uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
     uint64_t ctr_data[16 << SCTRDEPTH_MAX];
 
+    /* Ssqosid extension */
+    target_ulong srmcfg;
+
     /* Machine and Supervisor interrupt priorities */
     uint8_t miprio[64];
     uint8_t siprio[64];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7c0..ebb400bf6f2c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -228,6 +228,9 @@
 #define CSR_SPTBR           0x180
 #define CSR_SATP            0x180
 
+/* Ssqosid extension */
+#define CSR_SRMCFG          0x181
+
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT        0x150
 #define CSR_SIREG           0x151
@@ -1164,4 +1167,9 @@ typedef enum CTRType {
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
 #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
+
+/* SRMCFG CSR field masks (Ssqosid extensions) */
+#define SRMCFG_RCID                      0x00000FFF
+#define SRMCFG_MCID                      0x0FFF0000
+
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc792b..6518f6f9c571 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -105,6 +105,7 @@ BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
 BOOL_FIELD(ext_ssctr)
 BOOL_FIELD(ext_sscofpmf)
+BOOL_FIELD(ext_ssqosid)
 BOOL_FIELD(ext_smepmp)
 BOOL_FIELD(ext_smrnmi)
 BOOL_FIELD(ext_ssnpm)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3dc4..06a6212c672d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1759,6 +1759,37 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException check_srmcfg(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_ssqosid) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    /*
+     * Even though this is an S-mode CSR the spec says that we need to throw
+     * and virt instruction fault if a guest tries to access it.
+     */
+    return env->virt_enabled ?
+           RISCV_EXCP_VIRT_INSTRUCTION_FAULT : smode(env, csrno);
+}
+
+static RISCVException read_srmcfg(CPURISCVState *env, int csrno,
+                                  target_ulong *val)
+{
+    *val = env->srmcfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_srmcfg(CPURISCVState *env, int csrno,
+                                   target_ulong val, uintptr_t ra)
+{
+    env->srmcfg = val & (SRMCFG_RCID | SRMCFG_MCID);
+    return RISCV_EXCP_NONE;
+}
+
+
 #define VSTOPI_NUM_SRCS 5
 
 /*
@@ -6035,6 +6066,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Supervisor Protection and Translation */
     [CSR_SATP]     = { "satp",     satp, read_satp,     write_satp     },
 
+    /* Supervisor-Level Quality-of-Service Identifiers (Ssqosid) */
+    [CSR_SRMCFG]   = { "srmcfg",  check_srmcfg, read_srmcfg, write_srmcfg },
+
     /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
     [CSR_SISELECT]   = { "siselect",   csrind_or_aia_smode, NULL, NULL,
                          rmw_xiselect                                       },

-- 
2.43.0


