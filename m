Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34FDCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNIL-0001Vx-UM; Mon, 11 May 2026 05:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMNI4-0000WX-4Y; Mon, 11 May 2026 05:51:15 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMNHv-0004F2-Br; Mon, 11 May 2026 05:51:06 -0400
Received: from yzs (unknown [183.156.89.125])
 by APP-05 (Coremail) with SMTP id zQCowABH2AutgQFqFdDxDw--.23564S2;
 Mon, 11 May 2026 15:13:49 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH] target/riscv/pmp: Fix integer overflow in TOR and NA4 address
 computation
Date: Mon, 11 May 2026 15:13:47 +0800
Message-ID: <20260511071347.3000476-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABH2AutgQFqFdDxDw--.23564S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45GF43Wr43JryxGr1DAwb_yoW8WF43pF
 WfGw4ftFZxt3y0qa1DCF18XF1kKrWrCr15tFsI9w1rur45XrWfZryav3WYya15XFZ5tr4I
 9F18uF98AF4rur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
 UU=
X-Originating-IP: [183.156.89.125]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsEA2oBMV6P8gADsw
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

Fix this issue by casting the `target_ulong` variables to `hwaddr`
before performing the left shift operation.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2472/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
 target/riscv/pmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5391caa59c7d..dfddafcbcb48 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -253,12 +253,12 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
             sa = ea = 0u;
             break;
         }
-        sa = prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
-        ea = (this_addr << 2) - 1u;
+        sa = (hwaddr)prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
+        ea = ((hwaddr)this_addr << 2) - 1u;
         break;
 
     case PMP_AMATCH_NA4:
-        sa = this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
+        sa = (hwaddr)this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
         ea = (sa + 4u) - 1u;
         break;
 
-- 
2.51.2


