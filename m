Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD01C624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2mqe-0004pK-3B; Sat, 05 Sep 2026 05:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqc-0004n0-Ky; Sat, 05 Sep 2026 05:38:06 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqY-0002d8-Ni; Sat, 05 Sep 2026 05:38:06 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowABHUT_u4ptqIsvvBg--.16071S7;
 Sat, 05 Sep 2026 17:37:53 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 5/5] target/riscv: canonicalize reserved CBIE encoding
Date: Sat,  5 Sep 2026 17:37:49 +0800
Message-ID: <20260905093749.491-6-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
References: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUT_u4ptqIsvvBg--.16071S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3Wr48uF1kXr15urW7Jwb_yoW8tF48pF
 4UWF45KrWv934I9a93Jr1UWF1akrWrGay5Wwnruw4kXa13GFyftFnrG345Kr4UWFWxK3sF
 9wsxGry5Cws5JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
 IFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I
 3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
 WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
 wI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20x
 vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
 JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjGYLPUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
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

CBIE encoding 10 is reserved when Zicbom is implemented, while
encoding 11 has defined behavior. Canonicalize only encoding 10 in the
menvcfg, senvcfg, and henvcfg write paths so the reserved value is not
retained and the defined encoding remains unchanged.

Tested: RV64 menvcfg, senvcfg, and henvcfg CBIE 10 and CBIE 11
write/readback witnesses.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4416

Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
 target/riscv/tcg/csr.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114..cf59f9ae54 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3260,6 +3260,16 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
             stce_changed = true;
         }
     }
+
+    /*
+     * CBIE is a WARL field: encoding 10 is reserved.  A software write of
+     * this encoding must canonicalize to a supported value instead of being
+     * retained in the readback.
+     */
+    if (cfg->ext_zicbom && get_field(val, MENVCFG_CBIE) == 2) {
+        val &= ~MENVCFG_CBIE;
+    }
+
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
     if (stce_changed) {
@@ -3354,6 +3364,16 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         mask |= SENVCFG_UKTE;
     }
 
+    /*
+     * CBIE is a WARL field: encoding 10 is reserved.  A software write of
+     * this encoding must canonicalize to a supported value instead of being
+     * retained in the readback.
+     */
+    if (env_archcpu(env)->cfg.ext_zicbom &&
+        get_field(val, SENVCFG_CBIE) == 2) {
+        val &= ~SENVCFG_CBIE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -3422,6 +3442,15 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         }
     }
 
+    /*
+     * CBIE is a WARL field: encoding 10 is reserved.  A software write of
+     * this encoding must canonicalize to a supported value instead of being
+     * retained in the readback.
+     */
+    if (cfg->ext_zicbom && get_field(val, HENVCFG_CBIE) == 2) {
+        val &= ~HENVCFG_CBIE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         /*
          * RV32 stores STCE/ADUE/PBMTE/DTE in henvcfgh, so a low-half henvcfg
-- 
2.55.0.windows.2


