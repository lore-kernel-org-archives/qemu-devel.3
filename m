Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4662CD98DC
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUOR-0000gR-9V; Sat, 13 Jun 2026 15:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOE-0000fe-6w; Sat, 13 Jun 2026 15:51:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOB-0003Kp-Bh; Sat, 13 Jun 2026 15:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380257; bh=D/ECPOIbeMuZELutml99RgtJz9N+zxsI2HnC8cHrciQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U7nlKII4SsV7o7zodTHuLUPR/4y1IGJGOkVtKhNUjKN8mDXcsoT5YDgahEP8F3Sru
 waHz5E39Ch3ow+pduK1f3sOzPEcL4znOQZt8sWTlmNxe96vYyZTjx3Fln8boEyCf+3
 I+1a7YCAUiznNmlsHOCC+eVFugrfDPwHXRaEDju0nIbwB4DDObmjDP64z56jI82LAu
 ED3i1MdqpJsW2UG8hpzWJfQCTQtz+e/aukmUW15GfAeP8qdL7+OpOkNX06tclO7FGL
 Emxe5y5TqallgLv8lQZS4jqXSJ4JdALCjK0EQnPs4I787JslCAFhg8ond3KiU3KhlF
 Jl38qfrupWHwg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E42AC1B6E10;
 Sat, 13 Jun 2026 22:50:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 47ECC3CE88A;
 Sat, 13 Jun 2026 22:51:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 01/56] target/riscv: Update MISA.C for Zc* extensions
Date: Sat, 13 Jun 2026 22:50:15 +0300
Message-ID: <20260613195116.1807273-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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
index 863aebec45..d8d82e69dc 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -972,6 +972,44 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
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
@@ -979,6 +1017,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_update_misa_c(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.47.3


