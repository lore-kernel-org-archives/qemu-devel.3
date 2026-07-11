Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2FFC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifmm-0007FP-Rk; Sat, 11 Jul 2026 18:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflz-0006xB-Qe; Sat, 11 Jul 2026 18:02:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifly-0008Qi-5F; Sat, 11 Jul 2026 18:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=wSNU6e7WpFXFiBVayG3OBCpB8wb0GuSFcimKi/wmiyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O3ldSQ5d9qx+lun8d2JBW5MAnSVZVmJuJQlt+w3sb5K3yOdyeXrNscWrazTH6Mf+W
 3JGrksTHw9cmqF7tbNfxcF0lC30ZrxMBo6I6ILbmpIf8ReI1HxGh4+YwpFvbbmycjP
 C6qA5px3ucQ39lsQ/Bnpnv/ZzSqzq6P59M43jf5HLY5RJGLuy18eluouduAE/ek8vs
 S27t1sPq/v4ATf2gLrYS/gFkwCH4m/B0Q7ceWok82W82EGhxl2YhYLY3POPI3kErMb
 Rx11NiCs34lVzToZtXrFZ4so12mw44DiA17t0goA7JHVy+Ke1YBIBtTBbDAEKsz1ck
 hWXjPcZMu652w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C32CD1C0AA9;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7ABC93EAF34;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7DE8A1331F; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, SeungJu Cheon <suunj1331@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 30/81] target/riscv: Apply UXL WARL handling to
 vsstatus
Date: Sun, 12 Jul 2026 00:58:08 +0300
Message-ID: <20260711215904.3757-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: SeungJu Cheon <suunj1331@gmail.com>

write_mstatus() already handles the reserved UXL value by writing a
legal value instead.

Apply the same handling when writing vsstatus so that reserved UXL
values follow the same WARL behavior.

Factor the common logic into a local helper riscv_write_uxl() and use
it for both mstatus and vsstatus.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Fixes: f310df58bd2 ("target/riscv: Enable uxl field write")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260625081521.595683-1-suunj1331@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit dcd028517749835a618bb1fe8dca32d82318e1c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c8f510709ae..24c1f94ced0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1991,6 +1991,20 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
     return val;
 }
 
+static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
+                                uint64_t field)
+{
+    RISCVMXL xl = riscv_cpu_mxl(env);
+    uint64_t uxl = get_field(val, field);
+
+    if (uxl == MXL_RV128) {
+        uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
+        val = set_field(val, field, uxl);
+    }
+
+    return val;
+}
+
 static RISCVException write_mstatus(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
@@ -2037,17 +2051,8 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     if (xl != MXL_RV32 || env->debugger) {
         if ((val & MSTATUS64_UXL) != 0) {
-            uint64_t uxl = val & MSTATUS64_UXL >> 32;
             mask |= MSTATUS64_UXL;
-
-            /*
-             * uxl = 3 is reserved so write the current xl instead.
-             * In case xl = MXL_RV128 (3) write MXL_RV64.
-             */
-            if (uxl == 3) {
-                uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
-                val = deposit64(val, 32, 2, uxl);
-            }
+            val = riscv_write_uxl(env, val, MSTATUS64_UXL);
         }
     }
 
@@ -5155,6 +5160,8 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     uint64_t mask = (target_ulong)-1;
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
+    } else {
+        val = riscv_write_uxl(env, val, VSSTATUS64_UXL);
     }
     if ((env->henvcfg & HENVCFG_DTE)) {
         if ((val & SSTATUS_SDT) != 0) {
-- 
2.47.3


