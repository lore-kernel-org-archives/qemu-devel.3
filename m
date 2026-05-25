Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E552CCD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 09:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRRN4-00012t-BY; Mon, 25 May 2026 05:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wRRMz-00011D-7T
 for qemu-devel@nongnu.org; Mon, 25 May 2026 05:13:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wRRMw-0003Dr-9u
 for qemu-devel@nongnu.org; Mon, 25 May 2026 05:13:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxdnieEhRqpAYNAA--.12813S3;
 Mon, 25 May 2026 17:13:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxysGVEhRqXzuQAA--.8794S6;
 Mon, 25 May 2026 17:13:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 gaosong <gaosong@loongson.cn>
Subject: [PATCH v3 4/4] targe/loongarch: KVM disable msgint
Date: Mon, 25 May 2026 16:46:44 +0800
Message-Id: <20260525084645.3328690-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260525084645.3328690-1-gaosong@loongson.cn>
References: <20260525084645.3328690-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxysGVEhRqXzuQAA--.8794S6
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
---
 target/loongarch/cpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 64f437fcba..0e709661be 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -442,6 +442,9 @@ static void loongarch_max_initfn(Object *obj)
     loongarch_la464_initfn(obj);
 
     cpu->ptw = ON_OFF_AUTO_AUTO;
+    if (kvm_enabled()){
+        cpu->msgint=ON_OFF_AUTO_OFF;
+    }
     if (tcg_enabled()) {
         uint32_t data = cpu->env.cpucfg[2];
         data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
@@ -456,9 +459,9 @@ static void loongarch_max_initfn(Object *obj)
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


