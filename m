Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4BBC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4yo0-0003r2-Rx; Thu, 09 May 2024 04:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s4yns-0003pT-I1
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:07:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s4yno-0006CX-0c
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:07:00 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxN+kYhDxmvOQJAA--.13793S3;
 Thu, 09 May 2024 16:06:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxhFYVhDxmfOYWAA--.27243S5; 
 Thu, 09 May 2024 16:06:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 3/3] target/loongarch: Put cpucfg operation before CSR register
Date: Thu,  9 May 2024 16:06:45 +0800
Message-Id: <20240509080645.457303-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240509080645.457303-1-gaosong@loongson.cn>
References: <20240509080645.457303-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxhFYVhDxmfOYWAA--.27243S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

On Loongarch, cpucfg is register for cpu feature, some other registers
depend on cpucfg feature such as perf CSR registers. Here put cpucfg
read/write operations before CSR register, so that KVM knows how many
perf CSR registers are valid from pre-set cpucfg feature information.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240428031651.1354587-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8224d94333..bc75552d0f 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -587,22 +587,22 @@ int kvm_arch_get_registers(CPUState *cs)
         return ret;
     }
 
-    ret = kvm_loongarch_get_csr(cs);
+    ret = kvm_loongarch_get_cpucfg(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_get_regs_fp(cs);
+    ret = kvm_loongarch_get_csr(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_get_mpstate(cs);
+    ret = kvm_loongarch_get_regs_fp(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_get_cpucfg(cs);
+    ret = kvm_loongarch_get_mpstate(cs);
     return ret;
 }
 
@@ -615,22 +615,22 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_loongarch_put_csr(cs, level);
+    ret = kvm_loongarch_put_cpucfg(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_put_regs_fp(cs);
+    ret = kvm_loongarch_put_csr(cs, level);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_put_mpstate(cs);
+    ret = kvm_loongarch_put_regs_fp(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_put_cpucfg(cs);
+    ret = kvm_loongarch_put_mpstate(cs);
     return ret;
 }
 
-- 
2.25.1


