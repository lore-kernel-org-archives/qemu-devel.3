Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82AEC369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22zd-0006a6-An; Tue, 08 Apr 2025 03:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u22zb-0006ZW-NO
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:03:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u22zY-0007eO-Tq
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:03:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxlmk1yvRncve0AA--.38828S3;
 Tue, 08 Apr 2025 15:03:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMDxPcUwyvRnUlV0AA--.18375S3;
 Tue, 08 Apr 2025 15:03:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.comD, Bibo Mao <maobibo@loongson.cn>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/2] hw/loongarch/virt: Fix cpuslot::cpu set at last in
 virt_cpu_plug()
Date: Tue,  8 Apr 2025 14:41:21 +0800
Message-Id: <20250408064122.1917691-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250408064122.1917691-1-gaosong@loongson.cn>
References: <20250408064122.1917691-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcUwyvRnUlV0AA--.18375S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

In function virt_cpu_plug(), Object cpuslot::cpu is set at last
only when there is no any error, otherwise it is problematic that
cpuslot::cpu is set in advance however it returns because of error.

Fixes: ab9935d2991e (hw/loongarch/virt: Implement cpu plug interface)
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20250324030145.3037408-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e25864214f..504f8755a0 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -973,8 +973,6 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
     Error *err = NULL;
 
-    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
-    cpu_slot->cpu = CPU(dev);
     if (lvms->ipi) {
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
         if (err) {
@@ -998,6 +996,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
         }
     }
 
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot->cpu = CPU(dev);
     return;
 }
 
-- 
2.34.1


