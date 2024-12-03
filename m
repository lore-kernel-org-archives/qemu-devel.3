Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCACE77166
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6a-0001Iv-N1; Tue, 03 Dec 2024 18:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6X-0001HV-Uw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:53 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6V-0001Ix-IZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:53 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fbce800ee5so6129201a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267690; x=1733872490;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ddN6SdqQg7ukvbQ2Vu2DeDWsVWqNeVtoQ+eBROZ4d8=;
 b=dSDqv9SUWdS9+pwtnL5uo2C+x3ptz5ab71dRBwuyKQSr/2uyWVF+1MW56Q4oDmSEGd
 EC0RjH5OhoB8jrh5CexyvOwCBERc+t8/mgj4ZKajyE7AO1GE9Crx/Xw9PQWgUorIZaWd
 NhVxioHoWGHYj4Kb9ZSMD7Lmud/NxndIW4xk7KKNnHc8T5bxJy2VqfG0mzPxxu+9pSPw
 kPZrgCegbXJr9dE4SDUxA+KE6zFTiT3H4dCDnuDrYNdLKisZa3iYxoevjUYjIvr92HJl
 W2RC540QEbd9WvqvBtHuAeuAaqXcPc1UaeqvbNvPuH/t7b5KeHRijb/FUxpGmyKbACo3
 9d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267690; x=1733872490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ddN6SdqQg7ukvbQ2Vu2DeDWsVWqNeVtoQ+eBROZ4d8=;
 b=vikPMYtEInwKs8n2Gt+6v8YrtclGF+qp/A45m1SzdP6EpIglNixYP67vnDVVUEJVMS
 YicRBjXO43EZCSJ5WBO9mdEGqhiUTO0NR1xpl6CJ3aSmO63U6c4zqbGgU4NrRNLtK+yK
 p7JUvjrivNANPMTrL27FTqdehGpjl7vjsscoQOjyirwRYHrnc9gU+8Uoi+DGAJdHVqI1
 AR/zEBWqMFhLq7bKoZwI9kghZBvrA6aTxylY9LVi4MIdtSBJeOTYaXq3JhpXfdmCAI0O
 daeabs9Cbrcce37zNYXHQ0tlSSK1B2YQGRODcTYQlxR/nH4VdSd1Ce3uW6Gqg1QnVOKk
 82Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbhH+iwVZP5UBl9d9fnBW2lErgZQt1Gx8AFmIes2GOZX5d3rUPG66JW3tHrFYFuCEsD1LxRAbvqa2I@nongnu.org
X-Gm-Message-State: AOJu0YyS/9/hOvZpgxuvMx21EpdjfPAL0PI8HazrEJJ4ggnnLk23SA/U
 ZU1DYr0rjVzbjZ8WYSE/IAFOGVQYaBY7a03qi/B0BeKOWiYkkrlh8prt7W0KIbk=
X-Gm-Gg: ASbGncse+Bi/rGuzzjb98xW6Y1XMirClOvAc7xfV5VESjzOOpJQK7Argd7VnZxWbpxp
 lHPICByTo/DyV2tQxp1wlejhpg5DNbqs1JMgyzsBEr5Pu+ASpRabA+Eoy43WF6fngst1pMON3Ob
 jp3KTELz+JaFvDptCEESKaTFAgd8yS0fJbictFbOhl3SanO7bCAwz46qyiMqK92cP9OcAxcCqCD
 KYxGr9Ote1jnHRs9eoeVreurxddL1i3OMZjLzWE9MfSalt1BLlp0hDvMlQkr+I=
X-Google-Smtp-Source: AGHT+IGmpC9YKh768Zc+vF/NJox8kvweiKFmbp8YFDEMu71MoKjqLxkEDRDflub0ivuDZPkpmkyyVg==
X-Received: by 2002:a05:6a20:244f:b0:1d6:fb3e:78cf with SMTP id
 adf61e73a8af0-1e165410fbdmr5848197637.41.1733267690067; 
 Tue, 03 Dec 2024 15:14:50 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:49 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:42 -0800
