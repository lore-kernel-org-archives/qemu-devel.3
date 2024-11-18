Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEEDD49222
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1uu-0006lc-0u; Mon, 18 Nov 2024 08:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoguangyao18@mails.ucas.ac.cn>)
 id 1tD1uo-0006l6-2e
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:35:42 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <guoguangyao18@mails.ucas.ac.cn>)
 id 1tD1ug-0004Jc-K2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:35:40 -0500
Received: from localhost.localdomain (unknown [159.226.43.4])
 by APP-01 (Coremail) with SMTP id qwCowADHzHx1QjtndjLSAw--.81S2;
 Mon, 18 Nov 2024 21:35:14 +0800 (CST)
From: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	guoguangyao <guoguangyao18@mails.ucas.ac.cn>
Subject: [PATCH] target/loongarch: fix alignment error in tci.
Date: Mon, 18 Nov 2024 21:32:43 +0800
Message-Id: <20241118133243.291769-1-guoguangyao18@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHzHx1QjtndjLSAw--.81S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr13JF4kZFy5AFy5Gw4UJwb_yoWfuFb_Wa
 47Gr1Dur48uF1Ivw47t34rJw15GF48GF1YkFWkXws5Kr98XrZxZwsrtwnxAw1j9F4xZr43
 AFsFvr9xCryayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4UJVWxJr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb7DG7UUUU
 U==
X-Originating-IP: [159.226.43.4]
X-CM-SenderInfo: 5jxrw35dqj5trrryqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=guoguangyao18@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add alignment and check for fpr in
CPUArchState, fix alignment error in
tcg interpreter when executing LASX.

Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 86c86c6c95..f955f9f618 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -302,7 +302,7 @@ typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
 
-    fpr_t fpr[32];
+    fpr_t fpr[32] QEMU_ALIGNED(16);
     bool cf[8];
     uint32_t fcsr0;
     lbt_t  lbt;
@@ -487,6 +487,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
+QEMU_BUILD_BUG_ON((offsetof(CPULoongArchState, fpr[0]) & (15)) != 0);
 void loongarch_cpu_post_init(Object *obj);
 
 #endif /* LOONGARCH_CPU_H */
-- 
2.34.1


