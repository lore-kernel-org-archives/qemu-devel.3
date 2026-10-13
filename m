Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800CCCA9EDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGTAm-000284-MD; Mon, 12 Oct 2026 23:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xGTAh-00027R-Sr
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:27:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xGTAe-0004mZ-CW
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:27:22 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxrtITpc1qWjYVAA--.61979S3;
 Tue, 13 Oct 2026 11:27:15 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAx3c4Spc1qcK0rAA--.26881S3;
 Tue, 13 Oct 2026 11:27:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 SignKirigami <prcups@krgm.moe>
Subject: [PATCH 1/3] target/loongarch: Replace address_space_ldq_le() ->
 cpu_ldq_le_data_ra()
Date: Tue, 13 Oct 2026 11:28:39 +0800
Message-ID: <20261013032841.2482079-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013032841.2482079-1-maobibo@loongson.cn>
References: <20261013032841.2482079-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c4Spc1qcK0rAA--.26881S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFyrZryxtFWxXFW5ZFWkAFc_yoW5Jr1UpF
 WfCw4xtFWftrZ5X3Z7Ga4Y9r1UJ34DG3y7XF4SkryFk3s8Jr1xZrW8t3yqgF48Ja95uw4j
 vrnrZa4UZFWxXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjpB-U
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With LDDIR/LDPTE instruction, it accesses page table entry with physical
address, so it can only be used in DA mode. Replace API
address_space_ldq_le() with cpu_ldq_le_data_ra(), since there is QEMU
CPU TLB with the latter. And in future if LVZ is supported, the latter API
will call the second MMU page table walk.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 40cc076424..b6381f7cd3 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -21,7 +21,6 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
-#include "system/memory.h"
 
 typedef bool (*tlb_match)(bool global, int asid, int tlb_asid);
 
@@ -721,7 +720,6 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
-    CPUState *cs = env_cpu(env);
     uint64_t badvaddr;
     hwaddr index, phys;
     uint64_t palen_mask = loongarch_palen_mask(env);
@@ -754,7 +752,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
+    val = cpu_ldq_le_data_ra(env, phys, GETPC());
 
     return val & palen_mask;
 }
@@ -762,7 +760,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
                   uint32_t mem_idx)
 {
-    CPUState *cs = env_cpu(env);
     hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
     CPUSysState *sys = env_sys(env);
     uint64_t pte_raw;
@@ -823,8 +820,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        pte_raw = address_space_ldq_le(cs->as, phys,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
+        pte_raw = cpu_ldq_le_data_ra(env, phys, GETPC());
         tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
         ps = ptbase;
     }
-- 
2.54.0


