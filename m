Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB0ECDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNjg-0007F4-0j; Wed, 24 Jun 2026 09:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNja-00078N-1s; Wed, 24 Jun 2026 09:33:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNjY-0000QH-Fm; Wed, 24 Jun 2026 09:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307995; bh=UQO7+vmvaDWY9veMsChhE+30MJhvcboOLnQu6QDtjGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sNXW24PqSvlJLpltQA4L2Nm910uBZzmtpje7FS6FxSjlyqcLhNUZh58oEnutHtOd1
 AcyJkqD7N3fQmlZRwMY7aQQk0BwXk8slxFY6uALxE0Isy6DTYOXFYf4oSV517vU6Rr
 3jTJvVUPw7GweOtFqXIh+hfG6a/PnDKw7qDRVoU0f6cGRN10acfZ4uMVA9jImct52o
 +NbHp9vpsvYmDR/yx7YF57ZNl3pP7WJTVeubk0GjjmDDcqdzVf+6wo+djZVy2EaMB9
 D4rN1vUIQIerIm7SsRAmNUosw6TasCuDUY4aWi5Wxmap68Mn4ybz6OG7CdGKSOp4eD
 OqGPOzbQPD7yw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE0A01BA9BB;
 Wed, 24 Jun 2026 16:33:15 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B3863DEA0A;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 009/107] target/riscv/pmp: Fix integer overflow in TOR
 and NA4 address computation
Date: Wed, 24 Jun 2026 16:30:14 +0300
Message-ID: <20260624133301.403266-9-mjt@tls.msk.ru>
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

From: Zishun Yi <vulab@iscas.ac.cn>

According to the RISC-V Privileged Manual: "The Sv32 page-based
virtual-memory scheme described in sv32 supports 34-bit physical
addresses for RV32, so the PMP scheme must support addresses wider than
XLEN for RV32."

However, the current QEMU implementation uses `target_ulong` (which
resolves to `uint32_t` on RV32) for PMP address variables.  When
shifting these addresses left (e.g., `this_addr << 2`), an integer
overflow occurs, truncating the high bits of the 34-bit physical
address.

Fix this issue by changing the types of PMP address variables
(`this_addr` and `prev_addr`) to `hwaddr`.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2472/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260511102627.3120140-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 612f22c19db8adbe9b155f199ede01e86cc1546c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5391caa59c..a71091a316 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -227,8 +227,8 @@ static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
 {
     uint8_t this_cfg = env->pmp_state.pmp[pmp_index].cfg_reg;
-    target_ulong this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
-    target_ulong prev_addr = 0u;
+    hwaddr this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
+    hwaddr prev_addr = 0u;
     hwaddr sa = 0u;
     hwaddr ea = 0u;
     int g = pmp_get_granularity_g(env);
-- 
2.47.3


