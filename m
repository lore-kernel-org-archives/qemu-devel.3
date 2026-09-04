Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2782C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50Kr-0004GB-Cr; Fri, 11 Sep 2026 08:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Ko-000463-16; Fri, 11 Sep 2026 08:26:26 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Kj-0006CW-8Q; Fri, 11 Sep 2026 08:26:25 -0400
Received: from [172.21.96.1] (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowABHtD5k86NqyHDqBw--.17498S7;
 Fri, 11 Sep 2026 20:26:13 +0800 (CST)
Message-ID: <52562c735098160d9e3944994f6f635d9f69c9f8.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <cover.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
References: <cover.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
Date: Fri, 4 Sep 2026 21:49:14 +0800
Subject: [PATCH v4 5/5] target/riscv: canonicalize reserved CBIE encoding
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org
X-CM-TRANSID: zQCowABHtD5k86NqyHDqBw--.17498S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3Wr48uF1kXr15urW7Jwb_yoW8tF48pF
 4UWF45KrWq9ryI9a93Jr1UWF13Kr4rGay5Wwnruw4kXa13CFyftFnrK345Kr4UXFWxK3sF
 9wsxGry5Cws5JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQlb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vE77IFxV
 WkZVCq3wA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj
 6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI
 0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAF
 wI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64
 vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xr1l42xK82IY
 c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
 026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
 0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42
 IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
 aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0Yii7UUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
write/readback test cases.
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


