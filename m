Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B4BC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5IB-0005e6-Sq; Tue, 07 Jul 2026 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wh5Hx-0005WV-31
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wh5Hs-0002O4-G3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxVeqL9kxqDe4AAA--.2546S3;
 Tue, 07 Jul 2026 20:52:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxX8eF9kxqpekDAA--.23644S6;
 Tue, 07 Jul 2026 20:52:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, Tao Cui <cuitao@kylinos.cn>
Subject: [PULL 4/8] target/loongarch/kvm: fix cpucfg sync error handling
Date: Tue,  7 Jul 2026 20:32:22 +0800
Message-Id: <20260707123226.25918-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260707123226.25918-1-gaosong@loongson.cn>
References: <20260707123226.25918-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX8eF9kxqpekDAA--.23644S6
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

From: Tao Cui <cuitao@kylinos.cn>

In kvm_loongarch_get_cpucfg() and kvm_loongarch_put_cpucfg(), ret is
overwritten on each iteration, so only the last register's result is
returned and earlier failures are lost. On a failed read, env->cpucfg[i]
is stored from a stale or uninitialized val.

Accumulate errors with ret |=, matching kvm_loongarch_get_csr()/put_csr(),
and only update env->cpucfg[i] on a successful read. Keep the cpucfg2
negotiation check in put_cpucfg() on a separate variable so its early
return does not overwrite the accumulated result.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20260626052742.810726-5-cui.tao@linux.dev>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 162e7010ac..4d0cad5732 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -713,8 +713,11 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
     CPULoongArchState *env = cpu_env(cs);
 
     for (i = 0; i < 21; i++) {
-        ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
-        env->cpucfg[i] = (uint32_t)val;
+        int r = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
+        ret |= r;
+        if (!r) {
+            env->cpucfg[i] = (uint32_t)val;
+        }
     }
     return ret;
 }
@@ -767,13 +770,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
 
     for (i = 0; i < 21; i++) {
 	if (i == 2) {
-            ret = kvm_check_cpucfg2(cs);
-            if (ret) {
-                return ret;
+            int r = kvm_check_cpucfg2(cs);
+            if (r) {
+                return r;
             }
 	}
         val = env->cpucfg[i];
-        ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
     }
     return ret;
 }
-- 
2.55.0


