Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB671C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wozyI-0005ZO-2h; Wed, 29 Jul 2026 04:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wozyD-0005Z8-JN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:49:00 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wozyA-0000ue-N9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1785314404;
 bh=TxC4xOycr3Tt6NzMSAIfjxfQSMxTITeDl9K0WgJVtfw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fZgEwE+3I978TQS8WxECYFMmoOM83zRQL7X6MwHlKHq436pGWEj4euLYp7zcJQJVA
 OXoGKrNiVLDOKh+2pxuYKprp7RWeBdCQJU7V8rOTy4a+XJRvve+u+GqN1MGZd0ch0D
 XAbKU4tlgVi6yTh1cGugYgsg8BfPMIZC48KUHkQdIKyaYq6ZsDrtzgKoUq3kvSorpQ
 M4ypY1S8unnWJU8+feaTg7WxAn7P5J6EE/4EY0MYAbUoZ7vW+RyFZKfx+2mooBXK2P
 uqiBBh6aC2mKKZor6m2yKkHDV/kFoGXkat+038dRNaM02chIu7M3LNlyEAMnXQO3Xe
 j+s3REkAEgoqA==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 4FA5A40224;
 Wed, 29 Jul 2026 10:40:04 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 4921BFF855;
 Wed, 29 Jul 2026 10:40:04 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 24525400EE;
 Wed, 29 Jul 2026 10:40:04 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 2/2] target/riscv: Allow UXL to be 3 in mstatus on rv128
Date: Wed, 29 Jul 2026 10:39:41 +0200
Message-ID: <20260729083941.103646-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729083941.103646-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260729083941.103646-1-frederic.petrot@univ-grenoble-alpes.fr>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/tcg/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index d834b77714..5eeb9f0e0f 100644
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


