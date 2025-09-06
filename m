Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922ECCA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 07:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumzA-0001gA-2X; Sat, 06 Sep 2025 03:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uumz1-0001Ti-Hb
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:05:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uumyi-0003Lj-3j
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:05:09 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxSNEN3btoolgHAA--.15762S3;
 Sat, 06 Sep 2025 15:04:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8MJ3btoC6OBAA--.17248S4;
 Sat, 06 Sep 2025 15:04:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 02/13] target/loongarch: Add parameter tlb pointer with
 fill_tlb_entry
Date: Sat,  6 Sep 2025 15:04:30 +0800
Message-Id: <20250906070441.3749413-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250906070441.3749413-1-maobibo@loongson.cn>
References: <20250906070441.3749413-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8MJ3btoC6OBAA--.17248S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

With function fill_tlb_entry(), it will update LoongArch emulated
TLB information. Here parameter tlb pointer is added so that TLB
entry will be updated based on relative TLB CSR registers.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/tlb_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 0c31a346fe..25dbbd0d77 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -143,9 +143,8 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
     invalidate_tlb_entry(env, index);
 }
 
-static void fill_tlb_entry(CPULoongArchState *env, int index)
+static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
 {
-    LoongArchTLB *tlb = &env->tlb[index];
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
     uint8_t csr_ps;
@@ -312,7 +311,7 @@ void helper_tlbwr(CPULoongArchState *env)
         return;
     }
 
-    fill_tlb_entry(env, index);
+    fill_tlb_entry(env, env->tlb + index);
 }
 
 void helper_tlbfill(CPULoongArchState *env)
@@ -350,7 +349,7 @@ void helper_tlbfill(CPULoongArchState *env)
     }
 
     invalidate_tlb(env, index);
-    fill_tlb_entry(env, index);
+    fill_tlb_entry(env, env->tlb + index);
 }
 
 void helper_tlbclr(CPULoongArchState *env)
-- 
2.39.3


