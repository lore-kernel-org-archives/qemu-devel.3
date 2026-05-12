Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85C0CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 05:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMfa8-0005Uw-Dn; Tue, 12 May 2026 01:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMfa5-0005UI-LT; Tue, 12 May 2026 01:22:57 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMfa2-0001qF-Lx; Tue, 12 May 2026 01:22:57 -0400
Received: from yzs (unknown [122.231.43.248])
 by APP-05 (Coremail) with SMTP id zQCowABH2AsiuQJqmuwHEA--.34775S2;
 Tue, 12 May 2026 13:22:43 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH v1] target/riscv: clear mseccfg on reset for all dependent
 extensions
Date: Tue, 12 May 2026 13:22:40 +0800
Message-ID: <20260512052240.330815-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABH2AsiuQJqmuwHEA--.34775S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7Zr4UKry8XFy7CF4UArb_yoW8XF4Upr
 s3Way3KrWDAas7A39rAF18WF1Yg3sYgr45Ka9I9rykJF43CrWfKF1DK3429F9ruF40qrWa
 9rWjyFyava1vyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
 6r43MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
 ZEXa7VUb66wtUUUUU==
X-Originating-IP: [122.231.43.248]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoFA2oCr6AbmwAAss
Received-SPF: pass client-ip=159.226.251.25; envelope-from=vulab@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, the `mseccfg` CSR is only cleared to 0 during reset if the
`ext_smepmp` is enabled. However, this register is now shared by
several other extensions such as `zkr`, `smmpm`, and `zicfilp`.

Fix by clearing `mseccfg` if any dependent extension is present, and
adjusting the relevant comments.

This vulnerability was discovered and reported by SpecHunter, an
AI-driven architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-svvptc/pr-134/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
 target/riscv/cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37de..3cabfeb1fa7a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -756,10 +756,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
     /*
      * Clear mseccfg and unlock all the PMP entries upon reset.
-     * This is allowed as per the priv and smepmp specifications
-     * and is needed to clear stale entries across reboots.
+     * This is required as per the priv, smepmp, and other security
+     * extension specifications that share this CSR, and is needed
+     * to clear stale entries across reboots.
      */
-    if (riscv_cpu_cfg(env)->ext_smepmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp ||
+        riscv_cpu_cfg(env)->ext_zkr ||
+        riscv_cpu_cfg(env)->ext_smmpm ||
+        riscv_cpu_cfg(env)->ext_zicfilp) {
         env->mseccfg = 0;
     }
 
-- 
2.51.2


