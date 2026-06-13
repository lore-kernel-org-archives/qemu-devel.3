Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142FFCD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV5q-0001Tj-G2; Sat, 13 Jun 2026 16:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5l-0001OU-P3; Sat, 13 Jun 2026 16:36:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5h-00039B-DZ; Sat, 13 Jun 2026 16:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382962; bh=ruH2hkT0kSahVJDVkJVWgjKgRpyoHENjlyJWh/U7KsQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FesZH91FsLWovD1yWFxoKFyqz1GMlmq+2dLSlrQJEQxe2AhHl0qLsh9tH2Sg09HWI
 Cp4S8MnZL39vbHyVzBPI+HeG5r51FrOGaE+QWzG1co8ieemdJZq+0gdzX4DYyZB8XL
 UVc0pcXA9GCh3z1Mkq672TS+IWpX2lToXsBImHhHm2Wi5hpJ5hBdcz0NdgZz6zvPTJ
 PHFOQb35AAIH7hOs8ifTe2DYXUOFYESMb2S+6+yChW8/Y8PPq9p+exfRMVE9lwrl2C
 D39KMsbEfb6FwGC1I/9x9t5rlNfllZt0RTO3uLwAtMETOIWRjUcBbOdcKPypbe+/SS
 1jKAbunAEq0Yg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 712AC1B6EDC;
 Sat, 13 Jun 2026 23:36:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D6D803CE92E;
 Sat, 13 Jun 2026 23:36:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 02/72] target/riscv: Update MISA.C for Zc* extensions
Date: Sat, 13 Jun 2026 23:34:28 +0300
Message-ID: <20260613203542.1809153-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

From: Frank Chang <frank.chang@sifive.com>

MISA.C is set if the following extensions are selected:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only).

Therefore, MISA.C must be set according to the Zc* extension rules.

Warn the user if RVC is explicitly disabled but MISA.C is required by
the rules above.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260424050509.3935180-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit f0433a8bc4ac5626499ff09ba5d165dbf7a4a980)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..800b7dce5d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1150,6 +1150,44 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     }
 }
 
+/*
+ * MISA.C is set if the following extensions are selected:
+ *   - Zca and not F.
+ *   - Zca, Zcf and F (but not D) is specified on RV32.
+ *   - Zca, Zcf and Zcd if D is specified on RV32.
+ *   - Zca, Zcd if D is specified on RV64.
+ */
+static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    bool set_misa_c = false;
+
+    if (riscv_has_ext(env, RVC)) {
+        return;
+    }
+
+    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
+        set_misa_c = true;
+    } else if (riscv_cpu_mxl(env) == MXL_RV32 &&
+               cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
+               (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
+                                          riscv_has_ext(env, RVF))) {
+        set_misa_c = true;
+    } else if (riscv_cpu_mxl(env) == MXL_RV64 &&
+               cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
+        set_misa_c = true;
+    }
+
+    if (set_misa_c) {
+        if (cpu_misa_ext_is_user_set(RVC)) {
+            warn_report("RVC mandated by Zca/Zcf/Zcd extensions");
+            return;
+        }
+
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1157,6 +1195,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_update_misa_c(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.47.3