Subject: [PATCH v4 04/11] target/riscv: Support generic CSR indirect access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-4-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the indirect access registers required by sscsrind/smcsrind
and the operations on them. Note that xiselect and xireg are used for
both AIA and sxcsrind, and the behavior of accessing them depends on
whether each extension is enabled and the value stored in xiselect.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu_bits.h |  28 +++++++++-
 target/riscv/csr.c      | 144 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 385a2c67c24b..e13c5420a251 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -173,6 +173,13 @@
 #define CSR_MISELECT        0x350
 #define CSR_MIREG           0x351
 
+/* Machine Indirect Register Alias */
+#define CSR_MIREG2          0x352
+#define CSR_MIREG3          0x353
+#define CSR_MIREG4          0x355
+#define CSR_MIREG5          0x356
+#define CSR_MIREG6          0x357
+
 /* Machine-Level Interrupts (AIA) */
 #define CSR_MTOPEI          0x35c
 #define CSR_MTOPI           0xfb0
@@ -222,6 +229,13 @@
 #define CSR_SISELECT        0x150
 #define CSR_SIREG           0x151
 
+/* Supervisor Indirect Register Alias */
+#define CSR_SIREG2          0x152
+#define CSR_SIREG3          0x153
+#define CSR_SIREG4          0x155
+#define CSR_SIREG5          0x156
+#define CSR_SIREG6          0x157
+
 /* Supervisor-Level Interrupts (AIA) */
 #define CSR_STOPEI          0x15c
 #define CSR_STOPI           0xdb0
@@ -288,6 +302,13 @@
 #define CSR_VSISELECT       0x250
 #define CSR_VSIREG          0x251
 
+/* Virtual Supervisor Indirect Alias */
+#define CSR_VSIREG2         0x252
+#define CSR_VSIREG3         0x253
+#define CSR_VSIREG4         0x255
+#define CSR_VSIREG5         0x256
+#define CSR_VSIREG6         0x257
+
 /* VS-Level Interrupts (H-extension with AIA) */
 #define CSR_VSTOPEI         0x25c
 #define CSR_VSTOPI          0xeb0
@@ -863,10 +884,13 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_EIE63                0xff
 #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
-#define ISELECT_MASK                       0x1ff
+#define ISELECT_MASK_AIA                   0x1ff
+
+/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+#define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
-#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
+#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
 
 /* IMSIC bits (AIA) */
 #define IMSIC_TOPEI_IID_SHIFT              16
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c91a26a52ef6..424e9dbbd4ff 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -306,6 +306,15 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
+static RISCVException csrind_any(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
@@ -389,6 +398,15 @@ static bool csrind_or_aia_extensions_present(CPURISCVState *env)
     return csrind_extensions_present(env) || aia_extensions_present(env);
 }
 
+static RISCVException csrind_smode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smode(env, csrno);
+}
+
 static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
 {
     if (!csrind_or_aia_extensions_present(env)) {
@@ -417,6 +435,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
 }
 
+static RISCVException csrind_hmode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
 {
     if (!csrind_or_aia_extensions_present(env)) {
@@ -2065,7 +2092,12 @@ static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
     case CSR_SISELECT:
         return CSR_VSISELECT;
     case CSR_SIREG:
-        return CSR_VSIREG;
+    case CSR_SIREG2:
+    case CSR_SIREG3:
+    case CSR_SIREG4:
+    case CSR_SIREG5:
+    case CSR_SIREG6:
+        return CSR_VSIREG + (csrno - CSR_SIREG);
     default:
         return csrno;
     };
@@ -2105,7 +2137,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
         *val = *iselect;
     }
 
-    wr_mask &= ISELECT_MASK;
+    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind) {
+        wr_mask &= ISELECT_MASK_SXCSRIND;
+    } else {
+        wr_mask &= ISELECT_MASK_AIA;
+    }
+
     if (wr_mask) {
         *iselect = (*iselect & ~wr_mask) | (new_val & wr_mask);
     }
