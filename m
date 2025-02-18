Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDA1C021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 03:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkEAR-0002Yp-L5; Mon, 17 Feb 2025 22:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tkEAE-0002Vi-ID; Mon, 17 Feb 2025 22:20:51 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1tkEAB-0003Sf-Tr; Mon, 17 Feb 2025 22:20:50 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxIK+E_LNnll55AA--.10844S3;
 Tue, 18 Feb 2025 11:20:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxj8WE_LNnOnkZAA--.31938S2;
 Tue, 18 Feb 2025 11:20:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, Wanglei <wanglei@loongson.cn>,
 qemu-stable@nongnu.org
Subject: [PATCH] target/loongarch/gdbstub: Fix gdbstub incorrectly handling
 register R32
Date: Tue, 18 Feb 2025 11:20:27 +0800
Message-Id: <20250218032027.4137453-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8WE_LNnOnkZAA--.31938S2
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Write operation with R32 (orig_a0) and R32 (CSR_BADV) is discarded on
gdbstub implementation for LoongArch system. And return value should
be register size rather than 0, since it is used to calculate offset of
next register such as R33 (PC) in function handle_write_all_regs().

Cc: qemu-stable@nongnu.org
Fixes: ca61e75071c6 ("target/loongarch: Add gdb support.")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/gdbstub.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index dafa4feb75..471eda28c7 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -63,23 +63,24 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPULoongArchState *env = cpu_env(cs);
     target_ulong tmp;
-    int read_length;
     int length = 0;
 
+    if (n < 0 || n > 34) {
+        return 0;
+    }
+
     if (is_la64(env)) {
         tmp = ldq_le_p(mem_buf);
-        read_length = 8;
+        length = 8;
     } else {
         tmp = ldl_le_p(mem_buf);
-        read_length = 4;
+        length = 4;
     }
 
     if (0 <= n && n < 32) {
         env->gpr[n] = tmp;
-        length = read_length;
     } else if (n == 33) {
         set_pc(env, tmp);
-        length = read_length;
     }
     return length;
 }

base-commit: db7aa99ef894e88fc5eedf02ca2579b8c344b2ec
-- 
2.39.3


