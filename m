Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFAEC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 01:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9xYj-0003cR-7U; Wed, 22 May 2024 21:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9xYg-0003Bl-36; Wed, 22 May 2024 21:47:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1s9xYd-0001DO-TB; Wed, 22 May 2024 21:47:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx6+oCoE5mst8CAA--.6061S3;
 Thu, 23 May 2024 09:46:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMf9n05mSDMGAA--.17472S12; 
 Thu, 23 May 2024 09:46:42 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 10/10] hw/loongarch/virt: Fix FDT memory node address width
Date: Thu, 23 May 2024 09:46:37 +0800
Message-Id: <20240523014637.614872-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240523014637.614872-1-gaosong@loongson.cn>
References: <20240523014637.614872-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDMf9n05mSDMGAA--.17472S12
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Higher bits for memory nodes were omitted at qemu_fdt_setprop_cells.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240520-loongarch-fdt-memnode-v1-1-5ea9be93911e@flygoat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e3bdf085b5..3e6e93edf3 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -464,7 +464,8 @@ static void fdt_add_memory_node(MachineState *ms,
     char *nodename = g_strdup_printf("/memory@%" PRIx64, base);
 
     qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, 0, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", base >> 32, base,
+                           size >> 32, size);
     qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
 
     if (ms->numa_state && ms->numa_state->num_nodes) {
-- 
2.34.1


