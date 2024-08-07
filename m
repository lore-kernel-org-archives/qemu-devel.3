Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97BCC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDs-0006D3-Um; Tue, 06 Aug 2024 20:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCx-0002iQ-Ie
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCs-0001AB-AA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so10817335ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989229; x=1723594029;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+bpIptaXttzHb1X4OnANFThKybY/9eTMuFsYvhrFb8=;
 b=c/HxErLaigVd3acSEpQ97yz96b7dTCfG54QbqhwP15lun3w2Ic7bM3liL2Er8DId3F
 kfS9x6XWlKjNX8fDfUn/1FWw+IeMfueylIe89a/3mOSfKY3cahfMk86sGYMaAfOHVcP9
 m3LJSlmWN9/AZCJb6rqifrGNiYZ4mbVglhLI60Yt3w8bKYS38NhvuLJ0vknqNXVjkRG5
 fSPR8Sif7xyIl5N0nSflPVUTE+kx4Y9JcoLLyASmjq35QWjaNSvQZAKc0vq5ljDEv0o9
 3N4eLgwlhG+SbdMmJQ37UFb+ucUfMRarZK8cxYN2syeoU2p/QAxRn8tQohuIkIt8EM0/
 rZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989229; x=1723594029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+bpIptaXttzHb1X4OnANFThKybY/9eTMuFsYvhrFb8=;
 b=r5WmViF13lZgiqcO7+gTpz9+lmzs2b/uIMz+a/rq+V6GMQYflwQqTAZy1EOWH6qu7g
 mrVE1Ukgqhnyb13nn0Ezil0FvqN48TmQTt2SGQlTde1MS5wlyJ3U37/s7Dy5z1zkx7Qo
 R+xyl/TfvxO6ZHoyf6wOOx21kx3slhfgJLV67Wni8cwpQGz76UabGEVhJ8OLdL/P+ma8
 6bhycjMys0RV6INqUEhqsWwCrNWOeEioU7y28hAZkzcmdpp3/d+OoB2/8K+tyGmHabG+
 T/GHw79JXxCzU1iKGroDzZy99m5/9K/2qo+fC9VUHDPD91S1SAhiYGbUpRnyMdkVJMJk
 XiZw==
X-Gm-Message-State: AOJu0YzabNxFML00uhfdIQC/J7rAwm5NfOgbaZ7/NXmAPAsSgRWAr90b
 x1N994m2alWxAVWXGsGFvFSCxoTStkuqXlZ6ExX+ObVIxRnJ490HWai2d2laCmPF6yLAr/qMQ8k
 F
X-Google-Smtp-Source: AGHT+IFG7uXHEvVwHbEQho2aFZZWbx/7WPdGFuM4KxUkMxCBzVTVVHRAIdL7MADtLu6rm0MXYSlQ6A==
X-Received: by 2002:a17:903:2348:b0:1fb:6ea1:5e with SMTP id
 d9443c01a7336-1ff574627f4mr168099205ad.44.1722989228530; 
 Tue, 06 Aug 2024 17:07:08 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:08 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 10/20] target/riscv: introduce ssp and enabling controls
 for zicfiss
Date: Tue,  6 Aug 2024 17:06:41 -0700
Message-ID: <20240807000652.1417776-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
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

zicfiss introduces a new state ssp ("shadow stack register") in cpu.
ssp is expressed as a new unprivileged csr (CSR_SSP=0x11) and holds
virtual address for shadow stack as programmed by software.

Shadow stack (for each mode) is enabled via bit3 in *envcfg CSRs.
Shadow stack can be enabled for a mode only if it's higher privileged
mode had it enabled for itself. M mode doesn't need enabling control,
it's always available if extension is available on cpu.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c      |  3 ++
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h |  6 ++++
 target/riscv/csr.c      | 74 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 54fcf380ff..6b50ae0e45 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -998,6 +998,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     /* on reset elp is set to NO_LP_EXPECTED */
     env->elp = NO_LP_EXPECTED;
 
