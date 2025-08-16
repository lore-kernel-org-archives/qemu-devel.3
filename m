Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6845FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Aug 2025 08:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unCk9-0004UK-IY; Sat, 16 Aug 2025 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1unCk7-0004U0-WD; Sat, 16 Aug 2025 04:58:28 -0400
Received: from mail-m16.yeah.net ([1.95.21.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1unCk1-0003lc-CA; Sat, 16 Aug 2025 04:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sa
 QC+BB9xw1BdHerigzJ67clSJNT1OTLlTNrRef9RWw=; b=FWQoroKNV1fkBp8K5o
 xz5K+gr3VaoNfVFjkz/56agn+Zk6IO083jKcvkMNLU54bN4hmvAKLfPDOR/2cQkS
 QRsV/mHORHvUwf5WWGreS9C/mfeDh/XC7HKx7FzhZeQ7MVlPiYMc56ZwSuQIeCYZ
 biqmtL30dStm9H2i6Qforqb5k=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgC37_f_R6BoEUXBAg--.43192S2;
 Sat, 16 Aug 2025 16:57:38 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: richard.henderson@linaro.org, paolo.savini@embecosm.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v4 0/2] target/riscv: Generate strided vector ld/st with tcg
Date: Sat, 16 Aug 2025 16:56:34 +0800
Message-ID: <cover.1755333616.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.48.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgC37_f_R6BoEUXBAg--.43192S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF1UZF43ZF4fWrW5CFWfXwb_yoW8JF1Upa
 15Krya9r4xXa9rXF4fGr4xCr90qw4fu3W5AF1xJw1rurW5tr9rtFn2gw4UKF13GFyxur1a
 v3WayFs5uF1ava7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOcTQUUUUU=
X-Originating-IP: [114.88.98.193]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiNgJUfGigSAJOvwAA3v
Received-SPF: pass client-ip=1.95.21.14; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

Thanks Richard for the review.

For patch v4, the main modification is to improve the implementation of the
get_log2() function.

+static inline uint32_t get_log2(uint32_t a)
+{
-    uint32_t i = 0;
-    if (a == 0) {
-        return i;
-    }
-    for (; a > 1;) {
-        a >>= 1;
-        i++;
-    } 
+    assert(is_power_of_2(a));
+    return ctz32(a);
+}

patch v3 changes:
- Fix the get_log2() function:
  https://lore.kernel.org/qemu-riscv/cover.1755287531.git.chao.liu@yeah.net/T/#t
- Add test for vlsseg8e32 instruction.
- Rebase on top of the latest master.

patch v2 changes:
- Split the TCG node emulation of the complex strided load/store operation into
  two separate functions to simplify the implementation:
  https://lore.kernel.org/qemu-riscv/20250312155547.289642-1-paolo.savini@embecosm.com/


Best regards,

Chao

Chao Liu (2):
  Generate strided vector loads/stores with tcg nodes.
  tests/tcg/riscv64: Add test for vlsseg8e32 instruction

 target/riscv/insn_trans/trans_rvv.c.inc   | 319 ++++++++++++++++++----
 tests/tcg/riscv64/Makefile.softmmu-target |   8 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 107 ++++++++
 3 files changed, 382 insertions(+), 52 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

-- 
2.50.1


