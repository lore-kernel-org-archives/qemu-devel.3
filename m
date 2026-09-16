Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADBFC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kK6-00051v-KW; Wed, 16 Sep 2026 03:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kK5-00050G-Gq; Wed, 16 Sep 2026 03:44:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kK3-0004xv-Q4; Wed, 16 Sep 2026 03:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=29jSg7LzhQu5p2uJY1m4Yw2A+Blru/p0twf2rwRmIRA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Zh8bCC04Oua+3GLX5VKHo3l+EqrpNK8ABbXQAaZa77zyxKZUEce1fRYbID7uHh9a0
 1ejAMglodLMO7jurjKxHr2tbAkuCJ1V4tJ/yex13pty0RygyGLmzl2we0iA/e06n+d
 hP7+jkCC5hQJd8M4RazOmBy5rexcNGQbac4Z+gcHrUb/BUVJmIYt06vPV6tU85hFK5
 +ZfUj6HT1oRkJKDdslbMeiETAvOp9G6eyepIapCayab7+c48IL3dJ+Zs067sPPh6mM
 ef2QxN0HX4oZJRuRW4kmoSL80VPky5Iyu2lqNoz+kCNn6yHHm1gwwkukoRcoOr9Exk
 M0y55fU/oBGKg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 504B71D5598;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4822429B2D;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B3E775A6DB; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ivan Efremov <nendensu@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 13/49] target/riscv: Fix seed CSR sign extension
Date: Wed, 16 Sep 2026 10:42:31 +0300
Message-ID: <20260916074346.671467-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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

From: Ivan Efremov <nendensu@ispras.ru>

The SEED_OPST_* macros expanded to int expressions. When
bit 31 was present, converting a CSR seed value to target_ulong
on RV64 sign extended the value and incorrectly set the upper 32 bits.

Make the SEED_OPST_* constants unsigned so that CSR values are
zero extended on RV64.

Fixes: 77442380ecbe ("target/riscv: rvk: add CSR support for Zkr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4121
Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260802113130.7818-2-nendensu@ispras.ru>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 51362da8f73b13ad029287ee33e190a212894183)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c6178..2a9e03f18a2 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1023,11 +1023,11 @@ typedef enum CTRType {
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
2.47.3


