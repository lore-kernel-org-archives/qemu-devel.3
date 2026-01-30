Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB457D49C67
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlioN-0004Wr-Mg; Fri, 30 Jan 2026 02:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlioJ-0004Vt-Rx
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:20:57 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlioH-0006ud-CA
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:20:55 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-823210d1d8eso982847b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 23:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769757652; x=1770362452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WX1YIBlSSk0z3OjfqR27Nt/ZCHCH8tJk8Hn9YPPY784=;
 b=juQghVPK/WztjqseE4DNQXzcyQ7HvsQxWeX/qxQszD8Lj/C+GQfg02gk8CTCxJTyUe
 IGcm9GgvPObKkLxgOqvMb6ahDrPGZrSz9q9IkWzVtxMezDJTIhLB88mC4nch/+7L6e1l
 m4txr7JiEKJ4krdgqU+BppfcXDuR0DAzQsoUMtKcd+mN0r1YsOoNIByrCVd7a+s/EQ3H
 x9Xdrqd2fvkcyE+egvc/L8NcK4mYqvpDpF1IOYMYxgopcZ6Kgstf9sEVn7jmk+4unjVn
 IgXZoozzvlqFR4/jW9p1iXkTvwjUr5o5U2YRBPlV/q2UT3zoDsXD7W51g4mHBmyQDgy/
 VRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769757652; x=1770362452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WX1YIBlSSk0z3OjfqR27Nt/ZCHCH8tJk8Hn9YPPY784=;
 b=f6/3HIy5zEV6q/5bDFbJn5/oMJJegg0eoqb42PA56Nmiwd0QFUZwtlaCb9sm3T0Od4
 OQ3T5Jm8tbMjSrClhofXEdTpXh1brkHH7wlZIberySSNmg6O1MLzWXlQePrQGPwc2WBB
 x/2i3eEnRXSY3uoTbkXQdxEZtSguPzw/TarThvbk+FlVUEfhFXFQZmedKNSeZasb0Bfl
 CC1PKdtH46vni5x/ikfYn8cAmmMMdjIKQsYtxs28ojBSf51l3/Ru9NiJKSOteTCe2/p1
 yA9aXXwvkW4PUiOo0WwlG9ymznRsxuKnkh0wLj20+Q+WDYkypkxwKp1rEr+lD5P+4+s9
 Z6HA==
X-Gm-Message-State: AOJu0YwUSLeBh4adIBLc0Iuxfr+7z5PVHbkVFvJT6EdX6og4fSs5PIyq
 0j8fYTWvh4JZznkyRa/RLb3YLlrl8/L8BnHZFlyjavDvmr/aczzlIYMW
X-Gm-Gg: AZuq6aJZDTztD0g4xMp126qhwQE574OFCsMAPQGiHTa7tO6qaL8e/5FjQOTVWQOXs2T
 adBs++hUGJAm9XqUTMC5C5fJ7mauMPan+YwKaCQnr4ebJd7N8S6IwQ5AplPgUKloot/8BOdvYzg
 99jbOOccr94gklq5mqtlS51gZvO3uMJZNKS6fkSYMI8fnKstlDojQ/BdISk/ofhDcf+tcvmDLrO
 7laP8mHELFTVK5sxPm4wOmDHcvhv29JQwvO1IJP6IU/lU+C9IYGLsasrRUQ66RQQ2qx/wPb3Xfe
 69vwCxeQNycuxVGHOUvmSEVXwRcSooknFeScxYNWxHRanGLDv+Mya8Q0I/RhNih9vBxPnJRMG0G
 P6thO6grGkBUfo7RZ7LaIAdM9oicFDbahZV2zy+NrbUskWsO4EHoMj19hEEMqSs/g1kPGu0FrI1
 t++UTF8sANqrxKVXhtMjwisfBXV2zTM1Rp/NL13njMUAAaLk03UB0/hVMY9zo=
X-Received: by 2002:a05:6a00:3497:b0:821:8230:235d with SMTP id
 d2e1a72fcca58-823aa6ee07fmr1994605b3a.39.1769757651934; 
 Thu, 29 Jan 2026 23:20:51 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c227c2sm7269905b3a.53.2026.01.29.23.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 23:20:51 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@zevorn.cn>,
 Conor Dooley <conor@kernel.org>, Peng Jiang <3160104094@zju.edu.cn>
Subject: [PATCH v5 1/5] target/riscv: add thead-c908 cpu support
Date: Fri, 30 Jan 2026 15:19:39 +0800
Message-ID: <c97e77991ee9c1dfdf59aff81806371df40960ad.1769757064.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769757064.git.chao.liu.zevorn@gmail.com>
References: <cover.1769757064.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chao Liu <chao.liu@zevorn.cn>