@@ -2244,6 +2281,56 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+/*
+ * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
+ *
+ * Perform indirect access to xireg and xireg2-xireg6.
+ * This is a generic interface for all xireg CSRs. Apart from AIA, all other
+ * extension using csrind should be implemented here.
+ */
+static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
+                              target_ulong isel, target_ulong *val,
+                              target_ulong new_val, target_ulong wr_mask)
+{
+    return -EINVAL;
+}
+
+static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
+                      target_ulong new_val, target_ulong wr_mask)
+{
+    bool virt = false;
+    int ret = -EINVAL;
+    target_ulong isel;
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Translate CSR number for VS-mode */
+    csrno = csrind_xlate_vs_csrno(env, csrno);
+
+    if (CSR_MIREG <= csrno && csrno <= CSR_MIREG6 &&
+        csrno != CSR_MIREG4 - 1) {
+        isel = env->miselect;
+    } else if (CSR_SIREG <= csrno && csrno <= CSR_SIREG6 &&
+               csrno != CSR_SIREG4 - 1) {
+        isel = env->siselect;
+    } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
+               csrno != CSR_VSIREG4 - 1) {
+        isel = env->vsiselect;
+        virt = true;
+    } else {
+        goto done;
+    }
+
+    return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
+
+done:
+    return (env->virt_enabled && virt) ?
+            RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+}
+
 static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong *val, target_ulong new_val,
                                 target_ulong wr_mask)
@@ -2276,8 +2363,21 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
          goto done;
     };
 
+    /*
+     * Use the xiselect range to determine actual op on xireg.
+     *
+     * Since we only checked the existence of AIA or Indirect Access in the
+     * predicate, we should check the existence of the exact extension when
+     * we get to a specific range and return illegal instruction exception even
+     * in VS-mode.
+     */
     if (xiselect_aia_range(isel)) {
         return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
+    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
+               riscv_cpu_cfg(env)->ext_sscsrind) {
+        return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
     }
 
 done:
@@ -2735,7 +2835,7 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
-    if (riscv_cpu_cfg(env)->ext_smaia) {
+    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -2828,7 +2928,7 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (riscv_cpu_cfg(env)->ext_ssaia) {
+    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -5261,6 +5361,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MIREG]    = { "mireg",    csrind_or_aia_any,   NULL, NULL,
                        rmw_xireg                                       },
 
+    /* Machine Indirect Register Alias */
+    [CSR_MIREG2]   = { "mireg2", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG3]   = { "mireg3", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG4]   = { "mireg4", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG5]   = { "mireg5", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG6]   = { "mireg6", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+
     /* Machine-Level Interrupts (AIA) */
     [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
     [CSR_MTOPI]    = { "mtopi",    aia_any, read_mtopi },
@@ -5382,6 +5494,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SIREG]      = { "sireg",      csrind_or_aia_smode, NULL, NULL,
                          rmw_xireg                                          },
 
+    /* Supervisor Indirect Register Alias */
+    [CSR_SIREG2]      = { "sireg2", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG3]      = { "sireg3", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG4]      = { "sireg4", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG5]      = { "sireg5", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG6]      = { "sireg6", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* Supervisor-Level Interrupts (AIA) */
     [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
     [CSR_STOPI]      = { "stopi",      aia_smode, read_stopi },
@@ -5464,6 +5588,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIREG]      = { "vsireg",      csrind_or_aia_hmode, NULL, NULL,
                           rmw_xireg                                         },
 
+    /* Virtual Supervisor Indirect Alias */
+    [CSR_VSIREG2]     = { "vsireg2", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG3]     = { "vsireg3", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG4]     = { "vsireg4", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG5]     = { "vsireg5", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG6]     = { "vsireg6", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* VS-Level Interrupts (H-extension with AIA) */
     [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },
     [CSR_VSTOPI]      = { "vstopi",      aia_hmode, read_vstopi },

-- 
2.34.1


