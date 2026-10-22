Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DB606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=ftYy2Wob
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqs4-0000ok-NH; Thu, 22 Oct 2026 07:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJqrr-0000kp-Bk; Thu, 22 Oct 2026 07:21:56 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJqrn-0004aJ-IR; Thu, 22 Oct 2026 07:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1792668108;
 bh=5ZNU2HMQS5XM+YMyYoNZNgN+c+I3Ie5CfDbI8Jp8YHY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ftYy2Woba+hAIOItgs8bezTl2GGb0Ty/2rjU1nP9SUCW1Gd132+j87vqPdm/1CCNx
 FryUhENMDtbLhFXCm4u10CbrddsUaBUiRPuMVcUo2iGBLuWhC6iY9GbTunwyZmmYwN
 DwT4w71JxUzMuRCWiCN1Js+QmKhHX9xHsGZ9ooAjzDCqPA4yMTp4pI9TAjqF3u2H2y
 qBHKMr2fwmnY22wh/10DA5XhqvCbNwSArzJ0e+mGuriRMjMA2RJ0+KEIMQeGpTyflL
 BnZQudTWbR3QHbhFazNqAE9vvZQppmzL2m3bSEpne9+exHmvMl1OG8Vp4TNLJaP2Ki
 Ck9BjWPXMexEw==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 8DF5D4021E;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 89F41FF853;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 5491A140049;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 1/2] target/riscv: fix pmp sanitize error for x-rv128
Date: Thu, 22 Oct 2026 13:21:44 +0200
Message-ID: <20261022112145.356726-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022112145.356726-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20261022112145.356726-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

