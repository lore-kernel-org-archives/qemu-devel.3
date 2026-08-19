Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE91C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwdyb-0004Fv-L2; Wed, 19 Aug 2026 06:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wwdyZ-0004E6-3w; Wed, 19 Aug 2026 06:56:55 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wwdyX-0006At-7c; Wed, 19 Aug 2026 06:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1787137010;
 bh=4BjLY7BDlefHvhOKTtEg8Dg2WIfdTVac0sQmGr/EkmU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=29gCzqB7zIJk+8MeTeJzKbg7my6PU1dFOZX5SsGLiMuloHpuz1nelTGvqxDbK8gx9
 9JrBdSTF/SukizR/PisgcPztmRtgCDdILFv+Yrn9UT0MO1v6la53zW72x+iKV9gU9l
 BKJkv8o0yqCgxqO/yBu8i0+SPHIz2sKB8IRoJ7iTdzX4SxZdGsaBazSn931u0capkp
 GfP+9ZIVhdENlbnRsHDfYeLlZELd5vTMgVUPbXDs8f9TJerJfTW6PESw5yaLf6sxbB
 Ocpmilh1axKqdFIKH454V/ob1emwN4qegBU2l310SWn/Tv5BDUcGrNHhx3kzwiZ8TF
 e+51fhmfTIA9Q==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id B0D5840242;
 Wed, 19 Aug 2026 12:56:50 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id ACB26FF85F;
 Wed, 19 Aug 2026 12:56:50 +0200 (CEST)
Received: from naga.. (unknown [78.241.162.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 0D4C240120;
 Wed, 19 Aug 2026 12:56:49 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 2/2] target/riscv: Allow UXL to be 3 in mstatus on rv128
Date: Wed, 19 Aug 2026 12:56:55 +0200
Message-ID: <20260819105655.33391-3-frederic.petrot@univ-grenoble-alpes.fr>
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

Valid UXL field values for mstatus were restricted to fix a
reported issue, but this inadvertently broke the experimental
rv128 support where a value of 3 validly represents 128-bit
execution.

Update the mstatus write logic to permit UXL=3 when running on
an rv128 CPU.

Fixes: dcd028517749 ("target/riscv: Apply UXL WARL handling to vsstatus")
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 9cc6297328..4c8959a33d 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2014,8 +2014,8 @@ static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
     RISCVMXL xl = riscv_cpu_mxl(env);
     uint64_t uxl = get_field(val, field);
 
-    if (uxl == MXL_RV128) {
-        uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
+    if (xl != MXL_RV128 && uxl == MXL_RV128) {
+        uxl = xl;
         val = set_field(val, field, uxl);
     }
 
-- 
2.43.0


