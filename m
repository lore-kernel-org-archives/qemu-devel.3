Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2778CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNk1-0007SP-VS; Wed, 24 Jun 2026 09:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNk0-0007QC-9z; Wed, 24 Jun 2026 09:34:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNjy-0000Sg-OE; Wed, 24 Jun 2026 09:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307996; bh=Buh3wzvyJ5YPdIEyfbrsL/XcS/pQ3fOnyg/b6Lqqf10=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=duZUL1ywpnlujHQXzYK6YY/msfBSePxtgcDXaTifwOVDPF5EOHxcjtmF4p8KxRmw4
 qpJF28YW670bd7v+iBcaoSLpoceBNCxZnspuJqAy7dPFK5lXVxpEfuCDguP7VWCX9l
 smn4/11rp+LjxKBwyTEqeVEjUXCIGJ4nouCB10+1SuuDJ8UK+e2Rq1oN1jVEeyUE/R
 9McdkZWM+oTwFwLKeNC1e7LWk9cNLms3EcE+VAxceV636o/5Fs2BzcNy6+UjEpumv1
 zyhW/i6eARY5ml8mbksp9SB5HU4EI9NynEqsazHhdEJVyvCBX19p9L85TTVcN9ouce
 x9kcZ1MmGlrXg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 163981BA9BF;
 Wed, 24 Jun 2026 16:33:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A71423DEA0E;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 013/107] target/riscv/csr.c: fix read of pmpaddr(0-63)
 CSRs
Date: Wed, 24 Jun 2026 16:30:18 +0300
Message-ID: <20260624133301.403266-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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
index d65d176fe8..cf1fe6041c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5304,6 +5304,23 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
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


