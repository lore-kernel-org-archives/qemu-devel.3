Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77636606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0vY/tCo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOqr-00019B-OW; Mon, 26 Oct 2026 13:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLOqW-000103-15; Mon, 26 Oct 2026 13:50:57 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLOqT-0002pd-9S; Mon, 26 Oct 2026 13:50:55 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94B3243BA4;
 Mon, 26 Oct 2026 17:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B251F01829;
 Mon, 26 Oct 2026 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793037043;
 bh=RvMqN6SbC/xHT4wvwwslrx0x9ciZDfPxrIAHjnIWJpQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j0vY/tCoUJ9KUX6KSxbLEiqO/qvToor/udsABnP78tJLTAYo0cV27eJOo0954cDeU
 dWPFfw2tlFtOIG/bncZ2d+ksu/xUXV637TB2Dmea/S5MbSnB+/AJHIPeV9uR4bByr+
 Aq13pYc8sIXqor1F/Tuvm2AemjYNTHqzG5gNMwtRojZVCWOGNDCNDjuLXJzSpy0x4q
 YKmcl4bUM4ut47XsA6+rZytkqmlK+vLcsCaeCrl1sQEGlEGLRH0dEG0hFFSDNwGq99
 gvHRaoAasWctnlQjR1wD3VUpZDjzVjFEtf+0fS29L4GwZbO7xJD9D1rBb0kcXK8L4z
 KZi/xCqQTWC/A==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 26 Oct 2026 10:47:21 -0700
Subject: [PATCH v6 1/6] riscv: implement Ssqosid extension and srmcfg CSR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-riscv-ssqosid-cbqri-v6-1-1a367a35cd0e@kernel.org>
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
In-Reply-To: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6886; i=fustini@kernel.org;
 h=from:subject:message-id; bh=W3lRJfHtxB7BMQxArR4azcXacYfgDpiRLYMuVfnYrQM=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTdn/SJbbodr5VlsYHvRu2v+7+vZ/gyT9eDjcfSoVxrX
 nXbguZlHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJSBoz/DN+Ge57u/CzcaxB
 yMXtZoLfrlxW+uP0I6J+y8Mer4cF95IZ/vvFLHZu1FB+36Fgse3dmZPxzJIaW9xLVmw1XS4XL6G
 twQ8A
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kornel Dulęba <mindal@semihalf.com>

Implement the srmcfg CSR defined by the Ssqosid ISA extension
(Supervisor-mode Quality of Service ID). The CSR contains two fields:

  - Resource Control ID (RCID) used determine resource allocation
  - Monitoring Counter ID (MCID) used to track resource usage

The CSR is defined for S-mode, so check mstateen0.srmcfg to determine
if s-mode is allowed to access it. In addition, accessing it when V=1
shall cause a virtual instruction exception.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0/riscv-cbqri.pdf
Link: https://docs.riscv.org/reference/isa/priv/smstateen.html
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[fustini: rebase on v10.1.50, fix check_srmcfg]
Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 disas/riscv.c                     |  1 +
 target/riscv/cpu.c                |  3 +++
 target/riscv/cpu.h                |  3 +++
 target/riscv/cpu_bits.h           |  9 +++++++++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/tcg/csr.c            | 37 +++++++++++++++++++++++++++++++++++++
 6 files changed, 54 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index ca0d6e90b373..bce5f58305dd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -703,6 +703,7 @@ static const char *csr_name(int csrno)
     case 0x0143: return "stval";
     case 0x0144: return "sip";
     case 0x0180: return "satp";
+    case 0x0181: return "srmcfg";
     case 0x0200: return "hstatus";
     case 0x0202: return "hedeleg";
     case 0x0203: return "hideleg";
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a0529fbdade..3432fea38ba0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -284,6 +284,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
+    ISA_EXT_DATA_ENTRY(ssqosid, PRIV_VERSION_1_13_0, ext_ssqosid),
     ISA_INTERNAL_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_INTERNAL_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
@@ -3504,6 +3505,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbc = true,
         .cfg.ext_zbs = true,
         .cfg.ext_sstc = true,
+        .cfg.ext_ssqosid = true,
         .cfg.ext_svadu = true,
         .cfg.ext_svvptc = true,
     ),
@@ -3577,6 +3579,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbc = true,
         .cfg.ext_zbs = true,
         .cfg.ext_sstc = true,
+        .cfg.ext_ssqosid = true,
         .cfg.ext_svadu = true,
         .cfg.ext_svvptc = true,
     ),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 49a1186bdbb2..0dfb280d1f33 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -369,6 +369,9 @@ struct CPUArchState {
     uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
     uint64_t ctr_data[16 << SCTRDEPTH_MAX];
 
+    /* Ssqosid extension */
+    target_ulong srmcfg;
+
     /* Machine and Supervisor interrupt priorities */
     uint8_t miprio[64];
     uint8_t siprio[64];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3579789a1f56..628183ae0fe2 100644
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
@@ -356,6 +359,7 @@
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
 #define SMSTATEEN0_CTR      (1ULL << 54)
+#define SMSTATEEN0_SRMCFG   (1ULL << 55)
 #define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
@@ -1199,4 +1203,9 @@ typedef enum CTRType {
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
index 85fc3ad8bb8c..1ecdf9f393b4 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -113,6 +113,7 @@ BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
 BOOL_FIELD(ext_ssctr)
 BOOL_FIELD(ext_sscofpmf)
+BOOL_FIELD(ext_ssqosid)
 BOOL_FIELD(ext_smepmp)
 BOOL_FIELD(ext_smrnmi)
 BOOL_FIELD(ext_ssnpm)
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f32..fc94f569ea8a 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1805,6 +1805,40 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException check_srmcfg(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_ssqosid) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SRMCFG);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
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
@@ -6377,6 +6411,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


