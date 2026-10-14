Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AEDC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH1ra-00007t-3h; Wed, 14 Oct 2026 12:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH1rJ-00005X-Da; Wed, 14 Oct 2026 12:29:41 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH1rG-00068x-AJ; Wed, 14 Oct 2026 12:29:40 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACXmDbrrc9q4kXBCg--.37629S9;
 Thu, 15 Oct 2026 00:29:34 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 christoph.muellner@vrull.eu
Subject: [PATCH v5 5/5] target/riscv: canonicalize reserved CBIE encoding
Date: Thu, 15 Oct 2026 00:29:30 +0800
Message-ID: <20261014162930.251-6-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261014162930.251-1-wangyang25@otcaix.iscas.ac.cn>
References: <20261014162930.251-1-wangyang25@otcaix.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXmDbrrc9q4kXBCg--.37629S9
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3Wr48uF1kXr15urW7Jwb_yoW8Kr4fpF
 4UWF45KrWv9ryI9a93Jr1UWF13Krs5Gay5Wwnruws7Xa13CFyftFnrK345Kr4UXFWxK3sF
 9wsxGryrCw4kJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20x
 vEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj
 6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7
 CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
 6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
 C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
 Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
 0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
 cSsGvfC2KfnxnUUI43ZEXa7IUYnAwDUUUUU==
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
write/readback test cases.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4416
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


