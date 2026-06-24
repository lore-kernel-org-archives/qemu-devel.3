Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5415CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFrv-0004wD-5p; Wed, 24 Jun 2026 01:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFrG-0003lJ-Ql; Wed, 24 Jun 2026 01:09:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFrB-0005vh-M9; Wed, 24 Jun 2026 01:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277623; bh=7BqlqLaaist4BkgHD8Dt8zxx7+xT78UnpZkTDT0CL4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K4r8BqAcv/Yyi/Z9zq/4+ddrmGKfEV3QjAO9U1LnfPWhU+UKCTkv976q2d5pq9GRO
 x2vZwK/QE5HOBMFBRCM9+BZhPGiDE59sSQjZ7OxdANg8dz+TPZGKZ0DSyAHn7ujLzt
 z8s9vPM0DUx3FWTba2n5axVW/XPnMvcnf7YKBhRn+ub88+ByPOEeX+ZCqOOkTObgc/
 t7rjdMELtOzdf/SnxhaF5cDq/BDxqVazvorsROmhhQf5ZbYXDAL+1wwVcjh1O1GmEi
 mEQuy3oZ36f8l02oOeHP6Mj+F2wrK+EWNzrC2rvYadZCs4Iq7eXAhbHF9XpT5dKmwt
 7zJUB4ZT5pscw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5DC201BA66F;
 Wed, 24 Jun 2026 08:07:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 48E393DDB0C;
 Wed, 24 Jun 2026 08:07:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 81/95] disas/riscv.c: fix inst_length()
Date: Wed, 24 Jun 2026 08:05:16 +0300
Message-ID: <20260624050541.395079-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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

inst_length() can return 0 if 'inst' happens to not match any known
encoding (like [1]).  Returning 0 is not desirable, even for unknown
encodings, given that it will cause a loop in target_disas() later on.

The most recent version of the RISC-V unpriv spec ditched the
sophisticated instruction-length encoding.  We're now supporting only
16-bit and 32-bit length instructions, where:

"All the 32-bit instructions in the base ISA have their lowest two bits
set to 11.  The optional compressed 16-bit instruction-set extensions
have their lowest two bits equal to 00, 01, or 10."

So the code is now simpler, never returning 0, and in fact it's the same
thing we're already doing in insn_len() from target/riscv/internals.h.
Due to include shenarigans we can't use that function in disas/riscv.c,
but I believe we can cut ourselves some slack this time and not lose
sleep over a 1 line of duplicated logic.  We're documenting it though!

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3479

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3479
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260527200355.2068879-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 758dce9c98af4f3ef26eada48a484a7d60258636)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index 980da7f7e1..2d8add3212 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5083,26 +5083,10 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
     return true;
 }
 
-/* instruction length */
-
+/* Same as insn_len() from target/riscv/internals.h */
 static size_t inst_length(rv_inst inst)
 {
-    /* NOTE: supports maximum instruction size of 64-bits */
-
-    /*
-     * instruction length coding
-     *
-     *      aa - 16 bit aa != 11
-     *   bbb11 - 32 bit bbb != 111
-     *  011111 - 48 bit
-     * 0111111 - 64 bit
-     */
-
-    return (inst &      0b11) != 0b11      ? 2
-         : (inst &   0b11100) != 0b11100   ? 4
-         : (inst &  0b111111) == 0b011111  ? 6
-         : (inst & 0b1111111) == 0b0111111 ? 8
-         : 0;
+    return (inst & 3) == 3 ? 4 : 2;
 }
 
 /* format instruction */
-- 
2.47.3


