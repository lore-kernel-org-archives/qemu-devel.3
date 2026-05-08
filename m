Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C425CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN3D-0000Gq-Pa; Fri, 08 May 2026 11:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wLLwF-0002An-VY; Fri, 08 May 2026 10:12:24 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wLLwC-0000rv-Vp; Fri, 08 May 2026 10:12:23 -0400
Received: from yzs (unknown [115.199.218.204])
 by APP-03 (Coremail) with SMTP id rQCowAA3WN827_1p1M9oEA--.7657S2;
 Fri, 08 May 2026 22:12:08 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH] target/riscv: Fix missing CDE check for scountinhibit
Date: Fri,  8 May 2026 22:12:04 +0800
Message-ID: <20260508141204.247038-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAA3WN827_1p1M9oEA--.7657S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy5Cw4rWFW8Kr17JryDGFg_yoW8XFW5pF
 s7u3y3KaykWa4jk3Z7tF4DWF15Xw4Fg3y5Jwn2yw10qrs8K3yYy3s5KFWUtFy8WF4DGr42
 9rn8Cr9xuF4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
 6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-Originating-IP: [115.199.218.204]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwBA2n9t-WZjQAAsL
Received-SPF: pass client-ip=159.226.251.81; envelope-from=vulab@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 May 2026 11:23:21 -0400
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

According to the RISC-V smcdeleg specification: "When menvcfg.CDE=0,
attempts to access scountinhibit raise an illegal-instruction
exception."

The current implementation of scountinhibit_pred() only checks the
hardware extensions (ext_ssccfg, ext_smcdeleg) and virtualization
status, but completely misses the runtime environment configuration
check (menvcfg.CDE).  This allows S-mode to access scountinhibit even
when the M-mode has explicitly disabled counter delegation.

This issue was discovered by the SpecHunter tool
(https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2571/qemu.txt).

Fixes: 6247dc2ef70b ("target/riscv: Add counter delegation/configuration support")
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da366cf56271..8e494f545d76 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -17,6 +17,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "cpu_bits.h"
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
@@ -398,6 +399,10 @@ static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    if (!get_field(env->menvcfg, MENVCFG_CDE)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     if (env->virt_enabled) {
         return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
     }
-- 
2.51.2


