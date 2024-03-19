Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86A9C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 02:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPBK-0003Sp-K2; Mon, 18 Mar 2024 22:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rmPBD-0003Qp-Jc
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:26:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rmPBA-0007py-C8
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:26:19 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXeu_9_hl9JYaAA--.63947S3;
 Tue, 19 Mar 2024 10:26:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTRO+9_hlGghdAA--.47716S2; 
 Tue, 19 Mar 2024 10:26:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/loongarch: Refine default numa id calculation
Date: Tue, 19 Mar 2024 10:26:06 +0800
Message-Id: <20240319022606.2994565-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTRO+9_hlGghdAA--.47716S2
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With numa_test test case, there is subcase named test_def_cpu_split(),
there are 8 sockets and 2 numa nodes. Here is command line:
"-machine smp.cpus=8,smp.sockets=8 -numa node,memdev=ram -numa node"

The required result is:
  node 0 cpus: 0 2 4 6
  node 1 cpus: 1 3 5 7
Test case numa_test fails on LoongArch, since the actual result is:
  node 0 cpus: 0 1 2 3
  node 1 cpus: 4 5 6 7

It will be better if all the cpus in one socket share the same numa
node. Here socket id is used to calculate numa id in function
virt_get_default_cpu_node_id().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index deb3750d81..29885f6777 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1219,15 +1219,14 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 
 static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    int64_t nidx = 0;
+    int64_t socket_id;
 
     if (ms->numa_state->num_nodes) {
-        nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
-        if (ms->numa_state->num_nodes <= nidx) {
-            nidx = ms->numa_state->num_nodes - 1;
-        }
+        socket_id = ms->possible_cpus->cpus[idx].props.socket_id;
+        return socket_id % ms->numa_state->num_nodes;
+    } else {
+        return 0;
     }
-    return nidx;
 }
 
 static void loongarch_class_init(ObjectClass *oc, void *data)
-- 
2.39.3


