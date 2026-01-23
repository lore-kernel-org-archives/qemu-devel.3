Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205FD72350
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 09:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjDGJ-00011F-Sx; Fri, 23 Jan 2026 04:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3160104094@zju.edu.cn>)
 id 1vjDGG-00010k-4o
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 04:15:24 -0500
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <3160104094@zju.edu.cn>) id 1vjDGD-0001pq-Iz
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 04:15:23 -0500
Received: from zju.edu.cn (unknown [183.129.171.42])
 by mtasvr (Coremail) with SMTP id _____wC3H3ggPHNprEkyAA--.4356S3;
 Fri, 23 Jan 2026 17:15:13 +0800 (CST)
Received: from localhost.localdomain (unknown [183.129.171.42])
 by mail-app2 (Coremail) with SMTP id zC_KCgCXHUEbPHNpM99tBQ--.56764S2;
 Fri, 23 Jan 2026 17:15:08 +0800 (CST)
From: Panda Jiang <3160104094@zju.edu.cn>
To: richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 Panda Jiang <3160104094@zju.edu.cn>
Subject: [PATCH] accel/tcg: Fix uninitialized host_pc in tb_gen_code
Date: Fri, 23 Jan 2026 17:15:05 +0800
Message-Id: <20260123091505.20025-1-3160104094@zju.edu.cn>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zC_KCgCXHUEbPHNpM99tBQ--.56764S2
X-CM-SenderInfo: qtrwiiiquqmko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?zW3T5AXKKxbFmtjJiESix3B1w3sL8hBMFUTpd3cX36+dE6DPAN7iCt/gLhxLJ5hnLg
 KjdeYxgGwm4o3MkAMAFMbdSWh7vJ32BDtZ8/g8HPsaqE2nLoKm1lxJckB+ZVOUTV5EVzmy
 4upGrmqqL5Xwe9pw4h+Ozd4IW7/Oam7APkTTWnhX
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4fWF47tF15AFyDZr47GFX_yoW8GF4DpF
 ZIkr1kKry3Xw1Iyw1xJr48ur18ua17ZF17KwsIk3ZIvwsFvr1vya95KFWj9a1I9FW0v3WU
 ta1jv3y5WryUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
 JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU
Received-SPF: pass client-ip=162.243.161.220;
 envelope-from=3160104094@zju.edu.cn;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In tb_gen_code(), the local variable 'host_pc' was declared without
an initial value.

If get_page_addr_code_hostp() fails to find a host mapping for the
guest PC (e.g., when translating from an I/O region), it returns -1
but may not update the value of 'host_pc'. The function then proceeds
with an uninitialized 'host_pc' variable.

This leads to undefined behavior when this uninitialized pointer is
later passed to setjmp_gen_code(). This was observed as a segmentation
fault (coredump) when running QEMU with the '-d in_asm' logging
option, which enables the code path that uses this variable.

Fix this by initializing 'host_pc' to NULL upon declaration. This
ensures it has a well-defined value in all code paths, preventing
the crash.

Signed-off-by: Panda Jiang <3160104094@zju.edu.cn>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fba4e9dc21..140f100cca 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -266,7 +266,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
     int64_t ti;
-    void *host_pc;
+    void *host_pc = NULL;
 
     assert_memory_lock();
     qemu_thread_jit_write();
-- 
2.39.2 (Apple Git-143)


