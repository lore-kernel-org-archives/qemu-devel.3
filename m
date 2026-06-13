Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DFBCD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUbr-0000rg-EQ; Sat, 13 Jun 2026 16:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbm-0000mo-Cj; Sat, 13 Jun 2026 16:05:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbk-0000DE-AD; Sat, 13 Jun 2026 16:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381067; bh=ip2pqWDKYOwxi3LwiZS0HA5t1/dp131pu1KfGKKzz+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NIVNb1ViKjKtpjuIIgg04XzVPUqadOdXgCtTOAUBu9Qy/1df1n0dqDJK8XDcttGV3
 ztHvhtVth1i9YNYo8oy6RaRFXB4SFy9Nlf6NvXTMNlmshbH8mwHGzIE6iV2n/5AhyP
 t1h3QRk0VyO0XJJLkDfzt3exsewY5WpU8ZWjiGInIWeeK7ENVwwB/oMoQgLGHjbpeA
 vTrTO5AYrHkwSCxLY3/OiUIvFH3q3akT5Gw0GIYU07NnOFZdJ3lnTjgimgXrsIEsID
 KhgotmUzjce6IMpDiSka4f9iAlSWcJYV0OM0THQlm9bH+39+l7tUsanwh7PSOe7ofX
 heZes8gWxK/dQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B5B8B1B6E74;
 Sat, 13 Jun 2026 23:04:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1F7273CE8D7;
 Sat, 13 Jun 2026 23:04:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 13/61] target/riscv/csr.c: fix read of pmpaddr(0-63)
 CSRs
Date: Sat, 13 Jun 2026 23:02:56 +0300
Message-ID: <20260613200411.1808021-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The priv spec defines, for RV64, that the upper 10 bits of
pmpaddr0-pmpaddr63 are WARL and are supposed to be cleared.

After this patch, using the bug reproducer in [1], writing
ffffffffffffffff in pmpaddr0 and reading it back now results in
003fffffffffffff.  Here's the 'diff -cp' dump before and after
this change:

*************** IN:
*** 5272,5278 ****
   pmpcfg10 0000000000000000
   pmpcfg12 0000000000000000
   pmpcfg14 0000000000000000
!  pmpaddr0 ffffffffffffffff
   pmpaddr1 0000000000000000
   pmpaddr2 0000000000000000
   pmpaddr3 0000000000000000
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 53cc9747ed7c9b95ba084d614976dd48c9a57a97)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c360f77c92..9f81cd3960 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5328,6 +5328,23 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
     *val = pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
+
+    /*
+     * For RV64, bits 54-63 of the address registers
+     * PMPAADDR(0-63) is a WARL zero field (priv spec,
+     * section "Physical Memory Protection CSRs").
+     *
+     * We'll have to add an annoying TARGET_RISCV64 gate
+     * here to avoid complaints about masking bits 0-53
+     * of a potential 32 bit target_ulong '*var'.
+     */
+#ifdef TARGET_RISCV64
+    if (env->misa_mxl == MXL_RV64
+        && csrno >= CSR_PMPADDR0 && csrno <= CSR_PMPADDR63) {
+        target_ulong read_mask = MAKE_64BIT_MASK(0, 54);
+        *val &= read_mask;
+    }
+#endif
     return RISCV_EXCP_NONE;
 }
 
-- 
2.47.3


