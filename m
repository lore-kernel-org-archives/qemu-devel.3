Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38117CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNqo-0000yj-Ga; Mon, 11 May 2026 06:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMNqS-0000xi-Jh; Mon, 11 May 2026 06:26:41 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMNqP-0008WD-IJ; Mon, 11 May 2026 06:26:40 -0400
Received: from yzs (unknown [183.156.89.125])
 by APP-05 (Coremail) with SMTP id zQCowAB3CAzVrgFqGvr0Dw--.25414S2;
 Mon, 11 May 2026 18:26:30 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH v2] target/riscv/pmp: Fix integer overflow in TOR and NA4
 address computation
Date: Mon, 11 May 2026 18:26:27 +0800
Message-ID: <20260511102627.3120140-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <7dc52ffd-97e3-4c41-8cde-e79dd4bd2485@oss.qualcomm.com>
References: <7dc52ffd-97e3-4c41-8cde-e79dd4bd2485@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAB3CAzVrgFqGvr0Dw--.25414S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45GF43WryrurWDAF17trb_yoW8AFykpr
 WfG3ySyFWDJ3s7Xa1UAF4UZrWkGFWrWrW5Ka17C3409F4rX3y8ZF92k3WYgFW5XFWSyrWU
 uF4UuF98Ar4kZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
 6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUU
 U==
X-Originating-IP: [183.156.89.125]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkEA2oBeZvZwgAAsb
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

According to the RISC-V Privileged Manual: "The Sv32 page-based
virtual-memory scheme described in sv32 supports 34-bit physical
addresses for RV32, so the PMP scheme must support addresses wider than
XLEN for RV32."

However, the current QEMU implementation uses `target_ulong` (which
resolves to `uint32_t` on RV32) for PMP address variables.  When
shifting these addresses left (e.g., `this_addr << 2`), an integer
overflow occurs, truncating the high bits of the 34-bit physical
address.

Fix this issue by changing the types of PMP address variables
(`this_addr` and `prev_addr`) to `hwaddr`.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2472/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
Changes in v2:
- Changed the types of `this_addr` and `prev_addr` to `hwaddr` instead
  of using inline casting, by Daniel's suggestion.

 target/riscv/pmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5391caa59c7d..a71091a316e0 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -227,8 +227,8 @@ static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
 {
     uint8_t this_cfg = env->pmp_state.pmp[pmp_index].cfg_reg;
-    target_ulong this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
-    target_ulong prev_addr = 0u;
+    hwaddr this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
+    hwaddr prev_addr = 0u;
     hwaddr sa = 0u;
     hwaddr ea = 0u;
     int g = pmp_get_granularity_g(env);
-- 
2.51.2


