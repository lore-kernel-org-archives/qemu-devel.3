Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13A5C25B5C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 03:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4BpZ-0004hz-6B; Mon, 06 May 2024 23:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s4BpT-0004h9-Na
 for qemu-devel@nongnu.org; Mon, 06 May 2024 23:49:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s4BpP-0003Oy-Qg
 for qemu-devel@nongnu.org; Mon, 06 May 2024 23:49:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxN+m0pDlmoqkIAA--.11354S3;
 Tue, 07 May 2024 11:49:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrlexpDlmi4sTAA--.33863S7; 
 Tue, 07 May 2024 11:49:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] hw/loongarch: Remove minimum and default memory size
Date: Tue,  7 May 2024 11:49:03 +0800
Message-Id: <20240507034904.2391129-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240507034904.2391129-1-maobibo@loongson.cn>
References: <20240507034904.2391129-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrlexpDlmi4sTAA--.33863S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Some qtest test cases such as numa use default memory size of generic
machine class, which is 128M by fault.

Here generic default memory size is used, and also remove minimum memory
size which is 1G originally.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 5abfe0a9d7..36477172ea 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -986,10 +986,6 @@ static void loongarch_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    if (ram_size < 1 * GiB) {
-        error_report("ram_size must be greater than 1G.");
-        exit(1);
-    }
     create_fdt(lams);
 
     /* Create IOCSR space */
@@ -1284,7 +1280,6 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Loongson-3A5000 LS7A1000 machine";
     mc->init = loongarch_init;
-    mc->default_ram_size = 1 * GiB;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
     mc->default_ram_id = "loongarch.ram";
     mc->max_cpus = LOONGARCH_MAX_CPUS;
-- 
2.39.3


