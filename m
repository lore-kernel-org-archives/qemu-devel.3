Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96067606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K47Mxn85
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc7t-0006uJ-Kn; Sun, 01 Nov 2026 15:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xNc7r-0006tB-O1; Sun, 01 Nov 2026 15:25:59 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xNc7p-0008Dt-2u; Sun, 01 Nov 2026 15:25:59 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5ED9243E87;
 Sun,  1 Nov 2026 20:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114D71F0093A;
 Sun,  1 Nov 2026 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793564754;
 bh=I7ouLT/M+BCFIajGZwqKr4c5+Q8BhYcniakHEvtW6E8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=K47Mxn85Gz6CytauvsyeJqfW5kQCc1UzWTB4gt3t5Dv9znW4e+ruW4LuSuNRLxbNU
 bE8V/OqwCzG1ujQOMxKTUHxXl/7IIBLKxIGyl9IzpIgqj0cxC5ArC3DNwaBSysFxfl
 xC9jpKVgEpB5K3xXql9wvxpSeE2OLdNX2Wv2WCRcCYRylAe0MD1hOmQEgPD3n7iTnW
 ZtJGbeKCHSQGhCtAYFnLMeNfRxdIml5GDjXRnn1kOI8zJu2H6no0mIPuLBgyuFdktM
 ctdNyCNthLTLtC8N5etbvIrgAqb8vN7dL4HBVGm8g9YTL19cYgHSgRpoEEmOYJSNB4
 rIflhhZ3Z9WOA==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 01 Nov 2026 12:25:33 -0800
Subject: [PATCH v7 1/6] riscv: implement Ssqosid extension and srmcfg CSR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-riscv-ssqosid-cbqri-v7-1-92d1aae43e48@kernel.org>
References: <20261101-riscv-ssqosid-cbqri-v7-0-92d1aae43e48@kernel.org>
In-Reply-To: <20261101-riscv-ssqosid-cbqri-v7-0-92d1aae43e48@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8592; i=fustini@kernel.org;
 h=from:subject:message-id; bh=pH4ntEx3/2eZ64PKcIOMCwFtuys3Wn2+acOLUhS3X44=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ9XxDYLMnDYxncZWvhGXqvwfJD6N+nylVlmgVcLuwcP
 UczI9U7SlkYxLgYZMUUWTZ9yLuwxCv064L5L7bBzGFlAhnCwMUpABMJuMDwV/6g2jG5EsEphw+z
 uMu927steq7LrYVJrPqiUbNOtUwXuMrIsNC/rG72y9fyco6iacue7V+yuNn77C/59/bvlj/zU2P
 rZQUA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kornel Dulęba <mindal@semihalf.com>

Implement the srmcfg CSR defined by the Ssqosid ISA extension
(Supervisor-mode Quality of Service ID). The CSR contains two fields:

  - Resource Control ID (RCID) used to determine resource allocation
  - Monitoring Counter ID (MCID) used to track resource usage

The CSR is defined for S-mode, so check mstateen0.srmcfg to determine
if S-mode is allowed to access it. In addition, accessing it when V=1
shall cause a virtual instruction exception.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0/riscv-cbqri.pdf
Link: https://docs.riscv.org/reference/isa/priv/smstateen.html
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[fustini: rebase, fix check_srmcfg]
Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 disas/riscv.c                     |  1 +
 target/riscv/cpu.c                |  3 +++
 target/riscv/cpu.h                |  3 +++
 target/riscv/cpu_bits.h           |  9 ++++++++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/machine.c            | 19 +++++++++++++++++
 target/riscv/tcg/csr.c            | 45 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 81 insertions(+)

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
index 3579789a1f56..33af64f3667e 100644
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
+/* SRMCFG CSR field masks (Ssqosid extension) */
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
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0de06e958809..fa99c68fc852 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -382,6 +382,24 @@ static const VMStateDescription vmstate_sdext = {
     }
 };
 
+static bool ssqosid_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_ssqosid;
+}
+
+static const VMStateDescription vmstate_ssqosid = {
+    .name = "cpu/ssqosid",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ssqosid_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.srmcfg, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int riscv_cpu_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
@@ -656,6 +674,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_sstc,
         &vmstate_mseccfg,
         &vmstate_sdext,
+        &vmstate_ssqosid,
         NULL
     }
 };
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f32..cf8c8d924835 100644
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
+     * a virtual instruction fault if a guest tries to access it.
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
@@ -3738,6 +3772,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         if (riscv_cpu_cfg(env)->ext_ssctr) {
             wr_mask |= SMSTATEEN0_CTR;
         }
+
+        if (riscv_cpu_cfg(env)->ext_ssqosid) {
+            wr_mask |= SMSTATEEN0_SRMCFG;
+        }
     }
 
     return write_mstateen(env, csrno, wr_mask, new_val);
@@ -3797,6 +3835,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_CTR;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssqosid) {
+        wr_mask |= SMSTATEEN0_SRMCFG;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -6377,6 +6419,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


