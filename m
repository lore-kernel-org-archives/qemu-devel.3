Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8B8CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLPKZ-0005Uh-6q; Fri, 08 May 2026 13:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wLPKT-0005UJ-F0; Fri, 08 May 2026 13:49:37 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wLPKN-0003vw-63; Fri, 08 May 2026 13:49:33 -0400
Received: from yzs (unknown [115.199.218.204])
 by APP-03 (Coremail) with SMTP id rQCowAD3AsogIv5pxiJsEA--.1356S2;
 Sat, 09 May 2026 01:49:21 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH v2] target/riscv: Fix missing CDE check for scountinhibit
Date: Sat,  9 May 2026 01:49:17 +0800
Message-ID: <20260508174917.371667-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3AsogIv5pxiJsEA--.1356S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy5Cw4rWFW8Kr17JryDGFg_yoW8GFyrpF
 s7W3yfGay0gF9Fyan7JF4DWF15Ww4UK3y5Jwn2yw10qrs8J3yYy3s8KF4UtFy8Wrs5Gr42
 9rn0kr9xuF4UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
 U==
X-Originating-IP: [115.199.218.204]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgBA2n9+91F9wAAsG
Received-SPF: pass client-ip=159.226.251.81; envelope-from=vulab@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
v2: Removed mistakenly added #include "cpu_bits.h".

 target/riscv/csr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da366cf56271..9ae8d553dcf1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -398,6 +398,10 @@ static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
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


