Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BBBC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGc9-0007UN-Oq; Wed, 17 Jul 2024 22:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGc8-0007Od-76
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGc6-0003VR-A5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fb3e9e32ffso2100075ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268681; x=1721873481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NdenwwcemciAx5XYGTqEB0Vd6aa6AeSqR/oYgqPmso=;
 b=j6V1xSn/avqwrnSfFi0JYlhr88bKenaguUr8dPoXmK5BhNT68NVb6Jy/pFuV1PZJhz
 QznGtK2Ai7Q1k+Lv1IcUV9dZHUlyUJyn2AldflG34w8BZvixMOJ2k0WssQydRNu5P0YR
 qkX4UsUi9+3lDEp7K0Um5Izy3nW0poOrBKi3gyM1NcQNPsX1cnkh8BHsQZzVDEAjulum
 h5lokE5aGWntFaX4auUssMAwXHh40iU8/n1pcXnORcuIC/HblBUOKo2MznK2R9O0g6ch
 71LSoodzFaxKfY3cC5soUweuhfckpkWs5FF3ScaSJpmVYJAojxSDW6BAu45Ml2YvPVXp
 Gd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268681; x=1721873481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NdenwwcemciAx5XYGTqEB0Vd6aa6AeSqR/oYgqPmso=;
 b=BLpCT9MvWQwDkfKNK+UeLBK99ns7wMBzrIJX+ZtTmdnsYUcFStuUs/PyOAvQbwnXkQ
 +bsVKFe0lZUc8jkQisjWM8EYPESkzf6rThhbOHaZXQHWGpmfFYKo3qI5vXdPkyvcyhy0
 24c9COjDGaVrIqgYHlEAJa51AyKUSHA9+XcHUR+bqNUfPraZfnSTnZTmWQZy/nUma+wm
 eCkHtMY9tz2bvth9Qi2To0BNDPVhempGRBelPFOUWtBk/oq3XpjbXs9alhSqqVtnsuJi
 0xs09O1O73ljcOTECaa7Q1TtSk9fTDWVjV/SZb/UjwVUbAOH03vHJAMjNH82uEaNY+8R
 NFaQ==
X-Gm-Message-State: AOJu0YxxQdz1E0++3yLDsko9Oty++aOps4nDRpJxmjQTNggM03qTgLmp
 7zP8ynTJw88ZRlj/kbuOvH4Mszil2Hy5DuXuUhTc6YzZQdWo5nXW5hEc18zC
X-Google-Smtp-Source: AGHT+IEFNswy+7pQr0A+43ngi8zAMWc1bRsJZdAE6NkKZy6L4iq9eSENnz+/7DERPLcnK9zW6wQlgQ==
X-Received: by 2002:a17:902:db0a:b0:1fb:8924:df95 with SMTP id
 d9443c01a7336-1fc4e56262emr25468795ad.48.1721268680819; 
 Wed, 17 Jul 2024 19:11:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/30] target/riscv: Add cycle & instret privilege mode
 filtering support
Date: Thu, 18 Jul 2024 12:10:01 +1000
Message-ID: <20240718021012.2057986-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

QEMU only calculates dummy cycles and instructions, so there is no
actual means to stop the icount in QEMU. Hence this patch merely adds
the functionality of accessing the cfg registers, and cause no actual
effects on the counting of cycle and instret counters.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240711-smcntrpmf_v7-v8-5-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  12 ++++
 target/riscv/csr.c      | 138 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 5faa817453..32b068f18a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -926,6 +926,18 @@ typedef enum RISCVException {
 #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
 #define MHPMEVENTH_BIT_VUINH               BIT(26)
 
+#define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
+                                            MHPMEVENT_BIT_SINH  | \
+                                            MHPMEVENT_BIT_UINH  | \
+                                            MHPMEVENT_BIT_VSINH | \
+                                            MHPMEVENT_BIT_VUINH)
+
+#define MHPMEVENTH_FILTER_MASK              (MHPMEVENTH_BIT_MINH  | \
+                                            MHPMEVENTH_BIT_SINH  | \
+                                            MHPMEVENTH_BIT_UINH  | \
+                                            MHPMEVENTH_BIT_VSINH | \
+                                            MHPMEVENTH_BIT_VUINH)
+
 #define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
 #define MHPMEVENT_IDX_MASK                 0xFFFFF
 #define MHPMEVENT_SSCOF_RESVD              16
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1bcf75f91f..8831d4f5ec 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -30,7 +30,6 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 
-
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
 {
@@ -236,6 +235,24 @@ static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
     return sscofpmf(env, csrno);
 }
 
