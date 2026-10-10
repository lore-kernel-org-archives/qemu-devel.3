Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41A3CA9EC1
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFbBQ-00005D-49; Sat, 10 Oct 2026 13:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xFbB2-0008V1-5A; Sat, 10 Oct 2026 13:48:08 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xFbAz-00025a-4e; Sat, 10 Oct 2026 13:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
 Content-Description:In-Reply-To:References:X-Debbugs-Cc;
 bh=X/sV+QCHPh6WttKn04ZfRvNXuIvy+Kh7Y9N5OnH/H4o=; b=d8QdobJiXX1S1erIhwDFfz2CFS
 YGYANlSHWq8a54X94kw6jkvsVdzgDpGmtz0WipEPoDM/6eAcr/bqMi9kZR2d+09gTXluuo4ud/biE
 lfUJLbnfL2sUKphJrdZRkwLoyVfJnWVwkaQ6oX7O1XL1dYsEs+H7tp1alYfYwyAXysvErQwl7J8tQ
 pDwm8fuGuZy5WCJqlGFzytdbZeOCk+qNdVaeWBaStCkWPQFBDqo2l3kpoSP2RBCVjTGY+rVGMp+9n
 emiSGIIsiITC1VnhQ61J9DqVCL4rJLEspWt02N/VJrXnpYenfdywK768Ze73kJTAX+POPUloseJc6
 8U8ip1Gg==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xFbAm-0000000DYvr-1XuC;
 Sat, 10 Oct 2026 19:47:52 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG target),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical ops
Date: Sat, 10 Oct 2026 19:46:55 +0200
Message-ID: <20261010174742.3552498-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

For logical vector operations (in the case of the RISC-V backend that
corresponds to and_vec, or_vec and xor_vec), VECE is unused. However,
tcg_target_const_match() always treat it as an element size to extract
the corresponding constant element from the whole constant.

This causes the following aarch64 instruction
  bic v4.8h, #0xf0
to be translated into the following op:
  ...
  and_vec v128,e8,tmp5,tmp4,v128$0xff0fff0fff0fff0f
  ...
which is then translated to the following RISC-V instruction:
  vand.vi v1,v1,15

Fix that by, when VECE is 0 aka MO_8, only extracting the element if the
it can actually be represented as a duplicated constant.

Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 tcg/riscv64/tcg-target.c.inc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Changes v1 -> v2:
- Use dup_const() instead of open coding the constant duplication.

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 14a397117a..1262b71a62 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -392,8 +392,15 @@ static bool tcg_target_const_match(int64_t val, int ct,
         return 1;
     }
     if (type >= TCG_TYPE_V64) {
-        /* Val is replicated by VECE; extract the highest element. */
-        val >>= (-8 << vece) & 63;
+        /*
+         * For vector logical operations, VECE is unused and equals to 0, so
+         * we need to check that the constant can properly be represented after
+         * replication.
+         */
+        if ((vece != MO_8) || (val == dup_const(vece, val))) {
+            /* Val is replicated by VECE; extract the highest element. */
+            val >>= (-8 << vece) & 63;
+        }
     }
     /*
      * Sign extended from 12 bits: [-0x800, 0x7ff].
-- 
2.53.0


