Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D82CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENqo-0000g3-IC; Thu, 30 Oct 2025 04:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vENqj-0000f6-BT
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vENqe-0003BA-QJ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx2tEWHwNpi4gcAA--.62467S3;
 Thu, 30 Oct 2025 16:17:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxicAVHwNpKnMcAQ--.9832S4;
 Thu, 30 Oct 2025 16:17:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] target/loongarch: Call function
 loongarch_la464_init_csr() after realized
Date: Thu, 30 Oct 2025 16:17:23 +0800
Message-Id: <20251030081724.3921563-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251030081724.3921563-1-maobibo@loongson.cn>
References: <20251030081724.3921563-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxicAVHwNpKnMcAQ--.9832S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When CPU is realized, it will check capability of host and set guest
features, such as PMU CSR register number used by VM etc. Here move
function call with loongarch_la464_init_csr() after CPU is realized.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e80a92fb2e..7daf290851 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -106,11 +106,11 @@ bool loongarch_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static void loongarch_la464_init_csr(Object *obj)
+static void loongarch_la464_init_csr(DeviceState *dev)
 {
 #ifndef CONFIG_USER_ONLY
     static bool initialized;
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPULoongArchState *env = &cpu->env;
     int i, num;
 
@@ -369,7 +369,6 @@ static void loongarch_la464_initfn(Object *obj)
 
     cpu->msgint = ON_OFF_AUTO_OFF;
     cpu->ptw = ON_OFF_AUTO_OFF;
-    loongarch_la464_init_csr(obj);
     loongarch_cpu_post_init(obj);
 }
 
@@ -524,6 +523,7 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
+    loongarch_la464_init_csr(dev);
 
     lacc->parent_realize(dev, errp);
 }
-- 
2.39.3


