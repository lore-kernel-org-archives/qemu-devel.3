Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BBCC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuTdo-0001Rf-CF; Thu, 13 Aug 2026 07:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wuTdh-0001Pl-Id
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:30:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wuTdc-0004EV-7C
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:30:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx79LBqn1qwuMAAA--.2765S3;
 Thu, 13 Aug 2026 19:30:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxOs6+qn1q5lQDAA--.4396S5;
 Thu, 13 Aug 2026 19:30:10 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn,
 gaosong <gaosong@loongson.cn>
Subject: [PATCH v4 3/3] target/loongarch: KVM disable msgint
Date: Thu, 13 Aug 2026 19:10:00 +0800
Message-Id: <20260813111000.446232-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260813111000.446232-1-gaosong@loongson.cn>
References: <20260813111000.446232-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxOs6+qn1q5lQDAA--.4396S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: gaosong <gaosong@loongson.cn>

In KVM mode, msgint is disabled by default; please enable it manually.

e.g
   ... -cpu max,msgint=on ...

Signed-off-by: gaosong <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a241135227..84e609b5ed 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -449,6 +449,9 @@ static void loongarch_max_initfn(Object *obj)
     loongarch_la464_initfn(obj);
 
     cpu->ptw = ON_OFF_AUTO_AUTO;
+    if (kvm_enabled()){
+        cpu->msgint=ON_OFF_AUTO_OFF;
+    }
     if (tcg_enabled()) {
         uint32_t data = cpu->env.cpucfg[2];
         data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
@@ -463,9 +466,9 @@ static void loongarch_max_initfn(Object *obj)
         data = cpu->env.cpucfg[3];
         data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
         cpu->env.cpucfg[3] = data;
+	 cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
+        cpu->msgint = ON_OFF_AUTO_AUTO;
     }
-    cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
-    cpu->msgint = ON_OFF_AUTO_AUTO;
 }
 
 #if defined(CONFIG_KVM)
-- 
2.47.3


