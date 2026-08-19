Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4033DC5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwdyb-0004Fi-7n; Wed, 19 Aug 2026 06:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wwdyY-0004Dx-UA; Wed, 19 Aug 2026 06:56:54 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wwdyX-0006Ac-2l; Wed, 19 Aug 2026 06:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1787137009;
 bh=ayQmIvU7cHcv/trY1+acLz25t+8+pkLS16tDWnuaY1k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lh1X6JE3FOSgfLrJ8EagJalzKkgxO2llXLIgb3cnsIIrQh1Q/6GfRfSKgORd2HsPK
 SVlQMahSr6M1zlcdUaWRu5ayeIqtqxQITh+3uj38lKacqc+TUVX/quNEjHuDp8m6BR
 43k5cL+YTdElTD91Fw4w2VgcY2kYrsVRVaufXK4kS1UaBfj7IrQ8qlhfttiz82ABxC
 Cj8tfIS5UpkxHg6PhToTB575GhFk8uMGnow3HQuPQ9+1ZbYZwRtQ4z5+7w+OIMRL+k
 l8t8IRXjs7s0eoqWnvOehjfi9f3oh14TK6M/xdd2p8mi/mSyltUCe4gbr+0wphihie
 V+1oji0CiS1nQ==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id EAE4140241;
 Wed, 19 Aug 2026 12:56:49 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id E6D7DFF85F;
 Wed, 19 Aug 2026 12:56:49 +0200 (CEST)
Received: from naga.. (unknown [78.241.162.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 3A80340120;
 Wed, 19 Aug 2026 12:56:49 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 1/2] target/riscv: Fix sstatus update in rv128
Date: Wed, 19 Aug 2026 12:56:54 +0200
Message-ID: <20260819105655.33391-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

The sstatus register assignment was performed before the write
mask was fully constructed, leading to an incomplete update of
sstatus fields on the experimental rv128 target.

Move the sstatus write after the mask completion so the full
write mask is applied correctly.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index ffd751caa5..9cc6297328 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3998,7 +3998,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
                                         Int128 *val)
 {
     uint64_t mask = sstatus_v1_10_mask;
-    uint64_t sstatus = env->mstatus & mask;
+    uint64_t sstatus;
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
@@ -4009,7 +4009,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
     if (env_archcpu(env)->cfg.ext_zicfilp) {
         mask |= SSTATUS_SPELP;
     }
-
+    sstatus = env->mstatus & mask;
     *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
     return RISCV_EXCP_NONE;
 }
-- 
2.43.0


