Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B17C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 05:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO9mj-0001CL-3H; Mon, 01 Jul 2024 01:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lijiayi@eswincomputing.com>)
 id 1sO6kA-0006ar-Qf
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:26:14 -0400
Received: from azure-sdnproxy.icoremail.net ([20.231.56.155])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lijiayi@eswincomputing.com>) id 1sO6k8-00032h-TR
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:26:14 -0400
Received: from E0005096DT.eswin.cn (unknown [10.64.112.173])
 by app1 (Coremail) with SMTP id TAJkCgDHWuK3E4JmOcQSAA--.23755S4;
 Mon, 01 Jul 2024 10:26:02 +0800 (CST)
From: Jiayi Li <lijiayi@eswincomputing.com>
To: qemu-devel@nongnu.org, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 luweu1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: lijiayi@eswincomputing.com
Subject: [PATCH] target/riscv: Validate the mode in write_vstvec
Date: Mon,  1 Jul 2024 10:25:53 +0800
Message-Id: <20240701022553.1982-1-lijiayi@eswincomputing.com>
X-Mailer: git-send-email 2.39.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: TAJkCgDHWuK3E4JmOcQSAA--.23755S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur48tr1kZr1kAF47tF1DJrb_yoWfWFX_Gr
 1SgFyF93yDW3ZavFWjywn0yFyFkry0grn3ta13Cr98KrWqg3s8Ja1qvF9xXryrurW7Jwn3
 u3srXa17GF4a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb28FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5olmxt11l6v25zlqu0xpsx3x1qjou0bp/
Received-SPF: pass client-ip=20.231.56.155;
 envelope-from=lijiayi@eswincomputing.com; helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Jul 2024 01:41:02 -0400
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

Base on the riscv-privileged spec, vstvec substitutes for the usual stvec.
Therefore, the encoding of the MODE should also be restricted to 0 and 1.

Signed-off-by: Jiayi Li <lijiayi@eswincomputing.com>
---
 target/riscv/csr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 432c59dc66..f9229d92ab 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3791,7 +3791,12 @@ static RISCVException read_vstvec(CPURISCVState *env, int csrno,
 static RISCVException write_vstvec(CPURISCVState *env, int csrno,
                                    target_ulong val)
 {
-    env->vstvec = val;
+    /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
+    if ((val & 3) < 2) {
+        env->vstvec = val;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "CSR_VSTVEC: reserved mode not supported\n");
+    }
     return RISCV_EXCP_NONE;
 }
 
-- 
2.25.1