The C908 processor is based on the RV64GCB[V] instruction
set, compatible to RVA22 Profile and implements the XIE
(XuanTie Instruction Extension) technology.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Conor Dooley <conor@kernel.org>
Reported-by: Peng Jiang <3160104094@zju.edu.cn>
---
 target/riscv/cpu-qom.h |   2 +
 target/riscv/cpu.c     |  51 ++++++
 target/riscv/th_csr.c  | 380 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 432 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 30dcdcfaae..1a28f1369c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -52,6 +52,8 @@
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
+#define TYPE_RISCV_CPU_THEAD_C908       RISCV_CPU_TYPE_NAME("thead-c908")
+#define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa7079d86e..aa3ac557e1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3134,6 +3134,57 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.ext_xtheadba = true,
+        .cfg.ext_xtheadbb = true,
+        .cfg.ext_xtheadbs = true,
+        .cfg.ext_xtheadcmo = true,
+        .cfg.ext_xtheadcondmov = true,
+        .cfg.ext_xtheadfmv = true,
+        .cfg.ext_xtheadfmemidx = true,
+        .cfg.ext_xtheadmac = true,
+        .cfg.ext_xtheadmemidx = true,
+        .cfg.ext_xtheadmempair = true,
+        .cfg.ext_xtheadsync = true,
+        .cfg.ext_smepmp = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svpbmt = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zkt = true,
+        .cfg.ext_zbkc = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicboz = true,
+
+        .cfg.pmp = true,
+        .cfg.mmu = true,
+        .cfg.max_satp_mode = VM_1_10_SV48,
+
+        .cfg.marchid = 0x8d143000,
+        .cfg.mvendorid = THEAD_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = th_csr_list,
+#endif
+    ),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV,
+        .vext_spec = VEXT_VERSION_1_00_0,
+    ),
+
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 49eb7bbab5..e19cab5414 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -2,6 +2,9 @@
  * T-Head-specific CSRs.
  *
  * Copyright (c) 2024 VRULL GmbH
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * For more information, see XuanTie-C908-UserManual_xrvm_20240530.pdf
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -20,13 +23,88 @@
 #include "cpu.h"
 #include "cpu_vendorid.h"
 
-#define CSR_TH_SXSTATUS 0x5c0
+/* Extended M-mode control registers of T-Head */
+#define CSR_TH_MXSTATUS        0x7c0
+#define CSR_TH_MHCR            0x7c1
+#define CSR_TH_MCOR            0x7c2
+#define CSR_TH_MCCR2           0x7c3
+#define CSR_TH_MHINT           0x7c5
+#define CSR_TH_MRVBR           0x7c7
+#define CSR_TH_MCOUNTERWEN     0x7c9
+#define CSR_TH_MCOUNTERINTEN   0x7ca
+#define CSR_TH_MCOUNTEROF      0x7cb
+#define CSR_TH_MCINS           0x7d2
+#define CSR_TH_MCINDEX         0x7d3
+#define CSR_TH_MCDATA0         0x7d4
+#define CSR_TH_MCDATA1         0x7d5
+#define CSR_TH_MSMPR           0x7f3
+#define CSR_TH_CPUID           0xfc0
+#define CSR_TH_MAPBADDR        0xfc1
+
+/* TH_MXSTATUS bits */
+#define TH_MXSTATUS_UCME        BIT(16)
+#define TH_MXSTATUS_MAEE        BIT(21)
+#define TH_MXSTATUS_THEADISAEE  BIT(22)
+
+/* Extended S-mode control registers of T-Head */
+#define CSR_TH_SXSTATUS        0x5c0
+#define CSR_TH_SHCR            0x5c1
+#define CSR_TH_SCER2           0x5c2
+#define CSR_TH_SCER            0x5c3
+#define CSR_TH_SCOUNTERINTEN   0x5c4
+#define CSR_TH_SCOUNTEROF      0x5c5
+#define CSR_TH_SCYCLE          0x5e0
+#define CSR_TH_SHPMCOUNTER3    0x5e3
+#define CSR_TH_SHPMCOUNTER4    0x5e4
+#define CSR_TH_SHPMCOUNTER5    0x5e5
+#define CSR_TH_SHPMCOUNTER6    0x5e6
+#define CSR_TH_SHPMCOUNTER7    0x5e7
+#define CSR_TH_SHPMCOUNTER8    0x5e8
+#define CSR_TH_SHPMCOUNTER9    0x5e9
+#define CSR_TH_SHPMCOUNTER10   0x5ea
+#define CSR_TH_SHPMCOUNTER11   0x5eb
+#define CSR_TH_SHPMCOUNTER12   0x5ec
+#define CSR_TH_SHPMCOUNTER13   0x5ed
+#define CSR_TH_SHPMCOUNTER14   0x5ee
+#define CSR_TH_SHPMCOUNTER15   0x5ef
+#define CSR_TH_SHPMCOUNTER16   0x5f0
+#define CSR_TH_SHPMCOUNTER17   0x5f1
+#define CSR_TH_SHPMCOUNTER18   0x5f2
+#define CSR_TH_SHPMCOUNTER19   0x5f3
+#define CSR_TH_SHPMCOUNTER20   0x5f4
+#define CSR_TH_SHPMCOUNTER21   0x5f5
+#define CSR_TH_SHPMCOUNTER22   0x5f6
+#define CSR_TH_SHPMCOUNTER23   0x5f7
+#define CSR_TH_SHPMCOUNTER24   0x5f8
+#define CSR_TH_SHPMCOUNTER25   0x5f9
+#define CSR_TH_SHPMCOUNTER26   0x5fa
+#define CSR_TH_SHPMCOUNTER27   0x5fb
+#define CSR_TH_SHPMCOUNTER28   0x5fc
+#define CSR_TH_SHPMCOUNTER29   0x5fd
+#define CSR_TH_SHPMCOUNTER30   0x5fe
+#define CSR_TH_SHPMCOUNTER31   0x5ff
+#define CSR_TH_SMIR            0x9c0
+#define CSR_TH_SMLO0           0x9c1
+#define CSR_TH_SMEH            0x9c2
+#define CSR_TH_SMCIR           0x9c3
+
+/* Extended U-mode control registers of T-Head */
+#define CSR_TH_FXCR            0x800
 
 /* TH_SXSTATUS bits */
 #define TH_SXSTATUS_UCME        BIT(16)
 #define TH_SXSTATUS_MAEE        BIT(21)
 #define TH_SXSTATUS_THEADISAEE  BIT(22)
 
