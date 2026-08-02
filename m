Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573DEC55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 12:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqV8B-0007Kp-A9; Sun, 02 Aug 2026 08:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wqJdl-0006RU-VL; Sat, 01 Aug 2026 20:01:18 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wqJdi-0006vU-QP; Sat, 01 Aug 2026 20:01:17 -0400
Received: from DESKTOP-J3VFOUN.localdomain (unknown [62.217.189.53])
 by mail.ispras.ru (Postfix) with ESMTPSA id E682E406E9AC;
 Sun,  2 Aug 2026 00:01:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E682E406E9AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1785628870;
 bh=vunbb94ED8cx/ncK3P5gD8vDOmHoWA8kRt9ImI/RdEo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MVfLocwxbNP0GBFjr4fbeADlB96/dC90mOmIUnaIlvAhv72Z7aiV+9MUDkZLoHgFf
 cDYpKJjw23oAERnARLPnUFLadxwKniMNrNhU9a3x58bVvuXWutx+Wlbu6flHbwLWE8
 1eBOuvqV0l6xLB4s8inanfccnwQv4SCf3M0RnRMw=
From: Ivan Efremov <nendensu@ispras.ru>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 farosas@suse.de, lvivier@redhat.com, Ivan Efremov <nendensu@ispras.ru>
Subject: [PATCH 1/2] target/riscv: Fix seed CSR sign extension
Date: Sun,  2 Aug 2026 03:00:47 +0300
Message-ID: <20260802000048.691333-2-nendensu@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260802000048.691333-1-nendensu@ispras.ru>
References: <20260802000048.691333-1-nendensu@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=nendensu@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 02 Aug 2026 08:17:15 -0400
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

The SEED_OPST_* macros expanded to int expressions. When
bit 31 was present, converting a CSR seed value to target_ulong
on RV64 sign extended the value and incorrectly set the upper 32 bits.

Make the SEED_OPST_* constants unsigned so that CSR values are
zero extended on RV64.

Fixes: 77442380ecbe ("target/riscv: rvk: add CSR support for Zkr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4121
Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
---
 target/riscv/cpu_bits.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3f146a43fe..c01050ce2b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1086,11 +1086,11 @@ typedef enum CTRType {
     (HVICTL_VTI | HVICTL_IID | HVICTL_IPRIOM | HVICTL_IPRIO)
 
 /* seed CSR bits */
-#define SEED_OPST                        (0b11 << 30)
-#define SEED_OPST_BIST                   (0b00 << 30)
-#define SEED_OPST_WAIT                   (0b01 << 30)
-#define SEED_OPST_ES16                   (0b10 << 30)
-#define SEED_OPST_DEAD                   (0b11 << 30)
+#define SEED_OPST                        (0b11U << 30)
+#define SEED_OPST_BIST                   (0b00U << 30)
+#define SEED_OPST_WAIT                   (0b01U << 30)
+#define SEED_OPST_ES16                   (0b10U << 30)
+#define SEED_OPST_DEAD                   (0b11U << 30)
 /* PMU related bits */
 #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
 
-- 
2.43.0


