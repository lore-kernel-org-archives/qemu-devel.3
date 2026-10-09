Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A23CCA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wP-0004r2-O0; Thu, 08 Oct 2026 23:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0w3-0004jR-Hx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:16 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0w0-0005op-JN
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:13 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 018B8E005;
 Fri, 09 Oct 2026 08:35:59 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 22/23] target/loongarch: initialize CSR related to LVZ
Date: Fri,  9 Oct 2026 11:05:18 +0800
Message-ID: <f673294310fedf7e9a49f16df4b30755593425ac.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Initialize CSR.GSTAT.GIDBITS and GCSR.ASID.ASIDBITS at cpu init function.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8e759a2987..1522e64b9c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -334,7 +334,7 @@ static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys;
+    CPUSysState *sys, *guest;
     uint32_t data = 0, field;
     int i;
 
@@ -448,6 +448,9 @@ static void loongarch_la464_initfn(Object *obj)
 
     sys = env_sys(env);
     sys->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
+    sys->CSR_GSTAT = FIELD_DP64(0, CSR_GSTAT, GIDBITS, 8);
+    guest = get_sys(env, VM_LEVEL1);
+    guest->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 
     sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
     sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
-- 
2.55.0