+    /* on reset ssp is set to 0 */
+    env->ssp = 0;
+
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
      * extension is enabled.
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b77481428f..53b005b34c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     cfi_elp      elp;
+    /* shadow stack register for zicfiss extension */
+    target_ulong ssp;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 2c585a63c2..226157896d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -34,6 +34,9 @@
 
 /* Control and Status Registers */
 
+/* zicfiss user ssp csr */
+#define CSR_SSP             0x011
+
 /* User Trap Setup */
 #define CSR_USTATUS         0x000
 #define CSR_UIE             0x004
@@ -766,6 +769,7 @@ typedef enum RISCVException {
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_LPE                        BIT(2) /* zicfilp */
+#define MENVCFG_SSE                        BIT(3) /* zicfiss */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -780,12 +784,14 @@ typedef enum RISCVException {
 
 #define SENVCFG_FIOM                       MENVCFG_FIOM
 #define SENVCFG_LPE                        MENVCFG_LPE
+#define SENVCFG_SSE                        MENVCFG_SSE
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
+#define HENVCFG_SSE                        MENVCFG_SSE
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a5a969a377..d72d6289fb 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -185,6 +185,47 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException cfi_ss(CPURISCVState *env, int csrno)
+{
+    /* no cfi extension, access to csr is illegal */
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    /*
+     * CONFIG_USER_MODE always allow access for now. Better for user mode only
+     * functionality
+     */
+#if !defined(CONFIG_USER_ONLY)
+    if (env->debugger) {
+        return RISCV_EXCP_NONE;
+    }
+    /* current priv not M */
+    if (env->priv != PRV_M) {
+        /* menvcfg says no shadow stack enable */
+        if (!get_field(env->menvcfg, MENVCFG_SSE)) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+
+        /* V = 1 and henvcfg says no shadow stack enable */
+        if (env->virt_enabled &&
+            !get_field(env->henvcfg, HENVCFG_SSE)) {
+            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+        }
+
+        /*
+         * SSP are not accessible to U mode if disabled via senvcfg
+         * CSR
+         */
+        if ((env->priv == PRV_U) &&
+            (!get_field(env->senvcfg, SENVCFG_SSE))) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+    }
+#endif
+
+    return RISCV_EXCP_NONE;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
@@ -596,6 +637,19 @@ static RISCVException seed(CPURISCVState *env, int csrno)
 #endif
 }
 
+/* zicfiss CSR_SSP read and write */
+static int read_ssp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->ssp;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_ssp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->ssp = val;
+    return RISCV_EXCP_NONE;
+}
+
 /* User Floating-Point CSRs */
 static RISCVException read_fflags(CPURISCVState *env, int csrno,
                                   target_ulong *val)
@@ -2111,6 +2165,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= MENVCFG_LPE;
         }
+
+        if (env_archcpu(env)->cfg.ext_zicfiss) {
+            mask |= MENVCFG_SSE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2167,6 +2225,13 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         mask |= SENVCFG_LPE;
     }
 
+    /* Higher mode SSE must be ON for next-less mode SSE to be ON */
+    if (env_archcpu(env)->cfg.ext_zicfiss &&
+        get_field(env->menvcfg, MENVCFG_SSE) &&
+        (env->virt_enabled ? get_field(env->henvcfg, HENVCFG_SSE) : true)) {
+        mask |= SENVCFG_SSE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -2208,6 +2273,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= HENVCFG_LPE;
         }
+
+        /* H can light up SSE for VS only if HS had it from menvcfg */
+        if (env_archcpu(env)->cfg.ext_zicfiss &&
+            get_field(env->menvcfg, MENVCFG_SSE)) {
+            mask |= HENVCFG_SSE;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -4663,6 +4734,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Zcmt Extension */
     [CSR_JVT] = {"jvt", zcmt, read_jvt, write_jvt},
 
+    /* zicfiss Extension, shadow stack register */
+    [CSR_SSP]  = { "ssp", cfi_ss, read_ssp, write_ssp },
+
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
     [CSR_MCYCLE]    = { "mcycle",    any,   read_hpmcounter,
-- 
2.44.0


