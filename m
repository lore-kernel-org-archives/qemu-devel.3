Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B046C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp83-0003Wg-N9; Tue, 25 Aug 2026 07:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7y-00035n-Mf; Tue, 25 Aug 2026 07:15:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7w-0000fZ-C9; Tue, 25 Aug 2026 07:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=kJGMYrsT+mbyBc171FYvuxdrVVe9paVL1PkDwkX2aaE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nS2n3neqKwFVS1lpis5ebSJ6sCnUjN1Jxyu6adTtK0lWUzuktN8s0flyamH/fqZxm
 apetTSHPsZgDAQepD49KCqAF2uk5S+62mM2KswSqklTAnyh0xwADOHRDLfWIUPgyh+
 z38qQNeG+dN8JIlhaCo6FeVWaH1M71aeooMUHBekg3Ea5Ed4VggA5fXYwjQP+rp3Zg
 3F7BJNKTJNvNFNBRSS0ZqIkjhlwLzaZG2yU2PRs8kZoe1F+W8q3UMvo5ddUD8JYEaa
 b6R9/MTgT1C2Fmar7VMbM40ghMeLWUtL45Eb2S7JQ1D/FfEwsWeyyJJivJww2fksqa
 iDZBo3ETZEKSQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7881C1CE4BB;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9155D416287;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AAAC5325B9; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, A-Shehab <ahshehab24@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 159/166] target/riscv: allow menvcfg/henvcfg LPE
 and SSE bits on RV32
Date: Tue, 25 Aug 2026 14:11:55 +0300
Message-ID: <20260825111206.482723-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: A-Shehab <ahshehab24@gmail.com>

The Zicfilp landing-pad enable (LPE, bit 2) and Zicfiss shadow-stack
enable (SSE, bit 3) controls live in the low 32 bits of menvcfg and
henvcfg, and the CFI specification defines them for both RV32 and RV64.

QEMU only adds MENVCFG_LPE/MENVCFG_SSE (and the henvcfg equivalents) to
the writable mask inside the "riscv_cpu_mxl(env) == MXL_RV64" block, so
on RV32 these bits are silently dropped and the features cannot be
enabled. This is inconsistent with write_senvcfg(), which already
handles SENVCFG_LPE/SENVCFG_SSE regardless of MXLEN.

Hoist the LPE/SSE mask handling out of the RV64-only block in
write_menvcfg() and write_henvcfg() so the bits become writable on RV32
as well. The upper-half writers (write_menvcfgh/write_henvcfgh) are
unaffected because these bits reside in the low 32 bits.

Reproducible on qemu-system-riscv32 -cpu rv32,zicfilp=true,zicfiss=true:
an M-mode write of menvcfg.{LPE,SSE} reads back as zero, while the same
program on rv64 keeps the bits set.

Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling controls for zicfilp")
Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls for zicfiss")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4045
Signed-off-by: A-Shehab <ahshehab24@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260726080537.13913-1-ahshehab24@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit bd1ee9ab3c39f269d8bea8acf83ea833a69a6e10)
(Mjt: introduce `RISCVCPUConfig *cfg` variable in write_henvcfg()
  from v10.0.0-1878-gdff5f515409f
 "target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4015f023d10..9d43dbfab81 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3196,6 +3196,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
                     MENVCFG_CBZE | MENVCFG_CDE;
 
+    /*
+     * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= MENVCFG_LPE;
+    }
+
+    if (cfg->ext_zicfiss) {
+        mask |= MENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
@@ -3203,14 +3216,6 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
                 (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= MENVCFG_LPE;
-        }
-
-        if (env_archcpu(env)->cfg.ext_zicfiss) {
-            mask |= MENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_smnpm &&
             get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
@@ -3331,6 +3336,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
     RISCVException ret;
 
@@ -3339,20 +3345,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         return ret;
     }
 
+    /*
+     * henvcfg.LPE (Zicfilp) and henvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= HENVCFG_LPE;
+    }
+
+    /* H can light up SSE for VS only if HS had it from menvcfg */
+    if (cfg->ext_zicfiss && get_field(env->menvcfg, MENVCFG_SSE)) {
+        mask |= HENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
                                 HENVCFG_DTE);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= HENVCFG_LPE;
-        }
-
-        /* H can light up SSE for VS only if HS had it from menvcfg */
-        if (env_archcpu(env)->cfg.ext_zicfiss &&
-            get_field(env->menvcfg, MENVCFG_SSE)) {
-            mask |= HENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_ssnpm &&
             get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
-- 
2.47.3


