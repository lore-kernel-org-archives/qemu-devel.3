Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A3606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=JKBHKKNM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqs3-0000mq-Rt; Thu, 22 Oct 2026 07:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJqrp-0000kb-Rg; Thu, 22 Oct 2026 07:21:54 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJqrn-0004aK-Dl; Thu, 22 Oct 2026 07:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1792668108;
 bh=r0ljT3KfLB7UteheOjwLx31e7B6hdcVnVwWZ82e3C1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JKBHKKNMtJnEvXTiIiNEwDOTxy2FbFpx+TRHq0ahyVIQwFIi2xpU2iZyjoBOo2rhZ
 WPNZDzF8+phSBI9jdqUxSN9rWSjRs+/WAUiVK7xB/DE0W9EMHEridGd59JKt3QuINt
 qYjaMeSSvMMbHgGKr+77COrgxXJVYBG9I8+ngPVHoeZB1ou6PIjiQOUK1dUFyt34zQ
 wObkCz3QGMfkCBZfACvpFw0IU4elHNLATOHQ6416CgL+NxGfIEpFzRDwKvYxbOTSsB
 5gnc92qntvL4qx/fC4N6Wiy0VwJHnzqvkQ4+xmOKIDCZ/qStcwJEBAO1TJqSYvvnz1
 g010ZjpsvflCw==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id C05DD4025A;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id BC417FF855;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 8F095140049;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 2/2] target/riscv: fix riscv_cpu_do_interrupt sanitize
 error for x-rv128
Date: Thu, 22 Oct 2026 13:21:45 +0200
Message-ID: <20261022112145.356726-3-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022112145.356726-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20261022112145.356726-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

UndefinedBehaviorSanitizer reports an undefined behavior when setting
the Interrupt flag (msb) in the [ms]cause registers due to an out of
bounds shift.
We specifically correct these cases, leaving the ones depending on
specific extensions untouched.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/cpu.h            |  2 ++
 target/riscv/tcg/cpu_helper.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d631994..17bfcf38c0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -354,10 +354,12 @@ struct CPUArchState {
     uint64_t stvec;
     uint64_t sepc;
     uint64_t scause;
+    uint64_t scauseh;
 
     uint64_t mtvec;
     uint64_t mepc;
     uint64_t mcause;
+    uint64_t mcauseh;
     uint64_t mtval;  /* since: priv-1.10.0 */
 
     uint64_t mctrctl;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c..b35b61dc01 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2375,7 +2375,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
         env->mstatus = s;
         sxlen = 16 << riscv_cpu_sxl(env);
-        env->scause = cause | ((target_ulong)async << (sxlen - 1));
+        if (riscv_cpu_sxl(env) != MXL_RV128) {
+            env->scause = cause | ((target_ulong)async << (sxlen - 1));
+        } else {
+            env->scause = cause;
+            env->scauseh = (target_ulong)async << 63;
+        }
         env->sepc = env->pc;
         env->stval = tval;
         env->htval = htval;
@@ -2447,7 +2452,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             s = set_field(s, MSTATUS_MDT, 1);
         }
         env->mstatus = s;
-        env->mcause = cause | ((target_ulong)async << (mxlen - 1));
+        if (riscv_cpu_mxl(env) != MXL_RV128) {
+            env->mcause = cause | ((target_ulong)async << (mxlen - 1));
+        } else {
+            env->mcause = cause;
+            env->mcauseh = (target_ulong)async << 63;
+        }
         if (smode_double_trap) {
             env->mtval2 = env->mcause;
             env->mcause = RISCV_EXCP_DOUBLE_TRAP;
-- 
2.43.0


