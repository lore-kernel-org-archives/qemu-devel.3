Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6698FCF31B7
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 12:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhMu-00005s-Jx; Wed, 19 Nov 2025 07:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhMs-00005R-LJ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:33:02 -0500
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhMr-0005AM-1v
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:33:02 -0500
Received: from cslab-raptor.s.cslab.moe (unknown [166.111.238.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 49EE3476B63;
 Wed, 19 Nov 2025 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1763555579; bh=1PjjDl+97+7Fik6eCHC+tM9FqOHhRwHdvGo6X15ILME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j5H2j0md/YgKUS6mU8eFSdfjH+O3kNsCDMC76yOj1mLuyPVP0hM7tV8FB1hgqhaxW
 FnahCAZxD+f1Xf51e9BUyeDqGES1S7MvgOYSNe8bkft+/bJhwwmxw9wywPGCHkgQuq
 EpLenT8OBzTo/+dJPBkCs6gKbM6oMRcZvdND9PKI=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v2 7/7] target/loongarch: Add LA v1.1 instructions to max cpu
Date: Wed, 19 Nov 2025 20:30:58 +0800
Message-ID: <20251119123101.1542976-7-c@jia.je>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119123101.1542976-4-c@jia.je>
References: <20251119122822.1513788-1-c@jia.je>
 <20251119123101.1542976-4-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add LA v1.1 new instructinos to max cpu by enabling new features in
CPUCFG2.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d74c3c3766..2c357f9342 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -413,7 +413,16 @@ static void loongarch_max_initfn(Object *obj)
     if (tcg_enabled()) {
         cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
         cpu->msgint = ON_OFF_AUTO_AUTO;
-        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, 1);
+
+        uint32_t data = cpu->env.cpucfg[2];
+        data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
+        /* Enable LA v1.1 instructions */
+        data = FIELD_DP32(data, CPUCFG2, FRECIPE, 1);
+        data = FIELD_DP32(data, CPUCFG2, LAM_BH, 1);
+        data = FIELD_DP32(data, CPUCFG2, LAMCAS, 1);
+        data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
+        data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
+        cpu->env.cpucfg[2] = data;
     }
 }
 
-- 
2.51.0