+static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcntrpmf) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smcntrpmf(env, csrno);
+}
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -830,6 +847,111 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 
 #else /* CONFIG_USER_ONLY */
 
+static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
+{
+    *val = env->mcyclecfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
+                                      target_ulong val)
+{
+    uint64_t inh_avail_mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        env->mcyclecfg = val;
+    } else {
+        /* Set xINH fields if priv mode supported */
+        inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
+        inh_avail_mask |= riscv_has_ext(env, RVU) ? MCYCLECFG_BIT_UINH : 0;
+        inh_avail_mask |= riscv_has_ext(env, RVS) ? MCYCLECFG_BIT_SINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVU)) ? MCYCLECFG_BIT_VUINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVS)) ? MCYCLECFG_BIT_VSINH : 0;
+        env->mcyclecfg = val & inh_avail_mask;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val = env->mcyclecfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
+                                       target_ulong val)
+{
+    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+                                                 MCYCLECFGH_BIT_MINH);
+
+    /* Set xINH fields if priv mode supported */
+    inh_avail_mask |= riscv_has_ext(env, RVU) ? MCYCLECFGH_BIT_UINH : 0;
+    inh_avail_mask |= riscv_has_ext(env, RVS) ? MCYCLECFGH_BIT_SINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVU)) ? MCYCLECFGH_BIT_VUINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
+
+    env->mcyclecfgh = val & inh_avail_mask;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    *val = env->minstretcfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
+                                        target_ulong val)
+{
+    uint64_t inh_avail_mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        env->minstretcfg = val;
+    } else {
+        inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH;
+        inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UINH : 0;
+        inh_avail_mask |= riscv_has_ext(env, RVS) ? MINSTRETCFG_BIT_SINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVU)) ? MINSTRETCFG_BIT_VUINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVS)) ? MINSTRETCFG_BIT_VSINH : 0;
+        env->minstretcfg = val & inh_avail_mask;
+    }
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
+                                        target_ulong *val)
+{
+    *val = env->minstretcfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
+                                         target_ulong val)
+{
+    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+                                                 MINSTRETCFGH_BIT_MINH);
+
+    inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFGH_BIT_UINH : 0;
+    inh_avail_mask |= riscv_has_ext(env, RVS) ? MINSTRETCFGH_BIT_SINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVU)) ? MINSTRETCFGH_BIT_VUINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH : 0;
+
+    env->minstretcfgh = val & inh_avail_mask;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -5056,6 +5178,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                              write_mcountinhibit,
                              .min_priv_ver = PRIV_VERSION_1_11_0       },
 
+    [CSR_MCYCLECFG]      = { "mcyclecfg",   smcntrpmf, read_mcyclecfg,
+                             write_mcyclecfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+    [CSR_MINSTRETCFG]    = { "minstretcfg", smcntrpmf, read_minstretcfg,
+                             write_minstretcfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+
     [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_mhpmevent,
                              write_mhpmevent                           },
     [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_mhpmevent,
@@ -5115,6 +5244,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
                              write_mhpmevent                           },
 
+    [CSR_MCYCLECFGH]     = { "mcyclecfgh",   smcntrpmf_32, read_mcyclecfgh,
+                             write_mcyclecfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+    [CSR_MINSTRETCFGH]   = { "minstretcfgh", smcntrpmf_32, read_minstretcfgh,
+                             write_minstretcfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+
     [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-- 
2.45.2