+static RISCVException mmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVM)) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
@@ -36,11 +114,31 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
 static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
     return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
+static RISCVException read_th_mxstatus(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    /* We don't set MAEE here, because QEMU does not implement MAEE. */
+    *val = TH_MXSTATUS_UCME | TH_MXSTATUS_THEADISAEE;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_unimp_th_csr(CPURISCVState *env, int csrno,
+                                        target_ulong *val)
+{
+    *val = 0;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
@@ -50,10 +148,290 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
 }
 
 const RISCVCSR th_csr_list[] = {
+    {
+        .csrno = CSR_TH_MXSTATUS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mxstatus", mmode, read_th_mxstatus }
+    },
+    {
+        .csrno = CSR_TH_MHCR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mhcr", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcor", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCCR2,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mccr2", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MHINT,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mhint", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MRVBR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mrvbr", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOUNTERWEN,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterwen", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOUNTERINTEN,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterinten", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOUNTEROF,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterof", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCINS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcins", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCINDEX,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcindex", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCDATA0,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcdata0", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCDATA1,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcdata1", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MSMPR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.msmpr", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_CPUID,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.cpuid", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MAPBADDR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mapbaddr", mmode, read_unimp_th_csr }
+    },
     {
         .csrno = CSR_TH_SXSTATUS,
         .insertion_test = test_thead_mvendorid,
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     },
+    {
+        .csrno = CSR_TH_SHCR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shcr", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCER2,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scer2", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCER,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scer", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCOUNTERINTEN,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scounterinten", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCOUNTEROF,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scounterof", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCYCLE,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scycle", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER3,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter3", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER4,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter4", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER5,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter5", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER6,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter6", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER7,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter7", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER8,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter8", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER9,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter9", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER10,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter10", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER11,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter11", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER12,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter12", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER13,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter13", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER14,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter14", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER15,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter15", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER16,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter16", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER17,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter17", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER18,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter18", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER19,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter19", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER20,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter20", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER21,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter21", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER22,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter22", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER23,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter23", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER24,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter24", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER25,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter25", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER26,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter26", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER27,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter27", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER28,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter28", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER29,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter29", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER30,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter30", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER31,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter31", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMIR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smir", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMLO0,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smlo0", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMEH,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smeh", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMCIR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smcir", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_FXCR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.fxcr", any, read_unimp_th_csr }
+    },
     { }
 };
-- 
2.52.0


