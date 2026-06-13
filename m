Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94737CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV67-0001hj-Oe; Sat, 13 Jun 2026 16:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5y-0001ZD-51; Sat, 13 Jun 2026 16:36:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5w-0003EG-HU; Sat, 13 Jun 2026 16:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382962; bh=x8Obbye/RcP9958V3Ik52SIuaNnuyPM0y+vpzi01500=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wDYJxDKnLO1greEOexlb7aofV+2nFEtCWO7GGfBJV8xQynHW+4t3Gz0Z3IzGR7X2r
 bY0wfJlkIhpBAVnjrXCHV4iCh3+kv7imF71Cs94k9/vKhb1t9TmrMosvZffI0mR5pf
 aC/wfUy3GN7Yx3O9ObLchr07zzd0iN2kRsGR5RmhjBqyoRORw2sx/i1WIp6+R7/K+C
 swwUyJJbCzzE9IhGxFJp1wY5nXkVBhqbKgctKU21zBeTHOY8pLMLnU1wC6RchkWSKQ
 3KDyEe3XK294iyH9ODmRVmIw2WZsmpUxEWWkm+O9sqDMWJeFXfTJcKvPBHbTyKPdy4
 Agx/KL7ccz4Kw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DD9261B6EE2;
 Sat, 13 Jun 2026 23:36:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50F613CE934;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Abhigyan Kumar <314abh@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 08/72] target/riscv: Fix medeleg[11] read-only zero
 bit for M-mode ECALL
Date: Sat, 13 Jun 2026 23:34:34 +0300
Message-ID: <20260613203542.1809153-8-mjt@tls.msk.ru>
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

From: Abhigyan Kumar <314abh@gmail.com>

RISC-V Privileged Specification 3.1.8 (Machine Trap Delegation Registers
(medeleg and mideleg)) mentions:

"For exceptions that cannot occur in less privileged modes, the
corresponding medeleg bits should be read-only zero. In particular,
medeleg[11] is read-only zero."

QEMU incorrectly included RISCV_EXCP_M_ECALL in DELEGABLE_EXCPS. It
allowed the 11th bit to be written and read as set. Fixed by removing it
from the DELEGABLE_EXCPS mask, adhering to the specification.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3438
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260427060849.749179-2-314abh@gmail.com>
[ Changes by AF:
 - Remove comment
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit a0946caf1d9ec21446ebdcb5eab2400baa4323ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 51e668b46d..35e98df420 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1789,7 +1789,6 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_U_ECALL)) | \
                          (1ULL << (RISCV_EXCP_S_ECALL)) | \
                          (1ULL << (RISCV_EXCP_VS_ECALL)) | \
-                         (1ULL << (RISCV_EXCP_M_ECALL)) | \
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
-- 
2.47.3