UndefinedBehaviorSanitizer reports an undefined behavior due to shifts
larger than type in the handling of the pmp configuration registers for the
x-rv128 cpu.
Adding an "i128" version for the functions accessing the pmpcfg registers
to properly handle the 128-bit case.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/tcg/csr.c | 66 ++++++++++++++++++++++++++++++++----------
 target/riscv/tcg/csr.h |  3 ++
 target/riscv/tcg/pmp.c | 38 ++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 063590f56a..fabb95c171 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5598,6 +5598,24 @@ static RISCVException write_pmpcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_pmpcfg_i128(CPURISCVState *env, int csrno,
+                                       Int128 *val)
+{
+    uint32_t reg_index = csrno - CSR_PMPCFG0;
+
+    *val = pmpcfg_csr_read_i128(env, reg_index);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_pmpcfg_i128(CPURISCVState *env, int csrno,
+                                        Int128 val)
+{
+    uint32_t reg_index = csrno - CSR_PMPCFG0;
+
+    pmpcfg_csr_write_i128(env, reg_index, val);
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
@@ -6472,33 +6490,49 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Physical Memory Protection */
     [CSR_MSECCFG]    = { "mseccfg",   have_mseccfg, read_mseccfg, write_mseccfg,
                          .min_priv_ver = PRIV_VERSION_1_11_0           },
-    [CSR_PMPCFG0]    = { "pmpcfg0",   pmp, read_pmpcfg,  write_pmpcfg  },
-    [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
-    [CSR_PMPCFG2]    = { "pmpcfg2",   pmp, read_pmpcfg,  write_pmpcfg  },
-    [CSR_PMPCFG3]    = { "pmpcfg3",   pmp, read_pmpcfg,  write_pmpcfg  },
-    [CSR_PMPCFG4]    = { "pmpcfg4",   pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG0]    = { "pmpcfg0",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                          read_pmpcfg_i128,  write_pmpcfg_i128 },
+    [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                          read_pmpcfg_i128,  write_pmpcfg_i128  },
+    [CSR_PMPCFG2]    = { "pmpcfg2",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                          read_pmpcfg_i128,  write_pmpcfg_i128  },
+    [CSR_PMPCFG3]    = { "pmpcfg3",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                          read_pmpcfg_i128,  write_pmpcfg_i128  },
+    [CSR_PMPCFG4]    = { "pmpcfg4",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                          read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG5]    = { "pmpcfg5",   pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG5]    = { "pmpcfg5",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                          read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG6]    = { "pmpcfg6",   pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG6]    = { "pmpcfg6",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG7]    = { "pmpcfg7",   pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG7]    = { "pmpcfg7",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG8]    = { "pmpcfg8",   pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG8]    = { "pmpcfg8",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG9]    = { "pmpcfg9",   pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG9]    = { "pmpcfg9",   pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG10]   = { "pmpcfg10",  pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG10]   = { "pmpcfg10",  pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG11]   = { "pmpcfg11",  pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG11]   = { "pmpcfg11",  pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG12]   = { "pmpcfg12",  pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG12]   = { "pmpcfg12",  pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG13]   = { "pmpcfg13",  pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG13]   = { "pmpcfg13",  pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG14]   = { "pmpcfg14",  pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG14]   = { "pmpcfg14",  pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
-    [CSR_PMPCFG15]   = { "pmpcfg15",  pmp, read_pmpcfg,  write_pmpcfg,
+    [CSR_PMPCFG15]   = { "pmpcfg15",  pmp, read_pmpcfg,  write_pmpcfg, NULL,
+                         read_pmpcfg_i128,  write_pmpcfg_i128,
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
     [CSR_PMPADDR0]   = { "pmpaddr0",  pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR1]   = { "pmpaddr1",  pmp, read_pmpaddr, write_pmpaddr },
diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
index 53ba3b4a4d..40396bafdb 100644
--- a/target/riscv/tcg/csr.h
+++ b/target/riscv/tcg/csr.h
@@ -91,6 +91,9 @@ extern const RISCVCSR mips_csr_list[];
 void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
                       target_ulong val);
 target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
+void pmpcfg_csr_write_i128(CPURISCVState *env, uint32_t reg_index,
+                           Int128 val);
+Int128 pmpcfg_csr_read_i128(CPURISCVState *env, uint32_t reg_index);
 
 void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
 uint64_t mseccfg_csr_read(CPURISCVState *env);
diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8..6fda5192ec 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -556,6 +556,28 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
     }
 }
 
+void pmpcfg_csr_write_i128(CPURISCVState *env, uint32_t reg_index,
+                           Int128 val)
+{
+    int i;
+    uint8_t cfg_val;
+    int pmpcfg_nums = 2 << riscv_cpu_mxl(env);
+    bool modified = false;
+
+    trace_pmpcfg_csr_write(env->mhartid, reg_index, int128_getlo(val));
+    trace_pmpcfg_csr_write(env->mhartid, reg_index, int128_gethi(val));
+
+    for (i = 0; i < pmpcfg_nums; i++) {
+        cfg_val = int128_getlo(int128_rshift(val, 8 * i)) & 0xff;
+        modified |= pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
+    }
+
+    /* If PMP permission of any addr has been changed, flush TLB pages. */
+    if (modified) {
+        pmp_update_rule_nums(env);
+        tlb_flush(env_cpu(env));
+    }
+}
 
 /*
  * Handle a read from a pmpcfg CSR
@@ -576,6 +598,22 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     return cfg_val;
 }
 
+Int128 pmpcfg_csr_read_i128(CPURISCVState *env, uint32_t reg_index)
+{
+    int i;
+    Int128 cfg_val = int128_zero();
+    target_ulong val = 0;
+    int pmpcfg_nums = 2 << riscv_cpu_mxl(env);
+
+    for (i = 0; i < pmpcfg_nums; i++) {
+        val = pmp_read_cfg(env, (reg_index * 4) + i);
+        cfg_val = int128_or(cfg_val, int128_lshift(int128_make64(val), i * 8));
+    }
+    trace_pmpcfg_csr_read(env->mhartid, reg_index, int128_getlo(cfg_val));
+    trace_pmpcfg_csr_read(env->mhartid, reg_index, int128_gethi(cfg_val));
+
+    return cfg_val;
+}
 
 /*
  * Handle a write to a pmpaddr CSR
-- 
2.43.0


